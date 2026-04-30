# 05_LOGOS_Database_Schema_v04

DATA: 2026-04-30

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- tutte le tabelle documentate  
- campi reali allineati  
- comportamento runtime incluso  
- update flow documentato  
- normalization base lato frontend integrata  

Q (Qualità): 9/10  
- struttura corretta  
- schema invariato esplicitato  
- append-only controllato documentato  
- distinzione chiara tra DB passivo e normalizzazione frontend  
- limiti versioning / type / relazioni esplicitati  

D (Deployabilità): 10/10  
- documento utilizzabile come riferimento AS-IS  
- coerente con Supabase runtime  
- non introduce modifiche schema non implementate  

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
- classificazione tipo evento

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

type (text, NON utilizzato attivamente)

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
✔ event_date valorizzata quando parsata  
✔ project_id opzionale  
✔ entity_id opzionale  
✔ status sempre NEW in insert  
✔ updated_at valorizzato in insert/update  
✔ eventi NEW modificabili tramite update_event  
✔ nessuna modifica applicativa su WRITTEN / ERROR  

---

NORMALIZATION BASE — IMPATTO SU events:

La tabella non è stata modificata.

La qualità del dato è migliorata perché il frontend ora invia:

- amount numerico normalizzato
- unit coerente
- numeri senza unità non convertiti in amount
- raw_input preservato

Esempi:

```text
1.500,50 euro
→ amount: 1500.5
→ unit: euro

1ora lavoro
→ amount: 1
→ unit: ore

villa 2 mario
→ amount: null
→ unit: null

CAMPI NON UTILIZZATI O NON CONSOLIDATI:

type
reference_id
source
payment_method
notes
payload

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
→ matching
→ preview
→ insert_event
→ status NEW

Flusso edit:

evento NEW
→ load raw_input
→ parsing controlled
→ normalization base
→ matching
→ preview
→ update_event
→ status invariato NEW
→ updated_at aggiornato

Il database:

non interpreta dati
non valida dati
non corregge dati
non normalizza dati
non decide type
non decide project/entity
non mantiene storico revisioni
NORMALIZATION BASE E DATABASE

La normalizzazione base NON ha modificato lo schema.

Ha modificato solo la qualità del payload inviato a Supabase.

Normalizzazione lato Retool:

amount numeric
unit text normalizzata
event_date preservata/parsata
raw_input preservato

Regole principali:

458,78 → 458.78
1.500 → 1500
1.500,50 → 1500.5
1ora → amount 1, unit ore
18min → amount 18, unit minuti
villa 2 → amount null, unit null

Decisione:

Il formato localizzato italiano NON viene salvato come stringa.

Il DB salva:

1500.5

La visualizzazione futura potrà mostrare:

1.500,50

Questo appartiene al layer preview/output, non allo schema DB.

PROBLEMI NOTI
DATI PARZIALMENTE NORMALIZZATI
amount/unit base ora normalizzati lato frontend
duration normalization non implementata
type non affidabile
dati storici non retro-normalizzati
RELAZIONI DEBOLI
project/entity opzionali
nessun vincolo integrità forte documentato
integrità demandata al frontend
ENTITY NON STRUTTURATE
nessuna gerarchia
ambiguità possibile
duplicati possibili
TYPE NON UTILIZZATO
non distingue spesa/incasso
non affidabile per output/KPI
non gestito da engine
PAYLOAD INUTILIZZATO
sempre vuoto
nessuna struttura definita
ASSENZA VERSIONING
modifiche non tracciate storicamente
perdita stato precedente evento
update_event sovrascrive evento NEW
DATI STORICI
eventi inseriti prima del Normalization Layer Base possono avere qualità inferiore
nessuna retro-normalizzazione automatica implementata
eventuale bonifica futura richiede nodo dedicato
VINCOLI OPERATIVI
NON modificare schema attuale senza nodo dedicato
NON introdurre vincoli rigidi prematuri
mantenere flessibilità
evitare update su eventi WRITTEN / ERROR
non introdurre trigger DB per logica applicativa
non spostare parsing/normalizzazione in Supabase
non usare type per KPI finché non è affidabile

Motivazione:

sistema ancora in fase evolutiva.

La qualità viene migliorata progressivamente lato runtime,
non imposta dal database.

EVOLUZIONE FUTURA NON ATTIVA

Possibili estensioni:

TYPE:

spesa
incasso
tempo
evento
classificazione controllata

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
duration normalization
type classification
deduplicazione

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

ui_state.parsed come fonte unica
normalization base lato Retool
insert/update validati su casi reali
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