# LOGOS_RETOOL_RUNTIME_REAL_v05

DATA: 2026-04-30

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- copertura completa runtime reale  
- input → parsing → normalization → matching → preview → insert/update → processing  
- script allineati al sistema attuale  
- insert/update flow documentato  
- ui_state.parsed documentato come fonte unica  
- refresh lista post-save documentato  

Q (Qualità): 9/10  
- runtime reale aggiornato  
- distinzione chiara tra parser, normalization base, preview e save flow  
- debiti residui esplicitati  
- non descrive funzionalità non implementate come attive  

D (Deployabilità): 10/10  
- utilizzabile come riferimento tecnico reale  
- allineato a Retool  
- utile per ricostruire il runtime effettivo  

------------------------------------------------
STATO
------------------------------------------------

→ SISTEMA REALE DOCUMENTATO (AS-IS)

Runtime aggiornato dopo completamento:

ENGINE BASE — NORMALIZATION LAYER BASE

------------------------------------------------
DESCRIZIONE OPERATIVA DEL SISTEMA
------------------------------------------------

Il sistema LOGOS è un Event Operating System client-side
in cui tutta la logica applicativa è gestita in Retool tramite JavaScript.

Supabase funge da storage layer passivo.

Flusso attuale:

INPUT  
→ PARSING CONTROLLED  
→ NORMALIZATION BASE  
→ MATCHING  
→ PREVIEW  
→ INSERT / UPDATE  
→ REFRESH LISTA  
→ PROCESSING  

✔ allineamento save → DB verificato  
✔ insert e update usano ui_state.parsed  
✔ normalizzazione amount/unit base attiva  
✔ update visibile in lista senza refresh pagina  

------------------------------------------------
1. INPUT UTENTE
------------------------------------------------

Componente:

input_home

Ruolo:

- input libero
- campo visibile all’utente
- source of truth lato UX

Caratteristiche:

- non bloccante
- senza validazione formale
- accetta testo naturale
- utilizzato per create/edit

Sync:

input_home
→ input_raw

input_raw è l’adapter tecnico nascosto.

------------------------------------------------
2. INPUT_RAW
------------------------------------------------

Componente:

input_raw

Ruolo:

- adapter tecnico
- hidden
- derivato da input_home
- base per parsing e matching

Il valore di input_raw viene aggiornato da input_home.

Il parsing non viene più eseguito direttamente nel bottone confirm.

------------------------------------------------
3. TRIGGER_PARSE_DEBOUNCED
------------------------------------------------

Query/script:

trigger_parse_debounced

Ruolo:

- evitare parsing per-lettera
- ridurre trigger inutili
- stabilizzare la UX
- prevenire loop reattivo critico input → parsing → UI

Codice runtime:

