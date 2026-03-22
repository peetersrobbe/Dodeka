// ============================================================
// DODEKA SPORT – Statistics Page Logic
// ============================================================

let allSeasons    = [];
let currentSeason = null;
let statsData     = [];
let sortCol       = 'doelpunten';
let sortAsc       = false;
let isAdmin       = false;   // set true once admin is confirmed

// ── Boot ─────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', async () => {
  // Auth gate: check login first — redirect if not logged in
  const { data: { user } } = await supabaseClient.auth.getUser();
  if (!user) {
    window.location.href = 'login.html?redirect=statistieken.html';
    return;
  }

  // User is logged in — reveal the page
  document.getElementById('auth-gate').style.display = 'none';

  await checkAuthState(user);

  showSpinner(true);
  await loadSeasons();
  showSpinner(false);

  // Listen for modal open event
  document.getElementById('gameModal')
    .addEventListener('show.bs.modal', guOpen);
  document.getElementById('playersPanel')
    .addEventListener('show.bs.offcanvas', plOpen);
});

// ── Auth ──────────────────────────────────────────────────────
async function checkAuthState(user) {
  if (!user) {
    const { data: { user: u } } = await supabaseClient.auth.getUser();
    user = u;
  }
  const navAuth = document.getElementById('nav-auth');
  if (!user) {
    navAuth.innerHTML = `<a href="login.html" class="btn btn-outline-light btn-sm">Inloggen</a>`;
    return;
  }

  const { data: adminRow } = await supabaseClient
    .from('admins').select('user_id').eq('user_id', user.id).maybeSingle();

  if (adminRow) {
    isAdmin = true;
    navAuth.innerHTML =
      `<a href="admin.html" class="btn btn-warning btn-sm me-2">⚙ Beheer</a>
       <button onclick="signOut()" class="btn btn-outline-light btn-sm">Uitloggen</button>`;
    document.getElementById('admin-fab').style.display = 'block';
    // Show the edit-actions column header in the matches table
    document.getElementById('matches-actions-th').classList.remove('d-none');
    await guLoadPlayers();  // pre-load players for the panel
  } else {
    navAuth.innerHTML =
      `<button onclick="signOut()" class="btn btn-outline-light btn-sm">Uitloggen</button>`;
  }
}

async function signOut() {
  await supabaseClient.auth.signOut();
  window.location.reload();
}

// ── Seasons ───────────────────────────────────────────────────
async function loadSeasons() {
  const { data, error } = await supabaseClient
    .from('seasons').select('*').order('naam', { ascending: false });

  if (error) {
    showDbError(`Fout bij laden: ${error.message}`);
    return;
  }
  if (!data || data.length === 0) {
    showDbError();   // shows the seed_data.sql hint
    return;
  }

  allSeasons = data;
  renderSeasonButtons();

  const current = data.find(s => s.is_current) || data[0];
  if (current) await selectSeason(current);
}

function renderSeasonButtons() {
  const container = document.getElementById('season-buttons');
  const allBtn = `<button class="btn btn-sm btn-outline-secondary season-btn"
           data-id="all" onclick="selectAllSeasons()">
     🏆 Alle seizoenen
   </button>`;
  const seasonBtns = allSeasons.map(s =>
    `<button class="btn btn-sm btn-outline-secondary season-btn"
             data-id="${s.id}" onclick="selectSeason_id('${s.id}')">
       ${s.naam}
     </button>`
  ).join('');
  container.innerHTML = allBtn + seasonBtns;
}

async function selectSeason_id(id) {
  const season = allSeasons.find(s => s.id === id);
  if (season) await selectSeason(season);
}

async function selectAllSeasons() {
  currentSeason = null;

  // Hide the post-game button — it only applies to a specific season
  if (isAdmin) document.getElementById('admin-fab').style.display = 'none';

  document.querySelectorAll('.season-btn').forEach(b => {
    const active = b.dataset.id === 'all';
    b.classList.toggle('active',               active);
    b.classList.toggle('btn-danger',           active);
    b.classList.toggle('btn-outline-secondary', !active);
  });

  // Hide matches + standings tabs (not relevant for all-seasons view)
  document.getElementById('matches-tbody') && (document.getElementById('matches-tbody').innerHTML =
    '<tr><td colspan="6" class="text-center text-muted py-3">Selecteer een seizoen voor de wedstrijden.</td></tr>');
  const standEl = document.getElementById('standings-body');
  if (standEl) standEl.innerHTML = '<tr><td colspan="6" class="text-center text-muted py-3">Selecteer een seizoen voor de stand.</td></tr>';

  showSpinner(true);
  await loadAllStats();
  showSpinner(false);
}

