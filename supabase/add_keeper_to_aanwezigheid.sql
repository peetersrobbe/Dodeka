-- ============================================================
-- DODEKA SPORT – Add keeper tracking + forfait flag
-- Run this once in Supabase SQL Editor
-- ============================================================

-- Add is_keeper to aanwezigheid (was someone the goalkeeper for this match?)
ALTER TABLE aanwezigheid
  ADD COLUMN IF NOT EXISTS is_keeper BOOLEAN DEFAULT false;

-- Add is_forfait to matches (was this match played as a forfait?)
ALTER TABLE matches
  ADD COLUMN IF NOT EXISTS is_forfait BOOLEAN DEFAULT false;
