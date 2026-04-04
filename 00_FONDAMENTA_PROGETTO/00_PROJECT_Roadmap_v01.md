# 00_PROJECT_Roadmap_v01

DATA: 2026-04-02

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

✔ STEP 1 — INPUT RELIABILITY  
✔ STEP 2 — MATCHING BASE  
✔ STEP 3 — LABEL QUALITY  

---

FASE ATTIVA:

STEP 4 — UX REFINEMENT / ENGINE BASE

---

Motivazione:

Il sistema è:

- stabile
- utilizzabile
- deterministico

Ma:

- dati non normalizzati
- suggerimenti migliorabili
- nessun engine attivo

---

Blocco:

NON procedere verso DATA STRUCTURE o ENGINE avanzato
finché non è definita una base UX + normalizzazione controllata

------------------------------------------------
ROADMAP MASTER
------------------------------------------------

STEP 1 — INPUT RELIABILITY (ATTIVO)

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

STEP 3 — INPUT COMPLETENESS

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

STEP 3.5 — UX REFINEMENT (NUOVO)

Obiettivo:

Ridurre attrito e ambiguità senza modificare architettura

---

Interventi:

- miglioramento hint
- gestione ambiguità input
- controllo attivazione suggerimenti
- coerenza visuale preview

---

Output atteso:

- UX più chiara
- meno errori utente
- maggiore velocità input

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
✔ stabile  
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
CHANGELOG
------------------------------------------------

v01 — 2026-04-02

- Creazione roadmap separata dalla Regia
- Definizione sequenza operativa vincolante
- Allineamento con audit e stato reale sistema