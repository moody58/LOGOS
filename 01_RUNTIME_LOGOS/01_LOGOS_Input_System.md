# 01_LOGOS_Input_System_v16

DATA: 2026-05-23

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il comportamento operativo completo
del sistema di input LOGOS.

Il documento è utilizzato per:

- implementazione Retool
- sviluppo parsing
- gestione preview
- controllo qualità input
- normalizzazione base dei dati parsati
- duration normalization base
- type classification base
- allineamento preview ai dati parsati
- allineamento insert/update
- salvataggio type in events.type
- Match Engine Unification First Controlled Level
- allineamento matching project/entity
- gestione ambiguità project/entity
- allineamento create/edit flow con project_state/entity_state
- UX / Cleanup Micro-Batch Post Match Engine
- annulla modifica evento
- no-op edit guard
- Linting / State Helper Cleanup
- edit_mode / editing_event senza additionalScope { value }
- reset helper edit flow tramite window.__logos_edit_mode_value / window.__logos_editing_event_value
- Project / Entity Create Suggestion First Controlled Level
- gestione suggestion project/entity da input libero
- creazione inline controllata project/entity
- create_suggestion_state
- insert_project / insert_entity
- entity autofill controlled minimal
- separazione tra input evento e futuro command intent
- UX Mobile Coherence Pass
- Home mobile rifinita
- Dati evento compatti con label inline
- Feedback mobile stabilizzato
- feedback_summary come riepilogo UI temporaneo
- routing post-save contestuale
- insert → feedback → Home
- update → feedback → Lista eventi
- no-op edit → Lista eventi senza feedback
- cancel create/input → Home
- cancel edit → Lista eventi
- Navigation dock Home / Eventi / Dashboard
- Dashboard predisposta ma disabilitata
- font-size 16px input/select come baseline mobile Safari
- Command Intent — Create Project / Entity
- distinzione tra input evento e comando strutturale puro
- command_intent_state
- container_command_intent
- creazione project/entity da command solo previa conferma utente
- esclusione dei comandi puri dal salvataggio evento
- guida non operativa per “modifica evento”
- feedback project_created / entity_created
- feedback_mode come indicatore UI temporaneo
- UI Readiness / Visibility Aggregator — First Controlled Level
- ui_visibility_mode come latch UI empty / event / command
- ui_visibility_state come aggregatore read-only di visibilità input flow
- centralizzazione Hidden principali del flow input
- Preview Analysis State — First Controlled Layer
- preview_analysis_state come Transformer read-only per hint/status della Sintesi
- Input Analysis Result / Single Interpretation Layer Base — Read-only Diagnostic
- input_analysis_result come layer compositivo raw / selection / effective
- Input Analysis Result — Controlled UI Consumption Pass
- prima migrazione controllata degli Hidden principali da ui_visibility_state a input_analysis_result
- Input Analysis Result — Visibility Migration Completion
- migrazione completata degli Hidden principali del flow input a input_analysis_result
- container_input.Hidden migrato a input_analysis_result
- text_input_analysis_loading.Hidden migrato a input_analysis_result
- btn_cancel_edit / btn_cancel_input_home Hidden migrati a input_analysis_result
- button_input_confirm.Hidden migrato a input_analysis_result.readiness.canShowConfirm
- canShowConfirm distinto da canConfirm
- button_input_confirm.Disabled preservato come guard funzionale separata
- button_input_confirm payload invariato
- input_analysis_result non legge più ui_visibility_state
- ui_visibility_state residuo tecnico deprecabile, non cancellato
- ui_visibility_mode confermato come latch leggero empty / event / command
- routing principale app confermato su ui_state.view
- Linting / Retool Query Safety Pass
- linting Retool azzerati
- typing_state eliminato come query legacy unused
- handle_event_success eliminato come query legacy unused
- container_input stabilizzato tramite ui_visibility_state
- container vuoto durante digitazione risolto
- bottom bar flash risolto
- text_input_analysis_loading
- text_edit_mode_notice
- edit mode prevalente su Command Intent
- feedback project/entity timing alignment
- residui UI Readiness documentati

------------------------------------------------
PRINCIPI FONDANTI
------------------------------------------------

1. INPUT NON BLOCCANTE

L’utente deve sempre poter inserire un evento.

---

2. SALVARE > CORREGGERE

È preferibile salvare un dato imperfetto
piuttosto che bloccare l’inserimento.

---

3. MIGLIORAMENTO PROGRESSIVO

La qualità del dato viene migliorata nel tempo,
non imposta all’ingresso.

---

4. UTENTE NON TECNICO

Il sistema deve essere comprensibile senza formazione.

---

5. SUGGERIRE ≠ DECIDERE

Il sistema suggerisce, l’utente decide.

---

6. FONTI CONTROLLATE PER IL SALVATAGGIO

I dati strutturati salvati nel DB devono derivare da fonti runtime controllate:

- amount / unit / event_date → ui_state.parsed
- type → select1.value
- project_id → select_project.value
- entity_id → select_entity.value

Il matching project/entity è calcolato da:

- project_state
- entity_state

Le select leggono il risultato del match state:

- select_project → project_state.data.singleMatch
- select_entity → entity_state.data.singleMatch

Il bottone di conferma NON deve ricalcolare parsing
e NON deve ricalcolare matching.

Deve solo costruire il payload usando lo stato già disponibile.

---

7. MATCHING NON DECISIONALE

Il match engine suggerisce e segnala.

Non crea project/entity.
Non forza selezioni ambigue.
Non sostituisce la scelta utente.

Regole:

- match univoco → select valorizzata
- match ambiguo non risolto → conferma bloccata
- match ambiguo risolto manualmente → conferma consentita
- nessun match → conferma consentita

---

8. SUGGESTION ≠ SALVATAGGIO

Le suggestion project/entity aiutano l’utente a completare il dato,
ma non salvano automaticamente eventi.

La catena corretta è:

input libero
→ match state
→ create_suggestion_state
→ suggestion visibile
→ conferma utente
→ insert_project / insert_entity
→ select_project / select_entity valorizzata
→ eventuale Conferma evento manuale

Regole:

- nessuna creazione project/entity automatica silenziosa
- nessun evento salvato automaticamente dopo creazione project/entity
- suggestion ignorata non blocca il salvataggio
- project/entity mancanti non bloccano il salvataggio
- project/entity ambigui bloccano il salvataggio finché non risolti manualmente

---

9. INPUT EVENTO ≠ COMMAND INTENT

Frasi come:

- crea
- crea progetto Aspri
- aggiungi progetto Villa Nuova
- inserisci progetto Villa Nuova
- crea entità Patrizio
- aggiungi entità Referente Kappa
- modifica evento

sono ora gestite a primo livello controllato dal Command Intent.

Il runtime distingue:

- input evento ordinario
- comando strutturale puro
- guida non operativa

Regole:

- un comando puro NON deve essere salvato come evento
- un comando puro NON deve mostrare Sintesi evento / Dati evento
- project/entity da command vengono creati solo previa conferma utente
- command_intent_state non salva dati
- command_intent_state non modifica DB
- command_intent_state non modifica parser
- command_intent_state non modifica matching
- command_intent_state non sostituisce create_suggestion_state
- insert_project / insert_entity restano le query operative di creazione
- select_project / select_entity restano fonti salvabili finali per gli eventi
- “modifica evento” non apre un edit flow parallelo
- “modifica evento” guida l’utente alla lista eventi

Nota:

Command Intent è implementato solo a primo livello controllato.
Non è ancora un intent engine globale.

---

10. UI READINESS / INPUT ANALYSIS RESULT ≠ MOTORE MONOLITICO

Il sistema ha introdotto prima un livello controllato di readiness/visibility UI:

- ui_visibility_mode
- ui_visibility_state

Successivamente ha introdotto:

- preview_analysis_state
- input_analysis_result

preview_analysis_state:

- raccoglie hint/status/warning/Da verificare/associazioni mancanti della Sintesi
- è read-only
- non salva dati
- non modifica parser
- non modifica matching
- non modifica command_intent_state
- non modifica create_suggestion_state
- non modifica save flow
- non modifica DB

input_analysis_result:

- compone lo stato dell’input flow
- distingue raw / selection / effective
- distingue event / command / edit flow
- legge parser, matching, select, suggestion, command e preview state
- non ricalcola parsing
- non ricalcola matching
- non alimenta select_project / select_entity
- non costruisce payload save
- non modifica DB

Regola architetturale:

LOGOS non evolve verso un mega-motore monolitico.

La direzione corretta è:

- moduli specializzati che calcolano
- input_analysis_result che compone
- UI che legge progressivamente una verità operativa coerente

Stato attuale:

input_analysis_result è fonte UI controllata per gli Hidden principali del flow input:

- sintesi.Hidden
- text_event_data_title.Hidden
- select1.Hidden
- select_project.Hidden
- select_entity.Hidden
- container_command_intent.Hidden
- container_association_suggestions.Hidden
- micro-copy notice associazioni mancanti
- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden

ui_visibility_state:

- non è più letto da input_analysis_result
- non governa più gli Hidden principali migrati
- resta presente come residuo tecnico deprecabile / rollback
- non va cancellato fuori da nodo cleanup dedicato

Regole:

- input_analysis_result non è ancora Input Analysis Model completo
- input_analysis_result non è Event Interpretation Engine
- ui_visibility_state è deprecabile ma non eliminato
- button_input_confirm.Hidden è migrato a input_analysis_result
- button_input_confirm.Disabled non è ancora migrato
- button_input_confirm payload resta invariato
- save readiness non è ancora centralizzata
- non esiste più dipendenza input_analysis_result → ui_visibility_state
- resta vietato creare dipendenze inverse o loop tra visibility helper

---

11. EDIT FLOW CONTROLLATO

Il flow di modifica evento usa helper tecnici dedicati:

- edit_mode
- editing_event

Questi helper non sono fonte business.

Servono solo per:

- distinguere create flow da edit flow
- conservare l’evento NEW in modifica
- permettere Annulla
- permettere no-op edit guard
- chiudere correttamente il flow edit
- supportare il routing post-save contestuale
- permettere a button_input_confirm di decidere se tornare Home o Lista eventi dopo feedback

Dopo Linting / State Helper Cleanup,
edit_mode / editing_event non usano più:

additionalScope { value }

Il passaggio tecnico avviene tramite:

- window.__logos_edit_mode_value
- window.__logos_editing_event_value

Gli helper leggono la chiave window,
la cancellano dopo la lettura
e ritornano il valore controllato.

Nota UX Mobile Coherence Pass:

edit_mode viene usato anche per distinguere:

- insert reale → feedback → Home
- update reale → feedback → Lista eventi
- cancel create/input → Home
- cancel edit → Lista eventi

12.  FEEDBACK TEMPORANEO ≠ STATO EVENTO

Il feedback post-salvataggio è una conferma UI temporanea.

Non è:

- stato evento
- dato persistente
- validazione WRITTEN
- output analitico
- dato salvato nel DB

Il feedback usa:

- feedback_mode
- feedback_text
- feedback_project
- feedback_summary

Regole:

- feedback_summary viene creato prima del reset input/select
- feedback_summary viene usato solo dalla UI feedback
- feedback_summary viene azzerato dopo auto-return
- feedback_summary non viene salvato nel DB

feedback_mode distingue il tipo di feedback mostrato.

Valori usati:

- project_created
- entity_created
- null / event_created

Regole:

- feedback_mode è UI temporaneo
- non viene salvato nel DB
- viene azzerato dopo auto-return
- permette a feedback_title e feedback_resume di distinguere Evento / Progetto / Entità

Routing consolidato:

- insert reale → feedback 1800 ms → Home
- update reale → feedback 1800 ms → Lista eventi
- no-op edit → Lista eventi immediata senza feedback

13.  MOBILE SAFARI BASELINE

Su iPhone 13 Safari reale è stato rilevato che input/select con font troppo piccolo causavano:

- zoom automatico iOS
- troncamento laterale dell’app
- comportamento anomalo dropdown sulle select

Fix consolidato:

- font-size 16px su input/select principali

Regola:

I campi editabili e select principali devono mantenere font-size minimo 16px su mobile Safari.

Eventuali rifiniture future di font/spaziature non devono riattivare lo zoom automatico iOS.

------------------------------------------------
ARCHITETTURA INPUT
------------------------------------------------

COMPONENTI:

input_home
→ input utente (source of truth)

input_raw
→ derivato tecnico per parsing

trigger_parse_debounced
→ debounce del parsing

ui_visibility_mode
→ Variable Retool
→ latch UI leggero empty / event / command
→ aggiornata da trigger_parse_debounced
→ non salva dati
→ non sostituisce command_intent_state

command_intent_state
→ helper controllato per riconoscere comandi puri
→ distingue comando strutturale da evento ordinario
→ non salva dati
→ non modifica parser/matching/DB

ui_visibility_state
→ Transformer Retool legacy/residuo
→ precedentemente aggregava flag di visibilità del flow input
→ non è più letto da input_analysis_result
→ non governa più gli Hidden principali migrati
→ resta presente come residuo tecnico / rollback fino a cleanup dedicato
→ non è fonte dati salvabile
→ è deprecabile ma non eliminato

preview_analysis_state
→ Transformer Retool read-only
→ raccoglie hint/status/warning/Da verificare/associazioni mancanti della Sintesi
→ fonte specializzata per preview/hint
→ non salva dati
→ non modifica parser/matching/save flow/DB

input_analysis_result
→ Transformer Retool compositivo read-only
→ aggrega input, parsed, type, project/entity, selection, suggestion, command, preview e readiness
→ espone raw / selection / effective
→ fonte UI controllata per gli Hidden principali del flow input
→ governa readiness/visibility per Sintesi, Dati evento, Command, Suggestion, Input container, Loading, Cancel e Conferma Hidden
→ espone canShowConfirm come flag visibility-only
→ non alimenta select_project / select_entity
→ non costruisce payload save
→ non modifica DB

parse_input_controlled
→ parser controllato + normalization base + duration normalization base

ui_state.parsed
→ fonte unica per preview/save/edit

select1
→ fonte runtime per type classification base
→ valore salvato in events.type

project_state
→ fonte minima matching project
→ calcola matches / count / isAmbiguous / singleMatch

entity_state
→ fonte minima matching entity
→ calcola matches / count / isAmbiguous / singleMatch

create_suggestion_state
→ helper controllato per suggestion project/entity
→ legge input_raw, project_state, entity_state, projects_list, entities_list
→ non salva dati
→ non decide al posto dell’utente
→ alimenta container suggestion inline

select_project
→ legge project_state.data.singleMatch
→ fonte salvabile per project_id

select_entity
→ legge entity_state.data.singleMatch
→ fonte salvabile per entity_id

input_new_project_name
→ campo micro-editor per creazione project inline

input_new_entity_name
→ campo micro-editor per creazione entity inline

insert_project
→ crea project solo previa conferma utente

