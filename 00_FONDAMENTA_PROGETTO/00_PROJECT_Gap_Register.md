# 00_PROJECT_Gap_Register_v16

DATA: 2026-05-26

------------------------------------------------
SCOPO
------------------------------------------------

Tracciare i gap strutturali, funzionali, UX e documentali emersi durante audit,
sviluppo reale e sessioni operative LOGOS.

Il Gap Register serve a:

- conservare debiti e nodi futuri
- distinguere gap integrati da gap aperti
- impedire perdita di elementi strategici
- evitare apertura di nodi non prioritari
- mantenere ordine tra backlog, roadmap e stato reale
- supportare la Roadmap senza duplicarla

Il documento NON deve diventare:

- diario operativo completo
- duplicato dello State
- duplicato della Roadmap
- duplicato dei documenti tecnici canonici
- raccolta completa dei test già consolidati altrove

Regola:

il Gap Register registra il gap, lo stato, la priorità e l’azione futura.

Il dettaglio tecnico completo resta nei documenti canonici:

- 01_LOGOS_Input_System per input / parser / command / input_analysis_result
- 02_LOGOS_Match_Engine per matching project/entity
- 03_LOGOS_Event_Lifecycle per lifecycle evento
- 04_LOGOS_Retool_Architecture per componenti/query/Hidden/wiring Retool
- 05_LOGOS_Database_Schema per schema DB
- 06_LOGOS_View_Preview_System per Sintesi / preview / hint / warning
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
- LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase as-is

------------------------------------------------
STATO GAP
------------------------------------------------

Ogni gap può essere:

- IDENTIFICATO
- IN OSSERVAZIONE
- VALIDATO
- INTEGRATO PARZIALE
- INTEGRATO
- INTEGRATO BASE
- SCARTATO
- NON PRIORITARIO

------------------------------------------------
GAP REGISTER — SINTESI CONTROLLATA
------------------------------------------------

Il dettaglio storico/implementativo dei gap integrati non viene duplicato qui.

Questo registro mantiene:

- ID gap
- stato
- significato operativo
- azione futura
- fonte canonica per il dettaglio completo

------------------------------------------------
GAP ATTIVO DEL NODO CORRENTE
------------------------------------------------

Nessun gap attivo del nodo corrente.

Il nodo PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT è completato.

G36 è stato integrato come micro-correzione UX / semantica della Sintesi.

Prossimo gap operativo consigliato:

ID: G29

NOME:
Feedback / Input Flow Micro-flash Cleanup

Motivo:

- residuo UX minore già identificato
- candidato successivo coerente con State / Roadmap
- intervento da aprire solo se riproducibile in modo chiaro
- scope limitato a visibility/timing UI
- non deve modificare parser, DB, save flow, matching o payload

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

------------------------------------------------
GAP RESIDUI PRIORITARI
------------------------------------------------

ID: G29

NOME:
Feedback / Input Flow Micro-flash Cleanup

STATO:
IDENTIFICATO — RESIDUO MINORE

DESCRIZIONE:

Persistono micro-flash visivi in feedback project/entity e transizioni input/cambio schermata.

Azione:

aprire solo se il flash diventa fastidioso o riproducibile in modo chiaro.

Vincoli:

- non inseguire micro-flash senza identificazione precisa
- non modificare save flow
- non modificare insert/update
- intervenire solo su timing/visibility UI

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

ID: G33

NOME:
Button Confirm Readiness Alignment

STATO:
INTEGRATO PARZIALE — HIDDEN MIGRATO / DISABLED NON MIGRATO

DESCRIZIONE:

button_input_confirm.Hidden è migrato a input_analysis_result.
button_input_confirm.Disabled e payload restano separati.

Azione:

eventuale nodo dedicato per readiness funzionale / Disabled.

Vincoli:

- distinguere Hidden da Disabled
- non modificare payload
- non modificare insert_event / update_event
- non modificare parser/matching/select
- testare create/edit/no-op/command/ambiguity/empty input

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

ID: G17

NOME:
Preview Model / Hint State Consolidation

STATO:
IN OSSERVAZIONE — CANDIDATO POST INPUT ANALYSIS RESULT

DESCRIZIONE:

La Sintesi resta layer ibrido:

- rendering
- label cleaning
- highlight
- micro-copy
- hint/warning/status
- blocco “Da verificare”

preview_analysis_state ha ridotto parte della logica embedded,
ma non ha trasformato la Sintesi in view pura.

Azione:

valutare nodo dedicato solo dopo chiusura audit documentale o se emerge problema UX prioritario.

Fonte canonica:
- 06_LOGOS_View_Preview_System

---

ID: G35

NOME:
Status Semantics Alignment

STATO:
IDENTIFICATO — RESIDUO UX/SEMANTICO

DESCRIZIONE:

In alcuni casi la Sintesi può mostrare status OK insieme a card “Da verificare”.

Azione:

da trattare dentro Preview Model / Hint State Consolidation o nodo dedicato.

Vincoli:

- non trasformare warning non bloccanti in blocchi
- non modificare save flow
- preservare chiarezza utente

Fonte canonica:
- 06_LOGOS_View_Preview_System

