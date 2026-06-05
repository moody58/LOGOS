# 00_PROJECT_State_v28

DATA: 2026-06-04

------------------------------------------------
NODO ATTIVO:
------------------------------------------------

PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE / AUTO-SELECT CONFIDENCE — COMPLETATO

Stato nodo:

- micro-nodo funzionale / Match-Suggestion policy / anti-errore associazione completato
- G22 analizzato su sistema reale Retool
- caso guida “20 euro villa sierri” verificato
- classificazione finale: match presente + suggestion extension
- tema risolto con micro-policy locale
- G10A Match Engine Evolution Advanced non necessario per questo caso

Esito:

- create_suggestion_state aggiornato con flag requiresUserOverride
- requiresUserOverride esposto quando:
  - esiste un singleMatch già selezionato
  - esiste una candidate più specifica proposta da create_suggestion_state
  - reason = extension
- preview_analysis_state aggiornato per leggere create_suggestion_state.data.project/entity
- card Da verificare aggiornata con warning mirato:
  - Associazione progetto da controllare
  - Associazione entità da controllare
- micro-copy consolidata:
  - [baseName] selezionato · testo letto: [candidateName]
  - [baseName] selezionata · testo letto: [candidateName]
- create_suggestion_hint rifinito per mostrare solo la suggestion operativa
- rimossa duplicazione della selezione corrente dal container Suggerimenti associazione
- warning generici “Esistono progetti più specifici” / “Esistono entità più specifiche” non usati più come segnale principale nei casi G22
- separazione semantica consolidata:
  - Da verificare = rischio decisionale
  - Suggerimenti associazione = azione disponibile

Comportamento finale project:

20 euro villa sierri
→ select_project = Villa
→ create_suggestion_state.project.candidateName = Villa Sierri
→ requiresUserOverride = true
→ Da verificare:
  Associazione progetto da controllare
  Villa selezionato · testo letto: Villa Sierri
→ Suggerimenti associazione:
  Possibile nuovo progetto: Villa Sierri
→ Conferma attiva

Comportamento finale entity:

20 euro mario giordano
→ select_entity = Mario
→ create_suggestion_state.entity.candidateName = Mario Giordano
→ requiresUserOverride = true
→ Da verificare:
  Associazione entità da controllare
  Mario selezionata · testo letto: Mario Giordano
→ Suggerimenti associazione:
  Possibile nuova entità: Mario Giordano
→ Conferma attiva

Test runtime validati:

- 20 euro villa → Progetto Villa, nessun warning G22 project, Conferma attiva
- 20 euro villa sierri → warning G22 project, suggestion project, Conferma attiva
- 20 euro villa sierri 6 → Progetto Villa Sierri 6, nessun warning G22 project, Conferma attiva
- 20 euro tecnico mario → Entità Mario, nessun warning G22 entity, Conferma attiva
- crea progetto test → container command visibile, Conferma evento non mostrata
- 20 euro mario rossi → Entità Mario Rossi, nessun warning G22 entity, Conferma attiva
- 20 euro mario giordano → warning G22 entity, suggestion entity, Conferma attiva

Impatto:

- nessuna modifica parser
- nessuna modifica parse_input_controlled
- nessuna modifica duration normalization
- nessuna modifica type classification
- nessuna modifica project_state/entity_state nella logica funzionale
- nessuna modifica select_project/select_entity
- nessuna modifica select1
- nessuna modifica command_intent_state
- nessuna modifica input_analysis_result
- nessuna modifica button_input_confirm.Disabled
- nessuna modifica button_input_confirm.Hidden
- nessuna modifica button_input_confirm payload
- nessuna modifica insert_event/update_event
- nessuna modifica save flow
- nessuna modifica DB
- nessuna modifica Supabase
- nessuna eliminazione di ui_visibility_state
- nessun cleanup globale
- nessuna anticipazione G10A
- nessuna anticipazione fuzzy / alias / ranking globale / gerarchie / deduplicazione
- nessuna anticipazione dashboard / KPI / output

Classificazione:

G22 completato come micro-policy locale di sicurezza associazione.

Il nodo non ha modificato il Match Engine avanzato.
Il nodo non ha trasformato suggestion in blocco.
Il nodo non ha centralizzato la save readiness.
Il nodo non ha introdotto Input Analysis Model completo.

Residui emersi fuori nodo:

1. Status Semantics Alignment

Il badge OK nella Sintesi può risultare semanticamente debole quando esiste una card Da verificare.
Da trattare in nodo Preview/Status dedicato, non in G22.

2. Preview / Missing Association Notice Cleanup

Il balloon blu “Manca progetto / Manca entità” può risultare ridondante rispetto al container Suggerimenti associazione in alcuni casi.
Da valutare in nodo Preview/UX futuro.

3. Residui grafici / mobile polish

Da trattare più avanti o in sessioni brevi quando c’è poco tempo.
Non blocca il sistema.

Documenti aggiornati nel nodo:

- 02_LOGOS_Match_Engine
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL
- 06_LOGOS_View_Preview_System
- 00_PROJECT_State

Documenti ancora da aggiornare:

- 00_PROJECT_Gap_Register
- 00_PROJECT_Roadmap solo se cambia sequenza o priorità

Documenti da non aggiornare:

- 03_LOGOS_Event_Lifecycle
- 05_LOGOS_Database_Schema
- LOGOS_SUPABASE_RUNTIME_REAL
- 00_PROJECT_KERNEL_MANIFEST

Checkpoint:

Non necessario checkpoint esteso.
Il nodo ha prodotto una modifica locale, testata e documentabile tramite aggiornamento dei documenti canonici.

Prossimo nodo operativo consigliato:

DA DEFINIRE DOPO AGGIORNAMENTO GAP REGISTER / ROADMAP

Nota:

La sequenza futura deve evitare loop tra:

- G22 già completato
- G10A Match Engine Advanced
- select contextual filtering
- input_analysis_model avanzato
- preview model / hint state consolidation

La decisione va presa in Regia / Roadmap dopo aggiornamento Gap Register.

------------------------------------------------
FASE:
------------------------------------------------

STEP 4 — EVENT EDITING (COMPLETATO)
STEP 4.1 — INPUT SYSTEM STABILIZATION (COMPLETATO)
STEP 6.1 — ENGINE BASE / NORMALIZATION LAYER BASE (COMPLETATO)
PREVIEW ALIGNMENT BASE (COMPLETATO)
STEP 6.2 — ENGINE BASE / DURATION NORMALIZATION (COMPLETATO)
STEP 6.3 — ENGINE BASE / TYPE CLASSIFICATION BASE (COMPLETATO)
STEP 6.4 — MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL (COMPLETATO)
UX / CLEANUP MICRO-BATCH POST MATCH ENGINE (COMPLETATO)
LINTING / STATE HELPER CLEANUP (COMPLETATO)
PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL (COMPLETATO)
UX MOBILE COHERENCE PASS (COMPLETATO)
COMMAND INTENT — CREATE PROJECT / ENTITY (COMPLETATO)
UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL (COMPLETATO)
PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER (COMPLETATO)
INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC (COMPLETATO)
INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS (COMPLETATO)
INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION — COMPLETATO
LINTING / RETOOL QUERY SAFETY PASS — COMPLETATO
DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION — COMPLETATO
PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT — COMPLETATO
✔ INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION — CHIUSO COME RESIDUO UX MINORE ACCETTABILE / IN OSSERVAZIONE
✔ BUTTON CONFIRM READINESS ALIGNMENT — COMPLETATO
✔ PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE — COMPLETATO
TRANSIZIONE → AGGIORNAMENTO GAP REGISTER / ROADMAP PER DEFINIZIONE PROSSIMO NODO

Nota:

Il nodo documentale è completato.
Non ha modificato runtime LOGOS.
Non ha modificato Retool.
Non ha modificato Supabase.
Non ha modificato DB, parser, matching, preview, save flow, payload o componenti UI.

Risultato:

- fonti canoniche complete consolidate
- richiami espliciti introdotti nei documenti non canonici
- documenti core alleggeriti
- documenti tecnici preservati
- runtime manifest normalizzati
- Session Boot Matrix consolidata
- costo aggiornamenti futuri ridotto

Transizione operativa:

Il nodo PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT è completato.

Il prossimo nodo consigliato è INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION, salvo diversa decisione in Regia.

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10

