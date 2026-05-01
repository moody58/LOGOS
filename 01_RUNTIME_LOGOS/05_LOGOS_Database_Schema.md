# 05_LOGOS_Database_Schema_v06

DATA: 2026-05-01

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
- utilizzo reale di events.type documentato   

Q (Qualità): 9.5/10  
- struttura corretta  
- schema invariato esplicitato  
- append-only controllato documentato  
- distinzione chiara tra DB passivo e logica frontend  
- chiarito che le durate certe vengono salvate in minuti canonici  
- chiarito che type viene deciso lato Retool e salvato nel DB  
- chiarito che il DB non decide type  
- limiti versioning / relazioni / output esplicitati  

D (Deployabilità): 10/10  
- documento utilizzabile come riferimento AS-IS  
- coerente con Supabase runtime  
- non introduce modifiche schema non implementate  
- conferma schema invariato dopo Duration Normalization  
- conferma schema invariato dopo Type Classification Base   

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
✔ entity_id opzionale  
✔ status sempre NEW in insert  
✔ updated_at valorizzato in insert/update  
✔ eventi NEW modificabili tramite update_event  
✔ nessuna modifica applicativa su WRITTEN / ERROR  

---

NORMALIZATION BASE + DURATION NORMALIZATION + TYPE CLASSIFICATION BASE — IMPATTO SU events:

La tabella non è stata modificata.

La qualità del dato è migliorata perché il frontend ora invia:

- amount numerico normalizzato
- unit coerente
- numeri senza unità non convertiti in amount
- durate certe ore/minuti convertite in minuti
- type base valorizzato
- raw_input preservato

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
inserimento consentito lato frontend se non bloccato da ambiguità matching
update consentito solo lato applicativo su eventi NEW
DB non impedisce autonomamente update impropri
integrità demandata a Retool
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

✔ usata per matching
✔ popolamento select_project
✔ project_id salvato su events quando selezionato
✔ nessuna gerarchia attiva

NOTE:

name univoco = base matching
parent_project_id presente ma non operativo
relazioni avanzate non implementate
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
✔ utilizzata per matching
✔ entity_id salvato su events quando selezionato
✔ nessuna gerarchia attiva

LIMITI:

nessun vincolo UNIQUE su name
possibili duplicati
nessuna gerarchia attiva
parent_entity_id non operativo
metadata non usato in modo strutturale
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
→ matching
→ preview
→ insert_event
→ status NEW

Flusso edit:

evento NEW
→ load raw_input
→ parsing controlled
→ normalization base
→ duration normalization
→ type classification base
→ matching
→ preview
→ update_event
→ status invariato NEW
→ type aggiornato
→ updated_at aggiornato

Il database:

non interpreta dati
non valida dati
non corregge dati
non normalizza dati
non decide type
non decide project/entity
non mantiene storico revisioni

Il database riceve type già determinato lato frontend.

NORMALIZATION BASE / DURATION NORMALIZATION / TYPE CLASSIFICATION E DATABASE

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

RELAZIONI DEBOLI
project/entity opzionali
nessun vincolo integrità forte documentato
integrità demandata al frontend

ENTITY NON STRUTTURATE
nessuna gerarchia
ambiguità possibile
duplicati possibili

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