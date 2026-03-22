// ============================================================
// DODEKA SPORT – Admin Panel Logic
// ============================================================

let seasons   = [];
let players   = [];
let users     = [];   // profiles rows
let adminIds  = new Set();  // user_ids that are admin
let currentUserId = null;   // logged-in user's id
let matchModal, playerModal, seasonModal;

// ── Bootstrap ────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', async () => {
  // Guard: only admins may be here
  const { data: { user } } = await supabaseClient.auth.getUser();
  if (!user) { window.location.href = 'login.html'; return; }

  const { data: isAdmin } = await supabaseClient
    .from('admins').select('user_id').eq('user_id', user.id).maybeSingle();
  if (!isAdmin) { window.location.href = 'statistieken.html'; return; }

  currentUserId = user.id;

  matchModal  = new bootstrap.Modal(document.getElementById('matchModal'));
  playerModal = new bootstrap.Modal(document.getElementById('playerModal'));
  seasonModal = new bootstrap.Modal(document.getElementById('seasonModal'));

  await Promise.all([loadSeasons(), loadPlayers()]);

  document.getElementById('loading-overlay').classList.add('d-none');
  showSection('wedstrijden');
});

// ── Navigation ────────────────────────────────────────────────
function showSection(name) {
  document.querySelectorAll('.admin-section').forEach(s => s.classList.add('d-none'));
  document.getElementById(`section-${name}`).classList.remove('d-none');
  document.querySelectorAll('#admin-nav .nav-link').forEach(l =>
    l.classList.toggle('active', l.getAttribute('onclick').includes(`'${name}'`)));

  if (name === 'wedstrijden') loadMatchesAdmin();
  if (name === 'spelers')     renderPlayersAdmin();
  if (name === 'seizoenen')   renderSeasonsAdmin();
  if (name === 'stats')       syncSeasonSelects();
  if (name === 'gebruikers')  loadUsers();
}

// ── Seasons ───────────────────────────────────────────────────
async function loadSeasons() {
  const { data } = await supabaseClient.from('seasons').select('*').order('naam', { ascending: false });
  seasons = data || [];
  const seasonOpts = seasons.map(s => `<option value="${s.id}">${s.naam}</option>`).join('');
  ['match-season', 'match-season-filter', 'stats-season-sel'].forEach(id => {
    const el = document.getElementById(id);
    if (!el) return;
    el.innerHTML = seasonOpts;
  });
  // Populate player modal season dropdowns
  const startEl = document.getElementById('player-started-season');
  const endEl   = document.getElementById('player-ended-season');
  if (startEl) startEl.innerHTML = `<option value="">– altijd –</option>${seasonOpts}`;
  if (endEl)   endEl.innerHTML   = `<option value="">– huidig –</option>${seasonOpts}`;
}

function renderSeasonsAdmin() {
  const tbody = document.getElementById('admin-seasons-tbody');
  tbody.innerHTML = seasons.map(s => `
    <tr>
      <td>${s.naam}</td>
      <td>${s.is_current ? '<span class="badge bg-success">Huidig</span>' : ''}</td>
      <td>
        <button class="btn btn-sm btn-outline-primary me-1" onclick="editSeason('${s.id}')">✏</button>
        <button class="btn btn-sm btn-outline-danger" onclick="deleteSeason('${s.id}')">🗑</button>
      </td>
    </tr>`).join('');
}

function openSeasonModal(id) {
  document.getElementById('season-id').value   = '';
  document.getElementById('season-naam').value = '';
  document.getElementById('season-current').checked = false;
  seasonModal.show();
}

function editSeason(id) {
  const s = seasons.find(x => x.id === id);
  document.getElementById('season-id').value = s.id;
  document.getElementById('season-naam').value = s.naam;
  document.getElementById('season-current').checked = s.is_current;
  seasonModal.show();
}