- stato corrente del progetto documentato
- nodo documentale registrato come completato
- Pacchetto A registrato come allineamento, non riduzione
- Pacchetto B registrato come completato
- Pacchetto C registrato come completato
- Pacchetto D registrato come completato
- Kernel Manifest registrato come aggiornato
- stress test documentale finale registrato
- layer completati mantenuti in snapshot funzionale
- catene runtime principali mantenute in forma sintetica non interpretativa
- debiti tecnici/funzionali residui esplicitati
- prossimi nodi candidati mantenuti
- changelog aggiornato a v24
- richiami canonici inseriti per le logiche complete
- nodo Preview / Event Data Label Semantic Alignment registrato come completato
- label semantica Importo / Durata / Valore registrata nello stato sintetico
- impatto runtime limitato a micro-copy Sintesi documentato
- prossimo nodo consigliato aggiornato
- nodo Button Confirm Readiness Alignment registrato come completato
- G33 registrato come completato
- button_input_confirm.Disabled allineato a isAmbiguous
- fallback matches.length > 1 rimosso da Disabled
- rischio match generico / auto-select confidence registrato come fuori nodo da assorbire in G227
- nodo Project Create Suggestion — Match Present / User Override registrato come completato
- G22 registrato come completato a primo livello controllato
- requiresUserOverride registrato come flag UI derivato da create_suggestion_state
- warning mirato “Associazione progetto/entità da controllare” registrato nello State
- separazione Da verificare / Suggerimenti associazione registrata
- G10A registrato come non necessario per il caso G22

Q (Qualità): 9.4/10

- documento riportato alla funzione di State
- ridotte duplicazioni tecniche lunghe
- conservata ricostruibilità tramite richiami canonici
- separato stato corrente da implementazione tecnica completa
- ridotto rischio di versioni divergenti tra State e documenti tecnici
- nessuna decisione runtime ricalcolata
- nessuna roadmap operativa anticipata
- preservata funzione leggera dello State
- dettaglio tecnico completo rimandato a 06_LOGOS_View_Preview_System e LOGOS_RETOOL_RUNTIME_REAL
- nessuna duplicazione lunga del codice Sintesi
- preservata funzione leggera dello State anche dopo G33
- nessuna duplicazione lunga del codice runtime oltre al minimo necessario per ricostruire il nodo
- separato il fix locale Disabled dai temi futuri Match Engine / G22
- evitata creazione di gap ridondanti su auto-select confidence
- ridotto rischio di salvataggio inconsapevole su associazione generica
- preservata leggerezza dello State senza duplicare tutto il codice runtime
- registrati solo esito, impatto e residui strategici del nodo G22
- evitata anticipazione di Match Engine Advanced
- evitata anticipazione di Input Analysis Model completo

D (Deployabilità): 10/10

- pronto come documento core di boot
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica payload
- fonti canoniche richiamate per ricostruzione completa
- pronto come documento core di boot post documentation audit
- prossimo nodo operativo consigliato chiarito
- modifica runtime testata
- nessuna regressione parser / matching / save flow / DB
- G36 pronto per chiusura in Gap Register
- G33 completato e testato
- button_input_confirm.Disabled aggiornato senza regressioni
- payload invariato
- save flow invariato
- DB invariato
- parser / matching / preview invariati nella logica funzionale
- G22 completato e testato su runtime Retool reale
- create_suggestion_state.requiresUserOverride validato
- preview_analysis_state warning G22 validato
- create_suggestion_hint validato senza duplicazione informativa
- button_input_confirm.Disabled invariato
- payload invariato
- save flow invariato
- DB invariato
- Supabase invariato
- G10A non necessario per il caso G22

------------------------------------------------
IDENTIFICAZIONE PROGETTO
------------------------------------------------

Nome: LOGOS  
Tipo: Event Operating System  

Stack:

Frontend: Retool  
Backend: Supabase  
Logica: Client-side (JavaScript)  
Modello dati: Event Ledger (append-only controllato)  

------------------------------------------------
STATO GENERALE SISTEMA
------------------------------------------------

Sistema funzionante end-to-end:

INPUT  
→ PARSING  
→ NORMALIZATION  
→ MATCHING  
→ PREVIEW  
→ INSERT / UPDATE  
→ PROCESSING  
→ FEEDBACK

Stato consolidato:

✔ sistema funzionante  
✔ utilizzabile in produzione reale  
✔ comportamento quasi deterministico  
✔ input/parsing stabilizzati  
✔ normalization base completata  
✔ duration normalization completata per ore/minuti certi  
✔ type classification base completata  
✔ matching project/entity unificato a primo livello controllato  
✔ project/entity create suggestion completata a primo livello controllato  
✔ Command Intent create project/entity completato a primo livello controllato  
✔ UX mobile rifinita  
✔ preview/hint migliorati ma ancora ibridi  
✔ label riga valore Sintesi semanticamente allineata a Importo / Durata / Valore  
✔ input_analysis_result consolidato come fonte UI controllata per gli Hidden principali del flow input  
✔ ui_visibility_state riclassificato come residuo tecnico deprecabile / rollback  
✔ linting Retool azzerati  
✔ DB invariato  
✔ Supabase resta storage layer passivo 
✔ Documentation Architecture Audit / Redundancy Reduction completato
✔ fonti canoniche consolidate
✔ Session Boot Matrix consolidata nel Kernel Manifest
✔ regola aggiornamenti futuri consolidata 
✔ G29 analizzato e classificato come residuo UX minore non bloccante
✔ micro-flash input/command transition mantenuto in osservazione
✔ nessuna modifica runtime definitiva mantenuta dopo il nodo G29
✔ G33 Button Confirm Readiness Alignment completato
✔ button_input_confirm.Disabled allineato a project_state/entity_state isAmbiguous
✔ fallback matches.length > 1 rimosso da Disabled
✔ warning match più specifici preservati come non bloccanti dove pertinenti
✔ G22 Project Create Suggestion — Match Present / User Override completato
✔ match presente + suggestion extension gestito con warning mirato non bloccante
✔ Da verificare e Suggerimenti associazione separati semanticamente

Debiti principali:

⚠ preview ancora layer ibrido, non view pura  
⚠ input_analysis_result non è Input Analysis Model completo  
⚠ ui_visibility_state non ancora eliminato fisicamente  
✔ button_input_confirm.Disabled allineato localmente a isAmbiguous  
⚠ button_input_confirm.Disabled non migrato dentro input_analysis_result  
⚠ save readiness completa non centralizzata  
✔ auto-select confidence / match generico salvabile risolto a primo livello in G22  
⚠ auto-select confidence avanzata / ranking globale non implementati
⚠ Status Semantics Alignment da valutare: badge OK può risultare debole con card Da verificare
⚠ Missing Association Notice Cleanup da valutare: balloon blu “Manca progetto / Manca entità”
⚠ data structure / entity hierarchy non implementata  
⚠ output / dashboard / KPI non attivi  
⚠ micro-flash input/command transition residuo non bloccante, da non inseguire fuori nodo dedicato

Fonte completa:

- SNAPSHOT FUNZIONALE CONSOLIDATO in questo documento per stato sintetico corrente
- 01_LOGOS_Input_System per input/parser/input_analysis_result
- 02_LOGOS_Match_Engine per matching
- 03_LOGOS_Event_Lifecycle per lifecycle
- 04_LOGOS_Retool_Architecture per componenti/query/Hidden
- 04_LOGOS_Database_Schema per schema DB
- 06_LOGOS_View_Preview_System per preview/hint
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
- LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase as-is

------------------------------------------------
SNAPSHOT FUNZIONALE CONSOLIDATO
------------------------------------------------

Il sistema LOGOS è stabilizzato su ventitré layer fondamentali.

Layer completati:

1. INPUT RELIABILITY — PARSING
2. MATCHING BASE
3. LABEL QUALITY
4. ENGINE BASE — NORMALIZATION LAYER BASE
5. PREVIEW ALIGNMENT BASE
6. ENGINE BASE — DURATION NORMALIZATION
7. ENGINE BASE — TYPE CLASSIFICATION BASE
8. MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL
9. UX / CLEANUP MICRO-BATCH POST MATCH ENGINE
10. LINTING / STATE HELPER CLEANUP
11. PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
12. UX MOBILE COHERENCE PASS
13. COMMAND INTENT — CREATE PROJECT / ENTITY
14. UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
15. PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
16. INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
17. INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS
18. INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
19. LINTING / RETOOL QUERY SAFETY PASS
20. DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
21. PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT
22. BUTTON CONFIRM READINESS ALIGNMENT
23. PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE

------------------------------------------------
CATENE RUNTIME ATTUALI — SINTESI NON INTERPRETATIVA
------------------------------------------------

Catena input / parsing / dati strutturati:

input_home
→ input_raw
→ trigger_parse_debounced
→ parse_input_controlled
→ ui_state.parsed

Fonte canonica:
- 01_LOGOS_Input_System per input flow, parser, normalization, duration normalization, type base e input_analysis_result nel contesto input.
- 04_LOGOS_Retool_Architecture per wiring Retool dei componenti e query coinvolte.

Nota:
il dettaglio completo del parser e delle normalizzazioni non viene duplicato nello State.

---

Catena salvataggio evento:

ui_state.parsed
→ button_input_confirm payload
→ insert_event / update_event
→ Supabase
→ events_new refresh

Fonti canoniche:
- 01_LOGOS_Input_System per origine dei dati salvabili lato input.
- 03_LOGOS_Event_Lifecycle per lifecycle evento, edit, no-op, cancel, WRITTEN / ERROR.
- 04_LOGOS_Database_Schema per struttura DB e campi persistiti.
- LOGOS_SUPABASE_RUNTIME_REAL per comportamento Supabase as-is.

