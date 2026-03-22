-- ═══════════════════════════════════════════════════════════════
-- Migratie: aanwezigheid-kolommen toevoegen aan historical_season_stats
-- Brondata: rechtstreeks uit de Excel-seizoensbladen (ground truth)
-- Voer uit NA add_historical_season_stats.sql
-- ═══════════════════════════════════════════════════════════════

-- Voeg aanwezigheidskolommen toe
ALTER TABLE historical_season_stats
  ADD COLUMN IF NOT EXISTS aanwezig     INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS gespeeld     INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS gewisseld    INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS keeper_games INT NOT NULL DEFAULT 0;

-- ── Aanwezigheidsdata per speler per seizoen (uit Excel-bronbladen) ──
-- Spelers met bekende UUID: directe INSERT/UPDATE
-- Spelers zonder UUID: naam-opzoeking via players-tabel

-- ── Seizoen 2017-2018 ──
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'b04ed76b-4e28-49fd-a0b4-39e8243a54a0', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 4, 4, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '19792ac8-88f6-4a8b-9868-3b0b7184ae85', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 12, 12, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=12, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'DE BAKKER Toon'), '521a8c8a-2c7e-437d-b221-3586a9816c4e', 9, 9, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=9, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'db232b7c-aa0f-4295-b87a-ea5db2338730', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 12, 12, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=12, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '46e7f9db-b122-4111-a3e8-969af745d315', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 14, 14, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=14, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '75aec47d-812c-4899-a8db-2b64a43ef098', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 9, 9, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=9, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'ec83d2d1-1cf1-46ad-ae97-d17a63d532e3', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 13, 7, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=13, gespeeld=7, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 15, 15, 2, 5, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=15, gewisseld=2, keeper_games=5;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 12, 12, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=12, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'RENDERS Willem'), '521a8c8a-2c7e-437d-b221-3586a9816c4e', 1, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 4, 4, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6f340559-30b0-4ea3-af31-3ca707e51315', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 9, 9, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=9, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 10, 10, 0, 10, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=10, gespeeld=10, gewisseld=0, keeper_games=10;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'dad289c4-fc5d-43bd-aeaa-8c5a87273764', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 11, 10, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=11, gespeeld=10, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 13, 13, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=13, gespeeld=13, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VANLERBERGHE Jens'), '521a8c8a-2c7e-437d-b221-3586a9816c4e', 11, 10, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=11, gespeeld=10, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 11, 11, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=11, gespeeld=11, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd45fb0a6-6b26-4271-aa16-c02c88b28c22', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 14, 14, 0, 2, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=14, gewisseld=0, keeper_games=2;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 12, 12, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=12, gewisseld=2, keeper_games=0;

