-- ============================================================
-- DODEKA SPORT – Voeg 'uitslag' kolom toe aan matches
-- Run dit VÓÓR de nieuwe seed_data.sql
-- ============================================================

ALTER TABLE matches
  ADD COLUMN IF NOT EXISTS uitslag TEXT
  CHECK (uitslag IN ('w', 'v', 'g', 'fw', 'fv', 'fg'));