Nota:
button_input_confirm.Disabled e payload sono rimasti separati da input_analysis_result dopo Visibility Migration Completion.

---

Catena type:

ui_state.parsed.unit
→ select1.value
→ events.type

Fonte canonica:
- 01_LOGOS_Input_System per Type Classification Base.
- 04_LOGOS_Database_Schema per persistenza di events.type.

Regola consolidata:
type attuali = Evento / Tempo / Spesa / Incasso.

---

Catena matching project/entity:

input_raw
→ project_state / entity_state
→ select_project / select_entity
→ events.project_id / events.entity_id

Fonte canonica:
- 02_LOGOS_Match_Engine per project_state / entity_state / matches / count / isAmbiguous / singleMatch / moreSpecificMatches / confirm guard.
- 04_LOGOS_Retool_Architecture per wiring Retool.
- 06_LOGOS_View_Preview_System per hint/highlight collegati alla Sintesi.

Regole consolidate:
- auto-select solo tramite singleMatch
- ambiguità non risolta blocca Conferma
- ambiguità risolta manualmente consente Conferma
- nessun match non blocca il salvataggio
- match generico semplice resta confermabile
- match presente + suggestion extension genera warning G22 non bloccante
- blocco Conferma basato solo su isAmbiguous non risolto

---

Catena project/entity creation:

create_suggestion_state
→ container suggestion
→ input_new_project_name / input_new_entity_name
→ insert_project / insert_entity
→ projects_list / entities_list refresh
→ select_project / select_entity
→ Conferma evento manuale

Fonte canonica:
- 01_LOGOS_Input_System per create_suggestion_state e flow input.
- 04_LOGOS_Retool_Architecture per componenti/query.
- 04_LOGOS_Database_Schema per impatto DB.

Regole consolidate:
- nessuna creazione automatica project/entity
- creazione solo previa conferma utente
- evento non salvato automaticamente dopo creazione project/entity
- select_project / select_entity restano decisione utente finale
- match presente + suggestion extension espone requiresUserOverride
- requiresUserOverride non blocca Conferma e non salva dati

---


Catena Command Intent:

input_home / input_raw
→ command_intent_state
→ container_command_intent
→ btn_command_create_project / btn_command_create_entity / btn_command_go_events
→ insert_project / insert_entity oppure events_new
→ feedback project/entity oppure lista eventi

Fonte canonica:
- 01_LOGOS_Input_System per Command Intent nel contesto input.
- 04_LOGOS_Retool_Architecture per componenti/query Retool.
- 03_LOGOS_Event_Lifecycle per distinzione comando puro / evento ordinario.

Regole consolidate:
- comandi puri non salvano eventi
- “crea progetto...” e “crea entità...” creano risorse solo previa conferma
- “modifica evento” è guida non operativa verso lista eventi
- nessun update_event automatico da comando

---

Catena UI readiness / visibility:

input_home / input_raw
→ ui_visibility_mode
→ input_analysis_result
→ Hidden principali flow input

Fonte canonica:
- 01_LOGOS_Input_System per input_analysis_result, raw / selection / effective / readiness.
- 04_LOGOS_Retool_Architecture per Hidden/componenti Retool.
- LOGOS_RETOOL_RUNTIME_REAL per stato runtime as-is.

Regole consolidate:
- input_analysis_result governa gli Hidden principali migrati del flow input
- ui_visibility_state non è più letto da input_analysis_result
- ui_visibility_state resta residuo tecnico deprecabile / rollback
- ui_state.view resta fonte del routing principale app
- button_input_confirm.Disabled resta guard funzionale separata
- button_input_confirm.Disabled legge project_state/entity_state isAmbiguous
- button_input_confirm.Disabled non usa più matches.length > 1 come blocco grezzo

---

Catena preview / hint:

ui_state.parsed
→ project_state / entity_state
→ select / type
→ preview_analysis_state
→ Sintesi

Fonte canonica:
- 06_LOGOS_View_Preview_System per Sintesi, preview, hint, warning, label visuali, micro-copy e limiti preview.
- 02_LOGOS_Match_Engine per hint e highlight derivati dal matching.
- 01_LOGOS_Input_System per dati parsati consumati dalla preview.

Regole consolidate:
- preview non salva
- preview non valida evento
- preview non è fonte del payload
- preview resta layer ibrido, non view pura
- riga valore Sintesi allineata semanticamente:
  - euro → Importo
  - ore/minuti → Durata
  - fallback → Valore
- Da verificare segnala il rischio decisionale nei casi G22
- Suggerimenti associazione propone l’azione disponibile

------------------------------------------------
RISULTATI FUNZIONALI CONSOLIDATI
------------------------------------------------

Sistema:

✔ funzionante end-to-end
✔ utilizzabile in produzione reale
✔ input/parsing stabilizzati
✔ normalizzazione amount/unit implementata
✔ durate certe ore/minuti normalizzate in minuti
✔ type classification base implementata
✔ matching project/entity unificato a primo livello controllato
✔ project/entity creation controllata implementata
✔ Command Intent create project/entity implementato
✔ UI mobile rifinita
✔ feedback temporaneo stabilizzato
✔ input_analysis_result consolidato come fonte UI controllata per gli Hidden principali del flow input
✔ linting Retool azzerati
✔ query legacy typing_state / handle_event_success eliminate
✔ DB invariato
✔ parser/matching/save flow preservati dopo gli ultimi nodi
✔ label “Importo” su durata risolta
✔ riga valore della Sintesi semanticamente coerente con unità rilevata
✔ button_input_confirm.Disabled allineato alla fonte interpretata isAmbiguous
✔ G22 match presente + suggestion extension completato
✔ warning “Associazione progetto/entità da controllare” introdotto
✔ warning “progetti più specifici” / “entità più specifiche” non usati più come segnale principale nei casi G22
✔ suggestion ignorata resta non bloccante

------------------------------------------------
DEBITI TECNICI / FUNZIONALI RESIDUI
------------------------------------------------

Input / parsing:

- date relative non implementate
- giorni/settimane non convertiti automaticamente
- parole numeriche tipo “due ore” non supportate
- forme colloquiali tipo “un paio d’ore” non supportate

Fonte canonica:
- 01_LOGOS_Input_System

---

Matching / entity structure:

- fuzzy matching non implementato
- alias system non implementato
- gerarchie project/entity non implementate
- deduplicazione avanzata non implementata
- select options non filtrate in caso di ambiguità
- policy match presente + suggestion extension risolta a primo livello in G22
- auto-select confidence avanzata / ranking globale ancora non implementati

Fonte canonica:
- 02_LOGOS_Match_Engine
- 00_PROJECT_Gap_Register per stato dei gap futuri

---

Preview / hint:

- preview ancora layer ibrido
- “Da verificare” ancora embedded nella Sintesi
- micro-azioni Cambia / Scegli non cliccabili
- label “Importo” su durata risolta tramite micro-copy semantica della riga valore
- badge OK / status Sintesi da riallineare semanticamente
- balloon blu “Manca progetto / Manca entità” da rivalutare in nodo Preview/UX futuro
- residui grafici/mobile polish da trattare in nodi UX dedicati o sessioni brevi

Fonte canonica:
- 06_LOGOS_View_Preview_System

---

Input analysis / UI readiness:

- input_analysis_result non è Input Analysis Model completo
- ui_visibility_state resta residuo tecnico deprecabile
- cleanup obsolete UI guards / query reduction non ancora eseguito
- save readiness completa non centralizzata
- button_input_confirm.Disabled non migrato dentro input_analysis_result
- button_input_confirm.Disabled allineato localmente a isAmbiguous

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

Command Intent:

- Command Intent implementato solo a primo livello controllato
- engine intent globale non implementato
- alias generici modifica/correggi/cambia non implementati
- non apre edit flow automatici

Fonte canonica:
- 01_LOGOS_Input_System
- 03_LOGOS_Event_Lifecycle

---

DB / Supabase:

- DB passivo
- nessun versioning modifiche
- payload non utilizzato
- dati storici non retro-normalizzati
- nessun audit trail dedicato

Fonte canonica:
- 04_LOGOS_Database_Schema
- LOGOS_SUPABASE_RUNTIME_REAL

---

Output / Dashboard:

- Dashboard predisposta ma non implementata
- KPI/reportistica non attivi
- output non anticipato

Fonte canonica:
- 00_PROJECT_Roadmap
- 00_PROJECT_Gap_Register

------------------------------------------------
UI ARCHITECTURE — SINTESI
------------------------------------------------

LOGOS resta una Single Page App in Retool.

Container principali:

- container_home
- container_input
- container_feedback
- container_events_list
- container_app_nav / navigation dock

Routing principale:

ui_state.view

Visibility interna flow input:

input_analysis_result

Latch visivo empty / event / command:

ui_visibility_mode

Residuo tecnico deprecabile:

ui_visibility_state

Regole consolidate:

- ui_state.view governa Home / Feedback / Events List
- input_analysis_result governa gli Hidden principali migrati del flow input
- ui_visibility_state non è più fonte primaria degli Hidden principali migrati
- ui_visibility_state non va eliminato fuori da cleanup dedicato
- button_input_confirm.Disabled resta separato
- button_input_confirm.Disabled è allineato localmente a isAmbiguous
- button_input_confirm payload resta invariato

Fonte canonica:
- 04_LOGOS_Retool_Architecture per componenti, query, Hidden e wiring Retool.
- 01_LOGOS_Input_System per input_analysis_result.
- LOGOS_RETOOL_RUNTIME_REAL per runtime reale as-is.

------------------------------------------------
STATO LAYER SISTEMA
------------------------------------------------

Layer 1 — Input: ~99%
Layer Command Intent: ~72%
Layer 2 — Matching / Suggestion: ~94%
Layer 3 — View / Preview: ~96%
Layer HINT SYSTEM: ~94%
Layer UX Mobile: ~96%
Layer UI Readiness / Visibility: ~95% — G33 completato, residuo micro-flash G29 in osservazione
Layer Input Analysis / Composition: ~69%
Layer 4 — Data Structure: ~32%
Layer 4 — Engine: ~48%
Layer 6 — Output: 0%

---

STATO COMPLESSIVO:

~95%

------------------------------------------------
FASE ATTUALE
------------------------------------------------

✔ INPUT RELIABILITY — COMPLETATA  
✔ MATCHING BASE — COMPLETATO  
✔ LABEL QUALITY — COMPLETATO  
✔ EVENT EDITING — COMPLETATO  
✔ INPUT SYSTEM STABILIZATION — COMPLETATA  
✔ ENGINE BASE — NORMALIZATION LAYER BASE — COMPLETATO  
✔ PREVIEW ALIGNMENT BASE — COMPLETATO  
✔ ENGINE BASE — DURATION NORMALIZATION — COMPLETATO  
✔ ENGINE BASE — TYPE CLASSIFICATION BASE — COMPLETATO  
✔ MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL — COMPLETATO 
✔ UX / CLEANUP MICRO-BATCH POST MATCH ENGINE — COMPLETATO 
✔ LINTING / STATE HELPER CLEANUP — COMPLETATO
✔ PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL — COMPLETATO
✔ UX MOBILE COHERENCE PASS — COMPLETATO
✔ COMMAND INTENT — CREATE PROJECT / ENTITY — COMPLETATO
✔ UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL — COMPLETATO
✔ PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER — COMPLETATO
✔ INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC — COMPLETATO
✔ INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS — COMPLETATO
✔ INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION — COMPLETATO
✔ LINTING / RETOOL QUERY SAFETY PASS — COMPLETATO
✔ DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION — COMPLETATO
✔ PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT — COMPLETATO
✔ INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION — CHIUSO COME RESIDUO UX MINORE ACCETTABILE / IN OSSERVAZIONE
✔ BUTTON CONFIRM READINESS ALIGNMENT — COMPLETATO
✔ PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE — COMPLETATO

---

TRANSIZIONE:

→ AGGIORNAMENTO GAP REGISTER / ROADMAP PER CHIUSURA G22 E DEFINIZIONE PROSSIMO NODO

Nota:

le precedenti transizioni documentali post Input Analysis Result,
Visibility Migration e Linting Safety Pass sono state completate e consolidate
nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION.

------------------------------------------------
OBIETTIVO IMMEDIATO
------------------------------------------------

Nodo appena completato:

PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE / AUTO-SELECT CONFIDENCE

Esito:

- G22 completato su runtime Retool reale
- caso guida “20 euro villa sierri” risolto
- match presente + suggestion extension gestito senza bloccare Conferma
- create_suggestion_state espone requiresUserOverride
- preview_analysis_state mostra warning mirato in Da verificare
- create_suggestion_hint mostra solo la suggestion operativa
- Da verificare e Suggerimenti associazione separati semanticamente
- button_input_confirm.Disabled invariato
- button_input_confirm.Hidden invariato
- payload invariato
- insert_event / update_event invariati
- save flow invariato
- parser invariato
- matching primario invariato
- input_analysis_result invariato
- DB invariato
- Supabase invariato
- G10A non necessario per questo caso

Test post-fix:

- 20 euro villa → nessun warning G22 project
- 20 euro villa sierri → warning G22 project + suggestion project
- 20 euro villa sierri 6 → match specifico diretto
- 20 euro tecnico mario → nessun warning G22 entity
- crea progetto test → command container, nessuna Conferma evento
- 20 euro mario rossi → match specifico diretto
- 20 euro mario giordano → warning G22 entity + suggestion entity

Prossimo passo immediato:

aggiornare 00_PROJECT_Gap_Register.

Obiettivo aggiornamento Gap Register:

- chiudere G22
- registrare che G22 non apre G10A per questo caso
- registrare residui reali emersi:
  - Status Semantics Alignment
  - Preview / Missing Association Notice Cleanup
  - residui grafici/mobile polish
- evitare nuovi gap duplicati
- preparare decisione ordinata sul prossimo nodo senza loop tra Match Engine Advanced, Preview Model e Input Analysis Model

Prossimo nodo operativo:

da decidere dopo aggiornamento Gap Register e Roadmap.

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il sistema:

✔ è funzionale  
✔ è utilizzabile  
✔ è estendibile  
✔ ha una prima base engine reale  
⚠ non è ancora stabile architetturalmente in tutti i layer  

---

DIREZIONE STRATEGICA CONFERMATA:

LOGOS mantiene l’obiettivo di essere un sistema espandibile a blocchi,
fondato su un Core Event System centrale.

Il core attuale è:

input libero
→ interpretazione controllata
→ project / entity / type / amount / date
→ evento normalizzato
→ ledger eventi
→ viste / moduli / dashboard futuri

Le istanze ASPRI / ADEXIMA / MaurizioLab restano derivate future del core,
non nodi da anticipare ora.

Regola anti-deriva:

Non aprire moduli verticali specifici prima che il Core Event System sia consolidato.

Esempi di moduli da NON anticipare ora:

- dashboard ASPRI
- CRM ADEXIMA
- gestione MaurizioLab
- moduli animali / allevamento
- moduli fatture / preventivi
- moduli clienti avanzati

Sequenza corretta futura:

1. consolidare cuore eventi
2. consolidare gestione project/entity
3. introdurre command intent guidato ✔
4. UX mobile base rifinita e completata ✔
5. consolidare preview / hint / input analysis
4.1 visibility migration degli Hidden principali completata
4.2 consolidare preview / label / hint residui
4.3 semplificare architettura documentale per ridurre ridondanza senza perdere ricostruibilità
1. introdurre data structure / logiche avanzate
2. solo dopo aprire viste, dashboard operative, istanze o moduli verticali

---

La label è:

→ layer derivato  
→ non persistito  
→ base utile per evoluzione preview / engine  
→ ancora embedded nella preview  

---

Priorità aggiornata:

1. input reliability ✔
2. label quality ✔
3. normalization layer base ✔
4. preview alignment ✔
4. duration normalization ✔
6. type classification base ✔
7. match engine unification first controlled level ✔
8. UX / cleanup post match engine ✔
9. linting / state helper cleanup ✔
10. project/entity create suggestion ✔
11. UX mobile coherence pass ✔
12. command intent create project/entity ✔
13. UI readiness / visibility aggregator ✔
14. preview analysis state ✔
14. input analysis result controlled layers ✔
16. input analysis result visibility migration ✔
17. linting / Retool query safety pass ✔
18. documentation architecture audit / redundancy reduction ✔
19. preview / event data label semantic alignment ✔
20. input flow / transition micro-flash stabilization ✔
21. button confirm readiness alignment ✔
22. project create suggestion / match present / user override ✔
23. definizione prossimo nodo post G22
24. preview model / hint state consolidation
25. input analysis model completo / single interpretation layer avanzato
26. data structure / entity relations
27. economic direction advanced
28. output         

---

Il sistema attuale è:

✔ UX-driven  
✔ safe  
✔ non decisionale  
✔ progressivamente normalizzato  

---

PRIORITÀ FUTURE:

1. da definire dopo Gap Register / Roadmap post G22
2. preview model / hint state consolidation
3. input analysis model / single interpretation layer
4. data structure / entity relations
5. economic direction advanced
6. duration advanced — giorni / settimane
7. dashboard / KPI base

Nota strategica post UI Readiness:

Il checkpoint INPUT RENDERING STABILITY / PRIORITY REVIEW ha confermato che LOGOS può tendere in futuro
a un Input Analysis Result / Single Interpretation Layer, ma non come implementazione immediata.

Nel nodo appena completato è stato implementato solo il livello ammesso:
un aggregatore UI/readiness e un latch di visibilità, senza introdurre fonte unica interpretativa,
senza sostituire parser/matching/command/suggestion e senza creare un Event Interpretation Engine.

Direzione futura:

- Livello 1 completato: UI Readiness / Visibility Aggregator
- Livello 2 futuro: Input Analysis Result / Single Interpretation Layer
- Livello 3 futuro avanzato: Event Interpretation Engine / Multi-source Input

