00_PROJECT_State_v05

DATA: 2026-04-04

------------------------------------------------
NODO ATTIVO:
------------------------------------------------

LABEL QUALITY — COMPLETATO

------------------------------------------------
FASE:
------------------------------------------------

TRANSIZIONE → STEP 4 (UX / ENGINE BASE)

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- coperti tutti i layer sistema  
- parsing + matching completamente documentati  
- label layer integrato  

Q (Qualità): 9.5/10  
- stato coerente con sistema reale  
- distinzione chiara parsing / matching / label  
- UX migliorata senza regressioni  

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
→ PREVIEW (LABEL)  
→ INSERT  
→ PROCESSING  
→ FEEDBACK  

✔ sistema stabile  
✔ utilizzabile in produzione reale  
✔ comportamento deterministico  

------------------------------------------------
AGGIORNAMENTO CRITICO (COMPLETATO)
------------------------------------------------

Il sistema è stabilizzato su tre layer fondamentali:

1. INPUT RELIABILITY — PARSING  
2. MATCHING BASE  
3. LABEL QUALITY  

---

RISULTATO:

✔ eliminata fragilità input  
✔ eliminata divergenza preview / confirm  
✔ ridotti falsi positivi matching  
✔ migliorata coerenza label  
✔ UX meno rumorosa  
✔ comportamento prevedibile  

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

LABEL LAYER (NUOVO)

- sintesi (preview)
- pipeline label non distruttiva
- gestione hint UX

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
LABEL SYSTEM (NUOVO — STABILIZZATO)
------------------------------------------------

TIPO:

✔ deterministico  
✔ non distruttivo  
✔ derivato (non persistito)  

---

PIPELINE:

- normalizzazione testo  
- rimozione amount + unit  
- gestione unit compatte (es: 3h, 30min)  
- rimozione stopwords base  
- numeric safe (preservazione numeri semantici)  
- compound token (es: "villa 2")  
- sorting alfabetico stabile (locale: it, sensitivity base)  

---

PRINCIPI:

✔ nessuna perdita informazione  
✔ nessuna interpretazione semantica  
✔ nessuna modifica DB  

---

OUTPUT:

- label coerenti  
- variabilità ridotta  
- maggiore leggibilità  

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

- match su token significativi  
- almeno una parola ≥4 caratteri in comune  

---

AUTO-SELECT

✔ solo match univoco  
✔ nessuna forzatura  

---

AGGIUNTE UX MATCHING

- soglia attivazione hint (≥5 caratteri)  
- gestione ambiguità input corto (prefisso)  
- riduzione suggerimenti ridondanti  

---

RISULTATI

✔ riduzione falsi positivi  
✔ ambiguità solo reale  
✔ maggiore affidabilità suggerimenti  

------------------------------------------------
PREVIEW SYSTEM
------------------------------------------------

✔ preview = parsing reale + label  
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
- hint durata ambigua  

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

✔ label NON persistita  

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
✔ label cleaning non distruttivo  
✔ riduzione variabilità descrizioni  
✔ hint intelligenti (UX)  
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

- label variabili (ridotte lato preview)  
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
✔ variabilità label → RIDOTTA  
✔ rumore UX → RIDOTTO  
✔ unit attaccate → RISOLTE  
✔ duplicazione suggerimenti → RISOLTA  

------------------------------------------------
STATO LAYER SISTEMA
------------------------------------------------

Layer 1 — Input: ~95%  
Layer 2 — Matching + Processing: ~75%  
Layer 3 — Data Structure: ~20%  
Layer 4 — Engine: 0%  
Layer 5 — Output: 0%  

---

STATO COMPLESSIVO:

~55%

------------------------------------------------
FASE ATTUALE
------------------------------------------------

✔ INPUT RELIABILITY — COMPLETATA  
✔ MATCHING BASE — COMPLETATO  
✔ LABEL QUALITY — COMPLETATO  

---

TRANSIZIONE:

→ STEP 4 (UX refinement / ENGINE BASE)

------------------------------------------------
OBIETTIVO IMMEDIATO
------------------------------------------------

Migliorare:

- suggestion UX  
- gestione ambiguità  
- base per normalizzazione futura  

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

La label è ora:

→ layer derivato  
→ non persistito  
→ base per evoluzione engine  

---

Priorità:

1. label quality ✔  
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

v04 — 2026-04-03  
fix insert pipeline  

v05 — 2026-04-04  
introduzione label layer  
implementazione label pipeline  
miglioramento UX hint  
riduzione variabilità descrizioni  