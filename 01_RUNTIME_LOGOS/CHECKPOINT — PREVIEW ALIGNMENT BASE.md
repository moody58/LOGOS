# CHECKPOINT — PREVIEW ALIGNMENT BASE

DATA: 2026-04-30

------------------------------------------------
NODO
------------------------------------------------

PREVIEW ALIGNMENT BASE

------------------------------------------------
CONTESTO
------------------------------------------------

Nodo avviato dopo completamento di:

ENGINE BASE — NORMALIZATION LAYER BASE

Il sistema disponeva già di:

- parse_input_controlled stabilizzato
- ui_state.parsed come fonte unica dei dati strutturati
- amount/unit/event_date normalizzati lato parser
- insert_event / update_event allineati a ui_state.parsed
- DB invariato e passivo
- preview ancora parzialmente non allineata sul piano visuale

------------------------------------------------
SCOPO DEL NODO
------------------------------------------------

Allineare la preview/sintesi ai dati già normalizzati in ui_state.parsed,
senza modificare parsing, database, matching o type classification.

Obiettivi specifici:

- formattazione visuale amount in stile italiano
- visualizzazione coerente unit
- lettura coerente da ui_state.parsed
- label cleaning su casi già normalizzati
- micro-correzioni solo della sintesi/preview
- test runtime senza alterare DB

------------------------------------------------
SCOPE RISPETTATO
------------------------------------------------

Interventi eseguiti SOLO su:

- componente Retool: sintesi
- value builder della preview
- label cleaning visuale
- separatore data/label
- token filtering locale per highlight preview

NON sono stati modificati:

- parse_input_controlled
- trigger_parse_debounced
- button_input_confirm
- insert_event
- update_event
- schema DB
- Supabase
- project_state
- entity_state
- select_project
- select_entity
- select1
- matching reale
- type classification
- duration normalization
- dashboard/KPI

------------------------------------------------
STATO PRIMA
------------------------------------------------

La preview mostrava valori tecnicamente corretti ma visualmente non allineati.

Esempi:

1.500,50 euro materiale
→ 1500.5 € • 1.500,50 euro materiale

18 minuti test
→ 18 minuti • uti • test

6/4/26 inseminazione alfie
→ 6 apr inseminazione alfie

2 ore sopralluogo villa 2
→ la parola "ore" poteva essere evidenziata in verde perché intercettata dall'highlight locale

------------------------------------------------
MODIFICHE APPLICATE
------------------------------------------------

STEP 1 — VALUE FORMAT

È stato sostituito il blocco VALUE della sintesi.

Obiettivo:

- formattare amount solo a livello visuale
- mantenere amount numerico in ui_state.parsed
- mostrare euro con decimali italiani
- mostrare tempo con virgola italiana
- gestire singolare/plurale delle unità

Codice introdotto:

const formatAmountIT = (amount, unit) => {
  const num = Number(amount);

  if (!Number.isFinite(num)) return null;

  if (unit === "euro") {
    return num.toLocaleString("it-IT", {
      useGrouping: true,
      minimumFractionDigits: 2,
      maximumFractionDigits: 2
    });
  }

  if (unit === "ore" || unit === "minuti") {
    return num.toLocaleString("it-IT", {
      useGrouping: true,
      minimumFractionDigits: 0,
      maximumFractionDigits: 2
    });
  }

  return num.toLocaleString("it-IT", {
    useGrouping: true,
    minimumFractionDigits: 0,
    maximumFractionDigits: 2
  });
};

const formatUnitIT = (amount, unit) => {
  const num = Number(amount);

  if (unit === "euro") return "€";
  if (unit === "ore") return num === 1 ? "ora" : "ore";
  if (unit === "minuti") return num === 1 ? "minuto" : "minuti";

  return unit;
};

let value = null;

if (parsedAmount && parsedUnit) {
  const amountLabel = formatAmountIT(parsedAmount, parsedUnit);
  const unitLabel = formatUnitIT(parsedAmount, parsedUnit);

  if (amountLabel && unitLabel) {
    value = `<span style="font-weight:600;">${amountLabel} ${unitLabel}</span>`;
  }
}

Risultato:

1500 euro materiale
→ 1.500,00 € • materiale

1.500,50 euro materiale
→ 1.500,50 € • materiale

1ora lavoro
→ 1 ora • lavoro

18 minuti test
→ 18 minuti • test

------------------------------------------------
STEP 2 — LABEL CLEANING BASE
------------------------------------------------