Nota strategica post Input Analysis Result:

LOGOS non deve evolvere verso un mega-motore monolitico.

La direzione corretta è:

- moduli specializzati che calcolano:
  - parsing
  - matching
  - suggestion
  - command
  - preview hint/status
  - save flow

- input_analysis_result che compone:
  - raw state
  - selection state
  - effective state
  - readiness UI

- UI che legge progressivamente una verità operativa coerente

Obiettivo:

massimo controllo,
massima flessibilità,
riduzione delle verità parallele,
senza eliminare i moduli specializzati che funzionano.

Nota strategica post Visibility Migration Completion:

La migrazione visibility degli Hidden principali è stata completata senza trasformare input_analysis_result in motore monolitico.

Stato consolidato:

- moduli specializzati continuano a calcolare
- input_analysis_result compone
- UI legge contratti più stabili
- ui_state.view governa il routing principale app
- ui_visibility_mode resta latch leggero
- ui_visibility_state resta residuo tecnico deprecabile

Regola:

Non migrare tutto dentro input_analysis_result.
Usare input_analysis_result per composizione/readiness/visibility,
non per sostituire parser, matching, suggestion, command, preview hint o save flow.

Nota strategica post Documentation Architecture Audit:

Il nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION è completato.

Decisione consolidata:

- una logica fondamentale deve essere completa in un solo documento canonico
- gli altri documenti devono richiamarla esplicitamente
- i documenti core devono restare leggeri e ricostruibili
- lo State non deve duplicare implementazioni lunghe
- la Roadmap non deve duplicare dettagli tecnici estesi
- il Gap Register non deve diventare diario operativo completo
- LOGOS_RETOOL_RUNTIME_REAL va normalizzato per ultimo

Pacchetti completati:

- Pacchetto A completato come allineamento, non riduzione
- Pacchetto B completato sui documenti core governance
- Pacchetto C completato sui documenti tecnici canonici
- Pacchetto D completato su LOGOS_RETOOL_RUNTIME_REAL
- Kernel Manifest aggiornato
- stress test documentale finale completato

------------------------------------------------
NEXT NODES CANDIDATI
------------------------------------------------

1. STATUS SEMANTICS ALIGNMENT

Scopo:

- riallineare il badge OK / Verifica / Attenzione della Sintesi
- evitare che la Sintesi mostri OK quando è presente una card Da verificare significativa
- non modificare save flow
- non modificare button_input_confirm.Disabled
- non trasformare warning non bloccanti in blocchi
- mantenere distinzione tra stato visuale e readiness funzionale

Vincoli:

- nodo Preview/Status dedicato
- nessuna modifica DB
- nessuna modifica payload
- nessuna modifica matching
- nessuna modifica G22
- nessuna anticipazione Input Analysis Model completo

---

2. PREVIEW / MISSING ASSOCIATION NOTICE CLEANUP

Scopo:

- rivalutare il balloon blu “Manca progetto / Manca entità”
- verificare se resta utile nella Sintesi o se crea ridondanza con Suggerimenti associazione
- mantenere distinta la notice informativa dalla suggestion operativa
- migliorare UX mobile senza alterare logica di salvataggio

Vincoli:

- nodo Preview/UX dedicato
- nessuna modifica DB
- nessuna modifica payload
- nessuna modifica save flow
- nessuna modifica create_suggestion_state salvo necessità esplicita

---

3. MATCH ENGINE — MORE SPECIFIC MATCH POLICY / G10A ADVANCED

Scopo:

- mantenere G10A come nodo futuro solo per casi realmente avanzati
- valutare ranking globale, fuzzy matching, alias, gerarchie, deduplicazione o confidence score strutturale
- non riaprire G22 salvo regressione reale

Vincoli:

- non necessario per il caso “20 euro villa sierri”
- non anticipare se i residui sono solo preview/status/micro-copy
- evitare loop con select contextual filtering o Input Analysis Model

---

4. PREVIEW MODEL / HINT STATE CONSOLIDATION

Scopo:

- ridurre ulteriormente la natura ibrida della Sintesi
- consolidare preview_analysis_state come fonte hint/status
- separare meglio hint bloccanti / warning informativi / suggerimenti
- valutare se “Da verificare” debba diventare blocco autonomo
- preparare la Sintesi come view più pura

---

5. CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION

Scopo:

- valutare eliminazione ui_visibility_state
- rimuovere guardie duplicate ormai sostituite da input_analysis_result
- eliminare componenti/query obsolete solo dopo stabilità documentata
- non modificare parser/matching/save flow
- non fare cleanup prima della conclusione documentale

---

6. COMMAND INTENT — EDIT MODE GUIDANCE / GENERIC ALIAS

Scopo:

- migliorare la guida quando l’utente scrive comandi durante edit mode
- valutare riconoscimento di comandi guida generici:
  - modifica
  - correggi
  - cambia
- evitare che “modifica” da solo venga trattato come evento ordinario
- non aprire edit flow automatici

---

7. DATA STRUCTURE / ENTITY HIERARCHY

Scopo:

- valutare gerarchie
- valutare alias
- valutare deduplicazione
- valutare relazioni entity-project
- non introdurre prima di nodo dedicato

---

8. ECONOMIC DIRECTION ADVANCED

Scopo:

- valutare amount firmato
- valutare direction field
- valutare regole contabili per Spesa/Incasso
- non attivo finché matching/data quality/report readiness non saranno stabilizzati

---

9. DURATION ADVANCED — GIORNI / SETTIMANE

Scopo:

- decidere conversione giorni/settimane
- valutare giornata lavorativa
- valutare mezza giornata
- evitare conversioni automatiche ambigue

---

10. SUGGESTION CREATE VS EDIT CONSISTENCY

Scopo:

- verificare differenze suggestion tra create flow e edit flow
- chiarire quando create_suggestion_state deve produrre contenuti operativi in edit mode
- mantenere distinta la notice “Manca progetto/entità” dalla suggestion operativa

---

11. AZIONI RAPIDE OPERATIVE

Scopo:

- rendere operative le Azioni rapide oggi solo predisposte
- collegarle a flow già stabili
- evitare scorciatoie che bypassino input_analysis_result, parser, matching o conferma utente

---

12. DASHBOARD BASE

Scopo:

- attivare la voce Dashboard solo quando Core Event System e data quality saranno sufficientemente consolidati
- definire prime viste aggregate
- evitare KPI prematuri

---

INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION

Stato:

CHIUSO COME RESIDUO UX MINORE ACCETTABILE / IN OSSERVAZIONE

Nota:

Il flash/riga container_input durante transizioni input / command / empty è stato analizzato.
Non è bloccante.
Non genera errori console.
Non modifica dati.
Non impatta parser, matching, payload, save flow o DB.
Non va riaperto salvo peggioramento UX evidente o refactor dedicato della visibility/rendering.

------------------------------------------------
BUTTON CONFIRM READINESS ALIGNMENT
------------------------------------------------

Stato:

COMPLETATO

Nota:

Il nodo G33 ha aggiornato button_input_confirm.Disabled.
La modifica è locale, reversibile e testata.
Il bottone Conferma resta separato da input_analysis_result per la readiness funzionale.
Il payload e il save flow restano invariati.

Disabled ora blocca solo:

- input_raw vuoto
- project_state.data?.isAmbiguous = true senza select_project
- entity_state.data?.isAmbiguous = true senza select_entity

Warning informativi e match più specifici non sono stati trasformati in blocchi.

------------------------------------------------
PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE
------------------------------------------------

Stato:

COMPLETATO

Nota:

Il nodo G22 ha introdotto una policy locale per il caso match presente + suggestion extension.

Esempio:

20 euro villa sierri
→ select_project = Villa
→ suggestion: possibile nuovo progetto Villa Sierri

Comportamento consolidato:

- select_project resta valorizzata
- Conferma resta attiva
- Da verificare mostra:
  Associazione progetto da controllare
  Villa selezionato · testo letto: Villa Sierri
- Suggerimenti associazione mostra:
  Possibile nuovo progetto: Villa Sierri

Caso entity simmetrico:

20 euro mario giordano
→ select_entity = Mario
→ suggestion: possibile nuova entità Mario Giordano

Comportamento consolidato:

- select_entity resta valorizzata
- Conferma resta attiva
- Da verificare mostra:
  Associazione entità da controllare
  Mario selezionata · testo letto: Mario Giordano
- Suggerimenti associazione mostra:
  Possibile nuova entità: Mario Giordano

Il nodo non modifica:

- button_input_confirm.Disabled
- payload
- insert_event / update_event
- save flow
- DB
- Supabase

G10A non è necessario per questo caso.

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

v04 — 2026-04-04  
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

v10 — 2026-04-30  
completamento ENGINE BASE — NORMALIZATION LAYER BASE  
stabilizzazione ui_state.parsed  
normalizzazione amount formato italiano  
normalizzazione unit base  
supporto unità compatte testuali  
rimozione amount senza unità  
rimozione parsing legacy da button_input_confirm  
validazione insert con dati normalizzati  
validazione update con dati normalizzati  
fix refresh lista eventi dopo update  
aggiornamento stato Engine da 0% a 14%  
apertura transizione verso Preview Alignment Base  

