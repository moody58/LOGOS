Dopo:

{
  "view": "home",
  "parsed": {
    "amount": null,
    "unit": null,
    "event_date": null
  },
  "status": null,
  "feedback_text": null,
  "feedback_project": null
}

Risultato:

ui_state.parsed sempre presente
riduzione rischio null access
state coerente con save flow
2. Stabilizzazione success handler di parse_input_controlled

Success handler finale:

const parsed = parse_input_controlled.data || {};

ui_state.setValue({
  ...ui_state.value,
  parsed: {
    amount: parsed.amount ?? null,
    unit: parsed.unit ?? null,
    event_date: parsed.event_date ?? null
  }
});

Risultato:

parse_input_controlled aggiorna sempre ui_state.parsed
parsed mantiene forma stabile
amount/unit/event_date non restano undefined
3. Patch unità compatte e numero senza unità

Problemi rilevati:

1ora lavoro → unit null
villa 2 mario → amount 2

Correzioni implementate in parse_input_controlled:

riconoscimento unità compatte:
1ora
2ore
18min
30minuti
1.5ore
1,5 ore
rimozione fallback amount quando manca unit

Regola introdotta:

Se non esiste unità riconosciuta:
amount = null

Risultato:

1ora lavoro → amount 1, unit ore
villa 2 mario → amount null, unit null
4. Normalizzazione amount formato italiano

Aggiunta funzione:

function normalizeNumberValue(value) {
  if (value === null || value === undefined || value === "") {
    return null;
  }

  const raw = String(value).trim();

  // Formato italiano con migliaia + decimali:
  // 1.500,50 → 1500.50
  if (/^\d{1,3}(\.\d{3})+,\d+$/.test(raw)) {
    return Number(raw.replace(/\./g, "").replace(",", "."));
  }

  // Formato italiano con separatore migliaia:
  // 1.500 → 1500
  if (/^\d{1,3}(\.\d{3})+$/.test(raw)) {
    return Number(raw.replace(/\./g, ""));
  }

  // Formato con virgola decimale:
  // 458,78 → 458.78
  // 1,5 → 1.5
  if (/^\d+,\d+$/.test(raw)) {
    return Number(raw.replace(",", "."));
  }

  // Formato con punto decimale compatibile:
  // 1.5 → 1.5
  if (/^\d+\.\d+$/.test(raw)) {
    return Number(raw);
  }

  // Intero semplice:
  // 1500 → 1500
  if (/^\d+$/.test(raw)) {
    return Number(raw);
  }

  return null;
}

Regex numeri aggiornata:

const numbers = cleanForParsing.match(/\d{1,3}(?:\.\d{3})+(?:,\d+)?|\d+(?:[.,]\d+)?/g);

Conversione amount finale:

amount = best ? normalizeNumberValue(best) : null;

Risultati validati:

458,78 euro mangime       → amount 458.78, unit euro
1.500 euro materiale      → amount 1500, unit euro
1.500,50 euro materiale   → amount 1500.5, unit euro
1.5 ore sopralluogo       → amount 1.5, unit ore
1,5 ore sopralluogo       → amount 1.5, unit ore
villa 2 mario             → amount null, unit null
2 ore sopralluogo villa 2 → amount 2, unit ore

Nota:

il dato interno resta numerico
la formattazione italiana è tema di preview/output futuro
il DB riceve amount numeric, non stringhe formattate
5. Rimozione debug temporaneo

Rimosso da button_input_confirm:

console.log("LOGOS PAYLOAD TEST", payload);

Risultato:

console pulita
nessun impatto runtime
6. Stabilizzazione reset parsed in button_input_confirm

Prima:

parsed: null

Dopo:

parsed: {
  amount: null,
  unit: null,
  event_date: null
}

Risultato:

ui_state.parsed non torna più null dopo save
forma stabile mantenuta anche dopo reset input
nessuna regressione osservata
7. Rimozione parsing legacy da button_input_confirm

Rimosso dal bottone tutto il blocco duplicato:

DATE PARSING
DATE FILTER
UNIT DETECTION
AMOUNT DETECTION

Il bottone ora usa solo:

const parsed = ui_state.value?.parsed || {
  amount: null,
  unit: null,
  event_date: null
};

const payload = {
  raw_input: input_raw.value,
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
};

Risultato:

save flow ripulito
eliminata duplicazione parsing nel bottone
ui_state.parsed è fonte unica per insert/update
ridotto rischio drift preview/save/DB
8. Correzione race condition update → refresh lista

Problema rilevato:

update_event aggiornava correttamente il DB
events_new veniva refreshato troppo presto
la lista mostrava temporaneamente raw_input vecchio
dopo refresh pagina il dato era corretto

Prima:

const savePromise = edit_mode.data
  ? update_event.trigger({ additionalScope: payload })
  : insert_event.trigger({ additionalScope: payload });

events_new.trigger();

await savePromise;

Dopo:

const wasEditMode = edit_mode.data;

