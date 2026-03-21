"""
DODEKA SPORT – KAVVV Scraper
Scrapes uitslagen.vriendenclubsantwerpen.be for Dodeka's results
and klassement.vriendenclubsantwerpen.be for standings, then
upserts the data into Supabase.

Run locally: python scripts/sync_kavvv.py
  (requires .env with SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY)
"""

import os
import re
import sys
from datetime import date

import requests
from bs4 import BeautifulSoup
from supabase import create_client, Client

# ── Configuration ─────────────────────────────────────────────
SUPABASE_URL  = os.environ.get('SUPABASE_URL', '')
SUPABASE_KEY  = os.environ.get('SUPABASE_SERVICE_ROLE_KEY', '')
TEAM_NAME     = 'dodeka'          # lowercase – used for matching
AFDELING      = 'tweede afdeling b'  # lowercase – used for filtering

RESULTS_URL   = 'https://uitslagen.vriendenclubsantwerpen.be/'
STANDINGS_URL = 'https://klassement.vriendenclubsantwerpen.be/'

HEADERS = {'User-Agent': 'Mozilla/5.0 (compatible; DodekaScraper/1.0)'}


# ── Supabase client ───────────────────────────────────────────
def get_client() -> Client:
    if not SUPABASE_URL or not SUPABASE_KEY:
        print("ERROR: SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY must be set.")
        sys.exit(1)
    return create_client(SUPABASE_URL, SUPABASE_KEY)


# ── Helpers ───────────────────────────────────────────────────
def get_current_season(sb: Client) -> dict | None:
    res = sb.table('seasons').select('*').eq('is_current', True).maybe_single().execute()
    return res.data


def parse_score(score_str: str) -> tuple[int | None, int | None]:
    """Parse '3-1' into (3, 1). Returns (None, None) if not valid."""
    m = re.match(r'^(\d+)\s*[-–]\s*(\d+)$', score_str.strip())
    if m:
        return int(m.group(1)), int(m.group(2))
    return None, None


# ── Scrape standings ──────────────────────────────────────────
def scrape_standings(sb: Client, season: dict):
    print(f"Fetching standings from {STANDINGS_URL}…")
    try:
        r = requests.get(STANDINGS_URL, headers=HEADERS, timeout=15)
        r.raise_for_status()
    except Exception as e:
        print(f"  Could not fetch standings: {e}")
        return

    soup = BeautifulSoup(r.text, 'html.parser')

    # Find the table that contains our division
    # The site may have multiple tables (one per division).
    # We look for a heading or caption that mentions our division.
    rows_saved = 0
    for section in soup.find_all(['h2', 'h3', 'h4', 'caption', 'strong']):
        if AFDELING in section.get_text(strip=True).lower():
            # The standings table should be the next sibling table
            table = section.find_next('table')
            if not table:
                continue
            rows = table.find_all('tr')
            records = []
            for i, row in enumerate(rows[1:], start=1):  # skip header
                cells = [c.get_text(strip=True) for c in row.find_all(['td', 'th'])]
                if len(cells) < 5:
                    continue
                # Expected columns: positie, team, gespeeld, gew, gel, verl, +, -, punten
                # Actual column order may vary – adapt as needed
                try:
                    positie  = int(cells[0]) if cells[0].isdigit() else i
                    team     = cells[1]
                    gespeeld = int(cells[2]) if cells[2].isdigit() else 0
                    punten   = int(cells[-1]) if cells[-1].isdigit() else 0
                    gewonnen = int(cells[3]) if len(cells) > 3 and cells[3].isdigit() else 0
                    gelijk   = int(cells[4]) if len(cells) > 4 and cells[4].isdigit() else 0
                    verloren = int(cells[5]) if len(cells) > 5 and cells[5].isdigit() else 0
                    records.append({
                        'season_id':         season['id'],
                        'positie':           positie,
                        'team_naam':         team,
                        'gespeeld':          gespeeld,
                        'gewonnen':          gewonnen,
                        'gelijk':            gelijk,
                        'verloren':          verloren,
                        'punten':            punten,
                        'updated_at':        date.today().isoformat(),
                    })
                except (ValueError, IndexError):
                    continue

            if records:
                sb.table('standings').upsert(
                    records,
                    on_conflict='season_id,team_naam'
                ).execute()
                rows_saved += len(records)
            break  # Found and processed our division

    print(f"  Standings saved: {rows_saved} teams.")


