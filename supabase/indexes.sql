-- ============================================================
-- DODEKA SPORT – Database Indexes
-- Run this in Supabase SQL Editor after schema.sql
-- These make all queries significantly faster.
-- ============================================================

-- Matches: filter by season
CREATE INDEX IF NOT EXISTS idx_matches_season_id     ON matches(season_id);

-- Stats tables: filter by match
CREATE INDEX IF NOT EXISTS idx_aanwezigheid_match_id ON aanwezigheid(match_id);
CREATE INDEX IF NOT EXISTS idx_doelpunten_match_id   ON doelpunten(match_id);
CREATE INDEX IF NOT EXISTS idx_assists_match_id      ON assists(match_id);
CREATE INDEX IF NOT EXISTS idx_kaarten_match_id      ON kaarten(match_id);
CREATE INDEX IF NOT EXISTS idx_motm_match_id         ON motm(match_id);

-- Stats tables: filter by player
CREATE INDEX IF NOT EXISTS idx_aanwezigheid_player   ON aanwezigheid(player_id);
CREATE INDEX IF NOT EXISTS idx_doelpunten_player     ON doelpunten(player_id);
CREATE INDEX IF NOT EXISTS idx_assists_player        ON assists(player_id);
CREATE INDEX IF NOT EXISTS idx_kaarten_player        ON kaarten(player_id);
CREATE INDEX IF NOT EXISTS idx_motm_player           ON motm(player_id);

-- Standings: filter by season
CREATE INDEX IF NOT EXISTS idx_standings_season_id   ON standings(season_id);