async function saveSeason() {
  const id      = document.getElementById('season-id').value;
  const naam    = document.getElementById('season-naam').value.trim();
  const current = document.getElementById('season-current').checked;
  if (!naam) return;

  if (current) await supabaseClient.from('seasons').update({ is_current: false }).neq('id', id || 'x');

  if (id) {
    await supabaseClient.from('seasons').update({ naam, is_current: current }).eq('id', id);
  } else {
    await supabaseClient.from('seasons').insert({ naam, is_current: current });
  }
  seasonModal.hide();
  await loadSeasons();
  renderSeasonsAdmin();
  showToast('Seizoen opgeslagen!');
}

async function deleteSeason(id) {
  if (!confirm('Seizoen verwijderen? Dit verwijdert ook alle wedstrijden van dit seizoen!')) return;
  await supabaseClient.from('seasons').delete().eq('id', id);
  await loadSeasons();
  renderSeasonsAdmin();
  showToast('Seizoen verwijderd.');
}

// ── Players ───────────────────────────────────────────────────
async function loadPlayers() {
  const { data } = await supabaseClient.from('players').select('*').order('naam');
  players = data || [];
}

function renderPlayersAdmin() {
  const tbody = document.getElementById('admin-players-tbody');
  // Sort: active first, then alphabetically
  const sorted = [...players].sort((a, b) => {
    if (a.active !== b.active) return a.active ? -1 : 1;
    return a.naam.localeCompare(b.naam);
  });

  const seasonOpts = (nullLabel, nullValue='') =>
    `<option value="${nullValue}">${nullLabel}</option>` +
    seasons.map(s => `<option value="${s.id}">${s.naam}</option>`).join('');

  tbody.innerHTML = sorted.map(p => `
    <tr class="${p.active ? '' : 'table-secondary text-muted'}">
      <td>${p.nummer || '–'}</td>
      <td>${p.naam}</td>
      <td>
        <button class="btn btn-sm ${p.active ? 'btn-success' : 'btn-outline-secondary'}"
                style="min-width:90px"
                onclick="togglePlayerActive('${p.id}', ${p.active})">
          ${p.active ? '✓ Actief' : '✗ Inactief'}
        </button>
      </td>
      <td>
        <select class="form-select form-select-sm" style="min-width:110px"
                onchange="updatePlayerSeason('${p.id}', 'started_season_id', this.value)">
          ${seasonOpts('– altijd –').replace(`value="${p.started_season_id || ''}"`, `value="${p.started_season_id || ''}" selected`)}
        </select>
      </td>
      <td>
        <select class="form-select form-select-sm" style="min-width:110px"
                onchange="updatePlayerSeason('${p.id}', 'ended_season_id', this.value)">
          ${seasonOpts('– huidig –').replace(`value="${p.ended_season_id || ''}"`, `value="${p.ended_season_id || ''}" selected`)}
        </select>
      </td>
      <td>
        <button class="btn btn-sm btn-outline-primary me-1" onclick="editPlayer('${p.id}')">✏</button>
        <button class="btn btn-sm btn-outline-danger" onclick="deletePlayer('${p.id}')">🗑</button>
      </td>
    </tr>`).join('');
}

async function updatePlayerSeason(id, field, value) {
  await supabaseClient.from('players')
    .update({ [field]: value || null })
    .eq('id', id);
  const p = players.find(x => x.id === id);
  if (p) p[field] = value || null;
  showToast('Seizoen opgeslagen.');
}

async function togglePlayerActive(id, currentlyActive) {
  await supabaseClient.from('players').update({ active: !currentlyActive }).eq('id', id);
  await loadPlayers();
  renderPlayersAdmin();
  showToast(currentlyActive ? 'Speler op inactief gezet.' : 'Speler geactiveerd.');
}

function openPlayerModal() {
  document.getElementById('player-id').value = '';
  document.getElementById('player-naam').value = '';
  document.getElementById('player-nummer').value = '';
  document.getElementById('player-active').checked = true;
  document.getElementById('player-started-season').value = '';
  document.getElementById('player-ended-season').value   = '';
  playerModal.show();
}

