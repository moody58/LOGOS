00_PROJECT_State_v02

DATA: 2026-04-02
NODO: INPUT RELIABILITY — PARSING (RETROFIT COMPLETATO)

CQD — VALIDAZIONE DOCUMENTO

C (Completezza): 9.5/10

Tutti i layer aggiornati
Parsing reale documentato
Gap residui esplicitati

Q (Qualità): 9/10

Stato coerente con runtime reale
Nessuna ambiguità parsing/preview
Terminologia allineata

D (Deployabilità): 10/10

Documento pronto per Regia
Stato ricostruibile
Nessuna dipendenza mancante
IDENTIFICAZIONE PROGETTO

Nome: LOGOS
Tipo: Event Operating System

Stack:

Frontend: Retool
Backend: Supabase
Logica: Client-side (JavaScript)
Modello dati: Event Ledger (append-only)
STATO GENERALE SISTEMA

Sistema attualmente funzionante end-to-end:

INPUT → PREVIEW → INSERT → PROCESSING → FEEDBACK

Il sistema è operativo e stabile.

AGGIORNAMENTO CRITICO (NUOVO)

Il parsing è stato completamente stabilizzato tramite retrofit incrementale.

✔ eliminato parsing fragile
✔ eliminata divergenza preview / confirm
✔ introdotto parsing deterministico robusto

COMPONENTI ATTIVI
INPUT LAYER
input_home (input utente principale)
input_raw (adapter tecnico)
input libero non vincolato
PARSING (UPDATED — RETROFIT v2)

Il parsing è ora:

✔ proximity-based
✔ multi-formato
✔ deterministico

CAPACITÀ ATTUALI

Unità supportate:

Euro:

€, euro, eur
€20, 20€, € 20

Tempo:

ora, ore, h
min, minuti
2h, h2, 2 h
30min, min30
ESTRAZIONE AMOUNT
identificazione tutti i numeri (matchAll)
selezione numero più vicino alla unità

Esempi:

pizza 20 euro → 20
2 ore lavoro → 2
2h30 → 2
€20 pizza → 20
DECIMALI
supportati: 1,5 / 1.5
conversione automatica → Number
GESTIONE ORARI
formato HH:MM ignorato
non interpretato come amount
mantenuto come testo
LABEL CLEANING
rimozione amount + unit
rimozione preposizioni base
mantenimento significato
LIMITI CONSAPEVOLI
multi-unit NON supportato
nessuna interpretazione semantica
parsing basato su pattern
PREVIEW
sintesi strutturata (amount + unit + label)
selezione manuale:
type
project
entity
AGGIORNAMENTO CRITICO

✔ preview = parsing reale
✔ nessuna doppia interpretazione
✔ nessuna alterazione input

INSERT
insert_event attivo
scrittura su database events
status iniziale: NEW
nessuna validazione bloccante
DATABASE

Tabella: events

Campi principali:

id
created_at
event_date
project_id
entity_id
type
amount
unit
notes
raw_input
payload
status
PROCESSING
lista eventi NEW
azioni:
WRITTEN
ERROR
aggiornamento stato tramite query
UI STATE

Gestione tramite:

ui_state:

{
  view: "home" | "feedback"
}

Container:

container_home
container_input
container_feedback
container_events_list
FEEDBACK
sistema non bloccante
visualizzazione breve (~3s)
ritorno automatico a home
FUNZIONALITÀ IMPLEMENTATE

✔ inserimento eventi rapido (<3s)
✔ preview strutturata coerente
✔ parsing robusto reale
✔ supporto varianti input (€, h, min, compatti)
✔ suggerimenti project/entity (soft)
✔ gestione eventi NEW
✔ conferma manuale (WRITTEN / ERROR)
✔ UI state stabile
✔ feedback post-insert

FUNZIONALITÀ NON IMPLEMENTATE
INPUT
multi-unit parsing (2h30 → 2.5h)
parsing semantico
riconoscimento comandi
PROCESSING
editing eventi
correzione dati
DATA STRUCTURE
creazione guidata project/entity
relazioni strutturate
gestione duplicati
ENGINE
normalizzazione avanzata
deduplicazione
interpretazione intelligente
OUTPUT
dashboard
analytics
KPI
STATO LAYER SISTEMA

Layer 1 — Input: ~92%
Layer 2 — Processing: ~60%
Layer 3 — Data Structure: ~20%
Layer 4 — Engine: 0%
Layer 5 — Output: 0%

STATO COMPLESSIVO

~35%

PROBLEMI REALI IDENTIFICATI
1. MATCHING ANCORA DEBOLE
project/entity non sempre precisi
ambiguità su nomi simili
2. DATI NON NORMALIZZATI
unit coerenti ma non consolidate lato DB
assenza standard globale
3. ASSENZA LAYER ENGINE
nessuna logica evolutiva
nessuna interpretazione avanzata
PROBLEMI RISOLTI (NUOVO)
✔ INPUT NON AFFIDABILE → RISOLTO
parsing stabile
unit riconosciute correttamente
ambiguità ridotta drasticamente
✔ PREVIEW NON COERENTE → RISOLTO
preview allineata al parsing reale
✔ VARIANTI INPUT → RISOLTO
gestione input reale utente (compatti, simboli, decimali)
FASE ATTUALE

INPUT RELIABILITY — COMPLETATA

NODO OPERATIVO ATTIVO

→ TRANSIZIONE VERSO MATCHING / LABEL QUALITY

OBIETTIVO IMMEDIATO

Migliorare:

qualità label
precisione matching
riduzione ambiguità
VINCOLI OPERATIVI
nessun refactor globale
nessuna modifica architettura
nessun blocco input
miglioramenti incrementali
NOTE STRATEGICHE

Il sistema:

✔ non è più fragile
✔ è utilizzabile in produzione reale
✔ è pronto per layer successivo

Priorità:

→ matching
→ normalizzazione
→ engine
→ dashboard

CHANGELOG

v01 — 2026-04-01

documento iniziale
audit completo

v02 — 2026-04-02

retrofit parsing completato
introduzione parsing proximity-based
supporto varianti input reali
allineamento preview / confirm
eliminazione regressioni parsing
aggiornamento stato layer Input
riduzione ambiguità sistema