v11 — 2026-04-30  
completamento PREVIEW ALIGNMENT BASE  
formattazione italiana amount in preview  
introduzione formatAmountIT  
introduzione formatUnitIT  
euro visualizzato con due decimali  
grouping migliaia visuale  
ore/minuti visualizzati coerentemente  
singolare/plurale unit gestito  
label cleaning preview aggiornato  
rimozione amount/unit dalla label migliorata  
risolto bug "minuti" → "uti"  
separatore data/label uniformato  
introduzione previewStopTokens  
highlight unit-safe  
nessuna modifica a parser, DB, matching o save flow  
transizione verso STEP 6.2 — DURATION NORMALIZATION 

v12 — 2026-04-30  
completamento ENGINE BASE — DURATION NORMALIZATION  
definita unità canonica durata in minuti  
durate certe ore/minuti convertite in minuti  
1 ora → 60 minuti  
1,4 ore → 90 minuti  
1 ora e 14 minuti → 74 minuti  
2h30 → 140 minuti  
2 ore 30 → 140 minuti  
aggiornato parse_input_controlled  
aggiornata preview durata con forma umana  
aggiunto hint “Normalizzato: X minuti”  
aggiunto hint durata ambigua per giorni/settimane  
giorni/settimane non convertiti automaticamente  
raw_input preservato  
nessuna modifica DB  
nessuna modifica button_input_confirm  
nessuna modifica insert_event/update_event  
nessuna modifica matching  
nessuna type classification  
insert/update validati runtime con amount/unit normalizzati  
transizione verso STEP 6.3 — TYPE CLASSIFICATION BASE  

v13 — 2026-04-01  
completamento ENGINE BASE — TYPE CLASSIFICATION BASE  
select1 allineato a ui_state.parsed.unit  
parsed.unit = minuti → Tempo  
euro + keyword controllate di uscita → Spesa  
euro + keyword controllate di entrata → Incasso  
euro senza direzione chiara → Evento  
segnali economici contrastanti → Evento  
scelta manuale utente preservata  
type aggiunto al payload di button_input_confirm  
insert_event salva events.type  
update_event aggiorna events.type  
override manuale validato su Spesa / Incasso  
reset/stale value verificato  
type persistito in DB  
nessuna modifica schema DB  
nessuna modifica parser  
nessuna modifica matching  
nessun refactor preview  
nessun output/KPI anticipato  
linting Retool residuo registrato come anomalia non bloccante  
matching non unificato confermato come prossimo nodo logico  
transizione verso STEP 6.4 — MATCH ENGINE UNIFICATION  

v14 — 2026-04-02  
completamento MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL  
project_state aggiornato come fonte minima matching project  
entity_state aggiornato come fonte minima matching entity  
aggiunti output matches / count / hasMatch / isAmbiguous / singleMatch / moreSpecificMatches / hasMoreSpecificMatches  
select_project allineato a project_state.data.singleMatch  
select_entity allineato a entity_state.data.singleMatch  
trigger_parse_debounced aggiorna parse_input_controlled + project_state + entity_state  
btn_edit aggiorna parse_input_controlled + project_state + entity_state  
match state live in create flow  
match state live in edit flow  
preview hint ambiguità allineati a isAmbiguous  
preview highlight alimentato da matches  
detection locale preview rimossa come fonte decisionale matching  
confirm guard basata su ambiguità non risolta  
ambiguità risolta manualmente non blocca salvataggio  
nessun match non blocca salvataggio  
priority match minimo implementato  
ristrutturazione bagno → Ristrutturazione Bagno  
casa mare → Casa Mare  
villa 2 → Villa 2  
hint informativo match più specifici introdotto  
mario → Mario + hint entità più specifiche  
villa → Villa + hint progetti più specifici  
bug €400 nella label preview risolto  
linting project_state/entity_state ripuliti  
linting residui edit_mode/editing_event mantenuti come nodo futuro  
nessuna modifica DB  
nessuna modifica parser  
nessuna modifica type classification  
nessuna modifica duration normalization  
nessun output/KPI anticipato  
transizione verso NEXT NODE da definire in Roadmap

v14 — 2026-04-02  
completamento UX / CLEANUP MICRO-BATCH POST MATCH ENGINE  
aggiunto btn_cancel_edit in edit mode  
Annulla modifica resetta edit_mode / editing_event / input / select / ui_state.parsed  
Annulla torna alla lista eventi senza update_event  
rafforzato btn_edit per evitare doppia visibilità input/lista  
aggiunta barra ricerca lista eventi  
filtro client-side su raw_input / type / status / project / entity  
nessuna modifica a events_new  
corretta label creato/modificato nella lista eventi  
normalizzazione robusta created_at / updated_at  
marcatore leggero per eventi modificati  
aggiunto no-op edit guard in button_input_confirm  
edit senza modifiche reali non esegue update_event  
updated_at non cambia su conferma senza modifiche  
amount / unit / event_date esclusi dal confronto no-op perché derivati dal parser  
fix input_home change handler per nuovo input da lista eventi  
create flow validato  
edit flow validato  
annulla modifica validato  
search/filter lista validato  
WRITTEN / ERROR validati  
regressione match/type/duration validata  
linting edit_mode/editing_event ancora residui non bloccanti  
DB invariato  
parser invariato  
Match Engine invariato  
Type Classification invariata  
Duration Normalization invariata  
nessun output/KPI anticipato  
transizione verso NEXT NODE da definire in Roadmap

v16 — 2026-04-03  
completamento LINTING / STATE HELPER CLEANUP  
risolto linting Retool edit_mode: 'value' is not defined  
risolto linting Retool editing_event: 'value' is not defined  
rimossa dipendenza da additionalScope { value } per edit_mode / editing_event  
introdotto passaggio controllato tramite window.__logos_edit_mode_value  
introdotto passaggio controllato tramite window.__logos_editing_event_value  
edit_mode ora legge valore tecnico da window.__logos_edit_mode_value  
editing_event ora legge valore tecnico da window.__logos_editing_event_value  
gli helper cancellano la chiave window dopo la lettura  
aggiornato btn_edit  
aggiornato btn_cancel_edit  
aggiornato button_input_confirm nel ramo no-op edit guard  
aggiornato button_input_confirm nel reset finale dopo salvataggio reale  
editing_event viene azzerato anche dopo update reale completato  
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
nessun output/KPI anticipato  
transizione verso NEXT NODE da definire in Roadmap

v17 — 2026-04-07
completamento PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
introdotto create_suggestion_state
introdotte variabili project_create_inline_open / project_create_suggestion_dismissed
introdotte variabili entity_create_inline_open / entity_create_suggestion_dismissed
introdotta query insert_project
introdotta query insert_entity
introdotto container suggestion inline
introdotti micro-editor project/entity
introdotto ignore globale suggestion
introdotti bottoni Annulla contestuali
creazione project inline validata su DB reale
creazione entity inline validata su DB reale
select_project valorizzata dopo creazione project
select_entity valorizzata dopo creazione entity
evento non salvato automaticamente dopo creazione project/entity
evento salvato manualmente con project_id/entity_id corretti
project/entity mancanti non bloccano salvataggio
project/entity ambigui bloccano salvataggio finché non risolti manualmente
select manuale confermata come decisione utente finale
entity autofill controlled minimal implementato
entity autofill validato su Referente Kappa
entity autofill non attivo su materiale nuovo
flow combinato project + entity validato
no-match generico salvabile validato
edit/no-op non regressivo validato
DB schema invariato
parser invariato
type classification invariata
duration normalization invariata
nessun output/KPI anticipato
command intent registrato come nodo futuro
UX cleanup suggestion container registrato come nodo futuro
direzione LOGOS Core modulare riconfermata
istanze ASPRI / ADEXIMA / MaurizioLab confermate come derivate future del core
transizione verso NEXT NODE da definire in Roadmap

v18 — 2026-04-09
completamento UX MOBILE COHERENCE PASS
Home mobile rifinita
card Esempi resa coerente
Azioni rapide rifinite e predisposte
Events list mobile rifinita
Feedback mobile stabilizzato
feedback_summary introdotto in ui_state
handle_event_success disabilitato come gestore UI post-save
success handler UI rimossi da insert_event / update_event
button_input_confirm centralizza feedback e routing post-save
insert reale → feedback 1800 ms → Home
update reale → feedback 1800 ms → Lista eventi
no-op edit → Lista eventi immediata senza update_event
cancel create/input → Home
cancel edit → Lista eventi
Navigation dock Home / Eventi / Dashboard introdotta
Dashboard presente ma disabilitata
nav contestuale visibile in Home vuota e Events list
nav nascosta durante input attivo e feedback
Dati evento compattati con label inline nelle select
Icon add-ons Retool introdotti nei pulsanti reali
font-size input/select portato a 16px per Safari iOS
zoom automatico iOS Safari risolto
select mobile validate sia in digitazione sia in dropdown
validazione reale su iPhone 13 Safari completata
DB invariato
parser invariato
matching invariato
create_suggestion_state invariato
type classification invariata
duration normalization invariata
nessun output/KPI anticipato
transizione verso NEXT NODE da definire in Roadmap