---

ID: G30

NOME:
Command Intent — Edit Guide Generic Alias

STATO:
IDENTIFICATO — MICRO-NODO FUTURO

DESCRIZIONE:

Il sistema riconosce “modifica evento” come guida non operativa,
ma non riconosce ancora alias generici controllati:

- modifica
- correggi
- cambia

Azione:

valutare micro-nodo dedicato.

Vincoli:

- evitare falsi positivi
- non aprire edit flow automatici
- non modificare record
- non salvare eventi da comando generico

Fonte canonica:
- 01_LOGOS_Input_System
- 03_LOGOS_Event_Lifecycle

---

ID: G21

NOME:
Suggestion Create vs Edit Consistency

STATO:
IDENTIFICATO

DESCRIZIONE:

Possibile divergenza tra suggestion mostrate in create flow e suggestion mostrate in edit flow.

Azione:

verificare in nodo dedicato con casi riproducibili.

Vincoli:

- non modificare DB
- non modificare parser
- non introdurre creazioni automatiche
- preservare select_project / select_entity come decisione utente

Fonte canonica:
- 01_LOGOS_Input_System
- 02_LOGOS_Match_Engine
- 04_LOGOS_Retool_Architecture

---

ID: G22

NOME:
Project Create Suggestion — Match Present / User Override

STATO:
IDENTIFICATO

DESCRIZIONE:

In presenza di match generico esistente, il sistema non propone creazione nuovo progetto.

Esempio:

input “villa”
→ match Villa
→ hint progetti più specifici
→ nessuna opzione “crea comunque nuovo progetto”

Azione:

valutare opzione esplicita di override utente.

Vincoli:

- evitare duplicati
- nessuna creazione automatica
- conferma forte se implementato

Fonte canonica:
- 02_LOGOS_Match_Engine
- 01_LOGOS_Input_System

---

ID: G32

NOME:
Cleanup Obsolete UI Guards / Query Reduction

STATO:
IDENTIFICATO — CLEANUP FUTURO

DESCRIZIONE:

Dopo input_analysis_result e Visibility Migration Completion,
alcune guardie/query legacy possono essere obsolete.

Azione:

valutare solo dopo stabilità documentata e cleanup dedicato.

Vincoli:

- procedere uno alla volta
- test dopo ogni micro-rimozione
- non modificare parser/matching/save flow/DB
- non eliminare ui_visibility_state fuori nodo dedicato

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

ID: G34

NOME:
UI Visibility State Decommission / Wrapper Reduction

STATO:
IDENTIFICATO — RESIDUO TECNICO POST VISIBILITY MIGRATION

DESCRIZIONE:

ui_visibility_state non è più letto da input_analysis_result
e non governa più gli Hidden principali migrati,
ma resta fisicamente presente come residuo tecnico / rollback.

Azione:

decommission solo in nodo dedicato.

Possibili esiti futuri:

1. eliminazione
2. archiviazione come riferimento storico
3. mantenimento temporaneo come rollback tecnico

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

------------------------------------------------
GAP STRUTTURALI FUTURI
------------------------------------------------

ID: G11

NOME:
Data Structure / Entity Hierarchy

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Strutturazione futura di:

- relazioni entity-project
- parent_project_id / parent_entity_id
- alias
- deduplicazione
- gerarchie project/entity
- relazioni persona/azienda/fornitore/cliente/animale/progetto

Azione:

da valutare prima di output/KPI avanzati e prima di istanze verticali.

Fonte canonica:
- 02_LOGOS_Match_Engine
- 05_LOGOS_Database_Schema
- 00_PROJECT_Roadmap

---

ID: G13

NOME:
Economic Direction Advanced

STATO:
IDENTIFICATO

DESCRIZIONE:

Gestione avanzata della direzione economica.

Attualmente:

- type Spesa / Incasso è persistito
- amount resta positivo
- nessun direction field
- nessun amount firmato
- nessun report economico attivo

Azione:

da valutare dopo data quality/matching/data structure e prima di KPI economici.

Fonte canonica:
- 01_LOGOS_Input_System
- 05_LOGOS_Database_Schema
- 00_PROJECT_Roadmap

---

ID: G08A

NOME:
Duration Advanced — giorni / settimane

STATO:
IDENTIFICATO COME SOTTO-GAP FUTURO

DESCRIZIONE:

Ore/minuti sono normalizzati in minuti.
Giorni/settimane restano ambigui e non convertiti automaticamente.

Azione:

valutare solo in nodo dedicato.

Vincoli:

- evitare conversioni automatiche ambigue
- preservare duration normalization ore/minuti già stabile

Fonte canonica:
- 01_LOGOS_Input_System
- 06_LOGOS_View_Preview_System

---

ID: G10A

NOME:
Match Engine Evolution Advanced / Partial Ambiguity

STATO:
IDENTIFICATO COME SOTTO-GAP FUTURO

DESCRIZIONE:

Evoluzione futura del matching:

- alias
- fuzzy leggero
- ranking avanzato
- ambiguità parziale
- confidence
- filtering select su ambiguità

Azione:

non introdurre senza nodo dedicato.

Fonte canonica:
- 02_LOGOS_Match_Engine

