"""
DODEKA SPORT – Database Seeder
Imports all historical statistics from the Excel file into Supabase.

Usage:
  1. pip install pandas openpyxl supabase python-dotenv
  2. Copy your .env file with SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY
  3. Update EXCEL_PATH below to point to your Excel file
  4. Run: python scripts/seed_database.py

This script is safe to run multiple times (it checks for existing data).
"""

import os
import re
import sys
import pandas as pd
from datetime import datetime

EXCEL_PATH = 'DODEKA SPORT seizoen 2025-2026 en oude statistieken.xlsx'

# Map Excel sheet names to season names
SEASON_SHEETS = {
    '2017-2018': '2017-2018',
    '2018-2019': '2018-2019',
    '2019-2020': '2019-2020',
    '2020-2021': '2020-2021',
    '2021-2022': '2021-2022',
    '2022-2023': '2022-2023',
    '2023-2024': '2023-2024',
    '2024-2025': '2024-2025',
    '2025-2026': '2025-2026',
}

CURRENT_SEASON = '2025-2026'

# Map old Excel codes to new status values
AANW_MAP = {
    'h': 'aanwezig',
    'w': 'afwezig',
    't': 'verontschuldigd',
}


# ── Setup ─────────────────────────────────────────────────────
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

from supabase import create_client, Client

SUPABASE_URL = os.environ['SUPABASE_URL']
SUPABASE_KEY = os.environ['SUPABASE_SERVICE_ROLE_KEY']
sb: Client   = create_client(SUPABASE_URL, SUPABASE_KEY)


# ── Player cache ──────────────────────────────────────────────
_player_cache: dict[str, str] = {}  # naam -> id

def get_or_create_player(naam: str) -> str:
    naam = naam.strip()
    if naam in _player_cache:
        return _player_cache[naam]
    res = sb.table('players').select('id').eq('naam', naam).maybe_single().execute()
    if res.data:
        _player_cache[naam] = res.data['id']
    else:
        res = sb.table('players').insert({'naam': naam, 'active': True}).execute()
        _player_cache[naam] = res.data[0]['id']
    return _player_cache[naam]


# ── Season cache ──────────────────────────────────────────────
_season_cache: dict[str, str] = {}  # naam -> id

def get_or_create_season(naam: str) -> str:
    if naam in _season_cache:
        return _season_cache[naam]
    res = sb.table('seasons').select('id').eq('naam', naam).maybe_single().execute()
    if res.data:
        _season_cache[naam] = res.data['id']
    else:
        res = sb.table('seasons').insert({
            'naam': naam,
            'is_current': naam == CURRENT_SEASON
        }).execute()
        _season_cache[naam] = res.data[0]['id']
    return _season_cache[naam]


# ── Parse season sheet (current-style: 2025-2026) ────────────
def parse_current_season_sheet(df: pd.DataFrame, season_name: str):
    """
    Sheet layout (no header row – row indices 0-based):
      Row 0: scores per match  (e.g. "4-2", "1-1" …)
      Row 1: opponent names
      Row 2: dates
      Row 3: times
      Row 4+: player rows  [col0=nummer, col1=naam, col2+=status]
    """
    season_id = get_or_create_season(season_name)
    print(f"  Importing {season_name} (current-style)…")

    # Detect number of match columns (start at col 2)
    scores    = df.iloc[0, 2:].tolist()
    opponents = df.iloc[1, 2:].tolist()
    dates_raw = df.iloc[2, 2:].tolist()
    times_raw = df.iloc[3, 2:].tolist()

    # Collect valid match columns
    matches_meta = []
    for i, (score, opp) in enumerate(zip(scores, opponents)):
        if pd.isna(opp) or str(opp).strip() == '':
            continue
        col_idx = i + 2  # offset into df columns

        # Parse date
        datum_str = None
        raw_date = dates_raw[i]
        if pd.notna(raw_date):
            if isinstance(raw_date, (datetime, pd.Timestamp)):
                datum_str = raw_date.strftime('%Y-%m-%d')
            else:
                try:
                    datum_str = pd.to_datetime(str(raw_date)).strftime('%Y-%m-%d')
                except Exception:
                    pass

        # Parse score
        score_d, score_t = None, None
        if pd.notna(score):
            m = re.match(r'^(\d+)\s*[-–]\s*(\d+)$', str(score).strip())
            if m:
                score_d, score_t = int(m.group(1)), int(m.group(2))

        tijdstip = str(times_raw[i]) if pd.notna(times_raw[i]) else None

        # Upsert match
        existing = sb.table('matches')\
            .select('id')\
            .eq('season_id', season_id)\
            .eq('tegenstander', str(opp).strip())\
            .eq('datum', datum_str or '1900-01-01')\
            .maybe_single().execute()

        if existing.data:
            match_id = existing.data['id']
        else:
            res = sb.table('matches').insert({
                'season_id':          season_id,
                'datum':              datum_str or '1900-01-01',
                'tijdstip':           tijdstip,
                'tegenstander':       str(opp).strip(),
                'score_dodeka':       score_d,
                'score_tegenstander': score_t,
                'is_thuis':           True,  # unknown from this sheet; update manually if needed
            }).execute()
            match_id = res.data[0]['id']

        matches_meta.append({'col': col_idx, 'match_id': match_id})

    # Player rows start at row 4
    for row_idx in range(4, len(df)):
        row = df.iloc[row_idx]
        naam = row.iloc[1] if pd.notna(row.iloc[1]) else None
        if pd.isna(naam) or str(naam).strip() == '' or str(naam).strip().upper() == 'NAAM':
            continue

        player_id = get_or_create_player(str(naam).strip())

        for meta in matches_meta:
            val = row.iloc[meta['col']]
            if pd.isna(val):
                continue
            status = AANW_MAP.get(str(val).strip().lower())
            if status:
                sb.table('aanwezigheid').upsert(
                    {'match_id': meta['match_id'], 'player_id': player_id, 'status': status},
                    on_conflict='match_id,player_id'
                ).execute()

    print(f"    → {len(matches_meta)} matches, aanwezigheid imported.")


