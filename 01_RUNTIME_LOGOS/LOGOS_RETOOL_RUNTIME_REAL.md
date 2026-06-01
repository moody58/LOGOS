# LOGOS_RETOOL_RUNTIME_REAL_v19

DATA: 2026-06-01

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- copertura completa runtime reale  
- input → parsing → normalization → duration normalization → type classification → matching → preview → insert/update → processing  
- script allineati al sistema attuale  
- insert/update flow documentato  
- ui_state.parsed documentato come fonte amount/unit/event_date  
- select1.value documentato come fonte type  
- project_state / entity_state documentati come fonte minima matching  
- select_project / select_entity documentati come derivati da singleMatch  
- confirm guard documentata su ambiguità non risolta  
- create flow e edit flow allineati al match state live  
- preview alignment documentato  
- duration normalization documentata  
- type classification base documentata  
- Match Engine Unification First Controlled Level documentato   
- UX / Cleanup Micro-Batch Post Match Engine documentato
- Linting / State Helper Cleanup documentato
- btn_cancel_edit documentato
- no-op edit guard documentato
- edit_mode / editing_event senza additionalScope { value } documentati
- window.__logos_edit_mode_value / window.__logos_editing_event_value documentati
- Project / Entity Create Suggestion First Controlled Level documentato
- create_suggestion_state documentato
- insert_project / insert_entity documentati
- micro-editor project/entity documentati
- ignore globale suggestion documentato
- entity autofill controlled minimal documentato
- UX Mobile Coherence Pass documentato
- feedback_summary documentato
- feedback mobile stabilizzato
- routing post-save contestuale documentato
- cancel create/edit contestuale documentato
- navigation dock documentata
- handle_event_success non più gestore UI post-save documentato
- font-size 16px input/select mobile Safari documentato
- Command Intent — Create Project / Entity documentato
- command_intent_state documentato
- container_command_intent documentato
- input_command_project_name / input_command_entity_name documentati
- btn_command_create_project / btn_command_create_entity documentati
- btn_command_go_events documentato
- feedback_mode documentato
- feedback project_created / entity_created documentato
- comandi puri esclusi dal save flow evento documentati
- guida “modifica evento” documentata come command non operativo sui dati
- evento ordinario non regressivo dopo Command Intent documentato
- edit flow non regressivo dopo Command Intent documentato
- UI Readiness / Visibility Aggregator First Controlled Level documentato
- ui_visibility_mode documentato come Variable Retool
- ui_visibility_state documentato come Transformer read-only
- trigger_parse_debounced aggiornato con gestione ui_visibility_mode
- window.__logos_visibility_run_id documentato
- Hidden principali storicamente centralizzati tramite ui_visibility_state e successivamente migrati a input_analysis_result
- container_input storicamente stabilizzato tramite ui_visibility_state.isInputFlow e successivamente migrato a input_analysis_result
- container_app_nav micro-fix documentato
- text_input_analysis_loading documentato
- text_edit_mode_notice documentato
- feedback project/entity timing alignment documentato
- micro-flash feedback project/entity residuo documentato
- 5 linting Retool residui documentati
- residuo “modifica” generico non riconosciuto come guida edit documentato
- Preview Analysis State — First Controlled Layer documentato
- preview_analysis_state documentato come Transformer read-only
- hint/status/warning/Da verificare/associazioni mancanti della Sintesi documentati
- Input Analysis Result / Single Interpretation Layer Base — Read-only Diagnostic documentato
- input_analysis_result documentato come Transformer compositivo raw / selection / effective
- Input Analysis Result — Controlled UI Consumption Pass documentato
- controlled partial UI consumption documentata
- sintesi.Hidden migrato a input_analysis_result documentato
- text_event_data_title / select1 / select_project / select_entity Hidden migrati a input_analysis_result documentati
- container_command_intent.Hidden migrato a input_analysis_result documentato
- container_association_suggestions.Hidden migrato a input_analysis_result documentato
- documentato che nella fase Controlled UI Consumption Pass ui_visibility_state era ancora operativo; stato successivamente superato da Visibility Migration Completion
- documentato che container_input / loading / cancel / button_input_confirm erano fuori migrazione nella fase Controlled UI Consumption Pass; stato successivamente superato da Visibility Migration Completion
- edit mode + input vuoto stabilizzato documentato
- Home idle container nascosti durante edit mode documentati
- notice associazioni mancanti coerente con presenza reale suggerimenti documentata
- 19 linting Retool attuali documentati
- Input Analysis Result — Visibility Migration Completion documentato
- container_input.Hidden migrato a input_analysis_result documentato
- text_input_analysis_loading.Hidden migrato a input_analysis_result documentato
- btn_cancel_edit.Hidden migrato a input_analysis_result documentato
- btn_cancel_input_home.Hidden migrato a input_analysis_result documentato
- button_input_confirm.Hidden migrato a input_analysis_result.readiness.canShowConfirm documentato
- canShowConfirm documentato come flag visibility-only
- canShowConfirm distinto da canConfirm documentato
- button_input_confirm.Disabled allineato a project_state/entity_state isAmbiguous documentato
- rimosso fallback grezzo matches.length > 1 dalla guard funzionale Disabled
- button_input_confirm payload preservato invariato documentato
- rimossa dipendenza input_analysis_result → ui_visibility_state documentata
- input_analysis_result non legge più ui_visibility_state documentato
- ui_visibility_state residuo tecnico deprecabile documentato
- ui_visibility_mode confermato come latch leggero empty / event / command documentato
- routing principale container_home / container_feedback / container_events_list confermato su ui_state.view documentato
- Linting / Retool Query Safety Pass documentato
- linting Retool azzerati documentati
- typing_state eliminato come query legacy unused documentato
- handle_event_success eliminato come query legacy unused documentato
- Performance unused query risolta documentata
- label semantica della riga valore Sintesi documentata
- residuo label “Importo” su durata risolto
- flash residui digitazione/cambio schermata documentati
- INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION documentato come nodo analizzato e chiuso senza modifiche runtime definitive
- G29 documentato come residuo UX minore accettabile / in osservazione
- test Hidden / layout / micro-latch documentati in forma sintetica
- rollback alla base stabile documentato

Q (Qualità): 9.5/10  
- runtime reale aggiornato  
- distinzione chiara tra parser, normalization base, duration normalization, type classification, match state, preview e save flow  
- preview allineata visualmente ai dati normalizzati  
- matching project/entity più coerente  
- select / hint / highlight / confirm guard allineati a project_state/entity_state  
- durate certe ore/minuti normalizzate in minuti  
- type persistito in events.type  
- controllo manuale utente preservato  
- debiti residui esplicitati  
- rumore tecnico Retool edit_mode / editing_event eliminato
- runtime edit helper più ricostruibile
- non descrive funzionalità non implementate come attive  
- runtime reale aggiornato dopo Project / Entity Create Suggestion
- runtime reale aggiornato dopo UX Mobile Coherence Pass
- feedback/routing centralizzati in button_input_confirm
- comportamento insert/update/no-op più coerente
- UX mobile validata anche su iPhone 13 Safari reale
- Command Intent introdotto senza duplicare parser, matching o create_suggestion_state
- command_intent_state separato dal save flow evento
- comandi puri create project/entity non vengono trattati come eventi ordinari
- project/entity da command creati solo previa conferma utente
- insert_project / insert_entity riusati come query operative controllate
- “modifica evento” gestito come guida, senza edit flow parallelo
- feedback project/entity distinto dal feedback evento
- UI Readiness introdotta senza creare fonte dati salvabile
- ui_visibility_mode separato da command_intent_state
- ui_visibility_state separato da parser, matching, suggestion e save flow
- flow event / command più stabile
- container vuoto durante digitazione risolto
- bottom bar flash risolto
- edit mode più chiaro grazie a notice dedicata
- Input Analysis Model completo esplicitamente non implementato
- preview_analysis_state riduce la logica hint/status embedded nella Sintesi
- input_analysis_result introduce composizione raw / selection / effective senza creare motore monolitico
- parser, matching, suggestion, command, select e save flow restano moduli specializzati
- input_analysis_result diventa fonte UI controllata parziale
- ui_visibility_state riclassificato come residuo tecnico deprecabile / rollback dopo Visibility Migration Completion
- distinzione missing association notice / suggestion operativa chiarita
- edit mode prevalente su command intent formalizzato a livello effective
- stato intermedio documentato senza dichiarare decommission prematura
- Visibility Migration degli Hidden principali completata senza creare motore monolitico
- input_analysis_result consolidato come fonte UI controllata per Hidden principali del flow input
- canShowConfirm distinto da canConfirm
- visibilità Conferma separata da Disabled/readiness funzionale
- button_input_confirm.Disabled resta guard separata ma ora legge solo isAmbiguous come fonte interpretata
- eliminato rischio futuro di usare matches.length > 1 come blocco funzionale improprio
- button_input_confirm payload preservato invariato
- ui_visibility_state non più letto da input_analysis_result
- ui_visibility_state riclassificato come residuo tecnico deprecabile
- routing principale app mantenuto su ui_state.view
- rumore tecnico Retool ridotto con linting azzerati
- query legacy unused rimosse senza regressioni
- approccio modulare confermato: moduli specializzati calcolano, input_analysis_result compone
- chiarito che il micro-flash container_input è residuo di rendering/timing Retool non bloccante
- evitata documentazione di modifiche non mantenute come runtime attivo
- preservata distinzione tra runtime reale e tentativi non consolidati

D (Deployabilità): 10/10  
- utilizzabile come riferimento tecnico reale  
- allineato a Retool  
- utile per ricostruire il runtime effettivo  
- nodo Preview Alignment Base validato runtime  
- nodo Duration Normalization validato runtime  
- nodo Type Classification Base validato runtime  
- nodo Match Engine Unification First Controlled Level validato runtime       
- nodo UX / Cleanup Micro-Batch Post Match Engine validato runtime
- nodo Linting / State Helper Cleanup validato runtime
- create/edit/annulla/no-op edit/edit reale validati
- WRITTEN / ERROR rivalidati  
- Project / Entity Create Suggestion validato runtime
- insert_project validato su DB reale
- insert_entity validato su DB reale
- UX Mobile Coherence Pass validato runtime
- insert → feedback → Home validato
- update → feedback → Lista eventi validato
- no-op edit → Lista eventi senza update_event validato
- cancel create/edit validato
- font-size 16px validato su iPhone 13 Safari
- select mobile validate sia in digitazione sia in dropdown 
- Command Intent — Create Project / Entity validato runtime
- command_intent_state validato runtime
- btn_command_create_project validato runtime
- btn_command_create_entity validato runtime
- btn_command_go_events validato runtime
- feedback project_created / entity_created validato runtime
- comandi puri non salvano eventi validato runtime
- evento ordinario non regressivo dopo Command Intent validato runtime
- edit flow non regressivo dopo Command Intent validato runtime
- nodo UI Readiness / Visibility Aggregator validato runtime
- ui_visibility_mode validato runtime
- trigger_parse_debounced validato con modalità empty / event / command
- ui_visibility_state validato storicamente come helper UI, oggi residuo tecnico deprecabile / rollback
- Hidden principali migrati progressivamente e oggi governati da input_analysis_result
- container_input validato su empty / event / command / edit mode e oggi governato da input_analysis_result
- container_app_nav validato con bottom bar stabile
- text_input_analysis_loading validato
- text_edit_mode_notice validato
- test obbligatori 1–16 superati
- DB invariato
- parser invariato
- matching invariato
- save flow evento invariato
- Preview Analysis State validato runtime
- input_analysis_result read-only diagnostic validato runtime
- Controlled UI Consumption Pass validato runtime
- sintesi.Hidden migrato a input_analysis_result e validato
- Dati evento / select Hidden migrati a input_analysis_result e validati
- container_command_intent.Hidden migrato a input_analysis_result e validato
- container_association_suggestions.Hidden migrato a input_analysis_result e validato
- edit mode + input vuoto validato
- Home idle container nascosti durante edit mode validati
- notice associazioni mancanti validata
- button_input_confirm mantenuto invariato
- ui_visibility_state mantenuto come residuo tecnico deprecabile / rollback, non più fonte degli Hidden principali migrati
- nodo Input Analysis Result — Visibility Migration Completion validato runtime
- container_input.Hidden validato su input vuoto / evento / command / edit
- text_input_analysis_loading.Hidden validato
- btn_cancel_edit.Hidden validato
- btn_cancel_input_home.Hidden validato
- button_input_confirm.Hidden validato
- button_input_confirm.Disabled aggiornato in modo locale e reversibile
- button_input_confirm payload non modificato
- input_analysis_result non dipende più da ui_visibility_state
- graph Retool verificato post-rimozione dipendenza
- nodo Linting / Retool Query Safety Pass validato runtime
- linting Retool portati a 0
- typing_state eliminato e testato
- handle_event_success eliminato e testato
- Performance unused query risolta
- DB invariato
- parser invariato
- matching invariato
- command intent invariato nella logica funzionale
- suggestion invariata nella logica funzionale
- save flow invariato
- payload invariato
- confermato che nessuna modifica runtime definitiva è stata mantenuta dopo G29
- nodo BUTTON CONFIRM READINESS ALIGNMENT completato
- button_input_confirm.Disabled allineato a isAmbiguous
- payload, insert_event, update_event, parser, matching, preview, command intent e DB invariati
- confermato rollback a container_input.Hidden basato su input_analysis_result.value?.mode?.effectiveIsInputFlow
- confermato input_home Change handler pre-latch
- confermato che input_shell_visible non è parte del runtime attivo

------------------------------------------------
STATO
------------------------------------------------

→ SISTEMA REALE DOCUMENTATO (AS-IS)

Runtime aggiornato dopo completamento:

ENGINE BASE — NORMALIZATION LAYER BASE  
PREVIEW ALIGNMENT BASE  
ENGINE BASE — DURATION NORMALIZATION  
ENGINE BASE — TYPE CLASSIFICATION BASE  
MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL
UX / CLEANUP MICRO-BATCH POST MATCH ENGINE
LINTING / STATE HELPER CLEANUP
PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
UX MOBILE COHERENCE PASS
COMMAND INTENT — CREATE PROJECT / ENTITY
UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS
INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
LINTING / RETOOL QUERY SAFETY PASS
DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
PACCHETTO D — LOGOS_RETOOL_RUNTIME_REAL / RUNTIME MANIFEST NORMALIZATION
PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT
INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION
BUTTON CONFIRM READINESS ALIGNMENT

Nota post INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION:

Il nodo G29 è stato analizzato su runtime Retool reale.

Esito:

- flash/riga container_input osservato durante transizioni input / command / empty
- comportamento riproducibile ma non bloccante
- console Retool senza errori
- nessuna regressione funzionale rilevata
- nessuna modifica runtime definitiva mantenuta
- rollback alla base stabile effettuato

Classificazione:

G29 resta residuo UX minore accettabile / in osservazione.

Non è stato introdotto alcun nuovo helper runtime attivo.
La variabile sperimentale input_shell_visible non è stata mantenuta.

Nota post BUTTON CONFIRM READINESS ALIGNMENT:

Il nodo G33 è stato completato su runtime Retool reale.

Esito:

- button_input_confirm.Disabled aggiornato
- guard funzionale ora basata solo su project_state.data?.isAmbiguous e entity_state.data?.isAmbiguous
- rimosso fallback grezzo su matches.length > 1
- button_input_confirm.Hidden invariato
- canShowConfirm resta visibility-only
- button_input_confirm payload invariato
- insert_event / update_event invariati
- parser invariato
- matching invariato nella logica funzionale
- preview invariata
- command_intent_state invariato
- create_suggestion_state invariato
- DB invariato
- Supabase invariato

Test post-fix:

- 20 euro materiale → Conferma visibile e attiva
- 20 euro villa → Conferma attiva con warning non bloccante “progetti più specifici”
- 20 euro villa sierri → Conferma attiva; rischio match generico rilevato fuori nodo
- crea progetto test → container command visibile, Conferma evento non mostrata

Classificazione:

G33 completato come allineamento locale della readiness funzionale del bottone Conferma.

Il nodo non ha centralizzato la save readiness completa e non ha modificato la policy del Match Engine.

Nota residua fuori nodo:

Il caso “20 euro villa sierri → select_project = Villa + suggerimento nuovo progetto Villa Sierri” evidenzia un tema di Match Present / User Override / Auto-select Confidence da assorbire nel gap G22, non nel nodo G33.

Nota documentale:

Il presente documento viene normalizzato come manifest runtime Retool reale.

Pacchetto A completato.
Pacchetto B completato.
Pacchetto C completato.
Pacchetto D completato su LOGOS_RETOOL_RUNTIME_REAL.

La normalizzazione del manifest non modifica il runtime Retool.
Serve solo a chiarire responsabilità canonica, richiami documentali e stato attuale dei residui tecnici.

------------------------------------------------
RESPONSABILITÀ CANONICA DEL DOCUMENTO
------------------------------------------------

Questo documento è il manifest runtime reale Retool as-is di LOGOS.

È fonte canonica per:

- stato runtime Retool reale
- componenti Retool effettivamente presenti
- query Retool effettivamente presenti
- helper state / transformer Retool effettivamente presenti
- wiring runtime tra componenti, query e helper
- comportamento operativo Retool as-is
- flow create evento reale
- flow edit evento reale
- flow cancel reale
- flow no-op edit reale
- flow command intent reale
- flow project/entity create reale
- flow feedback/routing reale
- flow visibility/readiness reale
- stato effettivo di input_analysis_result
- stato effettivo di preview_analysis_state
- stato effettivo di ui_visibility_mode
- stato effettivo di ui_visibility_state come residuo tecnico deprecabile / rollback
- elenco query attive / eliminate / legacy
- test runtime validati
- debiti runtime Retool residui

Questo documento NON sostituisce i documenti tecnici canonici.

Le logiche complete restano nei documenti madre:

- 01_LOGOS_Input_System per input flow, parser, normalization, Command Intent, create_suggestion_state e input_analysis_result nel contesto input.
- 02_LOGOS_Match_Engine per project_state, entity_state, matching, ambiguità, singleMatch, moreSpecificMatches e confirm guard matching.
- 03_LOGOS_Event_Lifecycle per lifecycle evento, stati NEW / WRITTEN / ERROR, edit, no-op, cancel e processing.
- 04_LOGOS_Retool_Architecture per architettura Retool, componenti, query, Hidden e wiring Retool come modello tecnico.
- 05_LOGOS_Database_Schema per schema DB LOGOS e comportamento Supabase passivo come modello documentale.
- 06_LOGOS_View_Preview_System per Sintesi, preview, hint, warning, label visuali e micro-copy.
- LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase reale as-is.

Regola del manifest:

LOGOS_RETOOL_RUNTIME_REAL documenta ciò che esiste realmente in Retool.

Non deve:

- ricalcolare decisioni tecniche già consolidate
- sostituire i documenti madre
- diventare roadmap
- diventare gap register
- diventare manuale DB
- anticipare refactor
- proporre modifiche runtime non eseguite

Può contenere codice e dettagli operativi se servono a ricostruire il runtime reale.

Può richiamare i documenti canonici per evitare duplicazioni interpretative,
ma non deve perdere il dettaglio Retool necessario alla ricostruzione.

------------------------------------------------
DESCRIZIONE OPERATIVA DEL SISTEMA
------------------------------------------------

Il sistema LOGOS è un Event Operating System client-side
in cui tutta la logica applicativa è gestita in Retool tramite JavaScript.

Supabase funge da storage layer passivo.

Flusso attuale:

INPUT
→ UI VISIBILITY MODE CHECK
→ COMMAND INTENT CHECK
→ se comando puro: CONTAINER COMMAND INTENT
→ COMMAND ACTION / FEEDBACK / ROUTING
→ nessun evento creato

oppure

INPUT
→ UI VISIBILITY MODE CHECK
→ PARSING CONTROLLED
→ NORMALIZATION BASE
→ DURATION NORMALIZATION
→ TYPE CLASSIFICATION BASE
→ MATCH STATE
→ CREATE SUGGESTION STATE
→ PREVIEW ANALYSIS STATE
→ INPUT ANALYSIS RESULT
→ PREVIEW / SINTESI
→ DATI EVENTO / INPUT CONTAINER / LOADING / CANCEL / CONFIRM HIDDEN
→ SELECT PROJECT / ENTITY
→ FEEDBACK SUMMARY
→ INSERT / UPDATE
→ REFRESH LISTA
→ ROUTING POST-SAVE
→ PROCESSING