---

ID: G04

NOME:
Logging System / Versioning

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Sistema futuro di log, revisioni, errori, audit trail e rollback.

Azione:

non prioritario ora.
Da rivalutare se emerge bisogno reale di audit modifiche o rollback.

Fonte canonica:
- 03_LOGOS_Event_Lifecycle
- 05_LOGOS_Database_Schema
- LOGOS_SUPABASE_RUNTIME_REAL

---

ID: G05

NOME:
Input Modes — Libero vs Guidato

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Possibile doppia modalità futura:

- input libero
- form guidato

Azione:

non prioritario.
Da rivalutare dopo Command Intent, Input Analysis, Data Structure e Azioni Rapide.

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture

---

ID: G06

NOME:
Multi-source Input

STATO:
NON PRIORITARIO

DESCRIZIONE:

Input da API, voice, Siri, import o automazioni esterne.

Azione:

non lavorare ora.
Da rivalutare solo dopo input system maturo, engine più completo e sicurezza API valutata.

Fonte canonica:
- 01_LOGOS_Input_System
- 00_PROJECT_Roadmap

------------------------------------------------
GAP UX / MODULI FUTURI
------------------------------------------------

ID: G23

NOME:
Azioni Rapide Operative

STATO:
VALIDATO — NODO FUTURO

DESCRIZIONE:

La Home contiene azioni rapide predisposte ma non operative:

- Registra spesa
- Registra incasso
- Registra tempo
- Registra evento

Azione:

renderle operative solo in nodo dedicato,
senza bypassare input_analysis_result, parser, matching o conferma utente.

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- 01_LOGOS_Input_System

---

ID: G24

NOME:
Dashboard Base

STATO:
VALIDATO — NODO FUTURO NON IMMEDIATO

DESCRIZIONE:

Dashboard presente in Navigation dock ma disabilitata.

Azione:

attivare solo dopo consolidamento Core Event System e qualità dati sufficiente.

Fonte canonica:
- 00_PROJECT_Roadmap
- 05_LOGOS_Database_Schema

---

ID: G25

NOME:
Icon System / Mobile Polish Finale

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Sistema icone misto:

- Icon add-ons Retool nei componenti reali
- emoji/HTML in Sintesi e Feedback

Azione:

rivalutare solo in polish finale.

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- 06_LOGOS_View_Preview_System

---

ID: G20

NOME:
Core Event System / Modular Instances

STATO:
VALIDATO — VINCOLO STRATEGICO

DESCRIZIONE:

LOGOS resta Core Event System modulare.
ASPRI / ADEXIMA / MaurizioLab sono istanze future,
non nodi operativi da anticipare.

Azione:

mantenere vincolo anti-deriva.

Divieto:

non aprire dashboard ASPRI, CRM ADEXIMA, gestione MaurizioLab o moduli verticali
prima del consolidamento Core Event System.

Fonte canonica:
- 00_PROJECT_Roadmap
- 00_PROJECT_State

---

ID: G26

NOME:
Mobile Safari Font Baseline

STATO:
INTEGRATO COME REGOLA TECNICA

DESCRIZIONE:

Input/select mobile Safari devono mantenere font-size minimo 16px per evitare zoom automatico iOS.

Azione:

non riaprire salvo regressioni reali.
Da ricordare nel polish finale.

Fonte canonica:
- 04_LOGOS_Retool_Architecture

------------------------------------------------
GAP INTEGRATI / ARCHIVIO COMPATTO
------------------------------------------------

I gap seguenti sono integrati o integrati a livello base.

Non devono essere riaperti come nodo base.
Eventuali evoluzioni devono diventare sotto-gap o nodi dedicati.

G36 — Preview / Event Data Label Semantic Alignment
STATO: INTEGRATO

Fonte canonica:
- 06_LOGOS_View_Preview_System per comportamento visuale della Sintesi, label valore e micro-copy.
- LOGOS_RETOOL_RUNTIME_REAL per runtime reale Retool as-is.

Esito:

- risolto residuo semantico label “Importo” su valori durata
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

Regola:

G36 non deve essere riaperto come nodo base.
Eventuali evoluzioni future della Sintesi devono confluire in G17 Preview Model / Hint State Consolidation o in gap specifici.

G37 — Documentation Architecture Audit / Redundancy Reduction
STATO: COMPLETATO / INTEGRATO COME REGOLA DOCUMENTALE
Fonte canonica:
- 00_PROJECT_KERNEL_MANIFEST per Principio Fonti Canoniche e Session Boot Matrix
- CHECKPOINT — DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION per esito finale del nodo
- 00_PROJECT_State per stato post-audit
- 00_PROJECT_Roadmap per sequenza post-audit

Esito:

- fonti canoniche definite
- documenti core alleggeriti
- documenti tecnici canonici preservati
- runtime manifest normalizzati
- Kernel Manifest aggiornato
- Session Boot Matrix consolidata
- regola aggiornamenti futuri consolidata
- stress test documentale finale completato
- checkpoint finale prodotto

Regola:

G37 non deve essere riaperto come nodo documentale generico.
Eventuali futuri interventi documentali devono essere aperti solo se emerge un problema reale di ridondanza, perdita ricostruibilità o incoerenza tra fonti canoniche.


