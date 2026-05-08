# 05_LOGOS_Database_Schema_v08

DATA: 2026-05-07

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- tutte le tabelle documentate  
- campi reali allineati  
- comportamento runtime incluso  
- update flow documentato  
- normalization base lato frontend integrata  
- duration normalization lato frontend integrata  
- type classification base lato frontend integrata  
- Match Engine Unification First Controlled Level integrato  
- utilizzo reale di events.type documentato  
- utilizzo più coerente di events.project_id / events.entity_id documentato  
- schema invariato esplicitato  
- Project / Entity Create Suggestion First Controlled Level integrato
- insert_project / insert_entity documentati come scritture controllate lato Retool
- popolamento projects/entities da UI documentato
- confermato che la creazione inline non modifica schema DB
- confermato che create_suggestion_state non viene persistito

Q (Qualità): 9.5/10  
- struttura corretta  
- schema invariato esplicitato  
- append-only controllato documentato  
- distinzione chiara tra DB passivo e logica frontend  
- chiarito che le durate certe vengono salvate in minuti canonici  
- chiarito che type viene deciso lato Retool e salvato nel DB  
- chiarito che project/entity matching viene deciso lato Retool  
- chiarito che il DB non decide type  
- chiarito che il DB non decide project/entity  
- limiti versioning / relazioni / output esplicitati  
- chiarito che projects/entities possono ora essere popolati da creazione inline controllata
- chiarito che il DB non interpreta suggestion
- chiarito che il DB non distingue evento operativo da command intent
- chiarito che nessun audit trail dedicato è stato introdotto

D (Deployabilità): 10/10  
- documento utilizzabile come riferimento AS-IS  
- coerente con Supabase runtime  
- non introduce modifiche schema non implementate  
- conferma schema invariato dopo Duration Normalization  
- conferma schema invariato dopo Type Classification Base  
- conferma schema invariato dopo Match Engine Unification First Controlled Level  
- conferma schema invariato dopo Project / Entity Create Suggestion First Controlled Level
- insert_project validato su DB reale
- insert_entity validato su DB reale
- evento con project_id/entity_id creati inline validato

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire la struttura dati reale del sistema LOGOS
basata su Supabase / PostgreSQL.

Il documento descrive:

- tabelle
- campi
- comportamento reale
- limiti attuali
- rapporto tra schema DB e runtime Retool
- stato dei dati dopo Normalization Layer Base
- stato dei dati dopo Duration Normalization Base
- stato dei dati dopo Type Classification Base
- stato dei dati dopo Match Engine Unification First Controlled Level
- stato dei dati dopo Project / Entity Create Suggestion First Controlled Level
- popolamento controllato di projects/entities tramite Retool
- assenza di modifiche schema dopo creazione inline project/entity

------------------------------------------------
PRINCIPIO ARCHITETTURALE
------------------------------------------------

Il database è PASSIVO.

NON contiene:

- logica di business
- validazione applicativa
- trasformazioni dati
- parsing
- matching
- normalizzazione
- classificazione autonoma tipo evento
- matching autonomo project/entity
- creazione automatica project/entity
- logica di suggestion project/entity
- command intent
- audit trail automatico per creazione project/entity
- disambiguazione autonoma

---

Il database:

- memorizza eventi
- garantisce persistenza
- espone dati a Retool
- conserva lo stato corrente dell’evento

---

Nota:

La normalizzazione base introdotta nel sistema avviene lato Retool,
prima di insert/update.

Supabase riceve già:

- amount numerico
- unit testuale normalizzata
- raw_input preservato
- durate certe ore/minuti normalizzate in minuti
- type determinato lato Retool

Nota Duration Normalization:

La normalizzazione durata avviene lato Retool.

Il database NON calcola durate,
NON converte ore/minuti,
NON interpreta giorni/settimane.

Riceve solo il payload già normalizzato dal frontend.

Nota Type Classification Base:

La classificazione type avviene lato Retool.

Il database NON decide type,
NON corregge type,
NON distingue autonomamente Spesa/Incasso/Tempo/Evento.

Riceve solo il valore già determinato dal frontend tramite:

select1.value
→ payload.type
→ events.type

Nota terminologica:

select1 è un componente UI Select di Retool,
non una query.

Nota Match Engine Unification First Controlled Level:

Il matching project/entity avviene lato Retool.

Il database NON decide project_id,
NON decide entity_id,
NON corregge associazioni,
NON risolve ambiguità,
NON crea project/entity automaticamente.

Riceve solo i valori già scelti o confermati dal frontend tramite:

project_state / entity_state
→ select_project.value / select_entity.value
→ payload.project_id / payload.entity_id
→ events.project_id / events.entity_id

Se non esiste match, o l’utente non seleziona project/entity,
i campi restano null.

Se esiste ambiguità non risolta,
il frontend blocca la conferma.

Se l’ambiguità viene risolta manualmente,
il frontend consente il salvataggio.