v19 — 2026-04-13
completamento COMMAND INTENT — CREATE PROJECT / ENTITY
introdotto command_intent_state come query Retool page-level
command_intent_state riconosce comandi puri senza salvare dati
gestito comando generico “crea”
gestito create project incompleto
gestito create project completo
gestito create entity incompleto
gestito create entity completo
gestiti sinonimi base crea / aggiungi / inserisci / nuovo / nuova
comandi puri esclusi dal salvataggio evento
container_command_intent introdotto dentro container_input
UI mobile command intent rifinita
btn_command_create_project collegato a insert_project esistente
btn_command_create_entity collegato a insert_entity esistente
btn_command_go_events collegato alla lista eventi
nessuna nuova query DB duplicata per creazione project/entity
elementi già presenti riconosciuti e non duplicati
“crea progetto villa” validato come elemento già presente
“modifica evento” gestito come guida non operativa
nessun edit flow alternativo introdotto
nessuna modifica automatica evento da command
feedback_mode introdotto in ui_state
feedback project_created implementato
feedback entity_created implementato
feedback evento ordinario preservato
feedback_resume adattato a Evento / Progetto / Entità
ritorno Home automatico dopo feedback project/entity validato
routing “Vai agli eventi” validato
evento normale non regressivo validato
edit evento reale non regressivo validato
edit no-op / annulla modifica non regressivi validati
DB invariato
parser invariato
matching invariato
create_suggestion_state invariato
type classification invariata
duration normalization invariata
nessun output/KPI anticipato
residuo “Da verificare” dentro Sintesi documentato
residuo rendering progressivo input evento normale documentato
direzione futura Input Analysis Model / Single Interpretation Layer documentata
transizione verso NEXT NODE da definire in Roadmap

v20 — 2026-04-18
completamento UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
introdotto ui_visibility_state come Transformer read-only
introdotto ui_visibility_mode come Variable Retool
ui_visibility_mode supporta empty / event / command
trigger_parse_debounced aggiorna ui_visibility_mode
introdotto window.__logos_visibility_run_id per evitare update stale da debounce
classificazione locale event/command usata solo per visibilità UI
ui_visibility_state non sostituisce parser, matching, command_intent_state o create_suggestion_state
Hidden principali centralizzati:
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
container_input stabilizzato tramite ui_visibility_state.isInputFlow
container vuoto durante digitazione risolto
flash input flow ridotto
container_app_nav corretto usando input_home.value al posto di input_raw.value
bottom bar flash risolto
text_input_analysis_loading introdotto vicino all’input principale
text_edit_mode_notice introdotto per chiarire edit mode
edit mode prevale su command intent
durante edit mode scrivere “crea” non apre Command Intent
btn_command_create_project / btn_command_create_entity allineati nel timing del feedback
feedback project/entity funzionante con micro-flash residuo
test obbligatori 1–16 superati
DB invariato
parser invariato
matching invariato
create_suggestion_state invariato
command_intent_state invariato
preview content invariato
button_input_confirm payload invariato
insert_event / update_event invariati
insert_project / insert_entity invariati
Input Analysis Model completo non implementato
Event Interpretation Engine non implementato
residuo “modifica” generico non riconosciuto come guida edit documentato
residuo micro-flash feedback project/entity documentato
4 linting Retool residui documentati
transizione verso aggiornamento documentale post UI Readiness

v21 — 2026-04-20
completamento PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
introdotto preview_analysis_state come Transformer read-only
preview_analysis_state raccoglie hint / warning / status / Da verificare / associazioni mancanti della Sintesi
Sintesi aggiornata per leggere hint/status/missing association da preview_analysis_state
layout Sintesi preservato
UX mobile preservata
DB invariato
parser invariato
matching invariato
save flow invariato

completamento INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
introdotto input_analysis_result come layer compositivo read-only
input_analysis_result aggrega input / parsed / type / project / entity / suggestion / command / preview / readiness
introdotta distinzione raw / selection / effective
edit mode prevale su command intent
command raw e command effective distinti
project/entity raw match distinti da project/entity effective
input_analysis_result non sostituisce matching, parser, select, suggestion, command o save flow

completamento INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS
input_analysis_result diventato fonte UI controllata parziale
migrato sintesi.Hidden a input_analysis_result
migrati text_event_data_title / select1 / select_project / select_entity Hidden a input_analysis_result
migrato container_command_intent.Hidden a input_analysis_result
migrato container_association_suggestions.Hidden a input_analysis_result
micro-copy notice associazioni mancanti allineato alla presenza reale dei suggerimenti
bug edit mode + input vuoto corretto
Home idle container nascosti correttamente durante edit mode
Dati evento / Sintesi / Conferma nascosti con edit input vuoto
solo Annulla modifica resta visibile in edit input vuoto
ui_visibility_state resta operativo e non deprecato
container_input / loading / cancel / confirm restano fuori dalla migrazione corrente
button_input_confirm payload invariato
insert_event / update_event invariati
select value/default logic invariata
create_suggestion_state invariato
command_intent_state invariato
DB invariato
linting Retool attuali saliti a 19 e registrati come debito tecnico
prossimo nodo consigliato: INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
nodo parallelo consigliato: LINTING / RETOOL QUERY SAFETY PASS

v22 — 2026-04-23
completamento INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
container_input.Hidden migrato a input_analysis_result.mode.effectiveIsInputFlow
text_input_analysis_loading.Hidden migrato a input_analysis_result
btn_cancel_edit.Hidden migrato a input_analysis_result
btn_cancel_input_home.Hidden migrato a input_analysis_result
button_input_confirm.Hidden migrato a input_analysis_result.readiness.canShowConfirm
introdotto canShowConfirm come flag visibility-only
canConfirm preservato come readiness funzionale distinta
button_input_confirm.Disabled invariato
button_input_confirm payload invariato
rimossa dipendenza input_analysis_result → ui_visibility_state
input_analysis_result non legge più ui_visibility_state
nessun loop tra ui_visibility_state e input_analysis_result
ui_visibility_mode confermato come latch leggero empty / event / command
ui_visibility_state mantenuto come residuo tecnico deprecabile, non cancellato
routing principale container_home / container_feedback / container_events_list confermato su ui_state.view
test visibility migration superati:
- home vuota
- evento normale
- durata normalizzata
- command crea
- command crea progetto Nome Test
- match più specifici
- suggestion project
- edit input pieno
- edit input vuoto

completamento LINTING / RETOOL QUERY SAFETY PASS
linting Retool azzerati
risolti misleading line break before "?" in:
- input_analysis_result
- preview_analysis_state
- create_suggestion_state
- command_intent_state
sostituiti ternari multilinea ambigui con if / else
eliminata query legacy typing_state
eliminata query legacy handle_event_success
Performance unused query risolta
test post-rimozione query superati
DB invariato
parser invariato
matching invariato
command intent invariato nella logica funzionale
suggestion invariata nella logica funzionale
save flow invariato
payload invariato
flash residui digitazione/cambio schermata documentati come nodo futuro
label “Importo” su durata documentata come nodo futuro
policy match più specifici documentata come nodo futuro
prossimo nodo candidato prioritario: DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION

v23 — 2026-04-24

aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION

Pacchetto B — Core Governance avviato su 00_PROJECT_State

applicata riduzione controllata dello State
lo State è stato riportato alla funzione di stato corrente reale del progetto
ridotte duplicazioni tecniche lunghe già coperte da documenti canonici
sostituiti blocchi estesi di runtime con snapshot funzionale consolidato
aggiunte catene runtime sintetiche non interpretative
aggiunti richiami canonici a:
- 01_LOGOS_Input_System per input flow, parser, normalization, type, command e input_analysis_result
- 02_LOGOS_Match_Engine per matching project/entity
- 03_LOGOS_Event_Lifecycle per stati evento, edit, no-op, cancel e processing
- 04_LOGOS_Retool_Architecture per componenti/query/Hidden/wiring Retool
- 04_LOGOS_Database_Schema per schema DB
- 06_LOGOS_View_Preview_System per Sintesi, preview, hint e label visuali
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
- LOGOS_SUPABASE_RUNTIME_REAL per comportamento Supabase as-is

aggiornato NODO ATTIVO a DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION — IN CORSO
documentato Pacchetto A come allineato ma non ridotto
documentato Pacchetto B come avviato
aggiornata sezione OBIETTIVO IMMEDIATO
aggiornata priorità strategica
aggiornata voce NEXT NODES CANDIDATI
mantenuta ricostruibilità totale tramite richiami canonici espliciti
nessuna modifica runtime LOGOS
nessuna modifica Retool
nessuna modifica Supabase
nessuna modifica DB
nessuna modifica parser
nessuna modifica matching
nessuna modifica preview
nessuna modifica save flow
nessuna modifica payload
nessuna anticipazione output / KPI / dashboard