async function selectSeason(season) {
  currentSeason = season;

  // Show the post-game button when a specific season is selected
  if (isAdmin) document.getElementById('admin-fab').style.display = 'block';

  document.querySelectorAll('.season-btn').forEach(b => {
    const active = b.dataset.id === season.id;
    b.classList.toggle('active',              active);
    b.classList.toggle('btn-danger',          active);
    b.classList.toggle('btn-outline-secondary', !active);
  });

  showSpinner(true);
  await Promise.all([
    loadStats(season.id),
    loadMatches(season.id),
    loadStandings(season.id),
  ]);
  showSpinner(false);
}

// ── Player Stats (per seizoen) ────────────────────────────────
async function loadStats(seasonId) {
  // Step 1: match IDs for this season (for attendance)
  const { data: matches, error: mErr } = await supabaseClient
    .from('matches').select('id').eq('season_id', seasonId);

  if (mErr) { showError('Kon wedstrijden niet laden: ' + mErr.message); return; }

  const matchIds = (matches || []).map(m => m.id);
  if (!matchIds.length) {
    statsData = [];
    renderStats();
    return;
  }

  // Step 2: aanwezigheid (per match) + historical stats (goals/assists/cards/motm per season)
  const [playersRes, aanwRes, histRes] = await Promise.all([
    supabaseClient.from('players').select('id, naam, nummer, started_season_id, ended_season_id').order('naam'),
    supabaseClient.from('aanwezigheid').select('player_id, status, match_id').in('match_id', matchIds),
    supabaseClient.from('historical_season_stats').select('player_id, doelpunten, assists, gele_kaarten, motm').eq('season_id', seasonId),
  ]);

  const aanw = aanwRes.data  || [];
  const hist = histRes.data  || [];

  // Helper: get season naam by id from allSeasons
  const seasonNaam = id => allSeasons.find(s => s.id === id)?.naam || null;
  const currentNaam = currentSeason.naam;

  // Filter players active in this season
  const seasonPlayers = (playersRes.data || []).filter(p => {
    const startNaam = seasonNaam(p.started_season_id);
    const endNaam   = seasonNaam(p.ended_season_id);
    const startOk = !p.started_season_id || (startNaam !== null && startNaam <= currentNaam);
    const endOk   = !p.ended_season_id   || (endNaam   !== null && currentNaam <= endNaam);
    return startOk && endOk;
  });

  // Step 3: build per-match team size (volledig + gewisseld + keeper ≥ 11 → qualifies for wissel%)
  const matchTeamSize = {};
  for (const r of aanw) {
    if (['volledig', 'gewisseld', 'keeper'].includes(r.status)) {
      matchTeamSize[r.match_id] = (matchTeamSize[r.match_id] || 0) + 1;
    }
  }

  // Step 4: aggregate per player
  statsData = seasonPlayers.map(p => {
    const pRows     = aanw.filter(r => r.player_id === p.id);
    const volledig  = pRows.filter(r => r.status === 'volledig').length;
    const gewisseld = pRows.filter(r => r.status === 'gewisseld').length;
    const keeper    = pRows.filter(r => r.status === 'keeper').length;
    const gespeeld  = volledig + gewisseld + keeper;
    const aanwezig  = gespeeld + pRows.filter(r => ['toeschouwer','aanwezig'].includes(r.status)).length;

    // Wissel % — only count matches where team had ≥ 11 players; exclude keeper games
    const qualGespeeld  = pRows.filter(r =>
      ['volledig', 'gewisseld'].includes(r.status) && (matchTeamSize[r.match_id] || 0) >= 11
    ).length;
    const qualGewisseld = pRows.filter(r =>
      r.status === 'gewisseld' && (matchTeamSize[r.match_id] || 0) >= 11
    ).length;

    const h = hist.find(r => r.player_id === p.id) || {};
    return {
      player_id:            p.id,
      naam:                 p.naam,
      nummer:               p.nummer,
      wedstrijden_gespeeld: matchIds.length,
      aanwezig,
      gewisseld,
      gespeeld,
      wissel_pct:   qualGespeeld > 0 ? Math.round(qualGewisseld / qualGespeeld * 100) : null,
      doelpunten:   h.doelpunten   || 0,
      assists:      h.assists      || 0,
      gele_kaarten: h.gele_kaarten || 0,
      rode_kaarten: 0,
      motm:         h.motm         || 0,
      keeper,
    };
  }).filter(p => p.aanwezig > 0 || p.doelpunten > 0 || p.assists > 0 || p.motm > 0 || p.gele_kaarten > 0);

  renderStats();
}