const savePromise = wasEditMode
  ? update_event.trigger({ additionalScope: payload })
  : insert_event.trigger({ additionalScope: payload });

await savePromise;

await events_new.trigger();

if (wasEditMode) {
  edit_mode.trigger({
    additionalScope: { value: false }
  });
}

Risultato:

lista aggiornata solo dopo insert/update completato
update visibile immediatamente senza refresh pagina
feedback UI resta immediato
edit_mode ancora funzionante
CODICE FINALE BUTTON_INPUT_CONFIRM
// --- INSERT / UPDATE SWITCH ---
const parsed = ui_state.value?.parsed || {
  amount: null,
  unit: null,
  event_date: null
};

const payload = {
  raw_input: input_raw.value,
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
};

const feedbackText = input_raw.value;
const feedbackProject = select_project.selectedItem?.name;

// 🔥 RESET UI SUBITO (UX istantanea)
ui_state.setValue({
  ...ui_state.value,
  parsed: {
    amount: null,
    unit: null,
    event_date: null
  },
  status: "idle",
  view: "feedback",
  feedback_text: feedbackText,
  feedback_project: feedbackProject
});

input_home.setValue("");
input_raw.setValue("");

select_project.clearValue();
select_entity.clearValue();

// opzionale ma consigliato
trigger_parse_debounced.cancel?.();

const wasEditMode = edit_mode.data;

const savePromise = wasEditMode
  ? update_event.trigger({ additionalScope: payload })
  : insert_event.trigger({ additionalScope: payload });

await savePromise;

await events_new.trigger();

if (wasEditMode) {
  edit_mode.trigger({
    additionalScope: { value: false }
  });
}
CODICE FINALE parse_input_controlled
const text = input_raw.value || "";

if (!text || text.trim() === "") {
  return {
    amount: null,
    unit: null,
    event_date: null
  };
}

// normalizzazione
const clean = text.toLowerCase().replace(/\s+/g, " ").trim();

function normalizeNumberValue(value) {
  if (value === null || value === undefined || value === "") {
    return null;
  }

  const raw = String(value).trim();

  // Formato italiano con migliaia + decimali:
  // 1.500,50 → 1500.50
  if (/^\d{1,3}(\.\d{3})+,\d+$/.test(raw)) {
    return Number(raw.replace(/\./g, "").replace(",", "."));
  }

  // Formato italiano con separatore migliaia:
  // 1.500 → 1500
  if (/^\d{1,3}(\.\d{3})+$/.test(raw)) {
    return Number(raw.replace(/\./g, ""));
  }

  // Formato con virgola decimale:
  // 458,78 → 458.78
  // 1,5 → 1.5
  if (/^\d+,\d+$/.test(raw)) {
    return Number(raw.replace(",", "."));
  }

  // Formato con punto decimale compatibile:
  // 1.5 → 1.5
  if (/^\d+\.\d+$/.test(raw)) {
    return Number(raw);
  }

  // Intero semplice:
  // 1500 → 1500
  if (/^\d+$/.test(raw)) {
    return Number(raw);
  }

  return null;
}

// ------------------
// DATE
// ------------------

let event_date = null;

const dateSlashMatch = clean.match(/\b(\d{1,2})\/(\d{1,2})\/(\d{2,4})\b/);

if (dateSlashMatch) {
  let [, d, m, y] = dateSlashMatch;
  if (y.length === 2) y = "20" + y;
  event_date = `${y}-${m.padStart(2, "0")}-${d.padStart(2, "0")}`;
}

const mesiMap = {
  gennaio:"01", febbraio:"02", marzo:"03", aprile:"04", maggio:"05", giugno:"06",
  luglio:"07", agosto:"08", settembre:"09", ottobre:"10", novembre:"11", dicembre:"12"
};

if (!event_date) {
  const words = clean.split(" ");
  for (let i = 0; i < words.length; i++) {
    if (/^\d{1,2}$/.test(words[i]) && mesiMap[words[i + 1]]) {
      const year = new Date().getFullYear();
      event_date = `${year}-${mesiMap[words[i + 1]]}-${words[i].padStart(2,"0")}`;
      break;
    }
  }
}

// ------------------
// UNIT
// ------------------

let unit = null;

if (clean.match(/€|euro|eur/)) {
  unit = "euro";
} else if (
  clean.match(/\b(ora|ore)\b/) ||
  clean.match(/\d+\s*(h|ora|ore)\b/) ||
  clean.match(/\bh\d+/)
) {
  unit = "ore";
} else if (
  clean.match(/\b(min|minuto|minuti)\b/) ||
  clean.match(/\d+\s*(min|minuto|minuti)\b/) ||
  clean.match(/\b(min|minuto|minuti)\d+/)
) {
  unit = "minuti";
}

// ------------------
// AMOUNT
// ------------------

let amount = null;

const cleanForParsing = clean
  .replace(/\b\d{1,2}\/\d{1,2}(?:\/\d{2,4})?\b/g, "");

