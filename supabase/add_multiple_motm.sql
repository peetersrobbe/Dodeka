-- ═══════════════════════════════════════════════════════════════
-- Migratie: meerdere MOTM per wedstrijd toestaan
-- Wijzigt UNIQUE(match_id) naar UNIQUE(match_id, player_id)
-- Voer dit uit VÓÓR stats_2025_2026.sql
-- ═══════════════════════════════════════════════════════════════

-- Verwijder de bestaande UNIQUE constraint die slechts 1 MOTM/wedstrijd toestond
ALTER TABLE motm DROP CONSTRAINT IF EXISTS motm_match_id_key;

-- Voeg nieuwe constraint toe: zelfde speler kan maar 1x MOTM zijn per wedstrijd
ALTER TABLE motm ADD CONSTRAINT motm_match_player_unique UNIQUE (match_id, player_id);
