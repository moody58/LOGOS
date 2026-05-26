# 00_PROJECT_Roadmap_v19

DATA: 2026-05-26

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
- anticipare output prima di dati coerenti
- introdurre engine avanzato senza base stabile
- anticipare istanze verticali prima del Core Event System stabile
- trasformare LOGOS in gestionale monolitico o verticale prima del consolidamento core

------------------------------------------------
PRINCIPIO STRATEGICO OPERATIVO
------------------------------------------------

LOGOS evolve come Core Event System modulare.

Il cuore operativo resta:

INPUT
→ interpretazione controllata
→ project / entity / type / amount / date
→ evento normalizzato
→ ledger eventi
→ viste / moduli / dashboard futuri

Le istanze ASPRI / ADEXIMA / MaurizioLab sono derivate future del core,
non nodi da anticipare ora.

La Roadmap deve quindi preservare questa sequenza:

1. consolidare cuore eventi
2. consolidare project/entity
3. rifinire UX mobile base
4. introdurre command intent guidato
5. consolidare UI readiness / visibility del flow input
6. consolidare preview / hint / input analysis
7. consolidare data structure / relazioni / qualità dati
8. solo dopo aprire viste, dashboard operative, istanze o moduli verticali

Nota post Input Analysis Result Controlled UI Consumption:

Il consolidamento UI Readiness / Visibility Aggregator è stato completato a primo livello controllato.

Successivamente sono stati completati:

- PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
- INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
- INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS

Questo NON equivale ancora a un Input Analysis Model completo e NON equivale a un Event Interpretation Engine.

Stato corretto aggiornato post Visibility Migration Completion:

- UI Readiness / Visibility Aggregator → completato a primo livello
- preview_analysis_state → operativo nella Sintesi per hint/status/missing association
- input_analysis_result → operativo come fonte UI controllata per gli Hidden principali del flow input
- ui_visibility_mode → ancora attivo come latch leggero empty / event / command
- ui_visibility_state → residuo tecnico deprecabile, non più letto da input_analysis_result
- button_input_confirm.Hidden → migrato a input_analysis_result.readiness.canShowConfirm
- button_input_confirm.Disabled → non migrato, resta guard funzionale separata
- button_input_confirm payload / save flow → invariati
- Event Interpretation Engine / Multi-source Input → futuro avanzato, non attivo

Principio architetturale:

LOGOS non evolve verso un motore monolitico.
LOGOS evolve verso un’architettura modulare coordinata:

- i moduli specializzati calcolano;
- input_analysis_result compone raw / selection / effective state;
- la UI legge progressivamente una verità operativa coerente.

Nota post Linting / Retool Query Safety Pass:

Il rumore tecnico Retool è stato ridotto:

- linting Retool azzerati
- query legacy unused typing_state eliminata
- query legacy unused handle_event_success eliminata
- test post-fix superati

Questo non abilita nuovi layer funzionali, ma riduce rischio di manutenzione e falsi allarmi prima dei prossimi nodi.

Divieto operativo:

- non aprire dashboard ASPRI
- non aprire CRM ADEXIMA
- non aprire gestione MaurizioLab
- non aprire moduli animali / allevamento
- non aprire moduli fatture / preventivi
- non aprire moduli clienti avanzati

prima che il Core Event System sia sufficientemente stabile.

------------------------------------------------
STATO ATTUALE
------------------------------------------------

FASE COMPLETATA:

✔ STEP 1 — INPUT RELIABILITY (STABILIZZATO)  
✔ STEP 2 — MATCHING BASE (STABILE)  
✔ STEP 3 — LABEL QUALITY (COMPLETATO)  
✔ STEP 3.5 — STRUCTURE STABILIZATION (COMPLETATO)  
✔ STEP 4 — EVENT EDITING (COMPLETATO)  
✔ STEP 6.1 — ENGINE BASE / NORMALIZATION LAYER BASE (COMPLETATO)  
✔ PREVIEW ALIGNMENT BASE (COMPLETATO)  
✔ STEP 6.2 — ENGINE BASE / DURATION NORMALIZATION (COMPLETATO)  
✔ STEP 6.3 — ENGINE BASE / TYPE CLASSIFICATION BASE (COMPLETATO)
✔ STEP 6.4 — MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL (COMPLETATO)  
✔ UX / CLEANUP MICRO-BATCH POST MATCH ENGINE (COMPLETATO) 
✔ LINTING / STATE HELPER CLEANUP (COMPLETATO) 
✔ PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL (COMPLETATO)
✔ UX MOBILE COHERENCE PASS (COMPLETATO)
✔ COMMAND INTENT — CREATE PROJECT / ENTITY (COMPLETATO)
✔ UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL (COMPLETATO)
✔ PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER (COMPLETATO)
✔ INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC (COMPLETATO)
✔ INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS (COMPLETATO)
✔ INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION (COMPLETATO)
✔ LINTING / RETOOL QUERY SAFETY PASS (COMPLETATO)
✔ DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION (COMPLETATO)
✔ PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT (COMPLETATO)

---

FASE ATTIVA / TRANSIZIONE:

INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION — PROSSIMO NODO CONSIGLIATO

Stato post audit documentale:

- DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION completato
- Pacchetto A completato come ALLINEAMENTO, non riduzione
- Pacchetto B — Core Governance completato
- Pacchetto C — Documenti tecnici canonici completato
- Pacchetto D — LOGOS_RETOOL_RUNTIME_REAL / Runtime Manifest Normalization completato
- 00_PROJECT_KERNEL_MANIFEST aggiornato a v03
- controllo finale / stress test documentale completato

Esito:

- fonti canoniche definite
- documenti core alleggeriti
- documenti tecnici canonici preservati
- runtime manifest distinti e normalizzati
- Session Boot Matrix consolidata
- regola aggiornamenti futuri consolidata
- ridotto rischio loop documentale
- ridotto costo aggiornamenti futuri

Nota:

