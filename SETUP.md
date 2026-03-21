# Dodeka Sport – Statistieken Setup Gids

Volg deze stappen om de statistiekenmodule volledig werkend te krijgen.

---

## Stap 1 – Supabase project aanmaken

1. Ga naar [supabase.com](https://supabase.com) en maak een gratis account.
2. Klik op **New Project**, geef het de naam "Dodeka Sport" en kies een regio (bijv. EU West).
3. Noteer je wachtwoord veilig op — je hebt het later nodig.
4. Wacht tot het project klaar is (~1 minuut).

---

## Stap 2 – Database schema installeren

1. Ga in je Supabase project naar **SQL Editor** (linkermenu).
2. Klik op **New query**.
3. Open het bestand `supabase/schema.sql` uit je projectmap.
4. Kopieer de volledige inhoud en plak die in de SQL Editor.
5. Klik **Run** — je ziet "Success. No rows returned."

---

## Stap 3 – API-sleutels ophalen

1. Ga naar **Project Settings → API** (tandwielpictogram, linkermenu).
2. Kopieer twee waarden:
   - **Project URL** — begint met `https://...supabase.co`
   - **anon / public key** — begint met `eyJ...`
3. Open `js/supabase-config.js` en vervang de twee placeholders:
   ```js
   const SUPABASE_URL  = 'https://JOUW_PROJECT_ID.supabase.co';
   const SUPABASE_ANON = 'eyJ...JOUW_ANON_KEY...';
   ```
   De anon-sleutel is veilig om in GitHub te zetten — dat is waarvoor hij bedoeld is.
4. Kopieer ook de **service_role / secret key** (staat iets lager op dezelfde pagina). Die gebruik je in stap 5 en 6. Bewaar hem goed en commit hem **nooit**.

---

## Stap 4 – Historische data importeren (Windows)

### 4a – Controleer of Python geïnstalleerd is
Open **Opdrachtprompt** (zoek naar "cmd" in het Startmenu) en typ:
```
python --version
```
- Als je een versienummer ziet (bijv. `Python 3.11.x`) → ga door naar stap 4b.
- Als je een foutmelding krijgt → ga eerst naar [python.org/downloads](https://www.python.org/downloads/), download de nieuwste versie en installeer die. **Vink tijdens de installatie "Add Python to PATH" aan!** Sluit cmd daarna en open hem opnieuw.

### 4b – Installeer de benodigde pakketten
Typ in de Opdrachtprompt:
```
python -m pip install pandas openpyxl supabase python-dotenv
```
Wacht tot alles geïnstalleerd is (kan 1–2 minuten duren).

### 4c – Maak het .env bestand aan
1. Ga naar je projectmap in Verkenner (de map waar `index.html` staat).
2. Maak een nieuw tekstbestand aan. Noem het precies **`.env`** (geen `.txt` extensie!).
   - Tip: open Kladblok, typ de inhoud hieronder, kies **Opslaan als**, zet "Bestandstype" op "Alle bestanden" en geef de naam `.env`.
3. Inhoud van het `.env` bestand:
   ```
   SUPABASE_URL=https://ntxbgiccwdmsmsuhaicc.supabase.co
   SUPABASE_SERVICE_ROLE_KEY=VERVANG_DIT_MET_JOUW_SERVICE_ROLE_KEY
   ```
   De service role key vind je in Supabase → **Project Settings → API → service_role (secret)**.

### 4d – Zet de Excel file op de juiste plek
Zorg dat het Excel-bestand **`DODEKA SPORT seizoen 2025-2026 en oude statistieken.xlsx`** in dezelfde map staat als `index.html` (de hoofdmap van je project).

### 4e – Voer het importscript uit
Navigeer in de Opdrachtprompt naar je projectmap:
```
cd "C:\PAD\NAAR\JOUW\Dodeka website"
```
(Vervang het pad door waar jouw projectmap staat — je kunt het pad kopiëren uit de adresbalk van Verkenner.)

Voer daarna het script uit:
```
python scripts/seed_database.py
```
Je ziet regels zoals `Importing 2025-2026…` en `→ 21 matches, aanwezigheid imported.`
Dit importeert alle seizoenen, wedstrijden, doelpunten, assists, kaarten en man of the match.

---

## Stap 5 – Eerste admin-gebruiker instellen

Dit zorgt dat jij (en eventuele andere beheerders) via de website statistieken kunnen toevoegen en aanpassen.

1. **Registreer een account op je live website:**
   Ga naar `https://jouwdomein.be/login.html`, klik op **Registreren** en maak een account aan met je e-mailadres. Je ontvangt een bevestigingsmail — klik op de link daarin.

2. **Zoek je User UID op in Supabase:**
   - Ga naar [app.supabase.com](https://app.supabase.com) → jouw project.
   - Klik links in het menu op **Authentication** → dan **Users**.
   - Je ziet je e-mailadres in de lijst. Klik erop en kopieer de lange **UID** (ziet er zo uit: `a1b2c3d4-e5f6-...`).

3. **Maak jezelf admin:**
   - Ga in Supabase naar **SQL Editor** → **New query**.
   - Plak dit en vervang het UID door het jouwe:
     ```sql
     INSERT INTO admins (user_id) VALUES ('PLAK-JOUW-UID-HIER');
     ```
   - Klik op **Run**.

4. **Test het:** Log in op je website via `login.html`. In de navigatiebalk verschijnt nu een oranje knop **⚙ Beheer** — die brengt je naar het beheerderspaneel.

> Wil je meerdere admins? Herhaal stap 1–3 voor elke persoon. Gewone spelers (die alleen willen inloggen om hun eigen stats te zien) hoeven **niet** in de admins-tabel.

---

## Stap 6 – GitHub Actions secrets instellen (auto-sync KAVVV)

Dit zorgt dat resultaten en het klassement elke zondag automatisch worden bijgewerkt vanuit vriendenclubsantwerpen.be.

1. Ga naar je GitHub repository ([github.com/peetersrobbe/Dodeka](https://github.com/peetersrobbe/Dodeka)).
2. Klik bovenaan op **Settings** (tandwiel-tabblad).
3. Klik links in het menu op **Secrets and variables → Actions**.
4. Klik op **New repository secret** en voeg **twee** secrets toe:

   | Naam | Waarde |
   |------|--------|
   | `SUPABASE_URL` | `https://ntxbgiccwdmsmsuhaicc.supabase.co` |
   | `SUPABASE_SERVICE_ROLE_KEY` | jouw service role key (uit Supabase → Settings → API) |

5. De sync draait automatisch elke zondag om 22:00. Je kunt hem ook meteen handmatig testen:
   - Ga naar je repo → tabblad **Actions**.
   - Klik links op **Sync KAVVV Data**.
   - Klik rechts op **Run workflow → Run workflow**.
   - Na ~30 seconden zie je een groen vinkje als alles goed gaat.

---

## Stap 7 – Alle nieuwe bestanden naar GitHub pushen

Je Azure Static Web Apps deployment werkt ongewijzigd — gewoon pushen naar `main` en Azure deploy automatisch.

Als je **GitHub Desktop** gebruikt:
1. Open GitHub Desktop.
2. Je ziet alle nieuwe bestanden in de lijst (statistieken.html, login.html, admin.html, enz.).
3. Vul onderaan links een commit-bericht in, bijv. `"Statistieken module toegevoegd"`.
4. Klik op **Commit to main** en daarna op **Push origin**.

Als je de **command line** gebruikt:
```bash
cd "C:\PAD\NAAR\Dodeka website"
git add .
git commit -m "Statistieken module toegevoegd"
git push origin main
```

Na het pushen wacht je ~1 minuut en is je website automatisch bijgewerkt.

---

## Overzicht van nieuwe bestanden

| Bestand | Omschrijving |
|---|---|
| `statistieken.html` | Publieke statistiekenpagina |
| `login.html` | Inlog/registratiepagina |
| `admin.html` | Beheerderspaneel (alleen voor admins) |
| `js/supabase-config.js` | **Vul jouw sleutels in** |
| `js/stats.js` | Statistieken laden en weergeven |
| `js/admin.js` | Beheerderspaneel logica |
| `supabase/schema.sql` | Databaseschema (eenmalig uitvoeren) |
| `scripts/seed_database.py` | Excel-data importeren (eenmalig) |
| `scripts/sync_kavvv.py` | KAVVV-scraper (wekelijks via GitHub Actions) |
| `.github/workflows/sync-kavvv.yml` | GitHub Actions workflow |
| `.env.example` | Sjabloon voor je sleutels |
| `.gitignore` | Beveiligde bestanden uitsluiten |

---

## Beveiliging – Samenvatting

- **anon key** in `supabase-config.js` → veilig om te committen, enkel leesrechten via RLS
- **service_role key** → **alleen** in `.env` (lokaal) en GitHub Secrets, **nooit** committen
- **`.env`** staat in `.gitignore` → kan niet per ongeluk gecommit worden
- Row Level Security (RLS) zorgt dat alleen ingelogde admins data kunnen aanpassen

---

## Problemen?

- **"Kon seizoenen niet laden"** → Controleer of `supabase-config.js` de juiste URL en anon key bevat.
- **Stats-pagina blijft leeg** → Zorg dat er minstens één seizoen in de database staat en `is_current = true`.
- **Admin-knop verschijnt niet** → Controleer of je user_id correct in de `admins` tabel staat.
- **KAVVV-sync werkt niet** → Controleer GitHub Secrets, en controleer of de HTML-structuur van de site niet veranderd is.