function editPlayer(id) {
  const p = players.find(x => x.id === id);
  document.getElementById('player-id').value = p.id;
  document.getElementById('player-naam').value = p.naam;
  document.getElementById('player-nummer').value = p.nummer || '';
  document.getElementById('player-active').checked = p.active;
  document.getElementById('player-started-season').value = p.started_season_id || '';
  document.getElementById('player-ended-season').value   = p.ended_season_id   || '';
  playerModal.show();
}

async function savePlayer() {
  const id               = document.getElementById('player-id').value;
  const naam             = document.getElementById('player-naam').value.trim();
  const nummer           = parseInt(document.getElementById('player-nummer').value) || null;
  const active           = document.getElementById('player-active').checked;
  const started_season_id = document.getElementById('player-started-season').value || null;
  const ended_season_id   = document.getElementById('player-ended-season').value   || null;
  if (!naam) return;

  const payload = { naam, nummer, active, started_season_id, ended_season_id };

  if (id) {
    await supabaseClient.from('players').update(payload).eq('id', id);
  } else {
    await supabaseClient.from('players').insert(payload);
  }
  playerModal.hide();
  await loadPlayers();
  renderPlayersAdmin();
  showToast('Speler opgeslagen!');
}

async function deletePlayer(id) {
  if (!confirm('Speler verwijderen?')) return;
  await supabaseClient.from('players').delete().eq('id', id);
  await loadPlayers();
  renderPlayersAdmin();
  showToast('Speler verwijderd.');
}

// ── Matches ───────────────────────────────────────────────────
async function loadMatchesAdmin() {
  const seasonId = document.getElementById('match-season-filter')?.value;
  if (!seasonId) return;

  const { data } = await supabaseClient
    .from('matches').select('*').eq('season_id', seasonId).order('datum');

  const tbody = document.getElementById('admin-matches-tbody');
  if (!data || !data.length) {
    tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">Geen wedstrijden gevonden.</td></tr>';
    return;
  }
  tbody.innerHTML = data.map(m => {
    const datum = m.datum ? new Date(m.datum).toLocaleDateString('nl-BE') : '?';
    const score = (m.score_dodeka !== null && m.score_tegenstander !== null)
      ? `${m.score_dodeka}–${m.score_tegenstander}` : '–';
    return `<tr>
      <td>${datum}</td>
      <td>${m.tegenstander}</td>
      <td>${score}</td>
      <td>${m.is_thuis ? 'T' : 'U'}</td>
      <td>
        <button class="btn btn-sm btn-outline-primary me-1" onclick="editMatch('${m.id}')">✏</button>
        <button class="btn btn-sm btn-outline-danger"       onclick="deleteMatch('${m.id}')">🗑</button>
      </td>
    </tr>`;
  }).join('');
}

function openMatchModal() {
  document.getElementById('match-id').value = '';
  document.getElementById('match-datum').value = '';
  document.getElementById('match-tijdstip').value = '';
  document.getElementById('match-tegenstander').value = '';
  document.getElementById('match-score-dodeka').value = '';
  document.getElementById('match-score-teg').value = '';
  document.getElementById('is-thuis').checked = true;
  document.getElementById('matchModalTitle').textContent = 'Wedstrijd toevoegen';
  matchModal.show();
}

async function editMatch(id) {
  const { data: m } = await supabaseClient.from('matches').select('*').eq('id', id).single();
  document.getElementById('match-id').value = m.id;
  document.getElementById('match-season').value = m.season_id;
  document.getElementById('match-datum').value = m.datum;
  document.getElementById('match-tijdstip').value = m.tijdstip || '';
  document.getElementById('match-tegenstander').value = m.tegenstander;
  document.getElementById('match-score-dodeka').value = m.score_dodeka ?? '';
  document.getElementById('match-score-teg').value = m.score_tegenstander ?? '';
  document.querySelector(`input[name="thuisUit"][value="${m.is_thuis}"]`).checked = true;
  document.getElementById('matchModalTitle').textContent = 'Wedstrijd bewerken';
  matchModal.show();
}