G01 — Normalization Model
STATO: INTEGRATO PARZIALE
Fonte canonica: 01_LOGOS_Input_System

G02 — Processor / Engine Flow
STATO: VALIDATO / PARZIALMENTE AVVIATO
Fonte canonica: 01_LOGOS_Input_System, 04_LOGOS_Retool_Architecture, LOGOS_RETOOL_RUNTIME_REAL

G03 — Project / Entity Create Suggestion
STATO: INTEGRATO BASE
Fonte canonica: 01_LOGOS_Input_System, 02_LOGOS_Match_Engine, 04_LOGOS_Retool_Architecture, 05_LOGOS_Database_Schema

G07 — Preview Alignment
STATO: INTEGRATO
Fonte canonica: 06_LOGOS_View_Preview_System

G08 — Duration Normalization Base
STATO: INTEGRATO BASE
Fonte canonica: 01_LOGOS_Input_System

G09 — Type Classification Base
STATO: INTEGRATO BASE
Fonte canonica: 01_LOGOS_Input_System, 05_LOGOS_Database_Schema

G10 — Match Engine Unification
STATO: INTEGRATO BASE
Fonte canonica: 02_LOGOS_Match_Engine

G12 — Events List Label / Updated At Display
STATO: INTEGRATO
Fonte canonica: 03_LOGOS_Event_Lifecycle, 04_LOGOS_Retool_Architecture

G14 — Linting / State Helper Cleanup
STATO: INTEGRATO
Fonte canonica: 04_LOGOS_Retool_Architecture, LOGOS_RETOOL_RUNTIME_REAL

G15 — Edit Mode Cancel / Return to Events List
STATO: INTEGRATO
Fonte canonica: 03_LOGOS_Event_Lifecycle, 04_LOGOS_Retool_Architecture

G16 — Events List Search / Filter Bar
STATO: INTEGRATO
Fonte canonica: 04_LOGOS_Retool_Architecture

G18 — UX Mobile Coherence Pass
STATO: INTEGRATO BASE
Fonte canonica: 04_LOGOS_Retool_Architecture, 06_LOGOS_View_Preview_System

G19 — Command Intent — Create Project / Entity
STATO: INTEGRATO BASE
Fonte canonica: 01_LOGOS_Input_System, 03_LOGOS_Event_Lifecycle, 04_LOGOS_Retool_Architecture

G27 — Input Rendering Stability / Container Structure
STATO: INTEGRATO BASE / EVOLUTO IN INPUT ANALYSIS RESULT
Fonte canonica: 01_LOGOS_Input_System, 04_LOGOS_Retool_Architecture

G28 — Input Analysis Result / Single Interpretation Layer
STATO: INTEGRATO PARZIALE — VISIBILITY MIGRATION COMPLETION
Fonte canonica: 01_LOGOS_Input_System, 04_LOGOS_Retool_Architecture

G31 — Linting / Retool Query Safety Pass
STATO: INTEGRATO
Fonte canonica: 04_LOGOS_Retool_Architecture, LOGOS_RETOOL_RUNTIME_REAL

------------------------------------------------
ORDINE CONSIGLIATO GAP / NODI
------------------------------------------------

Ordine attuale consigliato post Preview / Event Data Label Semantic Alignment:

1. G29 — Input Flow / Transition Micro-flash Stabilization
2. G33 — Button Confirm Readiness Alignment
3. G17 — Preview Model / Hint State Consolidation
4. G35 — Status Semantics Alignment
5. G30 — Command Intent — Edit Guide Generic Alias
6. G21 — Suggestion Create vs Edit Consistency
7. G22 — Project Create Suggestion — Match Present / User Override
8. G10A — Match Engine Evolution Advanced / Partial Ambiguity
9.  G11 — Data Structure / Entity Hierarchy
10. G13 — Economic Direction Advanced
11. G08A — Duration Advanced / Giorni-Settimane
12. G32 / G34 — Cleanup Obsolete UI Guards / ui_visibility_state Decommission
13. G23 — Azioni Rapide Operative
14. G24 — Dashboard Base
15. G04 — Logging / Versioning
16. G05 — Input Modes
17. G06 — Multi-source Input

Vincoli strategici permanenti:

- G20 — Core Event System / Modular Instances
- G26 — Mobile Safari Font Baseline

Nota:

G37 — Documentation Architecture Audit / Redundancy Reduction è completato
e non resta nodo candidato attivo.

Le regole documentali permanenti sono ora nel Kernel Manifest.
Il checkpoint finale del nodo resta riferimento storico-operativo,
ma i checkpoint non devono essere l’unica fonte di regole permanenti.

Nota:

G36 — Preview / Event Data Label Semantic Alignment è completato
e non resta nodo candidato attivo.

Il residuo label “Importo” su durata è stato risolto.
La Sintesi resta comunque layer ibrido: eventuali interventi più ampi restano nel perimetro di G17.

------------------------------------------------
REGOLA GAP REGISTER
------------------------------------------------

Un gap diventa nodo operativo solo se:

✔ necessario nello sviluppo reale
✔ validato su uso concreto
✔ non sostituibile da soluzione più semplice
✔ utile al nodo operativo imminente
✔ coerente con State e Roadmap

Un gap NON diventa nodo operativo se:

- anticipa la roadmap
- richiede refactor globale
- introduce complessità non validata
- non è necessario al problema immediato
- crea rischio di regressione su runtime stabile

CHANGELOG

v01 — 2026-04-01

Creazione Gap Register
Consolidamento gap da audit + gap analysis
Introduzione sistema di validazione progressiva

v02 — 2026-04-30

aggiornato G01 Normalization Model a INTEGRATO PARZIALE
aggiornato G02 Processor / Engine Flow a VALIDATO / PARZIALMENTE AVVIATO
aggiunti gap G07 Preview Alignment
aggiunto gap G08 Duration Normalization
aggiunto gap G09 Type Classification Base
aggiunto gap G10 Match Engine Unification
aggiunto gap G11 Data Structure / Entity Hierarchy
classificato G06 Multi-source Input come NON PRIORITARIO
aggiornato ordine consigliato gap/nodi
allineamento con State v10 e Roadmap v04

v03 — 2026-04-30

aggiornato G07 Preview Alignment a INTEGRATO
aggiornato G08 Duration Normalization a INTEGRATO BASE
documentata unità canonica tempo = minuti
documentata normalizzazione durate certe ore/minuti
documentato raw_input preservato
documentato che giorni/settimane restano sotto-gap avanzato
aggiornato G01 Normalization Model dopo Duration Normalization
aggiornato G02 Processor / Engine Flow
aggiornato G09 Type Classification Base come prossimo nodo candidato
aggiunto G12 Events List Label / Updated At Display
aggiornato ordine consigliato gap/nodi
allineamento con State v12 e Roadmap v06

v05 — 2026-05-02

aggiornato G10 Match Engine Unification a INTEGRATO BASE
documentato completamento Match Engine Unification First Controlled Level
documentato project_state/entity_state come fonte minima matching
documentato singleMatch / isAmbiguous / moreSpecificMatches
documentato select_project/select_entity allineati al match state
documentato confirm guard su ambiguità non risolta
documentato match state live in create/edit flow
documentato priority match minimo
documentato hint match più specifici
documentato bug €500 preview risolto
aggiornato G03 come Project / Entity Create Suggestion
aggiunto G14 Linting / State Helper Cleanup
aggiunto G15 Edit Mode Cancel / Return to Events List
aggiunto G16 Events List Search / Filter Bar
aggiunto G17 Preview Model / Hint State Consolidation
aggiornato G07 Preview Alignment con nota post Match Engine
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G12 Events List Label / Updated At Display
aggiornato G13 Economic Direction Advanced
aggiornato G06 Multi-source Input
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
allineamento con State v14 e Roadmap v08

v06 — 2026-05-02

aggiornato Gap Register dopo UX / CLEANUP MICRO-BATCH POST MATCH ENGINE
aggiornato G12 Events List Label / Updated At Display a INTEGRATO
documentata correzione label creato/modificato
documentata normalizzazione robusta created_at / updated_at
documentato no-op edit guard
documentato che edit senza modifiche non aggiorna updated_at
aggiornato G15 Edit Mode Cancel / Return to Events List a INTEGRATO
documentato btn_cancel_edit
documentato reset edit_mode / editing_event / input / select / ui_state.parsed
documentato ritorno lista eventi senza update_event
documentato fix doppia visibilità input/lista
aggiornato G16 Events List Search / Filter Bar a INTEGRATO
documentato input_events_search
documentato filtro client-side su list_events
documentata ricerca su raw_input / type / status / project / entity
aggiornato G14 Linting / State Helper Cleanup come unico micro-nodo residuo
confermato linting edit_mode/editing_event come residuo non bloccante
aggiornato G02 Processor / Engine Flow
aggiornato G17 Preview Model / Hint State Consolidation con nota post UX cleanup
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
allineamento con State v15 e Roadmap v09

v07 — 2026-05-03

aggiornato Gap Register dopo LINTING / STATE HELPER CLEANUP
aggiornato G14 Linting / State Helper Cleanup a INTEGRATO
documentata risoluzione linting edit_mode: 'value' is not defined
documentata risoluzione linting editing_event: 'value' is not defined
documentata rimozione additionalScope { value } da edit_mode / editing_event
documentato passaggio controllato tramite window.__logos_edit_mode_value
documentato passaggio controllato tramite window.__logos_editing_event_value
documentato reset chiavi window dopo lettura helper
documentato aggiornamento btn_edit
documentato aggiornamento btn_cancel_edit
documentato aggiornamento button_input_confirm nel ramo no-op edit guard
documentato aggiornamento button_input_confirm nel reset finale dopo salvataggio reale
documentato azzeramento editing_event dopo update reale completato
create flow validato
edit flow validato
annulla modifica validato
edit senza modifiche reali validato
edit con modifica reale validato
updated_at / label creato-modificato validati
WRITTEN / ERROR validati
DB invariato
parser invariato
Match Engine invariato
Type Classification invariata
Duration Normalization invariata
preview invariata
lista eventi invariata
aggiornato G02 Processor / Engine Flow rimuovendo Linting Cleanup dai nodi residui
aggiornato G11 Data Structure / Entity Hierarchy dopo chiusura micro-nodi helper
aggiornato G13 Economic Direction Advanced con Linting Cleanup completato
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
allineamento con State v16 e Roadmap v10