Il nodo documentale completato non ha modificato runtime LOGOS,
Retool, Supabase, DB, parser, matching, preview, payload o save flow.

Stato post Preview / Event Data Label Semantic Alignment:

- PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT completato
- G36 integrato
- label “Importo” su durata risolta
- riga valore della Sintesi allineata semanticamente:
  - euro → Importo
  - ore / minuti → Durata
  - fallback non riconosciuto → Valore
- modifica limitata a micro-copy visuale
- parser invariato
- duration normalization invariata
- type classification invariata
- matching invariato
- input_analysis_result invariato
- preview_analysis_state invariato
- button_input_confirm invariato
- payload invariato
- save flow invariato
- DB invariato

Candidati principali residui ordinati:

1. INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION
2. BUTTON CONFIRM READINESS ALIGNMENT
3. PREVIEW MODEL / HINT STATE CONSOLIDATION
4. COMMAND INTENT — EDIT GUIDE GENERIC ALIAS
5. SUGGESTION CREATE VS EDIT CONSISTENCY
6. PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE
7. MATCH ENGINE EVOLUTION ADVANCED / PARTIAL AMBIGUITY
8. DATA STRUCTURE / ENTITY HIERARCHY
9. ECONOMIC DIRECTION ADVANCED
10. DURATION ADVANCED — GIORNI / SETTIMANE
11. CLEANUP OBSOLETE UI GUARDS / UI VISIBILITY STATE DECOMMISSION
12. AZIONI RAPIDE OPERATIVE
13. DASHBOARD BASE
14. ICON SYSTEM / MOBILE POLISH FINALE

Candidati non immediati:

- DASHBOARD BASE
- ICON SYSTEM / MOBILE POLISH FINALE
- ISTANZE / MODULI VERTICALI ASPRI / ADEXIMA / MAURIZIOLAB

------------------------------------------------
ROADMAP MASTER — SINTESI OPERATIVA
------------------------------------------------

La Roadmap mantiene la sequenza vincolante dello sviluppo LOGOS.

Il dettaglio tecnico completo dei nodi completati non viene duplicato qui.
Resta documentato nei documenti canonici e nei checkpoint consolidati.

Fonte canonica tecnica:

- 01_LOGOS_Input_System per input flow, parser, normalization, type, command intent e input_analysis_result
- 02_LOGOS_Match_Engine per matching project/entity
- 03_LOGOS_Event_Lifecycle per lifecycle evento, edit, no-op, cancel, WRITTEN / ERROR
- 04_LOGOS_Retool_Architecture per componenti, query, Hidden e wiring Retool
- 05_LOGOS_Database_Schema per schema DB
- 06_LOGOS_View_Preview_System per Sintesi, preview, hint, warning e label visuali
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
- LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase as-is

------------------------------------------------
STEP COMPLETATI
------------------------------------------------

STEP 1 — INPUT RELIABILITY

Stato:

COMPLETATO

Risultato:

- input utilizzabile
- parsing base stabilizzato
- riduzione ambiguità iniziale

Fonte canonica:
- 01_LOGOS_Input_System

---

STEP 2 — MATCHING BASE

Stato:

COMPLETATO / STABILE

Risultato:

- matching project/entity utilizzabile
- suggerimenti non bloccanti
- controllo utente preservato

Fonte canonica:
- 02_LOGOS_Match_Engine

---

STEP 3 — LABEL QUALITY / INPUT COMPLETENESS

Stato:

COMPLETATO

Risultato:

- label più leggibile
- preview più coerente
- riduzione variabilità descrizioni

Fonte canonica:
- 06_LOGOS_View_Preview_System

---

STEP 3.5 — STRUCTURE STABILIZATION

Stato:

COMPLETATO

Risultato:

- parser controllato
- debounce parsing
- loop reattivo principale eliminato
- input → parsing → UI stabilizzato

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture

---

STEP 4 — EVENT EDITING

Stato:

COMPLETATO

Risultato:

- editing eventi NEW operativo
- update_event implementato
- no-op edit consolidato
- annulla modifica consolidato

Fonte canonica:
- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture

---

STEP 6.1 — ENGINE BASE / NORMALIZATION LAYER BASE

Stato:

COMPLETATO

Risultato:

- amount/unit normalizzati a livello base
- numeri senza unità non interpretati come amount
- insert/update allineati a ui_state.parsed

Fonte canonica:
- 01_LOGOS_Input_System
- 05_LOGOS_Database_Schema

---

PREVIEW ALIGNMENT BASE

Stato:

COMPLETATO

Risultato:

- Sintesi allineata ai dati normalizzati
- formattazione italiana amount/unit
- preview più leggibile

Fonte canonica:
- 06_LOGOS_View_Preview_System

---

STEP 6.2 — ENGINE BASE / DURATION NORMALIZATION

Stato:

COMPLETATO

Risultato:

- durate certe ore/minuti normalizzate in minuti
- giorni/settimane riconosciuti come ambigui ma non convertiti

Fonte canonica:
- 01_LOGOS_Input_System
- 06_LOGOS_View_Preview_System per rendering/hint durata

---

STEP 6.3 — ENGINE BASE / TYPE CLASSIFICATION BASE

Stato:

COMPLETATO

Risultato:

- type base Evento / Tempo / Spesa / Incasso
- type salvato in events.type
- classificazione prudente con override manuale utente

Fonte canonica:
- 01_LOGOS_Input_System
- 05_LOGOS_Database_Schema

---

STEP 6.4 — MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL

Stato:

COMPLETATO

Risultato:

- project_state / entity_state fonte minima matching
- select, preview, hint e confirm guard allineati a primo livello
- ambiguità non risolta blocca Conferma
- scelta manuale utente preservata

Fonte canonica:
- 02_LOGOS_Match_Engine
- 04_LOGOS_Retool_Architecture

---

UX / CLEANUP MICRO-BATCH POST MATCH ENGINE

Stato:

COMPLETATO

Risultato:

- annulla modifica
- ricerca lista eventi
- no-op edit guard
- label creato/modificato
- fix nuovo input da lista eventi

Fonte canonica:
- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture

---

LINTING / STATE HELPER CLEANUP

Stato:

COMPLETATO

Risultato:

- linting edit_mode / editing_event risolti
- helper state ripuliti
- create/edit/annulla/no-op rivalidati

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL

Stato:

COMPLETATO

Risultato:

- project/entity possono essere creati inline previa conferma
- evento non salvato automaticamente dopo creazione
- select manuale resta decisione finale

Fonte canonica:
- 01_LOGOS_Input_System
- 02_LOGOS_Match_Engine
- 04_LOGOS_Retool_Architecture
- 05_LOGOS_Database_Schema

---

UX MOBILE COHERENCE PASS

Stato:

COMPLETATO

Risultato:

- Home mobile rifinita
- Events list rifinita
- Feedback stabilizzato
- Navigation dock predisposta
- vincolo font-size 16px su input/select Safari iOS consolidato

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- 06_LOGOS_View_Preview_System

---

COMMAND INTENT — CREATE PROJECT / ENTITY

Stato:

COMPLETATO — FIRST CONTROLLED LEVEL

Risultato:

- comandi puri create project/entity distinti dagli eventi ordinari
- project/entity creati solo previa conferma
- “modifica evento” gestito come guida non operativa
- nessun evento creato da comando puro

Fonte canonica:
- 01_LOGOS_Input_System
- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture

---

UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL

Stato:

COMPLETATO

Risultato:

- ui_visibility_mode introdotto come latch empty / event / command
- primo coordinamento visibility/readiness
- rendering progressivo ridotto
- container vuoto durante digitazione risolto

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

Nota:

Dopo Visibility Migration Completion, ui_visibility_state resta residuo tecnico deprecabile / rollback,
non più fonte primaria degli Hidden principali migrati.

---

PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER

Stato:

COMPLETATO

Risultato:

- preview_analysis_state introdotto come layer read-only per hint/status/warning
- Sintesi continua a renderizzare, ma legge parte della logica da preview_analysis_state

Fonte canonica:
- 06_LOGOS_View_Preview_System

---

INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC

Stato:

COMPLETATO

Risultato:

- input_analysis_result introdotto come layer compositivo raw / selection / effective
- non sostituisce parser, matching, select, suggestion, command o save flow

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture

---

INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS

Stato:

COMPLETATO

Risultato:

- input_analysis_result diventato fonte UI controllata parziale
- migrati Sintesi, Dati evento, select, command container e association suggestion container

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture

---

INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION

Stato:

COMPLETATO

Risultato:

- Hidden principali del flow input migrati a input_analysis_result
- button_input_confirm.Hidden migrato a canShowConfirm
- button_input_confirm.Disabled e payload invariati
- input_analysis_result non legge più ui_visibility_state

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

LINTING / RETOOL QUERY SAFETY PASS

Stato:

COMPLETATO

Risultato:

- linting Retool azzerati
- query legacy typing_state eliminata
- query legacy handle_event_success eliminata
- nessuna modifica funzionale intenzionale

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION

Stato:

COMPLETATO

Risultato:

- fonti canoniche definite
- documenti core alleggeriti
- documenti tecnici canonici preservati
- runtime manifest normalizzati
- Kernel Manifest aggiornato
- Session Boot Matrix consolidata
- regola aggiornamenti futuri consolidata

Fonte canonica:
- 00_PROJECT_KERNEL_MANIFEST
- 00_PROJECT_State
- 00_PROJECT_Gap_Register

---

PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT

Stato:

COMPLETATO

Risultato:

- label “Importo” su durata risolta
- riga valore della Sintesi allineata semanticamente
- euro → Importo
- ore / minuti → Durata
- fallback non riconosciuto → Valore
- modifica limitata a micro-copy visuale
- parser, DB, payload e save flow invariati

Fonte canonica:
- 06_LOGOS_View_Preview_System
- LOGOS_RETOOL_RUNTIME_REAL

------------------------------------------------
STEP NON ATTIVI / FUTURI
------------------------------------------------

STEP 5 — DATA STRUCTURE

Stato:

NON ATTIVO

Obiettivo futuro:

- relazioni entity-project
- alias
- deduplicazione avanzata
- gerarchie project/entity
- filtro select su match ambigui

Fonte canonica futura:
- 02_LOGOS_Match_Engine
- 05_LOGOS_Database_Schema
- 00_PROJECT_Gap_Register

---

STEP 7 — OUTPUT

Stato:

NON ATTIVO

Motivo:

Output, dashboard, KPI e istanze verticali restano bloccati finché non saranno sufficientemente consolidati:

- data structure / entity hierarchy
- economic direction
- qualità matching
- qualità dati
- preview / input analysis se necessario
- readiness save

Divieto:

non attivare Dashboard/KPI/reportistica prima del consolidamento Core Event System.

------------------------------------------------
VINCOLO DI AVANZAMENTO
------------------------------------------------

Il sistema NON può avanzare allo STEP 7 finché non vengono completati o valutati almeno:

1. Data Structure / Entity Hierarchy
2. Economic Direction Advanced
3. eventuale amount firmato / direction field
4. Duration Advanced — giorni / settimane
5. sufficienza dati reali per report iniziali
6. eventuale consolidamento Preview / Input Analysis per evitare output fuorvianti

Motivo:

senza questi passaggi, output e KPI rischierebbero aggregazioni premature o interpretazioni fuorvianti.

------------------------------------------------
REGOLA ANTI-DERIVA ROADMAP
------------------------------------------------

La Roadmap non deve duplicare dettagli tecnici completi.

La Roadmap deve indicare:

- sequenza
- priorità
- stato dei nodi
- vincoli
- blocchi
- cosa non anticipare

Le logiche complete restano nei documenti canonici.