async function saveMatch() {
  const id = document.getElementById('match-id').value;
  const payload = {
    season_id:           document.getElementById('match-season').value,
    datum:               document.getElementById('match-datum').value,
    tijdstip:            document.getElementById('match-tijdstip').value || null,
    tegenstander:        document.getElementById('match-tegenstander').value.trim(),
    score_dodeka:        parseIntOrNull('match-score-dodeka'),
    score_tegenstander:  parseIntOrNull('match-score-teg'),
    is_thuis:            document.querySelector('input[name="thuisUit"]:checked').value === 'true',
  };
  if (!payload.datum || !payload.tegenstander) return;

  if (id) await supabaseClient.from('matches').update(payload).eq('id', id);
  else     await supabaseClient.from('matches').insert(payload);

  matchModal.hide();
  await loadMatchesAdmin();
  showToast('Wedstrijd opgeslagen!');
}

async function deleteMatch(id) {
  if (!confirm('Wedstrijd verwijderen?')) return;
  await supabaseClient.from('matches').delete().eq('id', id);
  await loadMatchesAdmin();
  showToast('Wedstrijd verwijderd.');
}

// ── Match Stats ───────────────────────────────────────────────
function syncSeasonSelects() {
  const sel = document.getElementById('stats-season-sel');
  if (seasons.length) {
    sel.innerHTML = seasons.map(s => `<option value="${s.id}">${s.naam}</option>`).join('');
    loadMatchesForStats();
  }
}

async function loadMatchesForStats() {
  const seasonId = document.getElementById('stats-season-sel').value;
  const { data } = await supabaseClient.from('matches').select('*').eq('season_id', seasonId).order('datum');
  const sel = document.getElementById('stats-match-sel');
  sel.innerHTML = (data || []).map(m => {
    const d = m.datum ? new Date(m.datum).toLocaleDateString('nl-BE') : '?';
    return `<option value="${m.id}">${d} – ${m.tegenstander}</option>`;
  }).join('');
  if (data?.length) loadMatchStats();
  else document.getElementById('match-stats-form').innerHTML = '<p class="text-muted">Geen wedstrijden in dit seizoen.</p>';
}

