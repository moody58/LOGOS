00_PROJECT_State_v04

DATA: 2026-04-03

------------------------------------------------
NODO ATTIVO:
------------------------------------------------

INPUT RELIABILITY + MATCHING BASE — COMPLETATI

------------------------------------------------
FASE:
------------------------------------------------

TRANSIZIONE → LABEL QUALITY

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- coperti tutti i layer sistema  
- parsing + matching completamente documentati  
- runtime allineato  

Q (Qualità): 9.5/10  
- stato coerente con sistema reale  
- nessuna ambiguità parsing/matching  
- distinzione chiara tra attuale e futuro  

D (Deployabilità): 10/10  
- pronto per Regia  
- stato completamente ricostruibile  
- nessuna dipendenza mancante  

------------------------------------------------
IDENTIFICAZIONE PROGETTO
------------------------------------------------

Nome: LOGOS  
Tipo: Event Operating System  

Stack:

Frontend: Retool  
Backend: Supabase  
Logica: Client-side (JavaScript)  
Modello dati: Event Ledger (append-only)  

------------------------------------------------
STATO GENERALE SISTEMA
------------------------------------------------

Sistema funzionante end-to-end:

INPUT  
→ PARSING  
→ MATCHING  
→ PREVIEW  
→ INSERT  
→ PROCESSING  
→ FEEDBACK  

✔ sistema stabile  
✔ utilizzabile in produzione reale  
✔ comportamento deterministico  

------------------------------------------------
AGGIORNAMENTO CRITICO (COMPLETATO)
------------------------------------------------

Il sistema è stato stabilizzato su due layer fondamentali:

1. INPUT RELIABILITY — PARSING  
2. MATCHING BASE  

---

RISULTATO:

✔ eliminata fragilità input  
✔ eliminata divergenza preview / confirm  
✔ ridotti falsi positivi matching  
✔ comportamento prevedibile  
✔ allineamento completo preview → insert → DB  

------------------------------------------------
COMPONENTI ATTIVI
------------------------------------------------

INPUT LAYER

- input_home (input utente)
- input_raw (adapter tecnico)

---

MATCHING LAYER

- select_project
- select_entity
- logiche di matching distribuite

---

PROCESSING LAYER

- lista eventi NEW
- gestione WRITTEN / ERROR

---

UI STATE

ui_state:

{
  view: "home" | "feedback"
}

---

FEEDBACK SYSTEM

- non bloccante (~3s)
- ritorno automatico

------------------------------------------------
PARSING SYSTEM (STABILIZZATO)
------------------------------------------------

TIPO:

✔ deterministico  
✔ proximity-based  
✔ multi-formato  

---

UNITÀ SUPPORTATE

EURO:

€, euro, eur  
€20 / 20€ / € 20  

---

TEMPO:

ore: ora, ore, h  
minuti: min, minuti  

formati:

2h, h2, 2 h  
30min, min30  
0.5h  

✔ supporto unit compatte (senza spazi)

---

ESTRAZIONE AMOUNT

- matchAll numeri  
- selezione per prossimità alla unità  
- gestione corretta multi-numero  
→ numero selezionato in base alla unit più rilevante (ultima occorrenza)

---

DECIMALI

✔ supportati (1,5 / 1.5)

---

GESTIONE ORARI

✔ HH:MM ignorato  

---

FIX CRITICI INTRODOTTI

✔ eliminato fallback su "h"  
→ evitati falsi positivi ("macchina")

✔ numero finale senza unità ignorato  
→ "villa 2" NON genera amount

✔ gestione corretta unit compatte  
→ "2h", "18min", "0.5h"

✔ selezione amount corretta su input complessi  
→ "villa 2 mario rossi 3h" → 3

---

LABEL CLEANING

- rimozione amount + unit  
- rimozione preposizioni base  
- mantenimento significato  

⚠ NON utilizzato per persistenza (notes disattivato)

---

LIMITI CONSAPEVOLI

- multi-unit non supportato  
- parsing non semantico  

------------------------------------------------
MATCHING SYSTEM (STABILIZZATO)
------------------------------------------------

PRINCIPI:

✔ suggerire ≠ decidere  
✔ no inferenze  
✔ utente in controllo  

---

PROJECT MATCH

- split parole nome  
- filtro parole (>2 char, non numeriche)  
- match per parole  
- disambiguazione numerica  

---

ENTITY MATCH (RETROFIT STEP 2)

STRONG:

- match nome completo  

---

FULL:

- tutte parole presenti  
- parole ≥4 caratteri  

---

PARTIAL (RETROFIT):

PRIMA:

- includes(cleanText) → rumoroso  

DOPO:

- match su token significativi  
- almeno una parola ≥4 caratteri in comune  

---

AUTO-SELECT

✔ solo match univoco  
✔ nessuna forzatura  

---

RISULTATI

✔ riduzione falsi positivi  
✔ ambiguità solo reale  
✔ maggiore affidabilità suggerimenti  

