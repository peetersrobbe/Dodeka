-- ============================================================
-- DODEKA SPORT – Voeg 'keeper' toe + pas statistieken view aan
-- Stap 1 van 2: run dit VÓÓR de nieuwe seed_data.sql
-- ============================================================

-- ── 1. Voeg 'keeper' toe aan de CHECK constraint ────────────
ALTER TABLE aanwezigheid
  DROP CONSTRAINT IF EXISTS aanwezigheid_status_check;

ALTER TABLE aanwezigheid
  ADD CONSTRAINT aanwezigheid_status_check
  CHECK (status IN ('volledig', 'gewisseld', 'toeschouwer', 'keeper',
                    'afwezig', 'verontschuldigd', 'aanwezig'));

-- ── 2. Update season_player_stats view ──────────────────────
-- DROP + recreate is nodig omdat kolommen hernoemd worden
-- (CREATE OR REPLACE laat hernaming van kolommen niet toe)
DROP VIEW IF EXISTS season_player_stats;
CREATE VIEW season_player_stats AS
SELECT
  p.id                                                            AS player_id,
  p.naam,
  p.nummer,
  s.id                                                            AS season_id,
  s.naam                                                          AS seizoen,
  COUNT(DISTINCT m.id)                                            AS wedstrijden_gespeeld,
  COUNT(DISTINCT CASE
    WHEN a.status IN ('volledig', 'gewisseld', 'toeschouwer', 'keeper', 'aanwezig')
    THEN a.match_id END)                                          AS aanwezig,
  COUNT(DISTINCT CASE WHEN a.status = 'volledig'        THEN a.match_id END) AS volledig,
  COUNT(DISTINCT CASE WHEN a.status = 'gewisseld'       THEN a.match_id END) AS gewisseld,
  COUNT(DISTINCT CASE WHEN a.status = 'toeschouwer'     THEN a.match_id END) AS toeschouwer,
  COUNT(DISTINCT CASE WHEN a.status = 'keeper'          THEN a.match_id END) AS keeper,
  COUNT(DISTINCT CASE WHEN a.status = 'afwezig'         THEN a.match_id END) AS afwezig,
  COUNT(DISTINCT CASE WHEN a.status = 'verontschuldigd' THEN a.match_id END) AS verontschuldigd,
  COALESCE(SUM(d.aantal),   0)                                    AS doelpunten,
  COALESCE(SUM(ast.aantal), 0)                                    AS assists,
  COALESCE(SUM(k.geel),     0)                                    AS gele_kaarten,
  COALESCE(SUM(k.rood),     0)                                    AS rode_kaarten,
  COUNT(DISTINCT mo.match_id)                                     AS motm
FROM players p
CROSS JOIN seasons s
LEFT JOIN matches      m   ON m.season_id  = s.id
LEFT JOIN aanwezigheid a   ON a.player_id  = p.id AND a.match_id  = m.id
LEFT JOIN doelpunten   d   ON d.player_id  = p.id AND d.match_id  = m.id
LEFT JOIN assists      ast ON ast.player_id = p.id AND ast.match_id = m.id
LEFT JOIN kaarten      k   ON k.player_id  = p.id AND k.match_id  = m.id
LEFT JOIN motm         mo  ON mo.player_id = p.id AND mo.match_id = m.id
GROUP BY p.id, p.naam, p.nummer, s.id, s.naam;