insert_entity
→ crea entity solo previa conferma utente

container_command_intent
→ UI dedicata ai comandi riconosciuti
→ visibile solo per command intent coerente con input corrente
→ nasconde Sintesi evento / Dati evento quando l’input è comando puro

text_input_analysis_loading
→ micro-messaggio “Analisi input…”
→ mostrato vicino all’input principale durante transizione input/readiness
→ non modifica dati

text_edit_mode_notice
→ notice compatta edit mode
→ “Evento in modifica · Premi Annulla modifica per uscire.”
→ visibile solo con edit_mode attivo
→ chiarisce che in edit mode Command Intent non prende controllo del flow

input_command_project_name
→ campo command per completare il nome progetto quando l’utente scrive “crea progetto”

input_command_entity_name
→ campo command per completare il nome entità quando l’utente scrive “crea entità”

btn_command_create_project
→ crea project da command solo previa conferma
→ riusa insert_project

btn_command_create_entity
→ crea entity da command solo previa conferma
→ riusa insert_entity

btn_command_go_events
→ guida alla lista eventi dal command “modifica evento”
→ non modifica record

edit_mode
→ helper tecnico per distinguere create flow / edit flow
→ non usa più additionalScope { value }
→ legge window.__logos_edit_mode_value

editing_event
→ helper tecnico che conserva l’evento NEW in modifica
→ non usa più additionalScope { value }
→ legge window.__logos_editing_event_value

btn_cancel_edit / cancel contestuale
→ in create/input mode torna Home senza insert_event
→ in edit mode annulla modifica evento NEW senza update_event

input_events_search
→ filtro client-side lista eventi NEW

container_app_nav
→ navigation dock contestuale Home / Eventi / Dashboard
→ Hidden aggiornato post UI Readiness usando input_home.value
→ bottom bar flash risolto
→ visibile in Home vuota e Events list
→ nascosta durante input attivo e feedback

feedback_summary
→ oggetto UI temporaneo per riepilogo feedback
→ non persistito nel DB
→ azzerato dopo auto-return feedback

feedback_mode
→ valore UI temporaneo per distinguere feedback evento/progetto/entità
→ non persistito nel DB
→ azzerato dopo auto-return feedback

label / sintesi (preview)
→ derivato UI (non persistito)
→ allineato visualmente a ui_state.parsed per amount/unit/date
→ mostra durata normalizzata in forma umana + hint tecnico
→ mostra/supporta type tramite select1
→ legge project_state/entity_state per hint e highlight matching
→ non è fonte decisionale project/entity

---

FLOW ATTUALE:

input_home
→ sync
→ input_raw
→ trigger_parse_debounced
→ ui_visibility_mode
→ command_intent_state
→ parse_input_controlled
→ ui_state.parsed
→ project_state / entity_state
→ create_suggestion_state
→ preview_analysis_state
→ input_analysis_result
→ Sintesi / Command container / Suggestion container / Dati evento / Input container / Loading / Cancel / Confirm Hidden
→ select_project / select_entity
→ select1 / type classification base
→ eventuale creazione inline project/entity previa conferma utente
→ eventuale creazione project/entity da command previa conferma utente
→ conferma evento manuale se input evento ordinario
→ no-op edit guard se in edit mode
→ feedback_summary costruito prima del reset input/select
→ insert_event / update_event / insert_project / insert_entity se necessario
→ events_new / projects_list / entities_list refresh
→ reset edit_mode / editing_event se necessario
→ feedback temporaneo
→ routing post-save contestuale

Nota UI Readiness:

ui_visibility_mode e ui_visibility_state agiscono solo sulla visibilità UI.

Non modificano:

- amount
- unit
- event_date
- type
- project_id
- entity_id
- raw_input
- payload
- DB

Nota post Visibility Migration Completion:

input_analysis_result governa ora gli Hidden principali del flow input.

Migrati:

- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden

Non migrati intenzionalmente:

- button_input_confirm.Disabled
- button_input_confirm payload
- insert_event / update_event
- container_home.Hidden
- container_feedback.Hidden
- container_events_list.Hidden

Regola:

ui_state.view = routing principale app
input_analysis_result = readiness / visibility flow input
ui_visibility_mode = latch empty / event / command

Routing post-save:

Nuovo evento:
→ insert_event
→ feedback 1800 ms
→ Home

Modifica reale:
→ update_event
→ feedback 1800 ms
→ Lista eventi

Edit senza modifiche:
→ nessun update_event
→ nessun feedback
→ Lista eventi immediata

Command create project:
→ btn_command_create_project
→ input_new_project_name valorizzato
→ insert_project
→ projects_list refresh
→ feedback_mode = project_created
→ feedback 1800 ms
→ Home

Command create entity:
→ btn_command_create_entity
→ input_new_entity_name valorizzato
→ insert_entity
→ entities_list refresh
→ feedback_mode = entity_created
→ feedback 1800 ms
→ Home

Command guida modifica evento:
→ btn_command_go_events
→ reset input command
→ events_new refresh
→ Lista eventi

Nota:

La creazione inline project/entity non sostituisce la conferma evento.

Nota post Input Analysis Result:

input_analysis_result agisce come layer compositivo read-only.

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

Non modifica:

- parser
- matching
- command_intent_state
- create_suggestion_state
- select value/default
- button_input_confirm payload
- insert_event / update_event
- DB

Nota post Visibility Migration Completion:

input_analysis_result non legge più ui_visibility_state.

La precedente dipendenza raw diagnostica è stata rimossa.

Diagnostics consolidati:

- hasUiVisibilityDependency: false
- usesUiVisibilityOnlyAsRawDiagnostic: false
- effectiveReadinessComputedInternally: true
- isConsumptionReadyForUiVisibility: true

Regola anti-loop aggiornata:

ui_visibility_state non è più sorgente di input_analysis_result.
Non introdurre dipendenze inverse o circolari.

Dopo insert_project / insert_entity:

- viene aggiornata la lista projects/entities
- viene valorizzata la select relativa
- l’evento resta non salvato
- l’utente deve ancora confermare manualmente l’evento

---

EDIT FLOW:

evento selezionato
→ window.__logos_editing_event_value = item
→ editing_event
→ window.__logos_edit_mode_value = true
→ edit_mode
→ load raw_input
→ input_home
→ input_raw
→ parse_input_controlled
→ project_state / entity_state
→ ui_state.parsed
→ select_project / select_entity
→ select1 / type classification base
→ preview / hint / highlight
→ modifica utente
→ text_edit_mode_notice visibile

Percorsi possibili:

1. Modifica reale:
→ button_input_confirm
→ feedback_summary
→ update_event
→ events_new refresh
→ reset edit_mode / editing_event
→ feedback temporaneo 1800 ms
→ ritorno Lista eventi

1. Conferma senza modifiche reali:
→ button_input_confirm
→ no-op edit guard
→ nessun update_event
→ nessun feedback
→ reset edit_mode / editing_event
→ ritorno Lista eventi immediata

1. Annulla:
→ btn_cancel_edit / cancel contestuale
→ nessun update_event
→ reset edit_mode / editing_event
→ reset input/select/ui_state.parsed
→ azzera feedback_summary
→ ritorno Lista eventi

1. Cancel create/input:

input in creazione
→ Torna alla home
→ nessun insert_event
→ reset input/select/ui_state.parsed
→ azzera feedback_text / feedback_project / feedback_summary
→ ritorno Home

Nota:

in edit flow vengono rilanciati anche project_state/entity_state.
Questo mantiene coerenti suggerimenti, select, hint e confirm guard anche durante la modifica eventi.

Dopo Linting / State Helper Cleanup,
btn_edit non usa più additionalScope { value } per edit_mode / editing_event.

Usa invece:

- window.__logos_editing_event_value = item
- window.__logos_edit_mode_value = true

Regola post UI Readiness:

Durante edit mode, Command Intent non prende controllo del flow.

Se l’utente svuota l’input e scrive “crea”, resta comunque in modalità modifica.
Il comportamento viene chiarito da:

text_edit_mode_notice

Contenuto:

Evento in modifica · Premi Annulla modifica per uscire.

Per uscire dall’edit flow l’utente deve premere Annulla modifica.

Nota post Input Analysis Result:

input_analysis_result rende esplicita questa regola a livello effective.

In edit mode:

- raw command può essere true
- rawIsCommand può essere true
- rawIsPureCommand può essere true
- isSuppressedByEditMode = true
- effective command = false
- effectiveFlowType = edit
- effective event flow resta prevalente

Caso noto:

edit mode + input “crea”

Comportamento attuale:

- Command Intent non prende controllo del flow
- container_command_intent resta nascosto
- l’utente resta in modifica evento
- eventuali suggestion project/entity possono comparire se create_suggestion_state produce contenuti

Residuo UX:

manca una guidance esplicita tipo:
“Se vuoi creare qualcosa, annulla prima la modifica evento.”

Nodo futuro:

COMMAND INTENT — EDIT MODE GUIDANCE / GENERIC ALIAS

------------------------------------------------
COMMAND INTENT FLOW
------------------------------------------------

Il Command Intent è un primo livello controllato per distinguere:

- input evento ordinario
- comando strutturale puro
- guida non operativa

Componenti principali:

- command_intent_state
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

Output logico command_intent_state:

{
  isCommand,
  isPureCommand,
  commandFamily,
  commandType,
  targetType,
  candidateName,
  existingId,
  needsCompletion,
  canExecute,
  guideMessage,
  rawInput
}

Regole:

- isCommand = true se l’input è un comando riconosciuto
- isPureCommand = true se l’input non deve essere salvato come evento
- commandFamily può essere create / exists / guide
- commandType può essere create_project / create_entity / create_target_missing / project_exists / entity_exists / edit_event_help
- targetType può essere project / entity / event / null
- candidateName contiene il nome candidato estratto
- existingId contiene l’id di project/entity già esistente, se rilevato
- needsCompletion = true se manca il nome
- canExecute = true solo se la creazione è consentita
- guideMessage contiene la guida non operativa
- rawInput conserva l’input sorgente analizzato

------------------------------------------------
COMMAND INTENT — CASI GESTITI
------------------------------------------------

Comando generico:

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

Create project incompleto:

crea progetto

Comportamento:

- mostra campo input_command_project_name
- bottone Crea progetto disabilitato finché il nome è vuoto
- non salva eventi

---

Create project completo:

crea progetto Villa Nuova
aggiungi progetto Villa Nuova
inserisci progetto Villa Nuova
nuovo progetto Villa Nuova

Comportamento:

- mostra riepilogo progetto
- mostra bottone Crea progetto
- crea project solo dopo click utente
- usa insert_project esistente
- non salva eventi

---

Create entity incompleto:

crea entità

Comportamento:

- mostra campo input_command_entity_name
- bottone Crea entità disabilitato finché il nome è vuoto
- non salva eventi

---

Create entity completo:

crea entità Patrizio
aggiungi entità Referente Kappa
inserisci entità Marco Parisi
nuova entità Marco Parisi

Comportamento:

- mostra riepilogo entità
- mostra bottone Crea entità
- crea entity solo dopo click utente
- usa insert_entity esistente
- non salva eventi

---

Elemento già presente:

crea progetto villa

se Villa esiste già.

Comportamento:

- mostra Elemento già presente
- nessun bottone crea
- nessuna duplicazione
- nessun evento salvato
- guida l’utente a usare il dato esistente o un nome più specifico

---

Guida modifica evento:

modifica evento
correggi evento
cambia evento
come modifico evento
devo modificare evento

Comportamento:

- mostra guida con step
- mostra CTA Vai agli eventi
- non modifica record
- non apre edit flow automatico
- non salva eventi

------------------------------------------------
COMMAND INTENT — VINCOLI
------------------------------------------------

Command Intent NON è:

- parser amount/unit/date
- match engine
- create_suggestion_state
- save flow evento
- edit flow automatico
- dashboard command system
- intent engine globale
- form guidato completo

Command Intent NON deve:

- modificare DB schema
- creare project/entity automaticamente
- salvare eventi da comandi puri
- bypassare select_project / select_entity negli eventi ordinari
- aprire modifiche evento automatiche
- anticipare dashboard/KPI

------------------------------------------------
UI READINESS / INPUT ANALYSIS RESULT FLOW
------------------------------------------------

UI Readiness / Visibility Aggregator è stato implementato a primo livello controllato.

Obiettivo:

- distinguere visivamente empty / event / command
- ridurre Hidden duplicate
- stabilizzare container_input
- eliminare il container vuoto durante digitazione
- ridurre rendering progressivo
- risolvere flash bottom bar
- preservare parser / matching / command / suggestion / save flow
- introdurre progressivamente input_analysis_result come lettura UI coerente
- distinguere raw / selection / effective state
- ridurre letture sparse senza sostituire i moduli specializzati

Componenti:

- ui_visibility_mode
- ui_visibility_state residuo tecnico deprecabile
- preview_analysis_state
- input_analysis_result
- text_input_analysis_loading
- text_edit_mode_notice

---

UI_VISIBILITY_MODE

Tipo:

Variable Retool

Valori:

- empty
- event
- command

Aggiornata da:

trigger_parse_debounced

Significato:

empty:
input vuoto / nessun flow input attivo

event:
evento ordinario

command:
command intent / guida command

---

UI_VISIBILITY_STATE

Tipo:

Transformer Retool legacy/residuo.

Ruolo storico:

aggregatore read-only di visibilità UI.

Stato attuale post Visibility Migration Completion:

- non è più letto da input_analysis_result
- non governa più gli Hidden principali migrati
- non è fonte dati salvabile
- non modifica parser
- non modifica matching
- non modifica DB
- non costruisce payload
- è deprecabile ma non eliminato

Motivo della non eliminazione immediata:

- conservare rollback tecnico
- evitare cleanup fuori nodo
- rinviare eliminazione a CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION

Componenti ora governati da input_analysis_result:

- container_command_intent.Hidden
- sintesi.Hidden
- container_association_suggestions.Hidden
- text_event_data_title.Hidden
- select1.Hidden
- select_project.Hidden
- select_entity.Hidden
- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden

Componenti non governati da input_analysis_result perché routing principale app:

- container_home.Hidden
- container_feedback.Hidden
- container_events_list.Hidden

Regola:

ui_state.view = routing principale app
input_analysis_result = readiness / visibility flow input
ui_visibility_mode = latch empty / event / command

Risultati consolidati:

✔ container vuoto durante digitazione risolto
✔ flash input flow ridotto
✔ bottom bar flash risolto
✔ Hidden principali flow input migrati a input_analysis_result
✔ edit mode + input vuoto stabilizzato
✔ Home idle container nascosti durante edit mode
✔ Dati evento / Sintesi / Conferma nascosti con edit input vuoto
✔ Annulla modifica visibile con edit input vuoto
✔ button_input_confirm.Hidden migrato senza toccare Disabled
✔ save flow invariato

