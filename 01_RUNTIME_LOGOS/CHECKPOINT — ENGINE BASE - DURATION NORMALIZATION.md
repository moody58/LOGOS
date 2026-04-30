# CHECKPOINT — ENGINE BASE / DURATION NORMALIZATION

DATA: 2026-04-30

------------------------------------------------
NODO
------------------------------------------------

ENGINE BASE — DURATION NORMALIZATION

------------------------------------------------
CONTESTO
------------------------------------------------

Nodo avviato dopo completamento di:

- ENGINE BASE — NORMALIZATION LAYER BASE
- PREVIEW ALIGNMENT BASE

Il sistema disponeva già di:

- parse_input_controlled come parser runtime
- trigger_parse_debounced attivo
- ui_state.parsed come fonte unica dei dati strutturati
- amount/unit/event_date normalizzati lato parser base
- insert_event / update_event allineati a ui_state.parsed
- preview visualmente allineata a ui_state.parsed per amount/unit/date
- DB invariato e passivo
- raw_input preservato
- save flow stabile
- update flow stabile
- events_new aggiornato dopo save completato

------------------------------------------------
SCOPO DEL NODO
------------------------------------------------

Definire e implementare il primo livello controllato di normalizzazione durata.

Obiettivi:

- rendere confrontabili le durate certe
- normalizzare ore/minuti in una rappresentazione unica
- gestire casi multi-unità e compatti
- preservare raw_input
- mantenere invariato lo schema DB
- evitare type classification
- evitare modifiche a matching
- evitare dashboard/KPI
- mantenere il sistema stabile

------------------------------------------------
DECISIONE ARCHITETTURALE
------------------------------------------------

La durata normalizzata viene rappresentata usando i campi esistenti:

amount = durata totale in minuti
unit = "minuti"

raw_input resta invariato e conserva la forma originale inserita dall’utente.

Esempio:

Input:

1 ora e 15 minuti sopralluogo

Output strutturato:

amount: 75
unit: minuti
raw_input: 1 ora e 15 minuti sopralluogo

Motivazione:

- i minuti sono unità canonica stabile
- evitano dati misti tra ore e minuti
- rendono future dashboard/report più semplici
- permettono somma e confronto diretto
- non richiedono modifiche schema DB
- non richiedono payload aggiuntivo
- non sostituiscono raw_input

------------------------------------------------
DECISIONE SU GIORNI / SETTIMANE
------------------------------------------------

Giorni, settimane, giornata e mezza giornata NON vengono convertiti automaticamente.

Motivo:

- “giorno” può significare 24 ore
- oppure giornata lavorativa
- oppure giornata evento/cantiere
- oppure durata non tecnica
- “settimana” può significare 7 giorni o 5 giorni lavorativi

Decisione:

- non convertirli in minuti
- non salvarli come amount/unit
- non lasciarli però silenziosi nella UX
- mostrarli come durata ambigua nella preview

Esempio:

2 giorni rendering

parsed:

amount: null
unit: null

preview:

2 giorni rendering
⚠️ Durata ambigua: specifica ore/minuti per salvarla come tempo analizzabile

------------------------------------------------
SCOPE RISPETTATO
------------------------------------------------

Interventi eseguiti SOLO su:

- parse_input_controlled
- componente sintesi / preview
- label cleaning visuale
- hint durata
- visualizzazione umana della durata normalizzata

NON sono stati modificati:

- button_input_confirm
- insert_event
- update_event
- Supabase
- schema DB
- project_state
- entity_state
- select_project
- select_entity
- matching reale
- type classification
- dashboard/KPI
- payload
- retro-normalizzazione storico

------------------------------------------------
STATO PRIMA
------------------------------------------------

Il sistema gestiva solo durate semplici.

Esempi precedenti:

1 ora lavoro
→ amount 1
→ unit ore

18min test
→ amount 18
→ unit minuti

2 ore sopralluogo villa 2
→ amount 2
→ unit ore

1 ora e 15 minuti
→ non normalizzato correttamente come durata totale

