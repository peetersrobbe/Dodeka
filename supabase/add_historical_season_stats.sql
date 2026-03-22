-- ═══════════════════════════════════════════════════════════════
-- Migratie: historical_season_stats tabel + historische data
-- Voer uit NA stats_2025_2026.sql
-- ═══════════════════════════════════════════════════════════════

-- Maak nieuwe tabel aan
CREATE TABLE IF NOT EXISTS historical_season_stats (
  id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  player_id    UUID REFERENCES players(id) ON DELETE CASCADE,
  season_id    UUID REFERENCES seasons(id) ON DELETE CASCADE,
  doelpunten   INT NOT NULL DEFAULT 0,
  assists      INT NOT NULL DEFAULT 0,
  gele_kaarten INT NOT NULL DEFAULT 0,
  motm         INT NOT NULL DEFAULT 0,
  UNIQUE (player_id, season_id)
);

-- RLS: alleen ingelogde gebruikers mogen lezen; alleen admins mogen schrijven
ALTER TABLE historical_season_stats ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth_read"   ON historical_season_stats FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "admin_write" ON historical_season_stats FOR ALL    USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));

-- Verwijder bestaande data (voor herhaald uitvoeren)
DELETE FROM historical_season_stats;

-- ── Historische seizoenstotalen (2017-2025, uit Excel STATS sheets) ──

