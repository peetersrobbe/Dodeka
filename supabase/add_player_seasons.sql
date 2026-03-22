-- ============================================================
-- DODEKA SPORT – Add season tracking to players
-- Run this once in Supabase SQL Editor
-- ============================================================

ALTER TABLE players
  ADD COLUMN IF NOT EXISTS started_season_id UUID REFERENCES seasons(id),
  ADD COLUMN IF NOT EXISTS ended_season_id   UUID REFERENCES seasons(id);
