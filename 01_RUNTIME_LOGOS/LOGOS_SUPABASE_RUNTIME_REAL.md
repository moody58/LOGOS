# LOGOS_SUPABASE_RUNTIME_REAL_v4

DATA: 2026-05-02

------------------------------------------------
DESCRIZIONE
------------------------------------------------

⚠ ATTENZIONE

Questo documento è stato aggiornato per riflettere:

- completamento Normalization Layer Base lato Retool
- completamento Duration Normalization Base lato Retool
- completamento Type Classification Base lato Retool
- completamento Match Engine Unification First Controlled Level lato Retool
- stabilizzazione ui_state.parsed
- normalizzazione amount/unit prima di insert/update
- durate certe ore/minuti salvate come minuti
- type salvato in events.type
- project_id/entity_id più coerenti tramite match state
- rimozione parsing legacy da button_input_confirm
- validazione insert/update con dati normalizzati
- fix refresh events_new dopo update

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

Il database funge da storage layer passivo,
senza logica di business né validazione strutturale applicativa.

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
→ parse_input_controlled  
→ ui_state.parsed  
→ select1.value  
→ project_state / entity_state  
→ select_project / select_entity  
→ insert_event / update_event  
→ Supabase storage  

---

Supabase NON esegue:

- parsing
- normalization
- matching
- match state
- risoluzione ambiguità project/entity
- creazione automatica project/entity
- type classification
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
non risolve ambiguità.

La qualità dipende dal payload inviato da Retool.

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
nessuna creazione guidata project/entity

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

Flusso create:

input testo
→ Retool parsing controlled
→ Retool normalization base
→ Retool duration normalization
→ Retool type classification base
→ Retool match state project/entity
→ select_project / select_entity
→ preview
→ insert_event
→ status NEW
→ events_new refresh

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
non crea project/entity automaticamente
non riceve match state

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
nessuna gerarchia attiva

entities:

attivo
utilizzato per matching lato Retool
utilizzato da entity_state
nessun vincolo unique
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
nessuna deduplicazione
nessuna gerarchia attiva
nessuna creazione guidata project/entity

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