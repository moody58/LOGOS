# 00_PROJECT_System_v03

DATA: 2026-04-30

------------------------------------------------
IDENTITÀ SISTEMA
------------------------------------------------

Nome: LOGOS

Tipo:
Event Operating System

Definizione:

Sistema per la registrazione, gestione e trasformazione di eventi
in dati strutturati utilizzabili per analisi operative.

Modello:

Event Ledger user-driven  
Append-only controllato

------------------------------------------------
OBIETTIVO SISTEMA
------------------------------------------------

Trasformare input libero in:

- dati strutturati
- dati confrontabili
- dati progressivamente normalizzati
- dati analizzabili

Output atteso futuro:

- KPI
- analisi costi
- analisi tempi
- dashboard operative
- reportistica

Stato output:

❌ non ancora implementato

Motivo:

i dati non sono ancora sufficientemente completi per output affidabili.

------------------------------------------------
STACK TECNOLOGICO
------------------------------------------------

Frontend:

- Retool
- UI single page
- gestione stato lato client
- logica runtime JavaScript

Backend:

- Supabase
- database PostgreSQL
- REST API

Logica:

- JavaScript lato client
- parsing lato Retool
- normalization base lato Retool
- matching lato Retool
- preview lato Retool

Server / Database:

- passivo
- nessuna business logic applicativa
- nessun parsing
- nessuna normalizzazione
- nessuna classificazione

------------------------------------------------
PRINCIPI ARCHITETTURALI
------------------------------------------------

1. DATABASE PASSIVO

Il database:

- non contiene logica applicativa
- non valida semanticamente i dati
- non interpreta eventi
- non esegue parsing
- non esegue normalizzazione
- non decide project/entity
- non decide type

---

2. UI RESPONSABILE

La UI:

- gestisce input
- interpreta dati
- normalizza dati base
- costruisce preview
- guida decisione utente
- invia payload al database

---

3. RAW INPUT COME VERITÀ ORIGINARIA

raw_input:

- è sempre salvato
- preserva il testo utente
- non viene alterato
- consente ricostruzione/correzione futura

---

4. DATI STRUTTURATI COME DERIVATI

amount, unit, event_date, project_id, entity_id:

- sono derivati da parsing, matching o selezione utente
- possono essere incompleti
- possono essere corretti mentre l’evento è NEW
- non sostituiscono raw_input

---

5. APPEND-ONLY CONTROLLATO

Eventi:

- append-only dopo validazione
- modificabili in fase NEW
- evolvono tramite stato dopo validazione
- non hanno ancora versioning storico

Nota:

l’editing su eventi NEW è una violazione controllata
del modello append-only, accettata per migliorare qualità dati
prima della validazione.

---

6. SEPARAZIONE PROGRESSIVA DEI LAYER

Il sistema tende a separare:

- input
- parsing
- normalization
- preview
- matching
- insert/update
- processing
- output

Stato attuale:

✔ input/parsing/save più separati  
✔ normalization base introdotta  
⚠ preview ancora ibrida  
⚠ matching ancora non unificato  
⚠ output non attivo  

------------------------------------------------
ARCHITETTURA FUNZIONALE
------------------------------------------------

LIVELLI ATTUALI:

1. INPUT LAYER
2. PARSING LAYER
3. NORMALIZATION BASE LAYER
4. MATCH LAYER
5. PREVIEW / VIEW LAYER
6. UI STATE LAYER
7. INSERT / UPDATE LAYER
8. PROCESSING LAYER

LIVELLI FUTURI:

9. ENGINE ADVANCED
10. OUTPUT / ANALYTICS LAYER

------------------------------------------------
1 — INPUT LAYER
------------------------------------------------

Componenti:

- input_home
- input_raw

Caratteristiche:

- input libero
- nessun vincolo formale
- non bloccante
- source UX = input_home
- adapter tecnico = input_raw

Flow:

input_home
→ input_raw

Principio:

input_home = source of truth lato UX  
raw_input = source of truth lato persistenza

------------------------------------------------
2 — PARSING LAYER
------------------------------------------------

Componente principale:

- parse_input_controlled

Trigger:

- trigger_parse_debounced

Funzione:

Interpretazione base input.

Operazioni:

- estrazione amount
- riconoscimento unit
- parsing event_date
- esclusione orari HH:MM
- gestione multi-numero per prossimità
- supporto unità compatte

Caratteristiche:

- best-effort
- deterministico
- non bloccante
- lato client
- non semantico

Output:

```js
{
  amount,
  unit,
  event_date
}

Consumo:

ui_state.parsed
preview
insert_event
update_event
3 — NORMALIZATION BASE LAYER

Stato:

✔ implementato come primo blocco ENGINE BASE

Collocazione attuale:

incorporato in parse_input_controlled

Funzione:

rendere coerenti i dati minimi già parsati.

Ambito:

amount
unit
event_date preservato

Regole principali:

amount salvato come numero
unit salvata come testo normalizzato
raw_input preservato
numeri senza unità non diventano amount
formato italiano numerico convertito a numero

Esempi:

1.500,50 euro → amount 1500.5, unit euro
1ora lavoro → amount 1, unit ore
18min test → amount 18, unit minuti
villa 2 mario → amount null, unit null

Non implementato:

1 ora e 15 minuti
2h30
2 giorni rendering
conversione durata
unità canonica tempo
spesa/incasso
type classification
4 — MATCH LAYER

Funzione:

Associazione input a dati esistenti.

Entità coinvolte:

projects
entities

Componenti / fonti:

projects_list
entities_list
project_state
entity_state
select_project
select_entity
preview detection

Strategia attuale:

matching testuale
token matching
auto-select solo se univoco
nessuna inferenza definitiva

Output:

suggerimenti soft
auto-select solo se match unico
blocco confirm se match multipli

Limiti:

matching non unificato
ambiguità frequente
nessuna gerarchia entity
nessun priority match
incoerenza possibile tra preview, select e ranking
5 — PREVIEW / VIEW LAYER

Funzione:

Mostrare all’utente l’interpretazione del sistema.

Mostra:

amount
unit
event_date
label runtime
project/entity
hint
tipo evento base

Caratteristiche:

✔ utile lato UX
✔ non salva dati
✔ non modifica DB
✔ supporta correzione manuale

Limiti:

⚠ non è view pura
⚠ contiene label cleaning
⚠ contiene hint logic
⚠ contiene highlight
⚠ usa fonti multiple
⚠ formattazione italiana amount non ancora allineata

Esempio limite:

dato interno:

amount: 1500.5
unit: euro

preview attuale possibile:

1500.5 €

preview desiderata futura:

1.500,50 €

Nodo futuro coerente:

PREVIEW ALIGNMENT BASE

6 — UI STATE LAYER

State principale:

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

gestione view
stato feedback
fonte dati parsati
base save/edit
supporto create/update

Principio:

UI = funzione dello stato

Fonte unica dati strutturati:

ui_state.parsed

Usato da:

preview
button_input_confirm
insert_event
update_event

Regola:

ui_state.parsed deve restare sempre oggetto strutturato,
non null.

7 — INSERT / UPDATE LAYER

Componenti:

button_input_confirm
insert_event
update_event

Principio:

button_input_confirm NON esegue parsing.

Il payload viene costruito da:

const parsed = ui_state.value?.parsed || {
  amount: null,
  unit: null,
  event_date: null
};

Payload:

{
  raw_input: input_raw.value,
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
}

Insert:

crea evento NEW
salva raw_input
salva amount/unit/event_date
salva project/entity se selezionati

Update:

modifica evento NEW
mantiene status NEW
aggiorna updated_at
aggiorna lista dopo save completato

Ordine corretto:

savePromise
→ await savePromise
→ await events_new.trigger()

Risultato:

✔ insert stabile
✔ update stabile
✔ lista aggiornata senza refresh pagina
✔ parsing duplicato nel save rimosso

8 — PROCESSING LAYER

Funzione:

Gestione eventi inseriti.

Componenti:

events_new
update_written
update_error
edit su eventi NEW

Stati:

NEW
WRITTEN
ERROR

Transizioni:

NEW → NEW (edit)
NEW → WRITTEN
NEW → ERROR

Caratteristiche:

decisione manuale
nessuna automazione
editing solo su eventi NEW
updated_at usato per ordinamento/modifica

Limiti:

lifecycle limitato
no versioning storico
no stati intermedi
no revisione batch
FLOW COMPLETO SISTEMA

CREATE FLOW:

utente scrive in input_home

↓

SYNC:

input_home → input_raw

↓

DEBOUNCE:

trigger_parse_debounced

↓

PARSING:

parse_input_controlled

↓

NORMALIZATION BASE:

amount/unit/event_date

↓

STATE:

ui_state.parsed

↓

PREVIEW:

sintesi

↓

CONFERMA:

button_input_confirm

↓

INSERT:

insert_event

↓

DATABASE:

evento salvato con status NEW

↓

REFRESH:

events_new

↓

PROCESSING:

utente decide:

✔ WRITTEN
✖ ERROR

EDIT FLOW:

evento NEW selezionato

↓

LOAD:

raw_input → input_home / input_raw

↓

PARSING:

parse_input_controlled

↓

STATE:

ui_state.parsed

↓

PREVIEW:

sintesi

↓

CONFERMA:

button_input_confirm

↓

UPDATE:

update_event

↓

DATABASE:

evento aggiornato, status NEW

↓

REFRESH:

events_new

↓

PROCESSING:

WRITTEN / ERROR

MODELLO DATI

Tabella principale:

events

Campi principali:

id
created_at
updated_at
event_date
project_id
entity_id
type
amount
unit
reference_id
source
payment_method
notes
raw_input
payload
status

Tabelle correlate:

projects
entities

Tabelle non operative:

system_logs
STATO ARCHITETTURALE

✔ sistema coerente end-to-end
✔ flusso create funzionante
✔ flusso edit/update funzionante
✔ input stabilizzato
✔ parsing controllato attivo
✔ normalization base attiva
✔ save flow allineato a ui_state.parsed
✔ DB coerente con payload
✔ lista aggiornata dopo save/update

⚠ sistema incompleto nei layer evolutivi:

preview alignment
duration normalization
type classification
match engine unification
data structure avanzata
output

Layer esistenti ma parziali:

engine base
preview
matching
lifecycle

Layer non attivi:

analytics
dashboard
KPI
LIMITI STRUTTURALI
preview non ancora view pura
matching non unificato
hint non completamente state-driven
type non affidabile
spesa/incasso non implementati
duration normalization non implementata
multi-unit non supportato
dati storici non retro-normalizzati
lifecycle senza versioning
output non attivo
DIREZIONE EVOLUTIVA

Ordine corretto sviluppo aggiornato:

input reliability ✔
event editing ✔
input system stabilization ✔
normalization layer base ✔
preview alignment base
duration normalization
type classification base
match engine unification
data structure avanzata
output / dashboard

Nota:

l’ordine può essere raffinato dalla Roadmap,
ma non deve essere anticipato senza checkpoint.

DOCUMENTI TECNICI COLLEGATI

Core:

00_PROJECT_State
00_PROJECT_Roadmap
00_PROJECT_System

Runtime / tecnici:

01_LOGOS_Input_System
02_LOGOS_Match_Engine
03_LOGOS_Event_Lifecycle
04_LOGOS_Retool_Architecture
05_LOGOS_Database_Schema
06_LOGOS_View_Preview_System
LOGOS_RETOOL_RUNTIME_REAL
LOGOS_SUPABASE_RUNTIME_REAL
CHANGELOG

v01 — 2026-04-01

Definizione architettura reale sistema LOGOS
Allineamento completo con Retool e Supabase
Consolidamento layer funzionali
Eliminazione incoerenze tra documenti precedenti

v02 — 2026-04-23

aggiornamento modello append-only (editing su NEW)
introduzione update flow
allineamento parsing deterministico
aggiornamento UI state
introduzione problemi reattivi e accoppiamento layer

v03 — 2026-04-30

aggiornamento architettura dopo Input System Stabilization
introduzione parse_input_controlled
introduzione trigger_parse_debounced
aggiornamento ui_state.parsed come fonte unica dati strutturati
integrazione Engine Base / Normalization Layer Base
documentata normalizzazione amount/unit
documentata rimozione parsing duplicato da button_input_confirm
aggiornato insert/update flow
documentato refresh events_new dopo save completato
aggiornati limiti strutturali e direzione evolutiva