-- ── Seizoen 2018-2019 ──
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '19792ac8-88f6-4a8b-9868-3b0b7184ae85', 'd7353430-0e3b-4d52-8929-589bb68d6678', 11, 11, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=11, gespeeld=11, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '34d80d7f-1327-4839-8dec-889398b9737b', 'd7353430-0e3b-4d52-8929-589bb68d6678', 2, 2, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=2, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'DE BAKKER Toon'), 'd7353430-0e3b-4d52-8929-589bb68d6678', 16, 15, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=15, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'db232b7c-aa0f-4295-b87a-ea5db2338730', 'd7353430-0e3b-4d52-8929-589bb68d6678', 14, 10, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=10, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '08d42ab8-69da-488f-9553-4bab95fd89e4', 'd7353430-0e3b-4d52-8929-589bb68d6678', 3, 2, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=2, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'feb5a1e3-c509-4833-aacf-4d70aae2f260', 'd7353430-0e3b-4d52-8929-589bb68d6678', 11, 11, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=11, gespeeld=11, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '76cfff9b-0e78-4c71-94aa-2c62c8f50107', 'd7353430-0e3b-4d52-8929-589bb68d6678', 10, 10, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=10, gespeeld=10, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '46e7f9db-b122-4111-a3e8-969af745d315', 'd7353430-0e3b-4d52-8929-589bb68d6678', 14, 14, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=14, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '75aec47d-812c-4899-a8db-2b64a43ef098', 'd7353430-0e3b-4d52-8929-589bb68d6678', 8, 8, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=8, gespeeld=8, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'ec83d2d1-1cf1-46ad-ae97-d17a63d532e3', 'd7353430-0e3b-4d52-8929-589bb68d6678', 8, 6, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=8, gespeeld=6, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'd7353430-0e3b-4d52-8929-589bb68d6678', 18, 17, 4, 1, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=18, gespeeld=17, gewisseld=4, keeper_games=1;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'b368cd89-d75e-4d9e-9033-e1257f856bd2', 'd7353430-0e3b-4d52-8929-589bb68d6678', 16, 14, 3, 3, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=14, gewisseld=3, keeper_games=3;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'e7e35450-49ae-4cc2-80cb-35c4b406f478', 'd7353430-0e3b-4d52-8929-589bb68d6678', 9, 5, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=5, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6b321166-046b-44e4-8ebf-7e0a20b0fddd', 'd7353430-0e3b-4d52-8929-589bb68d6678', 2, 1, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=1, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6f340559-30b0-4ea3-af31-3ca707e51315', 'd7353430-0e3b-4d52-8929-589bb68d6678', 16, 14, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=14, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', 'd7353430-0e3b-4d52-8929-589bb68d6678', 11, 11, 0, 11, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=11, gespeeld=11, gewisseld=0, keeper_games=11;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'dad289c4-fc5d-43bd-aeaa-8c5a87273764', 'd7353430-0e3b-4d52-8929-589bb68d6678', 9, 9, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=9, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2995e934-f5a4-4076-ae32-0e02728e600a', 'd7353430-0e3b-4d52-8929-589bb68d6678', 10, 9, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=10, gespeeld=9, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', 'd7353430-0e3b-4d52-8929-589bb68d6678', 16, 15, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=15, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', 'd7353430-0e3b-4d52-8929-589bb68d6678', 18, 18, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=18, gespeeld=18, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VAN GOETHEM Tijl'), 'd7353430-0e3b-4d52-8929-589bb68d6678', 2, 2, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=2, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VANLERBERGHE Jens'), 'd7353430-0e3b-4d52-8929-589bb68d6678', 3, 3, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', 'd7353430-0e3b-4d52-8929-589bb68d6678', 8, 6, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=8, gespeeld=6, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd45fb0a6-6b26-4271-aa16-c02c88b28c22', 'd7353430-0e3b-4d52-8929-589bb68d6678', 15, 15, 4, 4, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=15, gewisseld=4, keeper_games=4;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', 'd7353430-0e3b-4d52-8929-589bb68d6678', 14, 14, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=14, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '38d0b8c9-7c17-4392-a492-b95943248244', 'd7353430-0e3b-4d52-8929-589bb68d6678', 7, 6, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=7, gespeeld=6, gewisseld=2, keeper_games=0;

-- ── Seizoen 2019-2020 ──
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '19792ac8-88f6-4a8b-9868-3b0b7184ae85', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 10, 10, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=10, gespeeld=10, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '34d80d7f-1327-4839-8dec-889398b9737b', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 12, 12, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=12, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'DE BAKKER Toon'), '84be4ead-cb97-450b-a79f-c3f37f4c404d', 14, 13, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=13, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'db232b7c-aa0f-4295-b87a-ea5db2338730', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 13, 13, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=13, gespeeld=13, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '08d42ab8-69da-488f-9553-4bab95fd89e4', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 4, 3, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=3, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'feb5a1e3-c509-4833-aacf-4d70aae2f260', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 9, 9, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=9, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '46e7f9db-b122-4111-a3e8-969af745d315', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 12, 10, 3, 1, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=10, gewisseld=3, keeper_games=1;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '75aec47d-812c-4899-a8db-2b64a43ef098', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 18, 18, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=18, gespeeld=18, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 14, 14, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=14, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'e7e35450-49ae-4cc2-80cb-35c4b406f478', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 7, 7, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=7, gespeeld=7, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 17, 13, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=17, gespeeld=13, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 16, 16, 0, 16, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=16, gewisseld=0, keeper_games=16;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2995e934-f5a4-4076-ae32-0e02728e600a', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 16, 15, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=15, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 12, 11, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=11, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VAN DER AUWERA Stijn'), '84be4ead-cb97-450b-a79f-c3f37f4c404d', 7, 6, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=7, gespeeld=6, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 17, 17, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=17, gespeeld=17, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VAN GOETHEM Tijl'), '84be4ead-cb97-450b-a79f-c3f37f4c404d', 1, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VANLERBERGHE Jens'), '84be4ead-cb97-450b-a79f-c3f37f4c404d', 5, 5, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=5, gespeeld=5, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 9, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd45fb0a6-6b26-4271-aa16-c02c88b28c22', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 12, 10, 2, 2, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=10, gewisseld=2, keeper_games=2;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 12, 11, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=11, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '38d0b8c9-7c17-4392-a492-b95943248244', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 14, 13, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=13, gewisseld=4, keeper_games=0;

