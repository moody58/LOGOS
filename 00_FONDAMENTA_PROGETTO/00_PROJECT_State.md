# 00_PROJECT_State_v01

DATA: 2026-04-01

------------------------------------------------
IDENTIFICAZIONE PROGETTO
------------------------------------------------

Nome: LOGOS
Tipo: Event Operating System
Stack:

- Frontend: Retool
- Backend: Supabase
- Logica: Client-side (JavaScript)
- Modello dati: Event Ledger (append-only)

------------------------------------------------
STATO GENERALE SISTEMA
------------------------------------------------

Sistema attualmente funzionante end-to-end:

INPUT → PREVIEW → INSERT → PROCESSING → FEEDBACK

Il sistema è operativo ma incompleto.

------------------------------------------------
COMPONENTI ATTIVI
------------------------------------------------

INPUT LAYER:

- input_home (input utente principale)
- input_raw (adapter tecnico)
- input libero non vincolato

---

PARSING:

- parsing base numerico
- riconoscimento parziale unità (minuti, euro)
- label cleaning parziale

---

PREVIEW:

- sintesi strutturata (amount + unit + label)
- selezione manuale:
  - type
  - project
  - entity
- suggerimenti soft (match base)

---

INSERT:

- insert_event attivo
- scrittura su database events
- status iniziale: NEW
- nessuna validazione bloccante

---

DATABASE:

Tabella: events

Campi principali:

- id
- created_at
- event_date
- project_id
- entity_id
- type
- amount
- unit
- notes
- raw_input
- payload
- status

---

PROCESSING:

- lista eventi NEW
- azioni:
  - WRITTEN
  - ERROR
- aggiornamento stato tramite query

---

UI STATE:

Gestione tramite:

ui_state:

{
  view: "home" | "feedback"
}

Container:

- container_home
- container_input
- container_feedback
- container_events_list

---

FEEDBACK:

- sistema non bloccante
- visualizzazione breve (~3s)
- ritorno automatico a home

------------------------------------------------
FUNZIONALITÀ IMPLEMENTATE
------------------------------------------------

✔ inserimento eventi rapido (<3s)
✔ preview strutturata
✔ parsing base funzionante
✔ suggerimenti project/entity (soft)
✔ gestione eventi NEW
✔ conferma manuale (WRITTEN / ERROR)
✔ UI state stabile
✔ feedback post-insert

------------------------------------------------
FUNZIONALITÀ NON IMPLEMENTATE
------------------------------------------------

INPUT:

- parsing unità completo (ore, giorni, multi-unit)
- normalizzazione coerente unità
- riconoscimento comandi (es. "crea progetto")

---

PROCESSING:

- editing eventi
- correzione dati

---

DATA STRUCTURE:

- creazione guidata project/entity
- relazioni strutturate entity-project
- gestione duplicati

---

ENGINE:

- normalizzazione avanzata
- deduplicazione
- logica semantica

---

OUTPUT:

- dashboard
- analytics
- KPI

------------------------------------------------
STATO LAYER SISTEMA
------------------------------------------------

Layer 1 — Input: ~80%
Layer 2 — Processing: ~60%
Layer 3 — Data Structure: ~20%
Layer 4 — Engine: 0%
Layer 5 — Output: 0%

---

STATO COMPLESSIVO:

~25%

------------------------------------------------
PROBLEMI REALI IDENTIFICATI
------------------------------------------------

1. INPUT NON AFFIDABILE

- unità non riconosciute correttamente
- parsing incompleto
- ambiguità elevata

---

2. MATCHING DEBOLE

- project/entity non sempre coerenti
- suggerimenti non affidabili

---

3. DATI NON NORMALIZZATI

- unità non uniformi
- struttura non consolidata

---

4. ASSENZA LIFECYCLE COMPLETO

- eventi limitati a NEW / WRITTEN / ERROR
- nessuna evoluzione dato

------------------------------------------------
FASE ATTUALE
------------------------------------------------

INPUT INTELLIGENCE MINIMAL

Focus:

- parsing unità base
- estrazione amount
- pulizia label
- matching base

------------------------------------------------
NODO OPERATIVO ATTIVO
------------------------------------------------

Parsing unità (€, minuti, ore)

------------------------------------------------
OBIETTIVO IMMEDIATO
------------------------------------------------

Rendere l’input sufficientemente affidabile per:

- tempo
- costi
- eventi

------------------------------------------------
VINCOLI OPERATIVI
------------------------------------------------

- nessun refactor globale
- nessuna modifica architettura
- nessun blocco input
- miglioramenti incrementali

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il sistema:

- NON è rotto
- è incompleto

Priorità:

→ affidabilità input
→ poi normalizzazione
→ poi engine
→ poi dashboard

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01

- Documento iniziale generato da audit completo
- Consolidamento stato reale sistema
- Eliminazione ambiguità tra versioni precedenti
- Allineamento con architettura Retool + Supabase