# ── Scrape match results ──────────────────────────────────────
def scrape_results(sb: Client, season: dict):
    print(f"Fetching results from {RESULTS_URL}…")
    try:
        r = requests.get(RESULTS_URL, headers=HEADERS, timeout=15)
        r.raise_for_status()
    except Exception as e:
        print(f"  Could not fetch results: {e}")
        return

    soup = BeautifulSoup(r.text, 'html.parser')
    saved = 0

    # Look for Dodeka matches: find table rows that contain our team name
    for row in soup.find_all('tr'):
        cells = [c.get_text(strip=True) for c in row.find_all(['td', 'th'])]
        text  = ' '.join(cells).lower()

        if TEAM_NAME not in text:
            continue

        # A match row typically has: datum, thuis_team, score, uit_team
        # Try to extract these (adapt column indices if the site layout changes)
        if len(cells) < 4:
            continue

        try:
            # Find which cell has the score (contains a dash between digits)
            score_idx = next(
                (i for i, c in enumerate(cells) if re.match(r'^\d+\s*[-–]\s*\d+$', c)),
                None
            )
            if score_idx is None:
                continue

            thuis_team = cells[score_idx - 1].strip()
            uit_team   = cells[score_idx + 1].strip() if score_idx + 1 < len(cells) else ''
            score_raw  = cells[score_idx]

            is_dodeka_thuis = TEAM_NAME in thuis_team.lower()
            tegenstander    = uit_team if is_dodeka_thuis else thuis_team

            score_raw_split = re.split(r'[-–]', score_raw)
            if is_dodeka_thuis:
                score_dodeka, score_teg = int(score_raw_split[0]), int(score_raw_split[1])
            else:
                score_teg, score_dodeka = int(score_raw_split[0]), int(score_raw_split[1])

            # Try to find a date in earlier cells
            datum_str = None
            for c in cells[:score_idx]:
                m = re.search(r'(\d{1,2})[/\-.](\d{1,2})[/\-.](\d{2,4})', c)
                if m:
                    day, month, year = int(m.group(1)), int(m.group(2)), int(m.group(3))
                    if year < 100:
                        year += 2000
                    datum_str = f'{year:04d}-{month:02d}-{day:02d}'
                    break

            if not datum_str:
                continue

            # Upsert the match (avoid duplicates by datum + tegenstander)
            existing = sb.table('matches')\
                .select('id')\
                .eq('season_id', season['id'])\
                .eq('datum', datum_str)\
                .eq('tegenstander', tegenstander)\
                .maybe_single().execute()

            payload = {
                'season_id':          season['id'],
                'datum':              datum_str,
                'tegenstander':       tegenstander,
                'score_dodeka':       score_dodeka,
                'score_tegenstander': score_teg,
                'is_thuis':           is_dodeka_thuis,
                'source':             'kavvv',
            }

            if existing.data:
                sb.table('matches').update(payload)\
                  .eq('id', existing.data['id']).execute()
            else:
                sb.table('matches').insert(payload).execute()

            saved += 1

        except (ValueError, IndexError, StopIteration):
            continue

    print(f"  Match results saved/updated: {saved}.")


# ── Main ──────────────────────────────────────────────────────
if __name__ == '__main__':
    # Allow loading .env file locally (pip install python-dotenv)
    try:
        from dotenv import load_dotenv
        load_dotenv()
        SUPABASE_URL = os.environ.get('SUPABASE_URL', SUPABASE_URL)
        SUPABASE_KEY = os.environ.get('SUPABASE_SERVICE_ROLE_KEY', SUPABASE_KEY)
    except ImportError:
        pass

    sb     = get_client()
    season = get_current_season(sb)

    if not season:
        print("ERROR: No current season found in Supabase. Create one first.")
        sys.exit(1)

    print(f"Syncing season: {season['naam']}")
    scrape_standings(sb, season)
    scrape_results(sb, season)
    print("Done!")