2h30
→ non normalizzato correttamente come durata totale

2 ore 30
→ non normalizzato correttamente come durata totale

2 giorni rendering
→ non gestito

Problema:

- durate salvate con unità diverse
- dati tempo non pienamente confrontabili
- casi complessi parziali o ambigui
- rischio futuro per dashboard/KPI tempo

------------------------------------------------
MODIFICHE APPLICATE
------------------------------------------------

------------------------------------------------
STEP 1 — PATCH parse_input_controlled
------------------------------------------------

È stato sostituito il codice di parse_input_controlled per introdurre Duration Normalization Base.

Decisione implementata:

- tutte le durate certe ore/minuti vengono convertite in minuti
- amount = totale minuti
- unit = "minuti"
- raw_input non viene modificato
- event_date resta gestito come prima
- euro resta gestito come prima
- numeri senza unità restano esclusi
- giorni/settimane non vengono convertiti

Casi gestiti:

- 18 minuti
- 18min
- min18
- 1 ora
- 1ora
- 2 ore
- 2h
- h2
- 1,5 ore
- 1.5 ore
- 1,5h
- 1.5h
- 1 ora e 15 minuti
- 1 ora 15 minuti
- 2 ore e 30 minuti
- 2 ore 30
- 2h30
- 2 h 30
- 90 minuti

Casi non convertiti:

- 2 giorni
- 1 settimana
- giornata
- giornate
- mezza giornata

------------------------------------------------
CODICE FINALE parse_input_controlled
------------------------------------------------

const text = input_raw.value || "";

if (!text || text.trim() === "") {
  return {
    amount: null,
    unit: null,
    event_date: null
  };
}

// normalizzazione base testo
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
  gennaio: "01",
  febbraio: "02",
  marzo: "03",
  aprile: "04",
  maggio: "05",
  giugno: "06",
  luglio: "07",
  agosto: "08",
  settembre: "09",
  ottobre: "10",
  novembre: "11",
  dicembre: "12"
};

if (!event_date) {
  const words = clean.split(" ");
  for (let i = 0; i < words.length; i++) {
    if (/^\d{1,2}$/.test(words[i]) && mesiMap[words[i + 1]]) {
      const year = new Date().getFullYear();
      event_date = `${year}-${mesiMap[words[i + 1]]}-${words[i].padStart(2, "0")}`;
      break;
    }
  }
}

// ------------------
// DURATION NORMALIZATION BASE
// ------------------

let amount = null;
let unit = null;

const isTimeFormat = /\d{1,2}:\d{2}/.test(clean);

// rimuove date dal testo usato per amount/unit
const cleanForParsing = clean
  .replace(/\b\d{1,2}\/\d{1,2}(?:\/\d{2,4})?\b/g, "")
  .replace(/\b\d{1,2}\s+(gennaio|febbraio|marzo|aprile|maggio|giugno|luglio|agosto|settembre|ottobre|novembre|dicembre)\b/g, "")
  .replace(/\s+/g, " ")
  .trim();

const hasAmbiguousLongDuration =
  /\b\d+(?:[.,]\d+)?\s*(giorno|giorni|settimana|settimane|giornata|giornate)\b/.test(cleanForParsing) ||
  /\b(giorno|giorni|settimana|settimane|giornata|giornate)\s*\d+(?:[.,]\d+)?\b/.test(cleanForParsing) ||
  /\bmezza giornata\b/.test(cleanForParsing);