Nota Project / Entity Create Suggestion First Controlled Level:

La creazione guidata project/entity avviene lato Retool.

Il database NON propone project/entity.
Il database NON decide se creare project/entity.
Il database NON interpreta no-match.
Il database NON interpreta command intent.
Il database NON salva suggestion state.

Retool può ora eseguire:

insert_project
insert_entity

solo dopo conferma esplicita dell’utente.

Dopo creazione project/entity:

- projects / entities vengono aggiornate
- select_project / select_entity vengono valorizzate lato frontend
- l’evento NON viene salvato automaticamente
- l’utente deve confermare manualmente l’evento

Catena project:

create_suggestion_state
→ input_new_project_name
→ insert_project
→ projects
→ projects_list refresh
→ select_project.value
→ events.project_id su conferma evento

Catena entity:

create_suggestion_state
→ input_new_entity_name
→ insert_entity
→ entities
→ entities_list refresh
→ select_entity.value
→ events.entity_id su conferma evento

------------------------------------------------
MODELLO DATI
------------------------------------------------

Tabelle principali:

- events
- projects
- entities

---

Tabelle accessorie:

- system_logs (presente ma non utilizzata)

------------------------------------------------
TABELLA: events
------------------------------------------------

Funzione:

contenitore eventi.

---

Caratteristiche:

- append-only controllato
- ogni riga = evento
- modificabile in stato NEW tramite update_event
- nessuna modifica applicativa prevista su eventi WRITTEN / ERROR
- nessuno storico revisioni
- updated_at usato per tracking ultima modifica

---

CAMPI:

id (uuid, PK)

created_at (timestamp)

updated_at (timestamp, utilizzato per tracking ultima modifica)

event_date (date)

project_id (uuid, opzionale)

entity_id (uuid, opzionale)

type (text, utilizzato per Type Classification Base)

amount (numeric)

unit (text)

reference_id (text, non utilizzato)

source (text, non utilizzato)

payment_method (text, non utilizzato)

notes (text)

raw_input (text)

payload (jsonb, default {})

status (text, default "NEW")

---

UTILIZZO REALE:

✔ raw_input sempre valorizzato  
✔ amount valorizzato da ui_state.parsed  
✔ amount salvato come numeric  
✔ unit valorizzata da ui_state.parsed  
✔ unit normalizzata lato frontend quando riconosciuta
✔ durate certe salvate con unit = minuti  
✔ amount tempo salvato come totale minuti 
✔ type valorizzato da payload.type  
✔ type derivato da select1.value lato Retool  
✔ valori type attuali: Evento, Tempo, Spesa, Incasso  
✔ type aggiornabile tramite update_event su eventi NEW     
✔ event_date valorizzata quando parsata  
✔ project_id opzionale  
✔ project_id derivato da select_project.value lato Retool  
✔ entity_id opzionale  
✔ entity_id derivato da select_entity.value lato Retool  
✔ project/entity matching calcolato lato Retool tramite project_state/entity_state  
✔ ambiguità project/entity non risolta bloccata lato frontend  
✔ nessun match project/entity non blocca il salvataggio  
✔ project_id può derivare da project creato inline e poi selezionato
✔ entity_id può derivare da entity creata inline e poi selezionata
✔ evento non salvato automaticamente dopo insert_project / insert_entity
✔ suggestion ignorata consente salvataggio con project_id/entity_id null  
✔ status sempre NEW in insert  
✔ updated_at valorizzato in insert/update  
✔ eventi NEW modificabili tramite update_event  
✔ nessuna modifica applicativa su WRITTEN / ERROR  

---

NORMALIZATION BASE + DURATION NORMALIZATION + TYPE CLASSIFICATION BASE + MATCH ENGINE UNIFICATION + PROJECT / ENTITY CREATE SUGGESTION — IMPATTO SU events:

La tabella non è stata modificata.

La qualità del dato è migliorata perché il frontend ora invia:

- amount numerico normalizzato
- unit coerente
- numeri senza unità non convertiti in amount
- durate certe ore/minuti convertite in minuti
- type base valorizzato
- raw_input preservato
- project_id più coerente quando il progetto è selezionato
- entity_id più coerente quando l’entità è selezionata
- ambiguità project/entity non salvate silenziosamente
- match univoci alimentati da singleMatch
- project_id/entity_id creati inline quando l’utente conferma la creazione project/entity
- project/entity mancanti ancora ammessi come null se l’utente ignora la suggestion
- nessuna ambiguità project/entity salvata silenziosamente

Esempi:

1.500,50 euro
→ type: Evento
→ amount: 1500.5
→ unit: euro

1ora lavoro
→ type: Tempo
→ amount: 60
→ unit: minuti

1 ora e 15 minuti sopralluogo
→ type: Tempo
→ amount: 75
→ unit: minuti

2h30 rendering
→ type: Tempo
→ amount: 150
→ unit: minuti

2 ore 30 rendering
→ type: Tempo
→ amount: 150
→ unit: minuti

