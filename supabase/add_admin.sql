-- ============================================================
-- DODEKA – Add a user as admin
-- 1. Go to Supabase → Authentication → Users
-- 2. Find the user, copy their UUID from the "UID" column
-- 3. Paste it below and run this query
-- ============================================================

INSERT INTO admins (user_id)
VALUES ('PLAK-HIER-JE-USER-UUID')
ON CONFLICT DO NOTHING;

-- Verify it worked:
SELECT * FROM admins;