// ── Player Stats (alle seizoenen) ─────────────────────────────
async function loadAllStats() {
  // Query only historical_season_stats (pre-aggregated) — avoids
  // Supabase's 1000-row limit on aanwezigheid and the URL-length
  // issue when passing 190+ match UUIDs to an .in() filter.
  const [playersRes, histRes] = await Promise.all([
    supabaseClient.from('players').select('id, naam, nummer').order('naam'),
    supabaseClient.from('historical_season_stats')
      .select('player_id, aanwezig, gespeeld, gewisseld, keeper_games, doelpunten, assists, gele_kaarten, motm'),
  ]);

  const hist = histRes.data || [];

  // Sum all seasons per player
  const byPlayer = {};
  for (const r of hist) {
    if (!byPlayer[r.player_id]) byPlayer[r.player_id] = {
      aanwezig: 0, gespeeld: 0, gewisseld: 0, keeper_games: 0,
      doelpunten: 0, assists: 0, gele_kaarten: 0, motm: 0,
    };
    const b = byPlayer[r.player_id];
    b.aanwezig     += r.aanwezig     || 0;
    b.gespeeld     += r.gespeeld     || 0;
    b.gewisseld    += r.gewisseld    || 0;
    b.keeper_games += r.keeper_games || 0;
    b.doelpunten   += r.doelpunten   || 0;
    b.assists      += r.assists      || 0;
    b.gele_kaarten += r.gele_kaarten || 0;
    b.motm         += r.motm         || 0;
  }

  statsData = (playersRes.data || []).map(p => {
    const b = byPlayer[p.id] || {};
    const gespeeld  = b.gespeeld  || 0;
    const gewisseld = b.gewisseld || 0;
    return {
      player_id:            p.id,
      naam:                 p.naam,
      nummer:               p.nummer,
      aanwezig:             b.aanwezig     || 0,
      gespeeld,
      gewisseld,
      keeper:               b.keeper_games || 0,
      wissel_pct:   gespeeld > 0 ? Math.round(gewisseld / gespeeld * 100) : null,
      doelpunten:   b.doelpunten   || 0,
      assists:      b.assists      || 0,
      gele_kaarten: b.gele_kaarten || 0,
      rode_kaarten: 0,
      motm:         b.motm         || 0,
    };
  }).filter(p => p.aanwezig > 0 || p.doelpunten > 0 || p.assists > 0 || p.motm > 0 || p.gele_kaarten > 0);

  renderStats();
}

function renderStats() {
  const tbody = document.getElementById('stats-tbody');
  if (!statsData.length) {
    tbody.innerHTML = '<tr><td colspan="9" class="text-center text-muted py-4">Geen data voor dit seizoen.</td></tr>';
    return;
  }

  const sorted = [...statsData].sort((a, b) => {
    const va = a[sortCol], vb = b[sortCol];
    // Nulls always sink to the bottom regardless of sort direction
    if (va == null && vb == null) return 0;
    if (va == null) return 1;
    if (vb == null) return -1;
    if (typeof va === 'number') return sortAsc ? va - vb : vb - va;
    return sortAsc ? String(va).localeCompare(String(vb)) : String(vb).localeCompare(String(va));
  });

  tbody.innerHTML = sorted.map(p => {
    const wPct = p.wissel_pct !== null ? `${p.wissel_pct}%` : '–';
    const wColor = p.wissel_pct !== null
      ? (p.wissel_pct >= 50 ? '#dc3545' : p.wissel_pct >= 25 ? '#fd7e14' : '#6c757d')
      : '';
    return `<tr>
      <td>${p.naam}</td>
      <td class="text-center">
        <span class="badge bg-success stat-badge">${p.aanwezig}</span>
      </td>
      <td class="text-center">
        <span class="text-muted" style="font-size:.8rem;${wColor ? `color:${wColor}!important;font-weight:600` : ''}">${wPct}</span>
      </td>
      <td class="text-center fw-bold">${p.doelpunten || 0}</td>
      <td class="text-center">${p.assists || 0}</td>
      <td class="text-center">${p.gele_kaarten ? `<span class="badge text-dark stat-badge" style="background:#ffc107">${p.gele_kaarten}</span>` : '–'}</td>
      <td class="text-center">${p.rode_kaarten ? `<span class="badge bg-danger stat-badge">${p.rode_kaarten}</span>` : '–'}</td>
      <td class="text-center">${p.motm ? `<span class="badge stat-badge" style="background:#a00a30">⭐ ${p.motm}</span>` : '–'}</td>
      <td class="text-center">${p.keeper ? `<span class="badge stat-badge bg-secondary">🧤 ${p.keeper}</span>` : '–'}</td>
    </tr>`;
  }).join('');
}

// ── Sort ──────────────────────────────────────────────────────
document.querySelectorAll('th.sortable').forEach(th => {
  th.addEventListener('click', () => {
    const col = th.dataset.col;
    if (sortCol === col) sortAsc = !sortAsc;
    else { sortCol = col; sortAsc = col === 'naam'; }
    renderStats();
    document.querySelectorAll('th.sortable .sort-icon').forEach(el => el.textContent = '↕');
    th.querySelector('.sort-icon').textContent = sortAsc ? '↑' : '↓';
  });
});

