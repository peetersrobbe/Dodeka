-- ============================================================
-- DODEKA SPORT - Wedstrijden seizoen 2026-2027 (KAVVV kalender)
-- Bron: https://www.vriendenclubsantwerpen.be/index.php?view=kalender_db&id=5
-- Run dit in de Supabase SQL Editor (project moet actief/niet-gepauzeerd zijn).
--
-- Idempotent: opnieuw uitvoeren voegt geen duplicaten toe (NOT EXISTS guard
-- op season_id + datum + tegenstander). Scores/uitslag blijven leeg tot ze
-- ingevuld worden (handmatig of via de wekelijkse KAVVV-sync).
-- ============================================================

-- 1) Seizoen 2026-2027 aanmaken (indien nog niet aanwezig).
INSERT INTO seasons (naam, start_date, end_date, is_current)
VALUES ('2026-2027', '2026-09-12', '2027-06-30', false)
ON CONFLICT (naam) DO NOTHING;

-- 2) OPTIONEEL: maak 2026-2027 het huidige seizoen.
--    Dit bepaalt welk seizoen de site standaard toont en welk seizoen de
--    wekelijkse KAVVV-sync bijwerkt. Verwijder de -- om te activeren.
-- UPDATE seasons SET is_current = false WHERE is_current = true;
-- UPDATE seasons SET is_current = true  WHERE naam = '2026-2027';

-- 3) Wedstrijden toevoegen.
-- Uitwedstrijd bij De Keysers (30/08/2026) - gespeeld, 1-2 verloren.
-- Staat niet meer op de KAVVV-kalender, daarom handmatig toegevoegd met uitslag.
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, score_dodeka, score_tegenstander, is_thuis, uitslag, source)
SELECT s.id, '2026-08-30', NULL, 'De Keysers', 1, 2, false, 'v', 'manual'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-08-30' AND m.tegenstander = 'De Keysers');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2026-09-12', '14u45', 'Swinchester United', true, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-09-12' AND m.tegenstander = 'Swinchester United');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2026-09-19', '15u00', 'Sporting Olympia', false, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-09-19' AND m.tegenstander = 'Sporting Olympia');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2026-10-03', '15u00', 'Katastroof', false, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-10-03' AND m.tegenstander = 'Katastroof');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2026-10-10', '14u45', 'Kloosterstraat', true, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-10-10' AND m.tegenstander = 'Kloosterstraat');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2026-10-17', '15u00', 'Amber A', false, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-10-17' AND m.tegenstander = 'Amber A');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2026-10-24', '14u45', 'De Bruurs', true, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-10-24' AND m.tegenstander = 'De Bruurs');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2026-10-31', '14u45', 'Den Derde Helft', true, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-10-31' AND m.tegenstander = 'Den Derde Helft');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2026-11-14', '16u00', 'El Citadel FC', false, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-11-14' AND m.tegenstander = 'El Citadel FC');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2026-11-21', '14u45', 'La Pantera', true, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-11-21' AND m.tegenstander = 'La Pantera');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2026-11-28', '14u45', 'De Keysers', true, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-11-28' AND m.tegenstander = 'De Keysers');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2026-12-12', '15u45', 'Swinchester United', false, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2026-12-12' AND m.tegenstander = 'Swinchester United');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2027-01-09', '14u45', 'Sporting Olympia', true, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2027-01-09' AND m.tegenstander = 'Sporting Olympia');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2027-01-13', '20u00', 'Kloosterstraat', false, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2027-01-13' AND m.tegenstander = 'Kloosterstraat');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2027-01-16', '15u00', 'Den Derde Helft', false, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2027-01-16' AND m.tegenstander = 'Den Derde Helft');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2027-01-23', '14u45', 'Katastroof', true, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2027-01-23' AND m.tegenstander = 'Katastroof');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2027-02-20', '14u45', 'Amber A', true, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2027-02-20' AND m.tegenstander = 'Amber A');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2027-02-27', '16u30', 'De Bruurs', false, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2027-02-27' AND m.tegenstander = 'De Bruurs');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2027-03-06', '14u45', 'El Citadel FC', true, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2027-03-06' AND m.tegenstander = 'El Citadel FC');
INSERT INTO matches (season_id, datum, tijdstip, tegenstander, is_thuis, source)
SELECT s.id, '2027-03-13', '15u00', 'La Pantera', false, 'kavvv'
FROM seasons s WHERE s.naam = '2026-2027'
  AND NOT EXISTS (SELECT 1 FROM matches m WHERE m.season_id = s.id AND m.datum = '2027-03-13' AND m.tegenstander = 'La Pantera');

