# 00_PROJECT_System_v04

DATA: 2026-05-01

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
- duration normalization lato Retool
- type classification base lato Retool
- matching lato Retool
- preview lato Retool

Server / Database:

- passivo
- nessuna business logic applicativa
- nessun parsing
- nessuna normalizzazione
- nessuna classificazione autonoma
- nessuna decisione type lato DB

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
- riceve type già determinato lato UI

---

2. UI RESPONSABILE

La UI:

- gestisce input
- interpreta dati
- normalizza dati base
- normalizza durate certe ore/minuti
- classifica type a livello base
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

amount, unit, event_date, type, project_id, entity_id:

- sono derivati da parsing, normalization, type classification, matching o selezione utente
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
- duration normalization
- type classification
- preview
- matching
- insert/update
- processing
- output

Stato attuale:

✔ input/parsing/save più separati  
✔ normalization base introdotta  
✔ duration normalization base introdotta  
✔ type classification base introdotta  
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
4. DURATION NORMALIZATION BASE LAYER
5. TYPE CLASSIFICATION BASE LAYER
6. MATCH LAYER
7. PREVIEW / VIEW LAYER
8. UI STATE LAYER
9. INSERT / UPDATE LAYER
10. PROCESSING LAYER

LIVELLI FUTURI:

11. MATCH ENGINE UNIFICATION
12. ENGINE ADVANCED
13. OUTPUT / ANALYTICS LAYER

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
- supporto durate composte ore/minuti
- normalizzazione durata base in minuti

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

------------------------------------------------
3 — NORMALIZATION BASE LAYER
------------------------------------------------

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
20 euro materiale → amount 20, unit euro
villa 2 mario → amount null, unit null

Non implementato:

giorni/settimane come conversione automatica
giornata lavorativa
mezza giornata
parole numeriche tipo “due ore”
forme colloquiali tipo “un paio d’ore”

------------------------------------------------
4 — DURATION NORMALIZATION BASE LAYER
------------------------------------------------

Stato:

✔ implementato

Collocazione attuale:

incorporato in parse_input_controlled

Funzione:

rendere confrontabili le durate certe espresse in ore/minuti.

Decisione:

amount tempo = totale minuti
unit tempo = "minuti"
raw_input preservato
nessuna modifica schema DB
nessun payload duration
nessun campo duration_minutes dedicato

Esempi:

1 ora → amount 60, unit minuti
1,5 ore → amount 90, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
2h30 → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti
18min → amount 18, unit minuti
90 minuti → amount 90, unit minuti

Ambiguità non convertite:

2 giorni rendering → amount null, unit null
1 settimana lavoro → amount null, unit null
mezza giornata → amount null, unit null

Motivo:

giorni/settimane/giornate possono indicare calendario,
giornata lavorativa, evento, cantiere o turno operativo.

------------------------------------------------
5 — TYPE CLASSIFICATION BASE LAYER
------------------------------------------------

Stato:

✔ implementato

Componente principale:

select1

Funzione:

classificare l’evento a livello base,
in modo prudente e correggibile dall’utente.

Valori attuali:

- Evento
- Tempo
- Spesa
- Incasso

Regole principali:

parsed.unit = "minuti"
→ Tempo

euro + keyword controllate di uscita
→ Spesa

euro + keyword controllate di entrata
→ Incasso

euro senza direzione chiara
→ Evento

segnali economici contrastanti
→ Evento

nessuna unit significativa
→ Evento

Esempi:

2h30 rendering
→ type Tempo
→ amount 150
→ unit minuti

20 euro spesa materiale
→ type Spesa
→ amount 20
→ unit euro

20 euro incasso cliente
→ type Incasso
→ amount 20
→ unit euro

20 euro materiale
→ type Evento
→ amount 20
→ unit euro

villa 2 mario
→ type Evento
→ amount null
→ unit null

Principio:

La classificazione automatica è base e prudente.
L’utente può sempre modificare select1 manualmente.

Persistenza:

select1.value
→ payload.type
→ insert_event / update_event
→ events.type

Limiti:

nessuna classificazione economica avanzata
nessun amount firmato
nessun direction field
nessuna retro-normalizzazione storico
type non ancora sufficiente per KPI avanzati

6 — MATCH LAYER

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

7 — PREVIEW / VIEW LAYER

Funzione:

Mostrare all’utente l’interpretazione del sistema.

Mostra:

amount
unit
event_date
type / select1
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
✔ formattazione italiana amount allineata
✔ durata normalizzata mostrata in forma umana
⚠ preview non ancora view pura

Esempi attuali:

amount: 1500.5
unit: euro
→ preview: 1.500,50 €

amount: 150
unit: minuti
raw_input: 2h30 rendering
→ preview: 2 ore 30 minuti
→ hint: Normalizzato: 150 minuti

Nota:

la preview usa anche select1.value per mostrare il tipo,
ma non salva direttamente il type.
La persistenza avviene tramite button_input_confirm.

8 — UI STATE LAYER

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

Fonte unica dati strutturati parsing/normalization:

ui_state.parsed

Fonte type:

select1.value

Usato da:

preview
button_input_confirm
insert_event
update_event

Nota:

ui_state.parsed alimenta amount/unit/event_date.
select1.value alimenta type.

Regola:

ui_state.parsed deve restare sempre oggetto strutturato,
non null.

9 — INSERT / UPDATE LAYER

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
  type: select1.value || "Evento",
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
}

Insert:

crea evento NEW
salva raw_input
salva type
salva amount/unit/event_date
salva project/entity se selezionati

Update:

modifica evento NEW
mantiene status NEW
aggiorna type
aggiorna amount/unit/event_date
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

10 — PROCESSING LAYER

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

DURATION NORMALIZATION:

durate certe ore/minuti → minuti

↓

TYPE CLASSIFICATION:

select1.value

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

evento salvato con status NEW e type valorizzato

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

TYPE CLASSIFICATION:

select1.value

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

evento aggiornato, status NEW, type aggiornato

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
✔ duration normalization base attiva
✔ type classification base attiva
✔ save flow allineato a ui_state.parsed e select1.value
✔ DB coerente con payload
✔ events.type valorizzato in insert/update
✔ lista aggiornata dopo save/update

⚠ sistema incompleto nei layer evolutivi:

match engine unification
hint state-driven
data structure avanzata
economic direction advanced
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
type classification base implementata ma non avanzata
spesa/incasso implementati solo a livello base
amount firmato non implementato
direction field non implementato
giorni/settimane non convertiti automaticamente
multi-unit avanzato non supportato
dati storici non retro-normalizzati
lifecycle senza versioning
output non attivo
linting Retool residuo non bloccante

DIREZIONE EVOLUTIVA

Ordine corretto sviluppo aggiornato:

input reliability ✔
event editing ✔
input system stabilization ✔
normalization layer base ✔
preview alignment base ✔
duration normalization ✔
type classification base ✔
match engine unification
hint state-driven
data structure avanzata
economic direction advanced
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

v04 — 2026-05-01

aggiornamento architettura dopo Type Classification Base
integrazione Duration Normalization Base
integrazione Type Classification Base
documentata unità canonica tempo = minuti
documentata catena select1.value → payload.type → events.type
documentato type persistito in insert_event/update_event
documentati valori type: Evento, Tempo, Spesa, Incasso
documentato che DB resta passivo e non decide type
documentato che type è deciso lato UI
documentato override manuale utente
documentato che amount resta positivo
documentato che output/KPI non sono attivi
documentato matching non unificato come prossimo nodo architetturale
aggiornati limiti strutturali e direzione evolutiva