if (!isTimeFormat && !hasAmbiguousLongDuration) {
  let totalMinutes = null;

  // 1) Formato compatto ore+minuti:
  // 2h30, 2h 30
  const compactHourMinuteMatch = cleanForParsing.match(
    /\b(\d+(?:[.,]\d+)?)\s*h\s*(\d{1,2})\b/
  );

  if (compactHourMinuteMatch) {
    const hours = normalizeNumberValue(compactHourMinuteMatch[1]);
    const minutes = normalizeNumberValue(compactHourMinuteMatch[2]);

    if (hours !== null && minutes !== null) {
      totalMinutes = Math.round(hours * 60 + minutes);
    }
  }

  // 2) Formato ore + minuti testuale:
  // 1 ora e 15 minuti
  // 1 ora 15 minuti
  // 2 ore 30 minuti
  if (totalMinutes === null) {
    const hourMinuteTextMatch = cleanForParsing.match(
      /\b(\d+(?:[.,]\d+)?)\s*(h|ora|ore)\s*(?:e\s*)?(\d{1,2})\s*(min|minuto|minuti)?\b/
    );

    if (hourMinuteTextMatch) {
      const hours = normalizeNumberValue(hourMinuteTextMatch[1]);
      const minutes = normalizeNumberValue(hourMinuteTextMatch[3]);

      if (hours !== null && minutes !== null) {
        totalMinutes = Math.round(hours * 60 + minutes);
      }
    }
  }

  // 3) Formato h + numero:
  // h2
  if (totalMinutes === null) {
    const hBeforeMatch = cleanForParsing.match(/\bh\s*(\d+(?:[.,]\d+)?)\b/);

    if (hBeforeMatch) {
      const hours = normalizeNumberValue(hBeforeMatch[1]);

      if (hours !== null) {
        totalMinutes = Math.round(hours * 60);
      }
    }
  }

  // 4) Formato ore semplice:
  // 1 ora
  // 1ora
  // 2 ore
  // 2h
  // 1,5 ore
  // 1.5h
  if (totalMinutes === null) {
    const simpleHourMatch = cleanForParsing.match(
      /\b(\d+(?:[.,]\d+)?)\s*(h|ora|ore)\b/
    );

    if (simpleHourMatch) {
      const hours = normalizeNumberValue(simpleHourMatch[1]);

      if (hours !== null) {
        totalMinutes = Math.round(hours * 60);
      }
    }
  }

  // 5) Formato minuti semplice:
  // 18 minuti
  // 18min
  // 30 min
  if (totalMinutes === null) {
    const simpleMinuteMatch = cleanForParsing.match(
      /\b(\d+(?:[.,]\d+)?)\s*(min|minuto|minuti)\b/
    );

    if (simpleMinuteMatch) {
      const minutes = normalizeNumberValue(simpleMinuteMatch[1]);

      if (minutes !== null) {
        totalMinutes = Math.round(minutes);
      }
    }
  }

  // 6) Formato minuti con unità prima:
  // min30
  // min 30
  if (totalMinutes === null) {
    const minuteBeforeMatch = cleanForParsing.match(
      /\b(min|minuto|minuti)\s*(\d+(?:[.,]\d+)?)\b/
    );

    if (minuteBeforeMatch) {
      const minutes = normalizeNumberValue(minuteBeforeMatch[2]);

      if (minutes !== null) {
        totalMinutes = Math.round(minutes);
      }
    }
  }

  if (totalMinutes !== null) {
    amount = totalMinutes;
    unit = "minuti";
  }
}

// ------------------
// EURO / ECONOMICO BASE
// ------------------