------------------------------------------------
PREVIEW SYSTEM
------------------------------------------------

✔ preview = parsing reale  
✔ nessuna doppia interpretazione  
✔ rappresentazione fedele  
✔ completamente allineata con insert e DB  

STRUTTURA:

MAIN:

amount + unit + label  

META:

project + entity  

HINT:

- suggerimenti matching  
- suggerimenti tipo  

------------------------------------------------
INSERT
------------------------------------------------

insert_event attivo

Scrittura:

- raw_input  
- amount  
- unit  
- project_id  
- entity_id  
- status = NEW  

✔ unit sempre persistita correttamente  
✔ amount coerente con parsing  
✔ raw_input sempre valorizzato  
✔ dati salvati coerenti con preview  

✔ nessuna validazione bloccante  

------------------------------------------------
DATABASE
------------------------------------------------

Tabelle:

- events  
- projects  
- entities  

---

CARATTERISTICHE:

✔ database passivo  
✔ nessuna logica  
✔ nessuna validazione  

---

LIMITI:

- entity senza gerarchia  
- dati non normalizzati  
- type non utilizzato  

------------------------------------------------
PROCESSING
------------------------------------------------

Lista eventi NEW

Azioni:

✔ WRITTEN  
✔ ERROR  

---

✔ decisione manuale  
✔ nessuna automazione  

------------------------------------------------
UI ARCHITECTURE
------------------------------------------------

Single Page App (Retool)

Container:

- home  
- input  
- feedback  
- events_list  

---

✔ state-driven  
✔ nessun routing  
✔ logica client-side  

------------------------------------------------
FUNZIONALITÀ IMPLEMENTATE
------------------------------------------------

✔ inserimento eventi rapido (<3s)  
✔ parsing robusto reale  
✔ supporto varianti input  
✔ matching project/entity stabile  
✔ suggerimenti non invasivi  
✔ preview coerente  
✔ allineamento preview = DB  
✔ gestione eventi NEW  
✔ conferma manuale  
✔ UI stabile  
✔ feedback post-insert  

------------------------------------------------
FUNZIONALITÀ NON IMPLEMENTATE
------------------------------------------------

INPUT

- multi-unit parsing  
- parsing semantico  

---

MATCHING

- gerarchia entity  
- disambiguazione avanzata  
- ranking  

---

DATA STRUCTURE

- relazioni entity  
- deduplicazione  

---

ENGINE

- normalizzazione  
- interpretazione  

---

OUTPUT

- dashboard  
- analytics  
- KPI  

------------------------------------------------
PROBLEMI REALI IDENTIFICATI
------------------------------------------------

1. DATA NON NORMALIZZATI

- label variabili  
- unit non consolidate  

---

2. ENTITY NON STRUTTURATE

- nessuna gerarchia  
- ambiguità inevitabile  

---

3. TYPE LIMITATO

- nessuna distinzione spesa/incasso  

---

4. UI LIMITI

- input non multilinea  
- preview migliorabile  

---

5. ASSENZA ENGINE

- nessuna logica evolutiva  

------------------------------------------------
PROBLEMI RISOLTI
------------------------------------------------

✔ parsing fragile → RISOLTO  
✔ preview incoerente → RISOLTO  
✔ falsi positivi matching → RIDOTTI  
✔ comportamento non deterministico → RISOLTO  
✔ perdita unit → RISOLTA  
✔ mismatch amount → RISOLTO  
✔ divergenza preview / DB → RISOLTA  

------------------------------------------------
STATO LAYER SISTEMA
------------------------------------------------

Layer 1 — Input: ~95%  
Layer 2 — Matching + Processing: ~70%  
Layer 3 — Data Structure: ~20%  
Layer 4 — Engine: 0%  
Layer 5 — Output: 0%  

---

STATO COMPLESSIVO:

~50%

------------------------------------------------
FASE ATTUALE
------------------------------------------------

✔ INPUT RELIABILITY — COMPLETATA  
✔ MATCHING BASE — COMPLETATO  

---

TRANSIZIONE:

→ LABEL QUALITY  

------------------------------------------------
OBIETTIVO IMMEDIATO
------------------------------------------------

Migliorare:

- qualità label  
- coerenza descrizioni  
- riduzione variabilità  

---

Preparare:

→ base per ENGINE  

------------------------------------------------
VINCOLI OPERATIVI
------------------------------------------------

✔ nessun refactor globale  
✔ nessuna modifica architettura  
✔ nessuna AI  
✔ miglioramenti incrementali  

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il sistema:

✔ è stabile  
✔ è utilizzabile  
✔ è estendibile  

---

Priorità:

1. label quality  
2. normalizzazione  
3. engine  
4. output  

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01  
documento iniziale  

v02 — 2026-04-02  
parsing retrofit  

v03 — 2026-04-03  
matching retrofit  
stabilizzazione completa input + matching  
allineamento runtime reale  

v04 — 2026-04-03  
fix insert pipeline  
allineamento preview → DB  
fix unit compatte  
fix amount multi-numero  