È stato sostituito il blocco LABEL CLEAN.

Obiettivo:

- rimuovere amount + unit già rappresentati dal value builder
- correggere il bug "minuti" → "uti"
- gestire unità compatte e separate
- preservare numeri semantici come "villa 2"
- non modificare raw_input, parser o DB

Correzione principale:

l'ordine delle unità nel cleaning è stato modificato mettendo:

minuti / minuto / min

prima di:

min

per evitare residui testuali.

Codice introdotto:

let note = lowerText;

note = note
  .replace(/€/g, " € ")

  // unità compatte
  // ordine importante: "minuti" prima di "min"
  // per evitare residui tipo "uti"
  .replace(/(\d)(minuti|minuto|min|ore|ora|h)/g, "$1 $2")
  .replace(/(minuti|minuto|min|ore|ora|h)(\d)/g, "$1 $2")

  .replace(/\s+/g, " ")
  .trim();

if (parsedAmount && parsedUnit) {
  note = note
    // euro separati o compatti
    .replace(/\b\d{1,3}(?:\.\d{3})*(?:[,.]\d+)?\s*(€|euro|eur)\b/gi, " ")
    .replace(/\b\d+(?:[,.]\d+)?\s*(€|euro|eur)\b/gi, " ")
    .replace(/\b(€|euro|eur)\s*\d{1,3}(?:\.\d{3})*(?:[,.]\d+)?\b/gi, " ")
    .replace(/\b(€|euro|eur)\s*\d+(?:[,.]\d+)?\b/gi, " ")

    // ore separate o compatte
    .replace(/\b\d+(?:[,.]\d+)?\s*(ore|ora|h)\b/gi, " ")
    .replace(/\b(h)\s*\d+(?:[,.]\d+)?\b/gi, " ")

    // minuti separati o compatti
    .replace(/\b\d+(?:[,.]\d+)?\s*(minuti|minuto|min)\b/gi, " ")
    .replace(/\b(minuti|minuto|min)\s*\d+(?:[,.]\d+)?\b/gi, " ")

    .replace(/\s+/g, " ")
    .trim();
}

note = note
  .replace(/\b\d{1,2}\/\d{1,2}(?:\/\d{2,4})?\b/g, "")
  .replace(/\b\d{1,2}\s+(gennaio|febbraio|marzo|aprile|maggio|giugno|luglio|agosto|settembre|ottobre|novembre|dicembre)\b/g, "")
  .replace(/\b20\d{2}\b/g, "")
  .replace(/\s+/g, " ")
  .trim();

const words = note.split(" ");
const combined = [];

for (let i = 0; i < words.length; i++) {
  if (words[i + 1] && /^\d+$/.test(words[i + 1])) {
    combined.push(words[i] + " " + words[i + 1]);
    i++;
  } else {
    combined.push(words[i]);
  }
}

note = combined.join(" ").trim();
note = note.split(" ").slice(0, 6).join(" ");

Risultato:

1.500,50 euro materiale
→ 1.500,50 € • materiale

10 euro benzina sopralluogo aspri test
→ 10,00 € • benzina sopralluogo aspri test

18 minuti test
→ 18 minuti • test

18min test
→ 18 minuti • test

sopralluogo villa 2 per 18 minuti
→ 18 minuti • sopralluogo villa 2 per

villa 2 mario
→ villa 2 mario

------------------------------------------------
STEP 3 — DATE SEPARATOR
------------------------------------------------

È stato modificato il blocco LABEL BASE.

Prima:

se non era presente amount/unit, data e label venivano unite con spazio semplice.

Esempio:

6/4/26 inseminazione alfie
→ 6 apr inseminazione alfie

Dopo:

anche in assenza di amount/unit, la data viene separata con " • ".

Codice modificato:

let main = null;

if (parsedAmount && parsedUnit) {
  main = [displayDate, value, note].filter(Boolean).join(" • ");
} else {
  main = [displayDate, note].filter(Boolean).join(" • ");
}

let labelStyled = main;

Risultato:

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

4 aprile inseminazione alfie
→ 4 apr • inseminazione alfie

------------------------------------------------
STEP 4 — GROUPING MIGLIAIA
------------------------------------------------

È stato aggiunto useGrouping: true nella formattazione visuale.

Obiettivo:

- mostrare migliaia in formato italiano
- non modificare il dato interno numerico

Risultato:

1500 euro materiale
→ 1.500,00 € • materiale

1.500,50 euro materiale
→ 1.500,50 € • materiale

1500 minuti test
→ 1.500 minuti • test

18 minuti test
→ 18 minuti • test

------------------------------------------------
STEP 5 — HIGHLIGHT UNIT SAFE
------------------------------------------------

Problema rilevato:

la parola "ore" poteva essere evidenziata in verde perché il sistema di highlight locale lavorava sull'intera labelStyled, incluso il value.

Causa:

"ore" ha lunghezza 3 e passava il filtro:

tokens.length >= 3

Soluzione:

aggiunto filtro locale per escludere token tecnici già rappresentati dal value.

Codice introdotto prima della detection entità/progetti:

const previewStopTokens = [
  "ora",
  "ore",
  "h",
  "min",
  "minuto",
  "minuti",
  "euro",
  "eur"
];

const getPreviewTokens = () =>
  lowerText
    .split(" ")
    .map(t => t.trim())
    .filter(t => t.length >= 3)
    .filter(t => !previewStopTokens.includes(t));

Sono state sostituite le ricorrenze locali:

const tokens = lowerText.split(" ").filter(t => t.length >= 3);

con:

const tokens = getPreviewTokens();

nei blocchi:

- detectedEntities
- detectedProjects
- detectedEntities.forEach
- detectedProjects.forEach

Risultato:

2 ore sopralluogo villa 2
→ "ore" non viene più colorato come match

2,7 ore sviluppo sistema aspri
→ "ore" non viene più colorato come match

18 minuti test
→ "minuti" non viene evidenziato

10 euro benzina...
→ "euro" non interferisce con highlight

------------------------------------------------
TEST ESEGUITI
------------------------------------------------

VALUE / AMOUNT FORMAT

Input:

1.500,50 euro materiale

Output preview:

1.500,50 € • materiale

Esito: OK

---

Input:

1500 euro materiale

Output preview:

1.500,00 € • materiale

Esito: OK

---

Input:

1500 minuti test

Output preview:

1.500 minuti • test

Esito: OK

---

Input:

18 minuti test

Output preview:

18 minuti • test

Esito: OK

------------------------------------------------
LABEL CLEANING
------------------------------------------------

Input:

10 euro benzina sopralluogo aspri test

Output preview:

10,00 € • benzina sopralluogo aspri test

Esito: OK

---

Input:

18 minuti test

Output preview:

18 minuti • test

Esito: OK

---

Input:

18min test

Output preview:

18 minuti • test

Esito: OK

---

Input:

sopralluogo villa 2 per 18 minuti

Output preview:

18 minuti • sopralluogo villa 2 per

Esito: OK

Nota:

il residuo "per" è accettato nel nodo corrente.
Non è stata introdotta una nuova stopword logic.

---

Input:

villa 2 mario

Output preview:

villa 2 mario

Esito: OK

Nota:

il numero semantico "2" è preservato.

------------------------------------------------
DATE
------------------------------------------------

Input:

6/4/26 inseminazione alfie

Output preview:

6 apr • inseminazione alfie

Esito: OK

---

Input:

4 aprile inseminazione alfie

Output preview:

4 apr • inseminazione alfie

Esito: OK

---

Input:

4 aprile benzina 50 euro alfie allevamento aspri

Output preview:

4 apr • 50,00 € • benzina alfie allevamento aspri

Esito: OK

------------------------------------------------
HIGHLIGHT
------------------------------------------------

Input:

2 ore sopralluogo villa 2

Output preview:

2 ore • sopralluogo villa 2

Esito: OK

Nota:

"ore" non viene più colorato impropriamente.

---

Input:

2,7 ore sviluppo sistema aspri

Output preview:

2,7 ore • sviluppo sistema aspri

Esito: OK

Nota:

"Verifica durata" può comparire e resta accettato.

---

Input:

villa 2 mario

Output preview:

villa 2 mario

Esito: OK

Nota:

project/entity highlight continuano a funzionare.

------------------------------------------------
STATO FINALE
------------------------------------------------

La preview è ora allineata al Normalization Layer Base.

Risultati ottenuti:

- amount visualizzato in formato italiano
- euro mostrato con due decimali
- migliaia visualizzate correttamente
- tempo mostrato con virgola italiana
- singolare/plurale gestito
- unità visuali coerenti
- label ripulita da amount/unit già rappresentati
- bug "minuti" → "uti" risolto
- numeri semantici preservati
- date separate correttamente dalla descrizione
- highlight non interferisce più con unità tecniche
- sintesi più leggibile e coerente
- nessuna modifica al dato persistito