# ── Parse goals sheet ─────────────────────────────────────────
def parse_goals_sheet(df: pd.DataFrame, season_name: str):
    season_id = get_or_create_season(season_name)
    opponents = df.iloc[1, 2:].tolist()
    dates_raw = df.iloc[2, 2:].tolist()

    match_ids = []
    for i, opp in enumerate(opponents):
        if pd.isna(opp) or str(opp).strip() == '':
            continue
        raw_date = dates_raw[i]
        datum_str = None
        if pd.notna(raw_date):
            if isinstance(raw_date, (datetime, pd.Timestamp)):
                datum_str = raw_date.strftime('%Y-%m-%d')
            else:
                try:
                    datum_str = pd.to_datetime(str(raw_date)).strftime('%Y-%m-%d')
                except Exception:
                    pass
        res = sb.table('matches')\
            .select('id')\
            .eq('season_id', season_id)\
            .eq('tegenstander', str(opp).strip())\
            .maybe_single().execute()
        match_ids.append((i + 2, res.data['id'] if res.data else None))

    count = 0
    for row_idx in range(3, len(df)):
        row  = df.iloc[row_idx]
        naam = row.iloc[1]
        if pd.isna(naam) or str(naam).strip() == '':
            continue

        is_eigen = 'eigen doelpunt' in str(naam).lower()
        player_id = None if is_eigen else get_or_create_player(str(naam).strip())

        for col_idx, match_id in match_ids:
            if match_id is None:
                continue
            val = row.iloc[col_idx]
            if pd.isna(val):
                continue
            try:
                aantal = int(float(val))
            except (ValueError, TypeError):
                continue
            if aantal <= 0:
                continue
            if player_id:
                sb.table('doelpunten').upsert(
                    {'match_id': match_id, 'player_id': player_id, 'aantal': aantal},
                    on_conflict='match_id,player_id'
                ).execute()
                count += 1

    print(f"    → {count} goal records imported.")


# ── Parse assists sheet ───────────────────────────────────────
def parse_assists_sheet(df: pd.DataFrame, season_name: str):
    season_id = get_or_create_season(season_name)
    opponents = df.iloc[1, 2:].tolist()
    match_ids = []
    for i, opp in enumerate(opponents):
        if pd.isna(opp) or str(opp).strip() == '':
            continue
        res = sb.table('matches')\
            .select('id')\
            .eq('season_id', season_id)\
            .eq('tegenstander', str(opp).strip())\
            .maybe_single().execute()
        match_ids.append((i + 2, res.data['id'] if res.data else None))

    count = 0
    for row_idx in range(3, len(df)):
        row  = df.iloc[row_idx]
        naam = row.iloc[1]
        if pd.isna(naam) or str(naam).strip() == '':
            continue
        player_id = get_or_create_player(str(naam).strip())
        for col_idx, match_id in match_ids:
            if match_id is None:
                continue
            val = row.iloc[col_idx]
            if pd.isna(val):
                continue
            try:
                aantal = int(float(val))
            except (ValueError, TypeError):
                continue
            if aantal <= 0:
                continue
            sb.table('assists').upsert(
                {'match_id': match_id, 'player_id': player_id, 'aantal': aantal},
                on_conflict='match_id,player_id'
            ).execute()
            count += 1
    print(f"    → {count} assist records imported.")