-- ── Seizoen 2020-2021 ──
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '34d80d7f-1327-4839-8dec-889398b9737b', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 4, 4, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'DE BAKKER Toon'), '03814ec7-8f01-4709-a8f9-e473a76d1e86', 3, 3, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'db232b7c-aa0f-4295-b87a-ea5db2338730', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 4, 4, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 3, 3, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '08d42ab8-69da-488f-9553-4bab95fd89e4', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 2, 1, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=1, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'feb5a1e3-c509-4833-aacf-4d70aae2f260', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 2, 2, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=2, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '46e7f9db-b122-4111-a3e8-969af745d315', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 2, 2, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=2, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '75aec47d-812c-4899-a8db-2b64a43ef098', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 4, 3, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=3, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 4, 4, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'e7e35450-49ae-4cc2-80cb-35c4b406f478', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 2, 2, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=2, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 2, 2, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=2, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 4, 4, 0, 4, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=0, keeper_games=4;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2995e934-f5a4-4076-ae32-0e02728e600a', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 3, 2, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=2, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 3, 3, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VAN DER AUWERA Stijn'), '03814ec7-8f01-4709-a8f9-e473a76d1e86', 1, 0, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=0, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 4, 4, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '02ef13da-4f05-45da-9cd0-d62c0cc16f51', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 1, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '55db8337-8403-4495-a3aa-ce85cf614885', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 2, 2, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=2, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VANLERBERGHE Jens'), '03814ec7-8f01-4709-a8f9-e473a76d1e86', 2, 0, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=0, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 1, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd45fb0a6-6b26-4271-aa16-c02c88b28c22', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 3, 3, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 2, 1, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=1, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '38d0b8c9-7c17-4392-a492-b95943248244', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 3, 3, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=1, keeper_games=0;

-- ── Seizoen 2021-2022 ──
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '19792ac8-88f6-4a8b-9868-3b0b7184ae85', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 14, 12, 7, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=12, gewisseld=7, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '34d80d7f-1327-4839-8dec-889398b9737b', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 13, 12, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=13, gespeeld=12, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'DE BAKKER Toon'), '9da86047-721f-4fd5-803f-b0ce0c1f4049', 4, 4, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'db232b7c-aa0f-4295-b87a-ea5db2338730', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 15, 15, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=15, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 15, 10, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=10, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '08d42ab8-69da-488f-9553-4bab95fd89e4', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 8, 6, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=8, gespeeld=6, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'feb5a1e3-c509-4833-aacf-4d70aae2f260', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 13, 13, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=13, gespeeld=13, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'DEBAENST Gilles'), '9da86047-721f-4fd5-803f-b0ce0c1f4049', 3, 3, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '46e7f9db-b122-4111-a3e8-969af745d315', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 5, 5, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=5, gespeeld=5, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'GEUDENS Joren'), '9da86047-721f-4fd5-803f-b0ce0c1f4049', 1, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '75aec47d-812c-4899-a8db-2b64a43ef098', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 19, 19, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=19, gespeeld=19, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 12, 9, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=9, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'e7e35450-49ae-4cc2-80cb-35c4b406f478', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 1, 1, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 9, 5, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=5, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 18, 18, 0, 18, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=18, gespeeld=18, gewisseld=0, keeper_games=18;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '4ee424fc-e545-4ca2-8bbc-c516edec4f3d', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 15, 15, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=15, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2995e934-f5a4-4076-ae32-0e02728e600a', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 15, 14, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=14, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 6, 4, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=6, gespeeld=4, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VAN DER AUWERA Stijn'), '9da86047-721f-4fd5-803f-b0ce0c1f4049', 1, 0, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=0, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 15, 10, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=10, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VAN DUN Lennert'), '9da86047-721f-4fd5-803f-b0ce0c1f4049', 1, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'c7c8347b-f2fb-44b4-8135-87dd9e62f0f8', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 9, 9, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=9, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '55db8337-8403-4495-a3aa-ce85cf614885', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 3, 3, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VANLERBERGHE Jens'), '9da86047-721f-4fd5-803f-b0ce0c1f4049', 9, 2, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=2, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 16, 16, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=16, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd45fb0a6-6b26-4271-aa16-c02c88b28c22', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 15, 14, 3, 2, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=14, gewisseld=3, keeper_games=2;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 19, 19, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=19, gespeeld=19, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '38d0b8c9-7c17-4392-a492-b95943248244', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 20, 20, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=20, gespeeld=20, gewisseld=3, keeper_games=0;