------------------------------------------------
INPUT_HOME
------------------------------------------------

Ruolo:

- campo principale di input
- visibile all’utente
- source of truth lato UX

Caratteristiche:

- libero
- senza vincoli formali
- accetta qualsiasi testo

---

Regole:

✔ sempre modificabile  
✔ sempre attivo  
✔ non validato  
✔ non bloccante  

------------------------------------------------
INPUT_RAW
------------------------------------------------

Ruolo:

- adapter tecnico
- base per parsing
- valore sincronizzato da input_home

---

Caratteristiche:

- hidden
- derivato da input_home
- non modificato direttamente dall’utente

---

Sync:

input_home → input_raw

---

Nota:

Il precedente rischio di loop reattivo è stato ridotto tramite:

- trigger_parse_debounced
- parse_input_controlled
- ui_state.parsed come fonte unica

------------------------------------------------
MOBILE SAFARI BASELINE
------------------------------------------------

Durante il test reale su iPhone 13 Safari sono stati rilevati problemi non emersi nella sola preview mobile Retool.

Problemi:

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

- zoom automatico Safari iOS risolto
- layout non più troncato
- select funzionanti sia in digitazione sia in dropdown
- validazione reale su iPhone 13 Safari completata

Regola:

input e select principali su mobile Safari devono mantenere font-size minimo 16px.

Il polish finale può rivedere spaziature e gerarchia visiva,
ma non deve riattivare lo zoom automatico iOS.

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

Regola:

La navigation dock è UI di navigazione.
Non è parte del dato evento.
Non modifica parser, matching, salvataggio o lifecycle DB.

Decisione:

La nav è contestuale e non fixed/sticky,
per evitare sovrapposizioni e instabilità mobile in Retool.

------------------------------------------------
TRIGGER_PARSE_DEBOUNCED
------------------------------------------------

Ruolo:

- evitare parsing per-lettera
- ridurre chiamate inutili
- stabilizzare UX
- mantenere preview reattiva senza loop critici
- aggiornare ui_visibility_mode
- distinguere visivamente empty / event / command
- aggiornare anche il match state project/entity
- evitare update stale tramite window.__logos_visibility_run_id

---

Comportamento:

input_raw aggiornato
→ reset micro-state suggestion inline
→ calcolo rawText
→ aggiornamento ui_visibility_mode
→ salvataggio window.__logos_visibility_run_id
→ attesa debounce
→ controllo runId valido
→ command_intent_state.trigger()
→ parse_input_controlled.trigger()
→ project_state.trigger()
→ entity_state.trigger()
→ create_suggestion_state.trigger()

---

Esempio runtime:

Esempio runtime aggiornato:

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

Risultato:

✔ parsing aggiornato
✔ ui_state.parsed aggiornato
✔ project_state aggiornato
✔ entity_state aggiornato
✔ select_project/select_entity coerenti
✔ preview/hint/confirm guard coerenti
✔ create_suggestion_state aggiornato
✔ suggestion stale resettate al cambio input
✔ micro-editor project/entity chiusi quando cambia input principale
✔ ui_visibility_mode aggiornato
✔ ui_visibility_state può distinguere empty/event/command
✔ container vuoto durante digitazione risolto
✔ flash input flow ridotto
✔ update stale da debounce precedenti ridotti

Nota:

La classificazione locale in trigger_parse_debounced serve solo alla visibilità UI.

La fonte funzionale del Command Intent resta command_intent_state.

Limite noto:

“modifica evento” viene riconosciuto correttamente come command guide.
“modifica” generico non è ancora riconosciuto come guida edit e viene trattato come evento ordinario.

UI_STATE.PARSED

Ruolo:

fonte unica dei dati strutturati parsati
base per preview
base per insert/update
base per edit flow

Struttura:

{
  amount: null,
  unit: null,
  event_date: null
}

ui_state completo:

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

Regole:

✔ parsed deve sempre esistere
✔ parsed non deve tornare null
✔ parsed deve contenere sempre amount/unit/event_date
✔ button_input_confirm usa parsed senza ricalcolare parsing
✔ parsed.unit alimenta select1 per la classificazione Tempo

Relazione con preview:

✔ preview legge ui_state.parsed
✔ preview formatta amount/unit solo visualmente
✔ preview non modifica parsed
✔ preview non modifica il payload di salvataggio
✔ preview non modifica il DB

Esempio:

ui_state.parsed.amount = 1500.5
ui_state.parsed.unit = euro

preview:

1.500,50 €

DB:

amount 1500.5
unit euro

Nota:

ui_state.parsed NON contiene type.

Il type viene gestito da select1.value e salvato nel DB tramite payload.type.

Nota matching:

ui_state.parsed NON contiene project/entity.

Il matching project/entity è gestito da:

input_raw
→ project_state / entity_state

La scelta finale salvabile resta:

select_project.value
select_entity.value

Nota suggestion:

ui_state.parsed NON contiene suggestion project/entity.

Le suggestion sono gestite da:

create_suggestion_state

La creazione project/entity inline aggiorna:

- projects_list / entities_list
- select_project / select_entity

Non modifica:

- ui_state.parsed
- raw_input
- amount / unit / event_date

Nota feedback:

ui_state.feedback_summary NON contiene dati persistenti.

È un oggetto temporaneo usato solo per mostrare il riepilogo nel feedback mobile.

Contenuto atteso:

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
- letto solo dal container_feedback
- non modifica ui_state.parsed
- non modifica payload evento
- non viene salvato in Supabase
- viene azzerato dopo auto-return feedback

Nota feedback_mode:

ui_state.feedback_mode NON contiene dati persistenti.

È un valore temporaneo usato solo dalla UI feedback per distinguere:

- Evento salvato
- Progetto creato
- Entità creata

Valori usati:

- project_created
- entity_created
- null / event_created

Non modifica:

- ui_state.parsed
- payload evento
- Supabase
- lifecycle evento

------------------------------------------------
UI_VISIBILITY_MODE / UI_VISIBILITY_STATE / INPUT_ANALYSIS_RESULT
------------------------------------------------

Questi helper appartengono alla linea UI Readiness / Input Analysis.

Non fanno parte di ui_state.parsed.

Non sono dati salvabili.

---

ui_visibility_mode:

- Variable Retool
- valori:
  - empty
  - event
  - command
- aggiornata da trigger_parse_debounced
- usata da ui_visibility_state
- letta anche da input_analysis_result
- non salva dati
- non sostituisce command_intent_state

---

ui_visibility_state:

- Transformer Retool legacy/residuo
- precedentemente aggregava flag di visibilità
- non è più letto da input_analysis_result
- non governa più gli Hidden principali migrati
- non modifica dati
- non modifica parser
- non modifica matching
- non modifica DB
- non costruisce payload
- è deprecabile ma non eliminato
- resta solo come residuo tecnico / rollback fino a cleanup dedicato

Componenti non più governati da ui_visibility_state:

- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden

Componenti migrati a input_analysis_result:

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

---

preview_analysis_state:

- Transformer Retool read-only
- fonte specializzata preview/hint
- raccoglie:
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

---

input_analysis_result:

- Transformer Retool compositivo read-only
- non legge più ui_visibility_state
- calcola readiness / visibility effettiva propria
- espone raw / selection / effective state
- fonte UI controllata per gli Hidden principali del flow input
- espone canShowConfirm come flag visibility-only
- mantiene canConfirm come readiness funzionale distinta

Relazione con input system:

input_home / input_raw
→ trigger_parse_debounced
→ ui_visibility_mode
→ command_intent_state
→ parse_input_controlled
→ project_state / entity_state
→ create_suggestion_state
→ preview_analysis_state
→ input_analysis_result
→ Hidden principali del flow input

Relazione con futuro Input Analysis Model:

input_analysis_result è il primo layer compositivo concreto,
ma non è ancora Input Analysis Model completo.

Non è:

- Event Interpretation Engine
- motore monolitico
- sostituto del parser
- sostituto del matching
- sostituto delle select
- fonte payload save

Regola anti-loop:

input_analysis_result non legge più ui_visibility_state.
ui_visibility_state non deve leggere input_analysis_result.
Non introdurre dipendenze circolari tra helper visibility/readiness.

------------------------------------------------
HELPER EDIT STATE
------------------------------------------------

Il sistema usa due helper tecnici Retool per il flow edit:

- edit_mode
- editing_event

Questi helper NON sono fonte dati business.

---

EDIT_MODE

Ruolo:

- distingue create flow da edit flow
- abilita btn_cancel_edit
- permette a button_input_confirm di scegliere tra insert_event e update_event

Valori:

- true
- false

Codice runtime:

```js
const key = "__logos_edit_mode_value";

if (!Object.prototype.hasOwnProperty.call(window, key)) {
  return false;
}

const nextValue = window[key];

delete window[key];

return Boolean(nextValue);

EDITING_EVENT

Ruolo:

conserva l’evento NEW attualmente in modifica
permette il confronto no-op con i dati originali
viene azzerato al termine del flow edit

Valori:

item evento NEW
null

Codice runtime:

const key = "__logos_editing_event_value";

if (!Object.prototype.hasOwnProperty.call(window, key)) {
  return null;
}

const nextValue = window[key];

delete window[key];

return nextValue ?? null;

Motivo del pattern:

Prima gli helper usavano:

return value;

con valore passato tramite:

additionalScope: { value: ... }

Il runtime era corretto,
ma Retool segnalava:

edit_mode: 'value' is not defined
editing_event: 'value' is not defined

Il nuovo pattern elimina il linting
senza modificare parser, matching, preview, DB, type o duration.

Regola:

Le chiavi:

window.__logos_edit_mode_value
window.__logos_editing_event_value

sono temporanee.

Devono essere scritte solo dal chiamante immediato
e cancellate dagli helper dopo la lettura.

------------------------------------------------
CANCEL CONTESTUALE — CREATE / EDIT
------------------------------------------------

Componente:

btn_cancel_edit / pulsante cancel contestuale

Label dinamica:

- create/input mode → Torna alla home
- edit mode → Annulla modifica

CREATE / INPUT MODE:

Comportamento:

- cancella eventuale debounce pendente
- cancella eventuale timer feedback pendente
- non esegue insert_event
- resetta input_home
- resetta input_raw
- pulisce select_project
- pulisce select_entity
- pulisce select1
- resetta ui_state.parsed
- azzera feedback_text
- azzera feedback_project
- azzera feedback_summary
- imposta ui_state.view = "home"
- mostra Home
- nasconde Input / Feedback / Events list

Risultato:

- nessun evento creato
- nessuna modifica DB
- Home pulita

EDIT MODE:

Comportamento:

- cancella eventuale debounce pendente
- cancella eventuale timer feedback pendente
- scrive window.__logos_edit_mode_value = false
- rilancia edit_mode
- scrive window.__logos_editing_event_value = null
- rilancia editing_event
- non esegue update_event
- resetta input_home
- resetta input_raw
- pulisce select_project
- pulisce select_entity
- pulisce select1
- resetta ui_state.parsed
- azzera feedback_text
- azzera feedback_project
- azzera feedback_summary
- imposta ui_state.view = "events"
- mostra Lista eventi

Risultato:

- nessun update_event
- updated_at invariato
- ritorno Lista eventi

Notice edit mode:

Durante edit mode viene mostrato:

text_edit_mode_notice

Contenuto:

Evento in modifica · Premi Annulla modifica per uscire.

Scopo:

- chiarire che il sistema è ancora in modifica evento
- evitare confusione se l’utente cancella l’input e scrive “crea”
- preservare il comportamento corretto: edit mode prevale su Command Intent

PARSING SYSTEM

FUNZIONE:

estrarre informazioni strutturate dall’input.

TIPO:

best-effort deterministico

OUTPUT:

amount
unit
event_date

⚠ label NON è output del parsing

REGOLE:

✔ parsing non blocca
✔ parsing può fallire
✔ parsing può essere parziale
✔ parsing non interpreta semanticamente l’evento
✔ parsing non classifica direttamente spesa/incasso
✔ parsing fornisce però unit utili alla type classification base
✔ parsing non modifica raw_input

CASI:

✔ parsing corretto
✔ parsing incompleto
✔ parsing errato

Tutti validi.

L’utente mantiene il controllo finale.

PARSING + NORMALIZATION BASE

Il parser attuale non si limita più a estrarre dati,
ma applica anche una normalizzazione base controllata.

Questa normalizzazione riguarda:

amount
unit
event_date preservato
durate certe ore/minuti normalizzate in minuti

La Duration Normalization Base è parte del parsing controllato.

Regola:

tutte le durate certe espresse in ore/minuti vengono convertite in minuti.

Esempio:

1 ora e 15 minuti
→ amount 75
→ unit minuti

2h30
→ amount 150
→ unit minuti

raw_input resta sempre preservato.

Non riguarda direttamente:

label
project
entity
spesa/incasso
matching project/entity
hint
dashboard
KPI

Nota:

type classification base usa ui_state.parsed.unit come segnale,
ma resta gestita da select1, non dal parser.

Nota:

il matching project/entity è ora stabilizzato a primo livello tramite project_state/entity_state,
ma resta separato dal parser.

Il parser non decide project/entity.

Obiettivo:

rendere coerenti i dati strutturati minimi
prima di insert/update.

PARSING UNITÀ

Unità supportate:

euro
minuti
ore

RICONOSCIMENTO UNITÀ

EURO:

€
euro
eur
€20
20€
€ 20
20 euro
20 eur

TEMPO — ORE:

ora
ore
h
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

TEMPO — MINUTI:

min
minuto
minuti
30 min
30min
30 minuti
30minuti
min30

OUTPUT NORMALIZZATO UNIT:

€, euro, eur → euro

h, ora, ore, min, minuto, minuti → minuti

Regola durata:

le unità tempo riconosciute vengono convertite in unità canonica "minuti".

Esempi:

1 ora → amount 60, unit minuti
2 ore → amount 120, unit minuti
1,5 ore → amount 90, unit minuti
18 minuti → amount 18, unit minuti
2h30 → amount 150, unit minuti

NORMALIZZAZIONE INPUT RUNTIME

Applicata solo nel layer parsing.

Operazioni:

lowercase
trim
compressione spazi
riconoscimento simboli (€)
riconoscimento unit compatte
pulizia spazi
estrazione amount per prossimità alla unità

ESEMPI:

2h → amount 120, unit minuti
1ora → amount 60, unit minuti
18min → amount 18, unit minuti
1,5 ore → amount 90, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
2h30 → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti
€20 → amount 20, unit euro
1.500,50 euro → amount 1500.5, unit euro

IMPORTANTE:

✔ non modifica input utente
✔ non modifica raw_input
✔ usata solo per parsing interno
✔ produce dati strutturati per ui_state.parsed

GESTIONE ORARI

Formati:

HH:MM

COMPORTAMENTO:

✔ NON considerati amount
✔ NON considerati unit
✔ mantenuti come testo

ESEMPIO:

15:30 test
→ amount null
→ unit null
→ raw_input preservato

ESTRAZIONE AMOUNT

Regola:

estrarre il numero più rilevante rispetto alla unità rilevata.

STRATEGIA:

identificazione dei numeri presenti
identificazione della posizione della unità
selezione del numero con distanza minima dalla unità
conversione tramite normalizeNumberValue
se non esiste unità, amount = null

ESEMPI:

pizza 20 euro → 20 / euro
2 ore lavoro → 120 / minuti
2 ore 30 → 150 / minuti
1 ora e 15 minuti → 75 / minuti
2h30 rendering → 150 / minuti
villa 2 mario → null / null
villa 2 mario rossi 3h → 180 / minuti

FORMATI SUPPORTATI:

interi
decimali con virgola
decimali con punto
migliaia italiane con punto
migliaia italiane + decimali con virgola

ESEMPI AMOUNT NORMALIZATION:

458,78 → 458.78
1,5 → 1.5
1.5 → 1.5
1.500 → 1500
1.500,50 → 1500.5
1500 → 1500

REGOLA CRITICA:

I numeri senza unità NON vengono interpretati come amount.

Esempi:

villa 2 → amount null
cliente 2026 → amount null
casa mare 2 → amount null

Motivo:

preservare numeri semantici
evitare dati quantitativi errati
ridurre errori permanenti in DB

NORMALIZE_NUMBER_VALUE

Funzione runtime utilizzata dal parser:

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

------------------------------------------------
DURATION NORMALIZATION BASE
------------------------------------------------

La Duration Normalization Base è stata implementata nel parser controllato.

Decisione:

- amount tempo = totale minuti
- unit tempo = minuti
- raw_input preservato
- nessuna modifica schema DB
- nessun payload duration
- nessun campo duration_minutes dedicato

------------------------------------------------
UNITÀ CANONICA TEMPO
------------------------------------------------

Unità canonica:

minuti

Motivo:

- rende i dati confrontabili
- evita mix tra ore e minuti
- facilita dashboard/report futuri
- permette somma diretta delle durate
- mantiene raw_input come fonte originaria

------------------------------------------------
CASI SUPPORTATI
------------------------------------------------

Minuti semplici:

18 minuti → amount 18, unit minuti
18min → amount 18, unit minuti
min30 → amount 30, unit minuti
90 minuti → amount 90, unit minuti

Ore semplici:

1 ora → amount 60, unit minuti
1ora → amount 60, unit minuti
2 ore → amount 120, unit minuti
2h → amount 120, unit minuti
h2 → amount 120, unit minuti

Ore decimali:

1,5 ore → amount 90, unit minuti
1.5 ore → amount 90, unit minuti
1,5h → amount 90, unit minuti
1.5h → amount 90, unit minuti

Durate composte:

1 ora e 15 minuti → amount 75, unit minuti
1 ora 15 minuti → amount 75, unit minuti
2 ore e 30 minuti → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti
2h30 → amount 150, unit minuti
2 h 30 → amount 150, unit minuti

------------------------------------------------
CASI NON CONVERTITI AUTOMATICAMENTE
------------------------------------------------

Non vengono convertiti automaticamente:

- giorni
- settimane
- giornata
- giornate
- mezza giornata
- parole numeriche tipo “due ore”
- forme colloquiali tipo “un paio d’ore”
- 2h e mezza

Motivo:

questi casi introducono ambiguità operativa.

Esempio:

2 giorni

può significare:

- 48 ore
- due giornate lavorative
- due giornate evento
- due giorni di calendario
- due turni operativi

Decisione:

2 giorni rendering
→ amount null
→ unit null
→ raw_input preservato
→ preview mostra hint durata ambigua

SUCCESS HANDLER PARSER

parse_input_controlled aggiorna ui_state.parsed tramite success handler.

Codice finale:

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

✔ parsed sempre strutturato
✔ nessun undefined
✔ nessun parsed null
✔ save/edit leggono dati coerenti

DATE PARSING

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
intervalli date

LABEL / SINTESI (RUNTIME)

FUNZIONE:

generare una descrizione leggibile per la preview.

TIPO:

✔ derivato runtime
✔ non persistito
✔ non strutturato
✔ visuale

INPUT:

raw_input
ui_state.parsed.amount
ui_state.parsed.unit
ui_state.parsed.event_date

COMPORTAMENTO:

rimozione amount + unit già rappresentati dal value
rimozione date già parse
normalizzazione spazi
preservazione numeri semantici
gestione compound token
formattazione visuale amount/unit
visualizzazione umana della durata normalizzata
hint valore normalizzato
hint durata ambigua per giorni/settimane

AGGIORNAMENTO PREVIEW ALIGNMENT BASE:

✔ formattazione italiana amount implementata nella sintesi
✔ euro mostrato con due decimali
✔ grouping migliaia visuale
✔ ore/minuti visualizzati coerentemente
✔ singolare/plurale unit gestito
✔ label cleaning aggiornato
✔ bug "minuti" → "uti" risolto
✔ data separata correttamente dalla descrizione
✔ highlight locale reso unit-safe

AGGIORNAMENTO DURATION NORMALIZATION BASE:

✔ durata interna salvata in minuti
✔ preview durata mostrata in forma umana
✔ hint “Normalizzato: X minuti”
✔ hint durata ambigua per giorni/settimane
✔ rimozione dalla label della durata originale già normalizzata
✔ rimozione residui congiunzione “e/ed”

ESEMPI:

1.500,50 euro materiale
→ 1.500,50 € • materiale

1500 euro materiale
→ 1.500,00 € • materiale

18min test
→ 18 minuti • test

1ora lavoro
→ 1 ora
→ Normalizzato: 60 minuti

2 ore sopralluogo villa 2
→ 2 ore • sopralluogo villa 2
→ Normalizzato: 120 minuti

1 ora e 15 minuti sopralluogo
→ 1 ora 15 minuti • sopralluogo
→ Normalizzato: 75 minuti

2h30 rendering
→ 2 ore 30 minuti • rendering
→ Normalizzato: 150 minuti

2 giorni rendering
→ 2 giorni rendering
→ Durata ambigua: specifica ore/minuti per salvarla come tempo analizzabile

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

villa 2 mario
→ villa 2 mario

IMPORTANTE:

✔ NON esiste ancora un label system separato
✔ logica applicata direttamente nella preview
✔ NON riutilizzabile come modulo indipendente
✔ NON influisce su parsing
✔ NON modifica ui_state.parsed
✔ NON salvata nel DB

⚠ logica accoppiata alla preview
⚠ non isolata come layer indipendente
⚠ preview non ancora view pura
⚠ “Da verificare” resta interno alla Sintesi e non è blocco autonomo
⚠ hint bloccanti / warning informativi / suggestion visuali non sono ancora separati in container indipendenti

Nota post Preview Analysis State / Input Analysis Result:

La logica hint/status principale della Sintesi è ora raccolta in:

preview_analysis_state

La visibilità della Sintesi è ora governata da:

input_analysis_result.readiness.canShowEventPreview

La Sintesi viene nascosta durante command intent puro,
mentre container_command_intent viene mostrato tramite:

input_analysis_result.readiness.canShowCommandContainer

Il contenuto interno della Sintesi non è stato trasformato in view pura.
La Sintesi resta un layer ibrido perché conserva ancora:

- rendering HTML
- label cleaning
- highlight
- layout visuale
- micro-copy finale

Nota:

input_analysis_result non ricalcola gli hint.
Li legge da preview_analysis_state.

Nota post Visibility Migration Completion:

Durante i test è stato osservato un residuo semantico non bloccante:

2h30 rendering lavoro
→ durata riconosciuta correttamente
→ type Tempo corretto
→ amount 150 / unit minuti corretti
→ Dati evento mostrano però ancora label “Importo” per il valore durata

Questo non è un problema di parser, normalization o save flow.
È un problema di label visuale.

Nodo futuro candidato:

PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT

Possibile regola futura:

- euro → Importo
- minuti / ore → Durata
- nessuna unità → riga assente o label neutra

AGGIORNAMENTO MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL:

✔ hint ambiguità project/entity alimentati da project_state/entity_state
✔ highlight project/entity alimentato da matches
✔ detection locale preview non più fonte decisionale matching
✔ hint match più specifici introdotto
✔ bug €500 nella label preview risolto
✔ preview resta visuale e non salva dati

Esempi:

villa 2 mario
→ villa 2 evidenziato come project
→ mario evidenziato come entity

mario
→ select_entity = Mario
→ hint: Esistono entità più specifiche

villa
→ select_project = Villa
→ hint: Esistono progetti più specifici

€500 acconto alfie mario rossi
→ 500,00 € • acconto alfie mario rossi

------------------------------------------------
TYPE CLASSIFICATION BASE
------------------------------------------------

La Type Classification Base è stata implementata.

Componente principale:

select1

Ruolo:

classificare l’evento in modo minimo, prudente e correggibile dall’utente.

Valori reali disponibili in select1:

- Evento
- Tempo
- Spesa
- Incasso

------------------------------------------------
REGOLE ATTUALI
------------------------------------------------

TEMPO:

parsed.unit = "minuti"
→ select1 = Tempo

Motivo:

dopo Duration Normalization,
tutte le durate certe ore/minuti vengono salvate come:

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

------------------------------------------------
SPESA
------------------------------------------------

Regola:

euro + keyword controllate di uscita
→ select1 = Spesa

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

20 euro saldo pagato
→ select1 = Spesa

------------------------------------------------
INCASSO
------------------------------------------------

Regola:

euro + keyword controllate di entrata
→ select1 = Incasso

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

------------------------------------------------
EVENTO / FALLBACK PRUDENTE
------------------------------------------------

Regola:

euro senza direzione chiara
→ select1 = Evento

segnali economici contrastanti
→ select1 = Evento

nessuna unit significativa
→ select1 = Evento

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
PRINCIPIO DI CONTROLLO UTENTE
------------------------------------------------

La classificazione automatica è solo base.

L’utente può sempre modificare manualmente select1.

La scelta manuale prevale sul default automatico
e viene salvata in events.type.

Esempi validati:

20 euro materiale
→ default Evento
→ utente seleziona Spesa
→ DB: type = Spesa

20 euro materiale
→ default Evento
→ utente seleziona Incasso
→ DB: type = Incasso

------------------------------------------------
PERSISTENZA TYPE
------------------------------------------------

Catena runtime:

select1.value
→ payload.type
→ insert_event / update_event
→ events.type

Il type viene salvato in DB.

Insert:

- salva type

Update:

- aggiorna type

Esempio:

2h30 rendering
→ select1 = Tempo
→ DB: type Tempo, amount 150, unit minuti

20 euro spesa materiale
→ select1 = Spesa
→ DB: type Spesa, amount 20, unit euro

20 euro incasso cliente
→ select1 = Incasso
→ DB: type Incasso, amount 20, unit euro

------------------------------------------------
CODICE LOGICO select1 — DEFAULT VALUE
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
LIMITI TYPE
------------------------------------------------

Non implementato:

- classificazione economica avanzata
- dizionario esteso keyword
- classificazione automatica da parole di dominio
- benzina → Spesa automatica
- materiale → Spesa automatica
- mangime → Spesa automatica
- amount firmato
- direction field
- KPI/reportistica
- retro-normalizzazione eventi storici

PREVIEW SYSTEM

FUNZIONE:

mostrare interpretazione sistema.

STRUTTURA:

MAIN:

event_date + amount + unit + label

META:

project
entity

HINT:

suggerimenti matching
suggerimenti tipo
hint durata ambigua

REGOLE:

✔ preview non blocca
✔ preview può essere parzialmente errata
✔ preview non modifica input
✔ preview non modifica DB
✔ preview legge dati parsati/normalizzati
✔ preview visualizza amount/unit/date in formato leggibile
✔ preview resta visuale

Preview = rendering di:

parsed (amount, unit, event_date)
select1.value / type
label runtime
stato matching project/entity
hint

Visibilità preview:

input_analysis_result.readiness.canShowEventPreview

Fonte hint/status:

preview_analysis_state

Fonte compositiva UI/readiness:

input_analysis_result

Regola:

La preview viene mostrata solo nel flow evento.
Non viene mostrata nel flow command.

AGGIORNAMENTO PREVIEW ALIGNMENT BASE:

✔ amount formattato in stile italiano
✔ euro visualizzato con simbolo €
✔ euro visualizzato con due decimali
✔ migliaia visualizzate correttamente
✔ ore/minuti visualizzati coerentemente
✔ singolare/plurale unit gestito
✔ label cleaning coerente con amount/unit già rappresentati
✔ date separate correttamente dalla descrizione
✔ highlight locale non interferisce più con unità tecniche

Esempio:

Dato interno:

amount: 1500.5
unit: euro

Preview:

1.500,50 €

DB:

amount: 1500.5
unit: euro

REGOLA CRITICA:

La formattazione italiana è solo visuale.

Non modifica:

- parse_input_controlled
- ui_state.parsed
- button_input_confirm
- insert_event
- update_event
- DB

✔ hint matching project/entity alimentati da project_state/entity_state
✔ highlight project/entity alimentato da matches
✔ detection locale preview non più fonte decisionale matching
✔ bug €500 label preview risolto

⚠ presenza logica interna
⚠ non pura view
⚠ dipendenza da più fonti
⚠ hint duration/type ancora embedded nella preview
⚠ preview non ancora view pura

Nota post Command Intent:

Durante il nodo Command Intent è stato confermato che “Da verificare” è ancora parte della Sintesi e non può essere spostato sotto la CTA senza intervenire sul modello preview.

Questo rafforza il possibile nodo futuro:

PREVIEW MODEL / HINT STATE CONSOLIDATION

Preview Alignment Base:

✔ COMPLETATO

AGGIORNAMENTO DURATION NORMALIZATION BASE:

✔ preview durata in forma umana
✔ valore tecnico normalizzato mostrato come hint
✔ giorni/settimane segnalati come durata ambigua
✔ label cleaning aggiornato per rimuovere durate composte già normalizzate

Esempio:

Dato interno:

amount: 150
unit: minuti

raw_input:

2h30 rendering

Preview:

2 ore 30 minuti • rendering
Normalizzato: 150 minuti

DB:

amount: 150
unit: minuti

AGGIORNAMENTO TYPE CLASSIFICATION BASE:

✔ select1 allineato a ui_state.parsed.unit
✔ parsed.unit = minuti → Tempo
✔ euro + keyword controllate → Spesa / Incasso
✔ euro senza direzione chiara → Evento
✔ scelta manuale utente preservata
✔ type persistito nel DB tramite confirm

Esempio:

2h30 rendering
→ preview durata: 2 ore 30 minuti
→ select1: Tempo
→ DB: type Tempo, amount 150, unit minuti

AGGIORNAMENTO MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL:

✔ preview legge project_state/entity_state per matching
✔ hint “Più entità trovate” deriva da entity_state.isAmbiguous
✔ hint “Più progetti trovati” deriva da project_state.isAmbiguous
✔ hint rossi spariscono se l’utente risolve manualmente l’ambiguità
✔ highlight legge matches
✔ hint match più specifici introdotti
✔ preview non decide project/entity

MATCHING BASE — FIRST CONTROLLED LEVEL

Oggetti:

projects
entities

Fonte minima matching:

project_state
entity_state

Input:

input_raw
projects_list.data
entities_list.data

Output standard:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

STRATEGIA:

- normalizzazione base testo
- confronto parole significative
- full name match
- priority match minimo
- rimozione match generici coperti da match specifici
- auto-select solo tramite singleMatch
- hint match più specifici non bloccante

---

PROJECT MATCH:

Esempi:

villa → Villa + hint progetti più specifici
villa 2 → Villa 2
casa mare → Casa Mare
ristrutturazione bagno → Ristrutturazione Bagno

---

ENTITY MATCH:

Esempi:

mario → Mario + hint entità più specifiche
mario rossi → Mario Rossi + hint entità più specifiche
mario rossi alfredo → Mario Rossi Alfredo
alfie mario rossi → ambiguità reale

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

REGOLE:

✔ mai forzare selezione ambigua
✔ mai creare automaticamente project/entity dal matching
✔ eventuale creazione project/entity passa da create_suggestion_state e conferma utente
✔ utente in controllo
✔ select_project.value è fonte salvabile per project_id
✔ select_entity.value è fonte salvabile per entity_id

---

RISOLTO A PRIMO LIVELLO:

✔ logiche select non ricalcolano matching
✔ preview non usa detection locale come fonte decisionale
✔ hint ambiguità da isAmbiguous
✔ confirm guard da ambiguità non risolta
✔ match state live in create flow
✔ match state live in edit flow
✔ priority match minimo implementato

---

NON IMPLEMENTATO:

- fuzzy matching
- alias system
- entity hierarchy
- project hierarchy
- deduplicazione
- input analysis model unico
- ui_visibility_state non sostituisce matching
- command intent avanzato oltre create project/entity
- filtro select su match ambigui
- ranking avanzato
- match engine separato come modulo autonomo

------------------------------------------------
PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
------------------------------------------------

La creazione guidata project/entity è stata implementata a primo livello controllato.

Ruolo:

aiutare l’utente a completare project/entity quando l’input libero
non produce un match sufficiente oppure contiene una estensione specifica
non ancora presente.

Componenti principali:

- create_suggestion_state
- container suggestion inline
- input_new_project_name
- input_new_entity_name
- btn_open_project_create
- btn_open_entity_create
- btn_create_project_inline
- btn_create_entity_inline
- bottone Ignora globale
- bottoni Annulla contestuali

Query:

- insert_project
- insert_entity

Regole:

- nessuna creazione automatica silenziosa
- creazione solo previa conferma utente
- evento non salvato automaticamente dopo creazione project/entity
- project/entity mancanti non bloccano salvataggio
- project/entity ambigui bloccano salvataggio
- suggestion ignorata non blocca salvataggio
- una sola creazione guidata aperta alla volta
- select_project / select_entity restano decisione utente finale

---

PROJECT CREATE

Caso tipico:

villa sierri 15 sopralluogo

Comportamento:

- project_state riconosce Villa come match base
- create_suggestion_state propone Villa Sierri 15 come possibile nuovo project
- input_new_project_name viene precompilato
- utente conferma Crea progetto
- insert_project crea il record
- projects_list viene aggiornata
- select_project viene valorizzata
- evento resta da confermare manualmente

---

ENTITY CREATE

Caso tipico:

villa sierri 15 sopralluogo referente kappa

Comportamento:

- entity_state non trova match
- create_suggestion_state propone creazione entity
- input_new_entity_name può essere precompilato se candidate sicura
- utente conferma Crea entità
- insert_entity crea il record
- entities_list viene aggiornata
- select_entity viene valorizzata
- evento resta da confermare manualmente

---

ENTITY AUTOFILL CONTROLLED MINIMAL

Autofill entity disponibile solo in casi controllati.

Non è:

- parsing
- matching entity
- salvataggio
- creazione automatica

È solo precompilazione del campo input_new_entity_name.

Condizioni:

- entity no-match reale
- entity non ambigua
- nessuna entity già selezionata
- testo residuo pulito
- presenza di prefisso entity forte

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

---

IGNORA GLOBALE

Il bottone Ignora globale:

- nasconde suggestion project/entity
- chiude micro-editor aperti
- svuota input_new_project_name / input_new_entity_name
- non modifica input_raw
- non modifica select_project / select_entity
- non blocca conferma

Esempio validato:

acquisto 50 euro materiale nuovo
→ Ignora
→ evento salvabile con project_id null / entity_id null

---

AMBITO NON COPERTO

Non implementa:

- command intent avanzato oltre create project/entity
- input analysis model unico
- modifica project/entity da command
- dashboard/report intent da command
- gerarchie project/entity
- alias
- deduplicazione avanzata
- filtro select su match ambigui
- Cambia / Scegli nella Sintesi realmente cliccabili
- Azioni rapide operative
- Dashboard reale
- suggestion create vs edit consistency
- project creation override con match generico
- Icon System completamente standardizzato
- polish finale font/spaziature

Nota UX Mobile Coherence Pass:

La Dashboard è presente nella navigation dock solo come voce futura disabilitata.
Le Azioni rapide sono presenti solo come predisposizione UX.
Nessuna delle due abilita output, KPI o logiche guidate avanzate.

------------------------------------------------
COMMAND INTENT — CREATE PROJECT / ENTITY
------------------------------------------------

Il Command Intent è stato implementato a primo livello controllato.

Ruolo:

distinguere input evento ordinario da comando strutturale puro.

Componenti principali:

- command_intent_state
- container_command_intent
- input_command_project_name
- input_command_entity_name
- btn_command_create_project
- btn_command_create_entity
- btn_command_go_events

Regole:

- nessun evento salvato da comando puro
- nessuna creazione automatica silenziosa
- project/entity creati solo previa conferma utente
- insert_project / insert_entity restano le query operative
- command_intent_state non modifica parser
- command_intent_state non modifica matching
- command_intent_state non modifica DB
- command_intent_state non sostituisce create_suggestion_state
- “modifica evento” è guida non operativa

Nota post UI Readiness:

ui_visibility_mode può anticipare visivamente il flow command,
ma command_intent_state resta la fonte funzionale del comando.

Dopo Input Analysis Result Controlled UI Consumption,
input_analysis_result governa la visibilità di:

- container_command_intent
- sintesi
- Dati evento

button_input_confirm resta fuori dalla migrazione corrente.

I comandi puri restano esclusi dal salvataggio evento.

Flussi:

crea
→ guida con esempi
→ nessun salvataggio

crea progetto
→ input_command_project_name
→ Crea progetto disabilitato finché manca il nome

crea progetto [nome]
→ riepilogo progetto
→ btn_command_create_project
→ insert_project
→ feedback project_created
→ Home

crea entità
→ input_command_entity_name
→ Crea entità disabilitato finché manca il nome

crea entità [nome]
→ riepilogo entità
→ btn_command_create_entity
→ insert_entity
→ feedback entity_created
→ Home

crea progetto villa
→ elemento già presente
→ nessun bottone crea
→ nessuna duplicazione

modifica evento
→ guida con step
→ btn_command_go_events
→ Lista eventi

Limiti:

- non è un intent engine globale
- non gestisce dashboard/report
- non gestisce modifica project/entity
- non apre edit flow evento automatico
- non unifica tutte le fonti di interpretazione
- “modifica” generico non ancora riconosciuto come guida edit

------------------------------------------------
DATI EVENTO — UX MOBILE COHERENCE PASS
------------------------------------------------

Durante UX Mobile Coherence Pass, la sezione Dati evento è stata compattata.

Prima:

- label sopra ogni select
- maggiore altezza verticale

Dopo:

- label inline / affiancate alle select
- layout più compatto
- maggiore leggibilità mobile

Campi:

- Tipo evento
- Progetto
- Entità

Regola:

Dati evento resta la zona di decisione finale utente.

La Sintesi rappresenta ciò che LOGOS ha interpretato.
Dati evento contiene le fonti salvabili:

- select1.value
- select_project.value
- select_entity.value

Le select non vengono spostate nella Sintesi.

Visibilità post Input Analysis Result Visibility Migration Completion:

La sezione Dati evento è governata da:

input_analysis_result.readiness.canShowEventData

Gli Hidden principali collegati al flow input leggono ora input_analysis_result.

Regola:

- visibile nel flow evento
- visibile nel flow edit con input valorizzato
- nascosta nel flow command
- nascosta quando edit mode ha input vuoto
- nascosta quando input flow non è pronto

CONFERMA EVENTO

AZIONE:

utente conferma inserimento o modifica.

SEQUENZA ATTUALE:

SEQUENZA ATTUALE AGGIORNATA:

lettura ui_state.parsed
costruzione payload
determinazione wasEditMode
no-op edit guard se in edit mode
costruzione feedbackText / feedbackProject / feedbackEntity
costruzione feedbackSummary prima del reset input/select
reset input/select
ui_state.view = feedback
container_feedback visibile
insert_event / update_event
await savePromise
await events_new.trigger()
reset edit_mode / editing_event se necessario tramite window helper
timer feedback 1800 ms
routing post-save contestuale

ROUTING POST-SAVE CONSOLIDATO:

Nuovo evento:

- insert_event
- feedback 1800 ms
- ritorno Home

Modifica reale:

- update_event
- feedback 1800 ms
- ritorno Lista eventi

Edit senza modifiche:

- nessun update_event
- nessun feedback
- ritorno immediato Lista eventi
- updated_at invariato

REGOLE:

✔ conferma consentita se:

- input non vuoto
- nessun match project/entity
- match univoco project/entity
- ambiguità project/entity risolta manualmente

✔ conferma bloccata se:

- project_state.isAmbiguous = true e select_project vuoto
- entity_state.isAmbiguous = true e select_entity vuoto

✔ input comunque sempre modificabile
✔ scelta manuale utente preservata
✔ evento salvabile anche dopo creazione inline project/entity
✔ evento salvabile anche senza project/entity
✔ suggestion ignorata non blocca salvataggio
✔ comando puro riconosciuto da command_intent_state non deve arrivare al save flow evento
✔ container_command_intent sostituisce Sintesi/Dati evento per command puri
✔ button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm
⚠ button_input_confirm.Disabled non è ancora migrato a input_analysis_result
⚠ button_input_confirm payload resta invariato e fuori dalla migrazione

Nota:

button_input_confirm resta un punto delicato perché unisce:

- visibilità bottone
- disabled state
- input vuoto
- ambiguità project/entity
- edit mode
- save readiness
- payload insert/update
- no-op edit guard

Dopo Visibility Migration Completion, la visibilità del bottone è stata separata:

- canShowConfirm = mostra/nasconde il bottone
- canConfirm = readiness funzionale
- Disabled = guard funzionale autonoma ancora nel componente

Nodo futuro dedicato:

BUTTON CONFIRM READINESS ALIGNMENT

✔ gestione edit_mode:

true → update_event
false → insert_event

✔ gestione no-op edit:

→ updated_at NON cambia
→ feedback NON viene mostrato
→ edit_mode viene chiuso
se edit_mode = true
e raw_input / type / project_id / entity_id non cambiano:

→ update_event NON viene eseguito
→ editing_event viene azzerato
→ feedback_summary viene azzerato
→ ritorno immediato Lista eventi

Regola anti-conflitto post-save:

handle_event_success è stato eliminato come query legacy unused dopo Linting / Retool Query Safety Pass.

Feedback e cambio view post-save restano centralizzati in button_input_confirm.

insert_event / update_event non devono avere success handler UI duplicati che modificano:

- ui_state.view
- container_home
- container_feedback
- container_events_list
- container_input

La gestione UI post-save è centralizzata in button_input_confirm.

Il bottone NON ricalcola più parsing.

Fonte dati strutturata:

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

Nota:

button_input_confirm non legge create_suggestion_state come fonte dati salvabile.
button_input_confirm non legge command_intent_state come fonte dati salvabile.

command_intent_state serve solo a distinguere e guidare il flow command.
I comandi puri devono essere intercettati prima del salvataggio evento.
La separazione visiva viene gestita ora da ui_visibility_mode + input_analysis_result per gli Hidden principali del flow input.
ui_visibility_state resta solo residuo tecnico deprecabile.
La separazione funzionale viene gestita da command_intent_state.

create_suggestion_state può aiutare a creare project/entity,
ma il payload evento legge sempre e solo:

- select_project.value
- select_entity.value

Disabled logic:

button_input_confirm non ricalcola matching.

Legge:

- project_state.data.isAmbiguous
- entity_state.data.isAmbiguous
- select_project.value
- select_entity.value

Regola:

ambiguità non risolta → blocco
ambiguità risolta manualmente → conferma consentita

BUTTON_INPUT_CONFIRM — FLOW FINALE

Codice logico finale:

```js
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
// Se siamo in edit mode ma il payload non cambia nulla,
// non eseguiamo update_event e non aggiorniamo updated_at.

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
    feedback_text: null,
    feedback_project: null
  });

  container_input.setHidden(true);
  container_home.setHidden(true);
  container_feedback.setHidden(true);
  container_events_list.setHidden(false);

  return;
}

