-- ============================================================
-- DODEKA – Data cleanup fix
-- Run this in Supabase SQL Editor > New query
-- ============================================================

-- ── 1. Merge DELANDTSHEER Rik into DE LANDTSHEER Rik ─────────
-- Reassign any stat records that don't conflict
DO $$
DECLARE
  keep_id  UUID := 'ff2eccf5-dd9d-4504-835c-04015695758e';  -- DE LANDTSHEER Rik
  merge_id UUID := '14282040-8ff6-4cc4-a503-f10c6e933a19';  -- DELANDTSHEER Rik
BEGIN
  -- aanwezigheid: skip matches already covered by keep_id (UNIQUE match+player)
  DELETE FROM aanwezigheid
  WHERE player_id = merge_id
    AND match_id IN (SELECT match_id FROM aanwezigheid WHERE player_id = keep_id);

  UPDATE aanwezigheid SET player_id = keep_id WHERE player_id = merge_id;

  -- doelpunten
  DELETE FROM doelpunten
  WHERE player_id = merge_id
    AND match_id IN (SELECT match_id FROM doelpunten WHERE player_id = keep_id);
  -- If both scored in the same match, add the goals together
  UPDATE doelpunten d SET aantal = d.aantal + (
    SELECT aantal FROM doelpunten WHERE player_id = merge_id AND match_id = d.match_id
  )
  WHERE d.player_id = keep_id
    AND EXISTS (SELECT 1 FROM doelpunten WHERE player_id = merge_id AND match_id = d.match_id);
  DELETE FROM doelpunten WHERE player_id = merge_id;

  -- assists
  DELETE FROM assists
  WHERE player_id = merge_id
    AND match_id IN (SELECT match_id FROM assists WHERE player_id = keep_id);
  UPDATE assists a SET aantal = a.aantal + (
    SELECT aantal FROM assists WHERE player_id = merge_id AND match_id = a.match_id
  )
  WHERE a.player_id = keep_id
    AND EXISTS (SELECT 1 FROM assists WHERE player_id = merge_id AND match_id = a.match_id);
  DELETE FROM assists WHERE player_id = merge_id;

  -- kaarten
  DELETE FROM kaarten
  WHERE player_id = merge_id
    AND match_id IN (SELECT match_id FROM kaarten WHERE player_id = keep_id);
  UPDATE kaarten k SET
    geel = k.geel + COALESCE((SELECT geel FROM kaarten WHERE player_id = merge_id AND match_id = k.match_id), 0),
    rood = k.rood + COALESCE((SELECT rood FROM kaarten WHERE player_id = merge_id AND match_id = k.match_id), 0)
  WHERE k.player_id = keep_id
    AND EXISTS (SELECT 1 FROM kaarten WHERE player_id = merge_id AND match_id = k.match_id);
  DELETE FROM kaarten WHERE player_id = merge_id;

  -- motm: if somehow both have MOTM for same match, just drop the duplicate
  DELETE FROM motm WHERE player_id = merge_id
    AND match_id IN (SELECT match_id FROM motm WHERE player_id = keep_id);
  UPDATE motm SET player_id = keep_id WHERE player_id = merge_id;

  -- Finally remove the duplicate player
  DELETE FROM players WHERE id = merge_id;
END $$;

-- ── 2. Remove non-player entries (Excel row labels) ──────────
DELETE FROM players WHERE id IN (
  'eb69d0c7-68e8-4518-866c-348778fe0ed6',  -- Forfait
  '58e2e70a-0f91-4b3b-b860-b0c93d2e6bd4',  -- Gelijk
  'a61ba331-ed0a-4389-a40c-e47508e55da4',  -- Gewonnen
  '7b887c20-5e95-4039-bb27-b37f1817c004',  -- Met 11 of meer?
  'c7f5cdf8-fbbc-4b74-b1ce-15a336c4e9b7',  -- TEGEN
  '97211e26-f8b2-499d-a50c-7912bfd5e362',  -- Tegen
  'f3cda04e-9023-49e9-af26-8815eb50ad83',  -- VOOR
  '812417f7-52ec-4110-a15d-292fec7f71a7',  -- Verloren
  '71cc37a0-cd03-4c24-a327-2581c5a4888d'   -- Voor
);
-- Their stats (aanwezigheid, doelpunten, etc.) are removed automatically via CASCADE

-- ── 3. Remove matches with invalid date (01/01/1900) ─────────
DELETE FROM matches WHERE datum = '1900-01-01';
-- Their child rows (aanwezigheid, doelpunten, etc.) are removed automatically via CASCADE