-- ── Seizoen 2022-2023 ──
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '34d80d7f-1327-4839-8dec-889398b9737b', '7f16160c-5442-4536-86b4-52276f033840', 12, 12, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=12, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'DE BAKKER Toon'), '7f16160c-5442-4536-86b4-52276f033840', 2, 2, 0, 1, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=2, gewisseld=0, keeper_games=1;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '3157eb62-2322-4ec4-af2f-f00136e99a50', '7f16160c-5442-4536-86b4-52276f033840', 10, 10, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=10, gespeeld=10, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'db232b7c-aa0f-4295-b87a-ea5db2338730', '7f16160c-5442-4536-86b4-52276f033840', 14, 13, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=13, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', '7f16160c-5442-4536-86b4-52276f033840', 9, 9, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=9, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '08d42ab8-69da-488f-9553-4bab95fd89e4', '7f16160c-5442-4536-86b4-52276f033840', 19, 18, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=19, gespeeld=18, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd0a7948c-a298-451d-8903-d70938e4d4c3', '7f16160c-5442-4536-86b4-52276f033840', 8, 8, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=8, gespeeld=8, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'DEBAENST Gilles'), '7f16160c-5442-4536-86b4-52276f033840', 1, 1, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '46e7f9db-b122-4111-a3e8-969af745d315', '7f16160c-5442-4536-86b4-52276f033840', 15, 15, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=15, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '75aec47d-812c-4899-a8db-2b64a43ef098', '7f16160c-5442-4536-86b4-52276f033840', 19, 19, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=19, gespeeld=19, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '7f16160c-5442-4536-86b4-52276f033840', 19, 12, 4, 1, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=19, gespeeld=12, gewisseld=4, keeper_games=1;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'e7e35450-49ae-4cc2-80cb-35c4b406f478', '7f16160c-5442-4536-86b4-52276f033840', 4, 4, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '7f16160c-5442-4536-86b4-52276f033840', 6, 4, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=6, gespeeld=4, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '83edb0c0-8198-48d4-8d24-ae7554553be9', '7f16160c-5442-4536-86b4-52276f033840', 12, 12, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=12, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6f340559-30b0-4ea3-af31-3ca707e51315', '7f16160c-5442-4536-86b4-52276f033840', 3, 3, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '7f16160c-5442-4536-86b4-52276f033840', 21, 21, 0, 21, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=21, gespeeld=21, gewisseld=0, keeper_games=21;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '4ee424fc-e545-4ca2-8bbc-c516edec4f3d', '7f16160c-5442-4536-86b4-52276f033840', 4, 4, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2995e934-f5a4-4076-ae32-0e02728e600a', '7f16160c-5442-4536-86b4-52276f033840', 16, 16, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=16, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', '7f16160c-5442-4536-86b4-52276f033840', 17, 17, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=17, gespeeld=17, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '7f16160c-5442-4536-86b4-52276f033840', 15, 14, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=14, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'c7c8347b-f2fb-44b4-8135-87dd9e62f0f8', '7f16160c-5442-4536-86b4-52276f033840', 7, 7, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=7, gespeeld=7, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '55db8337-8403-4495-a3aa-ce85cf614885', '7f16160c-5442-4536-86b4-52276f033840', 10, 10, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=10, gespeeld=10, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VANLERBERGHE Jens'), '7f16160c-5442-4536-86b4-52276f033840', 3, 0, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=0, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '7f16160c-5442-4536-86b4-52276f033840', 17, 13, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=17, gespeeld=13, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd45fb0a6-6b26-4271-aa16-c02c88b28c22', '7f16160c-5442-4536-86b4-52276f033840', 8, 8, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=8, gespeeld=8, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '7f16160c-5442-4536-86b4-52276f033840', 19, 19, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=19, gespeeld=19, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '38d0b8c9-7c17-4392-a492-b95943248244', '7f16160c-5442-4536-86b4-52276f033840', 17, 16, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=17, gespeeld=16, gewisseld=4, keeper_games=0;