------------------------------------------------
NODO ATTIVO / PROSSIMO NODO OPERATIVO
------------------------------------------------

INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION

Stato:

PROSSIMO NODO CONSIGLIATO POST PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT

Motivo:

- residuo UX minore già tracciato
- candidato successivo coerente con State e Gap Register
- rischio contenuto se trattato come micro-nodo
- utile per stabilizzare ulteriormente le transizioni del flow input
- non richiede modifiche parser
- non richiede modifiche DB
- non richiede modifiche save flow
- non richiede modifiche matching
- non richiede modifiche payload

Obiettivo:

analizzare eventuali flash residui durante digitazione / cambio schermata,
distinguendo micro-flash accettabili da regressioni UX reali.

Documenti da usare:

Core Boot:

- 00_PROJECT_State
- 00_PROJECT_Roadmap
- ultimo checkpoint rilevante

Documenti tecnici:

- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL
- 01_LOGOS_Input_System solo se emerge impatto su input_analysis_result
- 06_LOGOS_View_Preview_System solo se emerge impatto sulla Sintesi

Vincolo:

non trasformare questo nodo in cleanup globale,
refactor input_analysis_result,
decommission ui_visibility_state
o Preview Model / Hint State Consolidation.

------------------------------------------------
NODI CANDIDATI POST PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT
------------------------------------------------

1. INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION

Obiettivo:

- valutare flash residui durante digitazione/cambio schermata
- intervenire solo se fix locale, sicuro e reversibile

---

2. BUTTON CONFIRM READINESS ALIGNMENT

Obiettivo:

- distinguere visibilità bottone, abilitazione, blocchi reali e warning
- valutare eventuale lettura controllata da input_analysis_result
- mantenere payload invariato

---

3. PREVIEW MODEL / HINT STATE CONSOLIDATION

Obiettivo:

- ridurre natura ibrida della Sintesi
- consolidare preview_analysis_state
- separare hint, warning, “Da verificare” se necessario

---

4. MATCH ENGINE — MORE SPECIFIC MATCH POLICY

Obiettivo:

- decidere se warning su match più specifici resta non bloccante
- non introdurre matching avanzato senza nodo dedicato

---

5. CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION

Obiettivo:

- valutare decommission ui_visibility_state
- rimuovere guardie duplicate solo dopo stabilità documentata
- non modificare parser/matching/save flow

---

6. COMMAND INTENT — EDIT MODE GUIDANCE / GENERIC ALIAS

Obiettivo:

- migliorare guida comandi in edit mode
- valutare alias modifica/correggi/cambia
- non aprire edit flow automatici

---

7. SUGGESTION CREATE VS EDIT CONSISTENCY

Obiettivo:

- verificare differenze suggestion tra create/edit
- distinguere notice associazioni mancanti da suggestion operativa

---

8. PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE

Obiettivo:

- valutare creazione progetto anche con match generico presente
- evitare automatismi silenziosi

---

9. MATCH ENGINE EVOLUTION ADVANCED / PARTIAL AMBIGUITY

Obiettivo:

- valutare alias, fuzzy leggero, ranking o token strategy
- non introdurre deduplicazione o gerarchie senza nodo dedicato

---

10. DATA STRUCTURE / ENTITY HIERARCHY

Obiettivo:

- valutare relazioni, alias, gerarchie e deduplicazione
- preparare qualità dati prima degli output

---

11. ECONOMIC DIRECTION ADVANCED

Obiettivo:

- valutare amount firmato, direction field e regole contabili
- non attivo finché data quality non è sufficiente

---

12. DURATION ADVANCED — GIORNI / SETTIMANE

Obiettivo:

- decidere conversione giorni/settimane
- evitare conversioni automatiche ambigue

---

13. AZIONI RAPIDE OPERATIVE

Obiettivo:

- rendere operative le azioni rapide già predisposte
- evitare bypass di parser, matching, input_analysis_result o conferma utente

---

14. DASHBOARD BASE

Obiettivo:

- attivare solo dopo sufficiente consolidamento Core Event System e qualità dati

---

15. ICON SYSTEM / MOBILE POLISH FINALE

Obiettivo:

- standardizzare icone/font/spaziature senza toccare runtime
- preservare baseline 16px mobile Safari

---

16. ISTANZE / MODULI VERTICALI ASPRI / ADEXIMA / MAURIZIOLAB

Stato:

NON ATTIVO.

Regola:

le istanze verticali restano future e dipendono dal consolidamento del Core Event System.

------------------------------------------------
REGOLE OPERATIVE
------------------------------------------------

VIETATO:

- anticipare step successivi
- lavorare su più layer
- introdurre automazioni premature
- modificare architettura senza necessità
- modificare schema DB fuori nodo
- trasformare preview alignment in engine semantico
- introdurre dashboard/KPI prima dell’engine sufficiente

---

CONSENTITO:

- miglioramenti incrementali
- test reali
- iterazioni rapide
- micro-patch controllate
- aggiornamenti documentali dopo checkpoint
- verifica runtime reale prima delle modifiche

------------------------------------------------
CRITERIO DI PASSAGGIO STEP
------------------------------------------------

Uno step è considerato completato solo se:

✔ utilizzabile in modo reale  
✔ stabile anche reattivamente  
✔ senza blocchi evidenti  
✔ validato su uso concreto  
✔ documentato in checkpoint  
✔ riflesso in State/Roadmap se cambia lo stato reale  

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
- un checkpoint operativo è stato completato

---

Aggiornamento tramite:

versione progressiva

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il sistema NON deve evolvere per:

- completezza teorica
- feature non validate
- complessità non necessaria
- anticipazione di output non fondati

---

Il sistema deve evolvere per:

- uso reale
- qualità dati
- affidabilità
- progressiva normalizzazione
- stabilità runtime

---

Principio attuale:

Prima rendere i dati coerenti,
poi renderli leggibili,
poi renderli analizzabili.

---

Principio strategico confermato:

Prima consolidare il Core Event System,
poi aprire viste, moduli o istanze verticali.