✔ allineamento save → DB verificato  
✔ insert e update usano ui_state.parsed  
✔ normalizzazione amount/unit base attiva 
✔ duration normalization base attiva  
✔ durate certe ore/minuti salvate in minuti canonici  
✔ type classification base attiva  
✔ select1 allineato a ui_state.parsed.unit  
✔ events.type valorizzato in insert/update  
✔ Spesa / Incasso / Tempo / Evento persistiti nel DB   
✔ preview visualmente allineata a ui_state.parsed  
✔ amount/unit/date mostrati in formato leggibile italiano  
✔ riga valore della Sintesi semanticamente allineata a Importo / Durata / Valore
✔ label Importo usata solo per euro
✔ label Durata usata per ore/minuti
✔ label Valore usata come fallback visuale
✔ update visibile in lista senza refresh pagina 
✔ Match Engine Unification First Controlled Level completato  
✔ project_state / entity_state come fonte minima matching project/entity  
✔ select_project / select_entity alimentati da singleMatch  
✔ hint ambiguità alimentati da isAmbiguous  
✔ confirm guard basata su ambiguità non risolta  
✔ priority match minimo implementato  
✔ hint match più specifici implementato  
✔ preview highlight alimentato da matches  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ bug €500 label preview risolto 
✔ UX / Cleanup Micro-Batch Post Match Engine completato
✔ btn_cancel_edit implementato
✔ no-op edit guard implementato
✔ lista eventi filtrabile
✔ label creato/modificato coerente
✔ Linting / State Helper Cleanup completato
✔ edit_mode / editing_event non usano più additionalScope { value }
✔ linting edit_mode / editing_event risolti
✔ create/edit/annulla/no-op edit/edit reale rivalidati
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ create_suggestion_state implementato
✔ insert_project implementato e validato
✔ insert_entity implementato e validato
✔ project/entity creati inline solo previa conferma utente
✔ evento non salvato automaticamente dopo creazione project/entity
✔ select_project / select_entity restano decisione finale utente
✔ UX Mobile Coherence Pass completato
✔ Home mobile rifinita
✔ Events list mobile rifinita
✔ Feedback mobile stabilizzato
✔ feedback_summary introdotto in ui_state
✔ button_input_confirm centralizza feedback e routing post-save
✔ insert reale → feedback 1800 ms → Home
✔ update reale → feedback 1800 ms → Lista eventi
✔ no-op edit → Lista eventi immediata senza update_event
✔ cancel create/input → Home
✔ cancel edit → Lista eventi
✔ Navigation dock Home / Eventi / Dashboard introdotta
✔ Dashboard presente ma disabilitata
✔ Dati evento compattati con label inline nelle select
✔ Icon add-ons Retool introdotti nei pulsanti reali
✔ font-size input/select 16px validato su Safari iOS
✔ zoom automatico Safari iOS risolto
✔ select mobile funzionanti sia in digitazione sia in dropdown   
✔ Command Intent — Create Project / Entity completato
✔ command_intent_state implementato
✔ comando generico “crea” riconosciuto
✔ create project incompleto gestito
✔ create project completo gestito
✔ create entity incompleto gestito
✔ create entity completo gestito
✔ sinonimi base create supportati: crea, aggiungi, inserisci, nuovo, nuova
✔ container_command_intent implementato
✔ input_command_project_name implementato
✔ input_command_entity_name implementato
✔ btn_command_create_project implementato e validato
✔ btn_command_create_entity implementato e validato
✔ btn_command_go_events implementato e validato
✔ comandi puri non mostrano Sintesi evento / Dati evento
✔ comandi puri non salvano eventi
✔ project/entity da command creati solo previa conferma utente
✔ insert_project / insert_entity riusati da command intent
✔ elemento già presente riconosciuto e non duplicato
✔ “crea progetto villa” validato come elemento già presente
✔ “modifica evento” gestito come guida non operativa
✔ feedback_mode introdotto in ui_state
✔ feedback project_created implementato
✔ feedback entity_created implementato
✔ feedback evento ordinario preservato
✔ evento normale non regressivo dopo Command Intent validato
✔ edit flow non regressivo dopo Command Intent validato 
✔ UI Readiness / Visibility Aggregator completato
✔ ui_visibility_mode implementato
✔ ui_visibility_state presente come residuo tecnico deprecabile / rollback
✔ trigger_parse_debounced aggiorna ui_visibility_mode
✔ window.__logos_visibility_run_id introdotto
✔ Hidden principali del flow input migrati a input_analysis_result
✔ container_input.Hidden migrato a input_analysis_result
✔ container vuoto durante digitazione risolto
✔ flash input flow ridotto
✔ bottom bar flash risolto
✔ text_input_analysis_loading introdotto
✔ text_edit_mode_notice introdotto
✔ edit mode prevale su command intent
✔ feedback project/entity timing allineato
✔ test obbligatori 1–16 superati
✔ Preview Analysis State — First Controlled Layer completato
✔ preview_analysis_state implementato
✔ hint/status/missing association della Sintesi letti da preview_analysis_state
✔ Input Analysis Result / Single Interpretation Layer Base completato come diagnostico
✔ input_analysis_result implementato
✔ raw / selection / effective state introdotti
✔ Input Analysis Result — Controlled UI Consumption Pass completato
✔ input_analysis_result ora fonte UI controllata per gli Hidden principali del flow input
✔ sintesi.Hidden migrato a input_analysis_result
✔ text_event_data_title / select1 / select_project / select_entity Hidden migrati a input_analysis_result
✔ container_command_intent.Hidden migrato a input_analysis_result
✔ container_association_suggestions.Hidden migrato a input_analysis_result
✔ edit mode + input vuoto stabilizzato
✔ Home idle container nascosti durante edit mode
✔ Dati evento / Sintesi / Conferma nascosti con edit input vuoto
✔ solo Annulla modifica resta visibile in edit input vuoto
✔ notice associazioni mancanti coerente con presenza reale suggerimenti
✔ ui_visibility_state resta presente come residuo tecnico deprecabile
✔ button_input_confirm payload invariato
✔ save flow evento invariato
✔ Input Analysis Result — Visibility Migration Completion completato
✔ container_input.Hidden migrato a input_analysis_result
✔ text_input_analysis_loading.Hidden migrato a input_analysis_result
✔ btn_cancel_edit.Hidden migrato a input_analysis_result
✔ btn_cancel_input_home.Hidden migrato a input_analysis_result
✔ button_input_confirm.Hidden migrato a input_analysis_result.readiness.canShowConfirm
✔ canShowConfirm distinto da canConfirm
✔ button_input_confirm.Disabled allineato a isAmbiguous
✔ fallback grezzo matches.length > 1 rimosso dalla guard Disabled
✔ button_input_confirm payload invariato
✔ input_analysis_result non legge più ui_visibility_state
✔ nessun loop input_analysis_result / ui_visibility_state
✔ graph Retool verificato
✔ Linting / Retool Query Safety Pass completato
✔ linting Retool azzerati
✔ typing_state eliminato
✔ handle_event_success eliminato
✔ Performance unused query risolta
✔ INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION analizzato
✔ G29 classificato come residuo UX minore accettabile / in osservazione
✔ nessuna modifica runtime definitiva mantenuta dopo G29
✔ rollback alla base stabile confermato
⚠ micro-flash container_input durante transizioni input / command / empty ancora presente come residuo non bloccante

------------------------------------------------
1. INPUT UTENTE
------------------------------------------------

Componente:

input_home

Ruolo:

- input libero
- campo visibile all’utente
- source of truth lato UX

Caratteristiche:

- non bloccante
- senza validazione formale
- accetta testo naturale
- utilizzato per create/edit

Sync:

input_home
→ input_raw

input_raw è l’adapter tecnico nascosto.

Nota post G29:

Il Change handler di input_home è stato verificato durante il nodo INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION.

Base runtime mantenuta:

const value = input_home.value || "";

// Se l’utente sta scrivendo un nuovo input,
// la lista eventi deve sparire e deve tornare visibile il flow input.
if (value.trim()) {
  ui_state.setValue({
    ...ui_state.value,
    view: "home"
  });

  container_events_list.setHidden(true);
  container_feedback.setHidden(true);
  container_home.setHidden(false);
  container_input.setHidden(false);
}

await input_raw.setValue(value);
trigger_parse_debounced.trigger();

Nota:

La Strada B con micro-latch input_shell_visible è stata testata ma non mantenuta,
perché non ha risolto il flash in modo stabile.

------------------------------------------------
2. INPUT_RAW
------------------------------------------------

Componente:

input_raw

Ruolo:

- adapter tecnico
- hidden
- derivato da input_home
- base per parsing e matching

Il valore di input_raw viene aggiornato da input_home.

Il parsing non viene più eseguito direttamente nel bottone confirm.

------------------------------------------------
3. TRIGGER_PARSE_DEBOUNCED
------------------------------------------------

Nota canonica:

Questo documento conserva il comportamento runtime Retool reale di trigger_parse_debounced.

Per la logica completa dell’input flow, parser, Command Intent e input_analysis_result,
la fonte canonica è:

- 01_LOGOS_Input_System

Per il modello componenti/query/wiring Retool,
la fonte canonica tecnica è:

- 04_LOGOS_Retool_Architecture

Query/script:

trigger_parse_debounced

Ruolo:

- evitare parsing per-lettera
- ridurre trigger inutili
- stabilizzare la UX
- prevenire loop reattivo critico input → parsing → UI
- aggiornare ui_visibility_mode
- distinguere visivamente empty / event / command
- evitare update stale tramite window.__logos_visibility_run_id

Codice runtime concettuale aggiornato:

// Reset micro-editor project/entity quando cambia input principale.
// Evita stati stale tra input consecutivi.
project_create_inline_open.setValue(false);
project_create_suggestion_dismissed.setValue(false);
input_new_project_name.setValue("");

entity_create_inline_open.setValue(false);
entity_create_suggestion_dismissed.setValue(false);
input_new_entity_name.setValue("");

// Classificazione locale minima SOLO per visibilità UI.
const rawText = String(input_home.value || input_raw.value || "")
  .toLowerCase()
  .normalize("NFD")
  .replace(/[\u0300-\u036f]/g, "")
  .replace(/\s+/g, " ")
  .trim();

const runId = Date.now();
window.__logos_visibility_run_id = runId;

