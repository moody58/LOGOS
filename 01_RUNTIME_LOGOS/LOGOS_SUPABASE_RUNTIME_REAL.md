# LOGOS_SUPABASE_RUNTIME_REAL_v6

DATA: 2026-05-25

------------------------------------------------
DESCRIZIONE
------------------------------------------------

⚠ ATTENZIONE

Questo documento è stato aggiornato per riflettere:

- completamento Normalization Layer Base lato Retool
- completamento Duration Normalization Base lato Retool
- completamento Type Classification Base lato Retool
- completamento Match Engine Unification First Controlled Level lato Retool
- completamento Project / Entity Create Suggestion First Controlled Level lato Retool
- completamento UX Mobile Coherence Pass lato Retool
- completamento Command Intent — Create Project / Entity lato Retool
- completamento UI Readiness / Visibility Aggregator First Controlled Level lato Retool
- completamento Preview Analysis State — First Controlled Layer lato Retool
- completamento Input Analysis Result / Single Interpretation Layer Base lato Retool
- completamento Input Analysis Result — Controlled UI Consumption Pass lato Retool
- completamento Input Analysis Result — Visibility Migration Completion lato Retool
- completamento Linting / Retool Query Safety Pass lato Retool
- stabilizzazione ui_state.parsed
- normalizzazione amount/unit prima di insert/update
- durate certe ore/minuti salvate come minuti
- type salvato in events.type
- project_id/entity_id più coerenti tramite match state
- project/entity creati solo tramite conferma utente
- comandi puri esclusi dal salvataggio eventi
- feedback_mode / feedback_summary non persistiti
- input_analysis_result / preview_analysis_state / ui_visibility_mode / ui_visibility_state non persistiti
- rimozione parsing legacy da button_input_confirm
- validazione insert/update con dati normalizzati
- fix refresh events_new dopo update
- linting Retool azzerati senza modifiche Supabase

Nota:

Tutti i nodi sopra elencati sono runtime Retool.
Non hanno modificato schema Supabase, tabelle, vincoli, payload o RPC.

Fonte canonica per il comportamento Retool completo:

- LOGOS_RETOOL_RUNTIME_REAL
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture

Fonte canonica per lo schema DB:

- 05_LOGOS_Database_Schema

Versioni precedenti descrivevano un sistema con parsing avanzato,
ma non ancora normalizzato in modo stabile nel save flow.

Documento tecnico completo del database reale LOGOS su Supabase.

Obiettivo:

- fotografare lo stato reale del sistema AS-IS
- documentare ogni tabella, campo, vincolo e comportamento
- rappresentare fedelmente l’uso attuale lato Retool
chiarire il rapporto tra Supabase e i layer runtime Retool:

- Normalization Layer Base
- Duration Normalization Base
- Type Classification Base
- Match Engine Unification First Controlled Level
- Project / Entity Create Suggestion First Controlled Level
- Command Intent — Create Project / Entity
- UI Readiness / Visibility Aggregator
- Preview Analysis State
- Input Analysis Result
- Visibility Migration Completion
- Linting / Retool Query Safety Pass

Nota:

Supabase resta storage layer passivo.

I layer Retool sopra indicati non vengono persistiti come stati DB,
non aggiungono campi,
non aggiungono tabelle,
non modificano payload,
non modificano RPC.

Il database funge da storage layer passivo,
senza logica di business né validazione strutturale applicativa.

------------------------------------------------
RESPONSABILITÀ CANONICA DEL DOCUMENTO
------------------------------------------------

Questo documento è fonte canonica per:

- runtime Supabase reale LOGOS as-is
- comportamento Supabase effettivo
- ruolo di Supabase come storage layer passivo
- schema public lato Supabase nel runtime reale
- tabelle realmente presenti:
  - events
  - projects
  - entities
  - system_logs
- struttura reale delle tabelle Supabase
- vincoli realmente presenti / assenti
- RPC realmente presenti
- update_event_status come RPC di status
- assenza di logica business lato Supabase
- assenza di parsing lato Supabase
- assenza di normalization lato Supabase
- assenza di matching lato Supabase
- assenza di Command Intent lato Supabase
- assenza di input_analysis_result lato Supabase
- assenza di preview_analysis_state lato Supabase
- assenza di ui_visibility_mode / ui_visibility_state lato Supabase
- impatto reale dei nodi Retool su Supabase
- conferma che i nodi recenti non hanno modificato schema, payload, tabelle o RPC
- limiti Supabase attuali
- stato reale Supabase prima di eventuali future migrazioni DB

