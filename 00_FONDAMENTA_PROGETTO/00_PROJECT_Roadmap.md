# 00_PROJECT_Roadmap_v03
DATA: 2026-04-24

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire la sequenza operativa vincolante
per lo sviluppo del sistema LOGOS.

La roadmap:

- guida lo sviluppo
- stabilisce priorità
- previene deriva
- definisce ordine corretto delle fasi

---

La roadmap è:

✔ operativa  
✔ aggiornata nel tempo  
✔ dipendente dallo stato reale  

---

NON è:

❌ strategica (ruolo della Regia)  
❌ descrittiva (ruolo dello State)  

------------------------------------------------
PRINCIPIO FONDANTE
------------------------------------------------

SVILUPPO SEQUENZIALE VINCOLATO

---

Ogni fase:

- deve essere completata
- deve essere validata
- non può essere saltata

---

Divieto:

- lavorare su più fasi contemporaneamente

------------------------------------------------
STATO ATTUALE
------------------------------------------------

FASE COMPLETATA:

✔ STEP 1 — INPUT RELIABILITY (STABILIZZATO)  
✔ STEP 2 — MATCHING BASE (STABILE)  
✔ STEP 3 — LABEL QUALITY (COMPLETATO)  
✔ STEP 3.5 — STRUCTURE STABILIZATION (COMPLETATO)  
✔ STEP 4 — EVENT EDITING (COMPLETATO)  

---

FASE ATTIVA:

TRANSIZIONE → STEP 6 — ENGINE BASE

------------------------------------------------
ROADMAP MASTER
------------------------------------------------

STEP 1 — INPUT RELIABILITY (COMPLETATO)

Obiettivo:

Rendere l’input sufficientemente affidabile

---

Interventi:

- parsing unità (€, minuti, ore)
- estrazione amount stabile
- label cleaning
- type detection base

---

Output atteso:

- preview coerente
- riduzione ambiguità
- input utilizzabile

------------------------------------------------

STEP 2 — MATCHING BASE

Obiettivo:

Ridurre ambiguità project/entity

---

Interventi:

- project matching stabile
- entity matching multi-livello
- suggerimenti coerenti

---

Output atteso:

- riduzione errori selezione
- suggerimenti affidabili

------------------------------------------------

STEP 3 — LABEL QUALITY / INPUT COMPLETENESS

Obiettivo:

Gestione casi complessi

---

Interventi:

- edge case parsing
- gestione input sporco
- stabilizzazione preview

---

Output atteso:

- copertura casi reali
- robustezza input

------------------------------------------------

STEP 3.5 — STRUCTURE STABILIZATION (COMPLETATO)

Obiettivo:

Stabilizzare il sistema eliminando accoppiamenti tra input, parsing e UI

---

Interventi eseguiti:

✔ introduzione parser controllato (parse_input_controlled)  
✔ introduzione debounce parsing  
✔ eliminazione parsing per-lettera  
✔ eliminazione loop reattivo  
✔ centralizzazione parsing in ui_state  
✔ eliminazione duplicazione parsing  
✔ allineamento create/edit  
✔ stabilizzazione UI flow (no flash)  
✔ separazione input → parsing → preview  

---

Output raggiunto:

✔ sistema deterministico reale  
✔ parsing stabile  
✔ UX fluida  
✔ nessun trigger circolare  
✔ base pronta per engine  

------------------------------------------------

STEP 4 — EVENT EDITING

Obiettivo:

Consentire correzione eventi

---

Interventi:

- editing eventi NEW
- riuso UI input
- correzione dati

---

Output atteso:

- miglioramento qualità dati
- riduzione errori permanenti
---

STATO:

✔ editing eventi NEW operativo  
✔ update_event implementato  
✔ riuso completo pipeline input  
✔ miglioramento qualità dati  
✔ completamente allineato con input system stabilizzato

------------------------------------------------

STEP 5 — DATA STRUCTURE

Obiettivo:

Strutturare dati e relazioni

---

Interventi:

- creazione guidata project/entity
- relazioni entity-project
- gestione duplicati

---

Output atteso:

- dati coerenti
- struttura stabile

------------------------------------------------

STEP 6 — ENGINE

Obiettivo:

Normalizzazione e logica dati

---

Interventi:

- normalizzazione avanzata
- deduplicazione
- logica semantica

---

Output atteso:

- dati confrontabili
- base per analytics

------------------------------------------------

STEP 7 — OUTPUT

Obiettivo:

Visualizzazione e analisi

---

Interventi:

- dashboard
- KPI
- analytics

---

Output atteso:

- sistema decisionale completo

------------------------------------------------
REGOLE OPERATIVE
------------------------------------------------

VIETATO:

- anticipare step successivi
- lavorare su più layer
- introdurre automazioni premature
- modificare architettura

---

CONSENTITO:

- miglioramenti incrementali
- test reali
- iterazioni rapide

------------------------------------------------
CRITERIO DI PASSAGGIO STEP
------------------------------------------------

Uno step è considerato completato solo se:

✔ utilizzabile in modo reale  
✔ stabile (anche reattivamente)    
✔ senza blocchi evidenti  
✔ validato su uso concreto  

---

Se non soddisfa questi criteri:

→ lo step NON è chiuso

------------------------------------------------
GESTIONE EVOLUZIONE ROADMAP
------------------------------------------------

La roadmap può essere aggiornata SOLO se:

- cambia lo stato reale del sistema
- emerge un blocco strutturale
- audit evidenzia errore critico

---

Aggiornamento tramite:

versione (v01 → v02)

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il sistema NON deve evolvere per:

- completezza teorica
- feature non validate
- complessità non necessaria

---

Il sistema deve evolvere per:

- uso reale
- qualità dati
- affidabilità

------------------------------------------------
BLOCCO ATTUALE (CRITICO)
------------------------------------------------

Il blocco strutturale principale è stato risolto:

✔ eliminato loop reattivo  
✔ separata pipeline input → parsing → UI  
✔ eliminata duplicazione parsing  
✔ stabilizzato comportamento reattivo  

---

Il sistema è ora idoneo al passaggio verso ENGINE.

---

⚠ BLOCCO ATTUALE:

Il sistema NON può avanzare allo STEP 7 (OUTPUT)
finché non viene implementato:

- ENGINE BASE (STEP 6)

---

Motivazione:

senza engine:

- dati non normalizzati  
- impossibilità di confronto  
- impossibilità di aggregazione  

---

STEP 5 (DATA STRUCTURE) resta:

⚠ opzionale ma fortemente consigliato prima di ENGINE avanzato

------------------------------------------------

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-02

- Creazione roadmap separata dalla Regia
- Definizione sequenza operativa vincolante
- Allineamento con audit e stato reale sistema

v03 — 2026-04-24

- completamento STEP 3.5 (Structure Stabilization)
- eliminazione loop reattivo
- introduzione parsing controllato
- unificazione parsing (single source of truth)
- stabilizzazione UX input
- chiusura dipendenza STEP 4 da stabilizzazione
- apertura transizione verso ENGINE BASE