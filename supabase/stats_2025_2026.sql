-- ═══════════════════════════════════════════════════════════════
-- Stats script: Doelpunten, Assists, Kaarten, MOTM  ·  2025-2026
-- Gegenereerd op basis van Excel-sheets
-- VEREISTE MIGRATIE: Voer eerst add_multiple_motm.sql uit!
-- ═══════════════════════════════════════════════════════════════

-- Verwijder bestaande stats voor 2025-2026 seizoen
DELETE FROM doelpunten WHERE match_id IN (
  SELECT id FROM matches WHERE season_id = '4c55ecd2-206a-4593-973e-7da184008077'
);
DELETE FROM assists WHERE match_id IN (
  SELECT id FROM matches WHERE season_id = '4c55ecd2-206a-4593-973e-7da184008077'
);
DELETE FROM kaarten WHERE match_id IN (
  SELECT id FROM matches WHERE season_id = '4c55ecd2-206a-4593-973e-7da184008077'
);
DELETE FROM motm WHERE match_id IN (
  SELECT id FROM matches WHERE season_id = '4c55ecd2-206a-4593-973e-7da184008077'
);

-- ── Doelpunten 2025-2026 ────────────────────────────────────────
-- Chossel Sport 2025-08-30
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('af857b3e-1052-478d-a44e-f1d5e2b6a772', '24fcdf61-3840-4274-b315-a287adbfbd50', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', 1);
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('b438ed1f-cee7-48ac-828d-2503b5d3dea7', '24fcdf61-3840-4274-b315-a287adbfbd50', '38d0b8c9-7c17-4392-a492-b95943248244', 1);

-- Bacchus 2025-09-06
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('8652038c-74ff-492f-ae9f-28808693357b', '3a33b2b2-c6dd-43af-b6d8-d308cbc5fbce', '34d80d7f-1327-4839-8dec-889398b9737b', 1);

-- Amber G 2025-09-20
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('31398555-0cf7-403c-993b-f134f34816fd', '62bf3933-8c5d-4256-8c12-334e716cd51a', '08d42ab8-69da-488f-9553-4bab95fd89e4', 1);
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('31e08d31-0910-4c23-8081-51989caab017', '62bf3933-8c5d-4256-8c12-334e716cd51a', '7662b497-bd4a-4068-b238-c36624dbe58d', 1);

-- Excelsior 81 2025-10-11
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('21d1c214-3a69-4d87-9494-a5de3922fb2f', 'd02b1d71-e5b5-4cb4-a5df-6ac2549a7afc', '75aec47d-812c-4899-a8db-2b64a43ef098', 1);

-- Sporting Olympia 2025-10-25
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('c35a7ce1-855d-4421-8fd0-e47364ab98d9', 'ab4a53df-80c0-40f8-8d86-e9e5346db90e', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', 1);
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('6264ff3d-87ce-4f20-8a8f-83f813c8ecc1', 'ab4a53df-80c0-40f8-8d86-e9e5346db90e', '34d80d7f-1327-4839-8dec-889398b9737b', 1);

-- Ruisbroek Next 2025-11-08
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('94d636f2-2e9c-43a5-8f4e-9ba2a1a91c5a', 'dbd417a8-ca4a-4a06-97e5-96df18382572', 'ae6aca04-8285-4c31-bf0d-745275a89acf', 2);

-- Sporting Olympia 2025-11-15
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('e9e90a21-9849-41a3-b395-c3da1e3a4773', 'a4aecfca-dba4-43f1-a1c5-4f16f03864bf', '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', 1);
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('70ac6eed-4462-4333-a0dd-9c040cfc48b8', 'a4aecfca-dba4-43f1-a1c5-4f16f03864bf', '1f1958d7-66be-44f3-bca8-ec69c9d00f8c', 1);

-- Kloosterstraat 2025-11-22
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('58c71969-9c58-485d-b657-4da40cdd6e90', '5c3e1254-664a-4bd4-bff9-3ffb8c15f613', '08d42ab8-69da-488f-9553-4bab95fd89e4', 1);
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('57212af7-df83-455b-87e0-b91477c358e2', '5c3e1254-664a-4bd4-bff9-3ffb8c15f613', '38d0b8c9-7c17-4392-a492-b95943248244', 1);
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('349952d9-f1fe-496f-8cd7-97895c516def', '5c3e1254-664a-4bd4-bff9-3ffb8c15f613', '4d88dc95-07bd-4461-be53-3a0cdb5bd43b', 1);

-- Bacchus 2025-12-06
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('4c7c51ab-a625-4512-9eb0-1f9f5e38aa2a', 'bccc8f0a-2a80-4e51-a16e-f86b0b87de6b', '08d42ab8-69da-488f-9553-4bab95fd89e4', 1);
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('cf6ff6d2-2cf7-45b3-b3f8-35fe39fdc3c7', 'bccc8f0a-2a80-4e51-a16e-f86b0b87de6b', '3302401e-bca1-4829-bccd-ca90c6534d78', 1);

-- OBB 2025-12-13
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('164331e3-ab3a-407e-b5a6-fa40b825e5c1', 'ab30b85e-593f-42f2-afc5-2f5489b6d8d7', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', 1);
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('b5faff3b-c60a-4cb1-8b03-5e9266445f33', 'ab30b85e-593f-42f2-afc5-2f5489b6d8d7', '38d0b8c9-7c17-4392-a492-b95943248244', 1);

-- AC De Heide 2026-01-24
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('5ab4358d-a4a5-4050-896c-b2cdb2b541ba', 'f5b8264d-ac96-4951-bf22-5c64e56b970f', 'ff2eccf5-dd9d-4504-835c-04015695758e', 3);
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('a2444a2e-848c-42f5-b7ec-d3f3201301a0', 'f5b8264d-ac96-4951-bf22-5c64e56b970f', '75aec47d-812c-4899-a8db-2b64a43ef098', 1);
-- EIGEN DOELPUNT (door tegenstander, 1x) - niet opgeslagen in doelpunten tabel

-- Excelsior 81 2026-01-31
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('7781395f-d512-436f-a309-5a1598925949', '3222c9d3-44e3-422f-b46a-782632122895', 'ae6aca04-8285-4c31-bf0d-745275a89acf', 1);
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('435399c3-454b-463f-a1b7-1ce339d449a2', '3222c9d3-44e3-422f-b46a-782632122895', '7662b497-bd4a-4068-b238-c36624dbe58d', 1);

-- Ruisbroek Next 2026-02-28
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('bb264e15-0b41-43f1-bd2d-7ff676862526', '26ac9b89-d480-4316-9ce2-4beedd600f0e', '08d42ab8-69da-488f-9553-4bab95fd89e4', 1);
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('3a95f73e-a290-4b5c-883e-73d55a7f3d1f', '26ac9b89-d480-4316-9ce2-4beedd600f0e', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', 1);

-- Kloosterstraat 2026-03-14
INSERT INTO doelpunten (id, match_id, player_id, aantal) VALUES ('24275c4b-55fa-4d93-9102-b6a8dddb4bb7', '372c4cd4-8442-4f09-aa26-f9142a892425', '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', 1);

-- ── Assists 2025-2026 ──────────────────────────────────────────
-- Chossel Sport 2025-08-30
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('da534c73-2df3-415f-98f1-ea9a51901046', '24fcdf61-3840-4274-b315-a287adbfbd50', '55db8337-8403-4495-a3aa-ce85cf614885', 1);
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('9b197469-0b89-49cc-b268-f812b658d7e9', '24fcdf61-3840-4274-b315-a287adbfbd50', '75aec47d-812c-4899-a8db-2b64a43ef098', 1);

-- Bacchus 2025-09-06
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('e7979a0e-af11-470c-ba11-f03d0616e804', '3a33b2b2-c6dd-43af-b6d8-d308cbc5fbce', '55db8337-8403-4495-a3aa-ce85cf614885', 1);

-- Excelsior 81 2025-10-11
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('55e358c1-f9b4-483f-909b-0ea74b7e4048', 'd02b1d71-e5b5-4cb4-a5df-6ac2549a7afc', 'f6ca1a0c-0eb8-4dd8-babd-3202aa86d92a', 1);

-- Sporting Olympia 2025-10-25
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('dcd3cb50-a777-4191-86d2-92808eea09bb', 'ab4a53df-80c0-40f8-8d86-e9e5346db90e', '55db8337-8403-4495-a3aa-ce85cf614885', 1);

-- Ruisbroek Next 2025-11-08
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('9b18a31b-a823-4cbc-874d-94d4d70a0cfc', 'dbd417a8-ca4a-4a06-97e5-96df18382572', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', 1);
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('d7dfeb16-0dc7-4e36-9c95-952538f3b78f', 'dbd417a8-ca4a-4a06-97e5-96df18382572', 'db232b7c-aa0f-4295-b87a-ea5db2338730', 1);

-- Sporting Olympia 2025-11-15
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('f3ddadad-db4c-4b50-8d2c-a24a3290b8b9', 'a4aecfca-dba4-43f1-a1c5-4f16f03864bf', '08d42ab8-69da-488f-9553-4bab95fd89e4', 1);
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('6012ef7d-dbcb-4c1e-9141-6c5e4466b7c3', 'a4aecfca-dba4-43f1-a1c5-4f16f03864bf', '38d0b8c9-7c17-4392-a492-b95943248244', 1);

-- Kloosterstraat 2025-11-22
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('18d0e3bc-8b55-47f8-81c5-41acf2182c5c', '5c3e1254-664a-4bd4-bff9-3ffb8c15f613', '75aec47d-812c-4899-a8db-2b64a43ef098', 1);
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('397a30cd-c6db-4e5a-9809-3e0f997631a9', '5c3e1254-664a-4bd4-bff9-3ffb8c15f613', '08d42ab8-69da-488f-9553-4bab95fd89e4', 1);

-- Bacchus 2025-12-06
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('24a5d915-dfe8-42b8-8c6e-91c0a39807d2', 'bccc8f0a-2a80-4e51-a16e-f86b0b87de6b', '75aec47d-812c-4899-a8db-2b64a43ef098', 1);

-- OBB 2025-12-13
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('3ad565ce-71e3-4629-9be3-5e450290347d', 'ab30b85e-593f-42f2-afc5-2f5489b6d8d7', '1f1958d7-66be-44f3-bca8-ec69c9d00f8c', 1);

-- AC De Heide 2026-01-24
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('292da8a5-fbf5-45a2-bc32-6422cb73fdef', 'f5b8264d-ac96-4951-bf22-5c64e56b970f', 'f6ca1a0c-0eb8-4dd8-babd-3202aa86d92a', 1);
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('701a0178-d172-4df5-b3fb-a644e83d86df', 'f5b8264d-ac96-4951-bf22-5c64e56b970f', '2dacb871-5105-4cb9-a30f-9fc2c7870ad3', 1);
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('77047845-86a8-4447-ac0c-a75b481226b8', 'f5b8264d-ac96-4951-bf22-5c64e56b970f', 'ff2eccf5-dd9d-4504-835c-04015695758e', 1);
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('a59991d9-d73a-48c0-9758-5852da40068e', 'f5b8264d-ac96-4951-bf22-5c64e56b970f', 'ae6aca04-8285-4c31-bf0d-745275a89acf', 1);
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('6221d2c5-7775-4424-a7bc-02d746147474', 'f5b8264d-ac96-4951-bf22-5c64e56b970f', '7662b497-bd4a-4068-b238-c36624dbe58d', 1);

-- Kloosterstraat 2026-03-14
INSERT INTO assists (id, match_id, player_id, aantal) VALUES ('69843be8-3a48-40f0-8509-b60d4eabbf78', '372c4cd4-8442-4f09-aa26-f9142a892425', 'f6ca1a0c-0eb8-4dd8-babd-3202aa86d92a', 1);

-- ── Kaarten 2025-2026 (geel) ──────────────────────────────────
-- Amber G 2025-09-20
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('aaef1c66-b51e-4e25-9bf2-0eabcf39f867', '62bf3933-8c5d-4256-8c12-334e716cd51a', '38d0b8c9-7c17-4392-a492-b95943248244', 1, 0);
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('4603a01d-bc6f-44a8-9b23-c3008c43fe6a', '62bf3933-8c5d-4256-8c12-334e716cd51a', '08d42ab8-69da-488f-9553-4bab95fd89e4', 1, 0);
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('d8df5d0c-01c0-4a03-9b4b-85561e1bac83', '62bf3933-8c5d-4256-8c12-334e716cd51a', '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', 1, 0);

-- Sporting Olympia 2025-10-25
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('11d927b6-02e1-4345-8547-fe4eab2045b7', 'ab4a53df-80c0-40f8-8d86-e9e5346db90e', '38d0b8c9-7c17-4392-a492-b95943248244', 1, 0);
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('bf26c5fb-6675-4042-9a5a-083b2bd53bfb', 'ab4a53df-80c0-40f8-8d86-e9e5346db90e', '3157eb62-2322-4ec4-af2f-f00136e99a50', 1, 0);

-- Ruisbroek Next 2025-11-08
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('579725cb-8bd5-4932-977b-125678582bc1', 'dbd417a8-ca4a-4a06-97e5-96df18382572', 'db232b7c-aa0f-4295-b87a-ea5db2338730', 1, 0);

-- Sporting Olympia 2025-11-15
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('be6e7667-bed1-419a-8318-a01fc834b844', 'a4aecfca-dba4-43f1-a1c5-4f16f03864bf', '08d42ab8-69da-488f-9553-4bab95fd89e4', 1, 0);

-- Kloosterstraat 2025-11-22
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('d5bbe429-9da6-4f3d-9f79-c7bd6cf6c154', '5c3e1254-664a-4bd4-bff9-3ffb8c15f613', '38d0b8c9-7c17-4392-a492-b95943248244', 1, 0);

-- Bacchus 2025-12-06
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('b260267d-84bc-461d-ad82-6018a4c9dd21', 'bccc8f0a-2a80-4e51-a16e-f86b0b87de6b', '08d42ab8-69da-488f-9553-4bab95fd89e4', 1, 0);

-- OBB 2025-12-13
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('1233e159-00f4-4ad3-b608-e1e9f138dc41', 'ab30b85e-593f-42f2-afc5-2f5489b6d8d7', '6b321166-046b-44e4-8ebf-7e0a20b0fddd', 1, 0);

-- Katastroof 2026-02-07
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('96fc5a4f-c759-432d-bb3b-b2960838013a', '610acc1b-3392-44f6-8f37-6387ef2eaca3', '38d0b8c9-7c17-4392-a492-b95943248244', 1, 0);
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('4f93cd6d-9c39-41c3-98e1-8cf079afad65', '610acc1b-3392-44f6-8f37-6387ef2eaca3', '08d42ab8-69da-488f-9553-4bab95fd89e4', 1, 0);
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('d8cdf445-8cb1-4c03-8070-a2e136a4f280', '610acc1b-3392-44f6-8f37-6387ef2eaca3', 'f6ca1a0c-0eb8-4dd8-babd-3202aa86d92a', 1, 0);

-- Amber G 2026-02-14
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('7a7b5158-9d5b-43ab-8cb8-342665f00d1d', '930396a1-e2e8-44b0-b076-3cb809a9946a', '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', 1, 0);
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('ff269151-b886-4d3c-8fa9-ad7bb4fb9215', '930396a1-e2e8-44b0-b076-3cb809a9946a', '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1', 1, 0);

-- Kloosterstraat 2026-03-14
INSERT INTO kaarten (id, match_id, player_id, geel, rood) VALUES ('1b8c2450-278c-4a03-b606-58cd06054f82', '372c4cd4-8442-4f09-aa26-f9142a892425', '767f223c-ed87-4ab8-93ae-f5889ea6c2bb', 1, 0);

-- ── Men of the Match 2025-2026 ────────────────────────────────
-- Meerdere MOTM per wedstrijd mogelijk (UNIQUE constraint verwijderd)
-- Chossel Sport 2025-08-30
INSERT INTO motm (id, match_id, player_id) VALUES ('4ca4fb03-6fcb-443e-b6ed-38ac5d8bf067', '24fcdf61-3840-4274-b315-a287adbfbd50', '38d0b8c9-7c17-4392-a492-b95943248244');

-- Bacchus 2025-09-06
INSERT INTO motm (id, match_id, player_id) VALUES ('ef965598-3d51-4fdf-849c-210e77ef7f40', '3a33b2b2-c6dd-43af-b6d8-d308cbc5fbce', '1f1958d7-66be-44f3-bca8-ec69c9d00f8c');

-- OBB 2025-09-13
INSERT INTO motm (id, match_id, player_id) VALUES ('009c725a-d220-4861-8ebb-cbe8a357ab04', '2bafe135-ef08-4737-8a9f-d5cbead42917', 'ff2eccf5-dd9d-4504-835c-04015695758e');

-- Amber G 2025-09-20
INSERT INTO motm (id, match_id, player_id) VALUES ('f98cafa6-42f4-47d2-a1f6-3b150f8debe6', '62bf3933-8c5d-4256-8c12-334e716cd51a', 'f6ca1a0c-0eb8-4dd8-babd-3202aa86d92a');

-- AC De Heide 2025-10-04
INSERT INTO motm (id, match_id, player_id) VALUES ('dda417da-e931-4942-8361-a8af406d7d3c', 'ce1d336a-61ca-4407-8032-003f7f0342eb', 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a');

-- Excelsior 81 2025-10-11
INSERT INTO motm (id, match_id, player_id) VALUES ('8f929667-d48f-486a-81d5-77e16c99979d', 'd02b1d71-e5b5-4cb4-a5df-6ac2549a7afc', 'ae6aca04-8285-4c31-bf0d-745275a89acf');

-- Katastroof 2025-10-18
INSERT INTO motm (id, match_id, player_id) VALUES ('6890af1a-5183-46a6-b136-7a5df24bc60b', '6173799e-15f8-4d7c-8694-8dfdc6275ff1', '38d0b8c9-7c17-4392-a492-b95943248244');

-- Sporting Olympia 2025-10-25
INSERT INTO motm (id, match_id, player_id) VALUES ('4457f654-e16d-42f0-bbee-96cf10ece88f', 'ab4a53df-80c0-40f8-8d86-e9e5346db90e', 'c0a0bc2b-0f04-4f18-824a-7eb2680f5fdc');

-- Ruisbroek Next 2025-11-08
INSERT INTO motm (id, match_id, player_id) VALUES ('08de2ef7-13ea-4810-8eac-64c50ea3511e', 'dbd417a8-ca4a-4a06-97e5-96df18382572', 'ae6aca04-8285-4c31-bf0d-745275a89acf');

-- Sporting Olympia 2025-11-15
INSERT INTO motm (id, match_id, player_id) VALUES ('f45befd5-277e-46a9-a3d3-81be2060039e', 'a4aecfca-dba4-43f1-a1c5-4f16f03864bf', '1f1958d7-66be-44f3-bca8-ec69c9d00f8c');

-- Kloosterstraat 2025-11-22
INSERT INTO motm (id, match_id, player_id) VALUES ('b43bfb25-1bca-4ddf-947b-e7f9e1ddf414', '5c3e1254-664a-4bd4-bff9-3ffb8c15f613', 'f6ca1a0c-0eb8-4dd8-babd-3202aa86d92a');

-- Chossel Sport 2025-11-29
INSERT INTO motm (id, match_id, player_id) VALUES ('88cd829a-0042-44fe-8af1-b659843adb21', '8b3355a1-a4a2-4cdb-a7f0-b367e846eff9', 'db232b7c-aa0f-4295-b87a-ea5db2338730');

-- Bacchus 2025-12-06
INSERT INTO motm (id, match_id, player_id) VALUES ('4881916a-061b-4ad1-9ae5-8c0c1742cfd6', 'bccc8f0a-2a80-4e51-a16e-f86b0b87de6b', '6b321166-046b-44e4-8ebf-7e0a20b0fddd');
INSERT INTO motm (id, match_id, player_id) VALUES ('42292863-8220-40fe-a39a-fd4c91cc176d', 'bccc8f0a-2a80-4e51-a16e-f86b0b87de6b', '46e7f9db-b122-4111-a3e8-969af745d315');

-- OBB 2025-12-13
INSERT INTO motm (id, match_id, player_id) VALUES ('7b32833f-2a19-4c58-8867-e5a542a35a62', 'ab30b85e-593f-42f2-afc5-2f5489b6d8d7', '6b321166-046b-44e4-8ebf-7e0a20b0fddd');
INSERT INTO motm (id, match_id, player_id) VALUES ('cae4e1a7-9abb-4f0f-b0cb-a6f5ebf6c749', 'ab30b85e-593f-42f2-afc5-2f5489b6d8d7', 'e5270f79-ad7d-44ee-a1ce-d96ba66f490b');

-- AC De Heide 2026-01-24
INSERT INTO motm (id, match_id, player_id) VALUES ('68fef5fb-c578-4f76-b60d-56e0303a4f3b', 'f5b8264d-ac96-4951-bf22-5c64e56b970f', 'ff2eccf5-dd9d-4504-835c-04015695758e');

-- Excelsior 81 2026-01-31
INSERT INTO motm (id, match_id, player_id) VALUES ('fc48c397-35a6-4de7-a97e-c2cc963125fa', '3222c9d3-44e3-422f-b46a-782632122895', '7662b497-bd4a-4068-b238-c36624dbe58d');

-- Katastroof 2026-02-07
INSERT INTO motm (id, match_id, player_id) VALUES ('17cd14de-bdc7-4f5c-8545-eb9fd6b7e833', '610acc1b-3392-44f6-8f37-6387ef2eaca3', 'a8a7f37d-95b9-4cc3-8887-fa8802496e4a');

-- Amber G 2026-02-14
INSERT INTO motm (id, match_id, player_id) VALUES ('f1f53e7a-416e-458d-8755-105a82ebfe12', '930396a1-e2e8-44b0-b076-3cb809a9946a', '46e7f9db-b122-4111-a3e8-969af745d315');

-- Ruisbroek Next 2026-02-28
INSERT INTO motm (id, match_id, player_id) VALUES ('e6652bf6-29b5-4847-a51b-93d0f0ccc49b', '26ac9b89-d480-4316-9ce2-4beedd600f0e', '1f1958d7-66be-44f3-bca8-ec69c9d00f8c');

-- Kloosterstraat 2026-03-14
INSERT INTO motm (id, match_id, player_id) VALUES ('25144c9e-3cb8-4932-bf58-debac54b4e96', '372c4cd4-8442-4f09-aa26-f9142a892425', '23c489b4-ab3d-41f2-b2ef-61ca76e9edb1');