1,5 ore sopralluogo
→ type: Tempo
→ amount: 90
→ unit: minuti

18min test
→ type: Tempo
→ amount: 18
→ unit: minuti

20 euro spesa materiale
→ type: Spesa
→ amount: 20
→ unit: euro

20 euro incasso cliente
→ type: Incasso
→ amount: 20
→ unit: euro

20 euro materiale
→ type: Evento
→ amount: 20
→ unit: euro

2 giorni rendering
→ type: Evento
→ amount: null
→ unit: null
→ raw_input preservato

villa 2 mario
→ type: Evento
→ amount: null
→ unit: null

Esempi Match Engine Unification:

villa 2 mario
→ type: Evento
→ amount: null
→ unit: null
→ project_id: Villa 2
→ entity_id: Mario

18 min ristrutturazione bagno
→ type: Tempo
→ amount: 18
→ unit: minuti
→ project_id: Ristrutturazione Bagno

4 aprile benzina 50 euro alfie allevamento aspri
→ type: Evento
→ amount: 50
→ unit: euro
→ project_id: ASPRI
→ entity_id: null finché ambiguità non risolta

alfie mario rossi
→ entity ambigua
→ salvataggio bloccato finché l’utente non sceglie entità

acquisto 50 euro materiale nuovo
→ type: Spesa
→ amount: 50
→ unit: euro
→ project_id: null
→ entity_id: null
→ salvataggio consentito

Esempi Project / Entity Create Suggestion:

villa sierri 15 sopralluogo referente kappa
→ project creato inline: Villa Sierri 15
→ entity creata inline: Referente Kappa
→ evento salvato manualmente
→ project_id valorizzato
→ entity_id valorizzato
→ status NEW

acquisto 50 euro materiale nuovo
→ suggestion project/entity ignorata
→ type: Spesa
→ amount: 50
→ unit: euro
→ project_id: null
→ entity_id: null
→ status NEW

CAMPI NON UTILIZZATI O NON CONSOLIDATI:

reference_id
source
payment_method
notes
payload

CAMPI ORA UTILIZZATI A LIVELLO BASE:

type
→ utilizzato per Type Classification Base
→ valori attuali: Evento, Tempo, Spesa, Incasso
→ non ancora sufficiente da solo per KPI avanzati

COMPORTAMENTO:

nessuna validazione DB
nessuna constraint forte applicativa
inserimento consentito lato frontend se non bloccato da ambiguità project/entity non risolta
update consentito solo lato applicativo su eventi NEW
DB non impedisce autonomamente update impropri
integrità demandata a Retool

Regole matching lato frontend:

- match univoco → select valorizzata → project_id/entity_id salvabili
- match ambiguo non risolto → conferma bloccata
- match ambiguo risolto manualmente → conferma consentita
- nessun match → project_id/entity_id null → conferma consentita

TABELLA: projects

Funzione:

contenitore progetti.

CAMPI:

id (uuid, PK)

name (text, UNIQUE)

parent_project_id (uuid, non utilizzato)

type (text, non utilizzato)

status (text, non utilizzato)

created_at (timestamp)

UTILIZZO REALE:

✔ usata per matching lato Retool  
✔ caricata da projects_list  
✔ utilizzata da project_state  
✔ alimenta select_project tramite singleMatch  
✔ project_id salvato su events quando selezionato  
✔ priority match minimo gestito lato Retool  
✔ nessuna gerarchia attiva  
✔ popolabile tramite insert_project lato Retool
✔ creazione inline project validata
✔ utilizzata anche da Project Create Suggestion First Controlled Level

NOTE:

name univoco = base matching
parent_project_id presente ma non operativo
relazioni avanzate non implementate

Project / Entity Create Suggestion First Controlled Level:

projects può ora essere popolata da Retool tramite insert_project.

Regole runtime:

- creazione solo previa conferma utente
- controllo duplicati base lato frontend
- nessuna creazione automatica silenziosa
- nessuna gerarchia assegnata automaticamente
- parent_project_id resta null
- type resta null salvo casi esistenti/manuali
- status può essere valorizzato ACTIVE secondo query insert_project
- evento non salvato automaticamente dopo creazione project

Esempi validati:

Villa Sierri 6
Villa Sierri 7
Villa Sierri 15

Match Engine Unification First Controlled Level:

- Villa + Villa 2 → Villa 2 quando input contiene “villa 2”
- Ristrutturazione + Ristrutturazione Bagno → Ristrutturazione Bagno
- Casa + Casa Mare → Casa Mare
- match più specifici segnalati con hint informativo
- nessuna modifica schema projects

TABELLA: entities

Funzione:

contenitore entità.

CAMPI:

id (uuid, PK)

name (text)

type (text, non utilizzato)

parent_entity_id (uuid, non utilizzato)

status (text, non utilizzato)

metadata (jsonb, default {})

created_at (timestamp)

updated_at (timestamp)

UTILIZZO REALE:

✔ caricata in UI  
✔ caricata da entities_list  
✔ utilizzata da entity_state  
✔ alimenta select_entity tramite singleMatch  
✔ entity_id salvato su events quando selezionato  
✔ priority match minimo gestito lato Retool  
✔ nessuna gerarchia attiva  
✔ popolabile tramite insert_entity lato Retool
✔ creazione inline entity validata
✔ utilizzata anche da Entity Create Suggestion First Controlled Level

LIMITI:

nessun vincolo UNIQUE su name
controllo duplicati base demandato al frontend
possibili duplicati
nessuna gerarchia attiva
parent_entity_id non operativo
metadata non usato in modo strutturale

Match Engine Unification First Controlled Level:

- Mario + Mario Rossi → Mario Rossi quando input contiene “mario rossi”
- Mario Rossi + Mario Rossi Alfredo → Mario Rossi Alfredo quando input contiene nome completo
- Mario → Mario con hint entità più specifiche se esistono varianti
- Alfie + Mario Rossi nello stesso input resta ambiguità reale
- nessuna modifica schema entities

Project / Entity Create Suggestion First Controlled Level:

entities può ora essere popolata da Retool tramite insert_entity.

Regole runtime:

- creazione solo previa conferma utente
- controllo duplicati base lato frontend
- nessuna creazione automatica silenziosa
- nessuna gerarchia assegnata automaticamente
- parent_entity_id resta null
- metadata resta {}
- type/status non sono ancora usati in modo strutturale
- evento non salvato automaticamente dopo creazione entity

Esempi validati:

Tecnico Sierri 4
Referente Kappa

Nota:

entity autofill controlled minimal precompila input_new_entity_name,
ma non crea entity e non scrive nel DB senza conferma utente.

TABELLA: system_logs

Funzione:

logging eventi sistema.

STATO:

presente
NON utilizzata
RELAZIONI

events → projects

tramite project_id
NON vincolata formalmente da FK applicativa documentata

events → entities

tramite entity_id
NON vincolata formalmente da FK applicativa documentata

Nota:

integrità demandata al frontend.

COMPORTAMENTO GLOBALE

Flusso create:

input
→ parsing controlled
→ normalization base
→ duration normalization
→ type classification base
→ match state project/entity
→ create_suggestion_state
→ eventuale insert_project / insert_entity previa conferma utente
→ select_project / select_entity
→ preview / suggestion container
→ insert_event manuale
→ status NEW

Flusso edit:

evento NEW
→ load raw_input
→ parsing controlled
→ normalization base
→ duration normalization
→ type classification base
→ match state project/entity
→ create_suggestion_state
→ eventuale insert_project / insert_entity previa conferma utente
→ select_project / select_entity
→ preview / suggestion container
→ update_event manuale se modifica reale
→ status invariato NEW
→ type aggiornato
→ project_id/entity_id aggiornati se modificati
→ updated_at aggiornato

Il database:

non interpreta dati
non valida dati
non corregge dati
non normalizza dati
non decide type
non decide project/entity
non risolve ambiguità project/entity
non crea project/entity automaticamente
non salva suggestion state
non interpreta command intent
non collega automaticamente project/entity creati agli eventi
non mantiene storico revisioni

Il database riceve type già determinato lato frontend.

Il database riceve project_id/entity_id già determinati lato frontend
tramite select_project.value / select_entity.value.

Se project/entity vengono creati inline,
il database riceve prima una nuova riga in projects/entities.
Solo dopo eventuale conferma evento riceve project_id/entity_id dentro events.

NORMALIZATION BASE / DURATION NORMALIZATION / TYPE CLASSIFICATION / MATCH ENGINE / CREATE SUGGESTION E DATABASE

La normalizzazione base, la duration normalization e la type classification base NON hanno modificato lo schema.

Hanno modificato solo la qualità del payload inviato a Supabase.

Normalizzazione / classificazione lato Retool:

amount numeric
unit text normalizzata
event_date preservata/parsata
durate certe ore/minuti convertite in minuti
type valorizzato a livello base
raw_input preservato

Regole principali:

458,78 → 458.78
1.500 → 1500
1.500,50 → 1500.5

Durate certe:

1ora → amount 60, unit minuti
1 ora → amount 60, unit minuti
1,5 ore → amount 90, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
2h30 → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti
18min → amount 18, unit minuti
90 minuti → amount 90, unit minuti

Ambiguità non convertite:

2 giorni → amount null, unit null
1 settimana → amount null, unit null

Numeri semantici:

villa 2 → amount null, unit null

Decisione:

Il formato localizzato italiano NON viene salvato come stringa.

Il DB salva:

1500.5

La visualizzazione futura potrà mostrare:

1.500,50

Questo appartiene al layer preview/output, non allo schema DB.

Type Classification Base:

parsed.unit = minuti → type Tempo
euro + keyword controllate di uscita → type Spesa
euro + keyword controllate di entrata → type Incasso
euro senza direzione chiara → type Evento
segnali economici contrastanti → type Evento
nessuna unit significativa → type Evento

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