v08 — 2026-05-07

aggiornato Gap Register dopo PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
aggiornato G03 Project / Entity Create Suggestion a INTEGRATO BASE
documentato create_suggestion_state
documentate variabili project/entity inline open e dismissed
documentate query insert_project / insert_entity
documentato container suggestion inline
documentati micro-editor project/entity
documentato bottone Ignora globale
documentati bottoni Annulla contestuali
documentata creazione project inline validata su DB reale
documentata creazione entity inline validata su DB reale
documentato select_project valorizzato dopo creazione project
documentato select_entity valorizzato dopo creazione entity
documentato evento non salvato automaticamente dopo creazione project/entity
documentato evento salvato manualmente con project_id/entity_id corretti
documentato blocco solo su ambiguità project/entity attiva
documentato salvataggio consentito senza project/entity
documentato entity autofill controlled minimal
documentato flow combinato project + entity
aggiunto G18 UX Cleanup — Suggestion Container / Mobile
aggiunto G19 Command Intent — Create Project / Entity
aggiunto G20 Core Event System / Modular Instances
aggiornato G02 Processor / Engine Flow
aggiornato G06 Multi-source Input
aggiornato G10 Match Engine Unification
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G13 Economic Direction Advanced
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
confermata direzione LOGOS Core modulare
confermate istanze ASPRI / ADEXIMA / MaurizioLab come derivate future del core
allineamento con State v17 e Roadmap v11

v09 — 2026-05-09

aggiornato Gap Register dopo UX MOBILE COHERENCE PASS
aggiornato G18 da UX Cleanup — Suggestion Container / Mobile a UX Mobile Coherence Pass
aggiornato G18 a INTEGRATO BASE
documentata Home mobile rifinita
documentata Events list mobile rifinita
documentato Feedback mobile stabilizzato
documentato feedback_summary in ui_state
documentato routing post-save contestuale
documentato insert → feedback → Home
documentato update → feedback → Lista eventi
documentato no-op edit → Lista eventi senza update_event
documentato cancel create/input → Home
documentato cancel edit → Lista eventi
documentata Navigation dock Home / Eventi / Dashboard
documentata Dashboard predisposta ma disabilitata
documentate Azioni rapide predisposte ma non operative
documentato font-size 16px input/select come fix iOS Safari
documentato zoom automatico Safari iOS risolto
documentata select mobile funzionante in digitazione/dropdown
aggiunto G21 Suggestion Create vs Edit Consistency
aggiunto G22 Project Create Suggestion — Match Present / User Override
aggiunto G23 Azioni Rapide Operative
aggiunto G24 Dashboard Base
aggiunto G25 Icon System / Mobile Polish Finale
aggiunto G26 Mobile Safari Font Baseline
aggiornato G02 Processor / Engine Flow
aggiornato G03 Project / Entity Create Suggestion
aggiornato G05 Input Modes
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G15 Edit Mode Cancel / Return to Events List
aggiornato G16 Events List Search / Filter Bar
aggiornato G19 Command Intent — Create Project / Entity
aggiornato G20 Core Event System / Modular Instances
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
confermata direzione LOGOS Core modulare
allineamento con State v18 e Roadmap v12

v10 — 2026-05-13

aggiornato Gap Register dopo COMMAND INTENT — CREATE PROJECT / ENTITY
aggiornato G19 Command Intent — Create Project / Entity a INTEGRATO BASE
documentato command_intent_state
documentato riconoscimento comando generico “crea”
documentato create project incompleto
documentato create project completo
documentato create entity incompleto
documentato create entity completo
documentati sinonimi base crea / aggiungi / inserisci / nuovo / nuova
documentato blocco duplicati project/entity già esistenti
documentato “crea progetto villa” come elemento già presente
documentata guida non operativa “modifica evento”
documentato container_command_intent
documentati btn_command_create_project / btn_command_create_entity / btn_command_go_events
documentato riuso insert_project / insert_entity
documentato feedback_mode in ui_state
documentato feedback project_created
documentato feedback entity_created
documentato feedback evento ordinario preservato
documentato che comandi puri non salvano eventi
documentato che project/entity da command richiedono conferma utente
documentato che Command Intent non modifica DB/parser/matching/create_suggestion_state
aggiornato G02 Processor / Engine Flow
aggiornato G03 Project / Entity Create Suggestion
aggiornato G05 Input Modes
aggiornato G06 Multi-source Input
aggiornato G07 Preview Alignment
aggiornato G10 Match Engine Unification
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G13 Economic Direction Advanced
aggiornato G17 Preview Model / Hint State Consolidation
aggiornato G18 UX Mobile Coherence Pass
aggiornato G20 Core Event System / Modular Instances
aggiornato G23 Azioni Rapide Operative
aggiornato G24 Dashboard Base
aggiunto G27 Input Rendering Stability / Container Structure
aggiunto G28 Input Analysis Model / Single Interpretation Layer
aggiornato ordine consigliato gap/nodi post Command Intent
confermato output/KPI non attivi
confermata direzione LOGOS Core modulare
allineamento con State v19 e Roadmap v13