-- ── Seizoen 2023-2024 ──
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '34d80d7f-1327-4839-8dec-889398b9737b', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 15, 15, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=15, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '5635a8d2-aa63-484f-beaa-11dc99deda52', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 5, 5, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=5, gespeeld=5, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '3157eb62-2322-4ec4-af2f-f00136e99a50', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 13, 13, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=13, gespeeld=13, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'db232b7c-aa0f-4295-b87a-ea5db2338730', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 10, 10, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=10, gespeeld=10, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 10, 5, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=10, gespeeld=5, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '08d42ab8-69da-488f-9553-4bab95fd89e4', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 17, 17, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=17, gespeeld=17, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd0a7948c-a298-451d-8903-d70938e4d4c3', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 5, 5, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=5, gespeeld=5, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '46e7f9db-b122-4111-a3e8-969af745d315', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 17, 17, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=17, gespeeld=17, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '75aec47d-812c-4899-a8db-2b64a43ef098', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 14, 12, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=12, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a944e010-ad35-44b7-9cef-86ca443fd246', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 7, 4, 0, 4, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=7, gespeeld=4, gewisseld=0, keeper_games=4;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 2, 2, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=2, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'e7e35450-49ae-4cc2-80cb-35c4b406f478', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 5, 2, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=5, gespeeld=2, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '97e2bbf6-eb60-4cc8-a2d6-cbd024134689', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 6, 6, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=6, gespeeld=6, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 5, 3, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=5, gespeeld=3, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '7d0b29e3-a680-4343-9fe1-dba2d35f64c0', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 3, 3, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '83edb0c0-8198-48d4-8d24-ae7554553be9', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 10, 9, 3, 1, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=10, gespeeld=9, gewisseld=3, keeper_games=1;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 14, 13, 0, 13, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=13, gewisseld=0, keeper_games=13;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2995e934-f5a4-4076-ae32-0e02728e600a', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 12, 12, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=12, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 13, 8, 4, 1, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=13, gespeeld=8, gewisseld=4, keeper_games=1;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 11, 9, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=11, gespeeld=9, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '55db8337-8403-4495-a3aa-ce85cf614885', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 10, 10, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=10, gespeeld=10, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VANLERBERGHE Jens'), '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 3, 0, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=0, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 16, 16, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=16, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd45fb0a6-6b26-4271-aa16-c02c88b28c22', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 4, 4, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 16, 16, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=16, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '38d0b8c9-7c17-4392-a492-b95943248244', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 16, 16, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=16, gewisseld=1, keeper_games=0;

