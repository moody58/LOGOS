# 04_LOGOS_Retool_Architecture_v06

DATA: 2026-04-30

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- struttura UI completa  
- flow input → parsing → normalization → insert/update documentato  
- query e componenti allineati al runtime reale  
- ui_state.parsed documentato come fonte unica  
- confirm flow aggiornato  
- refresh lista dopo save documentato  

Q (Qualità): 9/10  
- architettura reale documentata  
- distinzione chiara tra parsing, normalization base, preview, matching e save  
- debiti residui esplicitati  
- non introduce modello ideale non implementato  

D (Deployabilità): 10/10  
- utilizzabile come riferimento tecnico reale  
- coerente con implementazione Retool attuale  
- utile per ricostruzione runtime  

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Documentare l’architettura reale dell’interfaccia LOGOS
sviluppata in Retool.

Il documento descrive:

- struttura componenti
- organizzazione UI
- logica runtime
- flussi operativi reali
- parsing controllato
- normalization layer base
- insert/update flow
- stato UI condiviso

------------------------------------------------
STRUTTURA GENERALE
------------------------------------------------

Applicazione:

- Single Page
- Nessun routing
- Navigazione tramite stato UI
- Logica client-side JavaScript
- Supabase come backend passivo

---

Gerarchia:

page1  
└── Main  
    └── wrapper  
        ├── container_home  
        ├── container_input  
        ├── container_feedback  
        └── container_events_list  

------------------------------------------------
GESTIONE STATO UI
------------------------------------------------

State Retool:

ui_state

---

Struttura attuale:

```js
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

controllare la vista attiva
conservare dati parsati
mantenere feedback post-save
supportare create/edit
fornire fonte unica per insert/update

Binding principali:

container_home:
Hidden = view === "feedback"

container_feedback:
Hidden = view !== "feedback"

container_input:
Hidden = !input_home.value

Principio:

UI = funzione dello stato

Stato dati:

ui_state.parsed è la fonte unica runtime per:

amount
unit
event_date

Usato da:

preview
button_input_confirm
insert_event
update_event

Nota:

ui_state.parsed deve restare sempre strutturato:

{
  amount: null,
  unit: null,
  event_date: null
}

e non deve tornare null.

CONTAINER HOME

Componenti:

input_home
container_esempi
container_suggerimenti
container_attivita

Funzione:

punto ingresso sistema
input principale
esperienza utente non bloccante

INPUT:

campo libero

SUGGERIMENTI:

registra spesa
registra incasso
registra tempo
registra evento

Nota:

i suggerimenti restano UX helper,
non modificano il modello dati.

CONTAINER INPUT

Componenti:

input_raw (hidden)
sintesi (preview)
select1 (type)
select_project
select_entity
button_input_confirm

Funzione:

preview dati
validazione manuale
selezione project/entity
conferma inserimento o modifica

Preview:

MAIN:

event_date + amount + unit + label

HINT:

basati su stato matching
basati su condizioni locali preview
non completamente state-driven

Esempi:

entity_matches > 1 → "Seleziona entità"
project_matches > 1 → "Seleziona progetto"

Caratteristiche:

✔ preview rappresenta i dati principali parsati
✔ preview non modifica DB
✔ preview non blocca input
✔ preview supporta create/edit

⚠ contiene ancora logiche di derivazione
⚠ contiene label + hint
⚠ non è una view completamente pura
⚠ formattazione italiana amount non ancora pienamente allineata

Nota:

La label è:

✔ generata in tempo reale
✔ non persistita
✔ derivata da raw_input
✔ embedded nella preview

INPUT FLOW

Flow attuale:

input_home
→ input_raw
→ trigger_parse_debounced
→ parse_input_controlled
→ ui_state.parsed
→ preview / save / edit

input_home:

source of truth lato UX
campo modificato dall’utente

input_raw:

adapter tecnico
derivato da input_home
hidden
base per parsing e matching

trigger_parse_debounced:

riduce parsing per-lettera
richiama parse_input_controlled con ritardo controllato

parse_input_controlled:

esegue parsing
applica normalization base
restituisce amount/unit/event_date

ui_state.parsed:

riceve il risultato del parser
alimenta preview e confirm

Principio:

input_home = fonte UX
ui_state.parsed = fonte dati strutturati

Risultato:

✔ ridotto loop reattivo critico
✔ parsing non duplicato nel save
✔ create/edit più coerenti
✔ input e salvataggio allineati

TRIGGER_PARSE_DEBOUNCED

Tipo:

JS Query / script runtime

Funzione:

cancellare timer precedente
attendere debounce
lanciare parse_input_controlled

Codice runtime:

if (window.__parseTimer) {
  clearTimeout(window.__parseTimer);
}

window.__parseTimer = setTimeout(() => {
  parse_input_controlled.trigger();
}, 350);

Nota:

Il debounce permette preview reattiva
senza parsing continuo a ogni singolo carattere.

PARSING FLOW + NORMALIZATION BASE

Eseguito in:

parse_input_controlled

Non più eseguito in:

button_input_confirm

Output:

{
  amount,
  unit,
  event_date
}

Success handler:

const parsed = parse_input_controlled.data || {};

ui_state.setValue({
  ...ui_state.value,
  parsed: {
    amount: parsed.amount ?? null,
    unit: parsed.unit ?? null,
    event_date: parsed.event_date ?? null
  }
});

Caratteristiche:

✔ normalizzazione input
✔ riconoscimento unità
✔ selezione amount per prossimità
✔ gestione decimali
✔ gestione migliaia italiane
✔ esclusione formato HH:MM
✔ supporto unit compatte
✔ supporto forme testuali compatte
✔ gestione input multi-numero
✔ nessun amount se manca unità
✔ output stabile in ui_state.parsed

UNIT SUPPORTATE:

EURO:

€
euro
eur
€20
20€
€ 20

TEMPO:

ora
ore
h
min
minuto
minuti

Formati:

2h
h2
2 h
1ora
2ore
18min
min30
30 minuti
30minuti
0.5h
1.5 ore
1,5 ore

AMOUNT NORMALIZATION:

458,78 → 458.78
1,5 → 1.5
1.5 → 1.5
1.500 → 1500
1.500,50 → 1500.5
1500 → 1500

REGOLA CRITICA:

Numeri senza unità NON diventano amount.

Esempi:

villa 2 → amount null
villa 2 mario → amount null
cliente 2026 → amount null

LIMITI:

⚠ multi-unit non supportato
⚠ 1 ora e 15 minuti non normalizzato
⚠ 2h30 non normalizzato
⚠ giorni non supportati
⚠ parsing non semantico
⚠ type classification non consolidata

MATCHING FLOW

Eseguito tramite:

project_state
entity_state
select_project
select_entity
logiche locali preview

OUTPUT:

project_state.data?.matches
entity_state.data?.matches

LOGICA GENERALE:

match = 1
→ auto-select

match > 1
→ ambiguità
→ nessuna selezione

match = 0
→ nessun suggerimento

Caratteristiche:

✔ matching osservabile tramite state
✔ auto-select solo se match univoco
✔ utente mantiene controllo

⚠ presenza di più logiche di matching non unificate
⚠ possibili incoerenze tra preview e select
⚠ priority match non implementato
⚠ entity hierarchy non implementata

TYPE DETECTION

Componente:

select1

Logica attuale:

Tempo → presenza unità tempo
Economico → presenza euro
Evento → default

Nota:

rimosso fallback aggressivo su "h"
evitati falsi positivi tipo "macchina"
economico non distingue spesa/incasso
type non è ancora un dato affidabile per output/KPI

NON IMPLEMENTATO:

classificazione spesa/incasso
parole chiave controllate
type engine
persistenza type pienamente affidabile
LABEL (RUNTIME)

Eseguito in:

sintesi (preview)

Caratteristiche:

✔ generata runtime
✔ non persistita
✔ non esiste come layer separato
✔ derivata da raw_input

Operazioni:

rimozione amount + unit best-effort
rimozione date già parse
normalizzazione spazi
preservazione numeri semantici
compound token
label leggibile

Nota:

✔ utile per UX
✔ non modifica DB
✔ non è fonte dati strutturata

⚠ parte della logica preview
⚠ non riutilizzabile come modulo
⚠ non isolata
⚠ non completamente allineata al Normalization Layer Base

PREVIEW (SINTESI)

Ruolo:

mostrare interpretazione sistema
aiutare l’utente prima del salvataggio
visualizzare amount/unit/label/project/entity/hint

Input usati:

input_raw.value
ui_state.parsed
select_project.value
select_entity.value
projects_list.data
entities_list.data
project_state.data
entity_state.data
select1.value

Output:

labelStyled
typeBadge
hint

Caratteristiche:

✔ non blocca input
✔ non salva dati
✔ supporta correzione utente
✔ mostra dati principali

⚠ contiene logiche di trasformazione
⚠ contiene label cleaning
⚠ contiene hint logic
⚠ non è ancora view pura
⚠ formattazione italiana amount non ancora allineata

Esempio limite attuale:

Dato interno:

amount = 1500.5
unit = euro

Possibile preview attuale:

1500.5 €

Preview desiderata futura:

1.500,50 €

Nodo dedicato:

PREVIEW ALIGNMENT BASE

CONFIRM FLOW

Componente:

button_input_confirm

Ruolo:

confermare inserimento
confermare modifica evento NEW
costruire payload da ui_state.parsed
lanciare insert_event o update_event
aggiornare feedback e lista

Sequenza attuale:

legge ui_state.parsed
costruisce payload
salva feedbackText / feedbackProject
mostra feedback subito
resetta input/select
cancella debounce pending
determina wasEditMode
esegue insert_event o update_event
attende savePromise
aggiorna events_new
resetta edit_mode se necessario

EDIT MODE:

edit_mode = true → update_event
edit_mode = false → insert_event

VINCOLI:

✔ conferma bloccata se:

entity_matches > 1
project_matches > 1

✔ nessuna ambiguità consentita in insert/update

Principio:

button_input_confirm NON esegue parsing.

Il parsing legacy è stato rimosso.

Fonte unica:

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

Reset UI:

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

Save / refresh:

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

✔ parsing duplicato eliminato
✔ insert/update coerenti
✔ feedback immediato
✔ lista aggiornata dopo salvataggio reale
✔ update visibile senza refresh pagina

INSERT_EVENT

Tipo:

REST Query Supabase

Uso:

inserimento nuovo evento
status iniziale NEW

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

additionalScope generato da button_input_confirm.

Campi valorizzati:

raw_input
amount
unit
event_date
project_id
entity_id
status
updated_at
payload

Validato:

1.500,50 euro test engine
→ amount 1500.5
→ unit euro
→ status NEW
UPDATE_EVENT

Tipo:

REST Query Supabase

Uso:

modifica evento esistente
consentita su eventi NEW
status invariato

Origine valori:

additionalScope generato da button_input_confirm.

Campi aggiornati:

raw_input
amount
unit
event_date
project_id
entity_id
updated_at

Validato:

1,5 ore test engine update
→ amount 1.5
→ unit ore
→ status NEW

Fix recente:

events_new non viene più aggiornato prima del completamento update_event.

Nuovo ordine:

await savePromise
→ await events_new.trigger()

Risultato:

✔ lista aggiornata subito
✔ nessun refresh pagina necessario

EVENTS_NEW

Tipo:

REST Query Supabase

Uso:

recupera eventi NEW
alimenta lista processing
mostra eventi modificabili

Query attuale:

events?select=*&status=eq.NEW&order=updated_at.desc.nullslast,created_at.desc

Ruolo nel flow:

Dopo insert/update:

await events_new.trigger()

Motivo:

evitare race condition tra save e refresh lista.

QUERY ATTIVE

GLOBAL:

projects_list
entities_list

PAGE1 — INPUT / PARSING:

trigger_parse_debounced
parse_input_controlled

PAGE1 — DATA / MATCHING:

project_state
entity_state

PAGE1 — EVENTI:

insert_event
update_event
events_new
update_written
update_error

PAGE1 — STATE / UI:

ui_state
edit_mode
focus_input_home
handle_event_success

LEGACY / DEBITO:

eventuali residui parse_input o typing_state non devono essere considerati fonte di verità se ancora presenti
fonte operativa parsing = parse_input_controlled
fonte operativa salvataggio = ui_state.parsed
SUPABASE INTEGRAZIONE

Connessione:

REST API

Uso:

fetch projects
fetch entities
insert eventi
update eventi
update status
fetch eventi NEW

Nota:

database passivo

Supabase:

✔ salva dati
✔ espone API
✔ restituisce lista eventi

NON:

interpreta input
valida semantica
normalizza amount/unit
decide project/entity
classifica spesa/incasso
PATTERN ARCHITETTURALI

✔ Adapter Pattern (input_raw)
✔ State-driven UI
✔ Client-side logic
✔ Append-only controllato (editing su NEW)
✔ Single Source of Truth per dati strutturati: ui_state.parsed
✔ Async save con refresh lista post-save
✔ Progressive enhancement

PROBLEMI NOTI

RISOLTI:

✔ parsing fragile → risolto
✔ perdita unit → risolta
✔ mismatch amount → risolto
✔ numeri senza unità → risolti
✔ parsing duplicato nel confirm → risolto
✔ divergenza save / DB → risolta
✔ race condition update → events_new → risolta
✔ lista vecchia dopo update → risolta
✔ loop input/parsing critico → risolto

UI:

⚠ input non multilinea
⚠ preview migliorabile
⚠ formattazione italiana amount non allineata
⚠ preview non pura

DATA:

⚠ nessuna gerarchia entity
⚠ dati storici non retro-normalizzati
⚠ payload non usato

TYPE:

⚠ nessuna distinzione spesa/incasso
⚠ type non pienamente affidabile

ARCHITETTURA:

⚠ accoppiamento preview / label / hint
⚠ matching non unificato
⚠ hint non completamente state-driven
⚠ duration normalization non implementata

STATO ARCHITETTURA

✔ funzionante
✔ coerente nei dati strutturati principali
✔ insert stabile
✔ update stabile
✔ lista eventi coerente dopo save
✔ parsing affidabile
✔ normalization base implementata
✔ label pipeline stabile
✔ UX migliorata

⚠ non completamente stabile nei layer evolutivi
⚠ preview ancora ibrida
⚠ matching funzionale ma non unificato
⚠ type classification debole
⚠ output non attivo

NEXT STEP ARCHITETTURALE CONSIGLIATO

PREVIEW ALIGNMENT BASE

Obiettivo:

allineare preview/lista ai dati normalizzati
formattare amount in stile italiano
ridurre divergenza visiva parser/sintesi
mantenere preview non decisionale
non toccare DB
non toccare matching
non introdurre spesa/incasso

Vietato nel prossimo nodo:

duration normalization
type classification
match engine unification
dashboard/KPI
refactor globale
CHANGELOG

v01 — 2026-04-01

documentazione architettura base

v02 — 2026-04-03

integrazione parsing retrofit
integrazione matching step 2

v03 — 2026-04-03

fix pipeline insert
supporto unit compatte

v04 — 2026-04-04

introduzione label layer
integrazione label pipeline
miglioramento UX hint
gestione ambiguità input corto

v05 — 2026-04-23

introduzione update_event
introduzione edit_mode
aggiornamento confirm flow
centralizzazione UI state
aggiornamento append-only controllato
identificazione loop reattivo
allineamento architettura con runtime reale

v06 — 2026-04-30

introduzione parse_input_controlled come fonte parsing runtime
introduzione trigger_parse_debounced
stabilizzazione ui_state.parsed
completamento Normalization Layer Base
normalizzazione amount formato italiano
normalizzazione unit base
supporto unità compatte testuali
rimozione amount per numeri senza unità
rimozione parsing legacy da button_input_confirm
allineamento insert/update a ui_state.parsed
validazione insert con amount/unit normalizzati
validazione update con amount/unit normalizzati
fix race condition update → events_new
aggiornamento lista eventi dopo save completato
apertura prossimo nodo consigliato: Preview Alignment Base