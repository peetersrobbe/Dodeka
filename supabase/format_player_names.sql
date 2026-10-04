-- ============================================================
-- DODEKA SPORT – Spelersnamen omzetten naar normale schrijfwijze
-- 'VAN DEN BOSCH Robbe'  ->  'Van Den Bosch Robbe'
-- Run dit één keer in: Supabase > SQL Editor > New query > Run
-- ============================================================

-- Controle vooraf: welke namen veranderen er?
-- SELECT naam AS oud, initcap(lower(naam)) AS nieuw
-- FROM players WHERE naam <> initcap(lower(naam)) ORDER BY naam;

UPDATE players
SET naam = initcap(lower(regexp_replace(trim(naam), '\s+', ' ', 'g')))
WHERE naam <> initcap(lower(regexp_replace(trim(naam), '\s+', ' ', 'g')));