-- 2017-2018
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('15db9494-71e6-4634-9c92-7b16cf7a92a2', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 7, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=7, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('874b5274-91d3-42c8-8223-fd30d927033e', '75aec47d-812c-4899-a8db-2b64a43ef098', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 6, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=6, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('ed14449b-081d-4ff8-a014-dc2ee8c6fef9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 4, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=4, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('0ba450d0-fe88-40f2-9828-34bc98913877', 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 3, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('a4ee28bb-9c89-4151-b3a8-22c2fe14df3b', 'db232b7c-aa0f-4295-b87a-ea5db2338730', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 2, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('d43df28a-8461-4b93-a220-a7297d509cc3', '46e7f9db-b122-4111-a3e8-969af745d315', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 2, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('18c08b7b-6468-4629-a2ad-ecd87d3df756', '6f340559-30b0-4ea3-af31-3ca707e51315', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 2, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('6d832217-eda3-4ab0-9cda-cd7186508fc8', 'dad289c4-fc5d-43bd-aeaa-8c5a87273764', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 2, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('7b537bed-a3ae-40b0-8ed7-52c429c30504', 'b04ed76b-4e28-49fd-a0b4-39e8243a54a0', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 1, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('6fe2c085-cc53-4c29-b1d5-118081e529a6', 'ec83d2d1-1cf1-46ad-ae97-d17a63d532e3', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 0, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('c665e199-9e1d-490b-bb6f-9d698698a0f1', '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 0, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('7e0d9d59-51a4-49d9-8105-3ead2d19fa22', 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '521a8c8a-2c7e-437d-b221-3586a9816c4e', 0, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=1, motm=0;

-- 2018-2019
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('ec0a167d-4c4f-4e3e-8841-4ecc20e29700', '75aec47d-812c-4899-a8db-2b64a43ef098', 'd7353430-0e3b-4d52-8929-589bb68d6678', 6, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=6, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('c6942f3b-5fb7-4b98-a69f-db1fb41b56a5', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', 'd7353430-0e3b-4d52-8929-589bb68d6678', 4, 2, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=4, assists=2, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('4185993a-12b8-4f73-ace5-e9c94e749419', '46e7f9db-b122-4111-a3e8-969af745d315', 'd7353430-0e3b-4d52-8929-589bb68d6678', 3, 3, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=3, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('9073feac-c1ab-47f4-a643-bc5783212933', '6f340559-30b0-4ea3-af31-3ca707e51315', 'd7353430-0e3b-4d52-8929-589bb68d6678', 2, 3, 3, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=3, gele_kaarten=3, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('d488631e-6f66-4262-96bf-8f3503a2cd15', 'db232b7c-aa0f-4295-b87a-ea5db2338730', 'd7353430-0e3b-4d52-8929-589bb68d6678', 0, 4, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=4, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('6d2e78b5-079e-4de1-b3fa-e35bcea6dc98', '08d42ab8-69da-488f-9553-4bab95fd89e4', 'd7353430-0e3b-4d52-8929-589bb68d6678', 2, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('50f32093-6309-4dba-b7bd-98ff7744d936', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'd7353430-0e3b-4d52-8929-589bb68d6678', 1, 2, 3, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=2, gele_kaarten=3, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('0f0c686e-e103-44eb-a424-2e2180abbfce', '76cfff9b-0e78-4c71-94aa-2c62c8f50107', 'd7353430-0e3b-4d52-8929-589bb68d6678', 3, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('60a82714-baf3-4f42-8ddf-3663dd781e09', 'b368cd89-d75e-4d9e-9033-e1257f856bd2', 'd7353430-0e3b-4d52-8929-589bb68d6678', 2, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('2044728d-2e27-4509-a53c-5ea188d7094b', '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', 'd7353430-0e3b-4d52-8929-589bb68d6678', 2, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('a1ffbd5a-7955-4709-8a7c-7159c2dfee52', 'dad289c4-fc5d-43bd-aeaa-8c5a87273764', 'd7353430-0e3b-4d52-8929-589bb68d6678', 1, 1, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=1, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('eb26f784-912f-4805-b94e-36323bcdbde9', 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', 'd7353430-0e3b-4d52-8929-589bb68d6678', 1, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('718b6cba-256e-46ee-b42b-64ebd80d08d6', 'feb5a1e3-c509-4833-aacf-4d70aae2f260', 'd7353430-0e3b-4d52-8929-589bb68d6678', 0, 2, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=2, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('686db297-f7b6-4992-ad0a-6be5f16cbdf0', '38d0b8c9-7c17-4392-a492-b95943248244', 'd7353430-0e3b-4d52-8929-589bb68d6678', 1, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('15166645-afa6-4f67-a959-35bbe7ee5374', '34d80d7f-1327-4839-8dec-889398b9737b', 'd7353430-0e3b-4d52-8929-589bb68d6678', 0, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('94058850-dd39-482e-9ba8-ad2c43757527', '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', 'd7353430-0e3b-4d52-8929-589bb68d6678', 0, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('ea896165-7ffd-4255-a4ab-510985d03fa7', 'ec83d2d1-1cf1-46ad-ae97-d17a63d532e3', 'd7353430-0e3b-4d52-8929-589bb68d6678', 0, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=1, motm=0;

-- 2019-2020
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('49800fbe-fb6a-424f-8a8b-c05596f832b2', '75aec47d-812c-4899-a8db-2b64a43ef098', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 10, 3, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=10, assists=3, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('37bbb8d5-5711-4c03-af93-96210ea86da9', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 6, 4, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=6, assists=4, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('543bbb79-c92b-4924-ba3c-26ecf19f6868', '38d0b8c9-7c17-4392-a492-b95943248244', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 9, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=9, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('2a8ce920-2bcd-4a1e-91c8-9b0961210965', 'feb5a1e3-c509-4833-aacf-4d70aae2f260', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 1, 4, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=4, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('4d72eab9-1afd-4291-a7b7-ba02a34fcad1', 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 4, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=4, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('260d6630-5ca6-478b-934e-c259bc399433', 'db232b7c-aa0f-4295-b87a-ea5db2338730', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 1, 3, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=3, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('3c961e33-540d-44b9-95be-815c0cd1f54b', 'e7e35450-49ae-4cc2-80cb-35c4b406f478', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 2, 2, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=2, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('e71bbb88-ffca-43c9-be62-cd796af9d76e', '34d80d7f-1327-4839-8dec-889398b9737b', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 1, 2, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=2, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('b2328e3e-8cf0-4ad0-b0b8-3cd404bc3aad', '2995e934-f5a4-4076-ae32-0e02728e600a', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 1, 2, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=2, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('a5fb953c-e817-4b48-a8c3-40530ec72221', '46e7f9db-b122-4111-a3e8-969af745d315', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 1, 1, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=1, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('72a9ddde-ad69-4d49-8bff-dbf6ecaa60cd', '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 0, 2, 2, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=2, gele_kaarten=2, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('d2b7f932-a008-488f-8595-4d2aff8b427c', '08d42ab8-69da-488f-9553-4bab95fd89e4', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 0, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('004a5b78-a7ca-4aec-ab76-ad5757be6a29', 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 0, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('295d2d2d-3cc2-4af7-ba9e-431179233825', '19792ac8-88f6-4a8b-9868-3b0b7184ae85', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 0, 1, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=1, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('13533225-0364-4f6c-8d4a-a0467848521f', '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '84be4ead-cb97-450b-a79f-c3f37f4c404d', 0, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=1, motm=0;

-- 2020-2021
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('72eec99b-791d-4aae-bf64-a1ffe04460df', '38d0b8c9-7c17-4392-a492-b95943248244', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 5, 2, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=5, assists=2, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('cbd4fdd8-062d-4d3a-8319-34a370ad8652', '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 2, 4, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=4, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('2c764d51-b784-4286-a57e-a3266fc5b242', 'db232b7c-aa0f-4295-b87a-ea5db2338730', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 3, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('60c1a2bf-a6f6-4d4b-8fae-060c07f6a4fb', '55db8337-8403-4495-a3aa-ce85cf614885', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 2, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('fd7847b5-a075-4e58-97f0-cecf7d2596f3', '75aec47d-812c-4899-a8db-2b64a43ef098', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 1, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('b836057d-f8d5-42df-bf41-abeb8f79dee3', '02ef13da-4f05-45da-9cd0-d62c0cc16f51', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 1, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('ca4f8481-e34e-4308-b4ea-996595b8a800', '08d42ab8-69da-488f-9553-4bab95fd89e4', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 0, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('736d8a95-5161-43c2-9ee9-04054169d76a', 'feb5a1e3-c509-4833-aacf-4d70aae2f260', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 0, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('5da8204d-799c-4d68-b610-7512fd9c4d1c', 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', '03814ec7-8f01-4709-a8f9-e473a76d1e86', 0, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=1, motm=0;

-- 2021-2022
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('1c210029-396f-454e-8c8a-8861b8c97eb5', '75aec47d-812c-4899-a8db-2b64a43ef098', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 8, 4, 1, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=8, assists=4, gele_kaarten=1, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('98cdba0f-365f-456b-8d03-0aebd6620080', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 9, 3, 1, 3)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=9, assists=3, gele_kaarten=1, motm=3;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('ea1269fc-e315-4123-bf11-4bef778be5b7', '38d0b8c9-7c17-4392-a492-b95943248244', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 6, 5, 2, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=6, assists=5, gele_kaarten=2, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('b21513ad-0f83-48a6-aef2-1c012089d740', 'feb5a1e3-c509-4833-aacf-4d70aae2f260', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 3, 5, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=5, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('df794edc-2c47-4e07-b213-183f3b6d00e2', '4ee424fc-e545-4ca2-8bbc-c516edec4f3d', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 3, 2, 2, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=2, gele_kaarten=2, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('ba2b0fb9-27d8-497a-9ae6-1ab0334f7e8e', 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 2, 2, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=2, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('e4b54501-9738-4386-af73-d208697e0982', '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 3, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('2a24d46a-403b-45f4-bb76-081bb70341c5', 'db232b7c-aa0f-4295-b87a-ea5db2338730', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 1, 2, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=2, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('6d78cd06-0d7f-4e66-8d5e-e2440a7c8fc9', '55db8337-8403-4495-a3aa-ce85cf614885', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 0, 2, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=2, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('eb037ea9-05f5-4438-9ae9-20b8ea594ea0', 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 0, 2, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=2, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('7da94548-2d19-4d7d-99b4-2aa3ddc1d44a', '08d42ab8-69da-488f-9553-4bab95fd89e4', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 1, 0, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('cccc36d7-a18c-4a3c-815c-50b66f00e5f6', '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 1, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('3e97763c-628a-4bc1-adc5-4fb66046ef32', 'c7c8347b-f2fb-44b4-8135-87dd9e62f0f8', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 0, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('532e9e2d-9807-4612-b07f-8d54393cc63b', '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 0, 0, 2, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=2, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('4850ee14-4898-48fe-bfdc-1c754d3ea67f', 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 0, 0, 0, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('6ca1f88b-deb3-47f4-9687-9ce7aa28cad0', 'd45fb0a6-6b26-4271-aa16-c02c88b28c22', '9da86047-721f-4fd5-803f-b0ce0c1f4049', 0, 0, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=1;

-- 2022-2023
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('10cd27c8-831c-4a5a-bc76-070a3bb215df', '08d42ab8-69da-488f-9553-4bab95fd89e4', '7f16160c-5442-4536-86b4-52276f033840', 9, 8, 1, 3)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=9, assists=8, gele_kaarten=1, motm=3;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('618c8fd8-5f6e-4f2d-9d43-f8978476132c', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '7f16160c-5442-4536-86b4-52276f033840', 5, 9, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=5, assists=9, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('9c3390db-6ed7-4d4f-8ddb-cec209822d5a', '38d0b8c9-7c17-4392-a492-b95943248244', '7f16160c-5442-4536-86b4-52276f033840', 5, 5, 2, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=5, assists=5, gele_kaarten=2, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('75f4ffe6-bc75-4649-92e1-bdd48ed846bb', '75aec47d-812c-4899-a8db-2b64a43ef098', '7f16160c-5442-4536-86b4-52276f033840', 7, 2, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=7, assists=2, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('90c7809c-b86f-4b25-b272-c20b4746bc0c', 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '7f16160c-5442-4536-86b4-52276f033840', 7, 0, 0, 3)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=7, assists=0, gele_kaarten=0, motm=3;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('4c20ddef-ef0e-4001-a094-2d07d8dd4ba7', '55db8337-8403-4495-a3aa-ce85cf614885', '7f16160c-5442-4536-86b4-52276f033840', 3, 4, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=4, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('d452ea3e-db05-4d18-ae69-792b4e041173', 'db232b7c-aa0f-4295-b87a-ea5db2338730', '7f16160c-5442-4536-86b4-52276f033840', 3, 3, 2, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=3, gele_kaarten=2, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('2c4f208b-2126-4549-badb-53e09c44084f', 'd0a7948c-a298-451d-8903-d70938e4d4c3', '7f16160c-5442-4536-86b4-52276f033840', 2, 2, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=2, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('c642784a-8565-4fc1-85e6-8988af83fcdc', '34d80d7f-1327-4839-8dec-889398b9737b', '7f16160c-5442-4536-86b4-52276f033840', 2, 1, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=1, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('6334baa2-fb46-4a83-a7ed-feefc26cc070', '2995e934-f5a4-4076-ae32-0e02728e600a', '7f16160c-5442-4536-86b4-52276f033840', 0, 3, 3, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=3, gele_kaarten=3, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('23deaeb1-dfa9-4aa6-9f8c-c5737b7698a5', '4ee424fc-e545-4ca2-8bbc-c516edec4f3d', '7f16160c-5442-4536-86b4-52276f033840', 0, 3, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=3, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('733e6c31-7a6e-43b9-8f45-907426e734c4', '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '7f16160c-5442-4536-86b4-52276f033840', 1, 0, 3, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=3, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('49363b05-e578-41eb-9db1-9bbe26d2bcba', '6f340559-30b0-4ea3-af31-3ca707e51315', '7f16160c-5442-4536-86b4-52276f033840', 1, 0, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('57021105-3da5-468c-afce-4236f2b19c80', '3157eb62-2322-4ec4-af2f-f00136e99a50', '7f16160c-5442-4536-86b4-52276f033840', 1, 0, 1, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=1, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('0fa64ab6-fd1e-4cf5-9d5b-0d36e36fceee', 'e7e35450-49ae-4cc2-80cb-35c4b406f478', '7f16160c-5442-4536-86b4-52276f033840', 1, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('1c06c529-0785-496b-9a82-ad2f95625807', '46e7f9db-b122-4111-a3e8-969af745d315', '7f16160c-5442-4536-86b4-52276f033840', 0, 1, 4, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=1, gele_kaarten=4, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('49a709b1-634e-4b1c-aeab-f0726db471c4', '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '7f16160c-5442-4536-86b4-52276f033840', 0, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('4b375ae5-2e9f-4065-9c6c-98efada038a9', 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '7f16160c-5442-4536-86b4-52276f033840', 0, 0, 0, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('1c9daa13-46ee-44f8-a7bf-c4790bb388cf', '83edb0c0-8198-48d4-8d24-ae7554553be9', '7f16160c-5442-4536-86b4-52276f033840', 0, 0, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('617a071e-a604-4316-a0e0-3ebd4fbe42c8', '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '7f16160c-5442-4536-86b4-52276f033840', 0, 0, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=1;

-- 2023-2024
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('3b70e42e-95f2-4c34-b613-a41cb7769f33', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 13, 9, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=13, assists=9, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('2dfc1082-5249-48f0-9b7d-e72c5e358022', '08d42ab8-69da-488f-9553-4bab95fd89e4', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 7, 10, 2, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=7, assists=10, gele_kaarten=2, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('9adb6364-df3a-4fe5-a663-5fe6cbab4529', '75aec47d-812c-4899-a8db-2b64a43ef098', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 10, 0, 0, 3)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=10, assists=0, gele_kaarten=0, motm=3;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('3f18079f-555e-4606-8406-20bbaa33ca3d', 'db232b7c-aa0f-4295-b87a-ea5db2338730', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 3, 6, 2, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=6, gele_kaarten=2, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('18621747-e69f-47a7-adc0-291f0b889d24', 'd0a7948c-a298-451d-8903-d70938e4d4c3', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 6, 0, 0, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=6, assists=0, gele_kaarten=0, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('fd5ac35f-695b-439c-8b7b-bbb853e239e0', '3157eb62-2322-4ec4-af2f-f00136e99a50', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 4, 2, 3, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=4, assists=2, gele_kaarten=3, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('99d59611-9e48-43ce-818b-94e824b5f6ab', '34d80d7f-1327-4839-8dec-889398b9737b', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 1, 4, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=4, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('289a4a5b-c4b5-4c54-bb67-48a51bbadcd7', '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 3, 1, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=1, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('94a8051e-a3b2-41ff-a70a-ff70c67d06c0', '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 2, 1, 1, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=1, gele_kaarten=1, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('fdb1c8fb-ea41-4573-85fa-5de230157080', '38d0b8c9-7c17-4392-a492-b95943248244', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 1, 1, 1, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=1, gele_kaarten=1, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('5d3aece2-0e00-4794-9d3f-6690e6508670', '55db8337-8403-4495-a3aa-ce85cf614885', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 1, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('9968e9cd-67b8-4928-ab27-1b8ce295c74f', '97e2bbf6-eb60-4cc8-a2d6-cbd024134689', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 0, 2, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=2, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('126e82bb-acff-4ca4-a1eb-22ed02f42c61', '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 1, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('4ecf343b-201d-4795-8b08-75a963c8083c', '2995e934-f5a4-4076-ae32-0e02728e600a', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 1, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('b72b5db2-a7c5-4ae7-9d37-e4ba7b12eccf', '46e7f9db-b122-4111-a3e8-969af745d315', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 0, 1, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=1, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('65363770-564e-4fd0-a118-6f2ed7d0ec30', 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 0, 1, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=1, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('771bffc7-3cd5-4a46-87ae-28fdec48b99c', '5635a8d2-aa63-484f-beaa-11dc99deda52', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 0, 0, 2, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=2, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('91ceb5ee-2208-4d99-be88-d6a608981974', 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 0, 0, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('e89f7f61-765e-48a1-b9a9-00931fee3e19', '83edb0c0-8198-48d4-8d24-ae7554553be9', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 0, 0, 0, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('ce682fb5-9d96-4945-b8f5-fa70dbc27260', '7d0b29e3-a680-4343-9fe1-dba2d35f64c0', '5c5bd0e8-09b8-41bb-9448-fd7e21efc162', 0, 0, 0, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=2;

-- 2024-2025
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('cb8a677d-a367-496b-96b4-8d7bf260e497', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', '344ee973-7186-4486-b314-82cdf1456c59', 4, 12, 1, 3)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=4, assists=12, gele_kaarten=1, motm=3;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('5283d0f1-305c-4c80-a33c-19abe596b2e3', '08d42ab8-69da-488f-9553-4bab95fd89e4', '344ee973-7186-4486-b314-82cdf1456c59', 6, 1, 3, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=6, assists=1, gele_kaarten=3, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('18d87234-c95c-4a43-a548-dd9c0749e117', 'db232b7c-aa0f-4295-b87a-ea5db2338730', '344ee973-7186-4486-b314-82cdf1456c59', 3, 4, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=4, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('78b3742d-51d7-4abc-aff0-ec10247cca54', '38d0b8c9-7c17-4392-a492-b95943248244', '344ee973-7186-4486-b314-82cdf1456c59', 2, 3, 1, 3)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=3, gele_kaarten=1, motm=3;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('b6930251-b3a9-4981-9e7b-950114b1e0bc', 'b368cd89-d75e-4d9e-9033-e1257f856bd2', '344ee973-7186-4486-b314-82cdf1456c59', 3, 1, 1, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=1, gele_kaarten=1, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('f46b844d-4ef8-4cf9-bb65-ecec6ca5fc09', '2995e934-f5a4-4076-ae32-0e02728e600a', '344ee973-7186-4486-b314-82cdf1456c59', 2, 2, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=2, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('1e4916ea-c884-4030-9450-ce706cadc7c8', 'f6ca1a0c-0eb8-4dd8-babd-3202aa86d92a', '344ee973-7186-4486-b314-82cdf1456c59', 3, 1, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=1, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('5af0fa1f-1db2-4282-a556-1b2e402b8216', '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', '344ee973-7186-4486-b314-82cdf1456c59', 2, 1, 2, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=1, gele_kaarten=2, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('4e013c60-1e4d-4d1a-b9c7-f2e133d77ebd', '55db8337-8403-4495-a3aa-ce85cf614885', '344ee973-7186-4486-b314-82cdf1456c59', 2, 1, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=2, assists=1, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('86fc2408-8caf-45e3-acb2-d3fb87794f8b', '34d80d7f-1327-4839-8dec-889398b9737b', '344ee973-7186-4486-b314-82cdf1456c59', 3, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=3, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('d9acc5e5-e8b2-40f3-aed3-97fcfbb2b5bc', '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', '344ee973-7186-4486-b314-82cdf1456c59', 1, 1, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=1, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('a5165bdd-84e8-40a0-96e3-5af0bdc0bcb2', '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', '344ee973-7186-4486-b314-82cdf1456c59', 1, 0, 0, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=0, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('f3813043-1b18-4e0b-893d-aec0ad564db9', '1f1958d7-66be-44f3-bca8-ec69c9d00f8c', '344ee973-7186-4486-b314-82cdf1456c59', 1, 0, 0, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=0, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('84a2a54c-156c-4fdc-9014-a43425fa8818', '7662b497-bd4a-4068-b238-c36624dbe58d', '344ee973-7186-4486-b314-82cdf1456c59', 1, 0, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('b5536868-e8e5-4b2b-ba81-5e061a297cf5', '3302401e-bca1-4829-bccd-ca90c6534d78', '344ee973-7186-4486-b314-82cdf1456c59', 1, 0, 1, 3)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=1, assists=0, gele_kaarten=1, motm=3;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('2b77d88a-4fe4-4e58-9cc2-512777691a69', '3157eb62-2322-4ec4-af2f-f00136e99a50', '344ee973-7186-4486-b314-82cdf1456c59', 0, 0, 1, 0)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=1, motm=0;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('c739ddbb-61b6-442b-a9e1-53140cb1028e', 'e5270f79-ad7d-44ee-a1ce-d96ba66f490b', '344ee973-7186-4486-b314-82cdf1456c59', 0, 0, 2, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=2, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('b38e1ffc-9bb1-408f-aebd-36004cd385e3', '2c485bc2-47e8-4df0-a554-da9bf63c4d67', '344ee973-7186-4486-b314-82cdf1456c59', 0, 0, 1, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=1, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('700c444e-13ff-44c7-addb-03f4fbaa1f0b', 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a', '344ee973-7186-4486-b314-82cdf1456c59', 0, 0, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('aee38ea9-7342-43bc-bf63-42b0b3d20834', 'd45fb0a6-6b26-4271-aa16-c02c88b28c22', '344ee973-7186-4486-b314-82cdf1456c59', 0, 0, 0, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=2;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('6746437a-903b-4d00-8ce9-2104c9ef6411', '6b321166-046b-44e4-8ebf-7e0a20b0fddd', '344ee973-7186-4486-b314-82cdf1456c59', 0, 0, 0, 1)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=1;
INSERT INTO historical_season_stats (id, player_id, season_id, doelpunten, assists, gele_kaarten, motm)
VALUES ('2a9a6808-6963-4f0e-b7f5-aa06874cf62b', 'a944e010-ad35-44b7-9cef-86ca443fd246', '344ee973-7186-4486-b314-82cdf1456c59', 0, 0, 0, 2)
ON CONFLICT (player_id, season_id) DO UPDATE SET doelpunten=0, assists=0, gele_kaarten=0, motm=2;

-- ── 2025-2026: berekend vanuit per-wedstrijd tabellen ──
-- (Voer stats_2025_2026.sql eerst uit!)
INSERT INTO historical_season_stats (player_id, season_id, doelpunten, assists, gele_kaarten, motm)
SELECT
  p.id AS player_id,
  '4c55ecd2-206a-4593-973e-7da184008077' AS season_id,
  COALESCE(d.doelpunten, 0) AS doelpunten,
  COALESCE(a.assists, 0)    AS assists,
  COALESCE(k.geel, 0)       AS gele_kaarten,
  COALESCE(m.motm, 0)       AS motm
FROM players p
LEFT JOIN (
  SELECT player_id, SUM(aantal) AS doelpunten
  FROM doelpunten WHERE match_id IN (SELECT id FROM matches WHERE season_id = '4c55ecd2-206a-4593-973e-7da184008077')
  GROUP BY player_id) d ON d.player_id = p.id
LEFT JOIN (
  SELECT player_id, SUM(aantal) AS assists
  FROM assists WHERE match_id IN (SELECT id FROM matches WHERE season_id = '4c55ecd2-206a-4593-973e-7da184008077')
  GROUP BY player_id) a ON a.player_id = p.id
LEFT JOIN (
  SELECT player_id, SUM(geel) AS geel
  FROM kaarten WHERE match_id IN (SELECT id FROM matches WHERE season_id = '4c55ecd2-206a-4593-973e-7da184008077')
  GROUP BY player_id) k ON k.player_id = p.id
LEFT JOIN (
  SELECT player_id, COUNT(*) AS motm
  FROM motm WHERE match_id IN (SELECT id FROM matches WHERE season_id = '4c55ecd2-206a-4593-973e-7da184008077')
  GROUP BY player_id) m ON m.player_id = p.id
WHERE COALESCE(d.doelpunten, 0) + COALESCE(a.assists, 0) + COALESCE(k.geel, 0) + COALESCE(m.motm, 0) > 0
ON CONFLICT (player_id, season_id) DO UPDATE SET
  doelpunten   = EXCLUDED.doelpunten,
  assists      = EXCLUDED.assists,
  gele_kaarten = EXCLUDED.gele_kaarten,
  motm         = EXCLUDED.motm;