Questo documento NON è fonte canonica completa per:

- input flow / parser / normalization nel dettaglio runtime frontend
- Match Engine project/entity nel dettaglio runtime frontend
- lifecycle evento completo lato applicazione
- componenti / query / Hidden Retool completi
- Preview / Sintesi / hint / warning completi
- roadmap / priorità / gap governance
- schema DB come modello documentale generale

Fonti canoniche collegate:

- 01_LOGOS_Input_System per input flow, parser, normalization, Command Intent, create_suggestion_state e input_analysis_result.
- 02_LOGOS_Match_Engine per project_state / entity_state / matches / isAmbiguous / singleMatch / moreSpecificMatches / confirm guard matching.
- 03_LOGOS_Event_Lifecycle per lifecycle evento, edit, no-op, cancel, NEW / WRITTEN / ERROR e processing.
- 04_LOGOS_Retool_Architecture per componenti, query, Hidden, button_input_confirm, insert_event, update_event, insert_project, insert_entity e wiring Retool.
- 05_LOGOS_Database_Schema per schema DB LOGOS come modello documentale canonico.
- 06_LOGOS_View_Preview_System per Sintesi, preview, hint, warning, label visuali e micro-copy.
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is.

Nota post Pacchetto B:

State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo del runtime Supabase.
Il dettaglio completo del comportamento Supabase reale resta in questo documento e in 05_LOGOS_Database_Schema.

------------------------------------------------
ARCHITETTURA GENERALE
------------------------------------------------

Database:

PostgreSQL / Supabase

Schema:

public

Ruolo:

- persistenza dati
- fetch dati
- update eventi
- update status
- nessuna validazione applicativa
- nessuna logica lato DB, eccetto RPC minimale per status

Pattern architetturale:

INPUT  
→ Retool JS  
→ ui_visibility_mode / command_intent_state  
→ se comando puro: azione command controllata senza insert_event  
→ se evento ordinario: parse_input_controlled  
→ ui_state.parsed  
→ select1.value  
→ project_state / entity_state  
→ create_suggestion_state eventuale  
→ select_project / select_entity  
→ preview_analysis_state / input_analysis_result solo come helper UI read-only  
→ insert_event / update_event  
→ Supabase storage  

---

Supabase NON esegue:

- parsing
- normalization
- duration normalization
- type classification
- matching
- match state
- risoluzione ambiguità project/entity
- create_suggestion_state
- command_intent_state
- preview_analysis_state
- input_analysis_result
- ui_visibility_mode
- ui_visibility_state
- feedback_mode
- feedback_summary
- creazione automatica project/entity
- distinzione autonoma tra evento ordinario e comando puro
- direction/economic logic
- decisioni spesa/incasso
- deduplicazione
- KPI

------------------------------------------------
ELENCO TABELLE
------------------------------------------------

CORE:

- events
- projects
- entities

SUPPORT:

- system_logs

------------------------------------------------
TABELLA: events
------------------------------------------------

## STRUTTURA

id (uuid, NOT NULL, default: gen_random_uuid())

created_at (timestamp, NULL, default: now())

updated_at (timestamp, NULL)

event_date (date, NULL)

project_id (uuid, NULL)

entity_id (uuid, NULL)

type (text, NULL)

amount (numeric, NULL)

unit (text, NULL)

reference_id (text, NULL)

source (text, NULL)

payment_method (text, NULL)

notes (text, NULL)

raw_input (text, NULL)

payload (jsonb, NULL, default: {})

status (text, NULL, default: 'NEW')

------------------------------------------------
CONSTRAINT
------------------------------------------------

PRIMARY KEY:

- id

CHECK:

- 2200_17534_1_not_null

ASSENTI:

- foreign key su project_id
- foreign key su entity_id
- unique constraints aggiuntivi
- vincoli applicativi su status
- vincoli applicativi su type
- vincoli applicativi su amount/unit

------------------------------------------------
UTILIZZO REALE
------------------------------------------------

Campi popolati:

- raw_input → sempre valorizzato in insert/update
- amount → valorizzato da ui_state.parsed quando riconosciuto
- unit → valorizzata da ui_state.parsed quando riconosciuta
- event_date → valorizzata quando parsata
- type → valorizzato da select1.value lato Retool
- project_id → valorizzato da select_project.value quando selezionato
- entity_id → valorizzato da select_entity.value quando selezionato
- status → NEW in insert
- updated_at → valorizzato in insert/update
- payload → {}

