05_LOGOS_Database_Schema_v02

DATA: 2026-04-03

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- tutte le tabelle documentate  
- campi reali allineati  
- comportamento runtime incluso  

Q (Qualità): 9.5/10  
- distinzione chiara tra struttura e uso reale  
- limiti esplicitati  
- nessuna ambiguità semantica  

D (Deployabilità): 10/10  
- documento utilizzabile come riferimento AS-IS  
- coerente con Supabase runtime  

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire la struttura dati reale del sistema LOGOS
basata su Supabase (PostgreSQL).

Il documento descrive:

- tabelle
- campi
- comportamento reale
- limiti attuali

------------------------------------------------
PRINCIPIO ARCHITETTURALE
------------------------------------------------

Il database è PASSIVO.

NON contiene:

- logica di business
- validazione applicativa
- trasformazioni dati

---

Il database:

- memorizza eventi
- garantisce persistenza
- mantiene storico

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

contenitore eventi

---

Caratteristiche:

- append-only
- ogni riga = evento
- nessuna modifica distruttiva

---

CAMPI:

id (uuid, PK)

created_at (timestamp)

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
✔ amount valorizzato da parsing  
✔ unit sempre valorizzata correttamente (euro / tempo)  
✔ project_id talvolta valorizzato  
✔ entity_id raramente valorizzato  
✔ status sempre NEW in insert  
✔ amount coerente anche in presenza di multi-numero

---

CAMPI NON UTILIZZATI:

- type
- reference_id
- source
- payment_method

---

COMPORTAMENTO:

- nessuna validazione DB
- nessuna constraint forte
- inserimento sempre consentito

------------------------------------------------
TABELLA: projects
------------------------------------------------

Funzione:

contenitore progetti

---

CAMPI:

id (uuid, PK)

name (text, UNIQUE)

parent_project_id (uuid, non utilizzato)

type (text, non utilizzato)

status (text, non utilizzato)

created_at (timestamp)

---

UTILIZZO REALE:

✔ usata per matching  
✔ popolamento select_project  
✔ nessuna gerarchia attiva  

---

NOTE:

- name univoco = base matching

------------------------------------------------
TABELLA: entities
------------------------------------------------

Funzione:

contenitore entità

---

CAMPI:

id (uuid, PK)

name (text)

type (text, non utilizzato)

parent_entity_id (uuid, non utilizzato)

status (text, non utilizzato)

metadata (jsonb, default {})

created_at (timestamp)

updated_at (timestamp)

---

UTILIZZO REALE:

✔ caricata in UI  
✔ utilizzata per matching  
✔ entity_id raramente valorizzato  

---

LIMITI:

- nessun vincolo UNIQUE su name  
- possibili duplicati  
- nessuna gerarchia attiva  

------------------------------------------------
TABELLA: system_logs
------------------------------------------------

Funzione:

logging eventi sistema

---

STATO:

- presente
- NON utilizzata

------------------------------------------------
RELAZIONI
------------------------------------------------

events → projects

- tramite project_id
- NON vincolata (no FK)

---

events → entities

- tramite entity_id
- NON vincolata (no FK)

---

Nota:

integrità demandata al frontend

------------------------------------------------
COMPORTAMENTO GLOBALE
------------------------------------------------

Flusso:

input  
→ parsing (client-side)  
→ matching (client-side)  
→ insert  
→ status NEW  

---

Il database:

- non interpreta dati
- non valida dati
- non corregge dati

------------------------------------------------
PROBLEMI NOTI
------------------------------------------------

1. DATI NON NORMALIZZATI

- unit coerenti ma non standardizzate globalmente
- label non uniformi

---

2. RELAZIONI DEBOLI

- project/entity opzionali
- nessun vincolo integrità

---

3. ENTITY NON STRUTTURATE

- nessuna gerarchia
- ambiguità possibile

---

4. TYPE NON UTILIZZATO

- non distingue spesa/incasso

---

5. PAYLOAD INUTILIZZATO

- sempre vuoto
- nessuna struttura definita

------------------------------------------------
VINCOLI OPERATIVI
------------------------------------------------

- NON modificare schema attuale
- NON introdurre vincoli rigidi
- mantenere flessibilità

---

Motivazione:

sistema ancora in fase evolutiva

------------------------------------------------
EVOLUZIONE FUTURA (NON ATTIVA)
------------------------------------------------

Possibili estensioni:

TYPE:

- spesa / incasso

---

ENTITY:

- gerarchie
- relazioni

---

DATA QUALITY:

- flag qualità evento

---

ENGINE SUPPORT:

- tabelle derivate
- normalizzazione

------------------------------------------------
OBIETTIVO DATABASE
------------------------------------------------

Fornire base dati:

- stabile
- persistente
- flessibile

---

NON:

- intelligente
- autonoma

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01  
- definizione schema base  

v02 — 2026-04-03  
- allineamento utilizzo reale  
- distinzione campi attivi/non attivi  
- integrazione comportamento runtime  