async function loadMatchStats() {
  const matchId = document.getElementById('stats-match-sel').value;
  if (!matchId) return;

  const [aanwData, doelData, assData, kaartData, motmData] = await Promise.all([
    supabaseClient.from('aanwezigheid').select('*').eq('match_id', matchId),
    supabaseClient.from('doelpunten').select('*').eq('match_id', matchId),
    supabaseClient.from('assists').select('*').eq('match_id', matchId),
    supabaseClient.from('kaarten').select('*').eq('match_id', matchId),
    supabaseClient.from('motm').select('*').eq('match_id', matchId).maybeSingle(),
  ]);

  const aanwMap   = Object.fromEntries((aanwData.data || []).map(r => [r.player_id, r.status]));
  const doelMap   = Object.fromEntries((doelData.data || []).map(r => [r.player_id, r.aantal]));
  const assMap    = Object.fromEntries((assData.data  || []).map(r => [r.player_id, r.aantal]));
  const kaartMap  = Object.fromEntries((kaartData.data || []).map(r => [r.player_id, { geel: r.geel, rood: r.rood }]));
  const motmId    = motmData.data?.player_id || null;

  const activePlayers = players.filter(p => p.active);

  document.getElementById('match-stats-form').innerHTML = `
    <div class="table-responsive">
      <table class="table table-sm table-bordered" id="stats-entry-table">
        <thead class="table-dark">
          <tr>
            <th>Speler</th>
            <th>Aanw.</th>
            <th class="text-center">⚽</th>
            <th class="text-center">🅰</th>
            <th class="text-center">🟡</th>
            <th class="text-center">🔴</th>
            <th class="text-center">⭐ MOTM</th>
          </tr>
        </thead>
        <tbody>
          ${activePlayers.map(p => {
            const aanw = aanwMap[p.id] || null;
            const geel = kaartMap[p.id]?.geel || 0;
            const rood = kaartMap[p.id]?.rood || 0;
            const isMOTM = p.id === motmId;
            return `<tr data-player="${p.id}">
              <td>${p.naam}</td>
              <td>
                <div class="d-flex gap-1">
                  <button type="button" class="btn aanw-btn ${aanw === 'aanwezig' ? 'aanwezig' : 'btn-outline-secondary'}"
                          onclick="setAanw('${p.id}', 'aanwezig', this)" title="Aanwezig">✓</button>
                  <button type="button" class="btn aanw-btn ${aanw === 'afwezig' ? 'afwezig' : 'btn-outline-secondary'}"
                          onclick="setAanw('${p.id}', 'afwezig', this)" title="Afwezig">✗</button>
                  <button type="button" class="btn aanw-btn ${aanw === 'verontschuldigd' ? 'verontschuldigd' : 'btn-outline-secondary'}"
                          onclick="setAanw('${p.id}', 'verontschuldigd', this)" title="Verontschuldigd">~</button>
                </div>
              </td>
              <td class="text-center">
                <input type="number" class="form-control form-control-sm text-center"
                       style="width:55px;margin:auto" min="0" value="${doelMap[p.id] || 0}"
                       onchange="saveStatField('doelpunten', '${p.id}', 'aantal', this.value)">
              </td>
              <td class="text-center">
                <input type="number" class="form-control form-control-sm text-center"
                       style="width:55px;margin:auto" min="0" value="${assMap[p.id] || 0}"
                       onchange="saveStatField('assists', '${p.id}', 'aantal', this.value)">
              </td>
              <td class="text-center">
                <input type="number" class="form-control form-control-sm text-center"
                       style="width:55px;margin:auto" min="0" value="${geel}"
                       onchange="saveKaart('${p.id}', 'geel', this.value)">
              </td>
              <td class="text-center">
                <input type="number" class="form-control form-control-sm text-center"
                       style="width:55px;margin:auto" min="0" value="${rood}"
                       onchange="saveKaart('${p.id}', 'rood', this.value)">
              </td>
              <td class="text-center">
                <input type="radio" name="motm" value="${p.id}" class="form-check-input"
                       ${isMOTM ? 'checked' : ''}
                       onchange="saveMOTM('${p.id}')">
              </td>
            </tr>`;
          }).join('')}
        </tbody>
      </table>
    </div>
    <small class="text-muted">Wijzigingen worden automatisch opgeslagen per veld.</small>`;
}

// ── Stat field savers ─────────────────────────────────────────
async function setAanw(playerId, status, btn) {
  const matchId = document.getElementById('stats-match-sel').value;
  const row = btn.closest('tr');
  row.querySelectorAll('.aanw-btn').forEach(b => {
    b.classList.remove('aanwezig', 'afwezig', 'verontschuldigd');
    b.classList.add('btn-outline-secondary');
  });
  btn.classList.remove('btn-outline-secondary');
  btn.classList.add(status);

  await supabaseClient.from('aanwezigheid').upsert(
    { match_id: matchId, player_id: playerId, status },
    { onConflict: 'match_id,player_id' }
  );
}

async function saveStatField(table, playerId, field, value) {
  const matchId = document.getElementById('stats-match-sel').value;
  const aantal  = parseInt(value) || 0;
  if (aantal === 0) {
    await supabaseClient.from(table).delete()
      .eq('match_id', matchId).eq('player_id', playerId);
  } else {
    await supabaseClient.from(table).upsert(
      { match_id: matchId, player_id: playerId, [field]: aantal },
      { onConflict: 'match_id,player_id' }
    );
  }
}

async function saveKaart(playerId, kleur, value) {
  const matchId = document.getElementById('stats-match-sel').value;
  const aantal  = parseInt(value) || 0;
  await supabaseClient.from('kaarten').upsert(
    { match_id: matchId, player_id: playerId, [kleur]: aantal },
    { onConflict: 'match_id,player_id' }
  );
}