const feedbackText = input_raw.value;
const feedbackProject = select_project.selectedItem?.name;

ui_state.setValue({
  ...ui_state.value,
  parsed: {
    amount: null,
    unit: null,
    event_date: null
  },
  status: "idle",
  view: "feedback",
  feedback_text: feedbackText,
  feedback_project: feedbackProject
});

input_home.setValue("");
input_raw.setValue("");

select_project.clearValue();
select_entity.clearValue();

trigger_parse_debounced.cancel?.();

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

Aggiornamento UX Mobile Coherence Pass:

Il codice runtime effettivo di button_input_confirm è stato aggiornato per:

- creare feedbackSummary prima del reset input/select
- mostrare il feedback come ultimo stato UI visibile
- centralizzare feedback e routing post-save
- evitare conflitti con handle_event_success
- gestire insert reale → feedback → Home
- gestire update reale → feedback → Lista eventi
- gestire no-op edit → Lista eventi senza feedback
- azzerare feedback_summary dopo auto-return

Regola:

Questo blocco è fonte runtime del salvataggio evento.
Il feedback_summary è solo UI temporanea e non viene salvato nel DB.

Risultato:

✔ parsing duplicato rimosso
✔ insert/update usano ui_state.parsed
✔ insert/update salvano type da select1.value
✔ feedback immediato
✔ lista eventi aggiornata dopo save reale
✔ update visibile senza refresh pagina
✔ no-op edit guard attivo
✔ edit senza modifiche reali non esegue update_event
✔ updated_at non cambia su edit no-op
✔ edit_mode reset senza additionalScope { value }
✔ editing_event reset senza additionalScope { value }
✔ editing_event azzerato anche dopo update reale completato
✔ linting edit_mode / editing_event risolti