LOGOS non deve diventare un gestionale verticale prematuro.
ASPRI, ADEXIMA e MaurizioLab sono istanze future del core,
non direzioni operative da anticipare ora.

------------------------------------------------
BLOCCO ATTUALE / VINCOLO DI AVANZAMENTO
------------------------------------------------

Blocco verso STEP 7 — OUTPUT:

LOGOS non può avanzare a Dashboard/KPI/reportistica finché non saranno completati o valutati:

1. Data Structure / Entity Hierarchy
2. Economic Direction Advanced
3. eventuale amount firmato / direction field
4. Duration Advanced — giorni / settimane
5. sufficienza dati reali per report iniziali
6. eventuale consolidamento Preview / Input Analysis per evitare output fuorvianti

Stato attuale:

- Core Event System funzionante
- input/parsing stabilizzati
- matching stabilizzato a primo livello
- type classification base completata
- project/entity creation controllata completata
- command intent base completato
- input_analysis_result operativo come fonte UI controllata per gli Hidden principali
- linting Retool azzerati
- documentation architecture audit completato
- fonti canoniche consolidate
- Session Boot Matrix consolidata

Residui non bloccanti ma rilevanti:

- preview ancora layer ibrido
- label “Importo” su durata risolta
- flash residui digitazione/cambio schermata
- button_input_confirm.Disabled non migrato
- save readiness completa non centralizzata
- ui_visibility_state ancora presente fisicamente
- Input Analysis Model completo non implementato
- data structure / entity hierarchy non implementata
- output / KPI / dashboard non attivi

Regola:

i residui sopra orientano i prossimi nodi,
ma non autorizzano output, dashboard, KPI o istanze verticali.

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

v04 — 2026-04-30

- completamento STEP 6.1 — ENGINE BASE / NORMALIZATION LAYER BASE
- introduzione normalizzazione amount base
- introduzione normalizzazione unit base
- supporto formato numerico italiano
- gestione numeri senza unità
- rimozione parsing legacy da button_input_confirm
- validazione insert/update con ui_state.parsed
- fix refresh lista eventi dopo update
- apertura nodo consigliato PREVIEW ALIGNMENT BASE
- definizione candidati futuri: Duration Normalization, Type Classification Base, Match Engine Unification
- confermato blocco verso OUTPUT fino a dati più coerenti

v05 — 2026-04-30

- completamento PREVIEW ALIGNMENT BASE
- formattazione italiana amount in preview
- euro visualizzato con due decimali
- grouping migliaia visuale
- unità tempo visualizzate coerentemente
- label cleaning preview aggiornato
- risolto bug "minuti" → "uti"
- separatore data/descrizione uniformato
- highlight locale reso unit-safe
- nessuna modifica a parser, DB, matching o save flow
- aggiornamento fase attiva consigliata a STEP 6.2 — DURATION NORMALIZATION
- mantenuto blocco verso OUTPUT fino a duration/type/matching

v06 — 2026-04-30

- completamento STEP 6.2 — ENGINE BASE / DURATION NORMALIZATION
- definita unità canonica durata in minuti
- amount tempo salvato come totale minuti
- unit tempo salvata come "minuti"
- raw_input preservato
- 1 ora → 60 minuti
- 1,5 ore → 90 minuti
- 1 ora e 15 minuti → 75 minuti
- 2h30 → 150 minuti
- 2 ore 30 → 150 minuti
- 90 minuti → 90 minuti
- giorni/settimane riconosciuti come ambigui ma non convertiti
- preview aggiornata con forma umana della durata
- introdotto hint “Normalizzato: X minuti”
- introdotto hint durata ambigua
- insert/update validati runtime
- regressioni euro/date/numeri semantici superate
- nessuna modifica DB
- nessuna modifica matching
- nessuna type classification
- aggiornamento fase attiva consigliata a STEP 6.3 — TYPE CLASSIFICATION BASE
- mantenuto blocco verso OUTPUT fino a type/matching/data quality

v07 — 2026-05-01

- completamento STEP 6.3 — ENGINE BASE / TYPE CLASSIFICATION BASE
- select1 allineato a ui_state.parsed.unit
- parsed.unit = minuti → Tempo
- euro + keyword controllate di uscita → Spesa
- euro + keyword controllate di entrata → Incasso
- euro senza direzione chiara → Evento
- segnali economici contrastanti → Evento
- scelta manuale utente preservata
- type aggiunto al payload di button_input_confirm
- insert_event salva events.type
- update_event aggiorna events.type
- override manuale validato su Spesa / Incasso
- reset/stale value verificato
- type persistito in DB
- nessuna modifica schema DB
- nessuna modifica parser
- nessuna modifica matching
- nessun refactor preview
- nessun output/KPI anticipato
- linting Retool residuo registrato come anomalia non bloccante
- aggiornamento fase attiva consigliata a STEP 6.4 — MATCH ENGINE UNIFICATION
- mantenuto blocco verso OUTPUT fino a matching/data quality/report readiness

v08 — 2026-05-02

- completamento STEP 6.4 — MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL
- project_state aggiornato come fonte minima matching project
- entity_state aggiornato come fonte minima matching entity
- aggiunti output matching:
  - matches
  - count
  - hasMatch
  - isAmbiguous
  - singleMatch
  - moreSpecificMatches
  - hasMoreSpecificMatches