------------------------------------------------
STATO DB / SAVE FLOW
------------------------------------------------

Nessuna modifica eseguita a:

- insert_event
- update_event
- button_input_confirm
- Supabase
- schema DB

Il dato interno resta invariato:

1.500,50 euro
→ ui_state.parsed.amount = 1500.5
→ ui_state.parsed.unit = euro
→ preview = 1.500,50 €
→ DB amount = 1500.5

La formattazione italiana resta solo visuale.

------------------------------------------------
LIMITI RESIDUI
------------------------------------------------

Il nodo NON ha implementato:

- duration normalization
- 1 ora e 15 minuti
- 2h30
- 2 ore 30
- giorni / settimane
- unità canonica durata
- type classification
- spesa/incasso
- parole chiave economiche
- matching unificato
- priority match
- hint completamente state-driven
- dashboard / KPI
- preview come view pura completa
- refactor globale della sintesi

------------------------------------------------
NOTE OPERATIVE
------------------------------------------------

La preview resta ancora un layer ibrido:

- rendering dati
- label cleaning
- hint logic
- highlight locale

Tuttavia il nodo ha ridotto la divergenza principale tra dato normalizzato e visualizzazione utente.

Il sistema è ora più coerente per l'uso reale in input.

------------------------------------------------
DOCUMENTI DA AGGIORNARE
------------------------------------------------

Aggiornare:

1. 00_PROJECT_State
   - portare PREVIEW ALIGNMENT BASE a COMPLETATO
   - indicare preview allineata a ui_state.parsed per amount/unit/date
   - mantenere limiti duration/type/matching fuori scope

2. 00_PROJECT_Roadmap
   - segnare TRANSIZIONE → PREVIEW ALIGNMENT BASE come completata
   - mantenere STEP 6.2 — DURATION NORMALIZATION come candidato successivo

3. 06_LOGOS_View_Preview_System
   - aggiornare comportamento reale della sintesi
   - documentare formatAmountIT / formatUnitIT
   - documentare label cleaning aggiornato
   - documentare token filter previewStopTokens

4. LOGOS_RETOOL_RUNTIME_REAL
   - aggiornare sezione PREVIEW / SINTESI
   - indicare che amount è formattato solo visualmente
   - dichiarare invariato save flow

5. 04_LOGOS_Retool_Architecture
   - aggiornare descrizione container_input / sintesi
   - dichiarare preview più coerente ma ancora non view pura

Opzionale:

6. 01_LOGOS_Input_System
   - aggiornare solo se si vuole esplicitare che la preview ora rappresenta meglio i dati derivati da ui_state.parsed

------------------------------------------------
ARCHIVIAZIONE
------------------------------------------------

Il checkpoint precedente:

CHECKPOINT_ENGINE_BASE_NORMALIZATION_LAYER_BASE

può essere archiviato come checkpoint completato.

Non deve essere cancellato perché contiene:

- codice finale parse_input_controlled
- codice finale button_input_confirm
- logica ui_state.parsed
- normalizzazione amount/unit
- insert/update verificati
- base tecnica su cui poggia il presente nodo

Stato consigliato:

ARCHIVIATO / COMPLETATO

Il checkpoint attivo più recente diventa:

CHECKPOINT — PREVIEW ALIGNMENT BASE

------------------------------------------------
CQD — VALIDAZIONE CHECKPOINT
------------------------------------------------

C — Completezza: 10/10

- documentato stato prima/dopo
- documentate modifiche applicate
- documentati test eseguiti
- documentati limiti residui
- documentati documenti da aggiornare
- documentata archiviazione checkpoint precedente

Q — Qualità: 9.5/10

- checkpoint coerente con scope dichiarato
- nessuna deriva verso parser, DB, matching o type
- descrizione tecnica sufficiente per ricostruire il nodo
- limiti residui esplicitati

D — Deployabilità: 10/10

- modifiche già applicate e validate runtime
- nessuna dipendenza mancante
- nessuna modifica strutturale richiesta
- pronto per aggiornamento documentale

------------------------------------------------
VALIDAZIONE FINALE
------------------------------------------------

Nodo: OK
Scope: OK
Deviazione: NO

STATO:

PREVIEW ALIGNMENT BASE — COMPLETATO