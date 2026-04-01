# 05_LOGOS_Database_Schema_v01

DATA: 2026-04-01

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire la struttura dati del sistema LOGOS
basata su Supabase (PostgreSQL).

Il documento descrive:

- tabelle principali
- campi
- significato dati
- relazioni
- vincoli operativi

------------------------------------------------
PRINCIPIO ARCHITETTURALE
------------------------------------------------

Il database è PASSIVO.

NON contiene:

- logica di business
- validazione semantica
- trasformazioni dati

---

Il database:

- memorizza eventi
- garantisce persistenza
- mantiene storico

------------------------------------------------
MODELLO DATI
------------------------------------------------

Struttura principale:

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

contenitore principale degli eventi

---

Caratteristiche:

- append-only
- ogni riga = evento
- nessuna modifica distruttiva

---

CAMPI:

id

- tipo: uuid
- chiave primaria

---

created_at

- timestamp
- creazione evento

---

event_date

- timestamp
- data evento (se diversa da creazione)

---

project_id

- riferimento projects.id
- opzionale

---

entity_id

- riferimento entities.id
- opzionale

---

type

- tipo evento
- valori:

  - evento
  - tempo
  - economico

---

amount

- numero
- valore associato (tempo o costo)

---

unit

- unità di misura
- valori previsti:

  - minuti
  - ore
  - euro

---

reference_id

- campo opzionale
- uso non strutturato

---

source

- origine evento
- es:

  - manuale
  - api
  - import

---

payment_method

- metodo pagamento
- opzionale

---

notes

- testo libero
- descrizione evento

---

raw_input

- testo originale utente
- fonte primaria

---

payload

- JSON
- output parsing

---

status

- stato evento
- valori:

  - NEW
  - WRITTEN
  - ERROR

------------------------------------------------
TABELLA: projects
------------------------------------------------

Funzione:

contenitore progetti

---

CAMPI:

id

- uuid
- chiave primaria

---

name

- nome progetto
- testo

---

Caratteristiche:

- lista semplice
- nessuna gerarchia attuale

------------------------------------------------
TABELLA: entities
------------------------------------------------

Funzione:

contenitore entità (clienti, soggetti)

---

CAMPI:

id

- uuid
- chiave primaria

---

name

- nome entità
- testo

---

Caratteristiche:

- lista semplice
- nessuna relazione strutturata

------------------------------------------------
RELAZIONI
------------------------------------------------

events → projects

- relazione opzionale
- via project_id

---

events → entities

- relazione opzionale
- via entity_id

---

Nota:

nessuna relazione forzata

------------------------------------------------
STATO ATTUALE MODELLO
------------------------------------------------

✔ semplice  
✔ flessibile  
✔ coerente con append-only  

---

⚠ limitato:

- nessuna struttura gerarchica
- nessuna normalizzazione forte
- nessun vincolo dati

------------------------------------------------
PROBLEMI NOTI
------------------------------------------------

1. DATI NON NORMALIZZATI

- unità non coerenti
- valori eterogenei

---

2. RELAZIONI DEBOLI

- project/entity opzionali
- nessun vincolo integrità

---

3. AMBIGUITÀ TIPO

- economico non distingue spesa/incasso

---

4. USO PAYLOAD NON STRUTTURATO

- parsing non standardizzato

------------------------------------------------
VINCOLI OPERATIVI
------------------------------------------------

- NON modificare schema attuale
- NON introdurre vincoli rigidi
- mantenere flessibilità

---

Motivazione:

il sistema è ancora in fase di costruzione

------------------------------------------------
EVOLUZIONE FUTURA (NON ATTIVA)
------------------------------------------------

Possibili estensioni:

---

TYPE:

- separazione spesa / incasso

---

UNIT:

- normalizzazione automatica

---

RELATIONS:

- entity-project mapping

---

DATA QUALITY:

- flag qualità evento

---

ENGINE SUPPORT:

- tabelle derivate

------------------------------------------------
OBIETTIVO DATABASE
------------------------------------------------

Fornire base dati:

- stabile
- persistente
- estensibile

---

NON:

- intelligente
- autonomo

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01

- Definizione completa schema database LOGOS
- Allineamento con struttura Supabase reale
- Formalizzazione tabelle e campi
- Identificazione limiti e vincoli