const numbers = cleanForParsing.match(/\d{1,3}(?:\.\d{3})+(?:,\d+)?|\d+(?:[.,]\d+)?/g);
const isTimeFormat = clean.match(/\d{1,2}:\d{2}/);

if (numbers && !isTimeFormat) {
  if (unit) {

    const unitMatches = [...clean.matchAll(/€|euro|eur|ora|ore|\d+\s*(h|ora|ore)\b|\bh\d+|\d+\s*(min|minuto|minuti)\b|\b(min|minuto|minuti)\d+/g)];

    let unitIndex = -1;

    if (unitMatches.length > 0) {
      unitIndex = unitMatches[unitMatches.length - 1].index;
    }

    let best = null;
    let bestDist = Infinity;

    numbers.forEach(n => {
      const idx = clean.indexOf(n);
      const dist = Math.abs(idx - unitIndex);

      if (dist < bestDist) {
        bestDist = dist;
        best = n;
      }
    });

    amount = best ? normalizeNumberValue(best) : null;

  } else {
    amount = null;
  }
}

// ------------------
// RETURN
// ------------------

return {
  amount,
  unit,
  event_date
};
TEST ESEGUITI
Parser / preview

Validati:

18min test                  → 18 / minuti
18 minuti test              → 18 / minuti
1ora lavoro                 → 1 / ore
1 ora lavoro                → 1 / ore
20€ materiale               → 20 / euro
villa 2 mario               → null / null
458,78 euro mangime         → 458.78 / euro
1.500 euro materiale        → 1500 / euro
1.500,50 euro materiale     → 1500.5 / euro
1.5 ore sopralluogo         → 1.5 / ore
1,5 ore sopralluogo         → 1.5 / ore
2 ore sopralluogo villa 2   → 2 / ore
Insert DB

Input:

1.500,50 euro test engine

DB:

amount: 1500.5
unit: euro
raw_input: 1.500,50 euro test engine
status: NEW
Insert DB dopo rimozione parsing legacy

Input:

1.500,50 euro test engine 2

DB:

amount: 1500.5
unit: euro
raw_input: 1.500,50 euro test engine 2
status: NEW
Update DB

Input aggiornato:

1,5 ore test engine update

DB:

amount: 1.5
unit: ore
raw_input: 1,5 ore test engine update
status: NEW
Update lista

Problema iniziale:

DB aggiornato correttamente
lista eventi mostrava ancora testo precedente fino a refresh pagina

Correzione:

await savePromise
await events_new.trigger()

Risultato:

lista eventi aggiornata immediatamente dopo update
STATO RAGGIUNTO

Il sistema ora usa un flusso più pulito e coerente:

input_home
→ input_raw
→ trigger_parse_debounced
→ parse_input_controlled
→ ui_state.parsed
→ button_input_confirm
→ insert_event / update_event
→ Supabase
→ events_new refresh

Risultato:

parsing duplicato nel save eliminato
dato salvato coerente con preview parser
insert stabile
update stabile
refresh lista coerente
ui_state.parsed stabile
LIMITI NON RISOLTI

Il nodo NON ha implementato:

conversione multi-unità
1 ora e 15 minuti → 75 minuti / 1.25 ore
2h30
giorni / settimane
normalizzazione durata avanzata
classificazione spesa/incasso
type classification da parole chiave
preview formatting italiano
preview come view pura
matching unificato
priority match engine
hint state-driven
normalizzazione project/entity
deduplicazione
dashboard/KPI
DECISIONI ARCHITETTURALI
amount viene salvato come numero, non come stringa locale.

Esempio:

1.500,50 → 1500.5

La formattazione italiana:

1500.5 → 1.500,50

è demandata a preview/output futuri.

I numeri senza unità NON sono amount.

Esempio:

villa 2 → amount null
La normalizzazione base NON interpreta semanticamente l’evento.

Esempio:

benzina → non classifica ancora come spesa
acconto → non classifica ancora come incasso
La conversione delle durate è rinviata a nodo dedicato.

Esempio:

1 ora e 15 minuti
2 giorni rendering

richiedono regole engine successive.

PROSSIMI NODI SUGGERITI

Ordine consigliato:

PREVIEW ALIGNMENT BASE

Obiettivo:

formattazione italiana amount
visualizzazione coerente con ui_state.parsed
riduzione divergenza sintesi/parser
nessuna modifica DB
ENGINE BASE — DURATION NORMALIZATION

Obiettivo:

multi-unit tempo
1 ora e 15 minuti
2h30
eventuale unità canonica durata
ENGINE BASE — TYPE CLASSIFICATION BASE

Obiettivo:

evento / tempo / economico
eventuale spesa/incasso tramite parole chiave controllate
nessuna automazione decisionale definitiva
MATCH ENGINE UNIFICATION

Obiettivo:

eliminare logiche parallele select/preview/matching
priority match
hint state-driven