---

Campi non utilizzati o non consolidati:

- reference_id
- source
- payment_method
- notes
- payload

---

Nota:

amount/unit/date/type/project_id/entity_id sono determinati lato Retool.

Supabase non normalizza,
non classifica,
non esegue matching,
non risolve ambiguità,
non interpreta suggestion,
non interpreta command intent,
non interpreta input_analysis_result,
non interpreta preview_analysis_state,
non governa visibility/readiness UI.

La qualità dipende dal payload inviato da Retool.

Gli helper Retool successivi al 2026-05-02 migliorano interpretazione, visibilità e controllo UI,
ma non modificano il modello Supabase.

------------------------------------------------
NORMALIZATION / DURATION / TYPE / MATCH ENGINE — IMPATTO SU events
------------------------------------------------

La normalizzazione base avviene lato Retool,
prima di insert/update.

Supabase riceve:

- amount come numeric
- unit come text normalizzata
- event_date come date o null
- type come text
- project_id come uuid o null
- entity_id come uuid o null
- raw_input preservato

---

Regole runtime lato Retool:

```text
458,78 → 458.78
1,5 → 1.5
1.5 → 1.5
1.500 → 1500
1.500,50 → 1500.5
1500 → 1500

Unit normalizzate:

€, euro, eur → euro

h, ora, ore → minuti

min, minuto, minuti → minuti

Regola critica:

numeri senza unità NON vengono salvati come amount.

Esempi:

villa 2 → amount null
villa 2 mario → amount null
cliente 2026 → amount null

Esempi validati:

1.500,50 euro materiale
→ amount: 1500.5
→ unit: euro
→ type: Evento
→ status: NEW

1,5 ore lavoro
→ amount: 90
→ unit: minuti
→ type: Tempo
→ status: NEW

2h30 rendering
→ amount: 150
→ unit: minuti
→ type: Tempo
→ status: NEW

20 euro spesa materiale
→ amount: 20
→ unit: euro
→ type: Spesa
→ status: NEW

20 euro incasso cliente
→ amount: 20
→ unit: euro
→ type: Incasso
→ status: NEW

villa 2 mario
→ amount: null
→ unit: null
→ type: Evento
→ project_id: Villa 2
→ entity_id: Mario
→ status: NEW

18 min ristrutturazione bagno
→ amount: 18
→ unit: minuti
→ type: Tempo
→ project_id: Ristrutturazione Bagno
→ status: NEW

COMPORTAMENTO REALE

Parsing / Normalization / Type / Matching lato Retool:

parse_input_controlled
trigger_parse_debounced
ui_state.parsed
select1.value
project_state
entity_state
select_project
select_entity
button_input_confirm legge fonti runtime controllate
insert_event / update_event ricevono payload già strutturato

Supporto attuale:

euro (€ / euro / eur)
ore (ora / ore / h)
minuti (min / minuto / minuti)
unità compatte
decimali italiani
migliaia italiane
multi-numero con selezione per prossimità
esclusione formato orario HH:MM
esclusione numeri senza unità
duration normalization ore/minuti → minuti
type classification base
match state project/entity
singleMatch project/entity
confirm guard su ambiguità non risolta

Limitazioni:

nessuna gestione multi-unità avanzata
giorni/settimane non convertiti automaticamente
giornata / mezza giornata non normalizzate
parole numeriche tipo “due ore” non supportate
nessuna type classification avanzata
nessun amount firmato
nessun direction field
nessun alias system
nessun fuzzy matching
nessuna gerarchia project/entity
nessuna deduplicazione project/entity
creazione guidata project/entity implementata lato Retool tramite insert_project / insert_entity,
sempre previa conferma utente e senza salvataggio automatico dell’evento

EDITING EVENTI

Il sistema supporta modifica eventi in stato NEW.

Caratteristiche:

update_event lato Retool
modifica evento esistente
status invariato
updated_at aggiornato
lista events_new aggiornata dopo save completato

Campi modificati:

raw_input
amount
unit
event_date
project_id
entity_id
project_id/entity_id derivano da select_project/select_entity lato Retool
updated_at
type

Vincoli applicativi:

editing consentito solo su eventi NEW
eventi WRITTEN / ERROR non modificabili da UI

Nota:

Il DB non impedisce autonomamente update impropri.
Il vincolo è applicativo, gestito da Retool.

Edit flow aggiornato:

btn_edit rilancia anche:

- parse_input_controlled
- project_state
- entity_state

Questo mantiene coerenti suggerimenti, select, hint e confirm guard
anche in modalità modifica evento.

------------------------------------------------
PROJECT / ENTITY CREATE SUGGESTION — IMPATTO SUPABASE
------------------------------------------------

Project / Entity Create Suggestion First Controlled Level è stato implementato lato Retool.

Impatto Supabase:

- nessuna modifica schema
- nessuna nuova tabella
- nessun nuovo campo
- nessuna modifica payload
- nessuna nuova RPC
- create_suggestion_state non viene persistito
- dismissed state non viene persistito
- candidateName / draftName non vengono persistiti come tali

Scritture possibili:

- insert_project scrive una nuova riga in projects
- insert_entity scrive una nuova riga in entities

Regole:

- insert_project / insert_entity partono solo dopo conferma esplicita utente
- la creazione project/entity non salva automaticamente l’evento
- l’evento resta da confermare separatamente tramite insert_event
- project/entity mancanti possono restare null se l’utente ignora la suggestion
- project/entity ambigui bloccano il salvataggio lato Retool finché non risolti

Supabase non propone,
non decide,
non deduplica strutturalmente,
non collega automaticamente project/entity all’evento.

Fonte canonica per comportamento suggestion lato Retool:

- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

------------------------------------------------
COMMAND INTENT — IMPATTO SUPABASE
------------------------------------------------

Command Intent — Create Project / Entity è stato implementato lato Retool.

Impatto Supabase:

- nessuna modifica schema
- nessuna nuova tabella
- nessun campo command_intent
- nessun command_intent_payload
- nessun feedback_mode persistito
- nessuna modifica payload events
- nessuna nuova RPC

Comportamento:

- input “crea” mostra guida UI, senza scritture DB
- input “crea progetto [nome]” può eseguire insert_project solo dopo conferma utente
- input “crea entità [nome]” può eseguire insert_entity solo dopo conferma utente
- input “crea progetto [nome esistente]” non duplica se il frontend riconosce elemento già presente
- input “modifica evento” esegue solo routing UI verso lista eventi, senza update_event

Regola critica:

i comandi puri non creano record in events.

Supabase non distingue autonomamente evento ordinario da comando puro.
La distinzione avviene lato Retool tramite command_intent_state / input_analysis_result.

Fonte canonica per Command Intent lato Retool:

- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

------------------------------------------------
UI READINESS / PREVIEW ANALYSIS / INPUT ANALYSIS RESULT — IMPATTO SUPABASE
------------------------------------------------

I layer:

- ui_visibility_mode
- ui_visibility_state
- preview_analysis_state
- input_analysis_result

sono helper Retool read-only / UI-runtime.

Impatto Supabase:

- nessuna modifica schema
- nessuna nuova tabella
- nessun nuovo campo
- nessuna modifica payload
- nessuna nuova RPC
- nessuna persistenza di readiness
- nessuna persistenza di raw / selection / effective
- nessuna persistenza di canShowConfirm / canConfirm
- nessuna persistenza di hint/status preview
- nessuna persistenza di visibility state

Regole:

- input_analysis_result non costruisce payload
- preview_analysis_state non costruisce payload
- ui_visibility_mode non viene salvato
- ui_visibility_state non viene salvato
- button_input_confirm.Disabled resta guard funzionale lato Retool
- button_input_confirm payload resta separato e invariato
- Supabase riceve solo payload finale di insert_event / update_event o insert_project / insert_entity

Nota:

input_analysis_result governa gli Hidden principali del flow input lato Retool,
ma non modifica dati Supabase.

ui_visibility_state resta residuo tecnico deprecabile / rollback lato Retool,
non stato Supabase.

Fonte canonica:

- 01_LOGOS_Input_System per logica input_analysis_result
- 06_LOGOS_View_Preview_System per preview_analysis_state / Sintesi / hint
- 04_LOGOS_Retool_Architecture per wiring Retool
- LOGOS_RETOOL_RUNTIME_REAL per runtime reale as-is

RACE CONDITION UPDATE → LISTA

Problema precedente:

update_event aggiornava correttamente il DB
events_new veniva refreshato troppo presto
la lista mostrava temporaneamente il dato vecchio
refresh pagina mostrava il dato corretto

Correzione lato Retool:

await savePromise
→ await events_new.trigger()

Risultato:

lista eventi aggiornata subito dopo update
nessun refresh pagina necessario
DB e UI allineati dopo save
ESEMPIO DATI REALI AGGIORNATI

Esempi storici non più rappresentativi:

"50 euro vaccinazione Alfie allevamento Aspri"
→ unit: null

non rappresenta più il comportamento atteso dopo Normalization Layer Base.

Comportamento atteso attuale:

50 euro vaccinazione Alfie allevamento Aspri
→ amount: 50
→ unit: euro
→ type: Evento o selezione manuale utente
→ project/entity secondo match state e select

50 minuti di prove
→ amount: 50
→ unit: minuti
→ type: Tempo

15:35 TEST
→ amount: null
→ unit: null
→ type: Evento

villa 2 mario
→ amount: null
→ unit: null
→ type: Evento
→ project_id: Villa 2
→ entity_id: Mario

1.500,50 euro materiale
→ amount: 1500.5
→ unit: euro
→ type: Evento

20 euro spesa materiale
→ amount: 20
→ unit: euro
→ type: Spesa

20 euro incasso cliente
→ amount: 20
→ unit: euro
→ type: Incasso

2h30 rendering
→ amount: 150
→ unit: minuti
→ type: Tempo

18 min ristrutturazione bagno
→ amount: 18
→ unit: minuti
→ type: Tempo
→ project_id: Ristrutturazione Bagno

4 aprile benzina 50 euro alfie allevamento aspri
→ amount: 50
→ unit: euro
→ type: Evento
→ project_id: ASPRI
→ entity_id: null finché ambiguità non risolta

Esempi successivi Project / Entity Create Suggestion:

villa sierri 15 sopralluogo referente kappa
→ insert_project se confermato dall’utente
→ insert_entity se confermato dall’utente
→ eventuale insert_event solo dopo Conferma evento
→ nessun salvataggio automatico evento

Esempi successivi Command Intent:

crea progetto Villa Nuova
→ insert_project se confermato dall’utente
→ nessun insert_event

crea entità Patrizio
→ insert_entity se confermato dall’utente
→ nessun insert_event

modifica evento
→ routing UI verso lista eventi
→ nessun update_event

TABELLA: projects
STRUTTURA

id (uuid, NOT NULL, default: gen_random_uuid())

name (text, NULL)

parent_project_id (uuid, NULL)

type (text, NULL)

status (text, NULL, default: 'ACTIVE')

created_at (timestamp, NULL, default: now())

CONSTRAINT

PRIMARY KEY:

id

UNIQUE:

name

CHECK:

2200_17545_1_not_null

ASSENTI:

foreign key su parent_project_id

CARATTERISTICHE
name univoco → base per matching
supporto gerarchia tramite parent_project_id
gerarchia non attiva nel runtime
campo type non utilizzato
campo status non utilizzato lato Retool

UTILIZZO REALE

utilizzato per matching testuale lato Retool
caricato da projects_list
utilizzato da project_state
select_project legge singleMatch da project_state
project_id salvato in events quando selezionato
priority match minimo gestito lato Retool
popolabile tramite insert_project lato Retool
insert_project può essere invocato da Project Create Suggestion o Command Intent
creazione sempre previa conferma utente
nessun evento creato automaticamente dopo insert_project
nessuna gestione gerarchia
nessun filtro operativo per status

Esempi runtime:

villa → Villa + hint progetti più specifici
villa 2 → Villa 2
ristrutturazione bagno → Ristrutturazione Bagno
casa mare → Casa Mare

TABELLA: entities
STRUTTURA

id (uuid, NOT NULL, default: gen_random_uuid())

type (text, NULL)

name (text, NULL)

parent_entity_id (uuid, NULL)

status (text, NULL)

metadata (jsonb, NULL, default: {})

created_at (timestamp, NULL, default: now())

updated_at (timestamp, NULL, default: now())

CONSTRAINT

PRIMARY KEY:

id

CHECK:

2200_17557_1_not_null

ASSENTI:

unique su name
foreign key su parent_entity_id

CARATTERISTICHE
struttura simile a projects
nessun vincolo di unicità
possibili duplicati
metadata disponibile per estensioni
supporto aggiornamento updated_at
parent_entity_id non operativo

UTILIZZO REALE

caricata in UI tramite entities_list
utilizzata da entity_state
select_entity legge singleMatch da entity_state
entity_id salvato in events quando selezionato
priority match minimo gestito lato Retool
popolabile tramite insert_entity lato Retool
insert_entity può essere invocato da Entity Create Suggestion o Command Intent
creazione sempre previa conferma utente
nessun evento creato automaticamente dopo insert_entity
nessuna gerarchia attiva
metadata non usato in modo strutturale

Esempi runtime:

mario → Mario + hint entità più specifiche
mario rossi → Mario Rossi + hint entità più specifiche
mario rossi alfredo → Mario Rossi Alfredo
alfie mario rossi → ambiguità reale, conferma bloccata finché non viene scelta entità

TABELLA: system_logs
STRUTTURA

id (uuid, NOT NULL, default: gen_random_uuid())

event_id (uuid, NULL)

action (text, NULL)

timestamp (timestamp, NULL, default: now())

note (text, NULL)

CONSTRAINT

PRIMARY KEY:

id

ASSENTI:

foreign key su event_id
CARATTERISTICHE
struttura per logging eventi
supporto audit trail potenziale
non integrata nel runtime attuale
UTILIZZO REALE
nessun inserimento operativo rilevante
nessuna integrazione con Retool
non usata per versioning modifiche
non usata per audit trail update_event
RPC: update_event_status

⚠ NOTA

update_event_status gestisce SOLO lo stato:

WRITTEN
ERROR

NON gestisce editing contenuto evento.

PARAMETRI

event_id (text)

new_status (text)

IMPLEMENTAZIONE
begin
update events
set status = new_status
where id = event_id::uuid;
end;
CARATTERISTICHE
nessuna validazione input
nessun controllo stato precedente
nessun ritorno
nessun logging
nessun updated_at documentato nella RPC
nessun controllo transizione
COMPORTAMENTO GLOBALE SISTEMA

Flusso create evento ordinario:

input testo
→ Retool ui_visibility_mode / command_intent_state
→ se NON è comando puro
→ Retool parsing controlled
→ Retool normalization base
→ Retool duration normalization
→ Retool type classification base
→ Retool match state project/entity
→ Retool create_suggestion_state eventuale
→ select_project / select_entity
→ preview_analysis_state / input_analysis_result come helper UI read-only
→ preview
→ insert_event
→ status NEW
→ events_new refresh

Flusso command puro:

input testo
→ Retool command_intent_state
→ input_analysis_result governa visibilità command lato UI
→ eventuale insert_project / insert_entity se confermato dall’utente
→ oppure routing UI verso lista eventi
→ nessun insert_event
→ nessun evento NEW

Flusso edit:

evento NEW
→ load raw_input
→ Retool parsing controlled
→ Retool normalization base
→ Retool duration normalization
→ Retool type classification base
→ Retool match state project/entity
→ select_project / select_entity
→ preview
→ update_event
→ status invariato NEW
→ type/project_id/entity_id aggiornati se modificati
→ updated_at aggiornato
→ events_new refresh dopo save completato

Flusso processing:

NEW
→ update_written / update_error
→ WRITTEN / ERROR

Il database:

non interpreta dati
non valida dati
non corregge dati
non normalizza dati
non gestisce lifecycle avanzato
non versiona modifiche
non decide type
non decide project/entity
non risolve ambiguità
non propone project/entity
non crea project/entity automaticamente
non distingue evento ordinario da comando puro
non interpreta Command Intent
non interpreta input_analysis_result
non interpreta preview_analysis_state
non governa visibility/readiness UI
non riceve match state
non riceve suggestion state
non riceve command state
non riceve feedback_mode
non riceve feedback_summary

STATO SISTEMA

events:

attivo
utilizzato
riceve dati normalizzati base da Retool
riceve durate certe normalizzate in minuti
riceve type determinato da select1.value
riceve project_id/entity_id da select_project/select_entity
modificabile solo applicativamente in stato NEW
privo di storico revisioni

projects:

attivo
utilizzato per matching lato Retool
utilizzato da project_state
name univoco
popolabile tramite insert_project lato Retool
insert_project usato da Project Create Suggestion e Command Intent
creazione sempre previa conferma utente
nessun evento creato automaticamente dopo insert_project
nessuna gerarchia attiva

entities:

attivo
utilizzato per matching lato Retool
utilizzato da entity_state
nessun vincolo unique
popolabile tramite insert_entity lato Retool
insert_entity usato da Entity Create Suggestion e Command Intent
creazione sempre previa conferma utente
nessun evento creato automaticamente dopo insert_entity
nessuna gerarchia attiva

system_logs:

presente
inattivo

RPC:

update_event_status attiva per status
non usata per editing contenuto evento

LIMITI SUPABASE ATTUALI
DB PASSIVO
nessuna logica business
nessun controllo applicativo lato DB

NESSUNA VALIDAZIONE FORTE
project_id/entity_id non vincolati
status non governato da constraint applicativa documentata
type non validato

MATCH STATE NON PERSISTITO
matches non salvati
count non salvato
isAmbiguous non salvato
singleMatch non salvato
moreSpecificMatches non salvato
confirm guard gestita solo lato Retool

NESSUN VERSIONING
update_event sovrascrive evento NEW
nessun audit trail modifiche
system_logs non utilizzata

TYPE UTILIZZATO A LIVELLO BASE
Spesa / Incasso / Tempo / Evento salvati in events.type
type deciso lato Retool
non sufficiente da solo per output/KPI avanzati
nessun amount firmato
nessun direction field

PAYLOAD NON UTILIZZATO
sempre {}
nessuna struttura definita

DATI STORICI NON RETRO-NORMALIZZATI
eventi precedenti possono avere qualità inferiore
nessuna bonifica automatica

PROJECT/ENTITY STRUTTURALI NON EVOLUTI

nessun alias system
nessun fuzzy matching
nessuna deduplicazione strutturale DB
nessuna gerarchia attiva
creazione guidata project/entity implementata lato Retool a primo livello controllato
insert_project / insert_entity disponibili come scritture controllate
nessuna creazione automatica project/entity lato DB
nessun evento creato automaticamente dopo creazione project/entity

CONCLUSIONI

Il database LOGOS:

è strutturalmente solido
è progettato per scalabilità
non impone vincoli rigidi
delega la logica a Retool
resta passivo
riceve dati più coerenti dopo Normalization Layer Base

Stato attuale:

sistema funzionante
parsing controllato lato client
normalization base lato client
duration normalization base lato client
type classification base lato client
Match Engine Unification First Controlled Level lato client
matching project/entity unificato a primo livello controllato
Project / Entity Create Suggestion lato client
Command Intent — Create Project / Entity lato client
UI Readiness / Preview Analysis State / Input Analysis Result lato client
Visibility Migration Completion lato client
Linting / Retool Query Safety Pass lato client
editing eventi disponibile
edit flow allineato a match state
update flow attivo
lista aggiornata dopo save
grande capacità inutilizzata

⚠ la coerenza dei dati è garantita esclusivamente dal frontend

⚠ modifiche eventi non sono versionate

⚠ Supabase non esegue logica business

⚠ match state non viene persistito

⚠ output/KPI non attivi

------------------------------------------------
NOTA POST VISIBILITY MIGRATION / LINTING PASS
------------------------------------------------

I nodi:

- Input Analysis Result — Visibility Migration Completion
- Linting / Retool Query Safety Pass

non hanno modificato Supabase.

Conferme:

- schema DB invariato
- tabelle invariate
- campi invariati
- payload invariato
- RPC invariate
- nessun dato input_analysis_result persistito
- nessun dato preview_analysis_state persistito
- nessun dato ui_visibility_state persistito
- nessun dato ui_visibility_mode persistito
- nessun dato feedback_mode / feedback_summary persistito
- linting Retool azzerati lato frontend
- nessuna modifica alla logica Supabase

La fonte canonica per i dettagli Retool è LOGOS_RETOOL_RUNTIME_REAL.
La fonte canonica per lo schema DB è 05_LOGOS_Database_Schema.

CHANGELOG

v1 — 2026-04-01

runtime iniziale Supabase
documentazione schema reale
DB passivo
eventi NEW

v2 — 2026-04-23

aggiornamento parsing avanzato lato Retool
introduzione update_event
introduzione editing eventi
aggiunta updated_at
allineamento con runtime reale Retool

v3 — 2026-04-30

nessuna modifica schema Supabase
integrazione Normalization Layer Base lato Retool
aggiornato comportamento amount/unit ricevuto da Retool
chiarito che Supabase non esegue normalizzazione
aggiornati esempi reali dopo fix parser
documentato amount numeric e unit text normalizzata
documentato fix update → events_new refresh lato Retool
esplicitato che dati storici non sono retro-normalizzati
esplicitati limiti: no versioning, no duration normalization, no type classification

v4 — 2026-05-02

nessuna modifica schema Supabase
integrazione Duration Normalization Base lato Retool
integrazione Type Classification Base lato Retool
integrazione Match Engine Unification First Controlled Level lato Retool
chiarito che Supabase riceve durate certe come amount minuti / unit minuti
chiarito che Supabase riceve type da select1.value
chiarito che Supabase riceve project_id/entity_id da select_project/select_entity
documentato project_state/entity_state come runtime frontend
documentato che match state non viene persistito
documentato che Supabase non decide type
documentato che Supabase non decide project/entity
documentato che Supabase non risolve ambiguità
documentato che Supabase non crea project/entity automaticamente
documentato confirm guard su ambiguità non risolta lato Retool
documentati esempi 2h30 rendering, 20 euro spesa materiale, villa 2 mario, ristrutturazione bagno
documentato edit flow aggiornato con match state live
confermata assenza versioning
confermato output/KPI non attivi

v5 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicata normalizzazione controllata Pacchetto A — Allineamento alto / Lifecycle / Supabase
- allineato il documento allo stato post Project / Entity Create Suggestion First Controlled Level
- allineato il documento allo stato post UX Mobile Coherence Pass
- allineato il documento allo stato post Command Intent — Create Project / Entity
- allineato il documento allo stato post UI Readiness / Visibility Aggregator First Controlled Level
- allineato il documento allo stato post Preview Analysis State — First Controlled Layer
- allineato il documento allo stato post Input Analysis Result / Single Interpretation Layer Base
- allineato il documento allo stato post Input Analysis Result — Controlled UI Consumption Pass
- allineato il documento allo stato post Input Analysis Result — Visibility Migration Completion
- allineato il documento allo stato post Linting / Retool Query Safety Pass
- chiarito che tutti questi nodi sono runtime Retool e non modificano Supabase
- confermato schema DB invariato
- confermate tabelle invariate
- confermati campi invariati
- confermato payload invariato
- confermate RPC invariate
- documentato che create_suggestion_state non viene persistito
- documentato che command_intent_state non viene persistito
- documentato che preview_analysis_state non viene persistito
- documentato che input_analysis_result non viene persistito
- documentato che ui_visibility_mode / ui_visibility_state non vengono persistiti
- documentato che feedback_mode / feedback_summary non vengono persistiti
- documentato che insert_project / insert_entity possono essere usati da Project / Entity Create Suggestion e Command Intent
- confermato che insert_project / insert_entity partono solo previa conferma utente
- confermato che la creazione project/entity non salva automaticamente eventi
- confermato che i comandi puri non creano record in events
- confermato che “modifica evento” da Command Intent non esegue update_event
- chiarito che input_analysis_result governa visibility/readiness UI lato Retool, non dati Supabase
- chiarito che ui_visibility_state resta residuo tecnico deprecabile / rollback lato Retool
- aggiunti richiami canonici a:
  - LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
  - 01_LOGOS_Input_System per input / command / input_analysis_result
  - 04_LOGOS_Retool_Architecture per wiring Retool
  - 06_LOGOS_View_Preview_System per preview_analysis_state / Sintesi / hint
  - 05_LOGOS_Database_Schema per schema DB
- nessuna modifica runtime LOGOS
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica schema
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica save flow
- nessuna anticipazione output / KPI / dashboard

v6 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicato Pacchetto C — Documenti tecnici canonici su LOGOS_SUPABASE_RUNTIME_REAL
- documento aggiornato da v5 a v6
- confermato LOGOS_SUPABASE_RUNTIME_REAL come fonte canonica per runtime Supabase reale as-is, comportamento storage layer passivo, tabelle presenti, vincoli presenti/assenti, RPC reali e impatto dei nodi Retool su Supabase
- aggiunta sezione RESPONSABILITÀ CANONICA DEL DOCUMENTO
- chiarito che State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo del runtime Supabase
- chiarito che il dettaglio completo del comportamento Supabase reale resta in questo documento e in 05_LOGOS_Database_Schema
- aggiunti richiami canonici a:
  - 01_LOGOS_Input_System per input flow, parser, normalization, Command Intent, create_suggestion_state e input_analysis_result
  - 02_LOGOS_Match_Engine per Match Engine project/entity
  - 03_LOGOS_Event_Lifecycle per lifecycle evento
  - 04_LOGOS_Retool_Architecture per componenti/query/Hidden/button_input_confirm/insert_event/update_event/insert_project/insert_entity/wiring Retool
  - 05_LOGOS_Database_Schema per schema DB LOGOS come modello documentale canonico
  - 06_LOGOS_View_Preview_System per Sintesi, preview, hint e warning
  - LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
- nessuna riduzione aggressiva applicata
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica schema
- nessuna migrazione Supabase
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica payload
- nessuna anticipazione output / KPI / dashboard