Nota Match Engine:

Il bottone conferma continua a costruire il payload da fonti controllate:

- amount / unit / event_date → ui_state.parsed
- type → select1.value
- project_id → select_project.value
- entity_id → select_entity.value

Non ricalcola parsing.
Non ricalcola matching.
Non legge la preview come fonte dati.

------------------------------------------------
FEEDBACK SYSTEM — UX MOBILE COHERENCE PASS
------------------------------------------------

Il feedback post-salvataggio è stato stabilizzato.

Struttura:

- container_feedback
- feedback_mode
- feedback_text
- feedback_project
- feedback_summary

feedback_summary contiene:

- type
- date
- amount
- project
- entity
- text

Regole:

- creato prima del reset input/select
- visibile solo nel feedback mobile
- non salvato nel DB
- non modifica payload
- azzerato dopo auto-return

Comportamento:

INSERT reale:

button_input_confirm
→ feedback_summary
→ insert_event
→ events_new refresh
→ feedback 1800 ms
→ Home

UPDATE reale:

button_input_confirm
→ feedback_summary
→ update_event
→ events_new refresh
→ feedback 1800 ms
→ Lista eventi

NO-OP EDIT:

button_input_confirm
→ no-op edit guard
→ nessun update_event
→ nessun feedback
→ Lista eventi immediata

Decisione:

Il feedback è una toast-card temporanea,
non una pagina finale bloccante.

COMMAND CREATE PROJECT:

btn_command_create_project
→ insert_project
→ projects_list refresh
→ feedback_mode = project_created
→ feedback_summary strutturale progetto
→ feedback 1800 ms
→ Home

COMMAND CREATE ENTITY:

btn_command_create_entity
→ insert_entity
→ entities_list refresh
→ feedback_mode = entity_created
→ feedback_summary strutturale entità
→ feedback 1800 ms
→ Home

Feedback strutturale:

Evento salvato:
- titolo Evento salvato
- riepilogo evento

Progetto creato:
- titolo Progetto creato
- riepilogo progetto

Entità creata:
- titolo Entità creata
- riepilogo entità

FEEDBACK PROJECT / ENTITY — TIMING ALIGNMENT POST UI READINESS

Nel nodo UI Readiness sono stati allineati:

- btn_command_create_project
- btn_command_create_entity

Pattern:

1. preparare nextFeedbackState
2. await ui_state.setValue(nextFeedbackState)
3. micro-tick setTimeout 0
4. mostrare container_feedback

Scopo:

- allineare project/entity
- preparare feedback_mode e feedback_summary prima della visibilità feedback
- ridurre differenze di timing

Esito:

✔ feedback project/entity funzionante
✔ ritorno Home automatico confermato
⚠ micro-flash feedback project/entity ancora presente come residuo minore

Nota post Linting / Retool Query Safety Pass:

handle_event_success è stato eliminato perché Retool lo segnalava come query unused
e la gestione feedback/routing è già centralizzata in button_input_confirm.

Test post-rimozione superati.

INSERT FLOW

Trigger:

insert_event

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

Caratteristiche:

✔ insert consentito se non ci sono ambiguità bloccanti
✔ nessuna validazione DB
✔ nessuna label persistita
✔ amount coerente con ui_state.parsed
✔ unit coerente con ui_state.parsed
✔ raw_input preservato
✔ type salvato in events.type
✔ project_id salvato da select_project.value
✔ entity_id salvato da select_entity.value
✔ project/entity creati inline salvabili solo dopo selezione confermata
✔ evento salvabile con project_id/entity_id null se l’utente ignora suggestion

Test validati:

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

Project / Entity Create Suggestion — insert evento validato:

villa sierri 15 sopralluogo referente kappa
→ project creato inline: Villa Sierri 15
→ entity creata inline: Referente Kappa
→ evento confermato manualmente
→ project_id valorizzato
→ entity_id valorizzato
→ status NEW

acquisto 50 euro materiale nuovo
→ suggestion ignorata
→ project_id null
→ entity_id null
→ type Spesa
→ amount 50
→ unit euro
→ status NEW

UPDATE FLOW

Trigger:

update_event

Utilizzato quando:

edit_mode = true

Payload:

raw_input
type
amount
unit
event_date
project_id
entity_id
updated_at

Caratteristiche:

✔ modifica eventi NEW
✔ status invariato
✔ dati aggiornati correttamente in DB
✔ type aggiornato correttamente in DB
✔ lista eventi aggiornata dopo salvataggio completato
✔ no-op edit guard evita update_event se non cambia nulla
✔ updated_at non cambia su edit senza modifiche reali
✔ edit_mode / editing_event vengono azzerati al termine del flow edit
✔ reset helper edit flow senza additionalScope { value }

Test validato:

Evento precedente senza type valorizzato
modificato in:

1 ora e 45 minuti lavoro

DB:

type Tempo
amount 105
unit minuti
raw_input aggiornato
updated_at aggiornato
status NEW

Problema risolto:

Prima:

events_new veniva aggiornato prima del completamento update_event.

Risultato:

DB corretto
lista momentaneamente vecchia
fix visibile solo dopo refresh pagina

Dopo:

await savePromise
→ await events_new.trigger()

Risultato:

✔ lista aggiornata subito
✔ nessun refresh pagina necessario

------------------------------------------------
ANNULLA MODIFICA
------------------------------------------------

Componente:

btn_cancel_edit

Ruolo:

uscire dalla modifica evento NEW senza salvare.

Disponibile solo se:

edit_mode.data = true

Comportamento:

- cancella eventuale debounce pendente
- imposta window.__logos_edit_mode_value = false
- rilancia edit_mode
- imposta window.__logos_editing_event_value = null
- rilancia editing_event
- resetta input_home
- resetta input_raw
- pulisce select_project
- pulisce select_entity
- pulisce select1
- resetta ui_state.parsed
- imposta ui_state.view = "events"
- torna alla lista eventi
- non esegue update_event
- non aggiorna updated_at

Codice helper:

```js
window.__logos_edit_mode_value = false;
await edit_mode.trigger();

window.__logos_editing_event_value = null;
await editing_event.trigger();

Risultato:

✔ annulla modifica senza salvare
✔ nessun update_event
✔ updated_at invariato
✔ edit_mode false
✔ editing_event null
✔ ritorno lista eventi
✔ linting helper non reintrodotto

LISTA EVENTI — SEARCH / FILTER / LABEL

Componenti:

input_events_search
list_events

Ruolo:

migliorare la gestione degli eventi NEW in processing.

Filtro:

input_events_search filtra client-side la lista eventi.

Campi ricercati:

raw_input
type
status
nome progetto
nome entità

Label lista eventi:

La lista distingue:

creato
modificato

Regole:

created_at / updated_at normalizzati in modo robusto
date DB trattate coerentemente come UTC
updated_at vicino a created_at non viene considerato modifica reale
evento mai modificato → creato
evento modificato realmente → modificato
edit annullato → label invariata
edit no-op → label invariata
edit reale → label modificato

Nota:

search/filter e label lista sono processing UX.

Non modificano:

parser
matching
type
duration
DB schema
lifecycle evento

GESTIONE ERRORI

✔ errori UI gestiti tramite feedback state
✔ nessun blocco runtime
✔ parsing non blocca
✔ input resta modificabile

TIPI:

parsing error
match error
input ambiguo
save error
update error
insert_project error
insert_entity error
duplicato project/entity
duplicato project/entity da command intent
comando generico incompleto
command intent non eseguibile
micro-flash feedback project/entity
eventuali linting Retool futuri
alias edit generico non riconosciuto
candidate suggestion non sicura

COMPORTAMENTO:

✔ NON bloccare input
✔ NON interrompere UX inutilmente
✔ mostrare feedback implicito o toaster Retool
✔ preservare possibilità di correzione
✔ bloccare insert_project / insert_entity se nome mancante
✔ bloccare insert_project / insert_entity se duplicato frontend rilevato
✔ mostrare warning duplicato senza scrivere DB
✔ lasciare evento non salvato finché l’utente non conferma
✔ non mostrare bottone crea se l’elemento esiste già
✔ guidare l’utente se il comando è incompleto
✔ non salvare eventi se l’input è comando puro
✔ non trattare ui_visibility_state come fonte dati salvabile
✔ non trattare input_analysis_result come fonte payload save
✔ correggere linting solo in nodi tecnici dedicati
✔ non inseguire micro-flash dentro nodi non dedicati

TEST VALIDATI

UX MOBILE COHERENCE PASS:

1. Nuovo evento → Conferma evento

Esito:

- insert_event eseguito
- feedback visibile
- feedback_summary mostrato
- events_new aggiornato
- dopo 1800 ms ritorno Home

RISULTATO:
OK

---

2. Lista eventi → Modifica → modifica reale → Conferma evento

Esito:

- update_event eseguito
- feedback visibile
- events_new aggiornato
- dopo 1800 ms ritorno Lista eventi

RISULTATO:
OK

---

3. Lista eventi → Modifica → nessuna modifica → Conferma evento

Esito:

- update_event non eseguito
- feedback non mostrato
- ritorno immediato Lista eventi
- updated_at invariato

RISULTATO:
OK

---

4. Home → scrivi input → Torna alla home

Esito:

- nessun insert_event
- input_home svuotato
- input_raw svuotato
- select resettate
- ui_state.parsed resettato
- feedback_summary azzerato
- ritorno Home

RISULTATO:
OK

---

5. Lista eventi → Modifica → Annulla modifica

Esito:

- nessun update_event
- edit_mode false
- editing_event null
- input/select resettati
- feedback_summary azzerato
- ritorno Lista eventi

RISULTATO:
OK

---

6. iPhone 13 Safari reale

Problemi iniziali:

- zoom automatico su tap input
- troncamento laterale interfaccia
- select non pienamente utilizzabili come dropdown

Fix:

- font-size 16px su input/select principali

Esito:

- nessuno zoom automatico
- layout mobile stabile
- select Tipo / Progetto / Entità funzionanti sia in digitazione sia in dropdown

RISULTATO:
OK

COMMAND INTENT — TEST VALIDATI:

1. Comando generico

crea

Esito:

- Comando rilevato
- esempi leggibili
- nessuna Sintesi evento
- nessun Dati evento
- nessun evento salvato

RISULTATO:
OK

---

2. Create project incompleto

crea progetto

Esito:

- card command visibile
- input nome progetto visibile
- bottone Crea progetto disabilitato a campo vuoto
- nessun evento salvato

RISULTATO:
OK

---

3. Create project completo

crea progetto Command Final Project 2

Esito:

- project creato tramite insert_project
- feedback Progetto creato
- ritorno Home automatico
- nessun evento salvato

RISULTATO:
OK

---

4. Create entity incompleto

crea entità

Esito:

- card command visibile
- input nome entità visibile
- bottone Crea entità disabilitato a campo vuoto
- nessun evento salvato

RISULTATO:
OK

---

5. Create entity completo

crea entità Command Final Entity 2

Esito:

- entity creata tramite insert_entity
- feedback Entità creata
- ritorno Home automatico
- nessun evento salvato

RISULTATO:
OK

---

6. Elemento già presente

crea progetto villa

Esito:

- elemento già presente riconosciuto
- nessun bottone crea
- nessuna duplicazione
- nessun evento salvato

RISULTATO:
OK

---

7. Guida modifica evento

modifica evento

Esito:

- guida mostrata
- CTA Vai agli eventi funzionante
- lista eventi aperta
- nessuna modifica automatica
- nessun evento salvato

RISULTATO:
OK

---

8. Evento normale non regressivo

30 euro spesa villa citrignano

Esito:

- command intent non interferisce
- flow evento ordinario mostrato
- Conferma evento salva evento NEW
- feedback evento corretto
- ritorno Home automatico

RISULTATO:
OK

---

9. Edit evento reale non regressivo

Esito:

- update_event eseguito
- feedback evento corretto
- ritorno Lista eventi
- evento marcato come modificato

RISULTATO:
OK

---

10. Edit no-op / annulla modifica non regressivo

Esito:

- nessun update_event se non ci sono modifiche reali
- updated_at non alterato
- ritorno Lista eventi

RISULTATO:
OK

UI READINESS / VISIBILITY AGGREGATOR — TEST VALIDATI:

1. Evento normale

30 euro spesa villa citrignano

Risultato:

- flow evento ordinario mostrato
- Sintesi visibile
- Dati evento visibili
- Conferma evento disponibile

RISULTATO:
OK

---

2. Comando generico

crea

Risultato:

- container_command_intent visibile
- Sintesi nascosta
- Dati evento nascosti
- Conferma evento nascosta

RISULTATO:
OK

---

3. Create project incompleto

crea progetto

RISULTATO:
OK

---

4. Create project completo

crea progetto Nome Test

RISULTATO:
OK

---

5. Create entity incompleto

crea entità

RISULTATO:
OK

---

6. Create entity completo

crea entità Nome Test

RISULTATO:
OK

---

7. Elemento già presente

crea progetto villa

RISULTATO:
OK

---

8. Guida edit

modifica evento

RISULTATO:
OK

---

9. Suggestion project/entity da evento normale

RISULTATO:
OK

---

10. Edit evento reale

RISULTATO:
OK

---

11. Edit no-op

RISULTATO:
OK

---

12. Annulla edit

RISULTATO:
OK

---

13. Feedback evento

RISULTATO:
OK

---

14. Feedback project/entity

RISULTATO:
OK con micro-flash residuo non bloccante

---

15. Events list

RISULTATO:
OK

---

16. Home vuota + navigation dock

RISULTATO:
OK

---

Validazioni finali:

✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto
✔ edit mode chiarito
✔ Command Intent preservato
✔ create/edit/feedback/lista non regressivi
✔ DB invariato
✔ parser invariato
✔ matching invariato
✔ save flow invariato

INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS — TEST VALIDATI:

1. Evento normale

30 euro spesa materiale

Esito:

- Sintesi visibile
- Dati evento visibili
- select visibili
- command container nascosto

RISULTATO:
OK

---

2. Euro senza direzione

30 euro materiale

Esito:

- warning “Definisci spesa o incasso”
- Dati evento visibili
- salvataggio ancora consentito se non ci sono blocchi matching

RISULTATO:
OK

---

3. Durata normalizzata

1 ora e 15 minuti lavoro

Esito:

- amount 75
- unit minuti
- type Tempo
- hint Normalizzato: 75 minuti
- input_analysis_result readiness coerente

RISULTATO:
OK

---

4. Ambiguità entity

30 euro cliente test

Esito:

- entity ambigua
- hint “Più entità trovate”
- canConfirm false
- Sintesi e Dati evento visibili

RISULTATO:
OK

---

5. Command puro

crea progetto Nome Test

Esito:

- effectiveFlowType command
- container_command_intent visibile
- Sintesi nascosta
- Dati evento nascosti
- project/entity raw ignorati come dati evento

RISULTATO:
OK

---

6. Edit mode + input crea

Esito:

- raw command true
- command effective false
- edit mode prevale
- container_command_intent nascosto
- event flow preservato
- residuo UX guidance tracciato

RISULTATO:
OK

---

7. Edit mode + input vuoto

Esito:

- Sintesi nascosta
- Dati evento nascosti
- Conferma nascosta
- Home idle container nascosti
- Annulla modifica visibile

RISULTATO:
OK

---

8. Suggestion container

Esito:

- container_association_suggestions governato da input_analysis_result
- non appare vuoto
- la notice associazioni mancanti non promette suggerimenti se non sono visibili

RISULTATO:
OK

---

Validazioni finali:

✔ preview_analysis_state operativo
✔ input_analysis_result operativo come fonte UI parziale
✔ ui_visibility_state ancora operativo e non deprecato
✔ parser invariato
✔ matching invariato
✔ create_suggestion_state invariato
✔ command_intent_state invariato
✔ save flow invariato
✔ DB invariato

INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION — TEST VALIDATI:

Micro-batch 1:

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

Micro-batch 2:

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

Smoke test finale post rimozione dipendenza ui_visibility_state:

- Home vuota
- 20 euro villa
- crea
- edit input vuoto

Esito:

✔ input_analysis_result non dipende più da ui_visibility_state
✔ graph Retool confermato
✔ nessuna regressione osservata

Note:

- label “Importo” su durata rilevata come bug semantico preesistente
- policy match più specifici confermata non bloccante
- nav nascosta in edit mode confermata coerente

LINTING / RETOOL QUERY SAFETY PASS — TEST VALIDATI:

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

PARSER / PREVIEW:

18min test
→ parsed: amount 18, unit minuti
→ preview: 18 minuti • test

18 minuti test
→ parsed: amount 18, unit minuti
→ preview: 18 minuti • test

1ora lavoro
→ parsed: amount 60, unit minuti
→ preview: 1 ora
→ hint: Normalizzato: 60 minuti

1 ora lavoro
→ parsed: amount 60, unit minuti
→ preview: 1 ora • lavoro
→ hint: Normalizzato: 60 minuti

2 ore sopralluogo villa 2
→ parsed: amount 120, unit minuti
→ preview: 2 ore • sopralluogo villa 2
→ hint: Normalizzato: 120 minuti

1,5 ore sopralluogo
→ parsed: amount 90, unit minuti
→ preview: 1 ora 30 minuti • sopralluogo
→ hint: Normalizzato: 90 minuti

1.5 ore sopralluogo
→ parsed: amount 90, unit minuti
→ preview: 1 ora 30 minuti • sopralluogo
→ hint: Normalizzato: 90 minuti

1 ora e 15 minuti sopralluogo
→ parsed: amount 75, unit minuti
→ preview: 1 ora 15 minuti • sopralluogo
→ hint: Normalizzato: 75 minuti

2h30 rendering
→ parsed: amount 150, unit minuti
→ preview: 2 ore 30 minuti • rendering
→ hint: Normalizzato: 150 minuti

2 h 30 rendering
→ parsed: amount 150, unit minuti
→ preview: 2 ore 30 minuti • rendering
→ hint: Normalizzato: 150 minuti

2 ore 30 rendering
→ parsed: amount 150, unit minuti
→ preview: 2 ore 30 minuti • rendering
→ hint: Normalizzato: 150 minuti

90 minuti rendering
→ parsed: amount 90, unit minuti
→ preview: 90 minuti • rendering

20€ materiale
→ parsed: amount 20, unit euro

villa 2 mario
→ parsed: amount null, unit null
→ preview: villa 2 mario

458,78 euro mangime
→ parsed: amount 458.78, unit euro

1.500 euro materiale
→ parsed: amount 1500, unit euro

1.500,50 euro materiale
→ parsed: amount 1500.5, unit euro

2 giorni rendering
→ parsed: amount null, unit null
→ preview: 2 giorni rendering
→ hint: Durata ambigua

1 settimana lavoro
→ parsed: amount null, unit null
→ preview: 1 settimana lavoro
→ hint: Durata ambigua

INSERT:

1.500,50 euro test engine
→ amount 1500.5
→ unit euro
→ status NEW

INSERT DOPO RIMOZIONE PARSING LEGACY:

1.500,50 euro test engine 2
→ amount 1500.5
→ unit euro
→ status NEW

UPDATE:

1,5 ore test engine update
→ amount 1.5
→ unit ore
→ status NEW

UPDATE LISTA:

update_event
→ await save
→ events_new refresh
→ lista aggiornata subito

DURATION NORMALIZATION — INSERT:

1 ora e 15 minuti test duration
→ amount 75
→ unit minuti
→ raw_input preservato
→ status NEW

2h30 test duration
→ amount 150
→ unit minuti
→ raw_input preservato
→ status NEW

1,5 ore test duration
→ amount 90
→ unit minuti
→ raw_input preservato
→ status NEW

2 giorni test duration
→ amount null
→ unit null
→ raw_input preservato
→ status NEW

DURATION NORMALIZATION — UPDATE:

2 ore e 30 minuti test duration update
→ amount 150
→ unit minuti
→ raw_input aggiornato
→ status NEW

1 ora e 45 minuti regressione finale update
→ amount 105
→ unit minuti
→ raw_input aggiornato
→ status NEW

DURATION NORMALIZATION — REGRESSIONI:

30 euro regressione finale
→ amount 30
→ unit euro
→ status NEW

villa 2 test duration
→ amount null
→ unit null
→ raw_input preservato
→ status NEW

TYPE CLASSIFICATION BASE — ANTEPRIMA:

2h30 rendering
→ select1 Tempo

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

TYPE CLASSIFICATION BASE — INSERT DB:

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

TYPE CLASSIFICATION BASE — UPDATE DB:

1 ora e 45 minuti lavoro
→ type Tempo
→ amount 105
→ unit minuti
→ updated_at aggiornato

TYPE CLASSIFICATION BASE — OVERRIDE MANUALE:

20 euro materiale + select1 manuale Spesa
→ DB type Spesa

20 euro materiale + select1 manuale Incasso
→ DB type Incasso

TYPE CLASSIFICATION BASE — RESET / STALE VALUE:

20 euro materiale
→ select1 manuale Spesa
→ conferma
→ nuovo input villa 2 mario
→ select1 Evento

Esito:

nessuna modifica necessaria al reset select1.

PREVIEW ALIGNMENT BASE:

1.500,50 euro materiale
→ 1.500,50 € • materiale

1500 euro materiale
→ 1.500,00 € • materiale

18 minuti test
→ 18 minuti • test

18min test
→ 18 minuti • test

1ora lavoro
→ 1 ora • lavoro

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

4 aprile benzina 50 euro alfie allevamento aspri
→ 4 apr • 50,00 € • benzina alfie allevamento aspri

villa 2 mario
→ villa 2 mario

2 ore sopralluogo villa 2
→ 2 ore • sopralluogo villa 2

2,7 ore sviluppo sistema aspri
→ 2,7 ore • sviluppo sistema aspri

Nota:

il vecchio hint "Verifica durata" è stato superato
dal nodo Duration Normalization Base.

Ora la preview mostra:

- forma umana della durata
- hint "Normalizzato: X minuti"
- hint durata ambigua per giorni/settimane

MATCH ENGINE UNIFICATION — TEST VALIDATI:

villa 2 mario
→ project Villa 2
→ entity Mario
→ Conferma abilitata

4 aprile benzina 50 euro alfie allevamento aspri
→ project ASPRI
→ entity ambigua
→ Più entità trovate
→ Conferma disabilitata finché non viene scelta entità

stesso input + scelta manuale Alfie
→ Conferma abilitata

18 min ristrutturazione bagno
→ project Ristrutturazione Bagno
→ type Tempo
→ Conferma abilitata

acquisto 50 euro materiale nuovo
→ nessun project/entity
→ type Spesa
→ Conferma abilitata

mario
→ entity Mario
→ hint Esistono entità più specifiche
→ Conferma abilitata

mario rossi
→ entity Mario Rossi
→ hint Esistono entità più specifiche
→ Conferma abilitata

mario rossi alfredo
→ entity Mario Rossi Alfredo
→ Conferma abilitata

villa
→ project Villa
→ hint Esistono progetti più specifici
→ Conferma abilitata

villa 2
→ project Villa 2
→ Conferma abilitata

alfie mario rossi
→ ambiguità reale entity
→ Conferma disabilitata

€500 acconto alfie mario rossi
→ 500,00 € • acconto alfie mario rossi
→ entity ambigua

UX / CLEANUP MICRO-BATCH — TEST VALIDATI:

Create nuovo evento
→ OK

Edit evento
→ OK

Annulla modifica
→ nessun update_event
→ updated_at invariato
→ ritorno lista eventi
→ edit_mode false
→ editing_event null
→ OK

Edit senza modifiche reali
→ no-op edit guard attivo
→ nessun update_event
→ updated_at invariato
→ label creato/modificato invariata
→ ritorno lista eventi
→ OK

Edit con modifica reale
→ update_event eseguito
→ updated_at aggiornato
→ events_new refresh dopo save
→ label modificato coerente
→ edit_mode reset
→ editing_event reset
→ OK

Lista eventi search/filter
→ campo vuoto mostra lista completa
→ filtro raw_input funzionante
→ filtro type/status funzionante
→ filtro project/entity funzionante
→ edit da lista filtrata funzionante
→ WRITTEN / ERROR invariati
→ OK

LINTING / STATE HELPER CLEANUP — TEST VALIDATI:

Linting edit_mode
→ edit_mode: 'value' is not defined non più presente
→ OK

Linting editing_event
→ editing_event: 'value' is not defined non più presente
→ OK

Create flow
→ OK

Edit flow
→ OK

Annulla modifica
→ OK

Edit senza modifiche reali
→ OK

Edit con modifica reale
→ OK

updated_at / label creato-modificato
→ OK

WRITTEN / ERROR
→ OK

Regressioni:
- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- preview invariata
- lista eventi invariata

Esito:
OK

PROJECT / ENTITY CREATE SUGGESTION — TEST VALIDATI:

Project create:

villa sierri 6 sopralluogo
→ suggestion project Villa Sierri 6
→ insert_project eseguito previa conferma
→ select_project valorizzata
→ evento non salvato automaticamente

villa sierri 7 sopralluogo
→ suggestion project Villa Sierri 7
→ project creato
→ select_project valorizzata
→ evento salvato manualmente con project_id corretto

Entity create:

villa sierri 7 sopralluogo
→ project Villa Sierri 7 riconosciuto
→ nessuna entità associata
→ Crea entità visibile
→ Tecnico Sierri 4 creato inline
→ select_entity valorizzata
→ evento salvato manualmente con entity_id corretto

Flow combinato:

villa sierri 15 sopralluogo referente kappa
→ project Villa Sierri 15 creato inline
→ entity Referente Kappa creata inline
→ evento confermato manualmente
→ DB con project_id + entity_id corretti

No-match generico:

acquisto 50 euro materiale nuovo
→ type Spesa
→ amount 50
→ unit euro
→ suggestion project/entity visibile
→ Ignora
→ evento salvato con project_id null / entity_id null

Ambiguità entity:

alfie mario rossi
→ più entità trovate
→ Crea entità non visibile
→ Conferma disabilitata
→ dopo selezione manuale entity, Conferma abilitata

Entity autofill:

villa sierri 15 sopralluogo referente kappa
→ Crea entità
→ input_new_entity_name precompilato Referente Kappa

acquisto 50 euro materiale nuovo
→ Crea entità
→ input_new_entity_name vuoto

Edit/no-op regression:

edit evento esistente senza modifiche
→ no update_event
→ updated_at invariato
→ suggestion non regressiva

LIMITI ATTUALI

INPUT / PARSING:

giorni non convertiti automaticamente
settimane non convertite automaticamente
giornata / mezza giornata non normalizzate
parole numeriche tipo “due ore” non supportate
forme colloquiali tipo “un paio d’ore” non supportate
2h e mezza non supportato
date relative non supportate
parsing semantico non implementato

NORMALIZATION:

amount/unit base implementati
unità canonica tempo = minuti
conversione ore/minuti implementata
giorni/settimane non convertiti automaticamente
nessuna retro-normalizzazione dati storici
nessun payload duration
nessun campo duration_minutes dedicato

TYPE:

type classification base implementata
Tempo / Spesa / Incasso / Evento persistiti in events.type
spesa/incasso riconosciuti solo tramite keyword controllate o scelta manuale
euro senza direzione chiara resta Evento
amount firmato non implementato
direction field non implementato
classificazione economica avanzata non implementata
parole di dominio non usate come classificazione automatica
type non ancora sufficiente da solo per KPI avanzati
eventi storici non retro-normalizzati

MATCHING:

Match Engine Unification First Controlled Level completato
project_state/entity_state fonte minima matching
select/hint/highlight/confirm allineati a match state
priority match minimo implementato
no fuzzy matching
no alias system
no gerarchia entity/project
no deduplicazione
creazione guidata project/entity implementata a primo livello controllato
command intent base implementato
no filtro select su match ambigui
no ranking avanzato

PREVIEW:

non completamente read-only
formattazione italiana base allineata nella sintesi
contiene ancora logica label/hint
non è una view pura
label cleaning ancora embedded
hint matching project/entity allineati a state
hint duration/type ancora embedded
“Da verificare” ancora interno alla Sintesi
visibilità Sintesi governata da ui_visibility_state.showEventPreview
contenuto interno Sintesi ancora non separato
warning informativi non separati in blocchi autonomi

ARCHITETTURA:

alcuni layer ancora accoppiati
matching project/entity allineato a primo livello
preview ancora ibrida
input system stabilizzato ma non completamente separato da tutti i layer
command intent implementato a primo livello controllato
container suggestion UI rifinito a livello mobile base
create_suggestion_state ancora helper Retool, non modulo engine separato
command_intent_state ancora helper Retool, non modulo engine separato
input_analysis_result implementato come layer compositivo per Hidden principali del flow input
Input Analysis Model completo non implementato
ui_visibility_state non sostituisce match engine
ui_visibility_state non è più letto da input_analysis_result
ui_visibility_state resta residuo tecnico deprecabile
Full Visibility Migration degli Hidden principali completata
button_input_confirm.Hidden migrato
button_input_confirm.Disabled non migrato
button_input_confirm payload invariato
save readiness non centralizzata
rendering progressivo input evento normale ridotto tramite UI Readiness e input_analysis_result
micro-flash feedback project/entity ancora presente
flash residui digitazione/cambio schermata ancora presenti
linting Retool azzerati
typing_state eliminato
handle_event_success eliminato
“modifica” generico non ancora riconosciuto come guida edit
“crea” in edit mode soppresso correttamente ma senza guidance esplicita
cleanup obsolete UI guards / query reduction non ancora eseguito

COMMAND INTENT:

implementato a primo livello controllato

Gestito:

- crea
- crea progetto
- crea progetto [nome]
- aggiungi progetto [nome]
- inserisci progetto [nome]
- nuovo progetto [nome]
- crea entità
- crea entità [nome]
- aggiungi entità [nome]
- inserisci entità [nome]
- nuova entità [nome]
- modifica evento

Non implementato:

- intent engine globale
- dashboard/report intent
- modifica project/entity da command
- edit flow evento automatico da command
- input analysis model unico
- alias / deduplicazione / gerarchie da command
- alias guida edit generici:
  - modifica
  - correggi
  - cambia

OBIETTIVO INPUT SYSTEM

Rendere l’input:

veloce
comprensibile
sufficientemente affidabile
non bloccante
coerente nel salvataggio
progressivamente normalizzato
capace di assistere la creazione project/entity senza automatismi nascosti
capace di distinguere comandi strutturali puri da eventi ordinari a primo livello controllato
capace di coordinare la visibilità del flow input tramite input_analysis_result e ui_visibility_mode
capace di comporre raw / selection / effective state tramite input_analysis_result
capace di alimentare gli Hidden principali del flow input senza diventare un motore monolitico

NON:

perfetto
completamente automatico
semantico avanzato
decisionale
orientato a KPI prima della qualità dati
intent engine globale o assistente conversazionale avanzato
Input Analysis Model completo già concluso
Event Interpretation Engine
fonte unica interpretativa completa già implementata
mega-motore monolitico che sostituisce i moduli specializzati

NEXT STEP CONSIGLIATI

DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION

Obiettivo futuro:

ridurre ridondanze nella documentazione LOGOS senza perdere ricostruibilità.

Focus:

- una logica fondamentale completa in un solo documento canonico
- richiami espliciti negli altri documenti
- mappa responsabilità documentale
- Session Boot Matrix
- riduzione del numero di documenti da aggiornare per ogni micro-sessione

Vincoli:

- non cancellare contenuti critici
- non alterare logiche runtime
- non rendere i documenti troppo astratti
- preservare possibilità di ricostruzione del sistema in caso di crash

---

PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT

Obiettivo futuro:

correggere la label “Importo” quando il valore rappresenta una durata.

Focus:

- euro → Importo
- minuti / ore → Durata
- nessuna unità → riga assente o label neutra

Vincoli:

- non modificare parser
- non modificare duration normalization
- non modificare DB
- non modificare save flow
- non modificare amount/unit salvati

---

INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION

Obiettivo futuro:

analizzare flash residui durante digitazione e cambio schermata.

Vincoli:

- non modificare parser
- non modificare matching
- non modificare save flow
- non introdurre routing alternativo
- intervenire solo se il fix è locale e reversibile

---

BUTTON CONFIRM READINESS ALIGNMENT

Obiettivo futuro:

valutare solo la parte non migrata di button_input_confirm.

Focus:

- Disabled
- canConfirm
- ambiguity
- input vuoto
- edit mode
- no-op guard
- save readiness

Già completato:

- button_input_confirm.Hidden migrato a input_analysis_result.readiness.canShowConfirm

Vincoli:

- non modificare insert_event / update_event
- non modificare payload
- non modificare parser/matching
- testare create / edit / no-op / command / ambiguity / empty input

---

PREVIEW MODEL / HINT STATE CONSOLIDATION

Obiettivo futuro:

consolidare hint/warning ancora embedded nella Sintesi.

Focus:

- “Da verificare” dentro Sintesi
- status OK + card Da verificare
- separazione hint bloccanti / warning informativi / suggestion visuali
- preview più vicina a view pura
- evitare divergenze tra ciò che l’utente legge e ciò che viene salvato

---

CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION

Obiettivo futuro:

valutare eliminazione ui_visibility_state e guardie duplicate residue.

Vincoli:

- non prima dell’audit documentale
- non prima di test regressione dedicati
- non modificare parser/matching/save flow
- non eliminare query/componenti senza graph aggiornato

CHANGELOG

v01 — 2026-04-01

Definizione completa sistema input

v02 — 2026-04-02

Consolidamento parsing, preview, matching
Allineamento con implementazione Retool

v03 — 2026-04-04

introduzione separazione parsing / label
introduzione label system (non persistito)
aggiornamento preview (label + hint)
miglioramento UX suggerimenti

v04 — 2026-04-23

introduzione update_event
introduzione edit_mode
supporto editing eventi
refactor confirm flow (insert/update)
centralizzazione UI feedback
identificazione loop reattivo
allineamento comportamento reale sistema

v05 — 2026-04-30

completamento Normalization Layer Base
stabilizzazione ui_state.parsed
introduzione normalization amount formato italiano
introduzione normalization unit base
supporto unità compatte testuali
rimozione amount per numeri senza unità
eliminazione parsing legacy da button_input_confirm
allineamento insert/update a ui_state.parsed
validazione insert con dati normalizzati
validazione update con dati normalizzati
fix refresh lista dopo update
esplicitazione limiti: multi-unit, duration normalization, type classification

v06 — 2026-04-30

completamento PREVIEW ALIGNMENT BASE
documentato allineamento preview a ui_state.parsed
documentata formattazione italiana amount solo visuale
documentata visualizzazione euro con due decimali
documentato grouping migliaia visuale
documentata visualizzazione coerente ore/minuti
documentato singolare/plurale unit
documentato label cleaning preview aggiornato
documentata correzione bug "minuti" → "uti"
documentato separatore data/descrizione
documentato highlight unit-safe
confermato che parse_input_controlled non è stato modificato
confermato che ui_state.parsed non è stato modificato
confermato che save flow e DB restano invariati
aggiornamento prossimo nodo consigliato: ENGINE BASE — DURATION NORMALIZATION

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
aggiornamento prossimo nodo consigliato: ENGINE BASE — TYPE CLASSIFICATION BASE

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
aggiornamento prossimo nodo consigliato: MATCH ENGINE UNIFICATION

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
aggiornamento next step consigliati post linting cleanup

v11 — 2026-05-07

completamento PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
documentato create_suggestion_state
documentata creazione inline project/entity
documentato insert_project
documentato insert_entity
documentato container suggestion inline
documentati input_new_project_name / input_new_entity_name
documentato bottone Ignora globale
documentati bottoni Annulla contestuali
documentato entity autofill controlled minimal
documentato reset suggestion stale in trigger_parse_debounced
documentato che suggestion ≠ salvataggio
documentato che input evento ≠ command intent
documentato che evento non viene salvato automaticamente dopo creazione project/entity
documentato che project/entity mancanti non bloccano salvataggio
documentato che project/entity ambigui bloccano salvataggio
documentato flow combinato project + entity validato
documentato no-match generico salvabile
documentato ambiguità entity bloccante
documentato entity autofill positivo e negativo
documentato edit/no-op non regressivo dopo create suggestion
DB schema invariato
parser invariato
type classification invariata
duration normalization invariata
nessun output/KPI anticipato
aggiornati next step consigliati post create suggestion

v12 — 2026-05-09

- integrazione UX MOBILE COHERENCE PASS
- documentata Home mobile rifinita
- documentati Dati evento compatti con label inline
- documentato feedback_summary in ui_state
- documentato Feedback System mobile
- documentato feedback temporaneo non persistente
- documentato routing post-save contestuale
- documentato insert reale → feedback 1800 ms → Home
- documentato update reale → feedback 1800 ms → Lista eventi
- documentato no-op edit → Lista eventi immediata senza update_event
- documentato cancel create/input → Home
- documentato cancel edit → Lista eventi
- documentato cancel contestuale create/edit
- documentata Navigation dock Home / Eventi / Dashboard
- documentata Dashboard predisposta ma disabilitata
- documentata nav nascosta durante input attivo e feedback
- documentato handle_event_success non più gestore UI post-save
- documentata centralizzazione feedback/routing in button_input_confirm
- documentati Icon add-ons Retool nei componenti reali
- documentato font-size 16px input/select per Safari iOS
- documentato fix zoom automatico iOS Safari
- documentate select mobile funzionanti sia in digitazione sia in dropdown
- documentata validazione reale iPhone 13 Safari
- confermato DB invariato
- confermato parser invariato
- confermato matching invariato
- confermato create_suggestion_state invariato
- confermata type classification invariata
- confermata duration normalization invariata
- nessun output/KPI anticipato

v13 — 2026-05-13

- integrazione COMMAND INTENT — CREATE PROJECT / ENTITY
- documentato command_intent_state
- documentato container_command_intent
- documentati input_command_project_name / input_command_entity_name
- documentati btn_command_create_project / btn_command_create_entity / btn_command_go_events
- aggiornato principio INPUT EVENTO ≠ COMMAND INTENT
- documentato comando generico “crea”
- documentato create project incompleto
- documentato create project completo
- documentato create entity incompleto
- documentato create entity completo
- documentati sinonimi base crea / aggiungi / inserisci / nuovo / nuova
- documentato elemento già presente
- documentata guida non operativa “modifica evento”
- documentato che comandi puri non salvano eventi
- documentato che project/entity da command richiedono conferma utente
- documentato riuso insert_project / insert_entity
- documentato feedback_mode in ui_state
- documentato feedback project_created
- documentato feedback entity_created
- documentato feedback evento ordinario preservato
- documentato feedback_summary strutturale per progetto/entità
- documentato Command Intent Flow
- aggiornato trigger_parse_debounced con command_intent_state
- aggiornato Mobile Safari Baseline includendo input command
- aggiornati limiti attuali
- aggiunti test Command Intent validati
- aggiornati next step consigliati post Command Intent
- documentati residui:
  - rendering progressivo input evento normale
  - “Da verificare” interno alla Sintesi
  - input analysis model unico non implementato
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato

v14 — 2026-05-18

- integrazione UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
- integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- documentato principio UI READINESS ≠ INPUT ANALYSIS MODEL COMPLETO
- documentato ui_visibility_mode come Variable Retool
- documentato ui_visibility_state come Transformer read-only
- ui_visibility_mode supporta empty / event / command
- trigger_parse_debounced aggiorna ui_visibility_mode
- documentato window.__logos_visibility_run_id
- documentata classificazione locale event/command solo per visibilità UI
- documentato che ui_visibility_state non sostituisce parser, matching, command_intent_state o create_suggestion_state
- aggiornata architettura input con ui_visibility_mode e ui_visibility_state
- aggiornata pipeline input:
  input_home → input_raw → trigger_parse_debounced → ui_visibility_mode → command_intent_state / parser / matching / suggestion → ui_visibility_state
- documentata centralizzazione Hidden principali:
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
- text_input_analysis_loading documentato
- text_edit_mode_notice documentato
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
- cleanup obsolete UI guards / query reduction rimandato
- aggiornati next step consigliati post UI Readiness

v15 — 2026-05-20

- integrazione PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
- documentato preview_analysis_state come Transformer read-only
- documentato preview_analysis_state come fonte hint/status/warning/Da verificare/associazioni mancanti della Sintesi
- documentato che preview_analysis_state non modifica parser, matching, command_intent_state, create_suggestion_state, save flow o DB

- integrazione INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
- documentato input_analysis_result come Transformer compositivo read-only
- documentata distinzione raw / selection / effective
- documentato event / command / edit effective flow
- documentato command raw vs command effective
- documentato edit mode prevalente su command intent
- documentato project/entity raw match vs effective usability
- documentato che input_analysis_result non alimenta select_project / select_entity
- documentato che input_analysis_result non costruisce payload save
- documentato che input_analysis_result non sostituisce parser o matching

- integrazione INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS
- documentato input_analysis_result come fonte UI controllata parziale
- documentata migrazione di sintesi.Hidden a input_analysis_result
- documentata migrazione di text_event_data_title / select1 / select_project / select_entity Hidden a input_analysis_result
- documentata migrazione di container_command_intent.Hidden a input_analysis_result
- documentata migrazione di container_association_suggestions.Hidden a input_analysis_result
- documentata micro-copy notice associazioni mancanti coerente con presenza reale suggerimenti
- documentato edit mode + input vuoto stabilizzato
- documentato Home idle container nascosti durante edit mode
- documentato Dati evento / Sintesi / Conferma nascosti con edit input vuoto
- documentato che solo Annulla modifica resta visibile in edit input vuoto
- documentato che ui_visibility_state resta operativo e non deprecato
- documentato che container_input / loading / cancel / confirm restano fuori dalla migrazione corrente
- documentato che button_input_confirm non è ancora migrato
- documentato che button_input_confirm payload resta invariato
- documentato che save readiness non è centralizzata
- documentato aumento linting Retool a 19
- aggiornati limiti attuali
- aggiornati test validati
- aggiornati next step consigliati
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- command_intent_state invariato
- insert_event / update_event invariati
- insert_project / insert_entity invariati
- nessun output/KPI anticipato

v16 — 2026-05-23

- integrazione INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
- documentata migrazione container_input.Hidden a input_analysis_result
- documentata migrazione text_input_analysis_loading.Hidden a input_analysis_result
- documentata migrazione btn_cancel_edit.Hidden a input_analysis_result
- documentata migrazione btn_cancel_input_home.Hidden a input_analysis_result
- documentato canShowConfirm come flag visibility-only
- documentata migrazione button_input_confirm.Hidden a input_analysis_result.readiness.canShowConfirm
- documentato canShowConfirm distinto da canConfirm
- documentato button_input_confirm.Disabled invariato
- documentato button_input_confirm payload invariato
- documentata rimozione dipendenza input_analysis_result → ui_visibility_state
- documentato che input_analysis_result non legge più ui_visibility_state
- documentato ui_visibility_state come residuo tecnico deprecabile
- documentato ui_visibility_mode come latch leggero empty / event / command
- documentato routing principale app su ui_state.view
- documentati test Visibility Migration Completion
- documentato residuo label “Importo” su durata

- integrazione LINTING / RETOOL QUERY SAFETY PASS
- documentato linting Retool azzerato
- documentata sostituzione ternari multilinea ambigui con if / else equivalenti
- documentate correzioni in input_analysis_result
- documentate correzioni in preview_analysis_state
- documentate correzioni in create_suggestion_state
- documentate correzioni in command_intent_state
- documentata eliminazione query legacy typing_state
- documentata eliminazione query legacy handle_event_success
- documentata Performance unused query risolta
- documentati test post-rimozione query legacy
- confermato DB invariato
- confermato parser invariato
- confermato matching invariato
- confermato command intent invariato nella logica funzionale
- confermato suggestion invariata nella logica funzionale
- confermato save flow invariato
- confermato payload invariato
- aggiornati limiti attuali
- aggiornati next step consigliati