Match Engine Unification First Controlled Level:

project_state / entity_state calcolano:
- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

select_project / select_entity sono le fonti finali per:
- events.project_id
- events.entity_id

Il DB non riceve match state,
non riceve matches,
non riceve confidence,
non riceve moreSpecificMatches.

Riceve solo:
- project_id
- entity_id

oppure null.

Project / Entity Create Suggestion First Controlled Level:

create_suggestion_state calcola suggestion lato Retool.

Non viene persistito:

- noMatch
- shouldSuggestCreate
- candidateName
- draftName
- dismissed state
- create_suggestion_state.data

Il DB riceve solo:

- nuova riga in projects, se l’utente conferma insert_project
- nuova riga in entities, se l’utente conferma insert_entity
- project_id/entity_id in events, solo se l’utente conferma l’evento

Nessuna modifica schema è stata introdotta.

------------------------------------------------
DURATION NORMALIZATION E DATABASE
------------------------------------------------

Decisione:

La durata certa viene salvata usando i campi esistenti:

amount = totale minuti
unit = minuti

Non sono stati aggiunti campi dedicati.

NON esistono attualmente:

- duration_minutes
- duration_unit
- duration_payload
- duration_type
- duration_confidence

payload resta vuoto.

Esempio:

Input:

2h30 rendering

Frontend:

ui_state.parsed.amount = 150
ui_state.parsed.unit = minuti

DB:

amount = 150
unit = minuti
raw_input = 2h30 rendering

Preview:

2 ore 30 minuti
Normalizzato: 150 minuti

Nota:

Il DB conserva il dato strutturato minimo.
La forma originale resta in raw_input.
La visualizzazione leggibile resta compito della preview/output.

Giorni e settimane:

2 giorni rendering
→ amount null
→ unit null
→ raw_input preservato

Motivo:

2 giorni può significare:

- 48 ore
- due giornate lavorative
- due giornate operative
- due giorni calendario

La conversione automatica non viene eseguita senza nodo dedicato.

------------------------------------------------
TYPE CLASSIFICATION BASE E DATABASE
------------------------------------------------

Decisione:

Il type viene salvato usando il campo esistente:

events.type

Non sono stati aggiunti campi dedicati.

Valori attuali:

- Evento
- Tempo
- Spesa
- Incasso

Origine runtime:

select1.value lato Retool

Catena:

select1.value
→ payload.type
→ insert_event / update_event
→ events.type

Nota terminologica:

select1 è un componente UI Select di Retool,
non una query.

------------------------------------------------
MATCH ENGINE UNIFICATION E DATABASE
------------------------------------------------

Decisione:

Il Match Engine Unification First Controlled Level NON modifica lo schema DB.

Sono rimasti invariati:

- events.project_id
- events.entity_id
- projects
- entities
- payload

Non sono stati aggiunti:

- match_confidence
- match_source
- match_payload
- project_match_status
- entity_match_status
- pending_project_name
- pending_entity_name
- alias table
- relation table
- hierarchy table

Origine runtime:

project_state / entity_state lato Retool

Catena project:

project_state
→ select_project.value
→ payload.project_id
→ insert_event / update_event
→ events.project_id

Catena entity:

entity_state
→ select_entity.value
→ payload.entity_id
→ insert_event / update_event
→ events.entity_id

Regole:

- match univoco → select valorizzata
- match ambiguo non risolto → confirm bloccato
- match ambiguo risolto manualmente → confirm consentito
- nessun match → project_id/entity_id null
- project/entity non vengono creati automaticamente

Esempi:

villa 2 mario
→ events.project_id = Villa 2
→ events.entity_id = Mario

18 min ristrutturazione bagno
→ events.project_id = Ristrutturazione Bagno
→ events.type = Tempo
→ events.amount = 18
→ events.unit = minuti

mario
→ events.entity_id = Mario
→ hint più specifici gestito solo in UI
→ DB salva solo entity_id

alfie mario rossi
→ ambiguità entity
→ nessun insert/update finché non viene scelta entità

------------------------------------------------
PROJECT / ENTITY CREATE SUGGESTION E DATABASE
------------------------------------------------

Decisione:

Project / Entity Create Suggestion First Controlled Level NON modifica lo schema DB.

Sono rimasti invariati:

- events
- projects
- entities
- payload
- system_logs

Non sono stati aggiunti:

- pending_project_name
- pending_entity_name
- project_suggestion_status
- entity_suggestion_status
- suggestion_payload
- command_intent_type
- command_intent_payload
- audit trail dedicato
- relation table
- alias table

Origine runtime:

create_suggestion_state lato Retool

Catena project:

create_suggestion_state
→ input_new_project_name
→ insert_project
→ projects
→ projects_list refresh
→ select_project.value
→ payload.project_id
→ insert_event / update_event
→ events.project_id

Catena entity:

create_suggestion_state
→ input_new_entity_name
→ insert_entity
→ entities
→ entities_list refresh
→ select_entity.value
→ payload.entity_id
→ insert_event / update_event
→ events.entity_id

Regole:

- suggestion non viene persistita
- dismissed state non viene persistito
- project/entity creati inline sono record reali
- evento non viene salvato automaticamente dopo creazione project/entity
- insert_event/update_event restano azioni separate
- project/entity mancanti non bloccano il salvataggio
- project/entity ambigui bloccano il salvataggio lato frontend
- nessuna creazione automatica lato DB

Esempio validato:

Input:
villa sierri 15 sopralluogo referente kappa

Step DB:

1. insert_project
→ projects.name = Villa Sierri 15

2. insert_entity
→ entities.name = Referente Kappa

3. insert_event manuale
→ events.project_id = Villa Sierri 15
→ events.entity_id = Referente Kappa
→ events.raw_input = villa sierri 15 sopralluogo referente kappa
→ events.status = NEW

------------------------------------------------
INSERT
------------------------------------------------

insert_event ora invia:

type: type

Esempi validati:

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
→ project_id Villa 2
→ entity_id Mario

18 min ristrutturazione bagno
→ type Tempo
→ amount 18
→ unit minuti
→ project_id Ristrutturazione Bagno

Project / Entity Create Suggestion — insert_event validato:

villa sierri 15 sopralluogo referente kappa
→ project_id = Villa Sierri 15
→ entity_id = Referente Kappa
→ type Evento
→ amount null
→ unit null
→ status NEW

acquisto 50 euro materiale nuovo
→ project_id null
→ entity_id null
→ type Spesa
→ amount 50
→ unit euro
→ status NEW

------------------------------------------------
UPDATE
------------------------------------------------

update_event ora aggiorna anche:

type

Esempio validato:

Evento precedente senza type valorizzato,
modificato in:

1 ora e 45 minuti lavoro

DB dopo update:

type Tempo
amount 105
unit minuti
raw_input aggiornato
updated_at aggiornato
status NEW

Validazione Match Engine:

Evento modificato in:

villa 2 mario

DB dopo update:

type Evento
amount null
unit null
project_id Villa 2
entity_id Mario
raw_input aggiornato
updated_at aggiornato
status NEW

Evento modificato in:

18 min ristrutturazione bagno

DB dopo update:

type Tempo
amount 18
unit minuti
project_id Ristrutturazione Bagno
raw_input aggiornato
updated_at aggiornato
status NEW

------------------------------------------------
CONTROLLO UTENTE
------------------------------------------------

La classificazione automatica è prudente.

L’utente può modificare manualmente select1.

La scelta manuale viene salvata in events.type.

Esempi validati:

20 euro materiale
→ default Evento
→ utente seleziona Spesa
→ DB type Spesa

20 euro materiale
→ default Evento
→ utente seleziona Incasso
→ DB type Incasso

------------------------------------------------
CONTROLLO UTENTE SU PROJECT / ENTITY CREATE
------------------------------------------------

La creazione project/entity inline è controllata dall’utente.

Regole:

- Retool può proporre una creation suggestion
- l’utente deve confermare Crea progetto / Crea entità
- insert_project / insert_entity partono solo dopo azione esplicita
- il DB non crea risorse automaticamente
- dopo creazione project/entity, l’evento resta non salvato
- l’utente deve confermare manualmente l’evento
- l’utente può ignorare suggestion e salvare evento incompleto
- l’utente deve risolvere ambiguità project/entity prima del salvataggio

Questo mantiene separati:

- creazione risorsa
- salvataggio evento

------------------------------------------------
LIMITI
------------------------------------------------

Non implementato:

- classificazione economica avanzata
- dizionario esteso keyword
- classificazione automatica da parole di dominio
- benzina/materiale/mangime → Spesa automatica
- amount firmato
- direction field
- KPI/reportistica
- retro-normalizzazione eventi storici
- - match engine avanzato separato
- alias system
- fuzzy matching
- ranking avanzato
- command intent create project/entity
- pending state avanzato project/entity
- audit trail dedicato creazione project/entity

Nota:

events.type è ora valorizzato a livello base,
ma non abilita automaticamente output/KPI.

DATI PARZIALMENTE NORMALIZZATI
amount/unit base ora normalizzati lato frontend
duration normalization base implementata lato frontend
durate certe ore/minuti salvate in minuti
type classification base implementata lato frontend
events.type valorizzato per nuovi insert/update
giorni/settimane non convertiti automaticamente
type non sufficiente da solo per KPI avanzati
dati storici non retro-normalizzati
Match Engine Unification First Controlled Level implementato lato frontend
project_id/entity_id più coerenti quando selezionati
ambiguità project/entity non risolta bloccata lato frontend
nessun match project/entity non blocca il salvataggio
Project / Entity Create Suggestion First Controlled Level implementato lato frontend
projects/entities popolabili tramite insert inline controllato
evento salvabile con project_id/entity_id appena creati
suggestion ignorata consente project_id/entity_id null