v11 — 2026-05-18

aggiornato Gap Register dopo UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
aggiornato G02 Processor / Engine Flow con UI Readiness / Visibility Aggregator
aggiornato G05 Input Modes con distinzione visiva empty/event/command
aggiornato G07 Preview Alignment con nota post UI Readiness
aggiornato G10 Match Engine Unification con nota su ui_visibility_state non sostitutivo
aggiornato G11 Data Structure / Entity Hierarchy con nota su UI Readiness non strutturale
aggiornato G14 Linting / State Helper Cleanup con nota sui nuovi linting residui non trattati
aggiornato G17 Preview Model / Hint State Consolidation a candidato principale post UI Readiness
aggiornato G18 UX Mobile Coherence Pass con residui post UI Readiness
aggiornato G19 Command Intent — Create Project / Entity con residuo “modifica” generico
aggiornato G20 Core Event System / Modular Instances con UI Readiness
aggiornato G23 Azioni Rapide Operative con coordinamento futuro ui_visibility_state
aggiornato G24 Dashboard Base con UI Readiness completata
aggiornato G27 Input Rendering Stability / Container Structure a INTEGRATO BASE
documentato ui_visibility_state
documentato ui_visibility_mode
documentato trigger_parse_debounced aggiornato per ui_visibility_mode
documentato window.__logos_visibility_run_id
documentata centralizzazione Hidden principali
documentato container_input stabilizzato
documentato container vuoto durante digitazione risolto
documentato flash input flow ridotto
documentato bottom bar flash risolto
documentato text_input_analysis_loading
documentato text_edit_mode_notice
documentato edit mode prevalente su command intent
aggiornato G28 Input Analysis Model / Single Interpretation Layer con ui_visibility_state / ui_visibility_mode
aggiunto G29 Feedback Micro-flash Cleanup
aggiunto G30 Command Intent — Edit Guide Generic Alias
aggiunto G31 Linting / Minor Cleanup
aggiunto G32 Cleanup Obsolete UI Guards / Query Reduction
aggiornato ordine consigliato gap/nodi post UI Readiness
confermato output/KPI non attivi
confermata direzione LOGOS Core modulare

v12 — 2026-05-20

aggiornato Gap Register dopo PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
aggiornato Gap Register dopo INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
aggiornato Gap Register dopo INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS

aggiornato G02 Processor / Engine Flow con:
- preview_analysis_state
- input_analysis_result
- controlled partial UI consumption
- ui_visibility_state ancora operativo

aggiornato G03 Project / Entity Create Suggestion con distinzione:
- missing association notice
- suggestion operativa

aggiornato G05 Input Modes con nota post input_analysis_result
aggiornato G07 Preview Alignment con preview_analysis_state e status residuale
aggiornato G10 Match Engine Unification con input_analysis_result come compositore non sostitutivo
aggiornato G14 Linting / State Helper Cleanup con 19 linting Retool attuali
aggiornato G17 Preview Model / Hint State Consolidation con nota post preview_analysis_state
aggiornato G19 Command Intent con command suppression in edit mode
aggiornato G20 Core Event System / Modular Instances con principio architettura modulare coordinata
aggiornato G21 Suggestion Create vs Edit Consistency con distinzione notice/suggestion
aggiornato G27 Input Rendering Stability / Container Structure con evoluzione input_analysis_result
aggiornato G28 da Input Analysis Model futuro a Input Analysis Result integrato parziale
aggiornato G31 da Linting / Minor Cleanup a Linting / Retool Query Safety Pass
aggiornato G32 Cleanup Obsolete UI Guards / Query Reduction dopo partial migration

aggiunti nuovi gap:
- G33 Button Confirm Readiness Alignment
- G34 UI Visibility State Decommission / Wrapper Reduction
- G35 Status Semantics Alignment

aggiornato ordine consigliato gap/nodi post Input Analysis Result
confermato prossimo nodo candidato:
- Input Analysis Result — Visibility Migration Completion

confermato nodo tecnico candidato:
- Linting / Retool Query Safety Pass

confermato blocco verso Output / Dashboard / KPI
confermata direzione LOGOS Core modulare e non monolitica

v13 — 2026-05-23

aggiornato Gap Register dopo INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
aggiornato Gap Register dopo LINTING / RETOOL QUERY SAFETY PASS

aggiornato G02 Processor / Engine Flow con:
- Visibility Migration Completion
- Linting / Retool Query Safety Pass
- input_analysis_result come fonte UI controllata per Hidden principali
- ui_visibility_state residuo tecnico deprecabile