// ── Matches ───────────────────────────────────────────────────
async function loadMatches(seasonId) {
  const { data } = await supabaseClient
    .from('matches').select('*').eq('season_id', seasonId).order('datum');

  const tbody = document.getElementById('matches-tbody');
  const cols = isAdmin ? 6 : 5;
  if (!data || !data.length) {
    tbody.innerHTML = `<tr><td colspan="${cols}" class="text-center text-muted py-3">Geen wedstrijden gevonden.</td></tr>`;
    return;
  }
  tbody.innerHTML = data.map(m => {
    const sd = m.score_dodeka, st = m.score_tegenstander;
    const has = sd !== null && st !== null;
    const datum = m.datum
      ? new Date(m.datum).toLocaleDateString('nl-BE', { day: '2-digit', month: '2-digit', year: 'numeric' })
      : '?';

    // Score in conventional format: home team first
    // Home game: Dodeka – tegenstander; Away game: tegenstander – Dodeka
    const scoreDisplay = has
      ? (m.is_thuis ? `${sd}–${st}` : `${st}–${sd}`)
      : '<span class="text-muted">–</span>';

    // Result badge — use stored uitslag field (handles forfait correctly)
    let resultBadge = '<span class="text-muted">–</span>';
    const u = m.uitslag;
    if (u) {
      const forfait = u.startsWith('f');
      const base    = forfait ? u[1] : u;   // 'w', 'v' or 'g'
      const label   = base === 'w' ? 'W' : base === 'v' ? 'V' : 'G';
      if (forfait) {
        resultBadge = `<span class="badge" style="background:#6f42c1">${label} – forfait</span>`;
      } else {
        const cls = base === 'w' ? 'bg-success' : base === 'v' ? 'bg-danger' : 'bg-warning text-dark';
        resultBadge = `<span class="badge ${cls}">${label}</span>`;
      }
    } else if (has) {
      // Fallback: derive from score if uitslag not set
      if (sd > st) resultBadge = '<span class="badge bg-success">W</span>';
      else if (sd === st) resultBadge = '<span class="badge bg-warning text-dark">G</span>';
      else resultBadge = '<span class="badge bg-danger">V</span>';
    }

    const editBtn = isAdmin
      ? `<td class="text-center">
           <button class="btn btn-sm btn-outline-secondary py-0 px-2"
                   onclick="guOpenMatch('${m.id}')" title="Statistieken bewerken">✏</button>
         </td>`
      : '';
    return `<tr>
      <td style="white-space:nowrap">${datum}</td>
      <td>${m.tegenstander}</td>
      <td class="text-center">${scoreDisplay}</td>
      <td class="text-center"><small>${m.is_thuis ? '🏠' : '🚌'}</small></td>
      <td class="text-center">${resultBadge}</td>
      ${editBtn}
    </tr>`;
  }).join('');
}

// Open the modal pre-selected on a specific match (from the edit button)
async function guOpenMatch(matchId) {
  if (!isAdmin) return;
  // Make sure players are loaded
  if (!guPlayers.length) await guLoadPlayers();

  // Flag so guOpen() knows which match to pre-select
  guPendingMatchId = matchId;

  // Open the fullscreen modal
  bootstrap.Modal.getOrCreateInstance(
    document.getElementById('gameModal')
  ).show();
}

let guPendingMatchId = null;  // set by guOpenMatch, consumed by guOpen

// ── Standings ─────────────────────────────────────────────────
async function loadStandings(seasonId) {
  const { data } = await supabaseClient
    .from('standings').select('*').eq('season_id', seasonId).order('positie');

  const container = document.getElementById('standings-container');
  if (!data || !data.length) {
    container.innerHTML = '<p class="text-muted small">Klassement nog niet beschikbaar.<br>Activeer de GitHub Actions sync om het automatisch op te halen.</p>';
    return;
  }
  container.innerHTML = `
    <div class="table-responsive">
      <table class="table table-sm table-bordered align-middle mb-0" style="font-size:.82rem">
        <thead><tr><th>#</th><th>Team</th><th class="text-center">W</th><th class="text-center">Pt</th></tr></thead>
        <tbody>
          ${data.map(r => `
            <tr class="${r.team_naam.toLowerCase().includes('dodeka') ? 'standing-highlight' : ''}">
              <td>${r.positie}</td><td>${r.team_naam}</td>
              <td class="text-center">${r.gespeeld}</td>
              <td class="text-center fw-bold">${r.punten}</td>
            </tr>`).join('')}
        </tbody>
      </table>
    </div>`;
}

// ════════════════════════════════════════════════════════════
// POST-GAME UPDATE PANEL
// ════════════════════════════════════════════════════════════
let guPlayers    = [];   // all active players
let guAttendance = {};   // player_id → status string
let guGoals      = {};   // player_id → number
let guAssists    = {};   // player_id → number
let guGeel       = {};   // player_id → number
let guRood       = {};   // player_id → number
let guMotm       = new Set(); // Set of player_ids (multiple MOTM allowed)
let guIsThuis    = true; // home (true) or away (false)