if (amount === null && unit === null && !isTimeFormat) {
  const hasEuro = /€|euro|eur/.test(cleanForParsing);

  if (hasEuro) {
    unit = "euro";

    const euroUnitMatches = [
      ...cleanForParsing.matchAll(/€|euro|eur/g)
    ];

    const numbers = cleanForParsing.match(
      /\d{1,3}(?:\.\d{3})+(?:,\d+)?|\d+(?:[.,]\d+)?/g
    );

    let unitIndex = -1;

    if (euroUnitMatches.length > 0) {
      unitIndex = euroUnitMatches[euroUnitMatches.length - 1].index;
    }

    let best = null;
    let bestDist = Infinity;

    if (numbers && unitIndex >= 0) {
      numbers.forEach(n => {
        const idx = cleanForParsing.indexOf(n);
        const dist = Math.abs(idx - unitIndex);

        if (dist < bestDist) {
          bestDist = dist;
          best = n;
        }
      });
    }

    amount = best ? normalizeNumberValue(best) : null;
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

------------------------------------------------
STEP 2 — PATCH LABEL CLEANING PREVIEW
------------------------------------------------

Problema rilevato:

La preview mostrava residui dopo la conversione della durata.

Esempi:

2 ore e 30 minuti
→ 150 minuti • e

2h30 rendering
→ 150 minuti • 30 rendering

È stato aggiornato il blocco LABEL CLEAN della sintesi per rimuovere:

- durate composte testuali
- durate compatte tipo 2h30
- residui di congiunzione "e" / "ed"

------------------------------------------------
BLOCCO LABEL CLEAN AGGIORNATO
------------------------------------------------

if (parsedAmount && parsedUnit) {
  note = note
    // duration normalization base — rimozione durata originale già normalizzata
    // esempi:
    // 1 ora e 15 minuti
    // 1 ora 15 minuti
    // 2 ore e 30 minuti
    // 2 ore 30
    // 2h30
    // 2 h 30
    .replace(/\b\d+(?:[,.]\d+)?\s*(h|ora|ore)\s*(?:e\s*)?\d{1,2}\s*(minuti|minuto|min)?\b/gi, " ")
    .replace(/\b\d+(?:[,.]\d+)?\s*h\s*\d{1,2}\b/gi, " ")

    // euro separati o compatti:
    // 1.500,50 euro / 1500,50 euro / 10 euro / 10€ / €10
    .replace(/\b\d{1,3}(?:\.\d{3})*(?:[,.]\d+)?\s*(€|euro|eur)\b/gi, " ")
    .replace(/\b\d+(?:[,.]\d+)?\s*(€|euro|eur)\b/gi, " ")
    .replace(/\b(€|euro|eur)\s*\d{1,3}(?:\.\d{3})*(?:[,.]\d+)?\b/gi, " ")
    .replace(/\b(€|euro|eur)\s*\d+(?:[,.]\d+)?\b/gi, " ")

    // ore separate o compatte:
    // 1 ora / 1,5 ore / 2.2 ore / 2h / h2
    .replace(/\b\d+(?:[,.]\d+)?\s*(ore|ora|h)\b/gi, " ")
    .replace(/\b(h)\s*\d+(?:[,.]\d+)?\b/gi, " ")

    // minuti separati o compatti:
    // 18 minuti / 18min / min30
    .replace(/\b\d+(?:[,.]\d+)?\s*(minuti|minuto|min)\b/gi, " ")
    .replace(/\b(minuti|minuto|min)\s*\d+(?:[,.]\d+)?\b/gi, " ")

    // pulizia congiunzioni residue generate dalla rimozione duration
    .replace(/\b(e|ed)\b/gi, " ")

    .replace(/\s+/g, " ")
    .trim();
}

------------------------------------------------
STEP 3 — VISUALIZZAZIONE UMANA DURATA + HINT NORMALIZZAZIONE
------------------------------------------------

È stata aggiornata la sintesi per evitare che l’utente veda solo il valore tecnico in minuti.

Decisione UX:

- dato interno: sempre minuti
- preview principale: forma umana leggibile
- hint: valore normalizzato tecnico

Esempio:

Input:

2h30 rendering

Preview:

2 ore 30 minuti • rendering
ℹ️ Normalizzato: 150 minuti

DB:

amount: 150
unit: minuti

------------------------------------------------
HELPER AGGIUNTI IN SINTESI
------------------------------------------------

Aggiunto dopo formatUnitIT:

// -----------------------------
// DURATION DISPLAY — BASE
// -----------------------------

const hasHourDurationInput =
  // ore testuali o h semplice:
  // 1 ora, 2 ore, 1,5 ore, 2h
  /\b\d+(?:[,.]\d+)?\s*(h|ora|ore)\b/.test(lowerText) ||

  // formato compatto ore+minuti:
  // 2h30, 2h 30, 2 h 30
  /\b\d+(?:[,.]\d+)?\s*h\s*\d{1,2}\b/.test(lowerText) ||

  // formato h prima del numero:
  // h2
  /\bh\s*\d+(?:[,.]\d+)?\b/.test(lowerText);

const hasAmbiguousLongDuration =
  /\b\d+(?:[,.]\d+)?\s*(giorno|giorni|settimana|settimane|giornata|giornate)\b/.test(lowerText) ||
  /\b(giorno|giorni|settimana|settimane|giornata|giornate)\s*\d+(?:[,.]\d+)?\b/.test(lowerText) ||
  /\bmezza giornata\b/.test(lowerText);

const formatDurationHumanIT = (minutesValue) => {
  const total = Number(minutesValue);

  if (!Number.isFinite(total)) return null;

  const rounded = Math.round(total);
  const hours = Math.floor(rounded / 60);
  const minutes = rounded % 60;

  const hourLabel = hours === 1 ? "ora" : "ore";
  const minuteLabel = minutes === 1 ? "minuto" : "minuti";

  if (hours > 0 && minutes > 0) {
    return `${hours} ${hourLabel} ${minutes} ${minuteLabel}`;
  }

  if (hours > 0) {
    return `${hours} ${hourLabel}`;
  }

  return `${rounded} ${minuteLabel}`;
};

const formatDurationMinutesIT = (minutesValue) => {
  const total = Number(minutesValue);

  if (!Number.isFinite(total)) return null;

  const rounded = Math.round(total);

  return `${rounded.toLocaleString("it-IT", {
    useGrouping: true,
    minimumFractionDigits: 0,
    maximumFractionDigits: 0
  })} ${rounded === 1 ? "minuto" : "minuti"}`;
};

------------------------------------------------
VALUE BUILDER AGGIORNATO
------------------------------------------------

let value = null;

if (parsedAmount && parsedUnit) {

  if (parsedUnit === "minuti" && hasHourDurationInput) {
    const durationLabel = formatDurationHumanIT(parsedAmount);

    if (durationLabel) {
      value = `<span style="font-weight:600;">${durationLabel}</span>`;
    }

  } else {
    const amountLabel = formatAmountIT(parsedAmount, parsedUnit);
    const unitLabel = formatUnitIT(parsedAmount, parsedUnit);

    if (amountLabel && unitLabel) {
      value = `<span style="font-weight:600;">${amountLabel} ${unitLabel}</span>`;
    }
  }
}

------------------------------------------------
PREVIEW STOP TOKENS AGGIORNATI
------------------------------------------------

const previewStopTokens = [
  "ora",
  "ore",
  "h",
  "min",
  "minuto",
  "minuti",
  "euro",
  "eur",
  "giorno",
  "giorni",
  "settimana",
  "settimane",
  "giornata",
  "giornate"
];

------------------------------------------------
HINT DURATA AGGIORNATO
------------------------------------------------

Sostituito vecchio hint “Verifica durata” con due casi:

1. Durata normalizzata

if (parsedUnit === "minuti" && parsedAmount && hasHourDurationInput) {
  const normalizedLabel = formatDurationMinutesIT(parsedAmount);

  if (normalizedLabel) {
    hints.push({
      text: `ℹ️ Normalizzato: ${normalizedLabel}`,
      color: "#6B7280"
    });
  }
}

2. Durata ambigua lunga

if (hasAmbiguousLongDuration && !parsedUnit) {
  hints.push({
    text: "⚠️ Durata ambigua: specifica ore/minuti per salvarla come tempo analizzabile",
    color: "#d97706"
  });
}

------------------------------------------------
TEST ESEGUITI — PARSER / ui_state.parsed
------------------------------------------------

Tutti i test parser indicati sono stati superati.

Durate semplici:

18min test
→ amount 18
→ unit minuti

18 minuti test
→ amount 18
→ unit minuti

1ora lavoro
→ amount 60
→ unit minuti

1 ora lavoro
→ amount 60
→ unit minuti

1,5 ore sopralluogo
→ amount 90
→ unit minuti

1.5h sopralluogo
→ amount 90
→ unit minuti

Durate complesse:

1 ora e 15 minuti sopralluogo
→ amount 75
→ unit minuti

1 ora 15 minuti sopralluogo
→ amount 75
→ unit minuti

2h30 rendering
→ amount 150
→ unit minuti

2 h 30 rendering
→ amount 150
→ unit minuti

2 ore 30 rendering
→ amount 150
→ unit minuti

Numeri semantici:

villa 2 mario
→ amount null
→ unit null

2 ore sopralluogo villa 2
→ amount 120
→ unit minuti

Euro:

20 euro materiale
→ amount 20
→ unit euro

1.500,50 euro materiale
→ amount 1500.5
→ unit euro

Orari:

15:30 test
→ amount null
→ unit null

Giorni / settimane:

2 giorni rendering
→ amount null
→ unit null

1 settimana lavoro
→ amount null
→ unit null

------------------------------------------------
TEST ESEGUITI — PREVIEW / SINTESI
------------------------------------------------

Durate:

1 ora e 15 minuti sopralluogo
→ 1 ora 15 minuti • sopralluogo
→ ℹ️ Normalizzato: 75 minuti

2h30 rendering
→ 2 ore 30 minuti • rendering
→ ℹ️ Normalizzato: 150 minuti

2 ore e 30 minuti rendering
→ 2 ore 30 minuti • rendering
→ ℹ️ Normalizzato: 150 minuti

1,5 ore sopralluogo
→ 1 ora 30 minuti • sopralluogo
→ ℹ️ Normalizzato: 90 minuti

18min test
→ 18 minuti • test
→ nessun hint normalizzato

90 minuti rendering
→ 90 minuti • rendering
→ nessun hint normalizzato

2 ore sopralluogo villa 2
→ 2 ore • sopralluogo villa 2
→ ℹ️ Normalizzato: 120 minuti

Giorni / settimane:

2 giorni rendering
→ 2 giorni rendering
→ ⚠️ Durata ambigua: specifica ore/minuti per salvarla come tempo analizzabile

1 settimana lavoro
→ 1 settimana lavoro
→ ⚠️ Durata ambigua: specifica ore/minuti per salvarla come tempo analizzabile

Regressioni:

20 euro materiale
→ 20,00 € • materiale

1.500,50 euro materiale
→ 1.500,50 € • materiale

villa 2 mario
→ villa 2 mario

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

4 aprile benzina 50 euro alfie allevamento aspri
→ 4 apr • 50,00 € • benzina alfie allevamento aspri

------------------------------------------------
TEST ESEGUITI — INSERT DB
------------------------------------------------

Inserimenti testati:

1 ora e 15 minuti test duration

DB:

amount: 75
unit: minuti
raw_input: 1 ora e 15 minuti test duration
status: NEW

Esito: OK

---

2h30 test duration

DB:

amount: 150
unit: minuti
raw_input: 2h30 test duration
status: NEW

Esito: OK

---

1,5 ore test duration

DB:

amount: 90
unit: minuti
raw_input: 1,5 ore test duration
status: NEW

Esito: OK

---

20 euro test duration

DB:

amount: 20
unit: euro
raw_input: 20 euro test duration
status: NEW

Esito: OK

---

villa 2 test duration

DB:

amount: null
unit: null
raw_input: villa 2 test duration
status: NEW

Esito: OK

Nota:

project_id può essere valorizzato dal matching/select.
Non è collegato al nodo Duration Normalization.

---

2 giorni test duration

DB:

amount: null
unit: null
raw_input: 2 giorni test duration
status: NEW

Esito: OK secondo decisione corrente.

------------------------------------------------
TEST ESEGUITI — UPDATE DB
------------------------------------------------

Evento modificato con input:

2 ore e 30 minuti test duration update

DB:

amount: 150
unit: minuti
raw_input: 2 ore e 30 minuti test duration update
status: NEW
updated_at aggiornato

Esito: OK

Lista eventi:

aggiornata subito dopo update senza refresh pagina

Esito: OK

------------------------------------------------
TEST FINALE DI REGRESSIONE DB
------------------------------------------------

Insert finale durata:

2h30 regressione finale

DB:

amount: 150
unit: minuti
raw_input: 2h30 regressione finale
status: NEW

Esito: OK

---

Insert finale euro:

30 euro regressione finale

DB:

amount: 30
unit: euro
raw_input: 30 euro regressione finale
status: NEW

Esito: OK

---

Update finale:

1 ora e 45 minuti regressione finale update

DB:

amount: 105
unit: minuti
raw_input: 1 ora e 45 minuti regressione finale update
status: NEW
updated_at aggiornato

Esito: OK

------------------------------------------------
STATO FINALE
------------------------------------------------

Il nodo ENGINE BASE — DURATION NORMALIZATION è completato.

Risultati ottenuti:

- durate certe normalizzate in minuti
- amount/unit tempo resi confrontabili
- raw_input preservato
- DB invariato
- insert stabile
- update stabile
- preview leggibile
- hint normalizzazione aggiunto
- giorni/settimane segnalati come ambigui
- nessuna conversione automatica rischiosa per giorni/settimane
- euro non regredito
- numeri semantici preservati
- date non regredite
- save flow invariato
- matching non modificato
- type classification non modificata

------------------------------------------------
STATO DB / SAVE FLOW
------------------------------------------------

Nessuna modifica eseguita a:

- insert_event
- update_event
- button_input_confirm
- Supabase
- schema DB

Il dato interno viene salvato così:

Input:

2h30 rendering

ui_state.parsed:

amount: 150
unit: minuti

preview:

2 ore 30 minuti • rendering
ℹ️ Normalizzato: 150 minuti

DB:

amount: 150
unit: minuti
raw_input: 2h30 rendering

------------------------------------------------
LIMITI RESIDUI
------------------------------------------------

Il nodo NON ha implementato:

- conversione giorni/settimane
- gestione giornata lavorativa
- gestione mezza giornata
- parole numeriche tipo “due ore”
- forme colloquiali tipo “un paio d’ore”
- “2h e mezza”
- type classification
- spesa/incasso
- match engine unification
- dashboard/KPI
- retro-normalizzazione dati storici
- nuovo campo duration_minutes
- uso strutturale di payload.duration
- preview come view pura completa

------------------------------------------------
OSSERVAZIONI NON BLOCCANTI
------------------------------------------------

1. Flash preview durante digitazione

Durante la digitazione la sintesi può mostrare per pochi istanti la forma raw dell’input prima dell’aggiornamento di ui_state.parsed tramite debounce.

Esempio:

2,5 ore

può apparire momentaneamente come:

2,5 ore

e poi diventare:

2 ore 30 minuti
ℹ️ Normalizzato: 150 minuti

Impatto:

solo UX lieve.

Stato:

non corretto nel nodo per evitare interventi sul flusso reattivo input → debounce → parser → preview.

---

2. Lista eventi — “modificato oggi”

La lista eventi mostra “modificato oggi” anche per eventi appena inseriti.

Causa probabile:

updated_at viene valorizzato anche in insert_event.
La UI della lista interpreta la presenza di updated_at come modifica,
senza distinguere created_at / updated_at o insert/update.

Impatto:

solo visuale / UX.

Stato:

fuori scope.
Da rimandare a nodo UI / EVENTS LIST LABEL.

---

3. Type/select1

In alcuni casi, ad esempio:

2h30 rendering

il parser normalizza correttamente:

amount: 150
unit: minuti

ma select1 può restare su “Evento” invece di “Tempo”.

Impatto:

visuale / type.
Non impatta il dato salvato.

Stato:

fuori scope.
Da rimandare a ENGINE BASE — TYPE CLASSIFICATION BASE o micro-nodo select1/type detection.

------------------------------------------------
DOCUMENTI DA AGGIORNARE
------------------------------------------------

Aggiornare:

1. 00_PROJECT_State

- portare STEP 6.2 — ENGINE BASE / DURATION NORMALIZATION a COMPLETATO
- documentare unità canonica tempo = minuti
- documentare conversione ore/minuti in minuti
- documentare giorni/settimane come ambigui non convertiti
- mantenere type/matching/output fuori scope

2. 00_PROJECT_Roadmap

- segnare STEP 6.2 completato
- mantenere STEP 6.3 — TYPE CLASSIFICATION BASE come candidato successivo
- mantenere Match Engine Unification come nodo futuro
- mantenere Output bloccato fino a type/matching/data quality sufficienti

3. 01_LOGOS_Input_System

- aggiornare parsing duration
- documentare normalizzazione tempo in minuti
- aggiornare test validati
- documentare hint durata ambigua

4. LOGOS_RETOOL_RUNTIME_REAL

- aggiornare parse_input_controlled
- aggiornare preview/sintesi
- documentare duration normalization
- documentare test insert/update

5. 04_LOGOS_Retool_Architecture

- aggiornare sezione Parsing Flow + Normalization Base
- aggiornare sezione Preview
- documentare che amount/unit tempo sono canonici in minuti

6. 05_LOGOS_Database_Schema

- chiarire che schema resta invariato
- documentare che il campo amount/unit può contenere durata canonica in minuti
- documentare che raw_input resta fonte originaria

7. 06_LOGOS_View_Preview_System

- aggiornare value builder durata
- documentare formatDurationHumanIT
- documentare formatDurationMinutesIT
- documentare hint “Normalizzato”
- documentare hint durata ambigua

Opzionale:

8. 00_PROJECT_Gap_Register

- portare Duration Normalization da VALIDATO a INTEGRATO PARZIALE o INTEGRATO BASE
- mantenere aperti gap su giorni/settimane, payload duration, dashboard tempo e type classification

------------------------------------------------
ARCHIVIAZIONE
------------------------------------------------

Checkpoint precedente:

CHECKPOINT — PREVIEW ALIGNMENT BASE

Stato consigliato:

ARCHIVIATO / COMPLETATO

Non cancellare perché contiene:

- formatAmountIT
- formatUnitIT
- label cleaning precedente
- previewStopTokens
- base visuale su cui poggia Duration Normalization

Checkpoint precedente engine:

CHECKPOINT — ENGINE BASE NORMALIZATION LAYER BASE

Stato consigliato:

ARCHIVIATO / COMPLETATO

Non cancellare perché contiene:

- codice base parse_input_controlled precedente
- normalizzazione amount/unit
- eliminazione parsing legacy da confirm
- stabilizzazione ui_state.parsed
- save flow allineato

Checkpoint attivo più recente:

CHECKPOINT — ENGINE BASE / DURATION NORMALIZATION

------------------------------------------------
CQD — VALIDAZIONE CHECKPOINT
------------------------------------------------

C — Completezza: 10/10

- documentato contesto
- documentata decisione architetturale
- documentata rappresentazione duration
- documentato codice parse_input_controlled
- documentate modifiche preview/sintesi
- documentati test parser
- documentati test preview
- documentati test DB insert/update
- documentati limiti residui
- documentati bug fuori scope
- documentati documenti da aggiornare

Q — Qualità: 9.5/10

- soluzione coerente con sistema reale
- nessuna modifica DB
- nessuna modifica matching
- nessuna type classification
- dato più confrontabile
- raw_input preservato
- preview più chiara
- giorni/settimane gestiti come ambigui senza conversione rischiosa

D — Deployabilità: 10/10

- modifiche applicate e validate runtime
- insert verificato
- update verificato
- regressioni principali superate
- nessuna dipendenza mancante
- sistema pronto per aggiornamento documentale

------------------------------------------------
VALIDAZIONE FINALE
------------------------------------------------

Nodo: OK
Scope: OK
Deviazione: NO

STATO:

ENGINE BASE — DURATION NORMALIZATION — COMPLETATO