-- ============================================================
-- Migratie: profiles tabel + trigger voor gebruikersbeheer
-- Voer uit in: Supabase > SQL Editor > New query > Run
-- ============================================================

-- Tabel met basisprofiel per gebruiker (email + aanmaakdatum)
CREATE TABLE IF NOT EXISTS profiles (
  user_id    UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  email      TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS: alleen admins mogen alle profielen lezen; schrijven alleen via trigger/admin
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "admin_read"  ON profiles FOR SELECT USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));
CREATE POLICY "admin_write" ON profiles FOR ALL    USING (EXISTS (SELECT 1 FROM admins WHERE user_id = auth.uid()));

-- Trigger: maak automatisch een profiel aan bij nieuwe gebruikersregistratie
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public AS $$
BEGIN
  INSERT INTO profiles (user_id, email, created_at)
  VALUES (NEW.id, NEW.email, COALESCE(NEW.created_at, NOW()))
  ON CONFLICT (user_id) DO NOTHING;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- Bestaande gebruikers retroactief toevoegen aan profiles
INSERT INTO profiles (user_id, email, created_at)
SELECT id, email, created_at FROM auth.users
ON CONFLICT (user_id) DO NOTHING;