async function guLoadPlayers() {
  const { data } = await supabaseClient
    .from('players').select('id, naam, started_season_id, ended_season_id')
    .eq('active', true).order('naam');

  // Filter to players active in the current season
  const currentNaam = currentSeason?.naam || '9999';
  guPlayers = (data || []).filter(p => {
    const startNaam = allSeasons.find(s => s.id === p.started_season_id)?.naam || null;
    const endNaam   = allSeasons.find(s => s.id === p.ended_season_id)?.naam   || null;
    const startOk = !p.started_season_id || (startNaam !== null && startNaam <= currentNaam);
    const endOk   = !p.ended_season_id   || (endNaam   !== null && currentNaam <= endNaam);
    return startOk && endOk;
  });
}

async function guOpen() {
  if (!isAdmin || !currentSeason) return;
  guResetState();

  // Fill match dropdown with this season's matches (include is_thuis)
  const { data: matches } = await supabaseClient
    .from('matches').select('id, datum, tegenstander, score_dodeka, score_tegenstander, is_thuis')
    .eq('season_id', currentSeason.id).order('datum', { ascending: false });

  const sel = document.getElementById('gu-match');
  if (!matches || !matches.length) {
    sel.innerHTML = '<option value="">Geen wedstrijden — voeg er eerst een toe in Beheer</option>';
    guRenderTable();
    return;
  }
  sel.innerHTML = matches.map(m => {
    const d = m.datum ? new Date(m.datum).toLocaleDateString('nl-BE') : '?';
    return `<option value="${m.id}"
                    data-teg="${m.tegenstander}"
                    data-sd="${m.score_dodeka ?? ''}"
                    data-st="${m.score_tegenstander ?? ''}"
                    data-thuis="${m.is_thuis ? '1' : '0'}">${d} – ${m.tegenstander}</option>`;
  }).join('');

  // If opened via edit button, jump to that match; otherwise default to first
  if (guPendingMatchId) {
    sel.value = guPendingMatchId;
    guPendingMatchId = null;
  }

  await guLoadMatchData();
}

async function guLoadMatchData() {
  guResetState();
  const sel     = document.getElementById('gu-match');
  const opt     = sel.options[sel.selectedIndex];
  const matchId = sel.value;
  if (!matchId) return;

  // Pre-fill home/away first (guSetThuis updates labels)
  guSetThuis(opt.dataset.thuis !== '0');

  // Pre-fill score in conventional order: home team first
  // Home: left=Dodeka (sd), right=Teg (st)
  // Away: left=Teg (st), right=Dodeka (sd)
  const sd = opt.dataset.sd || '';
  const st = opt.dataset.st || '';
  const isThuis = opt.dataset.thuis !== '0';
  document.getElementById('gu-score-left').value  = isThuis ? sd : st;
  document.getElementById('gu-score-right').value = isThuis ? st : sd;

  // Load existing stats for this match
  const [aanwRes, doelRes, assRes, kaartRes, motmRes] = await Promise.all([
    supabaseClient.from('aanwezigheid').select('player_id, status').eq('match_id', matchId),
    supabaseClient.from('doelpunten').select('player_id, aantal').eq('match_id', matchId),
    supabaseClient.from('assists').select('player_id, aantal').eq('match_id', matchId),
    supabaseClient.from('kaarten').select('player_id, geel, rood').eq('match_id', matchId),
    supabaseClient.from('motm').select('player_id').eq('match_id', matchId),
  ]);

  (aanwRes.data  || []).forEach(r => { guAttendance[r.player_id] = r.status; });
  (doelRes.data  || []).forEach(r => { guGoals[r.player_id]      = r.aantal; });
  (assRes.data   || []).forEach(r => { guAssists[r.player_id]    = r.aantal; });
  (kaartRes.data || []).forEach(r => { guGeel[r.player_id]       = r.geel; guRood[r.player_id] = r.rood; });
  guMotm = new Set((motmRes.data || []).map(r => r.player_id));

  guRenderTable();
}

function guResetState() {
  guAttendance = {}; guGoals = {}; guAssists = {}; guGeel = {}; guRood = {}; guMotm = new Set(); guIsThuis = true;
}

function guSetThuis(val) {
  guIsThuis = val;
  document.getElementById('gu-thuis-btn').classList.toggle('btn-primary',  val);
  document.getElementById('gu-thuis-btn').classList.toggle('btn-outline-secondary', !val);
  document.getElementById('gu-uit-btn').classList.toggle('btn-primary',  !val);
  document.getElementById('gu-uit-btn').classList.toggle('btn-outline-secondary', val);

  // Update labels: home = [Dodeka]–[Teg], away = [Teg]–[Dodeka] (conventional home-first)
  const sel = document.getElementById('gu-match');
  const teg = sel.options[sel.selectedIndex]?.dataset?.teg || 'Teg.';
  document.getElementById('gu-label-left').textContent  = val ? 'Dodeka' : teg;
  document.getElementById('gu-label-right').textContent = val ? teg       : 'Dodeka';
}

