-- ============================================================
-- DODEKA – Make statistics private + expand attendance statuses
-- Run this in Supabase SQL Editor > New query
-- ============================================================

-- ── 1. Expand the aanwezigheid status constraint ──────────────
ALTER TABLE aanwezigheid
  DROP CONSTRAINT IF EXISTS aanwezigheid_status_check;

ALTER TABLE aanwezigheid
  ADD CONSTRAINT aanwezigheid_status_check
  CHECK (status IN ('volledig', 'gewisseld', 'toeschouwer', 'afwezig', 'verontschuldigd', 'aanwezig'));

-- ── 2. Make stats readable only when logged in ────────────────
-- Drop old public-read policies
DROP POLICY IF EXISTS "public_read" ON seasons;
DROP POLICY IF EXISTS "public_read" ON players;
DROP POLICY IF EXISTS "public_read" ON matches;
DROP POLICY IF EXISTS "public_read" ON aanwezigheid;
DROP POLICY IF EXISTS "public_read" ON doelpunten;
DROP POLICY IF EXISTS "public_read" ON assists;
DROP POLICY IF EXISTS "public_read" ON kaarten;
DROP POLICY IF EXISTS "public_read" ON motm;
DROP POLICY IF EXISTS "public_read" ON standings;

-- Create auth-only read policies
CREATE POLICY "auth_read" ON seasons      FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON players      FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON matches      FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON aanwezigheid FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON doelpunten   FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON assists      FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON kaarten      FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON motm         FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_read" ON standings    FOR SELECT USING (auth.uid() IS NOT NULL);

-- Keep admins table publicly readable (needed for the is_admin() check)
-- Already set in the previous fix — nothing to change here.
