00_PROJECT_State_v09
DATA: 2026-04-24

------------------------------------------------
NODO ATTIVO:
------------------------------------------------

INPUT SYSTEM — PARSE FLOW STABILIZATION COMPLETED

------------------------------------------------
FASE:
------------------------------------------------

STEP 4 — EVENT EDITING (COMPLETATO)

STEP 4.1 — INPUT SYSTEM STABILIZATION (COMPLETATO)

TRANSIZIONE → ENGINE BASE

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

✔ sistema funzionante  
✔ utilizzabile in produzione reale  
✔ comportamento quasi deterministico  

⚠ presenza loop reattivo (input ↔ parsing ↔ UI)
⚠ accoppiamento input / processing / UI    

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

⚠ matching basato su stringhe (no fuzzy)  
⚠ hint limitati a logica base

✔ introduzione EVENT EDITING

- edit_mode per distinzione INSERT / UPDATE
- update_event implementato
- riuso completo pipeline input per modifica

✔ introduzione updated_at

- tracciamento modifiche evento
- base per ordinamento dinamico lista

------------------------------------------------
AGGIORNAMENTO CRITICO — INPUT FLOW (NUOVO)
------------------------------------------------

Refactor completo del sistema di parsing:

✔ introduzione parse_input_controlled (parser unico)
✔ eliminazione parse_input come source di verità
✔ introduzione debounce parsing
✔ eliminazione trigger per-lettera
✔ separazione input → parsing → UI

---

NUOVA ARCHITETTURA:

input_home
→ input_raw
→ trigger_parse_debounced
→ parse_input_controlled
→ ui_state.parsed
→ preview

---

RISULTATI:

✔ eliminato loop reattivo (CRITICO)
✔ parsing stabile
✔ UX fluida (desktop + mobile)
✔ riduzione chiamate inutili
✔ base pronta per input vocale

---

PRINCIPIO INTRODOTTO:

→ SINGLE SOURCE OF TRUTH = ui_state.parsed

- preview usa ui_state
- salvataggio usa ui_state
- edit usa ui_state

✔ eliminata duplicazione parsing
✔ eliminata divergenza preview / DB

------------------------------------------------
AGGIORNAMENTO UX (NUOVO)
------------------------------------------------

Il sistema è stato aggiornato nel layer preview/hint:

✔ introduzione hint multipli
✔ introduzione gerarchia visiva
✔ eliminazione hint prematuri
✔ attivazione controllata (input ≥ 3 char)
✔ separazione semantica colori

RISULTATO:

✔ UX più chiara
✔ nessuna ambiguità nascosta
✔ miglior supporto decisionale utente

⚠ hint ancora scollegati da state unificato
⚠ duplicazione logica detection

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

LABEL LOGIC (EMBEDDED)

- generazione label dentro preview
- pipeline non distruttiva
- NON separata come layer runtime

---

PROCESSING LAYER

- lista eventi NEW
- gestione WRITTEN / ERROR

---

UI STATE

ui_state:

{
  view: "home" | "feedback" | "events",
  parsed: {
    amount,
    unit,
    event_date
  },
  status,
  feedback_text,
  feedback_project
}

✔ state centralizzato
✔ parsing condiviso tra layer
✔ UI completamente state-driven

---

FEEDBACK SYSTEM

✔ attivazione immediata (no attesa backend)
✔ gestione view tramite ui_state
✔ eliminato doppio trigger UI (no flash)

FLOW:

submit →
ui_state.view = feedback →
reset input →
save async →
refresh async

---

✔ UX immediata
✔ nessun flicker
✔ feedback consistente

---

✔ resume basato su ui_state (non su input)

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

--- 

ARCHITETTURA PARSING (AGGIORNATA)

✔ parsing NON più inline
✔ parsing NON duplicato
✔ parsing NON dipendente da UI

---

TRIGGER:

✔ debounce (non per lettera)
✔ trigger controllato

---

CONSUMO:

✔ preview → ui_state.parsed
✔ save → ui_state.parsed
✔ edit → trigger parse manuale

---

✔ sistema consistente in tutti gli stati (create/edit)

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

⚠ ambiguità non sempre correttamente segnalata  
⚠ riconoscimento entity non sempre consistente  
⚠ affidabilità suggerimenti variabile su input complessi 

--- 

⚠ PROBLEMA STRUTTURALE EMERSO

- presenza di più sistemi di matching:
  - input_raw (ranking)
  - select (deterministico)
  - preview (detected*)

→ incoerenza architetturale
→ duplicazione logica

⚠ PRIORITY MATCH NON IMPLEMENTATO
→ impossibilità di distinguere:
  - match migliore
  - match multipli equivalenti

------------------------------------------------
PREVIEW SYSTEM
------------------------------------------------

✔ preview = parsing reale + label  
✔ rappresentazione coerente lato utente  
✔ allineata ai dati salvati (amount, unit, ids)  

⚠ contiene logiche di trasformazione (cleaning + label)  
⚠ non è una view pura    

STRUTTURA:

MAIN:

amount + unit + label  

META:

project + entity  

HINT:

- suggerimenti matching  
- suggerimenti tipo  
- hint durata ambigua  

✔ supporto multi-hint

✔ hint NON bloccanti

✔ gerarchia visiva:

- rosso → ambiguità
- arancione → azione richiesta
- grigio → suggerimento soft

⚠ logica hint NON basata su state unico
⚠ presenza duplicazione detected vs state

---