/// Attendance options: label, icon, color
const GU_STATUSES = [
  { v: 'volledig',    label: 'Volledig',    icon: '✅', color: '#198754' },
  { v: 'gewisseld',   label: 'Gewisseld',   icon: '🔄', color: '#0d6efd' },
  { v: 'toeschouwer', label: 'Toeschouwer', icon: '👁', color: '#6f42c1' },
  { v: 'keeper',      label: 'Keeper',      icon: '🧤', color: '#fd7e14' },
];

// ── Combined attendance + stats table ────────────────────────
function guRenderTable() {
  const div = document.getElementById('gu-table');
  if (!guPlayers.length) {
    div.innerHTML = '<p class="text-muted small">Geen actieve spelers.</p>';
    return;
  }

  div.innerHTML = `
    <div class="table-responsive">
      <table class="table table-sm table-bordered mb-2" style="font-size:.82rem">
        <thead style="background:#a00a30;color:#fff">
          <tr>
            <th style="min-width:110px">Speler</th>
            <th class="text-center" style="white-space:nowrap">Aanw.</th>
            <th class="text-center">⚽</th>
            <th class="text-center">🅰</th>
            <th class="text-center">🟡</th>
            <th class="text-center">🔴</th>
            <th class="text-center">⭐</th>
          </tr>
        </thead>
        <tbody>
          ${guPlayers.map(p => {
            const s = guAttendance[p.id] || null;
            const canPlay = ['volledig','gewisseld','keeper','aanwezig'].includes(s);
            const dis = canPlay ? '' : 'disabled';
            const inputStyle = `width:38px;margin:auto${canPlay ? '' : ';background:#eee'}`;
            const aanwBtns = GU_STATUSES.map(({ v, label, icon, color }) => {
              const active = s === v;
              return `<button type="button"
                style="width:26px;height:26px;border-radius:5px;border:1px solid ${active ? color : '#ccc'};
                       background:${active ? color : '#fff'};color:${active ? '#fff' : '#888'};
                       font-size:.7rem;padding:0;line-height:1;"
                title="${label}" onclick="guToggleAanw('${p.id}','${v}')">${icon}</button>`;
            }).join('');
            return `<tr>
              <td style="min-width:110px;font-size:.9rem;vertical-align:middle;white-space:nowrap">${p.naam}</td>
              <td class="text-center" style="vertical-align:middle">
                <div class="d-flex gap-1 justify-content-center">${aanwBtns}</div>
              </td>
              <td style="vertical-align:middle">
                <input type="number" class="form-control form-control-sm text-center p-0"
                       style="${inputStyle}" min="0" value="${canPlay ? (guGoals[p.id] || 0) : ''}"
                       ${dis} oninput="guGoals['${p.id}']=+this.value">
              </td>
              <td style="vertical-align:middle">
                <input type="number" class="form-control form-control-sm text-center p-0"
                       style="${inputStyle}" min="0" value="${canPlay ? (guAssists[p.id] || 0) : ''}"
                       ${dis} oninput="guAssists['${p.id}']=+this.value">
              </td>
              <td style="vertical-align:middle">
                <input type="number" class="form-control form-control-sm text-center p-0"
                       style="${inputStyle}" min="0" value="${canPlay ? (guGeel[p.id] || 0) : ''}"
                       ${dis} oninput="guGeel['${p.id}']=+this.value">
              </td>
              <td style="vertical-align:middle">
                <input type="number" class="form-control form-control-sm text-center p-0"
                       style="${inputStyle}" min="0" value="${canPlay ? (guRood[p.id] || 0) : ''}"
                       ${dis} oninput="guRood['${p.id}']=+this.value">
              </td>
              <td class="text-center" style="vertical-align:middle">
                <input type="checkbox" value="${p.id}"
                       ${guMotm.has(p.id) ? 'checked' : ''} ${canPlay ? '' : 'disabled'}
                       onchange="guToggleMotm('${p.id}', this.checked)"
                       style="width:16px;height:16px;cursor:${canPlay ? 'pointer' : 'default'}">
              </td>
            </tr>`;
          }).join('')}
        </tbody>
      </table>
    </div>`;
}

function guToggleAanw(playerId, status) {
  // Toggle off if clicking same button again
  guAttendance[playerId] = guAttendance[playerId] === status ? null : status;
  guRenderTable();
}

function guToggleMotm(playerId, checked) {
  if (checked) guMotm.add(playerId);
  else         guMotm.delete(playerId);
}