-- ── Seizoen 2024-2025 ──
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '34d80d7f-1327-4839-8dec-889398b9737b', '344ee973-7186-4486-b314-82cdf1456c59', 17, 17, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=17, gespeeld=17, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '5635a8d2-aa63-484f-beaa-11dc99deda52', '344ee973-7186-4486-b314-82cdf1456c59', 1, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2c485bc2-47e8-4df0-a554-da9bf63c4d67', '344ee973-7186-4486-b314-82cdf1456c59', 11, 9, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=11, gespeeld=9, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '3157eb62-2322-4ec4-af2f-f00136e99a50', '344ee973-7186-4486-b314-82cdf1456c59', 12, 10, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=10, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'db232b7c-aa0f-4295-b87a-ea5db2338730', '344ee973-7186-4486-b314-82cdf1456c59', 16, 15, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=15, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', '344ee973-7186-4486-b314-82cdf1456c59', 13, 10, 2, 1, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=13, gespeeld=10, gewisseld=2, keeper_games=1;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '08d42ab8-69da-488f-9553-4bab95fd89e4', '344ee973-7186-4486-b314-82cdf1456c59', 18, 18, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=18, gespeeld=18, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd0a7948c-a298-451d-8903-d70938e4d4c3', '344ee973-7186-4486-b314-82cdf1456c59', 1, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '46e7f9db-b122-4111-a3e8-969af745d315', '344ee973-7186-4486-b314-82cdf1456c59', 17, 17, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=17, gespeeld=17, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '3302401e-bca1-4829-bccd-ca90c6534d78', '344ee973-7186-4486-b314-82cdf1456c59', 14, 14, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=14, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '75aec47d-812c-4899-a8db-2b64a43ef098', '344ee973-7186-4486-b314-82cdf1456c59', 9, 4, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=4, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a944e010-ad35-44b7-9cef-86ca443fd246', '344ee973-7186-4486-b314-82cdf1456c59', 8, 6, 0, 6, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=8, gespeeld=6, gewisseld=0, keeper_games=6;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '1f1958d7-66be-44f3-bca8-ec69c9d00f8c', '344ee973-7186-4486-b314-82cdf1456c59', 3, 3, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '344ee973-7186-4486-b314-82cdf1456c59', 14, 13, 4, 1, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=13, gewisseld=4, keeper_games=1;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '7662b497-bd4a-4068-b238-c36624dbe58d', '344ee973-7186-4486-b314-82cdf1456c59', 14, 13, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=13, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'f6ca1a0c-0eb8-4dd8-babd-3202aa86d92a', '344ee973-7186-4486-b314-82cdf1456c59', 12, 11, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=11, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '344ee973-7186-4486-b314-82cdf1456c59', 4, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'THOEN Nathan'), '344ee973-7186-4486-b314-82cdf1456c59', 1, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '344ee973-7186-4486-b314-82cdf1456c59', 8, 8, 0, 8, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=8, gespeeld=8, gewisseld=0, keeper_games=8;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '4ee424fc-e545-4ca2-8bbc-c516edec4f3d', '344ee973-7186-4486-b314-82cdf1456c59', 1, 1, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=1, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2995e934-f5a4-4076-ae32-0e02728e600a', '344ee973-7186-4486-b314-82cdf1456c59', 18, 18, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=18, gespeeld=18, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', '344ee973-7186-4486-b314-82cdf1456c59', 17, 12, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=17, gespeeld=12, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VAN DER AUWERA Stijn'), '344ee973-7186-4486-b314-82cdf1456c59', 4, 4, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '344ee973-7186-4486-b314-82cdf1456c59', 7, 6, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=7, gespeeld=6, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '55db8337-8403-4495-a3aa-ce85cf614885', '344ee973-7186-4486-b314-82cdf1456c59', 8, 8, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=8, gespeeld=8, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'e5270f79-ad7d-44ee-a1ce-d96ba66f490b', '344ee973-7186-4486-b314-82cdf1456c59', 16, 16, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=16, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VANLERBERGHE Jens'), '344ee973-7186-4486-b314-82cdf1456c59', 1, 0, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=0, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '344ee973-7186-4486-b314-82cdf1456c59', 18, 14, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=18, gespeeld=14, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd45fb0a6-6b26-4271-aa16-c02c88b28c22', '344ee973-7186-4486-b314-82cdf1456c59', 8, 8, 0, 7, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=8, gespeeld=8, gewisseld=0, keeper_games=7;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '344ee973-7186-4486-b314-82cdf1456c59', 20, 20, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=20, gespeeld=20, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '38d0b8c9-7c17-4392-a492-b95943248244', '344ee973-7186-4486-b314-82cdf1456c59', 16, 16, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=16, gewisseld=5, keeper_games=0;

