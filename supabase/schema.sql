-- ============================================================
-- DODEKA SPORT – Supabase Database Schema
-- Run this in the Supabase SQL Editor (https://app.supabase.com)
-- Project > SQL Editor > New query > paste & run
-- ============================================================

-- ── Seasons ──────────────────────────────────────────────────
CREATE TABLE seasons (
  id          UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
  naam        TEXT    NOT NULL UNIQUE,   -- e.g. "2025-2026"
  start_date  DATE,
  end_date    DATE,
  is_current  BOOLEAN DEFAULT false
);

-- ── Players ──────────────────────────────────────────────────
CREATE TABLE players (
  id         UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
  naam       TEXT    NOT NULL,
  nummer     INTEGER,
  user_id    UUID    REFERENCES auth.users(id) ON DELETE SET NULL,
  active     BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── Admins ───────────────────────────────────────────────────
-- Add a user_id here to grant admin write access
CREATE TABLE admins (
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY
);

-- ── Matches ──────────────────────────────────────────────────
CREATE TABLE matches (
  id                  UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
  season_id           UUID    REFERENCES seasons(id) ON DELETE CASCADE,
  datum               DATE    NOT NULL,
  tijdstip            TEXT,
  tegenstander        TEXT    NOT NULL,
  score_dodeka        INTEGER,
  score_tegenstander  INTEGER,
  is_thuis            BOOLEAN DEFAULT true,
  uitslag             TEXT    CHECK (uitslag IN ('w', 'v', 'g', 'fw', 'fv', 'fg')),
  source              TEXT    DEFAULT 'manual'  -- 'manual' or 'kavvv'
);

-- ── Attendance (Aanwezigheid) ─────────────────────────────────
CREATE TABLE aanwezigheid (
  id         UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  match_id   UUID REFERENCES matches(id)  ON DELETE CASCADE,
  player_id  UUID REFERENCES players(id) ON DELETE CASCADE,
  status     TEXT CHECK (status IN ('volledig', 'gewisseld', 'toeschouwer', 'keeper', 'afwezig', 'verontschuldigd', 'aanwezig')),
  UNIQUE (match_id, player_id)
);

-- ── Goals (Doelpunten) ────────────────────────────────────────
CREATE TABLE doelpunten (
  id               UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
  match_id         UUID    REFERENCES matches(id)  ON DELETE CASCADE,
  player_id        UUID    REFERENCES players(id) ON DELETE CASCADE,
  aantal           INTEGER DEFAULT 1,
  is_eigen_doelpunt BOOLEAN DEFAULT false,
  UNIQUE (match_id, player_id)
);

-- ── Assists ───────────────────────────────────────────────────
CREATE TABLE assists (
  id        UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
  match_id  UUID    REFERENCES matches(id)  ON DELETE CASCADE,
  player_id UUID    REFERENCES players(id) ON DELETE CASCADE,
  aantal    INTEGER DEFAULT 1,
  UNIQUE (match_id, player_id)
);

-- ── Cards (Kaarten) ───────────────────────────────────────────
CREATE TABLE kaarten (
  id        UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
  match_id  UUID    REFERENCES matches(id)  ON DELETE CASCADE,
  player_id UUID    REFERENCES players(id) ON DELETE CASCADE,
  geel      INTEGER DEFAULT 0,
  rood      INTEGER DEFAULT 0,
  UNIQUE (match_id, player_id)
);

-- ── Man of the Match ──────────────────────────────────────────
CREATE TABLE motm (
  id        UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  match_id  UUID REFERENCES matches(id)  ON DELETE CASCADE,
  player_id UUID REFERENCES players(id) ON DELETE CASCADE,
  UNIQUE (match_id)
);

-- ── League Standings (auto-synced from KAVVV) ─────────────────
CREATE TABLE standings (
  id           UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
  season_id    UUID    REFERENCES seasons(id) ON DELETE CASCADE,
  positie      INTEGER,
  team_naam    TEXT    NOT NULL,
  gespeeld     INTEGER DEFAULT 0,
  gewonnen     INTEGER DEFAULT 0,
  gelijk       INTEGER DEFAULT 0,
  verloren     INTEGER DEFAULT 0,
  doelpunten_voor  INTEGER DEFAULT 0,
  doelpunten_tegen INTEGER DEFAULT 0,
  punten       INTEGER DEFAULT 0,
  updated_at   TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (season_id, team_naam)
);

-- ── Convenience View: Season Stats per Player ─────────────────
CREATE OR REPLACE VIEW season_player_stats AS
SELECT
  p.id                                                          AS player_id,
  p.naam,
  p.nummer,
  s.id                                                          AS season_id,
  s.naam                                                        AS seizoen,
  COUNT(DISTINCT m.id)                                          AS wedstrijden_gespeeld,
  COUNT(DISTINCT CASE WHEN a.status = 'aanwezig'       THEN a.match_id END) AS aanwezig,
  COUNT(DISTINCT CASE WHEN a.status = 'afwezig'        THEN a.match_id END) AS afwezig,
  COUNT(DISTINCT CASE WHEN a.status = 'verontschuldigd' THEN a.match_id END) AS verontschuldigd,
  COALESCE(SUM(d.aantal),  0)                                   AS doelpunten,
  COALESCE(SUM(ast.aantal), 0)                                  AS assists,
  COALESCE(SUM(k.geel),    0)                                   AS gele_kaarten,
  COALESCE(SUM(k.rood),    0)                                   AS rode_kaarten,
  COUNT(DISTINCT mo.match_id)                                   AS motm
FROM players p
CROSS JOIN seasons s
LEFT JOIN matches      m   ON m.season_id  = s.id
LEFT JOIN aanwezigheid a   ON a.player_id  = p.id AND a.match_id  = m.id
LEFT JOIN doelpunten   d   ON d.player_id  = p.id AND d.match_id  = m.id
LEFT JOIN assists      ast ON ast.player_id = p.id AND ast.match_id = m.id
LEFT JOIN kaarten      k   ON k.player_id  = p.id AND k.match_id  = m.id
LEFT JOIN motm         mo  ON mo.player_id = p.id AND mo.match_id = m.id
GROUP BY p.id, p.naam, p.nummer, s.id, s.naam;

-- ════════════════════════════════════════════════════════════
-- ROW LEVEL SECURITY
-- ════════════════════════════════════════════════════════════
ALTER TABLE seasons       ENABLE ROW LEVEL SECURITY;
ALTER TABLE players       ENABLE ROW LEVEL SECURITY;
ALTER TABLE admins        ENABLE ROW LEVEL SECURITY;
ALTER TABLE matches       ENABLE ROW LEVEL SECURITY;
ALTER TABLE aanwezigheid  ENABLE ROW LEVEL SECURITY;
ALTER TABLE doelpunten    ENABLE ROW LEVEL SECURITY;
ALTER TABLE assists       ENABLE ROW LEVEL SECURITY;
ALTER TABLE kaarten       ENABLE ROW LEVEL SECURITY;
ALTER TABLE motm          ENABLE ROW LEVEL SECURITY;
ALTER TABLE standings     ENABLE ROW LEVEL SECURITY;

-- Only logged-in users can read (statistics are private)
CREATE POLICY "auth_read" ON seasons      FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON players      FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON matches      FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON aanwezigheid FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON doelpunten   FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON assists      FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON kaarten      FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON motm         FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON standings    FOR SELECT USING (auth.uid() IS NOT NULL);

-- Only admins can write
CREATE POLICY "admin_write" ON seasons      FOR ALL USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));
CREATE POLICY "admin_write" ON players      FOR ALL USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));
CREATE POLICY "admin_write" ON matches      FOR ALL USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));
CREATE POLICY "admin_write" ON aanwezigheid FOR ALL USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));
CREATE POLICY "admin_write" ON doelpunten   FOR ALL USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));
CREATE POLICY "admin_write" ON assists      FOR ALL USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));
CREATE POLICY "admin_write" ON kaarten      FOR ALL USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));
CREATE POLICY "admin_write" ON motm         FOR ALL USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));
CREATE POLICY "admin_write" ON standings    FOR ALL USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));

-- Admins table: use SECURITY DEFINER function to avoid infinite recursion
-- (a policy on admins that queries admins would recurse forever)
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid());
$$;

CREATE POLICY "public_read" ON admins FOR SELECT USING (true);
CREATE POLICY "admin_write" ON admins FOR ALL   USING (public.is_admin());