✔ preview ora basata su ui_state.parsed
✔ nessuna dipendenza diretta dal parser
✔ eliminato desync preview/edit

✔ comportamento identico:
- creazione
- modifica

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

✔ unit generalmente persistita correttamente  
✔ amount coerente con parsing  
✔ raw_input sempre valorizzato  

✔ dati salvati correttamente  
✔ nessun blocco runtime attuale      

✔ label NON persistita  

✔ nessuna validazione bloccante  

------------------------------------------------
UPDATE (NUOVO)
------------------------------------------------

update_event attivo

Scrittura:

- raw_input
- amount
- unit
- project_id
- entity_id
- event_date
- updated_at

✔ modifica evento senza duplicazione
✔ riuso pipeline input

⚠ update consentito solo su eventi NEW

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
✔ presenza campo updated_at
→ utilizzato per tracking modifiche

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

✔ supporto EDIT (modifica evento)

FLOW:

NEW → EDIT → NEW
NEW → WRITTEN
NEW → ERROR

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
✔ gestione stato centralizzata via ui_state
✔ eliminati trigger multipli UI

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
✔ gestione multi-hint
✔ gerarchia visiva feedback
✔ controllo attivazione hint (anti-noise) 
✔ EVENT EDITING (modifica eventi)
✔ UPDATE FLOW (insert/update separati)
✔ tracciamento updated_at
✔ ordinamento eventi per modifica
✔ centralizzazione UI state
✔ stabilizzazione feedback flow

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

HINT SYSTEM

- integrazione con state unificato
- priorità tra match (priority engine)

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

--- 

6. DUPLICAZIONE MATCHING

- più logiche indipendenti
- incoerenza tra layer

--- 

7. HINT NON STATE-DRIVEN

- uso detected*
- non allineati a select

--- 

8. PRIORITÀ MATCH ASSENTE

- impossibile distinguere match dominante  

9. LOOP REATTIVO (RISOLTO)

- eliminato tramite debounce + parser controllato

---

10. ACCOPPIAMENTO LAYER

- input non separato da processing
- preview non read-only puro

---

11. MATCHING NON UNIFICATO

- 3 logiche separate
- incoerenza tra select / preview / ranking

------------------------------------------------
PROBLEMI RISOLTI
------------------------------------------------

✔ parsing fragile → RISOLTO  
✔ preview incoerente → RISOLTO  
✔ falsi positivi matching → RIDOTTI  
✔ comportamento non deterministico → RISOLTO  
✔ perdita unit → RISOLTA  
✔ mismatch amount → RISOLTO  
✔ divergenza preview / DB → RISOLTA (dati persistiti)    
✔ variabilità label → RIDOTTA  
✔ rumore UX → RIDOTTO  
✔ unit attaccate → RISOLTE  
✔ duplicazione suggerimenti → RISOLTA  
✔ hint incoerenti → RISOLTI  
✔ hint prematuri → RISOLTI  
✔ perdita multi-anomalia → RISOLTA  
✔ UX hint migliorata → RISOLTA  
✔ loop reattivo input → RISOLTO  
✔ parsing per-lettera → RISOLTO  
✔ duplicazione parsing → RISOLTA  
✔ desync edit/preview → RISOLTO  
✔ errore ui_state.setValue → RISOLTO  
✔ flash UI feedback → RISOLTO  
✔ blocco UX su save → RISOLTO  

------------------------------------------------
STATO LAYER SISTEMA
------------------------------------------------

Layer 1 — Input: ~95%    
Layer 2 — Matching: ~75%  
Layer 3 — View / Preview: ~80%  
Layer HINT SYSTEM: ~90%
Layer 4 — Data Structure: ~20%  
Layer 5 — Engine: 0%  
Layer 6 — Output: 0%    

---

STATO COMPLESSIVO:

~68%

------------------------------------------------
FASE ATTUALE
------------------------------------------------

✔ INPUT RELIABILITY — COMPLETATA  
✔ MATCHING BASE — COMPLETATO  
✔ LABEL QUALITY — COMPLETATO  
✔ EVENT EDITING — COMPLETATO  
✔ INPUT SYSTEM STABILIZATION — COMPLETATA  

---

TRANSIZIONE:

→ ENGINE BASE

------------------------------------------------
OBIETTIVO IMMEDIATO
------------------------------------------------

Stabilizzare:

- eliminazione loop reattivo
- separazione input / processing / UI
- unificazione matching  

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

✔ è funzionale    
✔ è utilizzabile  
✔ è estendibile 
⚠ non è ancora stabile architetturalmente 

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

--- 

Il sistema attuale è:

✔ UX-driven
✔ safe
✔ non decisionale

--- 

PRIORITÀ FUTURE:

1. eliminazione loop reattivo  
2. unificazione matching  
3. hint state-driven  
4. semantic engine    

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

v06 — 2026-04-09  
refinement UX hint  
introduzione multi-hint  
introduzione gerarchia visiva  
emersione criticità matching duplicato  

v07 — 2026-04-22  
introduzione event editing  
implementazione update_event  
introduzione updated_at  

v08 — 2026-04-23  
stabilizzazione UI state  
fix feedback flow  
ordinamento eventi per updated_at  
identificazione loop reattivo  
allineamento stato sistema reale  

v09 — 2026-04-24  
introduzione parse_input_controlled  
introduzione debounce parsing  
eliminazione loop reattivo  
unificazione parsing (single source of truth)  
fix edit mode (trigger parse)  
stabilizzazione UI state  
eliminazione flash feedback  
ottimizzazione UX async save  