-- ── Seizoen 2025-2026 ──
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '34d80d7f-1327-4839-8dec-889398b9737b', '4c55ecd2-206a-4593-973e-7da184008077', 9, 9, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=9, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2c485bc2-47e8-4df0-a554-da9bf63c4d67', '4c55ecd2-206a-4593-973e-7da184008077', 1, 0, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=1, gespeeld=0, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '3157eb62-2322-4ec4-af2f-f00136e99a50', '4c55ecd2-206a-4593-973e-7da184008077', 4, 3, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=3, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'db232b7c-aa0f-4295-b87a-ea5db2338730', '4c55ecd2-206a-4593-973e-7da184008077', 12, 12, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=12, gespeeld=12, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', '4c55ecd2-206a-4593-973e-7da184008077', 9, 9, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=9, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '08d42ab8-69da-488f-9553-4bab95fd89e4', '4c55ecd2-206a-4593-973e-7da184008077', 18, 18, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=18, gespeeld=18, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'ff2eccf5-dd9d-4504-835c-04015695758e', '4c55ecd2-206a-4593-973e-7da184008077', 6, 6, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=6, gespeeld=6, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '46e7f9db-b122-4111-a3e8-969af745d315', '4c55ecd2-206a-4593-973e-7da184008077', 14, 14, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=14, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '3302401e-bca1-4829-bccd-ca90c6534d78', '4c55ecd2-206a-4593-973e-7da184008077', 14, 12, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=12, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '75aec47d-812c-4899-a8db-2b64a43ef098', '4c55ecd2-206a-4593-973e-7da184008077', 13, 13, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=13, gespeeld=13, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a944e010-ad35-44b7-9cef-86ca443fd246', '4c55ecd2-206a-4593-973e-7da184008077', 6, 1, 0, 1, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=6, gespeeld=1, gewisseld=0, keeper_games=1;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'ae6aca04-8285-4c31-bf0d-745275a89acf', '4c55ecd2-206a-4593-973e-7da184008077', 15, 15, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=15, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '1f1958d7-66be-44f3-bca8-ec69c9d00f8c', '4c55ecd2-206a-4593-973e-7da184008077', 4, 4, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '4c55ecd2-206a-4593-973e-7da184008077', 9, 7, 4, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=7, gewisseld=4, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '7662b497-bd4a-4068-b238-c36624dbe58d', '4c55ecd2-206a-4593-973e-7da184008077', 14, 13, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=14, gespeeld=13, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'f6ca1a0c-0eb8-4dd8-babd-3202aa86d92a', '4c55ecd2-206a-4593-973e-7da184008077', 13, 12, 5, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=13, gespeeld=12, gewisseld=5, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '4c55ecd2-206a-4593-973e-7da184008077', 9, 7, 3, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=9, gespeeld=7, gewisseld=3, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '83edb0c0-8198-48d4-8d24-ae7554553be9', '4c55ecd2-206a-4593-973e-7da184008077', 3, 3, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=3, gespeeld=3, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '4c55ecd2-206a-4593-973e-7da184008077', 19, 19, 0, 19, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=19, gespeeld=19, gewisseld=0, keeper_games=19;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2995e934-f5a4-4076-ae32-0e02728e600a', '4c55ecd2-206a-4593-973e-7da184008077', 4, 4, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=4, gespeeld=4, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', '4c55ecd2-206a-4593-973e-7da184008077', 13, 13, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=13, gespeeld=13, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '4c55ecd2-206a-4593-973e-7da184008077', 6, 4, 1, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=6, gespeeld=4, gewisseld=1, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '55db8337-8403-4495-a3aa-ce85cf614885', '4c55ecd2-206a-4593-973e-7da184008077', 7, 6, 2, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=7, gespeeld=6, gewisseld=2, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'e5270f79-ad7d-44ee-a1ce-d96ba66f490b', '4c55ecd2-206a-4593-973e-7da184008077', 15, 15, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=15, gespeeld=15, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT (SELECT id FROM players WHERE naam = 'VANLERBERGHE Jens'), '4c55ecd2-206a-4593-973e-7da184008077', 5, 0, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=5, gespeeld=0, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '4c55ecd2-206a-4593-973e-7da184008077', 17, 16, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=17, gespeeld=16, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT 'd45fb0a6-6b26-4271-aa16-c02c88b28c22', '4c55ecd2-206a-4593-973e-7da184008077', 2, 1, 0, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=2, gespeeld=1, gewisseld=0, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '4c55ecd2-206a-4593-973e-7da184008077', 16, 16, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=16, gewisseld=6, keeper_games=0;
INSERT INTO historical_season_stats (player_id, season_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm)
SELECT '38d0b8c9-7c17-4392-a492-b95943248244', '4c55ecd2-206a-4593-973e-7da184008077', 16, 16, 6, 0, 0, 0, 0, 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  aanwezig=16, gespeeld=16, gewisseld=6, keeper_games=0;