aggiornato G03 Project / Entity Create Suggestion con visibility suggestion governata da input_analysis_result senza modificare create_suggestion_state
aggiornato G05 Input Modes dopo Visibility Migration Completion
aggiornato G07 Preview Alignment con residuo label “Importo” su durata
aggiornato G10 Match Engine Unification con policy match più specifici non bloccante
aggiornato G14 Linting / State Helper Cleanup con linting Retool azzerati
aggiornato G17 Preview Model / Hint State Consolidation dopo chiusura Visibility Migration
aggiornato G20 Core Event System / Modular Instances con nodo documentale futuro
aggiornato G27 Input Rendering Stability / Container Structure dopo Full Visibility Migration Hidden principali
aggiornato G28 Input Analysis Result / Single Interpretation Layer a INTEGRATO PARZIALE — VISIBILITY MIGRATION COMPLETION
aggiornato G29 Feedback Micro-flash Cleanup con flash residui digitazione/cambio schermata
aggiornato G31 Linting / Retool Query Safety Pass a INTEGRATO
aggiornato G32 Cleanup Obsolete UI Guards / Query Reduction dopo completion visibility/linting
aggiornato G33 Button Confirm Readiness Alignment a INTEGRATO PARZIALE — HIDDEN MIGRATO / DISABLED NON MIGRATO
aggiornato G34 UI Visibility State Decommission come residuo tecnico post migration

aggiunti nuovi gap:
- G36 Preview / Event Data Label Semantic Alignment
- G37 Documentation Architecture Audit / Redundancy Reduction

aggiornato ordine consigliato gap/nodi post Visibility Migration + Linting Safety Pass

prossimo nodo candidato prioritario:
- Documentation Architecture Audit / Redundancy Reduction

confermato:
- output/KPI non attivi
- Dashboard non attiva
- istanze verticali non attive
- LOGOS resta Core Event System modulare
- input_analysis_result non deve diventare motore monolitico

v14 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicato Pacchetto B — Core Governance su 00_PROJECT_Gap_Register
- Gap Register aggiornato da v13 a v14
- ridotta duplicazione tecnica lunga nel Gap Register
- riportato il documento alla funzione di registro gap / debiti / futuri
- sostituito GAP REGISTER esteso con GAP REGISTER — SINTESI CONTROLLATA
- mantenuti tutti gli ID gap principali
- mantenuti gap attivi, prioritari, strutturali, UX, strategici e integrati
- spostati i dettagli tecnici completi verso documenti canonici
- aggiunti richiami canonici a:
  - 01_LOGOS_Input_System
  - 02_LOGOS_Match_Engine
  - 03_LOGOS_Event_Lifecycle
  - 04_LOGOS_Retool_Architecture
  - 05_LOGOS_Database_Schema
  - 06_LOGOS_View_Preview_System
  - LOGOS_RETOOL_RUNTIME_REAL
  - LOGOS_SUPABASE_RUNTIME_REAL
- aggiornato G37 Documentation Architecture Audit / Redundancy Reduction a IN CORSO
- documentato Pacchetto A come allineato, non ridotto
- documentato Pacchetto B come in corso / quasi completato
- aggiornato ordine consigliato gap/nodi post Pacchetto B
- confermato blocco verso output / dashboard / KPI
- confermato divieto di anticipare istanze verticali
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

v15 — 2026-05-25

- aggiornamento finale post DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- Gap Register aggiornato da v14 a v15
- G37 Documentation Architecture Audit / Redundancy Reduction aggiornato da IN CORSO a COMPLETATO / INTEGRATO COME REGOLA DOCUMENTALE
- rimosso G37 da GAP ATTIVO DEL NODO CORRENTE
- registrato che non ci sono gap documentali attivi
- registrato G36 Preview / Event Data Label Semantic Alignment come prossimo gap operativo consigliato
- spostato G37 in GAP INTEGRATI / ARCHIVIO COMPATTO
- registrato esito G37:
  - fonti canoniche definite
  - documenti core alleggeriti
  - documenti tecnici canonici preservati
  - runtime manifest normalizzati
  - Kernel Manifest aggiornato
  - Session Boot Matrix consolidata
  - regola aggiornamenti futuri consolidata
  - stress test documentale finale completato
  - checkpoint finale prodotto
- aggiornata sezione ORDINE CONSIGLIATO GAP / NODI post audit documentale
- chiarito che G37 non deve essere riaperto come nodo documentale generico
- chiarito che le regole documentali permanenti sono nel Kernel Manifest
- confermato che i checkpoint sono riferimenti storico-operativi e non unica fonte delle regole permanenti
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

v16 — 2026-05-26

- aggiornamento post PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT
- Gap Register aggiornato da v15 a v16
- G36 Preview / Event Data Label Semantic Alignment aggiornato da IDENTIFICATO a INTEGRATO
- G36 spostato da GAP RESIDUI PRIORITARI a GAP INTEGRATI / ARCHIVIO COMPATTO
- registrata risoluzione del residuo label “Importo” su durata
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
- aggiornato prossimo gap operativo consigliato a G29 Feedback / Input Flow Micro-flash Cleanup
- confermato che G36 non va riaperto come nodo base
- confermato che eventuali evoluzioni più ampie della Sintesi restano in G17 Preview Model / Hint State Consolidation
- nessuna anticipazione Button Confirm Readiness Alignment
- nessuna anticipazione cleanup ui_visibility_state
- nessuna anticipazione output / KPI / dashboard