v24 — 2026-04-24

aggiornamento finale post DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION

- State aggiornato da v23 a v24
- nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION registrato come COMPLETATO
- registrato completamento Pacchetto A — Allineamento alto / Lifecycle / Supabase
- registrato completamento Pacchetto B — Core Governance
- registrato completamento Pacchetto C — Documenti tecnici canonici
- registrato completamento Pacchetto D — LOGOS_RETOOL_RUNTIME_REAL / Runtime Manifest Normalization
- registrato aggiornamento 00_PROJECT_KERNEL_MANIFEST a v03
- registrato completamento controllo finale / stress test documentale
- registrato checkpoint finale CHECKPOINT — DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- confermato che le regole permanenti sono state consolidate nel Kernel Manifest
- confermato Principio Fonti Canoniche
- confermata Session Boot Matrix
- confermata regola aggiornamenti futuri
- confermata archiviabilità dei checkpoint precedenti:
  - CHECKPOINT - INPUT ANALYSIS RESULT - VISIBILITY MIGRATION COMPLETION
  - CHECKPOINT — LINTING RETOOL QUERY SAFETY PASS
  - CHECKPOINT — DOCUMENTATION ARCHITECTURE MAP
- aggiornata transizione verso PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT come prossimo nodo operativo consigliato
- chiarito che il prossimo nodo deve restare micro-nodo UX/semantico
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

v24 — 2026-04-26

aggiornamento post PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT

- State aggiornato da v24 a v24
- nodo PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT registrato come COMPLETATO
- registrata risoluzione G36 lato runtime
- registrata correzione label “Importo” su durata
- registrata riga valore Sintesi semanticamente allineata:
  - euro → Importo
  - ore / minuti → Durata
  - fallback non riconosciuto → Valore
- confermato che la modifica è solo visuale / micro-copy
- confermato codice reale Sintesi acquisito prima della modifica
- confermati test runtime superati
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
- documenti tecnici aggiornati:
  - 06_LOGOS_View_Preview_System
  - LOGOS_RETOOL_RUNTIME_REAL
- prossimo nodo operativo consigliato aggiornato a INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION
- nessuna anticipazione Preview Model / Hint State Consolidation
- nessuna anticipazione Button Confirm Readiness Alignment
- nessuna anticipazione cleanup ui_visibility_state
- nessuna anticipazione output / KPI / dashboard

v26 — 2026-06-01

aggiornamento post INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION

- State aggiornato da v25 a v26
- nodo INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION chiuso come RESIDUO UX MINORE ACCETTABILE / IN OSSERVAZIONE
- G29 analizzato su runtime Retool reale
- osservato flash/riga container_input durante transizioni input / command / empty
- confermato comportamento riproducibile ma non bloccante
- confermata console Retool senza errori
- testati Hidden di container_input
- testati Hidden dei figli principali:
  - text_input_analysis_loading
  - text_edit_mode_notice
  - btn_cancel_input_home
  - container_command_intent
- testati layout/stile di container_input
- verificati container_home e wrapper come possibili cause layout
- testata Strada B con micro-latch input_shell_visible
- micro-latch non risolutivo e non mantenuto
- rollback effettuato alla base stabile
- confermato container_input.Hidden basato su input_analysis_result.value?.mode?.effectiveIsInputFlow
- confermato input_home Change handler pre-latch
- nessuna modifica runtime definitiva mantenuta
- nessuna modifica parser
- nessuna modifica parse_input_controlled
- nessuna modifica duration normalization
- nessuna modifica type classification
- nessuna modifica matching
- nessuna modifica project_state/entity_state
- nessuna modifica command_intent_state mantenuta
- nessuna modifica create_suggestion_state
- nessuna modifica input_analysis_result mantenuta
- nessuna modifica preview_analysis_state
- nessuna modifica button_input_confirm.Disabled
- nessuna modifica payload
- nessuna modifica save flow
- nessuna modifica insert_event / update_event
- nessuna modifica DB
- nessuna modifica Supabase
- nessuna eliminazione ui_visibility_state
- nessun cleanup globale
- prossimo nodo operativo consigliato aggiornato a BUTTON CONFIRM READINESS ALIGNMENT
- nessuna anticipazione Preview Model / Hint State Consolidation
- nessuna anticipazione cleanup ui_visibility_state
- nessuna anticipazione output / KPI / dashboard

v27 — 2026-06-01

aggiornamento post BUTTON CONFIRM READINESS ALIGNMENT

- State aggiornato da v26 a v27
- nodo BUTTON CONFIRM READINESS ALIGNMENT registrato come COMPLETATO
- G33 completato su runtime Retool reale
- button_input_confirm.Disabled aggiornato
- Disabled ora legge solo project_state.data?.isAmbiguous e entity_state.data?.isAmbiguous
- rimosso fallback grezzo matches.length > 1 dalla guard Disabled
- confermato button_input_confirm.Hidden invariato
- confermato canShowConfirm come visibility-only
- confermato canConfirm come readiness funzionale distinta
- confermato button_input_confirm.Disabled come guard funzionale separata
- confermato button_input_confirm.Disabled non migrato dentro input_analysis_result
- confermato input_analysis_result invariato
- confermato button_input_confirm payload invariato
- confermati insert_event / update_event invariati
- confermato save flow invariato
- confermato parser invariato
- confermata normalization invariata
- confermata duration normalization invariata
- confermata type classification invariata
- confermato matching invariato nella logica funzionale
- confermati project_state/entity_state come fonti matching
- confermati select_project/select_entity come fonti salvabili finali
- confermato command_intent_state invariato
- confermato create_suggestion_state invariato
- confermato preview_analysis_state invariato
- confermato DB invariato
- confermato Supabase invariato
- test AS-IS eseguiti su evento normale, spesa, durata, no-match, match univoco, warning più specifici, command intent, edit flow
- test mirati eseguiti su dati reali projects/entities
- test post-fix superati:
  - 20 euro materiale
  - 20 euro villa
  - 20 euro villa sierri
  - crea progetto test
- confermato che warning “progetti più specifici” e “entità più specifiche” restano non bloccanti
- rilevato fuori nodo rischio match generico / auto-select confidence
- caso osservato: 20 euro villa sierri → select_project = Villa + suggerimento nuovo progetto Villa Sierri
- deciso di assorbire il tema nel gap G22 Project Create Suggestion — Match Present / User Override
- nessun nuovo gap autonomo creato per evitare ridondanza e loop documentali
- prossimo passo: aggiornamento 00_PROJECT_Gap_Register
- Roadmap da aggiornare solo se cambia la sequenza del prossimo nodo
- nessuna anticipazione Match Engine Advanced
- nessuna modifica select options / candidate filtering
- nessuna modifica save readiness centralizzata
- nessuna anticipazione dashboard / KPI / output

v28 — 2026-06-04

aggiornamento post PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE / AUTO-SELECT CONFIDENCE

- State aggiornato da v27 a v28
- nodo G22 registrato come COMPLETATO
- caso guida 20 euro villa sierri risolto
- match presente + suggestion extension classificato e consolidato
- create_suggestion_state aggiornato con requiresUserOverride
- requiresUserOverride registrato come flag UI derivato
- preview_analysis_state aggiornato per warning mirato G22
- card Da verificare aggiornata con:
  - Associazione progetto da controllare
  - Associazione entità da controllare
- micro-copy consolidata:
  - [baseName] selezionato · testo letto: [candidateName]
  - [baseName] selezionata · testo letto: [candidateName]
- create_suggestion_hint rifinito come area azione
- rimossa duplicazione della selezione corrente dal container Suggerimenti associazione
- separazione semantica consolidata:
  - Da verificare = rischio decisionale
  - Suggerimenti associazione = azione disponibile
- confermato che G22 non blocca Conferma
- confermato che suggestion ignorata non blocca salvataggio
- confermato button_input_confirm.Disabled invariato
- confermato button_input_confirm.Hidden invariato
- confermato payload invariato
- confermati insert_event / update_event invariati
- confermato save flow invariato
- confermato parser invariato
- confermato matching primario invariato
- confermato input_analysis_result invariato
- confermato DB invariato
- confermato Supabase invariato
- test validati:
  - 20 euro villa
  - 20 euro villa sierri
  - 20 euro villa sierri 6
  - 20 euro tecnico mario
  - crea progetto test
  - 20 euro mario rossi
  - 20 euro mario giordano
- confermato che G10A non è necessario per il caso G22
- registrati residui fuori nodo:
  - Status Semantics Alignment
  - Preview / Missing Association Notice Cleanup
  - residui grafici/mobile polish
- prossimo passo: aggiornamento 00_PROJECT_Gap_Register
- Roadmap da aggiornare solo se cambia sequenza o priorità
- nessuna anticipazione Match Engine Advanced
- nessuna anticipazione Input Analysis Model completo
- nessuna anticipazione dashboard / KPI / output