- select_project allineato a project_state.data.singleMatch
- select_entity allineato a entity_state.data.singleMatch
- trigger_parse_debounced aggiorna parse_input_controlled + project_state + entity_state
- btn_edit aggiorna parse_input_controlled + project_state + entity_state
- match state live in create flow
- match state live in edit flow
- preview hint ambiguità allineati a isAmbiguous
- preview highlight alimentato da matches
- detection locale preview rimossa come fonte decisionale matching
- confirm guard basata su ambiguità non risolta
- ambiguità risolta manualmente non blocca salvataggio
- nessun match non blocca salvataggio
- priority match minimo implementato
- ristrutturazione bagno → Ristrutturazione Bagno
- casa mare → Casa Mare
- villa 2 → Villa 2
- hint informativo match più specifici introdotto
- bug €500 nella label preview risolto
- linting project_state/entity_state ripuliti
- linting residui edit_mode/editing_event mantenuti come nodo futuro
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica type classification
- nessuna modifica duration normalization
- nessun output/KPI anticipato
- aggiornamento fase attiva consigliata a NEXT NODE da definire dopo aggiornamento documentale
- mantenuto blocco verso OUTPUT fino a data structure / economic direction / report readiness

v09 — 2026-05-02

- completamento UX / CLEANUP MICRO-BATCH POST MATCH ENGINE
- aggiunto pulsante Annulla in edit mode
- Annulla modifica senza update_event
- reset edit_mode / editing_event / input / select / ui_state.parsed
- fix doppia visibilità input/lista dopo Annulla
- aggiunta barra ricerca lista eventi
- filtro client-side su eventi NEW
- ricerca su raw_input / type / status / project / entity
- corretta label creato/modificato nella lista eventi
- normalizzazione robusta created_at / updated_at
- marcatore leggero per eventi modificati
- aggiunto no-op edit guard in button_input_confirm
- edit senza modifiche reali non aggiorna updated_at
- fix UI state per nuovo input da lista eventi
- create flow validato
- edit flow validato
- annulla modifica validato
- search/filter lista validato
- WRITTEN / ERROR validati
- regressione match/type/duration validata
- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- linting edit_mode/editing_event ancora residui non bloccanti
- aggiornamento fase attiva consigliata a NEXT NODE da definire dopo chiusura aggiornamento documentale minimo
- mantenuto blocco verso OUTPUT fino a data structure / economic direction / report readiness

v10 — 2026-05-03

- completamento LINTING / STATE HELPER CLEANUP
- risolto linting Retool edit_mode: 'value' is not defined
- risolto linting Retool editing_event: 'value' is not defined
- rimossa dipendenza da additionalScope { value } per edit_mode / editing_event
- introdotto passaggio controllato tramite window.__logos_edit_mode_value
- introdotto passaggio controllato tramite window.__logos_editing_event_value
- edit_mode ora legge valore tecnico da window.__logos_edit_mode_value
- editing_event ora legge valore tecnico da window.__logos_editing_event_value
- gli helper cancellano la chiave window dopo la lettura
- aggiornato btn_edit
- aggiornato btn_cancel_edit
- aggiornato button_input_confirm nel ramo no-op edit guard
- aggiornato button_input_confirm nel reset finale dopo salvataggio reale
- editing_event azzerato anche dopo update reale completato
- create flow validato
- edit flow validato
- annulla modifica validato
- edit senza modifiche reali validato
- edit con modifica reale validato
- updated_at / label creato-modificato validati
- WRITTEN / ERROR validati
- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- preview invariata
- lista eventi invariata
- nessun output/KPI anticipato
- aggiornamento fase attiva consigliata a NEXT NODE POST LINTING CLEANUP DA DEFINIRE
- mantenuto blocco verso OUTPUT fino a project/entity create suggestion / data structure / economic direction / report readiness

v11 — 2026-05-07

- completamento PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
- introdotto create_suggestion_state
- introdotte variabili project_create_inline_open / project_create_suggestion_dismissed
- introdotte variabili entity_create_inline_open / entity_create_suggestion_dismissed
- introdotte query insert_project / insert_entity
- introdotto container suggestion inline
- introdotti micro-editor project/entity
- introdotto bottone Ignora globale
- introdotti bottoni Annulla contestuali
- creazione project inline validata su DB reale
- creazione entity inline validata su DB reale
- select_project valorizzata dopo creazione project
- select_entity valorizzata dopo creazione entity
- evento non salvato automaticamente dopo creazione project/entity
- evento salvato manualmente con project_id/entity_id corretti
- project/entity mancanti non bloccano salvataggio
- project/entity ambigui bloccano salvataggio finché non risolti manualmente
- entity autofill controlled minimal implementato
- flow combinato project + entity validato
- no-match generico salvabile validato
- edit/no-op non regressivo validato
- command intent registrato come nodo futuro
- UX cleanup suggestion container registrato come nodo futuro
- direzione LOGOS Core modulare riconfermata
- istanze ASPRI / ADEXIMA / MaurizioLab confermate come derivate future del core
- aggiornamento fase attiva consigliata a NEXT NODE POST PROJECT / ENTITY CREATE SUGGESTION DA DEFINIRE
- mantenuto blocco verso OUTPUT fino a data structure / economic direction / report readiness

v12 — 2026-05-09

- completamento UX MOBILE COHERENCE PASS
- Home mobile rifinita
- card Esempi resa coerente
- Azioni rapide rifinite e predisposte
- Events list mobile rifinita
- Feedback mobile stabilizzato
- feedback_summary introdotto in ui_state
- handle_event_success disabilitato come gestore UI post-save
- success handler UI rimossi da insert_event / update_event
- button_input_confirm centralizza feedback e routing post-save
- insert reale → feedback 1800 ms → Home
- update reale → feedback 1800 ms → Lista eventi
- no-op edit → Lista eventi immediata senza update_event
- cancel create/input → Home
- cancel edit → Lista eventi
- Navigation dock Home / Eventi / Dashboard introdotta
- Dashboard presente ma disabilitata
- nav contestuale visibile in Home vuota e Events list
- nav nascosta durante input attivo e feedback
- Dati evento compattati con label inline nelle select
- Icon add-ons Retool introdotti nei pulsanti reali
- font-size input/select portato a 16px per Safari iOS
- zoom automatico iOS Safari risolto
- select mobile validate sia in digitazione sia in dropdown
- validazione reale su iPhone 13 Safari completata
- UX cleanup suggestion container non è più candidato immediato
- Command Intent / Data Structure / Economic Direction restano candidati principali
- Dashboard resta non attiva nonostante predisposizione in nav
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato
- aggiornamento fase attiva consigliata a NEXT NODE POST UX MOBILE COHERENCE PASS DA DEFINIRE

