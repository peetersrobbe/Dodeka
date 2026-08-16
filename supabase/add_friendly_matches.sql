-- ============================================================
-- DODEKA SPORT – Friendly (vriendschappelijke) matches
-- Run this in the Supabase SQL Editor.
--
-- Adds an `is_friendly` flag to matches. Friendly games are still
-- fully visible (listed + openable to see what happened), but their
-- goals, assists, cards, MOTM and attendance are excluded from every
-- aggregated statistic (per-season table, all-seasons table,
-- last-5-games section and the historical_season_stats rollup).
-- ============================================================

ALTER TABLE matches
  ADD COLUMN IF NOT EXISTS is_friendly BOOLEAN NOT NULL DEFAULT false;

-- Make sure any pre-existing rows are explicitly non-friendly.
UPDATE matches SET is_friendly = false WHERE is_friendly IS NULL;