```js
if (window.__parseTimer) {
  clearTimeout(window.__parseTimer);
}

window.__parseTimer = setTimeout(() => {
  parse_input_controlled.trigger();
}, 350);

Comportamento:

input_raw aggiornato
→ debounce
→ parse_input_controlled.trigger()

UI_STATE

State Retool:

ui_state

Struttura attuale:

{
  view: "home",
  parsed: {
    amount: null,
    unit: null,
    event_date: null
  },
  status: null,
  feedback_text: null,
  feedback_project: null
}

Ruolo:

controlla vista UI
conserva parsed data
alimenta preview
alimenta insert/update
conserva feedback post-save

Regola critica:

ui_state.parsed deve restare sempre strutturato.

Non deve tornare:

parsed: null

Forma corretta:

parsed: {
  amount: null,
  unit: null,
  event_date: null
}
PRE-PROCESSING

Normalizzazione runtime interna al parser:

lowercase
trim
compressione spazi
riconoscimento unità compatte
riconoscimento simboli
selezione amount per prossimità alla unità

Esempio:

const clean = text.toLowerCase().replace(/\s+/g, " ").trim();

Questa normalizzazione:

✔ non modifica input_home
✔ non modifica raw_input
✔ non modifica direttamente DB
✔ produce solo output strutturato in ui_state.parsed

PARSING CONTROLLED + NORMALIZATION BASE

Query/script:

parse_input_controlled

Output:

{
  amount,
  unit,
  event_date
}

Utilizzato da:

success handler parser
ui_state.parsed
preview
button_input_confirm
insert_event
update_event

Non più duplicato in:

button_input_confirm
6.1 SUCCESS HANDLER parse_input_controlled

Codice runtime:

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

✔ ui_state.parsed sempre strutturato
✔ nessun undefined
✔ fonte unica per save/edit
✔ riduzione drift tra preview e DB

6.2 UNIT NORMALIZATION

Unità supportate:

EURO:

€
euro
eur
€20
20€
€ 20
20 euro

Output:

euro

TEMPO — ORE:

ora
ore
h
1 ora
1ora
2 ore
2ore
2h
h2
2 h
1,5 ore
1.5 ore
1,5h
1.5h

Output:

ore

TEMPO — MINUTI:

min
minuto
minuti
30 min
30min
30 minuti
30minuti
min30

Output:

minuti
6.3 AMOUNT NORMALIZATION

Amount viene salvato come numero JavaScript / numeric DB,
non come stringa localizzata.

Regole supportate:

458,78 → 458.78
1,5 → 1.5
1.5 → 1.5
1.500 → 1500
1.500,50 → 1500.5
1500 → 1500

Funzione runtime:

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

Regex numeri:

const numbers = cleanForParsing.match(/\d{1,3}(?:\.\d{3})+(?:,\d+)?|\d+(?:[.,]\d+)?/g);
6.4 REGOLA NUMERI SENZA UNITÀ

Regola runtime:

Se non esiste unità riconosciuta:

amount = null;

Esempi:

villa 2 → amount null
villa 2 mario → amount null
cliente 2026 → amount null

Motivo:

evitare interpretazione errata di numeri semantici
preservare raw_input
evitare quantità false nel DB
6.5 DATE PARSING

Formati supportati:

6/4/26
06/04/2026
4 aprile

Output:

YYYY-MM-DD

Esempi:

6/4/26 → 2026-04-06
4 aprile → 2026-04-04

Non supportati:

oggi
domani
ieri
prossima settimana
date relative
6.6 GESTIONE ORARI

Formati:

HH:MM

Comportamento:

✔ ignorati come amount
✔ non considerati unit
✔ mantenuti nel raw_input

Esempio:

15:30 test → amount null, unit null
6.7 LIMITI PARSING / NORMALIZATION

Non implementato:

multi-unit
1 ora e 15 minuti
2h30
2 ore 30
2 giorni rendering
conversione durata
unità canonica durata
type classification semantica
spesa/incasso
parole chiave economiche
MATCHING

Eseguito in:

project_state
entity_state
select_project
select_entity
sintesi / preview

PROJECT MATCH:

split parole nome
filtro parole
match su parole
disambiguazione numerica

ENTITY MATCH:

STRONG:

nome completo

FULL:

parole significative presenti

PARTIAL:

confronto token significativi
riduzione includes aggressivo

AUTO-SELECT:

solo match univoco
nessuna forzatura

Stato:

✔ matching base funzionante
✔ suggerimenti utili
✔ utente in controllo

Problema strutturale ancora aperto:

⚠ presenza di più sistemi di matching:

input_raw / ranking
select / deterministico
preview / detection

→ non unificati

Non implementato:

priority match
gerarchia entity
ranking affidabile unico
matching engine centralizzato
TYPE DETECTION

Componente:

select1

Logica attuale:

Tempo → presenza unità tempo
Economico → presenza euro
Evento → default

Nota:

evitato fallback aggressivo su "h"
evitati falsi positivi tipo "macchina"

Limiti:

⚠ nessuna distinzione spesa/incasso
⚠ type non è ancora affidabile per KPI/output
⚠ non esiste type classification engine
⚠ parole chiave non implementate

PREVIEW / SINTESI

Costruita da:

input_raw
ui_state.parsed
select_project
select_entity
project_state
entity_state
select1
liste projects/entities

MAIN:

amount + unit + label

META:

project + entity

HINT:

suggerimenti matching
suggerimenti tipo
hint durata ambigua

Caratteristiche:

✔ non modifica input
✔ non blocca
✔ non modifica DB
✔ visualizza i dati principali parsati
✔ supporta create/edit

Limiti:

⚠ contiene logiche di trasformazione
⚠ contiene label cleaning
⚠ contiene hint logic
⚠ utilizza fonti multiple
⚠ non è view pura
⚠ formattazione italiana amount non ancora allineata

Esempio limite:

Dato interno:

amount: 1500.5
unit: euro

Possibile preview attuale:

1500.5 €

Preview desiderata futura:

1.500,50 €

Nodo futuro:

PREVIEW ALIGNMENT BASE

LABEL RUNTIME

Eseguita in:

sintesi / preview

Caratteristiche:

✔ generata runtime
✔ non persistita
✔ derivata da raw_input
✔ utile per UX

Operazioni:

rimozione amount + unit best-effort
rimozione date già parse
normalizzazione spazi
preservazione numeri semantici
compound token

Limiti:

⚠ non è modulo separato
⚠ non è riutilizzabile
⚠ embedded nella preview
⚠ non completamente allineata al Normalization Layer Base

INSERT / UPDATE EVENT

Componente:

button_input_confirm

Ruolo:

costruisce payload
mostra feedback immediato
resetta input/select
lancia insert_event o update_event
aggiorna events_new dopo save

Principio:

button_input_confirm NON esegue più parsing.

Fonte dati:

const parsed = ui_state.value?.parsed || {
  amount: null,
  unit: null,
  event_date: null
};

Payload:

const payload = {
  raw_input: input_raw.value,
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
};

EDIT MODE:

edit_mode = false → insert_event
edit_mode = true → update_event

VINCOLI:

Conferma disabilitata se:

entity_state.data?.matches > 1
project_state.data?.matches > 1
11.1 BUTTON_INPUT_CONFIRM — CODICE LOGICO
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

// RESET UI SUBITO
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

Risultati:

✔ parsing legacy rimosso
✔ save flow pulito
✔ feedback immediato
✔ update lista corretto
✔ nessuna divergenza save/DB osservata

INSERT_EVENT

Trigger:

insert_event

Tipo:

REST Query Supabase

Payload:

raw_input
amount
unit
event_date
project_id
entity_id
status: NEW
updated_at
payload: {}

Body:

JSON.stringify({
  raw_input: raw_input,
  amount: amount,
  unit: unit,
  event_date: event_date,
  project_id: project_id,
  entity_id: entity_id,
  status: "NEW",
  updated_at: new Date().toISOString(),
  payload: {}
})

Origine valori:

additionalScope da button_input_confirm.

Validazione:

1.500,50 euro test engine
→ amount 1500.5
→ unit euro
→ status NEW
UPDATE_EVENT

Trigger:

update_event

Tipo:

REST Query Supabase

Utilizzo:

modifica evento esistente
solo eventi NEW
status invariato

Campi aggiornati:

raw_input
amount
unit
event_date
project_id
entity_id
updated_at

Origine valori:

additionalScope da button_input_confirm.

Validazione:

1,5 ore test engine update
→ amount 1.5
→ unit ore
→ status NEW
RESET & FEEDBACK

Sequenza attuale:

button_input_confirm costruisce payload
ui_state.view = feedback
ui_state.feedback_text valorizzato
ui_state.feedback_project valorizzato
reset input_home
reset input_raw
clear select_project
clear select_entity
cancel debounce pending
insert/update async
await savePromise
await events_new.trigger()
reset edit_mode se necessario

Caratteristiche:

✔ feedback immediato
✔ salvataggio asincrono
✔ lista aggiornata dopo save reale
✔ nessun refresh pagina necessario dopo update
✔ parsed reset stabile a oggetto

PROCESSING EVENTI

Lista:

events_new

Query:

events?select=*&status=eq.NEW&order=updated_at.desc.nullslast,created_at.desc

Azioni:

✔ WRITTEN
✖ ERROR

Trigger:

update_written
update_error

Editing:

disponibile solo per eventi NEW
riuso pipeline input
update_event
QUERY

GET:

projects_list
entities_list
events_new

POST / UPDATE:

insert_event
update_event

RPC / STATUS:

update_written
update_error

STATE / UI:

ui_state
edit_mode
project_state
entity_state
focus_input_home

INPUT / PARSING:

trigger_parse_debounced
parse_input_controlled

LEGACY / DEBITO:

typing_state non è più fonte principale del parsing
parse_input non è più fonte di verità se ancora presente
button_input_confirm non deve contenere parsing duplicato
SUPABASE

Supabase è database passivo.

Ruolo:

✔ persistenza
✔ fetch liste
✔ insert eventi
✔ update eventi
✔ update status

NON:

parsing
normalizzazione
matching
validazione business
type classification
deduplicazione
KPI
LIMITI ATTUALI

INPUT:

nessun multi-unit
nessun parsing semantico
date relative non supportate
giorni/settimane non supportati

NORMALIZATION:

solo amount/unit base
nessuna conversione durata
nessuna unità canonica tempo
nessuna retro-normalizzazione storico

MATCHING:

nessuna gerarchia entity
nessuna disambiguazione automatica avanzata
matching non unificato
no priority match

TYPE:

nessuna distinzione spesa/incasso
type non affidabile per output
parole chiave non implementate

UI / PREVIEW:

input non multilinea
preview migliorabile
preview non pura
formattazione italiana amount non allineata

ARCHITETTURA:

accoppiamento preview / label / hint
matching distribuito
hint non completamente state-driven
PRINCIPI RUNTIME

✔ client-side logic
✔ database passivo
✔ append-only controllato
✔ editing solo su NEW
✔ suggerire ≠ decidere
✔ input non bloccante
✔ salvataggio da ui_state.parsed
✔ normalizzazione progressiva
✔ nessuna automazione decisionale

STATO RUNTIME

Runtime attuale:

✔ funzionante
✔ stabile su insert
✔ stabile su update
✔ normalizzazione base attiva
✔ parser controllato attivo
✔ save flow ripulito
✔ refresh lista corretto
✔ DB coerente con payload
✔ UX immediata

Debiti:

⚠ preview alignment da fare
⚠ duration normalization da fare
⚠ type classification da definire
⚠ matching unification da fare
⚠ output non attivo

CHANGELOG

v01 — 2026-04-01

runtime iniziale

v02 — 2026-04-03

parsing retrofit completo
fix type detection
entity matching migliorato
fix numero finale
allineamento completo runtime

v03 — 2026-04-03

fix insert pipeline
supporto unit compatte
fix amount multi-numero
allineamento preview → DB

v04 — 2026-04-23

introduzione update_event
introduzione edit_mode
refactor confirm flow
introduzione handle_event_success
aggiornamento UI state
identificazione loop reattivo
allineamento runtime con sistema reale

v05 — 2026-04-30

introduzione parse_input_controlled come parser runtime
introduzione trigger_parse_debounced
stabilizzazione ui_state.parsed
completamento Normalization Layer Base
normalizzazione amount formato italiano
normalizzazione unit base
supporto unità compatte testuali
rimozione amount per numeri senza unità
rimozione parsing legacy da button_input_confirm
allineamento insert/update a ui_state.parsed
validazione insert con dati normalizzati
validazione update con dati normalizzati
fix race condition update → events_new
refresh lista dopo save completato
apertura prossimo nodo: Preview Alignment Base