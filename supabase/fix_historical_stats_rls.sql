-- ============================================================
-- FIX: historical_season_stats write policy was too permissive.
-- The original migration used auth.role() = 'authenticated', which
-- allows ANY logged-in user to write. Replace it with the same
-- admin-only check used on every other table.
--
-- Run this once in: Supabase > SQL Editor > New query > Run
-- ============================================================

DROP POLICY IF EXISTS "auth write" ON historical_season_stats;

CREATE POLICY "admin_write" ON historical_season_stats
  FOR ALL
  USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));