// ── Sync historical_season_stats after editing match stats ────
async function refreshHistoricalStatsForSeason(seasonId) {
  const { data: seasonMatches } = await supabaseClient
    .from('matches').select('id').eq('season_id', seasonId);
  const mIds = (seasonMatches || []).map(m => m.id);
  if (!mIds.length) return;

  const [doelRes, assRes, kaartRes, motmRes, aanwRes] = await Promise.all([
    supabaseClient.from('doelpunten').select('player_id, aantal').in('match_id', mIds),
    supabaseClient.from('assists').select('player_id, aantal').in('match_id', mIds),
    supabaseClient.from('kaarten').select('player_id, geel').in('match_id', mIds),
    supabaseClient.from('motm').select('player_id').in('match_id', mIds),
    supabaseClient.from('aanwezigheid').select('player_id, status').in('match_id', mIds),
  ]);

  const byPlayer = {};
  const ensure = pid => {
    if (!byPlayer[pid]) byPlayer[pid] = {
      doelpunten: 0, assists: 0, gele_kaarten: 0, motm: 0,
      aanwezig: 0, gespeeld: 0, gewisseld: 0, keeper_games: 0,
    };
  };

  (doelRes.data  || []).forEach(r => { ensure(r.player_id); byPlayer[r.player_id].doelpunten   += r.aantal || 0; });
  (assRes.data   || []).forEach(r => { ensure(r.player_id); byPlayer[r.player_id].assists      += r.aantal || 0; });
  (kaartRes.data || []).forEach(r => { ensure(r.player_id); byPlayer[r.player_id].gele_kaarten += r.geel   || 0; });
  (motmRes.data  || []).forEach(r => { ensure(r.player_id); byPlayer[r.player_id].motm         += 1; });

  for (const r of (aanwRes.data || [])) {
    ensure(r.player_id);
    const b = byPlayer[r.player_id];
    if (['volledig','gewisseld','keeper','toeschouwer','aanwezig'].includes(r.status)) b.aanwezig++;
    if (['volledig','gewisseld','keeper'].includes(r.status)) b.gespeeld++;
    if (r.status === 'gewisseld') b.gewisseld++;
    if (r.status === 'keeper')    b.keeper_games++;
  }

  // Delete all existing rows for this season first so that players
  // whose stats were cleared don't keep stale totals in the summary.
  await supabaseClient.from('historical_season_stats').delete().eq('season_id', seasonId);

  const records = Object.entries(byPlayer).map(([pid, v]) => ({
    player_id: pid, season_id: seasonId, ...v
  }));
  if (records.length)
    await supabaseClient.from('historical_season_stats').insert(records);
}

// ── Save all ──────────────────────────────────────────────────
async function guSaveAll() {
  if (!isAdmin) { guShowMsg('Geen toegang: alleen admins kunnen statistieken opslaan.', 'danger'); return; }
  const matchId = document.getElementById('gu-match').value;
  if (!matchId) return;

  document.getElementById('gu-spinner').classList.remove('d-none');
  document.getElementById('gu-msg').classList.add('d-none');

  try {
    // Phase 1: update match metadata
    const leftVal  = parseInt(document.getElementById('gu-score-left').value);
    const rightVal = parseInt(document.getElementById('gu-score-right').value);
    const sd = guIsThuis ? leftVal  : rightVal;  // Dodeka score
    const st = guIsThuis ? rightVal : leftVal;   // Tegenstander score
    const matchUpdate = { is_thuis: guIsThuis };
    if (!isNaN(sd) && !isNaN(st)) {
      matchUpdate.score_dodeka = sd;
      matchUpdate.score_tegenstander = st;
    }
    await supabaseClient.from('matches').update(matchUpdate).eq('id', matchId);

    // Phase 2: wipe all existing per-match stats so cleared values don't linger
    await Promise.all([
      supabaseClient.from('aanwezigheid').delete().eq('match_id', matchId),
      supabaseClient.from('doelpunten').delete().eq('match_id', matchId),
      supabaseClient.from('assists').delete().eq('match_id', matchId),
      supabaseClient.from('kaarten').delete().eq('match_id', matchId),
      supabaseClient.from('motm').delete().eq('match_id', matchId),
    ]);

    // Phase 3: insert the current values
    const insertOps = [];

    // Attendance
    const aanwRecords = guPlayers
      .filter(p => guAttendance[p.id])
      .map(p => ({ match_id: matchId, player_id: p.id, status: guAttendance[p.id] }));
    if (aanwRecords.length)
      insertOps.push(supabaseClient.from('aanwezigheid').insert(aanwRecords));

    // Goals
    const doelRecords = guPlayers.filter(p => guGoals[p.id] > 0)
      .map(p => ({ match_id: matchId, player_id: p.id, aantal: guGoals[p.id] }));
    if (doelRecords.length)
      insertOps.push(supabaseClient.from('doelpunten').insert(doelRecords));

    // Assists
    const assRecords = guPlayers.filter(p => guAssists[p.id] > 0)
      .map(p => ({ match_id: matchId, player_id: p.id, aantal: guAssists[p.id] }));
    if (assRecords.length)
      insertOps.push(supabaseClient.from('assists').insert(assRecords));

    // Cards
    const kaartRecords = guPlayers.filter(p => (guGeel[p.id] || 0) + (guRood[p.id] || 0) > 0)
      .map(p => ({ match_id: matchId, player_id: p.id, geel: guGeel[p.id] || 0, rood: guRood[p.id] || 0 }));
    if (kaartRecords.length)
      insertOps.push(supabaseClient.from('kaarten').insert(kaartRecords));

    // MOTM (multiple allowed)
    if (guMotm.size > 0) {
      const motmRecords = [...guMotm].map(pid => ({ match_id: matchId, player_id: pid }));
      insertOps.push(supabaseClient.from('motm').insert(motmRecords));
    }

    await Promise.all(insertOps);

    // Show success + sync historical stats + refresh display
    guShowMsg('✓ Statistieken opgeslagen!', 'success');
    if (currentSeason) {
      await refreshHistoricalStatsForSeason(currentSeason.id);
      await Promise.all([loadStats(currentSeason.id), loadMatches(currentSeason.id)]);
    }

  } catch (err) {
    guShowMsg('Fout: ' + err.message, 'danger');
  } finally {
    document.getElementById('gu-spinner').classList.add('d-none');
  }
}

