-- ============================================================
-- DODEKA – Remap old attendance codes to new status values
-- Run this in Supabase SQL Editor > New query
-- ============================================================

-- 'aanwezig' (h/w codes from Excel = played)  → 'volledig'
UPDATE aanwezigheid SET status = 'volledig'    WHERE status = 'aanwezig';

-- 'verontschuldigd' (k/t codes from Excel = came to watch) → 'toeschouwer'
UPDATE aanwezigheid SET status = 'toeschouwer' WHERE status = 'verontschuldigd';
