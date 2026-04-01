# 00_PROJECT_System_v01

DATA: 2026-04-01

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

Event Ledger (append-only, user-driven)

------------------------------------------------
OBIETTIVO SISTEMA
------------------------------------------------

Trasformare input libero in:

- dati strutturati
- dati confrontabili
- dati analizzabili

Output atteso (non ancora implementato):

- KPI
- analisi costi
- analisi tempi
- dashboard operative

------------------------------------------------
STACK TECNOLOGICO
------------------------------------------------

Frontend:

- Retool
- UI single page
- gestione stato lato client

Backend:

- Supabase
- database PostgreSQL

Logica:

- JavaScript lato client
- parsing e matching in UI

Server:

- passivo
- nessuna business logic

------------------------------------------------
PRINCIPI ARCHITETTURALI
------------------------------------------------

1. DATABASE PASSIVO

Il database:

- non contiene logica
- non valida dati
- non interpreta eventi

---

2. UI RESPONSABILE

La UI:

- gestisce input
- interpreta dati
- costruisce preview
- guida decisione utente

---

3. RAW INPUT COME VERITÀ

raw_input:

- è sempre salvato
- è fonte primaria
- non viene alterato

---

4. APPEND-ONLY

Eventi:

- non vengono modificati
- evolvono tramite stato
- mantengono storico

---

5. SEPARAZIONE LAYER

Separazione tra:

- input
- parsing
- preview
- insert
- processing

------------------------------------------------
ARCHITETTURA FUNZIONALE
------------------------------------------------

LIVELLI:

1. INPUT LAYER
2. PARSING LAYER
3. MATCH LAYER
4. UI STATE LAYER
5. PROCESSING LAYER

------------------------------------------------
1 — INPUT LAYER
------------------------------------------------

Componenti:

- input_home (input utente)
- input_raw (adapter tecnico)

Caratteristiche:

- input libero
- nessun vincolo
- sincronizzazione unidirezionale

Flow:

input_home → input_raw

Principio:

input_home = source of truth

------------------------------------------------
2 — PARSING LAYER
------------------------------------------------

Funzione:

Interpretazione base input

Operazioni:

- estrazione numeri
- riconoscimento unità (parziale)
- pulizia testo
- separazione label

Caratteristiche:

- best-effort
- non bloccante
- non deterministico

Limiti:

- unità non complete
- multi-unit non gestite
- parsing semantico assente

------------------------------------------------
3 — MATCH LAYER
------------------------------------------------

Funzione:

Associazione input a dati esistenti

Entità coinvolte:

- projects
- entities

Strategia:

- match testuale (includes)
- normalizzazione base

Output:

- suggerimenti soft
- auto-select solo se univoco

Limiti:

- matching debole
- ambiguità frequente
- nessuna logica avanzata

------------------------------------------------
4 — UI STATE LAYER
------------------------------------------------

Gestione stato:

ui_state:

{
  view: "home" | "feedback"
}

Container:

- container_home
- container_input
- container_feedback
- container_events_list

Principio:

UI = funzione dello stato

Caratteristiche:

- nessun routing
- show/hide dinamico
- stato minimale

------------------------------------------------
5 — PROCESSING LAYER
------------------------------------------------

Funzione:

Gestione eventi inseriti

Componenti:

- lista eventi NEW
- azioni per evento:
  - WRITTEN
  - ERROR

Caratteristiche:

- decisione manuale
- aggiornamento stato
- refresh immediato

Limiti:

- nessun editing
- nessun lifecycle avanzato

------------------------------------------------
FLOW COMPLETO SISTEMA
------------------------------------------------

INPUT:

utente scrive in input_home

↓

SYNC:

input_home → input_raw

↓

PARSING:

estrazione dati base

↓

PREVIEW:

visualizzazione:

- amount + unit + label
- project/entity
- suggerimenti

↓

CONFERMA:

utente conferma

↓

INSERT:

insert_event

↓

DATABASE:

evento salvato con status NEW

↓

PROCESSING:

utente:

✔ WRITTEN
✖ ERROR

↓

UPDATE:

stato aggiornato

------------------------------------------------
MODELLO DATI
------------------------------------------------

Tabella: events

Campi:

- id
- created_at
- event_date
- project_id
- entity_id
- type
- amount
- unit
- reference_id
- source
- payment_method
- notes
- raw_input
- payload
- status

Tabelle correlate:

- projects
- entities

------------------------------------------------
STATO ARCHITETTURALE
------------------------------------------------

✔ sistema coerente
✔ architettura stabile
✔ flusso end-to-end funzionante

---

⚠ sistema incompleto nei layer centrali:

- parsing
- matching
- normalizzazione

---

❌ layer non esistenti:

- engine
- analytics
- dashboard

------------------------------------------------
LIMITI STRUTTURALI
------------------------------------------------

- parsing non affidabile
- matching non deterministico
- dati non normalizzati
- assenza lifecycle completo

------------------------------------------------
DIREZIONE EVOLUTIVA
------------------------------------------------

Ordine corretto sviluppo:

1. input reliability
2. parsing completo
3. matching affidabile
4. data structure
5. engine
6. dashboard

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01

- Definizione architettura reale sistema LOGOS
- Allineamento completo con Retool e Supabase
- Consolidamento layer funzionali
- Eliminazione incoerenze tra documenti precedenti