function guShowMsg(text, type) {
  const el = document.getElementById('gu-msg');
  el.className = `alert alert-${type} mt-2 p-2 small`;
  el.textContent = text;
  el.classList.remove('d-none');
}

// ── Helpers ───────────────────────────────────────────────────
function showSpinner(on) {
  document.getElementById('spinner').style.display = on ? 'block' : 'none';
}

function showDbError(msg) {
  const el = document.getElementById('db-error-msg');
  if (msg) el.innerHTML = `<strong>Fout:</strong> ${msg}`;
  el.classList.remove('d-none');
  document.getElementById('stats-tbody').innerHTML =
    '<tr><td colspan="7" class="text-center text-muted py-4">Geen data beschikbaar.</td></tr>';
}

function showError(msg) {
  console.error(msg);
  document.getElementById('stats-tbody').innerHTML =
    `<tr><td colspan="7" class="text-center text-danger py-4">${msg}</td></tr>`;
}

// ════════════════════════════════════════════════════════════
// PLAYERS PANEL (activate / deactivate)
// ════════════════════════════════════════════════════════════
let plAllPlayers = [];

async function plOpen() {
  await plLoad();
}

async function plLoad() {
  const div = document.getElementById('pl-list');
  div.innerHTML = '<div class="text-center py-3"><span class="spinner-border spinner-border-sm"></span></div>';

  const { data, error } = await supabaseClient
    .from('players').select('id, naam, nummer, active').order('naam');

  if (error || !data) {
    div.innerHTML = '<p class="text-danger small">Kon spelers niet laden.</p>';
    return;
  }
  plAllPlayers = data;
  plRender();
}

function plRender() {
  const div = document.getElementById('pl-list');
  // Active first, then inactive; both sorted alphabetically
  const sorted = [...plAllPlayers].sort((a, b) => {
    if (a.active !== b.active) return a.active ? -1 : 1;
    return a.naam.localeCompare(b.naam);
  });

  if (!sorted.length) {
    div.innerHTML = '<p class="text-muted small">Geen spelers gevonden.</p>';
    return;
  }

  div.innerHTML = sorted.map(p => `
    <div class="d-flex align-items-center justify-content-between py-2 border-bottom gap-2">
      <div style="min-width:0;flex:1">
        <span class="fw-semibold" style="font-size:.88rem">${p.naam}</span>
        ${p.nummer ? `<span class="text-muted ms-1" style="font-size:.78rem">#${p.nummer}</span>` : ''}
      </div>
      <button class="btn btn-sm flex-shrink-0 ${p.active ? 'btn-success' : 'btn-outline-secondary'}"
              style="min-width:88px"
              onclick="plToggle('${p.id}', ${p.active})">
        ${p.active ? '✓ Actief' : '✗ Inactief'}
      </button>
    </div>`).join('');
}

async function plToggle(id, currentlyActive) {
  const { error } = await supabaseClient
    .from('players').update({ active: !currentlyActive }).eq('id', id);

  if (error) { alert('Opslaan mislukt: ' + error.message); return; }

  // Update local state + re-render without full reload
  const p = plAllPlayers.find(x => x.id === id);
  if (p) p.active = !currentlyActive;
  plRender();

  // Also refresh the guPlayers list so next panel open is up to date
  await guLoadPlayers();
}