async function saveMOTM(playerId) {
  const matchId = document.getElementById('stats-match-sel').value;
  await supabaseClient.from('motm').upsert(
    { match_id: matchId, player_id: playerId },
    { onConflict: 'match_id' }
  );
  showToast('Man of the Match opgeslagen!');
}

// ── Helpers ───────────────────────────────────────────────────
function parseIntOrNull(id) {
  const v = document.getElementById(id).value;
  return v === '' ? null : parseInt(v);
}

// ── Users ─────────────────────────────────────────────────────
async function loadUsers() {
  const [profilesRes, adminsRes] = await Promise.all([
    supabaseClient.from('profiles').select('user_id, email, created_at').order('created_at'),
    supabaseClient.from('admins').select('user_id'),
  ]);

  users    = profilesRes.data || [];
  adminIds = new Set((adminsRes.data || []).map(r => r.user_id));

  renderUsersAdmin();
}

function renderUsersAdmin() {
  const tbody = document.getElementById('admin-users-tbody');
  if (!users.length) {
    tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted">Nog geen gebruikers gevonden. Voer eerst <code>add_user_profiles.sql</code> uit in Supabase.</td></tr>';
    return;
  }

  tbody.innerHTML = users.map(u => {
    const isAdm  = adminIds.has(u.user_id);
    const isSelf = u.user_id === currentUserId;
    const date   = u.created_at
      ? new Date(u.created_at).toLocaleDateString('nl-BE', { day: '2-digit', month: '2-digit', year: 'numeric' })
      : '–';

    const rolBadge = isAdm
      ? '<span class="badge bg-danger">Admin</span>'
      : '<span class="badge bg-secondary">Kijker</span>';

    const isOwner = u.email === 'robbe.peeters.95@gmail.com';

    let actionBtn;
    if (isOwner) {
      // Owner account is permanently protected — no one can demote it
      actionBtn = '<span class="badge bg-dark">Eigenaar</span>';
    } else if (isSelf) {
      // Can't demote yourself
      actionBtn = '<span class="text-muted small fst-italic">Jij</span>';
    } else if (isAdm) {
      actionBtn = `<button class="btn btn-sm btn-outline-secondary"
                           onclick="toggleAdmin('${u.user_id}', false)">
                     Maak kijker
                   </button>`;
    } else {
      actionBtn = `<button class="btn btn-sm btn-outline-danger"
                           onclick="toggleAdmin('${u.user_id}', true)">
                     Maak admin
                   </button>`;
    }

    return `<tr>
      <td>${u.email}</td>
      <td class="text-center" style="white-space:nowrap">${date}</td>
      <td class="text-center">${rolBadge}</td>
      <td class="text-center">${actionBtn}</td>
    </tr>`;
  }).join('');
}

async function toggleAdmin(userId, makeAdmin) {
  if (makeAdmin) {
    const { error } = await supabaseClient.from('admins').insert({ user_id: userId });
    if (error) { showToast('Fout: ' + error.message); return; }
    adminIds.add(userId);
    showToast('Gebruiker is nu admin.');
  } else {
    const { error } = await supabaseClient.from('admins').delete().eq('user_id', userId);
    if (error) { showToast('Fout: ' + error.message); return; }
    adminIds.delete(userId);
    showToast('Gebruiker is nu kijker.');
  }
  renderUsersAdmin();
}

async function signOut() {
  await supabaseClient.auth.signOut();
  window.location.href = 'login.html';
}

function showToast(message) {
  const container = document.getElementById('toast-container');
  const id = 'toast-' + Date.now();
  container.insertAdjacentHTML('beforeend', `
    <div id="${id}" class="toast align-items-center text-bg-success border-0 show" role="alert">
      <div class="d-flex">
        <div class="toast-body">${message}</div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
      </div>
    </div>`);
  setTimeout(() => document.getElementById(id)?.remove(), 3000);
}