if (!rawText) {
  ui_visibility_mode.setValue("empty");
} else {
  const isGenericCreateCommand =
    /^(crea|aggiungi|inserisci|nuovo|nuova)$/.test(rawText);

  const isCreateCommand =
    /^(crea|aggiungi|inserisci|nuovo|nuova)\s+(nuovo\s+|nuova\s+)?(progetto|entita)(\s|$)/.test(rawText);

  const isGuideCommand =
    /^(modifica|correggi|cambia)\s+(un\s+|uno\s+|l'|lo\s+|il\s+)?evento$/.test(rawText) ||
    /^(come\s+)?(modifico|correggo|cambio)\s+(un\s+|uno\s+|l'|lo\s+|il\s+)?evento$/.test(rawText) ||
    /^(devo\s+)?(modificare|correggere|cambiare)\s+(un\s+|uno\s+|l'|lo\s+|il\s+)?evento$/.test(rawText);

  ui_visibility_mode.setValue(
    isGenericCreateCommand || isCreateCommand || isGuideCommand
      ? "command"
      : "event"
  );
}

if (window.__parseTimer) {
  clearTimeout(window.__parseTimer);
}

window.__parseTimer = setTimeout(async () => {
  if (window.__logos_visibility_run_id !== runId) return;

  await Promise.allSettled([
    command_intent_state.trigger(),
    parse_input_controlled.trigger(),
    project_state.trigger(),
    entity_state.trigger()
  ]);

  await create_suggestion_state.trigger();
}, 350);

Comportamento:

input_raw aggiornato
→ reset micro-state creazione inline
→ calcolo rawText
→ aggiornamento ui_visibility_mode
→ salvataggio window.__logos_visibility_run_id
→ debounce
→ controllo runId valido
→ command_intent_state.trigger()
→ parse_input_controlled.trigger()
→ project_state.trigger()
→ entity_state.trigger()
→ create_suggestion_state.trigger()

Risultato:

✔ parser aggiornato  
✔ ui_state.parsed aggiornato  
✔ project_state aggiornato  
✔ entity_state aggiornato  
✔ select_project/select_entity coerenti  
✔ preview hint/highlight coerenti  
✔ confirm guard coerente  
✔ create_suggestion_state aggiornato
✔ micro-editor project/entity resettati al cambio input
✔ suggestion stale evitate tra input consecutivi
✔ command_intent_state aggiornato
✔ comandi puri riconosciuti prima del save flow evento
✔ container_command_intent può sostituire Sintesi evento / Dati evento
✔ ui_visibility_mode aggiornato
✔ empty / event / command distinti a livello visivo
✔ update stale da debounce precedenti ridotti
✔ container vuoto durante digitazione risolto
✔ flash input flow ridotto

Nota:

La classificazione locale in trigger_parse_debounced serve solo alla visibilità UI.

Non sostituisce command_intent_state.

command_intent_state resta la fonte funzionale del command intent.

Limite noto:

“modifica evento” viene riconosciuto come guida command.
“modifica” generico non è ancora riconosciuto come guida edit e resta residuo futuro.

UI_STATE

State Retool:

ui_state

Struttura attuale:

{
  view: "home",
  parsed: {
    amount: null,
    unit: null,
    event_date: null
  },
  status: null,
  feedback_mode: null,
  feedback_text: null,
  feedback_project: null,
  feedback_summary: null
}

feedback_summary:

oggetto UI temporaneo usato dal feedback mobile.

Contiene:

{
  type,
  date,
  amount,
  project,
  entity,
  text
}

Regole:

- creato prima del reset input/select
- usato solo per mostrare il riepilogo feedback
- non salvato nel DB
- non parte del modello dati Supabase
- azzerato dopo auto-return feedback

Ruolo:

controlla vista UI
conserva parsed data
alimenta preview
alimenta insert/update
conserva feedback post-save

feedback_mode:

valore UI temporaneo usato dal feedback mobile.

Valori usati:

- project_created
- entity_created
- null / event_created

Regole:

- non viene salvato nel DB
- non fa parte del modello dati Supabase
- distingue il tipo di feedback mostrato
- viene azzerato dopo auto-return feedback

Nota:

ui_state.parsed alimenta amount/unit/event_date.

Il type non è contenuto in ui_state.parsed.
Il type viene alimentato da select1.value.

Il project/entity matching non è contenuto in ui_state.parsed.

Il matching project/entity è gestito da:

input_raw
→ project_state / entity_state

La scelta finale salvabile resta:

select_project.value
select_entity.value

Quindi:

- ui_state.parsed = amount / unit / event_date
- select1.value = type
- project_state / entity_state = match state
- create_suggestion_state = suggestion project/entity
- command_intent_state = command intent controllato
- select_project.value / select_entity.value = project_id / entity_id
- ui_state.feedback_mode = modalità feedback temporanea
- ui_state.feedback_summary = riepilogo temporaneo feedback

Nota post Input Analysis Result:

ui_state.parsed NON contiene preview_analysis_state.
ui_state.parsed NON contiene input_analysis_result.

preview_analysis_state e input_analysis_result sono Transformer Retool read-only.

preview_analysis_state:

- alimenta hint/status/missing association della Sintesi
- non salva dati
- non costruisce payload
- non modifica DB

input_analysis_result:

- compone raw / selection / effective state
- governa parzialmente la visibilità UI dei componenti migrati
- non salva dati
- non costruisce payload insert/update
- non modifica DB
- non sostituisce parser, matching, suggestion, command, select o save flow

Regola critica:

ui_state.parsed deve restare sempre strutturato.

Non deve tornare:

parsed: null

Forma corretta:

parsed: {
  amount: null,
  unit: null,
  event_date: null
}

------------------------------------------------
UI_VISIBILITY_MODE
------------------------------------------------

Tipo:

Variable Retool

Valori supportati:

- empty
- event
- command

Ruolo:

latch UI leggero per distinguere lo stato visivo dell’input.

Significato:

empty:
input vuoto / nessun flow input attivo

event:
evento ordinario

command:
command intent / guida command

Aggiornato da:

trigger_parse_debounced

Usato da:

- ui_visibility_state
- input_analysis_result

Non è:

- parser
- matching engine
- command intent engine
- Input Analysis Model completo
- fonte business
- fonte salvabile
- fonte DB

Nota:

ui_visibility_mode può anticipare visivamente il flow command,
ma command_intent_state resta la fonte funzionale per capire se un comando è eseguibile.

------------------------------------------------
UI_VISIBILITY_STATE
------------------------------------------------

Tipo:

Transformer Retool legacy/residuo.

Ruolo storico:

aggregatore read-only di visibilità UI per il flow input.

Stato attuale post Visibility Migration Completion:

residuo tecnico deprecabile / rollback.

Non è più fonte canonica della visibility del flow input.
Non è più letto da input_analysis_result.
Non governa più gli Hidden principali migrati.

Resta nel runtime solo per prudenza tecnica,
in attesa di eventuale nodo dedicato:

CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION

Non è più letto da input_analysis_result.
Non governa più gli Hidden principali del flow input.

Motivo della non eliminazione immediata:

- conservare rollback tecnico
- evitare cleanup fuori nodo
- rinviare eliminazione a CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION

Uso attuale:

residuo tecnico / rollback.

Componenti non più governati da ui_visibility_state:

- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden
- sintesi.Hidden
- text_event_data_title.Hidden
- select1.Hidden
- select_project.Hidden
- select_entity.Hidden
- container_command_intent.Hidden
- container_association_suggestions.Hidden

Componenti non governati perché routing principale app:

- container_home.Hidden
- container_feedback.Hidden
- container_events_list.Hidden
- list_events

Regole:

- non salva dati
- non modifica DB
- non modifica parser
- non modifica matching
- non modifica command_intent_state
- non modifica create_suggestion_state
- non modifica preview content
- non costruisce payload
- non sostituisce Input Analysis Model completo
- è deprecabile ma non eliminato
- non deve leggere input_analysis_result
- non introdurre dipendenze circolari tra helper visibility/readiness

------------------------------------------------
PREVIEW_ANALYSIS_STATE
------------------------------------------------

Tipo:

Transformer Retool read-only

Ruolo:

fonte specializzata per hint/status/missing association della Sintesi.

Raccoglie:

- hints
- hasHints
- hasBlockingAmbiguity
- hasWarning
- statusLabel
- statusColor
- statusBg
- dotColor
- missingAssociationTitle
- showMissingAssociationNotice

Uso:

- alimenta la Sintesi per card “Da verificare”
- alimenta status/hint/warning
- viene letto da input_analysis_result

Regole:

- non salva dati
- non modifica parser
- non modifica matching
- non modifica command_intent_state
- non modifica create_suggestion_state
- non modifica save flow
- non modifica DB
- non rende la Sintesi una view pura

------------------------------------------------
INPUT_ANALYSIS_RESULT
------------------------------------------------

Nota canonica:

Questo documento documenta input_analysis_result come runtime Retool reale as-is.

Per la responsabilità canonica completa del layer input_analysis_result nel contesto input,
la fonte madre è:

- 01_LOGOS_Input_System

Per il wiring Retool dei componenti Hidden migrati,
la fonte madre tecnica è:

- 04_LOGOS_Retool_Architecture

Regola:

input_analysis_result governa gli Hidden principali del flow input,
ma non costruisce payload, non sostituisce parser, non sostituisce matching,
non sostituisce Command Intent e non sostituisce create_suggestion_state.

Tipo:

Transformer Retool compositivo read-only

Ruolo:

comporre lo stato operativo dell’input flow.

Legge:

- input_home / input_raw
- ui_visibility_mode
- edit_mode
- command_intent_state
- ui_state.parsed
- select1
- project_state / entity_state
- select_project / select_entity
- create_suggestion_state
- preview_analysis_state

Espone:

- mode
- input
- parsed
- type
- project.raw / project.selection / project.effective
- entity.raw / entity.selection / entity.effective
- suggestion
- command
- preview
- readiness
- diagnostics

Concetti:

raw:
stato tecnico prodotto dai layer esistenti.

selection:
valore attuale delle select.

effective:
stato realmente valido nel flow corrente.

Esempi:

- in command flow, project/entity raw possono esistere ma non sono usabili come dati evento
- in edit mode, command raw può essere true ma command effective viene soppresso
- in event flow, project/entity diventano usabili se coerenti con il flow

Readiness già consumata da UI:

- canShowEventPreview
- canShowCommandContainer
- canShowEventData
- canShowAssociationSuggestions
- canShowConfirm

Componenti già migrati:

- sintesi.Hidden
- text_event_data_title.Hidden
- select1.Hidden
- select_project.Hidden
- select_entity.Hidden
- container_command_intent.Hidden
- container_association_suggestions.Hidden
- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden

Nota post INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION:

container_input.Hidden resta governato da:

{{ !input_analysis_result.value?.mode?.effectiveIsInputFlow }}

Durante G29 sono stati testati:

- Hidden di container_input
- Hidden dei figli principali
- layout/stile di container_input
- container_home
- wrapper
- micro-latch input_shell_visible

Nessun tentativo ha eliminato stabilmente il micro-flash/riga container_input durante transizioni input / command / empty.

Esito:

- nessuna modifica definitiva mantenuta
- input_analysis_result invariato
- command_intent_state invariato
- preview_analysis_state invariato
- button_input_confirm invariato
- payload invariato
- save flow invariato
- DB invariato

Classificazione runtime:

residuo UX minore accettabile / in osservazione.

Componenti / logiche non migrate intenzionalmente:

- button_input_confirm.Disabled, che resta guard funzionale separata anche dopo G33
- button_input_confirm payload
- insert_event / update_event
- save readiness completa
- container_home.Hidden
- container_feedback.Hidden
- container_events_list.Hidden

Nota post G33:

button_input_confirm.Disabled non è stato migrato dentro input_analysis_result.
È stato solo allineato localmente alla fonte interpretata isAmbiguous di project_state/entity_state.

Nota:

container_home / feedback / events_list restano correttamente su ui_state.view
perché appartengono al routing principale dell’app,
non alla visibility interna del flow input.

Regole:

- input_analysis_result non salva dati
- input_analysis_result non modifica DB
- input_analysis_result non modifica parser
- input_analysis_result non ricalcola matching
- input_analysis_result non alimenta select_project / select_entity
- input_analysis_result non modifica create_suggestion_state
- input_analysis_result non modifica command_intent_state
- input_analysis_result non costruisce payload
- input_analysis_result non è ancora Input Analysis Model completo
- input_analysis_result non è Event Interpretation Engine
- input_analysis_result non è un motore monolitico
- input_analysis_result non legge più ui_visibility_state
- input_analysis_result espone canShowConfirm solo per visibilità del bottone
- canConfirm resta readiness funzionale distinta
- button_input_confirm.Disabled resta guard funzionale separata
- button_input_confirm payload resta invariato

Regola anti-loop:

input_analysis_result non legge più ui_visibility_state.
ui_visibility_state non deve leggere input_analysis_result.
Non introdurre dipendenze circolari tra helper visibility/readiness.

------------------------------------------------
HELPER EDIT STATE — RUNTIME
------------------------------------------------

Helper Retool:

- edit_mode
- editing_event

Ruolo:

edit_mode:

- distingue create flow da edit flow
- abilita btn_cancel_edit
- permette a button_input_confirm di scegliere insert_event oppure update_event

editing_event:

- conserva l’evento NEW attualmente in modifica
- permette il confronto no-op con i dati originali
- viene azzerato quando il flow edit termina

Dopo Linting / State Helper Cleanup,
questi helper non usano più:

additionalScope: { value }

Pattern runtime attuale:

- il chiamante scrive una chiave tecnica temporanea su window
- l’helper legge la chiave
- l’helper cancella la chiave dopo la lettura
- l’helper ritorna il valore controllato

Chiavi tecniche:

- window.__logos_edit_mode_value
- window.__logos_editing_event_value

---

EDIT_MODE — codice runtime:

```js
const key = "__logos_edit_mode_value";

if (!Object.prototype.hasOwnProperty.call(window, key)) {
  return false;
}

const nextValue = window[key];

delete window[key];

return Boolean(nextValue);

PRE-PROCESSING

Normalizzazione runtime interna al parser:

lowercase
trim
compressione spazi
riconoscimento unità compatte
riconoscimento simboli
selezione amount per prossimità alla unità

Esempio:

const clean = text.toLowerCase().replace(/\s+/g, " ").trim();

Questa normalizzazione:

✔ non modifica input_home
✔ non modifica raw_input
✔ non modifica direttamente DB
✔ produce solo output strutturato in ui_state.parsed

------------------------------------------------
HELPER VISIBILITY STATE — RUNTIME
------------------------------------------------

Helper Retool:

- ui_visibility_mode
- ui_visibility_state
- preview_analysis_state
- input_analysis_result

Ruolo:

coordinare la visibilità del flow input senza modificare dati salvabili.

Pattern:

input_home / input_raw
→ trigger_parse_debounced
→ ui_visibility_mode
→ preview_analysis_state
→ input_analysis_result
→ Hidden principali del flow input

ui_visibility_state
→ residuo tecnico deprecabile / rollback

Risultato:

✔ Hidden principali del flow input migrati a input_analysis_result
✔ flow event / command più stabile
✔ container_input più stabile
✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto tramite micro-fix dedicato
✔ edit mode più chiaro con notice dedicata

Nota post G29:

Il container vuoto “storico” durante digitazione era stato ridotto/risolto nei nodi precedenti.

Resta però un micro-flash/riga container_input durante specifiche transizioni input / command / empty.

Questo residuo è stato analizzato nel nodo INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION e classificato come:

RESIDUO UX MINORE ACCETTABILE / IN OSSERVAZIONE

Non è bloccante.
Non genera errori console.
Non modifica dati.
Non impatta parser, matching, payload, save flow o DB.

Nota:

ui_visibility_state è UI/readiness strutturale residua.

input_analysis_result è layer compositivo read-only e fonte UI controllata per gli Hidden principali del flow input.

Nessuno dei due è fonte dati salvabile.

Nessuno dei due sostituisce command_intent_state, parser, matching, suggestion, select o save flow.

Nota post Visibility Migration Completion:

ui_visibility_state non è più letto da input_analysis_result
e non governa più gli Hidden principali migrati.

input_analysis_result espone canShowConfirm per la visibilità del bottone Conferma.

button_input_confirm.Disabled e payload restano separati.

PARSING CONTROLLED + NORMALIZATION BASE + DURATION NORMALIZATION

Nota canonica:

Il dettaglio logico completo di parser, normalization base,
duration normalization e type classification nel contesto input
è documentato in:

- 01_LOGOS_Input_System

Questo manifest conserva il runtime reale Retool e gli esempi validati,
senza sostituire il documento madre.

Query/script:

parse_input_controlled

Output:

{
  amount,
  unit,
  event_date
}

Per le durate certe:

amount = totale minuti
unit = "minuti"

Esempio:

2h30 rendering
→ amount 150
→ unit minuti

Utilizzato da:

success handler parser
ui_state.parsed
preview
button_input_confirm
insert_event
update_event

Non più duplicato in:

button_input_confirm

Nota Type Classification Base:

parse_input_controlled non classifica direttamente Spesa/Incasso/Eventi.

Tuttavia il suo output unit viene usato da select1:

parsed.unit = "minuti"
→ select1 = Tempo

6.1 SUCCESS HANDLER parse_input_controlled

Codice runtime:

const parsed = parse_input_controlled.data || {};

ui_state.setValue({
  ...ui_state.value,
  parsed: {
    amount: parsed.amount ?? null,
    unit: parsed.unit ?? null,
    event_date: parsed.event_date ?? null
  }
});

Risultato:

✔ ui_state.parsed sempre strutturato
✔ nessun undefined
✔ fonte unica per save/edit
✔ riduzione drift tra preview e DB

6.2 UNIT NORMALIZATION

Unità supportate:

EURO:

€
euro
eur
€20
20€
€ 20
20 euro

Output:

euro

TEMPO — ORE / MINUTI:

ora
ore
h
min
minuto
minuti

Formati supportati:

1 ora
1ora
2 ore
2ore
2h
h2
2 h
1,5 ore
1.5 ore
1,5h
1.5h
30 min
30min
30 minuti
30minuti
min30
1 ora e 15 minuti
1 ora 15 minuti
2 ore e 30 minuti
2 ore 30
2h30
2 h 30

Output canonico:

minuti

Regola:

tutte le durate certe ore/minuti vengono convertite in minuti.

Esempi:

1 ora → amount 60, unit minuti
2 ore → amount 120, unit minuti
1,5 ore → amount 90, unit minuti
18min → amount 18, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
2h30 → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti

6.3 AMOUNT NORMALIZATION

Amount viene salvato come numero JavaScript / numeric DB,
non come stringa localizzata.

Regole supportate:

458,78 → 458.78
1,5 → 1.5
1.5 → 1.5
1.500 → 1500
1.500,50 → 1500.5
1500 → 1500

Funzione runtime:

function normalizeNumberValue(value) {
  if (value === null || value === undefined || value === "") {
    return null;
  }

  const raw = String(value).trim();

  // Formato italiano con migliaia + decimali:
  // 1.500,50 → 1500.50
  if (/^\d{1,3}(\.\d{3})+,\d+$/.test(raw)) {
    return Number(raw.replace(/\./g, "").replace(",", "."));
  }

  // Formato italiano con separatore migliaia:
  // 1.500 → 1500
  if (/^\d{1,3}(\.\d{3})+$/.test(raw)) {
    return Number(raw.replace(/\./g, ""));
  }

  // Formato con virgola decimale:
  // 458,78 → 458.78
  // 1,5 → 1.5
  if (/^\d+,\d+$/.test(raw)) {
    return Number(raw.replace(",", "."));
  }

  // Formato con punto decimale compatibile:
  // 1.5 → 1.5
  if (/^\d+\.\d+$/.test(raw)) {
    return Number(raw);
  }

  // Intero semplice:
  // 1500 → 1500
  if (/^\d+$/.test(raw)) {
    return Number(raw);
  }

  return null;
}

Regex numeri:

const numbers = cleanForParsing.match(/\d{1,3}(?:\.\d{3})+(?:,\d+)?|\d+(?:[.,]\d+)?/g);

6.4 REGOLA NUMERI SENZA UNITÀ

Regola runtime:

Se non esiste unità riconosciuta:

amount = null;

Esempi:

villa 2 → amount null
villa 2 mario → amount null
cliente 2026 → amount null

Motivo:

evitare interpretazione errata di numeri semantici
preservare raw_input
evitare quantità false nel DB

6.5 DATE PARSING

Formati supportati:

6/4/26
06/04/2026
4 aprile

Output:

YYYY-MM-DD

Esempi:

6/4/26 → 2026-04-06
4 aprile → 2026-04-04

Non supportati:

oggi
domani
ieri
prossima settimana
date relative

6.6 GESTIONE ORARI

Formati:

HH:MM

Comportamento:

✔ ignorati come amount
✔ non considerati unit
✔ mantenuti nel raw_input

Esempio:

15:30 test → amount null, unit null

6.7 DURATION NORMALIZATION BASE

Stato:

✔ implementata

Decisione runtime:

- unità canonica tempo = minuti
- amount = totale minuti
- unit = "minuti"
- raw_input preservato
- nessuna modifica DB
- nessun payload duration
- nessun campo duration_minutes

Casi supportati:

18 minuti → amount 18, unit minuti
18min → amount 18, unit minuti
min30 → amount 30, unit minuti
1 ora → amount 60, unit minuti
1ora → amount 60, unit minuti
2 ore → amount 120, unit minuti
2h → amount 120, unit minuti
h2 → amount 120, unit minuti
1,5 ore → amount 90, unit minuti
1.5 ore → amount 90, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
1 ora 15 minuti → amount 75, unit minuti
2 ore e 30 minuti → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti
2h30 → amount 150, unit minuti
2 h 30 → amount 150, unit minuti
90 minuti → amount 90, unit minuti

Casi non convertiti automaticamente:

2 giorni rendering
1 settimana lavoro
giornata
mezza giornata
due ore
un paio d’ore
2h e mezza

Motivo:

giorni/settimane e forme colloquiali introducono ambiguità operativa.

Comportamento:

2 giorni rendering
→ amount null
→ unit null
→ raw_input preservato
→ preview mostra hint durata ambigua

6.8 LIMITI PARSING / NORMALIZATION

Non implementato:

giorni/settimane come conversione automatica
giornata / mezza giornata
parole numeriche tipo “due ore”
forme colloquiali tipo “un paio d’ore”
2h e mezza
date relative
type classification avanzata
spesa/incasso avanzati
amount firmato
direction field
parole chiave economiche estese
retro-normalizzazione storico

------------------------------------------------
MATCHING — FIRST CONTROLLED LEVEL
------------------------------------------------

Nota canonica:

La logica completa del Match Engine project/entity è documentata in:

- 02_LOGOS_Match_Engine

Questo manifest conserva il runtime reale Retool di project_state,
entity_state, select_project, select_entity e consumatori runtime,
senza sostituire il documento madre.

Eseguito in:

project_state
entity_state

Derivato da:

input_raw
projects_list.data
entities_list.data

Consumatori:

select_project
select_entity
sintesi / preview
button_input_confirm.disabled

---

OUTPUT STANDARD project_state / entity_state:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

PROJECT MATCH:

- normalizzazione testo base
- match su parole significative
- gestione numeri nei nomi progetto
- full name match
- priority match minimo
- rimozione match generici coperti da match specifici
- hint informativo per progetti più specifici

Esempi:

villa → Villa + hint progetti più specifici  
villa 2 → Villa 2  
casa mare → Casa Mare  
ristrutturazione bagno → Ristrutturazione Bagno  

---

ENTITY MATCH:

- normalizzazione testo base
- match su parole significative
- full name match
- priority match minimo
- rimozione match generici coperti da match specifici
- hint informativo per entità più specifiche

Esempi:

mario → Mario + hint entità più specifiche  
mario rossi → Mario Rossi + hint entità più specifiche  
mario rossi alfredo → Mario Rossi Alfredo  
alfie mario rossi → ambiguità reale  

---

AUTO-SELECT:

solo tramite singleMatch

select_project:
→ legge project_state.data.singleMatch

select_entity:
→ legge entity_state.data.singleMatch

---

COMPORTAMENTO:

match univoco:
→ singleMatch valorizzato
→ select_project/select_entity valorizzati
→ conferma abilitata

match ambiguo non risolto:
→ isAmbiguous = true
→ select vuota
→ hint rosso
→ conferma disabilitata

match ambiguo risolto manualmente:
→ select valorizzata dall’utente
→ hint rosso rimosso
→ conferma abilitata

nessun match:
→ select vuota
→ nessun hint ambiguità
→ conferma abilitata

---

RISOLTO A PRIMO LIVELLO:

✔ logiche select non ricalcolano matching  
✔ preview non usa detection locale come fonte decisionale  
✔ hint ambiguità da isAmbiguous  
✔ confirm guard da ambiguità non risolta  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ priority match minimo implementato  
✔ bug €500 preview risolto  

---

NON IMPLEMENTATO:

- fuzzy matching
- alias system
- entity hierarchy
- project hierarchy
- deduplicazione
- ranking avanzato
- match engine separato come modulo autonomo

Nota post Input Analysis Result:

input_analysis_result legge project_state / entity_state,
ma non sostituisce il matching.

project_state / entity_state restano fonte minima matching.
input_analysis_result compone raw / selection / effective usability.

------------------------------------------------
PROJECT_STATE — RUNTIME
------------------------------------------------

Ruolo:

fonte minima del matching project.

Output:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

Comportamento:

- count = 1 → singleMatch valorizzato
- count > 1 → isAmbiguous true
- count = 0 → nessun match
- match più specifici segnalati come hint informativo

Nota:

project_state non salva dati.
project_id viene salvato solo tramite select_project.value.

------------------------------------------------
ENTITY_STATE — RUNTIME
------------------------------------------------

Ruolo:

fonte minima del matching entity.

Output:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

Comportamento:

- count = 1 → singleMatch valorizzato
- count > 1 → isAmbiguous true
- count = 0 → nessun match
- match più specifici segnalati come hint informativo

Nota:

entity_state non salva dati.
entity_id viene salvato solo tramite select_entity.value.

------------------------------------------------
SELECT_PROJECT — DEFAULT VALUE
------------------------------------------------

Logica runtime:

select_project legge project_state.data.singleMatch.

Comportamento:

- se singleMatch esiste → ritorna singleMatch.id
- altrimenti → null

Risultato:

select_project non ricalcola più matching.

------------------------------------------------
SELECT_ENTITY — DEFAULT VALUE
------------------------------------------------

Logica runtime:

select_entity legge entity_state.data.singleMatch.

Comportamento:

- se singleMatch esiste → ritorna singleMatch.id
- altrimenti → null

Risultato:

select_entity non ricalcola più matching.

------------------------------------------------
PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
------------------------------------------------

Eseguito tramite:

create_suggestion_state

Consumatori:

- container_association_suggestions
- btn_open_project_create
- btn_open_entity_create
- input_new_project_name
- input_new_entity_name
- btn_create_project_inline
- btn_create_entity_inline
- bottone Ignora globale
- btn_cancel_project_inline
- btn_cancel_entity_create

Input usati:

- input_raw.value
- project_state.data
- entity_state.data
- projects_list.data
- entities_list.data
- select_project.value
- select_entity.value

Output logico:

create_suggestion_state espone:

- project.noMatch
- project.shouldShowNoMatchHint
- project.shouldSuggestCreate
- project.candidateName
- project.draftName
- project.baseName
- entity.noMatch
- entity.shouldShowNoMatchHint
- entity.shouldSuggestCreate
- entity.candidateName
- entity.draftName
- entity.baseName

Principi:

- suggestion ≠ decisione
- suggestion ≠ salvataggio
- creazione solo previa conferma utente
- evento non salvato automaticamente dopo creazione project/entity
- project/entity mancanti non bloccano Conferma
- project/entity ambigui bloccano Conferma se non risolti manualmente
- project/entity ambigui non permettono nuova creazione
- una sola creazione guidata aperta alla volta
- raw_input resta invariato

Nota post Input Analysis Result:

container_association_suggestions.Hidden ora legge input_analysis_result.readiness.canShowAssociationSuggestions.

La migrazione visibility completata non modifica create_suggestion_state.

create_suggestion_state resta fonte del contenuto operativo.
input_analysis_result decide solo se il container può essere mostrato.

Il contenuto operativo del container resta però governato da create_suggestion_state.

Regola:

missing association notice
≠
suggestion operativa

input_analysis_result può governare la visibilità del container,
ma non deve inventare contenuti se create_suggestion_state non li produce.

Il container non deve apparire vuoto.

PROJECT CREATE FLOW:

1. utente clicca Crea progetto
2. input_new_project_name viene precompilato se candidate sicura
3. utente conferma Crea progetto
4. insert_project crea record in projects
5. projects_list viene aggiornata
6. select_project viene valorizzata con nuovo id
7. micro-editor si chiude
8. evento NON viene salvato automaticamente

ENTITY CREATE FLOW:

1. utente clicca Crea entità
2. input_new_entity_name viene mostrato / precompilato se candidate sicura
3. utente conferma Crea entità
4. insert_entity crea record in entities
5. entities_list viene aggiornata
6. select_entity viene valorizzata con nuovo id
7. micro-editor si chiude
8. evento NON viene salvato automaticamente

ENTITY AUTOFILL CONTROLLED MINIMAL:

Prefissi ammessi:

- referente
- tecnico
- cliente
- fornitore
- operaio
- collaboratore
- contatto
- responsabile
- muratore
- idraulico
- elettricista
- geometra
- architetto

Esempio positivo:

villa sierri 15 sopralluogo referente kappa
→ input_new_entity_name = Referente Kappa

Esempio negativo:

acquisto 50 euro materiale nuovo
→ input_new_entity_name vuoto

IGNORE GLOBALE:

- chiude project_create_inline_open
- chiude entity_create_inline_open
- imposta project_create_suggestion_dismissed = true
- imposta entity_create_suggestion_dismissed = true
- svuota input_new_project_name
- svuota input_new_entity_name
- non modifica input_raw
- non modifica select_project
- non modifica select_entity
- non blocca Conferma

DUPLICATE GUARD:

Project:

- se input_new_project_name esiste già in projects_list
- btn_create_project_inline è disabilitato
- warning duplicato visibile
- insert_project non parte da UI

Entity:

- se input_new_entity_name esiste già in entities_list
- btn_create_entity_inline è disabilitato
- warning duplicato visibile
- insert_entity non parte da UI

------------------------------------------------
COMMAND INTENT — CREATE PROJECT / ENTITY
------------------------------------------------

Eseguito tramite:

command_intent_state

Consumatori:

- container_command_intent
- txt_command_intent_loading
- txt_command_intent_title
- txt_command_intent_description
- txt_command_edit_steps
- divider_command_intent_main
- txt_command_intent_summary
- input_command_project_name
- input_command_entity_name
- btn_command_create_project
- btn_command_create_entity
- btn_command_go_events
- txt_command_intent_notice
- txt_command_intent_guide_notice

Input usati:

- input_home.value
- input_raw.value
- projects_list.data
- entities_list.data

Output logico:

command_intent_state espone:

- isCommand
- isPureCommand
- commandFamily
- commandType
- targetType
- candidateName
- existingId
- needsCompletion
- canExecute
- guideMessage
- rawInput

Principi:

- command intent ≠ evento ordinario
- command intent ≠ salvataggio automatico
- command intent ≠ parser amount/unit/date
- command intent ≠ matching engine
- command intent ≠ create_suggestion_state
- command intent ≠ edit flow automatico
- project/entity da command vengono creati solo previa conferma utente
- comandi puri non salvano eventi
- insert_project / insert_entity restano le query operative
- select_project / select_entity restano decisione finale per eventi ordinari
- input_analysis_result distingue command raw da command effective
- in edit mode il command intent viene soppresso a livello effective
- container_command_intent.Hidden ora legge input_analysis_result.readiness.canShowCommandContainer

---

COMANDO GENERICO

Input:

crea
aggiungi
inserisci
nuovo
nuova

Comportamento:

- mostra guida con esempi
- non mostra Sintesi evento
- non mostra Dati evento
- non salva eventi

---

CREATE PROJECT INCOMPLETO

Input:

crea progetto

Comportamento:

- mostra input_command_project_name
- bottone Crea progetto disabilitato finché il nome è vuoto
- non salva eventi

---

CREATE PROJECT COMPLETO

Input:

crea progetto Villa Nuova
aggiungi progetto Villa Nuova
inserisci progetto Villa Nuova
nuovo progetto Villa Nuova

Comportamento:

- mostra riepilogo progetto
- mostra btn_command_create_project
- crea project solo dopo click utente
- riusa insert_project esistente
- non salva eventi

---

CREATE ENTITY INCOMPLETO

Input:

crea entità

Comportamento:

- mostra input_command_entity_name
- bottone Crea entità disabilitato finché il nome è vuoto
- non salva eventi

---

CREATE ENTITY COMPLETO

Input:

crea entità Patrizio
aggiungi entità Referente Kappa
inserisci entità Marco Parisi
nuova entità Marco Parisi

Comportamento:

- mostra riepilogo entità
- mostra btn_command_create_entity
- crea entity solo dopo click utente
- riusa insert_entity esistente
- non salva eventi

---

ELEMENTO GIÀ PRESENTE

Input:

crea progetto villa

se Villa esiste già.

Comportamento:

- mostra Elemento già presente
- nessun bottone crea
- nessuna duplicazione
- nessun evento salvato
- guida l’utente a usare il dato esistente o un nome più specifico

---

GUIDA MODIFICA EVENTO

Input:

modifica evento
correggi evento
cambia evento
come modifico evento
devo modificare evento

Comportamento:

- mostra guida con step
- mostra btn_command_go_events
- non modifica record
- non apre edit flow automatico
- non salva eventi

Nota post Input Analysis Result:

In edit mode:

- command_intent_state può riconoscere raw command
- input_analysis_result imposta command effective false
- effectiveFlowType resta edit
- container_command_intent resta nascosto
- l’utente resta nel flow modifica evento

Residuo UX:

se l’utente scrive “crea” in edit mode,
manca ancora una guidance esplicita del tipo:

“Se vuoi creare qualcosa, annulla prima la modifica evento.”

---

AZIONI COMMAND

btn_command_create_project:

- legge candidateName o input_command_project_name
- valorizza input_new_project_name
- trigger insert_project
- refresh projects_list
- imposta feedback_mode = project_created
- mostra feedback progetto
- ritorna Home automaticamente
- non crea eventi

btn_command_create_entity:

- legge candidateName o input_command_entity_name
- valorizza input_new_entity_name
- trigger insert_entity
- refresh entities_list
- imposta feedback_mode = entity_created
- mostra feedback entità
- ritorna Home automaticamente
- non crea eventi

btn_command_go_events:

- resetta input command
- refresh events_new
- apre container_events_list
- non modifica eventi
- non crea eventi

------------------------------------------------
TYPE CLASSIFICATION BASE
------------------------------------------------

Componente:

select1

Stato:

✔ implementata

Ruolo:

classificare l’evento in modo minimo, prudente e correggibile dall’utente.

Valori reali disponibili:

- Evento
- Tempo
- Spesa
- Incasso

------------------------------------------------
LOGICA ATTUALE
------------------------------------------------

Fonte primaria per Tempo:

ui_state.parsed.unit

Regola:

parsed.unit = "minuti"
→ Tempo

Motivo:

dopo Duration Normalization tutte le durate certe ore/minuti vengono salvate come:

amount = totale minuti
unit = minuti

Esempi:

2h30 rendering
→ parsed.amount = 150
→ parsed.unit = minuti
→ select1 = Tempo

1 ora lavoro
→ parsed.amount = 60
→ parsed.unit = minuti
→ select1 = Tempo

18min test
→ parsed.amount = 18
→ parsed.unit = minuti
→ select1 = Tempo

---

SPESA:

Regola:

euro + keyword controllate di uscita
→ Spesa

Keyword base:

- spesa
- acquisto
- acquistato
- comprato
- pagato
- pagamento
- costo
- costi
- uscita
- acconto dato
- acconto versato
- saldo pagato
- saldo versato

Esempi:

20 euro spesa materiale
→ select1 = Spesa

20 euro acquisto materiale
→ select1 = Spesa

20 euro pagato materiale
→ select1 = Spesa

20 euro acconto dato
→ select1 = Spesa

---

INCASSO:

Regola:

euro + keyword controllate di entrata
→ Incasso

Keyword base:

- incasso
- incassato
- entrata
- vendita
- venduto
- pagamento ricevuto
- acconto ricevuto
- saldo ricevuto

Esempi:

20 euro incasso cliente
→ select1 = Incasso

20 euro vendita cucciolo
→ select1 = Incasso

20 euro acconto ricevuto
→ select1 = Incasso

20 euro pagamento ricevuto
→ select1 = Incasso

---

EVENTO / FALLBACK PRUDENTE:

Regola:

euro senza direzione chiara
→ Evento

segnali economici contrastanti
→ Evento

nessuna unit significativa
→ Evento

Esempi:

20 euro materiale
→ select1 = Evento

20 euro acconto
→ select1 = Evento

20 euro spesa incasso
→ select1 = Evento

materiale ricevuto 20 euro
→ select1 = Evento

saldo 20 euro
→ select1 = Evento

villa 2 mario
→ select1 = Evento

2 giorni rendering
→ select1 = Evento

4 aprile benzina 50 euro alfie allevamento aspri
→ select1 = Evento

Nota:

"benzina" non viene classificata automaticamente come Spesa.
È una parola di dominio, non una direzione contabile esplicita.

------------------------------------------------
CODICE RUNTIME select1 — DEFAULT VALUE
------------------------------------------------

{{
(() => {
  const text = (input_raw.value || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");

  const parsed = ui_state.value?.parsed || {};
  const parsedUnit = String(parsed.unit || "").toLowerCase();

  if (parsedUnit === "minuti") {
    return "Tempo";
  }

  const hasEuro =
    parsedUnit === "euro" ||
    /€|\beuro\b|\beur\b/.test(text);

  const isIncasso =
    /\bincasso\b/.test(text) ||
    /\bincassato\b/.test(text) ||
    /\bentrata\b/.test(text) ||
    /\bvendita\b/.test(text) ||
    /\bvenduto\b/.test(text) ||
    /\bpagamento ricevuto\b/.test(text) ||
    /\bacconto ricevuto\b/.test(text) ||
    /\bsaldo ricevuto\b/.test(text);

  const isSpesa =
    /\bspesa\b/.test(text) ||
    /\bacquisto\b/.test(text) ||
    /\bacquistato\b/.test(text) ||
    /\bcomprato\b/.test(text) ||
    /\bpagato\b/.test(text) ||
    /\bpagamento\b/.test(text) ||
    /\bcosto\b/.test(text) ||
    /\bcosti\b/.test(text) ||
    /\buscita\b/.test(text) ||
    /\bacconto dato\b/.test(text) ||
    /\bacconto versato\b/.test(text) ||
    /\bsaldo pagato\b/.test(text) ||
    /\bsaldo versato\b/.test(text);

  if (isIncasso && isSpesa) {
    return "Evento";
  }

  if (isIncasso) {
    return "Incasso";
  }

  if (isSpesa) {
    return "Spesa";
  }

  if (hasEuro) {
    return "Evento";
  }

  return "Evento";
})()
}}

------------------------------------------------
CONTROLLO UTENTE
------------------------------------------------

La classificazione automatica è base.

L’utente può sempre modificare manualmente select1.

La scelta manuale prevale sul default automatico
e viene salvata in events.type.

Validato:

20 euro materiale
→ default Evento
→ utente seleziona Spesa
→ DB: type Spesa

20 euro materiale
→ default Evento
→ utente seleziona Incasso
→ DB: type Incasso

------------------------------------------------
PERSISTENZA TYPE
------------------------------------------------

Catena runtime:

select1.value
→ payload.type
→ insert_event / update_event
→ events.type

Insert:

✔ salva type

Update:

✔ aggiorna type

Esempi DB validati:

2h30 rendering
→ type Tempo
→ amount 150
→ unit minuti

20 euro spesa materiale
→ type Spesa
→ amount 20
→ unit euro

20 euro incasso cliente
→ type Incasso
→ amount 20
→ unit euro

20 euro materiale
→ type Evento
→ amount 20
→ unit euro

villa 2 mario
→ type Evento
→ amount null
→ unit null

------------------------------------------------
LIMITI TYPE
------------------------------------------------

Non implementato:

- classificazione economica avanzata
- dizionario esteso keyword
- parole di dominio automatiche
- amount firmato
- direction field
- report/KPI
- retro-normalizzazione eventi storici

Nota:

type è ora persistito come classificazione base,
ma non abilita ancora automaticamente reportistica o KPI.

PREVIEW / SINTESI

Nota canonica:

Il comportamento visuale e semantico completo della Sintesi / Preview
è documentato in:

- 06_LOGOS_View_Preview_System

Questo manifest conserva le fonti runtime Retool lette dalla Sintesi,
gli helper coinvolti e i test validati,
senza sostituire il documento madre della preview.

Costruita da:

input_raw
ui_state.parsed
select_project
select_entity
project_state
entity_state
select1
liste projects/entities
preview_analysis_state
input_analysis_result per visibilità/readiness parziale
ui_visibility_state solo come stato strutturale residuo / raw diagnostic indiretto

Nota Command Intent:

La preview non rappresenta comandi puri come eventi.

Per input come:

- crea
- crea progetto Villa Nuova
- crea entità Patrizio
- modifica evento

la Sintesi evento deve essere nascosta
e deve essere mostrato container_command_intent.

Dopo Input Analysis Result Controlled UI Consumption,
questa visibilità è governata tramite:

input_analysis_result.readiness.canShowEventPreview
input_analysis_result.readiness.canShowCommandContainer

Nota:

select1 alimenta il type visuale e il payload di salvataggio.
La preview può mostrare/supportare il type,
ma non salva direttamente il dato.

MAIN:

event_date + amount + unit + label

META:

project + entity

HINT:

hint/status da preview_analysis_state
suggerimenti matching
suggerimenti tipo
hint durata ambigua

Caratteristiche:

✔ non modifica input
✔ non blocca
✔ non modifica DB
✔ visualizza i dati principali parsati
✔ supporta create/edit
✔ legge amount/unit/event_date da ui_state.parsed
✔ visualizza amount/unit in formato italiano
✔ visualizza durata normalizzata in forma umana
✔ mostra label valore semantica: Importo per euro, Durata per ore/minuti, Valore come fallback
✔ usa icona valore dinamica: € per euro, ⏱️ per durata, 🔢 per fallback
✔ mostra hint “Normalizzato: X minuti”
✔ mostra hint durata ambigua per giorni/settimane
✔ separa correttamente data e descrizione
✔ applica label cleaning sui casi già normalizzati
✔ highlight locale reso unit-safe

Limiti:

⚠ contiene logiche di trasformazione
⚠ contiene label cleaning
✔ hint/status principali separati a primo livello in preview_analysis_state
⚠ contiene ancora rendering HTML, label cleaning e micro-copy finale
⚠ utilizza fonti multiple
⚠ non è view pura
✔ matching project/entity letto da project_state/entity_state
✔ hint ambiguità matching alimentati da isAmbiguous
✔ highlight alimentato da matches
✔ detection locale preview non più fonte decisionale matching
⚠ preview resta layer ibrido
⚠ hint duration/type ancora embedded nella preview
⚠ “Da verificare” resta interno alla Sintesi
✔ rendering progressivo input evento normale ridotto tramite UI Readiness
⚠ micro-flash feedback project/entity ancora presente
⚠ “modifica” generico non ancora riconosciuto come guida edit
⚠ status OK + card Da verificare ancora da riallineare semanticamente

VALUE BUILDER:

Il value builder della sintesi costruisce il valore visuale partendo da ui_state.parsed.

Funzioni runtime introdotte:

formatAmountIT
formatUnitIT
formatDurationHumanIT
formatDurationMinutesIT

Label runtime riga valore:

valueRowLabel
valueRowIcon

Regola:

- parsedUnit = euro → label Importo, icona €
- parsedUnit = ore / minuti → label Durata, icona ⏱️
- altro valore non riconosciuto → label Valore, icona 🔢

Comportamento:

- euro → simbolo €
- euro → due decimali
- amount euro con grouping migliaia
- ore/minuti → massimo due decimali
- virgola italiana nei decimali
- singolare/plurale unit gestito

Esempi:

1500 euro materiale
→ 1.500,00 € • materiale

1.500,50 euro materiale
→ 1.500,50 € • materiale

1ora lavoro
→ 1 ora • lavoro
→ Normalizzato: 60 minuti

18min test
→ 18 minuti • test

2,7 ore sviluppo sistema aspri
→ 2 ore 42 minuti • sviluppo sistema aspri
→ Normalizzato: 162 minuti

1 ora e 15 minuti sopralluogo
→ 1 ora 15 minuti • sopralluogo
→ Normalizzato: 75 minuti

2h30 rendering
→ 2 ore 30 minuti • rendering
→ Normalizzato: 150 minuti

TYPE CLASSIFICATION BASE — ESEMPI:

2h30 rendering
→ preview: 2 ore 30 minuti • rendering
→ select1: Tempo
→ DB: type Tempo, amount 150, unit minuti

20 euro materiale
→ preview: 20,00 € • materiale
→ select1: Evento
→ scelta manuale richiesta se è Spesa o Incasso

20 euro spesa materiale
→ preview: 20,00 € • spesa materiale
→ select1: Spesa
→ DB: type Spesa, amount 20, unit euro

REGOLA CRITICA:

La formattazione italiana è solo visuale.

Il dato interno resta numerico.

Esempio:

input:
1.500,50 euro

ui_state.parsed.amount:
1500.5

ui_state.parsed.unit:
euro

preview:
1.500,50 €

DB:
amount 1500.5
unit euro

PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT — CODICE RUNTIME

La riga valore della Sintesi non usa più la label fissa “Importo”.

Codice runtime aggiunto:

```js
const valueRowLabel =
  parsedUnit === "euro"
    ? "Importo"
    : parsedUnit === "ore" || parsedUnit === "minuti"
      ? "Durata"
      : value
        ? "Valore"
        : "Valore";

const valueRowIcon =
  parsedUnit === "euro"
    ? "€"
    : parsedUnit === "ore" || parsedUnit === "minuti"
      ? "⏱️"
      : "🔢";

MATCH ENGINE UNIFICATION — ESEMPI:

villa 2 mario
→ preview evidenzia villa 2 come project
→ preview evidenzia mario come entity
→ confirm abilitato

4 aprile benzina 50 euro alfie allevamento aspri
→ project ASPRI
→ entity ambigua
→ hint Più entità trovate
→ confirm disabilitato finché non viene scelta entità

mario
→ entity Mario
→ hint Esistono entità più specifiche
→ confirm abilitato

villa
→ project Villa
→ hint Esistono progetti più specifici
→ confirm abilitato

€500 acconto alfie mario rossi
→ 500,00 € • acconto alfie mario rossi
→ bug duplicazione €500 risolto

LABEL CLEANING PREVIEW:

La label viene generata runtime nella sintesi.

Aggiornamenti Preview Alignment Base:

✔ rimozione amount + unit già rappresentati dal value  
✔ gestione euro separati e compatti  
✔ gestione ore separate e compatte  
✔ gestione minuti separati e compatti  
✔ bug "minuti" → "uti" risolto  
✔ numeri semantici preservati  
✔ data rimossa dalla label se già rappresentata come displayDate  
✔ durate composte rimosse dalla label se già rappresentate dal value  
✔ forme compatte tipo 2h30 rimosse dalla label  
✔ residui congiunzione “e/ed” rimossi dopo cleaning durata  
✔ gestione € prima del numero corretta  
✔ bug duplicazione €500 risolto  

Esempi:

1.500,50 euro materiale
→ 1.500,50 € • materiale

18 minuti test
→ 18 minuti • test

18min test
→ 18 minuti • test

villa 2 mario
→ villa 2 mario

DATE DISPLAY:

La data viene formattata in forma breve:

YYYY-MM-DD → d mese breve

Esempi:

2026-04-06 → 6 apr
2026-04-04 → 4 apr

La data viene separata dalla descrizione anche quando non esiste amount/unit.

Esempio:

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

HIGHLIGHT UNIT-SAFE:

È stato introdotto filtro locale per evitare che unità tecniche vengano evidenziate come match.

Token esclusi:

ora
ore
h
min
minuto
minuti
euro
eur
giorno
giorni
settimana
settimane
giornata
giornate

Funzioni runtime:

previewStopTokens
getPreviewTokens

Risultato:

2 ore sopralluogo villa 2
→ "ore" non viene più colorato impropriamente

Nota:

il filtro token tecnici resta utile per evitare highlight impropri.

Dopo Match Engine Unification First Controlled Level,
l’highlight project/entity legge però i matches da:

- project_state.data.matches
- entity_state.data.matches

La preview non usa più detection locale come fonte decisionale matching.

LABEL RUNTIME

Eseguita in:

sintesi / preview

Caratteristiche:

✔ generata runtime
✔ non persistita
✔ derivata da raw_input
✔ utile per UX
✔ allineata ai casi normalizzati principali
✔ non modifica ui_state.parsed
✔ non modifica DB

Operazioni:

rimozione amount + unit già rappresentati dal value
rimozione date già parse
normalizzazione spazi
preservazione numeri semantici
compound token
gestione unità compatte

Aggiornamenti validati:

✔ euro separati / compatti rimossi dalla label  
✔ ore separate / compatte rimosse dalla label  
✔ minuti separati / compatti rimossi dalla label  
✔ bug "minuti" → "uti" risolto  
✔ "villa 2" preservato  
✔ data separata dalla descrizione 
✔ durate composte rimosse correttamente dalla label  
✔ hint normalizzazione durata aggiunto  
✔ hint durata ambigua aggiunto   

Limiti:

⚠ non è modulo separato
⚠ non è riutilizzabile
⚠ embedded nella preview
⚠ non è view pura

INSERT / UPDATE EVENT

Nota canonica:

Questo manifest documenta il runtime reale di button_input_confirm,
insert_event, update_event, feedback/routing e no-op edit guard.

Per il lifecycle evento la fonte canonica è:

- 03_LOGOS_Event_Lifecycle

Per lo schema DB e i campi persistiti la fonte canonica è:

- 05_LOGOS_Database_Schema

Per il wiring Retool generale la fonte canonica tecnica è:

- 04_LOGOS_Retool_Architecture

Componente:

button_input_confirm

Ruolo:

costruisce payload
esegue no-op edit guard
costruisce feedback_summary
mostra feedback mobile
resetta input/select
lancia insert_event o update_event
aggiorna events_new dopo save
gestisce routing post-save contestuale
non gestisce command intent
non salva comandi puri come eventi
ha Hidden migrato a input_analysis_result, ma Disabled e payload restano separati

Principio:

button_input_confirm NON esegue più parsing.

Fonte dati:

const parsed = ui_state.value?.parsed || {
  amount: null,
  unit: null,
  event_date: null
};

Payload:

const payload = {
  raw_input: input_raw.value,
  type: select1.value || "Evento",
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
};

EDIT MODE:

edit_mode = false → insert_event
edit_mode = true → update_event

VINCOLI:

Conferma disabilitata se:

- input_raw vuoto
- project_state.data?.isAmbiguous = true e select_project vuoto
- entity_state.data?.isAmbiguous = true e select_entity vuoto

Conferma abilitata se:

- match univoco
- nessun match
- match generico con warning non bloccante
- match più specifici segnalati come hint informativo
- ambiguità risolta manualmente

Il bottone non ricalcola matching.
Il bottone non usa più matches.length > 1 come criterio grezzo di blocco.
Legge solo lo stato interpretato già disponibile da project_state/entity_state.

Regola Command Intent:

button_input_confirm resta dedicato agli eventi ordinari.

Dopo Input Analysis Result Visibility Migration Completion,
il filtro visivo principale degli Hidden del flow input avviene tramite:

- ui_visibility_mode
- input_analysis_result

button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm.
button_input_confirm.Disabled e payload restano separati.

La separazione funzionale resta in command_intent_state.

Se command_intent_state riconosce un comando puro:

- button_input_confirm non deve essere mostrato
- insert_event / update_event non devono essere eseguiti
- container_command_intent gestisce la UI command
- btn_command_create_project / btn_command_create_entity / btn_command_go_events gestiscono l’azione command

11.1 BUTTON_INPUT_CONFIRM — CODICE LOGICO

// --- INSERT / UPDATE SWITCH ---
const parsed = ui_state.value?.parsed || {};

const payload = {
  raw_input: input_raw.value,
  type: select1.value || "Evento",
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
};

// --- NO-OP EDIT GUARD ---
const wasEditMode = edit_mode.data;
const originalEvent = editing_event.data;

const normalizeComparable = (value) => {
  if (value === undefined || value === "") return null;
  return value;
};

const sameText =
  String(normalizeComparable(payload.raw_input) || "") ===
  String(normalizeComparable(originalEvent?.raw_input) || "");

const sameType =
  String(normalizeComparable(payload.type) || "Evento") ===
  String(normalizeComparable(originalEvent?.type) || "Evento");

const sameProject =
  String(normalizeComparable(payload.project_id) || "") ===
  String(normalizeComparable(originalEvent?.project_id) || "");

const sameEntity =
  String(normalizeComparable(payload.entity_id) || "") ===
  String(normalizeComparable(originalEvent?.entity_id) || "");

const isSamePayload =
  wasEditMode &&
  originalEvent &&
  sameText &&
  sameType &&
  sameProject &&
  sameEntity;

if (isSamePayload) {
  if (window.__parseTimer) {
    clearTimeout(window.__parseTimer);
    window.__parseTimer = null;
  }

  trigger_parse_debounced.cancel?.();

  window.__logos_edit_mode_value = false;
  await edit_mode.trigger();

  window.__logos_editing_event_value = null;
  await editing_event.trigger();

  await input_home.setValue("");
  await input_raw.setValue("");

  select_project.clearValue();
  select_entity.clearValue();
  select1.clearValue?.();

ui_state.setValue({
  ...ui_state.value,
  view: "events",
  parsed: {
    amount: null,
    unit: null,
    event_date: null
  },
  status: "idle",
  feedback_mode: null,
  feedback_text: null,
  feedback_project: null,
  feedback_summary: null
});

  container_input.setHidden(true);
  container_home.setHidden(true);
  container_feedback.setHidden(true);
  container_events_list.setHidden(false);

  return;
}

// --- FEEDBACK SUMMARY ---
const feedbackText = input_raw.value;
const feedbackProject = select_project.selectedItem?.name || null;
const feedbackEntity = select_entity.selectedItem?.name || null;

const feedbackSummary = {
  type: payload.type || "Evento",
  date: formatFeedbackDate(payload.event_date),
  amount: formatFeedbackAmount(payload.amount, payload.unit),
  project: feedbackProject || "—",
  entity: feedbackEntity || "—",
  text: feedbackText || "—"
};

// RESET INPUT / SELECT PRIMA DEL FEEDBACK
// Il feedback viene impostato come ultimo stato UI visibile.

if (window.__parseTimer) {
  clearTimeout(window.__parseTimer);
  window.__parseTimer = null;
}

trigger_parse_debounced.cancel?.();

await input_home.setValue("");
await input_raw.setValue("");

select_project.clearValue();
select_entity.clearValue();
select1.clearValue?.();

ui_state.setValue({
  ...ui_state.value,
  parsed: {
    amount: null,
    unit: null,
    event_date: null
  },
  status: "success",
  view: "feedback",
  feedback_mode: null,
  feedback_text: feedbackText,
  feedback_project: feedbackProject,
  feedback_summary: feedbackSummary
});

container_home.setHidden(true);
container_input.setHidden(true);
container_events_list.setHidden(true);
container_feedback.setHidden(false);

// SALVATAGGIO
const savePromise = wasEditMode
  ? update_event.trigger({ additionalScope: payload })
  : insert_event.trigger({ additionalScope: payload });

await savePromise;
await events_new.trigger();

if (wasEditMode) {
  window.__logos_edit_mode_value = false;
  await edit_mode.trigger();

  window.__logos_editing_event_value = null;
  await editing_event.trigger();
}

// --- AUTO RETURN AFTER FEEDBACK ---
const returnViewAfterFeedback = wasEditMode ? "events" : "home";

if (window.__logos_feedback_timer) {
  clearTimeout(window.__logos_feedback_timer);
  window.__logos_feedback_timer = null;
}

window.__logos_feedback_timer = setTimeout(() => {
  ui_state.setValue({
  ...ui_state.value,
  view: returnViewAfterFeedback,
  parsed: {
    amount: null,
    unit: null,
    event_date: null
  },
  status: "idle",
  feedback_mode: null,
  feedback_text: null,
  feedback_project: null,
  feedback_summary: null
});

  container_feedback.setHidden(true);
  container_input.setHidden(true);

  if (returnViewAfterFeedback === "events") {
    container_home.setHidden(true);
    container_events_list.setHidden(false);
  } else {
    container_events_list.setHidden(true);
    container_home.setHidden(false);
  }

  window.__logos_feedback_timer = null;
}, 1800);

Nota:

formatFeedbackDate e formatFeedbackAmount sono helper locali usati per costruire feedback_summary.
Il loro output è solo UI.
Non viene salvato nel DB.

Risultati:

✔ parsing legacy rimosso
✔ save flow pulito
✔ type salvato tramite select1.value
✔ feedback immediato
✔ update lista corretto
✔ no-op edit guard attivo
✔ edit senza modifiche reali non esegue update_event
✔ updated_at non cambia su edit no-op
✔ edit_mode reset senza additionalScope { value }
✔ editing_event reset senza additionalScope { value }
✔ editing_event azzerato anche dopo update reale completato
✔ nessuna divergenza save/DB osservata
✔ feedback_summary introdotto
✔ feedback mobile stabilizzato
✔ feedback mostrato come ultimo stato UI visibile
✔ handle_event_success eliminato come query legacy unused
✔ insert_event/update_event non devono avere success handler UI duplicati
✔ routing post-save contestuale
✔ insert reale → feedback 1800 ms → Home
✔ update reale → feedback 1800 ms → Lista eventi
✔ no-op edit → Lista eventi immediata senza feedback

BUTTON_INPUT_CONFIRM — DISABLED LOGIC

Codice runtime post BUTTON CONFIRM READINESS ALIGNMENT:

{{
  (() => {
    const projectAmbiguous =
      Boolean(project_state.data?.isAmbiguous);

    const entityAmbiguous =
      Boolean(entity_state.data?.isAmbiguous);

    return (
      !input_raw.value ||
      (projectAmbiguous && !select_project.value) ||
      (entityAmbiguous && !select_entity.value)
    );
  })()
}}

Nota post UI Readiness:

Il disabled logic resta dedicato alla validazione dell’evento ordinario.

La visibilità del bottone è stata migrata a input_analysis_result.

button_input_confirm.Hidden:

{{ !input_analysis_result.value?.readiness?.canShowConfirm }}

Stato attuale post G33:

- button_input_confirm.Hidden migrato
- canShowConfirm introdotto come flag visibility-only
- button_input_confirm.Disabled resta autonomo
- button_input_confirm.Disabled legge solo project_state/entity_state isAmbiguous
- rimosso fallback matches.length > 1 dalla guard Disabled
- payload invariato
- insert_event / update_event invariati
- save readiness completa non centralizzata

Decisione:

- input vuoto → blocco / bottone non utilizzabile
- ambiguità non risolta → blocco
- ambiguità risolta manualmente → conferma consentita
- nessun match → conferma consentita
- match univoco → conferma consentita
- match generico con hint più specifici → conferma consentita
- warning non bloccanti → conferma consentita
- command intent → Conferma evento nascosta da Hidden, non gestita da Disabled

Nota:

G33 non modifica la policy del Match Engine.
G33 non trasforma warning informativi in blocchi.
G33 non centralizza canConfirm dentro input_analysis_result.

COMMAND INTENT — HIDDEN / GUARD PRINCIPLE

Per i comandi puri, la guardia principale non è button_input_confirm.disabled,
ma la separazione UI coordinata da ui_visibility_mode + input_analysis_result:

- Sintesi evento nascosta
- Dati evento nascosti
- button_input_confirm nascosto
- container_command_intent visibile
- ui_visibility_mode = command

Il command intent non deve competere con il confirm event flow.

Regola:

evento ordinario → button_input_confirm  
comando puro → btn_command_create_project / btn_command_create_entity / btn_command_go_events

INSERT_EVENT

Trigger:

insert_event

Tipo:

REST Query Supabase

Payload:

raw_input
type
amount
unit
event_date
project_id
entity_id
status: NEW
updated_at
payload: {}

Body:

JSON.stringify({
  raw_input: raw_input,
  type: type,
  amount: amount,
  unit: unit,
  event_date: event_date,
  project_id: project_id,
  entity_id: entity_id,
  status: "NEW",
  updated_at: new Date().toISOString(),
  payload: {}
})

Origine valori:

additionalScope da button_input_confirm.

Validazioni:

2h30 rendering
→ type Tempo
→ amount 150
→ unit minuti
→ status NEW

20 euro spesa materiale
→ type Spesa
→ amount 20
→ unit euro
→ status NEW

20 euro incasso cliente
→ type Incasso
→ amount 20
→ unit euro
→ status NEW

20 euro materiale
→ type Evento
→ amount 20
→ unit euro
→ status NEW

villa 2 mario
→ type Evento
→ amount null
→ unit null
→ status NEW

UPDATE_EVENT

Trigger:

update_event

Tipo:

REST Query Supabase

Utilizzo:

modifica evento esistente
solo eventi NEW
status invariato

Campi aggiornati:

raw_input
type
amount
unit
event_date
project_id
entity_id
updated_at

Origine valori:

additionalScope da button_input_confirm.

Validazione:

1 ora e 45 minuti regressione finale update
→ amount 105
→ unit minuti
→ status NEW

2 ore e 30 minuti test duration update
→ amount 150
→ unit minuti
→ status NEW

Validazione Type Classification Base:

Evento precedente senza type valorizzato,
modificato in:

1 ora e 45 minuti lavoro

DB:

type Tempo
amount 105
unit minuti
raw_input aggiornato
status NEW
updated_at aggiornato

Esito: OK

RESET & FEEDBACK

Feedback mode:

ui_state.feedback_mode distingue il tipo di feedback mostrato.

Valori runtime:

- null / event_created
- project_created
- entity_created

Uso:

Evento ordinario:
→ feedback_mode null / event_created
→ feedback evento

Command create project:
→ feedback_mode project_created
→ feedback progetto

Command create entity:
→ feedback_mode entity_created
→ feedback entità

Regola:

feedback_mode è UI temporaneo.
Non viene salvato nel DB.
Non è stato evento.

FEEDBACK PROJECT / ENTITY — TIMING ALIGNMENT

Dopo UI Readiness, btn_command_create_project e btn_command_create_entity
sono stati allineati nel timing del feedback.

Pattern applicato:

1. preparare nextFeedbackState
2. await ui_state.setValue(nextFeedbackState)
3. micro-tick setTimeout 0
4. mostrare container_feedback

Scopo:

- rendere project/entity coerenti
- preparare feedback_mode e feedback_summary prima della visibilità feedback
- ridurre differenze di timing

Esito:

✔ feedback project/entity funzionante
✔ ritorno Home automatico confermato
⚠ micro-flash feedback project/entity ancora presente come residuo minore

Nota post Linting / Retool Query Safety Pass:

handle_event_success è stato eliminato come query legacy unused.
Feedback e routing post-save restano centralizzati in button_input_confirm.

PROCESSING EVENTI

Lista:

events_new

Query:

events?select=*&status=eq.NEW&order=updated_at.desc.nullslast,created_at.desc

Azioni:

✔ WRITTEN
✖ ERROR

Trigger:

update_written
update_error

Editing:

disponibile solo per eventi NEW
riuso pipeline input
update_event

Command Intent:

- command create project non crea eventi
- command create entity non crea eventi
- command “modifica evento” non modifica eventi
- btn_command_go_events fa solo routing alla lista eventi

UI Readiness / Input Analysis Result:

- ui_visibility_state non modifica eventi
- input_analysis_result non modifica eventi
- preview_analysis_state non modifica eventi
- nessuno di questi helper modifica status
- nessuno di questi helper modifica processing NEW / WRITTEN / ERROR
- questi helper governano solo interpretazione/readiness/visibilità UI

Cancel contestuale:

Create/input mode:

- label “Torna alla home”
- non esegue insert_event
- resetta input/select/ui_state.parsed
- azzera feedback_summary
- torna Home

Edit mode:

- label “Annulla modifica”
- non esegue update_event
- non aggiorna updated_at
- resetta edit_mode / editing_event
- resetta input/select/ui_state.parsed
- azzera feedback_summary
- torna alla lista eventi

No-op edit guard:

- attivo in button_input_confirm
- confronta raw_input / type / project_id / entity_id
- esclude amount / unit / event_date perché derivati dal parser
- se non ci sono modifiche reali, non esegue update_event
- updated_at resta invariato

Lista eventi:

- input_events_search filtra client-side list_events
- ricerca su raw_input / type / status / project / entity
- label creato/modificato basata su created_at / updated_at normalizzati
- eventi modificati hanno marcatore leggero

------------------------------------------------
NAVIGATION DOCK
------------------------------------------------

Componente:

container_app_nav

Voci:

- Home
- Eventi
- Dashboard

Stato Dashboard:

- presente come voce prevista
- disabilitata
- nessuna dashboard implementata
- nessun KPI anticipato

Comportamento:

Home vuota:

- nav visibile in basso

Input/Sintesi attiva:

- nav nascosta

Events list:

- nav visibile in alto

Feedback:

- nav nascosta

Hidden logic consolidata post UI Readiness:

{{
  !(
    ui_state.value?.view === "events" ||
    (ui_state.value?.view === "home" && !input_home.value)
  )
}}

Nota:

La formula usa input_home.value invece di input_raw.value.

Motivo:

input_raw può aggiornarsi in ritardo rispetto a input_home,
causando flash della bottom bar durante la digitazione.

Esito:

✔ bottom bar flash risolto

Decisione:

Navigation dock contestuale.
Non fixed/sticky.

Motivo:

- evitare sovrapposizioni mobile
- evitare instabilità Retool
- rendere la nav utile in lista eventi lunga
- non disturbare input/sintesi
- predisporre Dashboard senza implementarla

------------------------------------------------
MOBILE SAFARI BASELINE
------------------------------------------------

Test reale:

- iPhone 13
- Safari
- preview Retool non pubblicata

Problemi rilevati:

- tap su input causava zoom automatico iOS
- dopo lo zoom l’app veniva troncata lateralmente
- select Tipo / Progetto / Entità non mostravano correttamente il dropdown completo

Fix applicato:

- font-size portato a 16px sui campi editabili/select principali

Campi coinvolti:

- input_home
- input_events_search
- select1
- select_project
- select_entity
- input_new_project_name
- input_new_entity_name
- input_command_project_name
- input_command_entity_name

Esito:

✔ zoom automatico Safari iOS risolto
✔ layout non più troncato
✔ select funzionanti sia in digitazione sia in dropdown
✔ validazione reale su iPhone 13 Safari completata

Regola runtime:

Su mobile Safari, input e select principali devono mantenere font-size minimo 16px.

BTN_EDIT — FLOW AGGIORNATO

Il pulsante edit ora rilancia anche il match state.

Sequenza:

1. window.__logos_editing_event_value = item
2. editing_event.trigger()
3. window.__logos_edit_mode_value = true
4. edit_mode.trigger()
5. mostra container input
6. forza container_events_list nascosto
7. forza container_feedback nascosto
8. pulisce select_project / select_entity
9. carica item.raw_input in input_home e input_raw
10. rilancia:
   - parse_input_controlled
   - project_state
   - entity_state
11. ripristina project_id/entity_id salvati se presenti

Codice helper aggiornato:

```js
// salva evento in editing
window.__logos_editing_event_value = item;
await editing_event.trigger();

// attiva edit mode
window.__logos_edit_mode_value = true;
await edit_mode.trigger();

Risultato:

✔ edit flow coerente con create flow
✔ suggerimenti funzionano in modalità modifica
✔ select/hint/confirm guard aggiornati anche in edit
✔ dati salvati precedenti preservati se presenti
✔ doppia visibilità input/lista evitata
✔ linting edit_mode / editing_event risolti
✔ edit mode chiarito da text_edit_mode_notice
✔ durante edit mode il Command Intent non prende controllo del flow

------------------------------------------------
CANCEL CONTESTUALE — CREATE / EDIT FLOW
------------------------------------------------

Componente:

btn_cancel_edit / pulsante cancel contestuale

Ruolo:

annullare input corrente oppure modifica evento,
senza salvare nulla.

Label dinamica:

- create/input mode → Torna alla home
- edit mode → Annulla modifica

Comportamento create/input:

1. cancella eventuale debounce pendente
2. cancella eventuale timer feedback pendente
3. esce da edit mode se necessario
4. azzera editing_event
5. resetta input_home
6. resetta input_raw
7. pulisce select_project
8. pulisce select_entity
9. pulisce select1
10. resetta ui_state.parsed
11. azzera feedback_text / feedback_project / feedback_summary
12. imposta ui_state.view = "home"
13. mostra container_home
14. nasconde container_input
15. nasconde container_feedback
16. nasconde container_events_list

Comportamento edit:

1. cancella eventuale debounce pendente
2. cancella eventuale timer feedback pendente
3. scrive window.__logos_edit_mode_value = false
4. rilancia edit_mode
5. scrive window.__logos_editing_event_value = null
6. rilancia editing_event
7. resetta input_home
8. resetta input_raw
9. pulisce select_project
10. pulisce select_entity
11. pulisce select1
12. resetta ui_state.parsed
13. azzera feedback_text / feedback_project / feedback_summary
14. imposta ui_state.view = "events"
15. nasconde container_input
16. nasconde container_home
17. nasconde container_feedback
18. mostra container_events_list

Risultato:

✔ create/input cancel torna Home
✔ edit cancel torna Lista eventi
✔ nessun insert_event
✔ nessun update_event
✔ updated_at invariato
✔ nav corretta dopo cancel
✔ edit_mode.data = false
✔ editing_event.data = null

EDIT MODE NOTICE

Componente:

text_edit_mode_notice

Contenuto:

Evento in modifica · Premi Annulla modifica per uscire.

Hidden:

{{ edit_mode.data !== true }}

Scopo:

- rendere evidente che l’utente è in edit mode
- evitare confusione quando si svuota input e si scrive “crea”
- chiarire che per usare un nuovo comando bisogna uscire dalla modifica
- preservare edit flow senza far partire command intent durante modifica

Regola:

Durante edit mode, “crea” resta testo dell’evento in modifica.
Per uscire si usa Annulla modifica.

QUERY

GET:

projects_list
entities_list
events_new

POST / UPDATE:

insert_event
update_event
insert_project
insert_entity

RPC / STATUS:

update_written
update_error

STATE / UI:

ui_state
edit_mode
project_state
entity_state
focus_input_home
editing_event
create_suggestion_state
project_create_inline_open
project_create_suggestion_dismissed
entity_create_inline_open
entity_create_suggestion_dismissed
command_intent_state
ui_visibility_mode
ui_visibility_state (legacy/residuo deprecabile)
preview_analysis_state
input_analysis_result

HELPER TECNICI WINDOW:

window.__logos_edit_mode_value
window.__logos_editing_event_value
window.__logos_feedback_timer
window.__logos_visibility_run_id

COMPONENTI UI RILEVANTI:

select1
select_project
select_entity
btn_cancel_edit / cancel contestuale
input_events_search
list_events
container_association_suggestions
input_new_project_name
input_new_entity_name
btn_open_project_create
btn_open_entity_create
btn_create_project_inline
btn_create_entity_inline
btn_ignore_global_suggestions / bottone Ignora globale
btn_cancel_project_inline
btn_cancel_entity_create
container_app_nav
btn_nav_home
btn_nav_events
btn_nav_dashboard
container_command_intent
txt_command_intent_loading
txt_command_intent_title
txt_command_intent_description
txt_command_edit_steps
divider_command_intent_main
txt_command_intent_summary
input_command_project_name
input_command_entity_name
btn_command_create_project
btn_command_create_entity
btn_command_go_events
txt_command_intent_notice
txt_command_intent_guide_notice
text_input_analysis_loading
text_edit_mode_notice
sintesi
text_event_data_title

Nota:

select1 è un componente UI Select di Retool,
non una query.
Il suo Default value contiene la logica Type Classification Base.
Il valore runtime select1.value viene letto da button_input_confirm
e salvato come payload.type.

Nota:

select_project e select_entity non ricalcolano più matching.
Leggono singleMatch da project_state/entity_state.

Nota:

preview_analysis_state e input_analysis_result sono Transformer Retool read-only.

Non sono query di salvataggio.
Non modificano DB.
Non sostituiscono parser, matching, suggestion, command o save flow.

INPUT / PARSING:

trigger_parse_debounced
parse_input_controlled

LEGACY / DEBITO:

typing_state è stato eliminato come query legacy unused
handle_event_success è stato eliminato come query legacy unused
parse_input non è più fonte di verità se ancora presente
button_input_confirm non deve contenere parsing duplicato

SUPABASE

Nota canonica:

Questo manifest documenta il rapporto runtime Retool → Supabase.

Per il runtime Supabase reale as-is la fonte canonica è:

- LOGOS_SUPABASE_RUNTIME_REAL

Per lo schema DB come modello documentale canonico la fonte è:

- 05_LOGOS_Database_Schema

Supabase è database passivo.

Ruolo:

✔ persistenza
✔ fetch liste
✔ insert eventi
✔ update eventi
✔ update status
✔ insert project controllato
✔ insert entity controllato

NON:

parsing
normalizzazione
matching
validazione business
type classification autonoma
deduplicazione
KPI
crea automaticamente project/entity
interpreta command intent
crea eventi da comandi puri
salva feedback_mode
decide Dashboard/KPI

Nota:

Supabase riceve events.type già determinato lato Retool.
Il DB non decide e non corregge il type.
insert_project / insert_entity vengono eseguiti solo da azione esplicita utente.
La creazione project/entity non salva automaticamente l’evento.

Nota Command Intent:

Command Intent è gestito lato Retool.

Supabase riceve scritture solo dopo conferma utente:

- insert_project per progetto da command
- insert_entity per entità da command

Nessun comando puro crea record in events.

Nota UI Readiness / Input Analysis Result:

ui_visibility_mode, ui_visibility_state, preview_analysis_state e input_analysis_result sono interamente lato Retool.

Supabase non riceve nessun dato da questi helper.

Nessuna tabella, colonna o policy Supabase è stata modificata dai nodi:

- UI Readiness / Visibility Aggregator
- Preview Analysis State
- Input Analysis Result Read-only Diagnostic
- Input Analysis Result Controlled UI Consumption
- Input Analysis Result Visibility Migration Completion
- Linting / Retool Query Safety Pass

LIMITI ATTUALI

INPUT:

nessun parsing semantico
date relative non supportate
giorni/settimane non convertiti automaticamente
giornata / mezza giornata non normalizzate
parole numeriche tipo “due ore” non supportate
forme colloquiali tipo “un paio d’ore” non supportate

NORMALIZATION:

amount/unit base attivi
duration normalization base attiva
unità canonica tempo = minuti
giorni/settimane non convertiti automaticamente
nessun payload duration
nessun campo duration_minutes
nessuna retro-normalizzazione storico

MATCHING:

Match Engine Unification First Controlled Level completato
project_state/entity_state fonte minima matching
select/hint/highlight/confirm allineati a match state
priority match minimo implementato
nessuna gerarchia entity/project
nessuna deduplicazione entity/project
nessun alias system
nessun fuzzy matching
creazione guidata project/entity implementata a primo livello controllato
nessuna suggestion create/edit consistency avanzata
nessun project creation override con match generico
nessuna auto-select confidence avanzata
nessun filtro/priorità contestuale delle options select_project/select_entity
nessun ranking avanzato
input_analysis_result implementato come layer compositivo parziale
Input Analysis Model completo non implementato

TYPE:

type classification base implementata
Evento / Tempo / Spesa / Incasso persistiti in events.type
Spesa / Incasso riconosciuti tramite keyword controllate o scelta manuale
euro senza direzione chiara resta Evento
amount firmato non implementato
direction field non implementato
classificazione economica avanzata non implementata
parole di dominio non usate come classificazione automatica
type non ancora sufficiente da solo per KPI avanzati
eventi storici non retro-normalizzati

UI / PREVIEW:

input non multilinea
preview migliorabile come architettura
preview non pura
formattazione italiana amount allineata nella sintesi
label cleaning ancora embedded
hint matching project/entity allineati a state
hint/status principali separati a primo livello in preview_analysis_state
hint duration/type ancora parzialmente embedded
UX mobile base completata
Cambia / Scegli nella Sintesi ancora non cliccabili
Azioni rapide presenti ma non operative
Dashboard presente in nav ma disabilitata
Icon System non completamente standardizzato
rendering progressivo input evento normale ridotto tramite UI Readiness
micro-flash feedback project/entity ancora presente
“modifica” generico non ancora riconosciuto come guida edit
linting Retool azzerati
“Da verificare” resta interno alla Sintesi
Full Visibility Migration degli Hidden principali completata
button_input_confirm.Hidden migrato a input_analysis_result
button_input_confirm.Disabled non migrato a input_analysis_result, ma allineato localmente a isAmbiguous
flash residui durante digitazione/cambio schermata ancora presenti
label “Importo” su valori durata risolta tramite label semantica della riga valore
status OK + card Da verificare da riallineare semanticamente

ARCHITETTURA:

accoppiamento preview / label / hint
matching project/entity allineato a primo livello
hint matching project/entity state-driven
preview ancora ibrida
feedback/routing centralizzati in button_input_confirm
navigation dock contestuale implementata
Mobile Safari font-size 16px baseline consolidata
command intent implementato solo a primo livello controllato
command_intent_state ancora helper Retool separato
input_analysis_result implementato come layer compositivo per Hidden principali del flow input
Input Analysis Model completo non implementato
UI Readiness / Visibility Aggregator implementato a primo livello
Preview Analysis State implementato a primo livello
Controlled UI Consumption Pass completato
ui_visibility_state ancora presente come residuo tecnico deprecabile
Full Visibility Migration degli Hidden principali completata
button_input_confirm.Hidden migrato
button_input_confirm.Disabled non migrato, ma allineato localmente a isAmbiguous
save readiness completa non centralizzata
cleanup obsolete UI guards / query reduction non ancora eseguito
⚠ G29 analizzato: nessun micro-fix Hidden/layout/latch ha risolto stabilmente il residuo container_input

PRINCIPI RUNTIME

✔ client-side logic
✔ database passivo
✔ append-only controllato
✔ editing solo su NEW
✔ suggerire ≠ decidere
✔ input non bloccante
✔ salvataggio amount/unit/event_date da ui_state.parsed
✔ salvataggio type da select1.value
✔ normalizzazione progressiva
✔ nessuna automazione decisionale
✔ salvataggio project_id da select_project.value  
✔ salvataggio entity_id da select_entity.value  
✔ matching project/entity da project_state/entity_state  
✔ confirm guard da ambiguità non risolta  
✔ no-op edit guard
✔ controlled edit cancel flow
✔ helper edit_mode / editing_event senza additionalScope { value }
✔ window-backed edit helper state
✔ lista eventi filtrabile client-side
✔ create_suggestion_state = suggestion, non decisione
✔ insert_project / insert_entity solo su conferma utente
✔ evento non salvato automaticamente dopo creazione project/entity
✔ feedback_summary = UI temporanea, non dato DB
✔ feedback/routing post-save centralizzati in button_input_confirm
✔ insert → feedback → Home
✔ update → feedback → Lista eventi
✔ no-op edit → Lista eventi senza update_event
✔ cancel contestuale create/edit
✔ navigation dock contestuale
✔ Dashboard predisposta ma non attiva
✔ input/select mobile Safari minimo 16px
✔ command_intent_state = command intent controllato, non save flow
✔ comando puro ≠ evento ordinario
✔ comandi puri non salvano eventi
✔ container_command_intent sostituisce Sintesi/Dati evento nei comandi puri
✔ project/entity da command creati solo previa conferma utente
✔ insert_project / insert_entity riusati da command
✔ “modifica evento” da command = guida, non edit flow automatico
✔ feedback_mode = UI temporanea, non dato DB
✔ ui_visibility_mode = latch UI temporaneo, non dato DB
✔ ui_visibility_state = residuo tecnico deprecabile / rollback, non dato DB e non fonte canonica degli Hidden principali migrati
✔ UI Readiness ≠ Input Analysis Model completo
✔ visibilità componenti principali centralizzata a primo livello
✔ edit mode prevale su Command Intent
✔ durante edit mode scrivere “crea” non apre Command Intent
✔ preview_analysis_state = fonte hint/status Sintesi, non dato DB
✔ input_analysis_result = composizione raw / selection / effective, non payload save
✔ input_analysis_result governa gli Hidden principali del flow input, non sostituisce moduli specializzati
✔ missing association notice ≠ suggestion operativa
✔ ui_visibility_state residuo tecnico deprecabile, non fonte canonica della visibility flow input
✔ anti-loop: input_analysis_result non legge più ui_visibility_state; ui_visibility_state non deve leggere input_analysis_result
✔ LOGOS evolve verso architettura modulare coordinata, non motore monolitico
✔ canShowConfirm = visibilità bottone Conferma
✔ canConfirm = readiness funzionale
✔ button_input_confirm.Disabled = guard funzionale separata basata su isAmbiguous
✔ button_input_confirm.Disabled non usa più matches.length > 1 come blocco grezzo
✔ button_input_confirm payload = invariato
✔ micro-flash non bloccanti non vanno inseguiti oltre senza nodo/refactor dedicato
✔ input_shell_visible non è parte del runtime attivo
✔ G29 resta residuo UX minore accettabile / in osservazione

STATO RUNTIME

Runtime attuale:

✔ funzionante
✔ stabile su insert
✔ stabile su update
✔ normalizzazione base attiva
✔ parser controllato attivo
✔ preview alignment base completato
✔ duration normalization base completata
✔ type classification base completata
✔ select1 allineato a ui_state.parsed.unit
✔ type persistito in events.type
✔ amount/unit/date visualizzati coerentemente
✔ durate certe ore/minuti salvate in minuti
✔ preview durata in forma umana
✔ save flow ripulito
✔ refresh lista corretto
✔ DB coerente con payload
✔ UX immediata
✔ Match Engine Unification First Controlled Level completato  
✔ project_state/entity_state fonte minima matching  
✔ select_project/select_entity allineati a singleMatch  
✔ priority match minimo implementato  
✔ hint ambiguità matching allineati a isAmbiguous  
✔ confirm guard basata su ambiguità non risolta  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ bug €500 preview risolto  
✔ UX / Cleanup Micro-Batch Post Match Engine completato
✔ btn_cancel_edit implementato
✔ no-op edit guard implementato
✔ input_events_search implementato
✔ label creato/modificato lista eventi corretta
✔ Linting / State Helper Cleanup completato
✔ edit_mode / editing_event non usano più additionalScope { value }
✔ linting edit_mode / editing_event risolti
✔ create/edit/annulla/no-op edit/edit reale validati
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ create_suggestion_state implementato
✔ insert_project implementato
✔ insert_entity implementato
✔ creazione project/entity inline validata
✔ evento salvato con project_id/entity_id creati inline validato
✔ UX Mobile Coherence Pass completato
✔ Home mobile rifinita
✔ Events list mobile rifinita
✔ Feedback mobile stabilizzato
✔ feedback_summary introdotto
✔ routing post-save contestuale
✔ cancel create/edit contestuale
✔ Navigation dock Home / Eventi / Dashboard introdotta
✔ Dashboard predisposta ma disabilitata
✔ Dati evento compattati con label inline
✔ Icon add-ons Retool introdotti nei pulsanti reali
✔ font-size input/select 16px validato su Safari iOS
✔ zoom automatico Safari iOS risolto
✔ select mobile funzionanti in digitazione/dropdown
✔ Command Intent — Create Project / Entity completato
✔ command_intent_state implementato
✔ container_command_intent implementato
✔ input_command_project_name implementato
✔ input_command_entity_name implementato
✔ btn_command_create_project implementato e validato
✔ btn_command_create_entity implementato e validato
✔ btn_command_go_events implementato e validato
✔ feedback_mode implementato
✔ feedback project_created implementato
✔ feedback entity_created implementato
✔ comandi puri esclusi dal save flow evento
✔ evento ordinario non regressivo dopo Command Intent validato
✔ edit flow non regressivo dopo Command Intent validato
✔ UI Readiness / Visibility Aggregator First Controlled Level completato
✔ ui_visibility_mode implementato
✔ ui_visibility_state presente come residuo tecnico deprecabile / rollback
✔ trigger_parse_debounced aggiorna ui_visibility_mode
✔ window.__logos_visibility_run_id introdotto
✔ Hidden principali del flow input migrati a input_analysis_result
✔ container_input.Hidden migrato a input_analysis_result
✔ container vuoto durante digitazione risolto
✔ flash input flow ridotto
✔ bottom bar flash risolto
✔ text_input_analysis_loading introdotto
✔ text_edit_mode_notice introdotto
✔ edit mode prevale su command intent
✔ feedback project/entity timing allineato
✔ test obbligatori 1–16 superati
✔ Preview Analysis State — First Controlled Layer completato
✔ preview_analysis_state implementato
✔ hint/status/missing association della Sintesi letti da preview_analysis_state
✔ Input Analysis Result / Single Interpretation Layer Base completato come diagnostico
✔ input_analysis_result implementato
✔ raw / selection / effective state introdotti
✔ Input Analysis Result — Controlled UI Consumption Pass completato
✔ input_analysis_result fonte UI controllata per Hidden principali del flow input
✔ sintesi.Hidden migrato a input_analysis_result
✔ Dati evento / select Hidden migrati a input_analysis_result
✔ container_command_intent.Hidden migrato a input_analysis_result
✔ container_association_suggestions.Hidden migrato a input_analysis_result
✔ edit mode + input vuoto stabilizzato
✔ Home idle container nascosti durante edit mode
✔ notice associazioni mancanti coerente con presenza suggerimenti
✔ INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION completato come analisi runtime
✔ nessuna modifica runtime definitiva mantenuta dopo G29
✔ rollback alla base stabile confermato
✔ BUTTON CONFIRM READINESS ALIGNMENT completato
✔ button_input_confirm.Disabled aggiornato
✔ Disabled allineato a project_state/entity_state isAmbiguous
✔ fallback matches.length > 1 rimosso da Disabled
✔ test post-fix superati senza regressioni

Debiti:

⚠ giorni/settimane durata non convertiti automaticamente
⚠ type classification avanzata da definire
⚠ economic direction advanced non implementata
⚠ match engine avanzato separato non implementato
⚠ alias / gerarchie / deduplicazione non implementati
✔ creazione guidata project/entity implementata a primo livello controllato
⚠ suggestion create vs edit consistency da verificare
⚠ project creation override con match generico non implementato
⚠ auto-select confidence / match generico salvabile da assorbire in G22
⚠ select_project/select_entity non filtrano né prioritizzano ancora i candidati contestuali
⚠ preview ancora non view pura
⚠ output non attivo
⚠ Azioni rapide non operative
⚠ Dashboard non implementata
⚠ Icon System non completamente standardizzato
⚠ Command Intent è solo primo livello controllato
⚠ command intent avanzato non implementato
✔ input_analysis_result implementato come layer compositivo parziale
⚠ Input Analysis Model completo non implementato
✔ rendering progressivo input evento normale ridotto tramite UI Readiness e input_analysis_result
⚠ micro-flash feedback project/entity ancora presente
✔ linting Retool azzerati
✔ ui_visibility_state residuo tecnico deprecabile
✔ Full Visibility Migration degli Hidden principali completata
✔ button_input_confirm.Hidden migrato
✔ button_input_confirm.Disabled allineato localmente a isAmbiguous
⚠ micro-flash container_input durante transizioni input / command / empty ancora presente come residuo UX minore accettabile / in osservazione
✔ label “Importo” su durata risolta
✔ riga valore Sintesi semanticamente allineata a Importo / Durata / Valore
⚠ save readiness completa non centralizzata
⚠ “modifica” generico non ancora riconosciuto come guida edit
⚠ cleanup obsolete UI guards / query reduction non ancora eseguito
⚠ “Da verificare” resta interno alla Sintesi

------------------------------------------------
PREVIEW ALIGNMENT BASE — TEST VALIDATI
------------------------------------------------

Input:

1.500,50 euro materiale

Output preview:

1.500,50 € • materiale

Esito: OK

---

Input:

1500 euro materiale

Output preview:

1.500,00 € • materiale

Esito: OK

---

Input:

18 minuti test

Output preview:

18 minuti • test

Esito: OK

---

Input:

18min test

Output preview:

18 minuti • test

Esito: OK

---

Input:

1ora lavoro

Output preview:

1 ora • lavoro

Esito: OK

---

Input:

6/4/26 inseminazione alfie

Output preview:

6 apr • inseminazione alfie

Esito: OK

---

Input:

4 aprile benzina 50 euro alfie allevamento aspri

Output preview:

4 apr • 50,00 € • benzina alfie allevamento aspri

Esito: OK

---

Input:

villa 2 mario

Output preview:

villa 2 mario

Esito: OK

---

Input:

2 ore sopralluogo villa 2

Output preview:

2 ore • sopralluogo villa 2

Esito: OK

---

Input:

2,7 ore sviluppo sistema aspri

Output preview:

2,7 ore • sviluppo sistema aspri

Esito: OK

Nota:

il vecchio hint "Verifica durata" è stato superato
dal nodo Duration Normalization Base.

Ora la preview mostra:

- forma umana della durata
- hint "Normalizzato: X minuti"
- hint durata ambigua per giorni/settimane

------------------------------------------------
DURATION NORMALIZATION BASE — TEST VALIDATI
------------------------------------------------

Input:

1 ora e 15 minuti test duration

Parsed:

amount 75
unit minuti

DB:

amount 75
unit minuti
raw_input preservato

Esito: OK

---

Input:

2h30 test duration

Parsed:

amount 150
unit minuti

DB:

amount 150
unit minuti
raw_input preservato

Preview:

2 ore 30 minuti
Normalizzato: 150 minuti

Esito: OK

---

Input:

1,5 ore test duration

Parsed:

amount 90
unit minuti

DB:

amount 90
unit minuti
raw_input preservato

Preview:

1 ora 30 minuti
Normalizzato: 90 minuti

Esito: OK

---

Input:

2 ore e 30 minuti test duration update

DB:

amount 150
unit minuti
raw_input aggiornato
status NEW

Esito: OK

---

Input:

1 ora e 45 minuti regressione finale update

DB:

amount 105
unit minuti
raw_input aggiornato
status NEW

Esito: OK

---

Input:

2 giorni test duration

Parsed:

amount null
unit null

Preview:

Durata ambigua: specifica ore/minuti per salvarla come tempo analizzabile

DB:

amount null
unit null
raw_input preservato

Esito: OK secondo decisione corrente

---

Regressioni validate:

30 euro regressione finale
→ amount 30
→ unit euro

villa 2 test duration
→ amount null
→ unit null

6/4/26 inseminazione alfie
→ event_date 2026-04-06

------------------------------------------------
TYPE CLASSIFICATION BASE — TEST VALIDATI
------------------------------------------------

ANTEPRIMA:

2h30 rendering
→ select1 Tempo
→ preview durata coerente

1 ora lavoro
→ select1 Tempo

18min test
→ select1 Tempo

20 euro spesa materiale
→ select1 Spesa

20 euro acquisto materiale
→ select1 Spesa

20 euro pagato materiale
→ select1 Spesa

20 euro incasso cliente
→ select1 Incasso

20 euro vendita cucciolo
→ select1 Incasso

20 euro acconto ricevuto
→ select1 Incasso

20 euro acconto dato
→ select1 Spesa

20 euro acconto
→ select1 Evento

20 euro materiale
→ select1 Evento

20 euro spesa incasso
→ select1 Evento

villa 2 mario
→ select1 Evento

2 giorni rendering
→ select1 Evento

4 aprile benzina 50 euro alfie allevamento aspri
→ select1 Evento

---

INSERT DB:

2h30 rendering
→ type Tempo
→ amount 150
→ unit minuti

20 euro spesa materiale
→ type Spesa
→ amount 20
→ unit euro

20 euro incasso cliente
→ type Incasso
→ amount 20
→ unit euro

20 euro materiale
→ type Evento
→ amount 20
→ unit euro

villa 2 mario
→ type Evento
→ amount null
→ unit null

------------------------------------------------
MATCH ENGINE UNIFICATION — TEST VALIDATI
------------------------------------------------

Input:

villa 2 mario

Risultato:

project = Villa 2
entity = Mario
Conferma abilitata

Esito: OK

---

Input:

4 aprile benzina 50 euro alfie allevamento aspri

Risultato:

project = ASPRI
entity ambigua
hint Più entità trovate
Conferma disabilitata finché non viene scelta entità

Esito: OK

---

Input:

4 aprile benzina 50 euro alfie allevamento aspri
+ scelta manuale entity Alfie

Risultato:

Conferma abilitata

Esito: OK

---

Input:

18 min ristrutturazione bagno

Risultato:

project = Ristrutturazione Bagno
type = Tempo
Conferma abilitata

Esito: OK

---

Input:

acquisto 50 euro materiale nuovo

Risultato:

nessun project/entity
type = Spesa
Conferma abilitata

Esito: OK

---

Input:

mario

Risultato:

entity = Mario
hint Esistono entità più specifiche
Conferma abilitata

Esito: OK

---

Input:

mario rossi

Risultato:

entity = Mario Rossi
hint Esistono entità più specifiche
Conferma abilitata

Esito: OK

---

Input:

mario rossi alfredo

Risultato:

entity = Mario Rossi Alfredo
Conferma abilitata

Esito: OK

---

Input:

villa

Risultato:

project = Villa
hint Esistono progetti più specifici
Conferma abilitata

Esito: OK

---

Input:

villa 2

Risultato:

project = Villa 2
Conferma abilitata

Esito: OK

---

Input:

alfie mario rossi

Risultato:

ambiguità reale entity
Conferma disabilitata

Esito: OK

---

Input:

€500 acconto alfie mario rossi

Risultato:

500,00 € • acconto alfie mario rossi
entity ambigua

Esito: OK

---

UPDATE DB:

1 ora e 45 minuti lavoro
→ type Tempo
→ amount 105
→ unit minuti
→ raw_input aggiornato
→ updated_at aggiornato

---

OVERRIDE MANUALE:

20 euro materiale + select1 manuale Spesa
→ DB type Spesa

20 euro materiale + select1 manuale Incasso
→ DB type Incasso

---

RESET / STALE VALUE:

Sequenza:

20 euro materiale
→ select1 manuale Spesa
→ conferma
→ nuovo input villa 2 mario
→ select1 Evento

Esito:

OK

Nessuna modifica necessaria al reset select1.

---

ANOMALIE RESIDUE:

Nessuna anomalia linting edit_mode / editing_event residua.

Restano debiti evolutivi già noti:

- giorni/settimane durata non convertiti automaticamente
- type classification avanzata da definire
- economic direction advanced non implementata
- match engine avanzato separato non implementato
- alias / gerarchie / deduplicazione non implementati
- command intent avanzato non implementato
- input analysis model unico non implementato
- preview ancora non view pura
- output non attivo

------------------------------------------------
UX / CLEANUP MICRO-BATCH — TEST VALIDATI
------------------------------------------------

Create nuovo evento:

Esito: OK

---

Edit evento:

Esito: OK

---

Annulla modifica:

Risultato:

- nessun update_event
- updated_at invariato
- ritorno lista eventi
- edit_mode false
- editing_event null

Esito: OK

---

Edit senza modifiche reali:

Risultato:

- no-op edit guard attivo
- nessun update_event
- updated_at invariato
- label creato/modificato invariata
- ritorno lista eventi

Esito: OK

---

Edit con modifica reale:

Risultato:

- update_event eseguito
- updated_at aggiornato
- events_new refresh dopo save
- label modificato coerente
- edit_mode reset
- editing_event reset

Esito: OK

---

Lista eventi search/filter:

Risultato:

- campo vuoto mostra lista completa
- filtro su raw_input funzionante
- filtro su type/status funzionante
- filtro su project/entity funzionante
- edit da lista filtrata funzionante
- WRITTEN / ERROR invariati

Esito: OK

------------------------------------------------
LINTING / STATE HELPER CLEANUP — TEST VALIDATI
------------------------------------------------

Linting edit_mode:

Risultato:

- edit_mode: 'value' is not defined non più presente

Esito: OK

---

Linting editing_event:

Risultato:

- editing_event: 'value' is not defined non più presente

Esito: OK

---

Create flow:

Esito: OK

---

Edit flow:

Esito: OK

---

Annulla modifica:

Esito: OK

---

Edit senza modifiche reali:

Esito: OK

---

Edit con modifica reale:

Esito: OK

---

updated_at / label creato-modificato:

Esito: OK

---

WRITTEN / ERROR:

Esito: OK

---

Regressioni:

- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- preview invariata
- lista eventi invariata

Esito: OK

------------------------------------------------
PROJECT / ENTITY CREATE SUGGESTION — TEST VALIDATI
------------------------------------------------

Input:

villa sierri 15 sopralluogo referente kappa

Risultato:

- Crea progetto disponibile
- candidate project Villa Sierri 15
- Crea entità disponibile
- candidate entity Referente Kappa
- insert_project eseguito su conferma utente
- insert_entity eseguito su conferma utente
- select_project valorizzata
- select_entity valorizzata
- evento non salvato automaticamente
- evento salvato solo dopo Conferma evento

Esito: OK

---

Input:

acquisto 50 euro materiale nuovo

Azione:

Ignora suggerimenti

Risultato:

- suggestion container chiuso
- evento salvabile con project_id null / entity_id null
- type Spesa
- amount 50
- unit euro

Esito: OK

---

Input:

alfie mario rossi

Risultato:

- ambiguità entity
- Crea entità non visibile
- Conferma disabilitata finché non risolta manualmente

Esito: OK

------------------------------------------------
UX MOBILE COHERENCE PASS — TEST VALIDATI
------------------------------------------------

Home vuota:

Risultato:

- Home visibile
- input principale visibile
- Esempi visibili
- Azioni rapide visibili
- Eventi da verificare visibile
- nav visibile in basso

Esito: OK

---

Nuovo evento → Conferma evento:

Risultato:

- insert_event eseguito
- feedback visibile
- feedback_summary mostrato
- events_new aggiornato
- dopo 1800 ms ritorno Home

Esito: OK

---

Lista eventi → Modifica → modifica reale → Conferma evento:

Risultato:

- update_event eseguito
- feedback visibile
- events_new aggiornato
- dopo 1800 ms ritorno Lista eventi

Esito: OK

---

Lista eventi → Modifica → nessuna modifica → Conferma evento:

Risultato:

- update_event NON eseguito
- nessun feedback
- ritorno immediato Lista eventi
- updated_at invariato

Esito: OK

---

Home → scrivi input → Torna alla home:

Risultato:

- input_home svuotato
- input_raw svuotato
- select resettate
- ui_state.parsed resettato
- Home visibile
- nav Home visibile
- nessun salvataggio

Esito: OK

---

Lista eventi → Modifica → Annulla modifica:

Risultato:

- edit_mode false
- editing_event null
- input svuotati
- select resettate
- ritorno Lista eventi
- nav Events visibile
- nessun update_event

Esito: OK

---

iPhone 13 Safari reale:

Problemi iniziali:

- zoom automatico su tap input
- troncamento laterale interfaccia
- select non pienamente utilizzabili come dropdown

Fix:

- font-size 16px su input/select principali

Risultato:

- nessuno zoom automatico
- layout mobile stabile
- select Tipo / Progetto / Entità funzionanti sia in digitazione sia in dropdown

Esito: OK

------------------------------------------------
COMMAND INTENT — TEST VALIDATI
------------------------------------------------

Input:

crea

Risultato:

- container_command_intent visibile
- guida con esempi
- Sintesi evento nascosta
- Dati evento nascosti
- nessun evento salvato

Esito: OK

---

Input:

crea progetto

Risultato:

- card command project incompleto
- input_command_project_name visibile
- bottone Crea progetto disabilitato a campo vuoto
- Sintesi evento nascosta
- nessun evento salvato

Esito: OK

---

Input:

crea progetto Command Final Project 2

Risultato:

- riepilogo project visibile
- btn_command_create_project visibile
- insert_project eseguito su conferma utente
- feedback Progetto creato
- ritorno Home automatico
- nessun evento salvato

Esito: OK

---

Input:

crea entità

Risultato:

- card command entity incompleto
- input_command_entity_name visibile
- bottone Crea entità disabilitato a campo vuoto
- Sintesi evento nascosta
- nessun evento salvato

Esito: OK

---

Input:

crea entità Command Final Entity 2

Risultato:

- riepilogo entity visibile
- btn_command_create_entity visibile
- insert_entity eseguito su conferma utente
- feedback Entità creata
- ritorno Home automatico
- nessun evento salvato

Esito: OK

---

Input:

crea progetto villa

Risultato:

- Elemento già presente riconosciuto
- nessun bottone crea
- nessuna duplicazione
- Sintesi evento nascosta
- nessun evento salvato

Esito: OK

---

Input:

modifica evento

Risultato:

- guida command visibile
- step leggibili
- btn_command_go_events funzionante
- lista eventi aperta
- nessun update_event
- nessun evento salvato

Esito: OK

---

Input:

30 euro spesa villa citrignano

Risultato:

- evento ordinario riconosciuto
- container_command_intent non interferisce
- Sintesi evento mostrata
- Dati evento mostrati
- Conferma evento funzionante
- feedback evento corretto
- ritorno Home automatico

Esito: OK

---

Edit evento reale:

Risultato:

- update_event eseguito
- feedback evento corretto
- ritorno Lista eventi
- evento marcato come modificato

Esito: OK

---

Edit no-op / annulla modifica:

Risultato:

- nessun update_event se non ci sono modifiche reali
- updated_at invariato
- ritorno Lista eventi

Esito: OK

------------------------------------------------
UI READINESS / VISIBILITY AGGREGATOR — TEST VALIDATI
------------------------------------------------

Test obbligatori completati:

1. evento normale

Input:

30 euro spesa villa citrignano

Esito:

OK

---

2. comando generico

Input:

crea

Esito:

OK

---

3. create project incompleto

Input:

crea progetto

Esito:

OK

---

4. create project completo

Input:

crea progetto Nome Test

Esito:

OK

---

5. create entity incompleto

Input:

crea entità

Esito:

OK

---

6. create entity completo

Input:

crea entità Nome Test

Esito:

OK

---

7. elemento già presente

Input:

crea progetto villa

Esito:

OK

---

8. guida edit

Input:

modifica evento

Esito:

OK

---

9. suggestion project/entity da evento normale

Esito:

OK

---

10. edit evento reale

Esito:

OK

---

11. edit no-op

Esito:

OK

---

12. annulla edit

Esito:

OK

---

13. feedback evento

Esito:

OK

---

14. feedback project/entity

Esito:

OK con micro-flash residuo non bloccante

---

15. events list

Esito:

OK

---

16. Home vuota + navigation dock

Esito:

OK

---

Risultati validati:

✔ flow event / command stabile
✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto
✔ edit mode chiarito
✔ Command Intent preservato
✔ create/edit/feedback/lista non regressivi
✔ DB invariato
✔ parser invariato
✔ matching invariato
✔ save flow invariato

------------------------------------------------
INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS — TEST VALIDATI
------------------------------------------------

1. Evento normale

Input:

30 euro spesa materiale

Esito:

- Sintesi visibile
- Dati evento visibili
- select visibili
- container_command_intent nascosto

Risultato:

OK

---

2. Euro senza direzione

Input:

30 euro materiale

Esito:

- warning “Definisci spesa o incasso”
- Dati evento visibili
- salvataggio ancora consentito se non ci sono blocchi matching

Risultato:

OK

---

3. Durata normalizzata

Input:

1 ora e 15 minuti lavoro

Esito:

- amount 75
- unit minuti
- type Tempo
- hint Normalizzato: 75 minuti
- readiness coerente

Risultato:

OK

---

4. Ambiguità entity

Input:

30 euro cliente test

Esito:

- entity ambigua
- hint “Più entità trovate”
- canConfirm false
- Sintesi e Dati evento visibili

Risultato:

OK

---

5. Command puro

Input:

crea progetto Nome Test

Esito:

- effectiveFlowType command
- container_command_intent visibile
- Sintesi nascosta
- Dati evento nascosti
- project/entity raw ignorati come dati evento

Risultato:

OK

---

6. Edit mode + input “crea”

Esito:

- raw command true
- command effective false
- edit mode prevale
- container_command_intent nascosto
- event/edit flow preservato
- residuo UX guidance tracciato

Risultato:

OK

---

7. Edit mode + input vuoto

Esito:

- Sintesi nascosta
- Dati evento nascosti
- Conferma nascosta
- Home idle container nascosti
- Annulla modifica visibile

Risultato:

OK

---

8. Suggestion container

Esito:

- container_association_suggestions governato da input_analysis_result
- non appare vuoto
- la notice associazioni mancanti non promette suggerimenti se non sono visibili

Risultato:

OK

---

Validazioni finali:

✔ preview_analysis_state operativo
✔ input_analysis_result operativo come fonte UI parziale
✔ in quella fase ui_visibility_state era ancora operativo e non deprecato; stato successivamente superato da Visibility Migration Completion
✔ parser invariato
✔ matching invariato
✔ create_suggestion_state invariato
✔ command_intent_state invariato
✔ save flow invariato
✔ DB invariato

------------------------------------------------
INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION — TEST VALIDATI
------------------------------------------------

Micro-batch 1:

Test:

- Home vuota
- 20 euro villa
- 2h30 rendering lavoro
- acquisto 120 euro aspri allevamento aspri
- mario sopralluogo villa 2
- selezione manuale Mario Rossi
- 20 euro villa borghese
- Ignora suggerimenti
- crea
- crea progetto Nome Test
- edit input pieno
- edit input vuoto

Esito:

✔ container_input.Hidden migrato
✔ text_input_analysis_loading.Hidden migrato
✔ btn_cancel_edit.Hidden migrato
✔ btn_cancel_input_home.Hidden migrato
✔ edit input vuoto stabile
✔ Annulla modifica resta visibile
✔ command flow preservato
✔ event flow preservato
✔ suggestion flow preservato
✔ DB invariato
✔ parser invariato
✔ matching invariato
✔ save flow invariato

Note:

- label “Importo” su durata rilevata come residuo semantico preesistente
- policy match più specifici confermata non bloccante
- nav nascosta in edit mode confermata coerente

---

Micro-batch 2 — Confirm Hidden:

Test:

- Home vuota
- 20 euro villa
- 2h30 rendering lavoro
- crea
- crea progetto Nome Test
- mario sopralluogo villa 2
- edit input pieno
- edit input vuoto

Esito:

✔ button_input_confirm.Hidden migrato
✔ canShowConfirm introdotto come visibility-only
✔ button_input_confirm.Disabled invariato
✔ button_input_confirm payload invariato
✔ command flow non mostra Conferma
✔ edit input vuoto non mostra Conferma
✔ evento/edit input pieno mostrano Conferma

---

Smoke test finale post rimozione dipendenza ui_visibility_state:

Test:

- Home vuota
- 20 euro villa
- crea
- edit input vuoto

Esito:

✔ input_analysis_result non dipende più da ui_visibility_state
✔ graph Retool confermato
✔ nessuna regressione osservata

------------------------------------------------
LINTING / RETOOL QUERY SAFETY PASS — TEST VALIDATI
------------------------------------------------

Interventi:

- risolti linting “Misleading line break before ?”
- sostituiti ternari multilinea ambigui con if / else equivalenti
- corretti:
  - input_analysis_result
  - preview_analysis_state
  - create_suggestion_state
  - command_intent_state
- eliminata query legacy typing_state
- eliminata query legacy handle_event_success

Esito:

✔ linting Retool azzerati
✔ Performance unused query risolta
✔ evento normale validato
✔ command flow validato
✔ edit flow validato
✔ feedback/routing post-save validato
✔ no regressione visibility
✔ no regressione confirm
✔ no regressione command intent
✔ DB invariato
✔ parser invariato
✔ matching invariato
✔ save flow invariato
✔ payload invariato

------------------------------------------------
PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT — TEST VALIDATI
------------------------------------------------

Input:

20 euro materiale

Risultato:

- valore visualizzato: 20,00 €
- label riga valore: Importo
- icona riga valore: €
- parser invariato
- payload invariato
- save flow invariato

Esito: OK

---

Input:

2h30 rendering lavoro

Risultato:

- parsed.amount = 150
- parsed.unit = minuti
- valore visualizzato in forma umana
- label riga valore: Durata
- icona riga valore: ⏱️
- hint normalizzazione invariato, se previsto
- parser invariato
- duration normalization invariata

Esito: OK

---

Input:

1 ora lavoro

Risultato:

- parsed.unit = minuti
- type Tempo
- label riga valore: Durata
- icona riga valore: ⏱️
- save flow invariato

Esito: OK

---

Input:

villa 2 mario

Risultato:

- amount null
- unit null
- nessuna falsa durata
- nessun falso importo
- matching/highlight invariati

Esito: OK

---

Input:

crea progetto test

Risultato:

- command intent preservato
- Sintesi evento nascosta
- nessun evento salvato

Esito: OK

---

Edit evento NEW con durata:

Risultato:

- label riga valore: Durata
- edit flow non regressivo
- update_event invariato

Esito: OK

---

Save evento normale:

Risultato:

- payload invariato
- insert_event / update_event invariati
- DB invariato

Esito: OK

Regressioni:

- DB invariato
- parser invariato
- duration normalization invariata
- type classification invariata
- matching invariato
- command intent invariato
- preview_analysis_state invariato
- input_analysis_result invariato
- button_input_confirm invariato
- payload invariato
- save flow invariato

------------------------------------------------
BUTTON CONFIRM READINESS ALIGNMENT — TEST VALIDATI
------------------------------------------------

Nodo:

BUTTON CONFIRM READINESS ALIGNMENT

Gap collegato:

G33 — Button Confirm Readiness Alignment

Obiettivo:

allineare button_input_confirm.Disabled alla readiness funzionale reale del bottone Conferma,
distinguendo:

- visibilità del bottone
- abilitazione / disabilitazione
- blocchi reali
- warning non bloccanti
- command intent esclusi dal save flow evento

Modifica applicata:

button_input_confirm.Disabled è stato aggiornato per leggere solo:

- project_state.data?.isAmbiguous
- entity_state.data?.isAmbiguous

È stato rimosso il fallback grezzo:

- matches.length > 1

Codice runtime validato:

{{
  (() => {
    const projectAmbiguous =
      Boolean(project_state.data?.isAmbiguous);

    const entityAmbiguous =
      Boolean(entity_state.data?.isAmbiguous);

    return (
      !input_raw.value ||
      (projectAmbiguous && !select_project.value) ||
      (entityAmbiguous && !select_entity.value)
    );
  })()
}}

Test AS-IS pre-fix:

- 20 euro materiale → Conferma attiva
- 20 euro spesa materiale → Conferma attiva
- 2h30 rendering lavoro → Conferma attiva
- 20 euro attività generica → Conferma attiva, rilevato possibile falso positivo matching GENERIC fuori nodo
- 20 euro giardino → Conferma attiva
- 20 euro brico center → Conferma attiva
- 20 euro villa → Conferma attiva con hint progetti più specifici
- 20 euro mario → Conferma attiva con hint entità più specifiche
- crea → Conferma evento nascosta
- crea progetto test → Conferma evento nascosta
- crea entità test → Conferma evento nascosta
- edit evento NEW con input pieno → Conferma attiva
- edit evento NEW con input vuoto → Conferma non mostrata
- edit no-op → nessun update_event, comportamento invariato

Test mirati su dati reali:

- 20 euro villa sierri → select_project valorizzata su Villa, suggerimento nuovo progetto Villa Sierri, Conferma attiva
- 20 euro cucciolata marzo → nessun blocco, Conferma attiva
- 20 euro villa → Conferma attiva con warning non bloccante
- 20 euro tecnico → nessun blocco, Conferma attiva
- 20 euro mario → Conferma attiva con warning non bloccante
- 20 euro cliente → nessun blocco, Conferma attiva

Test post-fix:

- 20 euro materiale → Conferma visibile e attiva
- 20 euro villa → Conferma attiva con warning non bloccante
- 20 euro villa sierri → Conferma attiva; rischio match generico osservato fuori nodo
- crea progetto test → container command visibile, Conferma evento non mostrata

Esito:

- nessuna regressione evento ordinario
- nessuna regressione warning non bloccanti
- nessuna regressione match più specifici
- nessuna regressione command intent
- nessuna regressione edit flow osservata
- payload invariato
- insert_event invariato
- update_event invariato
- DB invariato
- Supabase invariato

Classificazione finale:

G33 completato.

button_input_confirm.Disabled è ora più coerente con la fonte interpretata del Match Engine,
ma resta separato da input_analysis_result.

Nota fuori nodo:

I test hanno evidenziato un rischio collegato a match generico / auto-select confidence:

20 euro villa sierri
→ select_project = Villa
→ suggestion: possibile nuovo progetto Villa Sierri
→ Conferma attiva

Questo non è un problema di Disabled,
ma un tema da assorbire in G22:

Project Create Suggestion — Match Present / User Override

Possibile estensione futura:

- auto-select confidence
- gestione match generico salvabile
- filtro/priorità contestuale delle select project/entity

Vincoli:

- non modificata la policy del Match Engine nel nodo G33
- non trasformati warning informativi in blocchi
- non modificati select_project / select_entity
- non modificata create_suggestion_state
- non modificato input_analysis_result
- nessuna centralizzazione completa della save readiness

------------------------------------------------
INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION — TEST / ANALISI
------------------------------------------------

Nodo:

INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION

Gap collegato:

G29 — Feedback / Input Flow Micro-flash Cleanup

Obiettivo:

analizzare flash residui durante digitazione, cambio stato input e transizioni command / event / empty.

Esito osservato:

- flash/riga container_input visibile per pochi istanti
- comportamento riproducibile soprattutto durante transizioni command → event → empty
- comportamento non bloccante
- console Retool senza errori
- nessuna regressione funzionale rilevata

Test / tentativi eseguiti:

1. Verifica Hidden container_command_intent
2. Verifica Hidden btn_cancel_input_home
3. Verifica Hidden btn_cancel_edit
4. Verifica Hidden text_input_analysis_loading
5. Verifica Hidden container_input
6. Verifica Hidden txt_command_intent_title / description
7. Test forzato container_input.Hidden = true
8. Test layout/stile container_input:
   - Height
   - Padding
   - Margin
   - Show body
   - Show border
9. Verifica container_home
10. Verifica wrapper
11. Test Strada B:
   - Variable input_shell_visible
   - micro-latch sul Change handler di input_home
   - container_input.Hidden basato su input_shell_visible

Risultato Strada B:

- input_shell_visible non ha risolto stabilmente il comportamento
- comportamento visibile sostanzialmente invariato
- input_shell_visible non mantenuto nel runtime attivo

Rollback:

container_input.Hidden mantenuto / ripristinato su:

{{ !input_analysis_result.value?.mode?.effectiveIsInputFlow }}

input_home Change handler mantenuto / ripristinato nella versione pre-latch.

Classificazione finale:

G29 resta:

RESIDUO UX MINORE ACCETTABILE / IN OSSERVAZIONE

Regressioni:

- parser invariato
- parse_input_controlled invariato
- duration normalization invariata
- type classification invariata
- matching invariato
- project_state/entity_state invariati
- command_intent_state invariato
- create_suggestion_state invariato
- input_analysis_result invariato
- preview_analysis_state invariato
- button_input_confirm.Disabled invariato
- payload invariato
- save flow invariato
- insert_event / update_event invariati
- DB invariato
- Supabase invariato
- ui_visibility_state non eliminato
- nessun cleanup globale eseguito

CHANGELOG

v01 — 2026-04-01

runtime iniziale

v02 — 2026-04-03

parsing retrofit completo
fix type detection
entity matching migliorato
fix numero finale
allineamento completo runtime

v03 — 2026-04-03

fix insert pipeline
supporto unit compatte
fix amount multi-numero
allineamento preview → DB

v04 — 2026-04-23

introduzione update_event
introduzione edit_mode
refactor confirm flow
introduzione handle_event_success
aggiornamento UI state
identificazione loop reattivo
allineamento runtime con sistema reale

v05 — 2026-04-30

introduzione parse_input_controlled come parser runtime
introduzione trigger_parse_debounced
stabilizzazione ui_state.parsed
completamento Normalization Layer Base
normalizzazione amount formato italiano
normalizzazione unit base
supporto unità compatte testuali
rimozione amount per numeri senza unità
rimozione parsing legacy da button_input_confirm
allineamento insert/update a ui_state.parsed
validazione insert con dati normalizzati
validazione update con dati normalizzati
fix race condition update → events_new
refresh lista dopo save completato
apertura prossimo nodo: Preview Alignment Base

v06 — 2026-04-30

completamento PREVIEW ALIGNMENT BASE
documentata formattazione italiana amount nella sintesi
introduzione formatAmountIT
introduzione formatUnitIT
euro visualizzato con due decimali
grouping migliaia visuale
unità tempo visualizzate coerentemente
singolare/plurale unit gestito
label cleaning preview aggiornato
rimozione amount/unit dalla label migliorata
risolto bug "minuti" → "uti"
separatore data/descrizione uniformato
introduzione previewStopTokens
introduzione getPreviewTokens
highlight locale reso unit-safe
confermato che preview non modifica DB
confermato save flow invariato
prossimo nodo operativo consigliato: STEP 6.2 — DURATION NORMALIZATION

v07 — 2026-04-30

completamento ENGINE BASE — DURATION NORMALIZATION
definita unità canonica tempo in minuti
durate certe ore/minuti convertite in minuti
1 ora → 60 minuti
1,5 ore → 90 minuti
1 ora e 15 minuti → 75 minuti
2h30 → 150 minuti
2 ore 30 → 150 minuti
90 minuti → 90 minuti
giorni/settimane riconosciuti come ambigui ma non convertiti
aggiornato parse_input_controlled
preview durata aggiornata con forma umana
introdotto hint “Normalizzato: X minuti”
introdotto hint durata ambigua
label cleaning aggiornato per rimuovere durate composte
insert/update validati runtime
regressioni euro/date/numeri semantici superate
nessuna modifica DB
nessuna modifica button_input_confirm
nessuna modifica insert_event/update_event
nessuna modifica matching
nessuna type classification
prossimo nodo operativo consigliato: STEP 6.3 — TYPE CLASSIFICATION BASE

v08 — 2026-05-01

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
aggiornamento prossimo nodo consigliato: STEP 6.4 — MATCH ENGINE UNIFICATION

v09 — 2026-05-02

completamento MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL
project_state aggiornato come fonte minima matching project
entity_state aggiornato come fonte minima matching entity
aggiunti output matching:
- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches
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
bug €500 nella label preview risolto
linting project_state/entity_state ripuliti
linting residui edit_mode/editing_event mantenuti come nodo futuro
nessuna modifica DB
nessuna modifica parser
nessuna modifica type classification
nessuna modifica duration normalization
nessun output/KPI anticipato

v10 — 2026-05-03

completamento UX / CLEANUP MICRO-BATCH POST MATCH ENGINE
documentato btn_cancel_edit
documentato annulla modifica senza update_event
documentato no-op edit guard
documentato edit senza modifiche reali senza update_event
documentato input_events_search
documentato filtro client-side lista eventi
documentata label creato/modificato
documentata normalizzazione robusta created_at / updated_at
documentato fix doppia visibilità input/lista dopo Annulla
completamento LINTING / STATE HELPER CLEANUP
documentata risoluzione linting edit_mode: 'value' is not defined
documentata risoluzione linting editing_event: 'value' is not defined
rimossa dipendenza da additionalScope { value } per edit_mode / editing_event
introdotto passaggio controllato tramite window.__logos_edit_mode_value
introdotto passaggio controllato tramite window.__logos_editing_event_value
documentato edit_mode come helper tecnico window-backed
documentato editing_event come helper tecnico window-backed
documentato reset chiavi window dopo lettura helper
aggiornato btn_edit
aggiornato btn_cancel_edit
aggiornato button_input_confirm nel ramo no-op edit guard
aggiornato button_input_confirm nel reset finale dopo salvataggio reale
editing_event azzerato anche dopo update reale completato
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

v11 — 2026-05-09

completamento PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
documentato create_suggestion_state
documentate variabili project/entity inline open e dismissed
documentato insert_project
documentato insert_entity
documentato container_association_suggestions
documentati micro-editor project/entity
documentato bottone Ignora globale
documentati bottoni Annulla contestuali
documentato Duplicate Guard project/entity
documentato entity autofill controlled minimal
documentato project create flow
documentato entity create flow
documentato che evento non viene salvato automaticamente dopo creazione project/entity
documentato che select_project/select_entity sono decisione utente finale
documentato flow combinato project + entity validato
documentato no-match generico salvabile
documentato blocco solo su ambiguità attiva

completamento UX MOBILE COHERENCE PASS
documentata Home mobile rifinita
documentata Events list mobile rifinita
documentato Feedback mobile stabilizzato
documentato feedback_summary in ui_state
documentato handle_event_success non più gestore UI post-save
documentato button_input_confirm come gestore centrale feedback/routing
documentato insert reale → feedback 1800 ms → Home
documentato update reale → feedback 1800 ms → Lista eventi
documentato no-op edit → Lista eventi immediata senza update_event
documentato cancel create/input → Home
documentato cancel edit → Lista eventi
documentata Navigation dock Home / Eventi / Dashboard
documentata Dashboard presente ma disabilitata
documentata nav contestuale Home/Events
documentati Dati evento compatti con label inline nelle select
documentati Icon add-ons Retool nei pulsanti reali
documentato font-size input/select 16px per Safari iOS
documentato zoom automatico iOS Safari risolto
documentate select mobile funzionanti sia in digitazione sia in dropdown
documentata validazione reale iPhone 13 Safari
DB invariato
parser invariato
matching invariato
type classification invariata
duration normalization invariata
nessun output/KPI anticipato

v12 — 2026-05-13

completamento COMMAND INTENT — CREATE PROJECT / ENTITY
documentato command_intent_state
documentato container_command_intent
documentati txt_command_intent_loading / title / description / summary / notice
documentati input_command_project_name / input_command_entity_name
documentati btn_command_create_project / btn_command_create_entity / btn_command_go_events
documentato comando generico “crea”
documentato create project incompleto
documentato create project completo
documentato create entity incompleto
documentato create entity completo
documentati sinonimi base crea / aggiungi / inserisci / nuovo / nuova
documentato elemento già presente
documentato “crea progetto villa” come elemento già presente
documentata guida non operativa “modifica evento”
documentato che comandi puri non salvano eventi
documentato che project/entity da command richiedono conferma utente
documentato riuso insert_project / insert_entity da command
documentato feedback_mode in ui_state
documentato feedback project_created
documentato feedback entity_created
documentato feedback evento ordinario preservato
documentato trigger_parse_debounced con command_intent_state
documentata separazione tra evento ordinario e comando puro
documentato button_input_confirm come dedicato agli eventi ordinari
documentati hidden/guard principle per command intent
documentato Supabase passivo rispetto al command intent
documentato che nessun comando puro crea record events
aggiunti test Command Intent validati
evento ordinario non regressivo validato
edit flow non regressivo validato
DB invariato
parser invariato
matching invariato
create_suggestion_state invariato
type classification invariata
duration normalization invariata
nessun output/KPI anticipato
documentati residui:
- command intent solo primo livello controllato
- command intent avanzato non implementato
- input analysis model unico non implementato
- rendering progressivo input evento normale ancora migliorabile
- “Da verificare” interno alla Sintesi

v13 — 2026-05-18

completamento UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
documentato ui_visibility_mode come Variable Retool
documentato ui_visibility_state come Transformer read-only
ui_visibility_mode supporta empty / event / command
trigger_parse_debounced aggiorna ui_visibility_mode
documentato window.__logos_visibility_run_id
documentata classificazione locale event/command solo per visibilità UI
documentato che ui_visibility_state non sostituisce parser, matching, command_intent_state o create_suggestion_state
documentata centralizzazione Hidden principali:
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
5 linting Retool residui documentati
cleanup obsolete UI guards / query reduction rimandato

v14 — 2026-05-20

completamento PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
documentato preview_analysis_state come Transformer read-only
documentato preview_analysis_state come fonte hint/status/warning/Da verificare/associazioni mancanti della Sintesi
documentato che preview_analysis_state non modifica parser, matching, command_intent_state, create_suggestion_state, save flow o DB
documentato che la Sintesi resta responsabile del rendering HTML finale

completamento INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
documentato input_analysis_result come Transformer compositivo read-only
documentata distinzione raw / selection / effective
documentato event / command / edit effective flow
documentato command raw vs command effective
documentato edit mode prevalente su command intent
documentato project/entity raw match vs effective usability
documentato che input_analysis_result non alimenta select_project / select_entity
documentato che input_analysis_result non costruisce payload save
documentato che input_analysis_result non sostituisce parser o matching

completamento INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS
documentato input_analysis_result come fonte UI controllata parziale
documentata migrazione di sintesi.Hidden a input_analysis_result
documentata migrazione di text_event_data_title / select1 / select_project / select_entity Hidden a input_analysis_result
documentata migrazione di container_command_intent.Hidden a input_analysis_result
documentata migrazione di container_association_suggestions.Hidden a input_analysis_result
documentata micro-copy notice associazioni mancanti coerente con presenza reale suggerimenti
documentato edit mode + input vuoto stabilizzato
documentato Home idle container nascosti durante edit mode
documentato Dati evento / Sintesi / Conferma nascosti con edit input vuoto
documentato che solo Annulla modifica resta visibile in edit input vuoto
documentato che in quella fase ui_visibility_state restava operativo e non deprecato; stato successivamente superato da Visibility Migration Completion
documentato che in quella fase container_input / loading / cancel / confirm restavano fuori dalla migrazione corrente; stato successivamente superato da Visibility Migration Completion
documentato che in quella fase button_input_confirm non era ancora migrato; stato successivamente superato dalla migrazione di button_input_confirm.Hidden a input_analysis_result.readiness.canShowConfirm
documentato che button_input_confirm payload resta invariato
documentato che save readiness non è centralizzata
documentato aumento linting Retool a 19
aggiunta sezione test Input Analysis Result Controlled UI Consumption Pass
aggiornati limiti attuali
aggiornati principi runtime
aggiornato stato runtime
DB invariato
parser invariato
matching invariato
create_suggestion_state invariato
command_intent_state invariato
insert_event / update_event invariati
insert_project / insert_entity invariati
nessun output/KPI anticipato

v15 — 2026-05-23

completamento INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
documentato input_analysis_result come fonte UI controllata per gli Hidden principali del flow input
documentata migrazione container_input.Hidden a input_analysis_result
documentata migrazione text_input_analysis_loading.Hidden a input_analysis_result
documentata migrazione btn_cancel_edit.Hidden a input_analysis_result
documentata migrazione btn_cancel_input_home.Hidden a input_analysis_result
documentato canShowConfirm come flag visibility-only
documentata migrazione button_input_confirm.Hidden a input_analysis_result.readiness.canShowConfirm
documentato canShowConfirm distinto da canConfirm
documentato button_input_confirm.Disabled invariato
documentato button_input_confirm payload invariato
documentata rimozione dipendenza input_analysis_result → ui_visibility_state
documentato che input_analysis_result non legge più ui_visibility_state
documentato ui_visibility_state come residuo tecnico deprecabile
documentato ui_visibility_mode come latch empty / event / command
documentato routing principale app su ui_state.view
documentato graph Retool post-rimozione dipendenza
documentato residuo label “Importo” su durata
documentato residuo flash digitazione/cambio schermata
documentati test Visibility Migration Completion
confermato DB invariato
confermato parser invariato
confermato matching invariato
confermato create_suggestion_state invariato
confermato command_intent_state invariato nella logica funzionale
confermato insert_event / update_event invariati
confermato payload invariato

completamento LINTING / RETOOL QUERY SAFETY PASS
documentato linting Retool azzerato
documentata sostituzione ternari multilinea ambigui con if / else equivalenti
documentate correzioni in input_analysis_result
documentate correzioni in preview_analysis_state
documentate correzioni in create_suggestion_state
documentate correzioni in command_intent_state
documentata eliminazione query legacy typing_state
documentata eliminazione query legacy handle_event_success
documentata Performance unused query risolta
documentati test post-rimozione query legacy
aggiornata sezione QUERY
aggiornata sezione HELPER VISIBILITY STATE — RUNTIME
aggiornata sezione INPUT_ANALYSIS_RESULT
aggiornata sezione INSERT / UPDATE EVENT
aggiornati LIMITI ATTUALI
aggiornati PRINCIPI RUNTIME
aggiornato STATO RUNTIME
allora indicato come prossimo nodo candidato prioritario: DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION; nodo successivamente completato e consolidato nel checkpoint finale dedicato

v16 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicato Pacchetto D — LOGOS_RETOOL_RUNTIME_REAL / Runtime Manifest Normalization
- documento aggiornato da v15 a v16
- confermato LOGOS_RETOOL_RUNTIME_REAL come manifest runtime reale Retool as-is
- aggiunta sezione RESPONSABILITÀ CANONICA DEL DOCUMENTO
- chiarito che LOGOS_RETOOL_RUNTIME_REAL documenta ciò che esiste realmente in Retool
- chiarito che il documento non sostituisce i documenti tecnici canonici
- aggiunti richiami canonici a:
  - 01_LOGOS_Input_System per input flow, parser, normalization, Command Intent, create_suggestion_state e input_analysis_result
  - 02_LOGOS_Match_Engine per Match Engine project/entity
  - 03_LOGOS_Event_Lifecycle per lifecycle evento
  - 04_LOGOS_Retool_Architecture per componenti/query/Hidden/wiring Retool
  - 05_LOGOS_Database_Schema per schema DB LOGOS
  - 06_LOGOS_View_Preview_System per Sintesi, preview, hint e warning
  - LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase reale as-is
- riallineati residui documentali su ui_visibility_state come stato storico / residuo tecnico deprecabile
- chiarito che ui_visibility_state non è più fonte canonica della visibility del flow input
- chiarito che gli Hidden principali del flow input sono migrati a input_analysis_result
- chiarito che button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm
- confermato che button_input_confirm.Disabled e payload restano separati
- resi storici i riferimenti del Controlled UI Consumption Pass a ui_visibility_state operativo/non deprecato
- resi storici i riferimenti del changelog v14 a container_input/loading/cancel/confirm fuori migrazione
- aggiunte note canoniche nelle sezioni trigger_parse_debounced, input_analysis_result, parsing/normalization, matching, preview, insert/update e Supabase
- corretto refuso “supportatei”
- nessuna riduzione aggressiva applicata
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica schema
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica payload
- nessuna anticipazione output / KPI / dashboard

v17 — 2026-05-26

- completamento PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT
- aggiornato runtime reale della Sintesi Retool
- risolto residuo label “Importo” su valori durata
- introdotta label semantica della riga valore:
  - euro → Importo
  - ore / minuti → Durata
  - fallback non riconosciuto → Valore
- introdotta icona dinamica della riga valore:
  - € per dati economici
  - ⏱️ per dati temporali
  - 🔢 per fallback valore
- sostituita riga runtime fissa row("€", "Importo", amountLabel)
- nuova riga runtime row(valueRowIcon, valueRowLabel, amountLabel)
- confermato che la modifica è solo visuale / micro-copy
- confermato parser invariato
- confermata duration normalization invariata
- confermata type classification invariata
- confermato matching invariato
- confermato command intent invariato
- confermato preview_analysis_state invariato
- confermato input_analysis_result invariato
- confermato button_input_confirm invariato
- confermato payload invariato
- confermato save flow invariato
- confermato DB invariato
- test runtime superati:
  - 20 euro materiale → Importo
  - 2h30 rendering lavoro → Durata
  - 1 ora lavoro → Durata
  - villa 2 mario → nessuna falsa durata/importo
  - crea progetto test → command intent non regressivo
  - edit evento NEW con durata → non regressivo
  - save evento normale → payload invariato

  v18 — 2026-06-01

- aggiornamento post INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION
- documento aggiornato da v17 a v18
- G29 Feedback / Input Flow Micro-flash Cleanup analizzato su runtime Retool reale
- osservato flash/riga container_input durante transizioni input / command / empty
- confermato comportamento riproducibile ma non bloccante
- confermata console Retool senza errori
- testati Hidden di container_input
- testati Hidden dei figli principali:
  - text_input_analysis_loading
  - text_edit_mode_notice
  - btn_cancel_input_home
  - container_command_intent
- testati layout/stile di container_input:
  - Height
  - Padding
  - Margin
  - Show body
  - Show border
- verificati container_home e wrapper come possibili cause layout
- testata Strada B con micro-latch input_shell_visible
- input_shell_visible non risolutivo e non mantenuto
- rollback effettuato alla base stabile
- confermato container_input.Hidden basato su input_analysis_result.value?.mode?.effectiveIsInputFlow
- confermato input_home Change handler pre-latch
- nessuna modifica runtime definitiva mantenuta
- confermato parser invariato
- confermato parse_input_controlled invariato
- confermata duration normalization invariata
- confermata type classification invariata
- confermato matching invariato
- confermati project_state/entity_state invariati
- confermato command_intent_state invariato
- confermato create_suggestion_state invariato
- confermato input_analysis_result invariato
- confermato preview_analysis_state invariato
- confermato button_input_confirm.Disabled invariato
- confermato button_input_confirm payload invariato
- confermato save flow invariato
- confermati insert_event / update_event invariati
- confermato DB invariato
- confermato Supabase invariato
- confermata nessuna eliminazione di ui_visibility_state
- confermato nessun cleanup globale
- G29 classificato come residuo UX minore accettabile / in osservazione
- prossimo nodo operativo consigliato: BUTTON CONFIRM READINESS ALIGNMENT
- nessuna anticipazione Preview Model / Hint State Consolidation
- nessuna anticipazione cleanup ui_visibility_state
- nessuna anticipazione output / KPI / dashboard

v19 — 2026-06-01

- completamento BUTTON CONFIRM READINESS ALIGNMENT
- documento aggiornato da v18 a v19
- aggiornato button_input_confirm.Disabled
- Disabled ora legge solo project_state.data?.isAmbiguous e entity_state.data?.isAmbiguous
- rimosso fallback grezzo matches.length > 1 dalla guard Disabled
- confermato button_input_confirm.Hidden invariato
- confermato canShowConfirm come visibility-only
- confermato button_input_confirm payload invariato
- confermati insert_event / update_event invariati
- confermato parser invariato
- confermata duration normalization invariata
- confermata type classification invariata
- confermato matching invariato nella logica funzionale
- confermati project_state/entity_state invariati come fonti matching
- confermati select_project/select_entity invariati
- confermato command_intent_state invariato
- confermato create_suggestion_state invariato
- confermato preview_analysis_state invariato
- confermato input_analysis_result invariato
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
- nessuna anticipazione Match Engine Advanced
- nessuna modifica select options / candidate filtering
- nessuna modifica save readiness centralizzata
- nessuna anticipazione dashboard / KPI / output