v13 — 2026-05-13

- completamento COMMAND INTENT — CREATE PROJECT / ENTITY
- introdotto command_intent_state come query Retool page-level
- gestito comando generico “crea”
- gestito create project incompleto
- gestito create project completo
- gestito create entity incompleto
- gestito create entity completo
- gestiti sinonimi base crea / aggiungi / inserisci / nuovo / nuova
- comandi puri esclusi dal salvataggio evento
- container_command_intent introdotto dentro container_input
- UI mobile Command Intent rifinita
- btn_command_create_project collegato a insert_project esistente
- btn_command_create_entity collegato a insert_entity esistente
- btn_command_go_events collegato alla lista eventi
- elementi già presenti riconosciuti e non duplicati
- “crea progetto villa” validato come elemento già presente
- “modifica evento” gestito come guida non operativa
- nessun edit flow alternativo introdotto
- feedback_mode introdotto in ui_state
- feedback project_created implementato
- feedback entity_created implementato
- feedback evento ordinario preservato
- feedback_resume adattato a Evento / Progetto / Entità
- ritorno Home automatico dopo feedback project/entity validato
- evento normale non regressivo validato
- edit evento reale non regressivo validato
- edit no-op / annulla modifica non regressivi validati
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato
- roadmap aggiornata post Command Intent
- Command Intent rimosso dai candidati futuri immediati
- aggiunti candidati INPUT RENDERING STABILITY / CONTAINER STRUCTURE
- aggiunto candidato INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER
- PREVIEW MODEL / HINT STATE CONSOLIDATION promosso tra candidati principali
- confermato blocco verso OUTPUT fino a data structure / economic direction / report readiness

v14 — 2026-05-18

- completamento UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
- integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- introdotto ui_visibility_state come Transformer read-only
- introdotto ui_visibility_mode come Variable Retool
- ui_visibility_mode supporta empty / event / command
- trigger_parse_debounced aggiorna ui_visibility_mode
- introdotto window.__logos_visibility_run_id per evitare update stale da debounce
- classificazione locale event/command usata solo per visibilità UI
- ui_visibility_state non sostituisce parser, matching, command_intent_state o create_suggestion_state
- Hidden principali centralizzati:
  - container_command_intent
  - sintesi
  - container_association_suggestions
  - text_event_data_title
  - select1
  - select_project
  - select_entity
  - button_input_confirm
  - btn_cancel_edit
  - btn_cancel_input_home
  - container_input
- container_input stabilizzato tramite ui_visibility_state.isInputFlow
- container vuoto durante digitazione risolto
- flash input flow ridotto
- container_app_nav corretto usando input_home.value al posto di input_raw.value
- bottom bar flash risolto
- text_input_analysis_loading introdotto vicino all’input principale
- text_edit_mode_notice introdotto per chiarire edit mode
- edit mode prevale su command intent
- durante edit mode scrivere “crea” non apre Command Intent
- btn_command_create_project / btn_command_create_entity allineati nel timing del feedback
- feedback project/entity funzionante con micro-flash residuo
- test obbligatori 1–16 superati
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- command_intent_state invariato
- preview content invariato
- button_input_confirm payload invariato
- insert_event / update_event invariati
- insert_project / insert_entity invariati
- Input Analysis Model completo non implementato
- Event Interpretation Engine non implementato
- residuo “modifica” generico non riconosciuto come guida edit documentato
- residuo micro-flash feedback project/entity documentato
- 5 linting Retool residui documentati
- INPUT RENDERING STABILITY / CONTAINER STRUCTURE rimosso dai candidati principali perché completato a primo livello tramite UI Readiness
- aggiunti candidati:
  - COMMAND INTENT — EDIT GUIDE GENERIC ALIAS
  - FEEDBACK MICRO-FLASH CLEANUP
  - LINTING / MINOR CLEANUP
  - CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION
- Dashboard resta non attiva
- istanze verticali restano non attive
- blocco verso OUTPUT confermato

v15 — 2026-05-20

- completamento PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
- introdotto preview_analysis_state come Transformer read-only
- preview_analysis_state raccoglie hint / warning / status / Da verificare / associazioni mancanti della Sintesi
- Sintesi aggiornata per leggere hint/status/missing association da preview_analysis_state
- layout Sintesi preservato
- UX mobile preservata
- DB invariato
- parser invariato
- matching invariato
- save flow invariato

- completamento INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
- introdotto input_analysis_result come layer compositivo read-only
- input_analysis_result aggrega input / parsed / type / project / entity / suggestion / command / preview / readiness
- introdotta distinzione raw / selection / effective
- edit mode prevale su command intent
- command raw e command effective distinti
- project/entity raw match distinti da project/entity effective
- input_analysis_result non sostituisce matching, parser, select, suggestion, command o save flow

- completamento INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS
- input_analysis_result diventato fonte UI controllata parziale
- migrato sintesi.Hidden a input_analysis_result
- migrati text_event_data_title / select1 / select_project / select_entity Hidden a input_analysis_result
- migrato container_command_intent.Hidden a input_analysis_result
- migrato container_association_suggestions.Hidden a input_analysis_result
- micro-copy notice associazioni mancanti allineato alla presenza reale dei suggerimenti
- bug edit mode + input vuoto corretto
- Home idle container nascosti correttamente durante edit mode
- Dati evento / Sintesi / Conferma nascosti con edit input vuoto
- solo Annulla modifica resta visibile in edit input vuoto
- ui_visibility_state resta operativo e non deprecato
- container_input / loading / cancel / confirm restano fuori dalla migrazione corrente
- button_input_confirm payload invariato
- insert_event / update_event invariati
- select value/default logic invariata
- create_suggestion_state invariato
- command_intent_state invariato
- DB invariato
- linting Retool attuali saliti a 19 e registrati come debito tecnico
- prossimo nodo consigliato: INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
- nodo tecnico consigliato: LINTING / RETOOL QUERY SAFETY PASS
- Dashboard resta non attiva
- istanze verticali restano non attive
- blocco verso OUTPUT confermato