# ── Parse cards sheet ─────────────────────────────────────────
def parse_cards_sheet(df: pd.DataFrame, season_name: str):
    season_id = get_or_create_season(season_name)
    opponents = df.iloc[1, 2:].tolist()
    match_ids = []
    for i, opp in enumerate(opponents):
        if pd.isna(opp) or str(opp).strip() == '':
            continue
        res = sb.table('matches')\
            .select('id')\
            .eq('season_id', season_id)\
            .eq('tegenstander', str(opp).strip())\
            .maybe_single().execute()
        match_ids.append((i + 2, res.data['id'] if res.data else None))

    count = 0
    for row_idx in range(3, len(df)):
        row  = df.iloc[row_idx]
        naam = row.iloc[1]
        if pd.isna(naam) or str(naam).strip() == '':
            continue
        player_id = get_or_create_player(str(naam).strip())
        for col_idx, match_id in match_ids:
            if match_id is None:
                continue
            val = row.iloc[col_idx]
            if pd.isna(val):
                continue
            try:
                aantal = int(float(val))
            except (ValueError, TypeError):
                continue
            if aantal <= 0:
                continue
            sb.table('kaarten').upsert(
                {'match_id': match_id, 'player_id': player_id, 'geel': aantal},
                on_conflict='match_id,player_id'
            ).execute()
            count += 1
    print(f"    → {count} card records imported.")


# ── Parse MOTM sheet ──────────────────────────────────────────
def parse_motm_sheet(df: pd.DataFrame, season_name: str):
    season_id = get_or_create_season(season_name)
    opponents = df.iloc[1, 2:].tolist()
    match_ids = []
    for i, opp in enumerate(opponents):
        if pd.isna(opp) or str(opp).strip() == '':
            continue
        res = sb.table('matches')\
            .select('id')\
            .eq('season_id', season_id)\
            .eq('tegenstander', str(opp).strip())\
            .maybe_single().execute()
        match_ids.append((i + 2, res.data['id'] if res.data else None))

    count = 0
    for row_idx in range(3, len(df)):
        row  = df.iloc[row_idx]
        naam = row.iloc[1]
        if pd.isna(naam) or str(naam).strip() == '':
            continue
        player_id = get_or_create_player(str(naam).strip())
        for col_idx, match_id in match_ids:
            if match_id is None:
                continue
            val = row.iloc[col_idx]
            if pd.isna(val):
                continue
            try:
                if int(float(val)) >= 1:
                    sb.table('motm').upsert(
                        {'match_id': match_id, 'player_id': player_id},
                        on_conflict='match_id'
                    ).execute()
                    count += 1
            except (ValueError, TypeError):
                continue
    print(f"    → {count} MOTM records imported.")


# ── Main ──────────────────────────────────────────────────────
def main():
    print(f"Loading Excel file: {EXCEL_PATH}")
    xl = pd.read_excel(EXCEL_PATH, sheet_name=None, header=None)
    print(f"Found sheets: {list(xl.keys())}\n")

    # Import the current detailed season sheets
    season = '2025-2026'
    if season in xl:
        print(f"=== Seizoen {season} ===")
        parse_current_season_sheet(xl[season], season)

        goals_sheet = f'Doelpunten {season}'
        if goals_sheet in xl:
            parse_goals_sheet(xl[goals_sheet], season)

        assists_sheet = f'Assists {season}'
        if assists_sheet in xl:
            parse_assists_sheet(xl[assists_sheet], season)

        cards_sheet = f'Kaarten {season}'
        if cards_sheet in xl:
            parse_cards_sheet(xl[cards_sheet], season)

        motm_sheet = f'Men of the Match {season}'
        if motm_sheet in xl:
            parse_motm_sheet(xl[motm_sheet], season)

    # Import older seasons from their individual sheets
    older_seasons = [s for s in SEASON_SHEETS if s != '2025-2026' and s in xl]
    for season_name in sorted(older_seasons):
        print(f"\n=== Seizoen {season_name} (historisch) ===")
        parse_current_season_sheet(xl[season_name], season_name)

    print("\n✓ Import completed!")


if __name__ == '__main__':
    main()