RELAZIONI DEBOLI
project/entity opzionali
nessun vincolo integrità forte documentato
integrità demandata al frontend
match state non persistito
singleMatch non persistito
moreSpecificMatches non persistito

ENTITY NON STRUTTURATE
nessuna gerarchia
ambiguità possibile
duplicati possibili
priority match minimo implementato lato Retool
hint più specifici implementato lato Retool
nessuna deduplicazione strutturale
creazione entity inline implementata a primo livello controllato
deduplicazione base solo lato frontend

PROJECT / ENTITY CREATE SUGGESTION

Implementata a primo livello lato Retool.

Limiti:

- nessun audit trail dedicato
- nessun pending state persistito
- nessun command intent
- nessuna deduplicazione DB avanzata
- nessun alias system
- nessuna relazione project/entity
- nessuna gerarchia automatica
- nessun vincolo DB nuovo

TYPE UTILIZZATO A LIVELLO BASE

events.type è ora utilizzato per Type Classification Base.

Valori attuali:

- Evento
- Tempo
- Spesa
- Incasso

Caratteristiche:

- deciso lato Retool
- derivato da select1.value
- salvato in insert_event
- aggiornato in update_event
- correggibile manualmente dall’utente

Limiti:

- non è calcolato dal DB
- non è vincolato da constraint DB
- non è retro-normalizzato sugli eventi storici
- non è ancora sufficiente da solo per KPI avanzati
- non gestisce amount firmato
- non gestisce direction field
- non contiene logica contabile avanzata

PAYLOAD INUTILIZZATO
sempre vuoto
nessuna struttura definita

Nota:

Duration Normalization NON usa payload.

Non è stato introdotto:

payload.duration
payload.duration_minutes
payload.duration_original_unit

Questa scelta mantiene il modello dati semplice
e coerente con amount/unit esistenti.

ASSENZA VERSIONING
modifiche non tracciate storicamente
perdita stato precedente evento
update_event sovrascrive evento NEW

DATI STORICI
eventi inseriti prima del Normalization Layer Base possono avere qualità inferiore
eventi inseriti prima della Duration Normalization possono avere durate in forma precedente
eventi inseriti prima della Type Classification Base possono avere type null o non valorizzato
nessuna retro-normalizzazione automatica implementata
eventuale bonifica futura richiede nodo dedicato

VINCOLI OPERATIVI
NON modificare schema attuale senza nodo dedicato
NON introdurre vincoli rigidi prematuri
mantenere flessibilità
evitare update su eventi WRITTEN / ERROR
non introdurre trigger DB per logica applicativa
non spostare duration normalization in Supabase
non aggiungere campo duration_minutes senza nodo schema dedicato
non usare payload.duration senza decisione architetturale dedicata
non usare type per KPI finché matching/data quality/report readiness non saranno stabilizzati
non introdurre amount firmato senza nodo dedicato
non introdurre direction field senza nodo dedicato
non aggiungere constraint DB su type senza nodo schema dedicato
non aggiungere alias table senza nodo dedicato
non aggiungere project/entity relation table senza nodo dedicato
non aggiungere pending project/entity fields senza nodo dedicato
non aggiungere suggestion_payload senza nodo dedicato
non aggiungere command_intent fields senza nodo dedicato
non spostare matching logic in Supabase
non spostare create_suggestion_state in Supabase
non creare project/entity automaticamente lato DB
non aggiungere audit trail project/entity senza nodo dedicato

Motivazione:

sistema ancora in fase evolutiva.

La qualità viene migliorata progressivamente lato runtime,
non imposta dal database.

EVOLUZIONE FUTURA NON ATTIVA

Possibili estensioni:

TYPE:

classificazione economica avanzata
dizionario esteso keyword
amount firmato
direction field
eventuale vincolo valori type
eventuale bonifica type storico

ENTITY:

gerarchie
relazioni
entity-project link
alias project/entity
deduplicazione
command intent create project/entity
pending project/entity workflow avanzato
audit trail creazione project/entity

DATA QUALITY:

flag qualità evento
review status
confidence
source quality

ENGINE SUPPORT:

tabelle derivate
normalizzazione avanzata
duration advanced per giorni/settimane
type classification avanzata
economic direction advanced
deduplicazione
eventuale campo duration_minutes solo con nodo schema dedicato
eventuale payload.duration solo con nodo architetturale dedicato
match engine avanzato
fuzzy matching controllato
ranking avanzato
command intent
suggestion model persistente solo se validato da nodo dedicato

VERSIONING:

event_revisions
audit trail modifiche
storico raw_input / amount / unit
rollback eventi NEW

OUTPUT:

viste aggregate
dashboard
KPI
reportistica
OBIETTIVO DATABASE

Fornire base dati:

stabile
persistente
flessibile
semplice
compatibile con evoluzione incrementale

NON essere:

intelligente
autonoma
decisionale
vincolante in modo prematuro

Principio:

coerenza applicativa garantita dal frontend.

Rischio:

incoerenze possibili se il frontend invia dati errati.

Mitigazione attuale:

ui_state.parsed come fonte per amount/unit/event_date
select1.value come fonte per type
project_state/entity_state come fonte minima matching
select_project.value come fonte per project_id
select_entity.value come fonte per entity_id
insert_project / insert_entity controllati lato Retool
create_suggestion_state non persistito
separazione tra creazione risorsa e salvataggio evento
confirm guard su ambiguità non risolta
normalization base lato Retool
duration normalization lato Retool
type classification base lato Retool
insert/update validati su casi reali
raw_input preservato per debug/correzione futura

CHANGELOG

v01 — 2026-04-01

definizione schema base

v02 — 2026-04-03

allineamento utilizzo reale
distinzione campi attivi/non attivi
integrazione comportamento runtime

v03 — 2026-04-23

introduzione updated_at
introduzione update_event
aggiornamento modello append-only controllato
supporto editing eventi NEW

v04 — 2026-04-30

nessuna modifica schema DB
integrazione Normalization Layer Base lato frontend
chiarito amount numeric e unit text
documentata normalizzazione amount/unit prima di insert/update
documentato che raw_input resta preservato
chiarito che Supabase resta database passivo
esplicitato che i dati storici non sono retro-normalizzati
esplicitati limiti: no versioning, no type affidabile, no duration normalization

v05 — 2026-04-30

nessuna modifica schema DB
integrazione Duration Normalization Base lato frontend
chiarito che le durate certe ore/minuti vengono salvate come minuti
definita rappresentazione DB: amount = totale minuti, unit = minuti
documentato che raw_input preserva la forma originaria
documentato che giorni/settimane non vengono convertiti automaticamente
documentato che payload resta inutilizzato
documentato che non è stato introdotto duration_minutes
documentato che Supabase resta passivo
validati insert/update con durate normalizzate
esplicitati limiti: dati storici non retro-normalizzati, type non affidabile, giorni/settimane non normalizzati

v06 — 2026-05-01

nessuna modifica schema DB
integrazione Type Classification Base lato frontend
chiarito utilizzo reale di events.type
definiti valori attuali type: Evento, Tempo, Spesa, Incasso
documentato che type deriva da select1.value
chiarito che select1 è componente UI Retool, non query
documentata catena select1.value → payload.type → events.type
documentato insert_event con type
documentato update_event con type
documentato che DB non decide type
documentato che Supabase resta passivo
documentato amount ancora positivo per Spesa/Incasso
documentato che non esiste direction field
documentato che non esiste amount firmato
validati insert/update con type persistito
documentato override manuale utente su Spesa/Incasso
esplicitati limiti: no KPI automatici, no retro-normalizzazione storico, no classificazione economica avanzata
aggiornamento prossimo nodo consigliato: MATCH ENGINE UNIFICATION

v07 — 2026-05-02

nessuna modifica schema DB
integrazione Match Engine Unification First Controlled Level lato frontend
chiarito utilizzo più coerente di events.project_id / events.entity_id
documentato che project_id deriva da select_project.value
documentato che entity_id deriva da select_entity.value
documentato che select_project/select_entity sono alimentati da project_state/entity_state
documentato che DB non decide project/entity
documentato che DB non risolve ambiguità
documentato che DB non crea project/entity automaticamente
documentato che match state non viene persistito
documentato che matches/count/isAmbiguous/singleMatch/moreSpecificMatches restano runtime frontend
documentato confirm guard su ambiguità non risolta lato Retool
documentato che nessun match project/entity salva null e non blocca
documentato che ambiguità risolta manualmente consente salvataggio
documentati esempi villa 2 mario, ristrutturazione bagno, mario, alfie mario rossi
confermato schema invariato dopo Match Engine Unification
confermato payload inutilizzato
confermati limiti: no alias, no fuzzy, no ranking avanzato, no creazione guidata project/entity
nessun output/KPI anticipato

v08 — 2026-05-07

nessuna modifica schema DB
integrazione Project / Entity Create Suggestion First Controlled Level lato frontend
documentato insert_project
documentato insert_entity
documentato popolamento projects/entities da UI controllata
documentato che create_suggestion_state non viene persistito
documentato che suggestion / candidate / dismissed state non vengono salvati nel DB
documentato che evento non viene salvato automaticamente dopo creazione project/entity
documentata separazione tra creazione risorsa e salvataggio evento
documentato project_id/entity_id derivati da select dopo creazione inline
documentati esempi Villa Sierri 15 e Referente Kappa
documentato no-match generico salvabile con project_id/entity_id null
confermato schema invariato
confermato payload inutilizzato
confermato DB passivo
confermato nessun command intent implementato
confermato nessun audit trail dedicato project/entity
confermato nessuna deduplicazione avanzata DB
nessun output/KPI anticipato