v16 — 2026-05-23

- completamento INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
- container_input.Hidden migrato a input_analysis_result.mode.effectiveIsInputFlow
- text_input_analysis_loading.Hidden migrato a input_analysis_result
- btn_cancel_edit.Hidden migrato a input_analysis_result
- btn_cancel_input_home.Hidden migrato a input_analysis_result
- introdotto canShowConfirm come flag visibility-only
- button_input_confirm.Hidden migrato a input_analysis_result.readiness.canShowConfirm
- button_input_confirm.Disabled invariato
- button_input_confirm payload invariato
- rimossa dipendenza input_analysis_result → ui_visibility_state
- input_analysis_result non legge più ui_visibility_state
- nessun loop tra ui_visibility_state e input_analysis_result
- ui_visibility_mode confermato come latch leggero empty / event / command
- ui_visibility_state mantenuto come residuo tecnico deprecabile
- routing principale container_home / container_feedback / container_events_list confermato su ui_state.view
- test visibility migration superati su evento, command, edit, suggestion, confirm

- completamento LINTING / RETOOL QUERY SAFETY PASS
- linting Retool azzerati
- risolti misleading line break before "?" in input_analysis_result / preview_analysis_state / create_suggestion_state / command_intent_state
- sostituiti ternari multilinea ambigui con if / else
- eliminata query legacy typing_state
- eliminata query legacy handle_event_success
- Performance unused query risolta
- test post-rimozione query superati
- DB invariato
- parser invariato
- matching invariato
- command intent invariato nella logica funzionale
- suggestion invariata nella logica funzionale
- save flow invariato
- payload invariato
- flash residui digitazione/cambio schermata documentati come nodo futuro
- label “Importo” su durata documentata come nodo futuro
- policy match più specifici documentata come nodo futuro
- prossimo nodo candidato prioritario: DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION

v17 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicato Pacchetto B — Core Governance su 00_PROJECT_Roadmap
- Roadmap aggiornata da v16 a v17
- fase attiva aggiornata a DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION — IN CORSO
- documentato Pacchetto A come allineato, non ridotto
- documentato Pacchetto B come in corso
- ridotta duplicazione tecnica lunga nella Roadmap
- sostituito ROADMAP MASTER esteso con ROADMAP MASTER — SINTESI OPERATIVA
- mantenuti step completati con stato, risultato e fonte canonica
- ridotti dettagli implementativi già coperti dai documenti canonici
- aggiornata sezione NODO ATTIVO
- aggiornata sezione NODI CANDIDATI POST DOCUMENTATION AUDIT
- ridotto BLOCCO ATTUALE / VINCOLO DI AVANZAMENTO
- confermato blocco verso STEP 7 — OUTPUT
- confermato divieto di anticipare Dashboard/KPI/reportistica/istanze verticali
- aggiunti richiami canonici a:
  - 01_LOGOS_Input_System
  - 02_LOGOS_Match_Engine
  - 03_LOGOS_Event_Lifecycle
  - 04_LOGOS_Retool_Architecture
  - 05_LOGOS_Database_Schema
  - 06_LOGOS_View_Preview_System
  - LOGOS_RETOOL_RUNTIME_REAL
  - LOGOS_SUPABASE_RUNTIME_REAL
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica payload
- nessuna anticipazione output / KPI / dashboard

v18 — 2026-05-25

- aggiornamento finale post DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- Roadmap aggiornata da v17 a v18
- nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION registrato come COMPLETATO
- registrato completamento Pacchetto A — Allineamento alto / Lifecycle / Supabase
- registrato completamento Pacchetto B — Core Governance
- registrato completamento Pacchetto C — Documenti tecnici canonici
- registrato completamento Pacchetto D — LOGOS_RETOOL_RUNTIME_REAL / Runtime Manifest Normalization
- registrato aggiornamento 00_PROJECT_KERNEL_MANIFEST a v03
- registrato completamento controllo finale / stress test documentale
- confermato Principio Fonti Canoniche
- confermata Session Boot Matrix
- confermata regola aggiornamenti futuri
- rimossa DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION dai nodi candidati attivi
- aggiornata transizione verso PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT come prossimo nodo operativo consigliato
- chiarito che il prossimo nodo deve restare micro-nodo UX/semantico
- confermato blocco verso STEP 7 — OUTPUT
- confermato divieto di anticipare Dashboard/KPI/reportistica/istanze verticali
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica payload
- nessuna anticipazione output / KPI / dashboard

v19 — 2026-05-26

- aggiornamento post PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT
- Roadmap aggiornata da v18 a v19
- nodo PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT registrato come COMPLETATO
- G36 registrato come integrato
- rimossa PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT dai nodi candidati attivi
- registrata risoluzione della label “Importo” su durata
- registrata riga valore Sintesi semanticamente allineata:
  - euro → Importo
  - ore / minuti → Durata
  - fallback non riconosciuto → Valore
- confermato che la modifica è solo visuale / micro-copy
- confermato parser invariato
- confermata duration normalization invariata
- confermata type classification invariata
- confermato matching invariato
- confermato input_analysis_result invariato
- confermato preview_analysis_state invariato
- confermato button_input_confirm invariato
- confermato payload invariato
- confermato save flow invariato
- confermato DB invariato
- aggiornato prossimo nodo operativo consigliato a INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION
- confermato che il prossimo nodo deve restare micro-nodo UX / visibility
- nessuna anticipazione Button Confirm Readiness Alignment
- nessuna anticipazione Preview Model / Hint State Consolidation
- nessuna anticipazione cleanup ui_visibility_state
- nessuna anticipazione output / KPI / dashboard