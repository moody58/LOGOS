# 02_LOGOS_Match_Engine_v11

DATA: 2026-05-25

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- inclusa logica reale aggiornata post STEP 6.4  
- project_state / entity_state documentati come fonte minima matching  
- coperti project + entity + hint + auto-select + confirm guard  
- documentato singleMatch  
- documentato isAmbiguous  
- documentato moreSpecificMatches  
- documentato priority match minimo  
- documentato create flow con match state live  
- documentato edit flow con match state live  
- documentato rapporto con preview / highlight / hint  
- esplicitati limiti residui
- documentato rapporto tra match state e create_suggestion_state
- documentato Project / Entity Create Suggestion First Controlled Level
- documentato che la suggestion consuma il matching ma non lo sostituisce
- documentata creazione project/entity solo previa conferma utente
- documentata regola select = decisione utente finale
- documentato blocco solo su ambiguità attiva
- documentato entity autofill controlled minimal come supporto suggestion, non matching  
- documentato Command Intent — Create Project / Entity
- chiarito che command_intent_state non è parte del Match Engine
- chiarito che command_intent_state non sostituisce project_state / entity_state
- chiarito che command_intent_state non sostituisce create_suggestion_state
- documentato che i comandi puri non entrano nel save flow evento
- documentato blocco duplicati project/entity esistenti da command
- documentata separazione tra matching, suggestion e command intent
- documentato rapporto tra Match Engine e UI Readiness / Visibility Aggregator
- chiarito che ui_visibility_state può leggere project_state / entity_state solo per visibilità/hint
- chiarito che ui_visibility_state non sostituisce project_state / entity_state
- chiarito che ui_visibility_state non modifica matching, select o confirm guard
- chiarito che ui_visibility_mode non è parte del Match Engine
- documentato residuo Input Analysis Model / Single Interpretation Layer come futuro non attivo
- documentato rapporto tra Match Engine e preview_analysis_state
- documentato rapporto tra Match Engine e input_analysis_result
- chiarito che input_analysis_result legge project_state / entity_state ma non sostituisce il matching
- chiarito che input_analysis_result distingue raw match / selection / effective usability
- chiarito che input_analysis_result non modifica project_state / entity_state
- chiarito che input_analysis_result non modifica select_project / select_entity
- chiarito che input_analysis_result non modifica confirm guard funzionale o payload
- documentato che il Match Engine resta invariato dopo Controlled UI Consumption Pass
- documentato che il Match Engine resta invariato dopo Input Analysis Result — Visibility Migration Completion
- documentato che input_analysis_result ora governa gli Hidden principali del flow input senza modificare project_state / entity_state
- documentato che ui_visibility_state non è più letto da input_analysis_result
- documentato che ui_visibility_state resta residuo tecnico deprecabile e non fonte matching
- documentato che button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm
- documentato che button_input_confirm.Disabled resta guard funzionale separata
- documentato che button_input_confirm payload resta invariato
- documentato che Linting / Retool Query Safety Pass non ha modificato il Match Engine
- documentato linting Retool azzerato come debito tecnico risolto fuori dal matching
- documentato caso match più specifico come policy non bloccante invariata
- documentata responsabilità canonica del documento nel modello post Pacchetto B
- chiarito che State, Roadmap e Gap Register richiamano il Match Engine senza duplicarne il dettaglio tecnico completo
- aggiunti richiami canonici ai documenti tecnici collegati

Q (Qualità): 9.5/10  
- logica matching ora più coerente  
- ridotta duplicazione tra state / select / preview / confirm  
- preview non è più fonte decisionale matching  
- controllo manuale utente preservato  
- nessuna automazione decisionale aggressiva  
- nessuna anticipazione data structure / KPI / output  
- limiti futuri chiari  
- chiarita separazione tra match, suggestion e salvataggio
- mantenuto il match engine non decisionale
- ridotto rischio di confondere no-match con errore bloccante
- preservata coerenza con Core Event System incrementale
- Command Intent integrato come layer separato e non concorrente al matching
- evitata duplicazione tra match engine e command intent
- chiarito che la rilevazione “elemento già presente” da command è una guardia UI, non deduplicazione strutturale
- mantenuto il principio select = decisione finale per gli eventi ordinari
- mantenuta separazione tra matching e visibility/readiness UI
- evitata confusione tra aggregatore Hidden e Match Engine
- confermato che UI Readiness non modifica la logica matching
- confermato che il Match Engine resta fonte minima project/entity per eventi ordinari
- input_analysis_result documentato come layer compositivo, non come nuovo motore matching
- preservata separazione tra matching, selection, suggestion, command e UI readiness
- evitata confusione tra raw match e dato effettivamente usabile nel flow corrente
- mantenuto il principio select = decisione finale salvabile
- confermato che la Visibility Migration non ha alterato la responsabilità del Match Engine
- confermato che project_state / entity_state restano fonte minima matching
- confermato che input_analysis_result compone raw / selection / effective senza calcolare matches
- chiarita separazione tra visibility del flow input e matching project/entity
- chiarita separazione tra button_input_confirm.Hidden e confirm guard funzionale
- confermato che la policy match più specifici resta informativa e non bloccante
- confermato che il nodo linting ha ridotto rumore tecnico senza modificare logica matching
- rafforzato il ruolo del documento come fonte madre del matching
- ridotto rischio di ricalcolo futuro delle decisioni consolidate sul matching
- chiariti i confini tra Match Engine e documenti canonici collegati

D (Deployabilità): 10/10  
- direttamente utilizzabile come riferimento runtime  
- allineato a implementazione Retool reale  
- create flow validato  
- edit flow validato  
- DB invariato  
- parser invariato  
- type classification invariata  
- duration normalization invariata 
- Project / Entity Create Suggestion validato runtime
- flow combinato project + entity validato
- no-match generico salvabile validato
- edit/no-op non regressivo validato dopo create suggestion
- Command Intent — Create Project / Entity validato runtime
- evento ordinario non regressivo dopo Command Intent validato
- edit flow non regressivo dopo Command Intent validato
- comandi puri create project/entity esclusi dal save flow evento
- command_intent_state validato come helper separato dal matching
- UI Readiness / Visibility Aggregator validato come layer separato dal matching
- test obbligatori 1–16 post UI Readiness superati senza regressione matching
- create flow non regressivo dopo UI Readiness validato
- edit flow non regressivo dopo UI Readiness validato
- suggestion project/entity non regressiva dopo UI Readiness validata
- DB invariato
- matching invariato
- Preview Analysis State validato senza regressione matching
- Input Analysis Result Read-only Diagnostic validato senza regressione matching
- Controlled UI Consumption Pass validato senza regressione matching
- project_state / entity_state invariati
- select_project / select_entity invariati
- create_suggestion_state invariato
- command_intent_state invariato
- button_input_confirm payload invariato
- Visibility Migration Completion validata senza regressione matching
- project_state invariato
- entity_state invariato
- select_project invariato
- select_entity invariato
- create_suggestion_state invariato nella logica funzionale
- command_intent_state invariato nella logica funzionale
- button_input_confirm.Hidden migrato senza modificare Disabled / payload
- Linting / Retool Query Safety Pass validato senza regressione matching
- linting Retool azzerati
- typing_state eliminato senza impatto matching
- handle_event_success eliminato senza impatto matching
- documento coerente con la Documentation Architecture Audit / Redundancy Reduction
- pronto come fonte canonica per future sessioni su matching project/entity

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il comportamento reale del sistema di matching
tra input utente e dati esistenti.

Il documento guida:

- suggerimenti automatici
- selezione project/entity
- gestione ambiguità
- comportamento runtime coerente
- identificazione debiti strutturali del matching
- rapporto tra matching e create suggestion
- distinzione tra match, suggestion, select e insert
- distinzione tra match engine, create suggestion e command intent
- rapporto tra project_state/entity_state e command_intent_state
- limiti del command intent rispetto al matching
- rapporto tra Match Engine e UI Readiness / Visibility Aggregator
- distinzione tra project_state/entity_state e ui_visibility_state
- chiarimento che ui_visibility_state non è fonte matching
- chiarimento che ui_visibility_mode non è Match Engine
- rapporto tra Match Engine e preview_analysis_state
- rapporto tra Match Engine e input_analysis_result
- chiarimento che input_analysis_result non è Match Engine
- chiarimento che input_analysis_result compone raw / selection / effective state ma non calcola matches
- chiarimento che il Controlled UI Consumption Pass non ha modificato il matching
- chiarimento che Input Analysis Result — Visibility Migration Completion non ha modificato il matching
- chiarimento che la migrazione degli Hidden principali a input_analysis_result non modifica project_state / entity_state
- chiarimento che button_input_confirm.Hidden migrato non modifica confirm guard funzionale
- chiarimento che Linting / Retool Query Safety Pass non modifica il Match Engine
- chiarimento che la policy match più specifici resta invariata

------------------------------------------------
RESPONSABILITÀ CANONICA DEL DOCUMENTO
------------------------------------------------

Questo documento è fonte canonica per:

- Match Engine project/entity
- project_state
- entity_state
- matches / count / hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches
- priority match minimo
- auto-select tramite singleMatch
- gestione ambiguità project/entity
- confirm guard collegata ad ambiguità non risolta
- policy match più specifici
- rapporto tra matching e select_project / select_entity
- rapporto tra matching e create_suggestion_state
- rapporto tra matching e Command Intent
- rapporto tra matching e input_analysis_result
- limiti futuri del Match Engine

Questo documento NON è fonte canonica completa per:

- input flow / parser / normalization
- Command Intent nel dettaglio runtime completo
- create_suggestion_state nel dettaglio input completo
- componenti / query / Hidden Retool completi
- Sintesi / preview / hint / warning completi
- lifecycle evento completo
- schema DB completo
- runtime Retool as-is completo
- runtime Supabase as-is completo

Fonti canoniche collegate:

- 01_LOGOS_Input_System per input flow, parser, normalization, Command Intent nel contesto input, create_suggestion_state e input_analysis_result.
- 03_LOGOS_Event_Lifecycle per lifecycle evento, edit, no-op, cancel, NEW / WRITTEN / ERROR e processing.
- 04_LOGOS_Retool_Architecture per componenti, query, Hidden, select e wiring Retool.
- 05_LOGOS_Database_Schema per schema DB, tabelle, campi e vincoli.
- 06_LOGOS_View_Preview_System per Sintesi, preview, hint, warning, highlight e label visuali.
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is.
- LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase / storage passivo.

Nota post Pacchetto B:

State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo del Match Engine.
Il dettaglio completo resta in questo documento e nei documenti canonici collegati.

------------------------------------------------
PRINCIPI FONDANTI
------------------------------------------------

1. SUGGERIRE ≠ DECIDERE

Il sistema suggerisce, non impone.

---

2. MATCH SOLO SE AFFIDABILE

Auto-selezione solo con certezza reale.

---

3. NO ASSUNZIONI

Nessuna inferenza implicita.

---

4. UTENTE IN CONTROLLO

La selezione finale è sempre manuale.

---

5. RIDUZIONE RUMORE

Il matching deve evitare falsi positivi.

---

6. MATCHING ≠ NORMALIZATION

Il matching non normalizza amount/unit/date.

La normalizzazione base è gestita dal layer input/parser:

parse_input_controlled
→ ui_state.parsed

Il matching resta dedicato a:

- project
- entity
- ambiguità
- suggerimenti

---

7. MATCHING ≠ CREAZIONE

Il matching non crea project/entity.

La creazione guidata è gestita dal layer successivo:

create_suggestion_state
→ container suggestion
→ conferma utente
→ insert_project / insert_entity

Il matching alimenta la suggestion,
ma non scrive dati nel DB.

---

8. SELECT = DECISIONE UTENTE

La select resta la decisione finale salvabile.

select_project.value → events.project_id
select_entity.value → events.entity_id

La selezione manuale è valida anche se il valore selezionato
non è presente nel raw_input.

---

9. MATCHING ≠ COMMAND INTENT

Il Match Engine riconosce project/entity dentro input evento ordinario.

Il Command Intent riconosce comandi strutturali puri.

Esempi command intent:

- crea
- crea progetto
- crea progetto Villa Nuova
- crea entità Patrizio
- modifica evento

Regole:

- command_intent_state NON è il Match Engine
- command_intent_state NON sostituisce project_state / entity_state
- command_intent_state NON sostituisce create_suggestion_state
- command_intent_state NON salva eventi
- command_intent_state NON decide project_id/entity_id negli eventi ordinari
- command_intent_state può verificare se un project/entity esiste già
- la verifica “elemento già presente” è una guardia UI, non deduplicazione strutturale DB
- i comandi puri vengono esclusi dal save flow evento
- select_project / select_entity restano la decisione finale salvabile per eventi ordinari

10. MATCHING ≠ UI READINESS / VISIBILITY

Il Match Engine calcola project/entity matching per eventi ordinari.

UI Readiness / Visibility Aggregator governa solo la visibilità del flow input.

Componenti UI Readiness:

- ui_visibility_mode
- input_analysis_result
- ui_visibility_state residuo tecnico deprecabile

Regole:

- input_analysis_result può leggere project_state / entity_state
- input_analysis_result può leggere select_project / select_entity
- input_analysis_result può usare isAmbiguous / select valorizzate per calcolare readiness/effective usability
- input_analysis_result NON calcola matches
- input_analysis_result NON calcola count
- input_analysis_result NON calcola singleMatch
- input_analysis_result NON calcola moreSpecificMatches
- input_analysis_result NON sostituisce project_state
- input_analysis_result NON sostituisce entity_state
- input_analysis_result NON modifica select_project / select_entity
- input_analysis_result NON modifica button_input_confirm payload
- input_analysis_result NON modifica confirm guard funzionale
- input_analysis_result NON salva dati
- input_analysis_result NON scrive DB
- ui_visibility_state non è più fonte degli Hidden principali del flow input
- ui_visibility_state non è più letto da input_analysis_result
- ui_visibility_state resta residuo tecnico deprecabile

ui_visibility_mode distingue solo:

- empty
- event
- command

Non riconosce project/entity.
Non è Match Engine.
Non è Input Analysis Model completo.

11. MATCHING ≠ INPUT_ANALYSIS_RESULT

input_analysis_result non è il Match Engine.

Il Match Engine resta composto da:

- project_state
- entity_state

input_analysis_result può leggere:

- project_state.data
- entity_state.data
- select_project.value
- select_entity.value
- create_suggestion_state.data
- command_intent_state.data
- preview_analysis_state.value

ma non calcola:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

input_analysis_result distingue:

- raw match:
  risultato tecnico di project_state / entity_state

- selection:
  valore attuale delle select

- effective usability:
  se quel match/valore è realmente utilizzabile nel flow corrente

Esempi:

- in event flow, project/entity raw possono diventare usable se coerenti
- in command flow, project/entity raw possono esistere ma vengono ignorati come dati evento
- in edit mode, command raw può essere true ma command effective viene soppresso

Regole:

- input_analysis_result NON modifica project_state
- input_analysis_result NON modifica entity_state
- input_analysis_result NON modifica select_project / select_entity
- input_analysis_result NON crea project/entity
- input_analysis_result NON modifica create_suggestion_state
- input_analysis_result NON modifica command_intent_state
- input_analysis_result NON modifica button_input_confirm payload
- input_analysis_result NON salva dati
- input_analysis_result NON scrive DB

Il suo ruolo è compositivo/readiness UI,
non matching.

Nota post Visibility Migration Completion:

input_analysis_result governa ora anche gli Hidden principali del flow input.

Questo non cambia il suo rapporto con il Match Engine.

input_analysis_result continua a:

- leggere project_state / entity_state
- leggere select_project / select_entity
- comporre raw / selection / effective usability
- distinguere event / command / edit flow
- governare visibility/readiness UI

ma continua a NON:

- calcolare matches
- selezionare project/entity
- modificare project_state / entity_state
- modificare select_project / select_entity
- cambiare confirm guard funzionale
- costruire payload
- salvare dati

button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm.

button_input_confirm.Disabled resta separato e continua a leggere ambiguità/select secondo la guard funzionale esistente.

------------------------------------------------
ENTITÀ COINVOLTE
------------------------------------------------

PROJECT:

- projects_list
- struttura: {id, name}

---

ENTITY:

- entities_list
- struttura: {id, name}

------------------------------------------------
POSIZIONE NEL RUNTIME ATTUALE
------------------------------------------------

Il matching opera dentro il seguente flow:

input_home  
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
→ preview / hint / highlight / suggestion container / Dati evento / Confirm Hidden  
→ select_project / select_entity  
→ button_input_confirm oppure command action  

---

Dopo lo STEP 6.4 — MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL:

- amount / unit / event_date restano gestiti da ui_state.parsed
- type resta gestito da select1.value
- project/entity matching è calcolato da project_state / entity_state
- select_project / select_entity leggono singleMatch
- preview hint legge count / isAmbiguous
- preview highlight legge matches
- confirm guard legge ambiguità non risolta

Nota:

Il matching lavora sul testo input_raw,
non sui valori numerici normalizzati.

ui_state.parsed NON è stato esteso a project/entity.
Il matching resta un layer separato.

Dopo PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL:

- create_suggestion_state consuma project_state / entity_state
- no-match project/entity può generare suggestion controllata
- project/entity possono essere creati inline solo previa conferma utente
- insert_project / insert_entity non sono parte del matching
- evento non viene salvato automaticamente dopo creazione project/entity
- select_project / select_entity restano fonte finale salvabile

Dopo COMMAND INTENT — CREATE PROJECT / ENTITY:

- command_intent_state riconosce comandi puri
- command_intent_state resta separato dal Match Engine
- command_intent_state non calcola il match primario project/entity per gli eventi
- command_intent_state può rilevare project/entity già esistenti per evitare duplicazioni da command
- container_command_intent sostituisce Sintesi evento / Dati evento quando l’input è comando puro
- i comandi puri non vengono salvati come eventi
- insert_project / insert_entity vengono usati solo dopo conferma utente
- button_input_confirm resta dedicato agli eventi ordinari

Dopo UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL:

- ui_visibility_mode distingue empty / event / command a livello UI
- ui_visibility_state aggrega la visibilità del flow input
- ui_visibility_state può leggere project_state / entity_state per capire se esistono ambiguità non risolte
- ui_visibility_state governa la visibilità di suggestion, Dati evento, Conferma e container command
- ui_visibility_state non modifica project_state / entity_state
- ui_visibility_state non modifica create_suggestion_state
- ui_visibility_state non modifica select_project / select_entity
- ui_visibility_state non modifica il Match Engine
- il Match Engine resta fonte minima project/entity per eventi ordinari

Dopo PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER:

- preview_analysis_state raccoglie hint/status/warning/Da verificare/associazioni mancanti della Sintesi
- preview_analysis_state può leggere stati derivati da project_state / entity_state
- preview_analysis_state non modifica project_state / entity_state
- preview_analysis_state non calcola matching
- preview_analysis_state non seleziona project/entity
- preview_analysis_state non modifica confirm guard o payload

Dopo INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS:

- input_analysis_result legge project_state / entity_state come raw match source
- input_analysis_result legge select_project / select_entity come selection source
- input_analysis_result calcola project/entity effective usability
- input_analysis_result distingue event / command / edit flow
- input_analysis_result può ignorare project/entity raw in command flow
- input_analysis_result può sopprimere command effective in edit mode
- input_analysis_result governa parte della UI/readiness
- input_analysis_result non modifica il Match Engine
- input_analysis_result non modifica project_state / entity_state
- input_analysis_result non modifica select_project / select_entity
- input_analysis_result non modifica create_suggestion_state
- input_analysis_result non modifica command_intent_state
- input_analysis_result non modifica button_input_confirm payload
- input_analysis_result non salva dati

Dopo INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION:

- input_analysis_result governa gli Hidden principali del flow input
- container_input.Hidden legge input_analysis_result
- text_input_analysis_loading.Hidden legge input_analysis_result
- btn_cancel_edit.Hidden legge input_analysis_result
- btn_cancel_input_home.Hidden legge input_analysis_result
- button_input_confirm.Hidden legge input_analysis_result.readiness.canShowConfirm
- canShowConfirm governa solo la visibilità del bottone Conferma
- button_input_confirm.Disabled resta guard funzionale separata
- button_input_confirm payload resta invariato
- input_analysis_result non legge più ui_visibility_state
- ui_visibility_state resta residuo tecnico deprecabile
- Match Engine invariato
- project_state / entity_state invariati
- select_project / select_entity invariati
- create_suggestion_state invariato nella logica funzionale
- command_intent_state invariato nella logica funzionale

Dopo LINTING / RETOOL QUERY SAFETY PASS:

- linting Retool azzerati
- typing_state eliminato come query legacy unused
- handle_event_success eliminato come query legacy unused
- nessuna modifica a project_state / entity_state
- nessuna modifica a select_project / select_entity
- nessuna modifica al Match Engine

------------------------------------------------
PIPELINE MATCH
------------------------------------------------

Pipeline match attuale post INPUT ANALYSIS RESULT VISIBILITY MIGRATION COMPLETION:

input_raw  
→ project_state / entity_state  
→ matches / count / isAmbiguous / singleMatch  
→ create_suggestion_state  
→ select_project / select_entity  
→ preview_analysis_state legge stato matching per hint/status preview  
→ input_analysis_result legge raw match + selection + effective usability  
→ preview hint / highlight / suggestion container / Dati evento / Confirm Hidden  
→ button_input_confirm guard funzionale separata  
→ project_id / entity_id salvati solo se selezionati      

Pipeline command separata:

input_raw  
→ command_intent_state  
→ container_command_intent  
→ btn_command_create_project / btn_command_create_entity / btn_command_go_events  
→ insert_project / insert_entity oppure Lista eventi  

Nota:

questa pipeline NON è Match Engine.

Serve a intercettare comandi puri prima che vengano trattati come eventi.

---

Fonte minima osservabile:

project_state  
entity_state  

---

Output standard di project_state / entity_state:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

Principio:

project_state / entity_state calcolano il matching.

create_suggestion_state legge il risultato del matching
e genera eventuali suggestion controllate.

create_suggestion_state NON calcola il match primario.
create_suggestion_state NON salva dati.
create_suggestion_state NON decide project/entity al posto dell’utente.

select_project / select_entity NON ricalcolano più il matching.
Leggono singleMatch.

preview NON usa più detection locale come fonte decisionale.
Legge matches / count / isAmbiguous.

button_input_confirm NON valuta più direttamente array matches in modo fragile.
Legge ambiguità non risolta.

command_intent_state NON modifica questa regola.

ui_visibility_state NON modifica questa regola ed è ora residuo tecnico deprecabile.

preview_analysis_state NON modifica questa regola.

input_analysis_result NON modifica questa regola.

Visibility Migration Completion NON modifica questa regola.

Il fatto che input_analysis_result governi più Hidden UI non lo rende Match Engine.

input_analysis_result può comporre lo stato effettivo del flow,
ma non cambia la fonte minima matching:

- project_state
- entity_state

e non cambia le fonti salvabili:

- select_project.value
- select_entity.value

UI Readiness può decidere se mostrare o nascondere componenti,
ma non cambia la fonte matching e non decide project/entity.

Per gli eventi ordinari:

- project_state resta fonte minima matching project
- entity_state resta fonte minima matching entity
- select_project / select_entity restano fonti salvabili
- button_input_confirm resta il punto di conferma evento

Per i comandi puri:

- il flow evento viene escluso
- container_command_intent usa azioni command dedicate
- nessun project_id/entity_id viene salvato in events

------------------------------------------------
NORMALIZZAZIONE MATCHING
------------------------------------------------

La normalizzazione testuale del matching è ora concentrata nei due state:

- project_state
- entity_state

Operazioni comuni:

- lowercase
- trim
- compressione spazi
- split parole significative
- full name match
- confronto su parole
- riduzione match generici coperti da match più specifici

---

Distinzione importante:

NORMALIZATION LAYER BASE:

- amount
- unit
- event_date
- duration normalization

Fonte:
parse_input_controlled → ui_state.parsed

MATCH NORMALIZATION:

- testi project/entity
- nomi
- token
- ambiguità
- singleMatch
- moreSpecificMatches

Fonte:
input_raw → project_state / entity_state

---

Regola:

il matching può leggere input_raw perché project/entity sono contenuti nel testo libero.

input_raw NON torna fonte di verità per amount/unit/event_date.

ui_state.parsed resta fonte unica per i dati parsati strutturati.

------------------------------------------------
PROJECT MATCH ATTUALE
------------------------------------------------

Fonte:

project_state

Input:

- input_raw.value
- projects_list.data

Output:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

LOGICA:

1. Normalizzazione testo

- lowercase
- trim
- compressione spazi

2. Match base

- confronto su parole significative del nome progetto
- parole del progetto devono essere presenti nel testo input
- gestione numeri nei nomi progetto

3. Gestione numeri

Se il progetto contiene numeri,
gli stessi numeri devono essere presenti nell’input.

Esempio:

Villa 2
→ richiede presenza di 2 nell’input

Questo evita che:

villa
→ selezioni Villa 2

ma consente:

villa 2
→ selezioni Villa 2

4. Full name match

Se il nome completo del progetto è presente nel testo,
viene considerato match forte.

5. Priority match minimo

Se esistono match generici e match più specifici,
vengono rimossi i generici coperti dallo specifico.

Esempi:

Ristrutturazione + Ristrutturazione Bagno
→ Ristrutturazione Bagno

Casa + Casa Mare
→ Casa Mare

Villa + Villa 2
→ Villa 2

6. More specific hint

Se il match esatto breve è valido,
ma esistono progetti più specifici,
il sistema mantiene il match e mostra hint informativo non bloccante.

Esempio:

villa
→ select_project = Villa
→ hint: Esistono progetti più specifici

---

COMPORTAMENTO:

count = 1  
→ singleMatch valorizzato  
→ select_project auto-valorizzato  

count > 1  
→ isAmbiguous = true  
→ select_project vuoto  
→ hint rosso se non risolto  
→ confirm disabilitato finché l’utente non sceglie  

count = 0  
→ nessun suggerimento  
→ select_project vuoto  
→ confirm non bloccato  

---

NOTE:

- project_id viene salvato solo da select_project.value
- project_state non crea project automaticamente
- eventuale creazione project è gestita da create_suggestion_state + insert_project
- eventuale creazione project da comando puro è gestita da command_intent_state + btn_command_create_project + insert_project
- il command intent non modifica il comportamento di project_state
- la creazione project richiede conferma esplicita utente
- il sistema non decide project in caso di ambiguità non risolta
- la scelta manuale utente prevale

------------------------------------------------
ENTITY MATCH ATTUALE
------------------------------------------------

Fonte:

entity_state

Input:

- input_raw.value
- entities_list.data

Output:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

LOGICA:

1. Normalizzazione testo

- lowercase
- trim
- compressione spazi

2. Match base

- confronto su parole significative del nome entità
- parole dell’entità devono essere presenti nel testo input

3. Full name match

Se il nome completo dell’entità è presente nel testo,
viene considerato match forte.

4. Priority match minimo

Se esistono match generici e match più specifici,
vengono rimossi i generici coperti dallo specifico.

Esempi:

Marco + Marco Rossi
→ Marco Rossi

Mario + Mario Rossi
→ Mario Rossi

Mario Rossi + Mario Rossi Alfredo
→ Mario Rossi Alfredo, quando il nome completo è presente

5. More specific hint

Se il match esatto breve è valido,
ma esistono entità più specifiche,
il sistema mantiene il match e mostra hint informativo non bloccante.

Esempi:

mario
→ select_entity = Mario
→ hint: Esistono entità più specifiche

mario rossi
→ select_entity = Mario Rossi
→ hint: Esistono entità più specifiche se esiste Mario Rossi Alfredo

mario rossi alfredo
→ select_entity = Mario Rossi Alfredo
→ nessun hint più specifico

---

COMPORTAMENTO:

count = 1  
→ singleMatch valorizzato  
→ select_entity auto-valorizzato  

count > 1  
→ isAmbiguous = true  
→ select_entity vuoto  
→ hint rosso se non risolto  
→ confirm disabilitato finché l’utente non sceglie  

count = 0  
→ nessun suggerimento  
→ select_entity vuoto  
→ confirm non bloccato  

---

NOTE:

- entity_id viene salvato solo da select_entity.value
- entity_state non crea entity automaticamente
- eventuale creazione entity è gestita da create_suggestion_state + insert_entity
- eventuale creazione entity da comando puro è gestita da command_intent_state + btn_command_create_entity + insert_entity
- il command intent non modifica il comportamento di entity_state
- la creazione entity richiede conferma esplicita utente
- il sistema non decide entity in caso di ambiguità non risolta
- la scelta manuale utente prevale
- la presenza di duplicati o entità simili resta un limite strutturale

---

RELAZIONE CON CREATE SUGGESTION:

Se project_state rileva un match base valido e create_suggestion_state
individua una possibile estensione non ancora presente,
il sistema può proporre la creazione di un nuovo project.

Esempio:

input:
villa sierri 15 sopralluogo

project_state:
singleMatch = Villa

create_suggestion_state:
candidateName = Villa Sierri 15

Azione utente:
Crea progetto → insert_project → select_project = Villa Sierri 15

Nota:

questo non modifica la regola del matching.
Villa resta match base reale.
Villa Sierri 15 è una suggestion di creazione controllata.

------------------------------------------------
AUTO-SELECT LOGIC
------------------------------------------------

Auto-select SOLO tramite:

project_state.data.singleMatch  
entity_state.data.singleMatch  

Nota post UI Readiness:

ui_visibility_state non partecipa all’auto-select.
input_analysis_result non partecipa all’auto-select.

Non può valorizzare:

- select_project
- select_entity

La selezione automatica resta limitata a singleMatch.

Nota post Input Analysis Result:

input_analysis_result non partecipa all’auto-select.

Non può valorizzare:

- select_project
- select_entity

Non può sostituire:

- project_state.data.singleMatch
- entity_state.data.singleMatch

La selezione automatica resta limitata a singleMatch prodotto da project_state / entity_state.

Nota post Visibility Migration Completion:

la migrazione degli Hidden principali a input_analysis_result non cambia l’auto-select.

select_project / select_entity restano alimentate da singleMatch.

---

select_project:

legge project_state.data.singleMatch

Se singleMatch esiste:
→ select_project = singleMatch.id

Altrimenti:
→ select_project = null

---

select_entity:

legge entity_state.data.singleMatch

Se singleMatch esiste:
→ select_entity = singleMatch.id

Altrimenti:
→ select_entity = null

---

NON auto-select se:

- isAmbiguous = true
- count > 1
- nessun match
- valore manuale già scelto dall’utente in caso di ambiguità risolta

---

Regola:

il match engine suggerisce.
La select è la fonte finale salvabile.
L’utente mantiene controllo.

------------------------------------------------
GESTIONE AMBIGUITÀ
------------------------------------------------

Ambiguità calcolata da:

project_state.data.isAmbiguous  
entity_state.data.isAmbiguous  

---

CASO 1 — Ambiguità non risolta

Condizione:

project_state.isAmbiguous = true
e select_project vuoto

oppure:

entity_state.isAmbiguous = true
e select_entity vuoto

Comportamento:

- mostra hint rosso
- non auto-seleziona
- button_input_confirm disabilitato

---

CASO 2 — Ambiguità risolta manualmente

Condizione:

project_state.isAmbiguous = true
ma select_project valorizzato manualmente

oppure:

entity_state.isAmbiguous = true
ma select_entity valorizzato manualmente

Comportamento:

- hint rosso rimosso
- button_input_confirm abilitato
- valore scelto dall’utente viene salvato

---

CASO 3 — Nessun match

Condizione:

count = 0

Comportamento:

- nessun hint ambiguità
- select vuota
- confirm non bloccato

Motivo:

LOGOS deve restare non bloccante.

Dopo Project / Entity Create Suggestion First Controlled Level,
il nessun match può generare una suggestion controllata,
ma non blocca il salvataggio.

L’utente può:

- creare project/entity inline
- ignorare la suggestion
- salvare evento con project_id/entity_id null

---

Confirm guard finale:

Conferma disabilitata se:

- input vuoto
- project ambiguo e select_project vuoto
- entity ambigua e select_entity vuoto

Conferma abilitata se:

- match univoco
- nessun match
- ambiguità risolta manualmente

---

Regola post create suggestion:

project/entity mancanti ≠ blocco.

project/entity ambigui = blocco finché non risolti manualmente.

La suggestion non cambia il confirm guard:
lo arricchisce solo con un percorso guidato opzionale.

Il command intent non cambia il confirm guard degli eventi ordinari.

Nota post UI Readiness:

input_analysis_result può leggere lo stato di ambiguità per decidere readiness/visibility di:

- suggestion container
- Dati evento
- Conferma Hidden

ma non modifica la regola di ambiguità.

Il blocco funzionale resta:

- project ambiguo + select_project vuoto
- entity ambigua + select_entity vuoto

input_analysis_result non risolve ambiguità.
input_analysis_result non seleziona project/entity.
input_analysis_result non cambia il confirm guard logico.

ui_visibility_state resta residuo tecnico deprecabile e non è fonte matching.

Nota post Input Analysis Result:

input_analysis_result può leggere ambiguità e selection per calcolare readiness/effective usability,
ma non risolve ambiguità.

input_analysis_result non seleziona project/entity.
input_analysis_result non cambia il confirm guard funzionale.
input_analysis_result non modifica button_input_confirm payload.

Dopo Visibility Migration Completion:

button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm.

Questo non modifica la guard funzionale Disabled.

La regola di blocco resta:

- project ambiguo + select_project vuoto
- entity ambigua + select_entity vuoto

Il blocco funzionale resta:

- project ambiguo + select_project vuoto
- entity ambigua + select_entity vuoto

In command flow, eventuali raw match project/entity possono essere presenti,
ma non vengono considerati dati evento usabili.

In edit flow, la regola matching resta quella degli eventi ordinari,
mentre command intent viene soppresso a livello effective.

Se l’input è comando puro:

- il confirm guard evento non viene usato
- button_input_confirm non deve essere mostrato
- container_command_intent gestisce la guida o l’azione controllata

------------------------------------------------
HINT SYSTEM
------------------------------------------------

Per il matching project/entity,
gli hint sono ora alimentati da project_state / entity_state.

---

HINT AMBIGUITÀ:

entity_state.isAmbiguous = true
e select_entity vuoto
→ "Più entità trovate"

project_state.isAmbiguous = true
e select_project vuoto
→ "Più progetti trovati"

---

HINT MATCH PIÙ SPECIFICI:

entity_state.hasMoreSpecificMatches = true
e singleMatch selezionato
→ "Esistono entità più specifiche"

project_state.hasMoreSpecificMatches = true
e singleMatch selezionato
→ "Esistono progetti più specifici"

---

Caratteristiche:

- hint ambiguità = bloccante finché non risolto
- hint match più specifici = informativo non bloccante
- nessuna inferenza automatica definitiva
- controllo utente preservato

---

Nota:

gli hint matching sono ora più state-driven.

Restano embedded nella preview altri hint:

- type / Spesa / Incasso
- durata normalizzata
- durata ambigua

Questi non sono stati separati in un hint engine globale.

Nota post UI Readiness:

input_analysis_result governa la visibilità del container che ospita hint/suggestion,
ma non è un hint engine.

Non separa:

- hint matching
- hint duration/type
- warning
- “Da verificare”
- suggestion create

Dopo Preview Analysis State:

preview_analysis_state raccoglie a primo livello hint/status/warning/Da verificare/associazioni mancanti della Sintesi.

Questo riduce la logica hint embedded nella Sintesi,
ma non rende ancora la preview una view pura.

input_analysis_result legge preview_analysis_state e lo compone nella propria readiness/UI state.

Restano comunque demandati a nodi futuri:

- PREVIEW MODEL / HINT STATE CONSOLIDATION
- STATUS SEMANTICS ALIGNMENT

Nota post Visibility Migration Completion:

il caso “mario sopralluogo villa 2” conferma la policy corrente:

- match specifico/auto-selezione valida se singleMatch esiste
- warning “entità/progetti più specifici” resta informativo
- Conferma può restare attiva se esiste selezione effettiva
- il warning non è bloccante nella policy attuale

Nodo futuro eventuale:

MATCH ENGINE — MORE SPECIFIC MATCH POLICY

---

HINT / SUGGESTION DISTINCTION:

Hint informativo:

- segnala stato del match
- non apre insert
- non scrive DB

Suggestion create:

- propone azione guidata
- richiede conferma utente
- può eseguire insert_project / insert_entity
- non salva evento automaticamente

Esempio:

“Esistono progetti più specifici”
→ hint informativo

“Possibile nuovo progetto: Villa Sierri 15”
→ suggestion create

Command intent:

- riconosce comando strutturale puro
- non è un hint matching
- non è suggestion create dentro evento
- non salva evento
- può proporre creazione project/entity solo come azione command dedicata

Esempio:

“crea progetto Villa Nuova”
→ command intent
→ container_command_intent
→ btn_command_create_project
→ insert_project
→ nessun evento salvato

------------------------------------------------
RELAZIONE CON PREVIEW
------------------------------------------------

Nota canonica:

La fonte completa per Sintesi, preview, hint, warning,
highlight, label visuali e micro-copy è:

- 06_LOGOS_View_Preview_System

Questo documento conserva solo il rapporto tra Match Engine e preview:

- hint project/entity
- highlight project/entity
- ambiguità matching
- match più specifici
- separazione tra preview visuale e matching decisionale

La preview utilizza project_state / entity_state per:

- mostrare hint ambiguità
- mostrare hint match più specifici
- evidenziare project/entity
- supportare la scelta utente

---

Dopo STEP 6.4:

la preview NON usa più detection locale project/entity
come fonte decisionale matching.

Prima:

preview calcolava detectedProjects / detectedEntities
con logica token-based locale.

Dopo:

preview legge:

- project_state.data.matches
- entity_state.data.matches
- project_state.data.count
- entity_state.data.count
- project_state.data.isAmbiguous
- entity_state.data.isAmbiguous
- project_state.data.hasMoreSpecificMatches
- entity_state.data.hasMoreSpecificMatches

---

Highlight:

- project evidenziati da project_state.matches
- entity evidenziate da entity_state.matches
- nome completo evidenziato quando presente

Esempio:

villa 2 mario
→ villa 2 evidenziato come project
→ mario evidenziato come entity

---

Nota:

La preview resta layer ibrido:

- rendering
- label cleaning
- hint logic
- highlight
- formattazione visuale

Ma non è più fonte autonoma decisionale per il matching.

Dopo Command Intent:

la preview non deve rappresentare comandi puri come eventi.

Esempi:

crea progetto Villa Nuova
→ non deve mostrare Sintesi evento
→ deve mostrare container_command_intent

crea entità Patrizio
→ non deve mostrare Sintesi evento
→ deve mostrare container_command_intent

modifica evento
→ non deve mostrare Sintesi evento
→ deve mostrare guida command

Il command intent quindi riduce un caso di falsa preview evento,
ma non rende la preview un layer puro.

Dopo Input Analysis Result Controlled UI Consumption:

- la visibilità della preview è governata da input_analysis_result.readiness.canShowEventPreview
- container_command_intent è governato da input_analysis_result.readiness.canShowCommandContainer
- container_association_suggestions è governato da input_analysis_result.readiness.canShowAssociationSuggestions
- Dati evento sono governati da input_analysis_result.readiness.canShowEventData
- button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm
- button_input_confirm.Disabled resta guard funzionale separata
- ui_visibility_state resta residuo tecnico deprecabile

Nota:

questo non modifica il matching.

La preview continua a leggere project_state / entity_state per hint e highlight.
input_analysis_result decide ora parte della visibility/readiness UI.

ui_visibility_state non governa più gli Hidden principali migrati.

Nessuno dei due modifica il matching.

La Visibility Migration Completion non modifica il contenuto della preview,
ma stabilizza quando i blocchi del flow input vengono mostrati.

Residuo osservato ma fuori Match Engine:

- label “Importo” ancora usata per valori durata

Nodo futuro:

PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT

------------------------------------------------
RELAZIONE CON CREATE SUGGESTION
------------------------------------------------

create_suggestion_state è un layer successivo al matching.

Consuma:

- input_raw.value
- project_state.data
- entity_state.data
- projects_list.data
- entities_list.data
- select_project.value
- select_entity.value

Produce:

- project.noMatch
- project.shouldShowNoMatchHint
- project.shouldSuggestCreate
- project.candidateName
- project.draftName
- entity.noMatch
- entity.shouldShowNoMatchHint
- entity.shouldSuggestCreate
- entity.candidateName
- entity.draftName

Non produce:

- project_id salvabile direttamente
- entity_id salvabile direttamente
- amount
- unit
- event_date
- type

Regole:

- suggestion ≠ match
- suggestion ≠ decisione
- suggestion ≠ salvataggio evento
- suggestion ignorata non blocca conferma
- creazione project/entity richiede conferma utente
- evento resta non salvato dopo creazione project/entity

---

PROJECT CREATE SUGGESTION

Attiva quando:

- esiste una candidate controllata
- non c’è ambiguità project
- la candidate non esiste già
- l’utente conferma la creazione

Esempio:

villa sierri 15 sopralluogo
→ candidate project: Villa Sierri 15

---

ENTITY CREATE SUGGESTION

Attiva quando:

- entity no-match reale
- entity non ambigua
- nessuna entity già selezionata
- l’utente conferma la creazione

Entity autofill controlled minimal:

- solo su prefissi forti
- non crea entity automaticamente
- non seleziona entity automaticamente
- precompila solo input_new_entity_name

Esempio:

referente kappa
→ draft entity: Referente Kappa

---

AMBIGUITÀ E CREATE SUGGESTION

Se project/entity è ambiguo:

- create suggestion non viene mostrata per quel layer
- Conferma resta disabilitata finché l’utente non sceglie manualmente

Dopo Input Analysis Result Controlled UI Consumption:

container_association_suggestions è ora visibile/nascosto tramite:

input_analysis_result.readiness.canShowAssociationSuggestions.

Dopo Visibility Migration Completion:

questa relazione resta invariata.

input_analysis_result governa la visibility del container,
ma create_suggestion_state resta fonte del contenuto operativo.

La migrazione visibility non modifica le regole suggestion.

Questo non modifica create_suggestion_state.

create_suggestion_state resta il layer che consuma il matching
e propone eventuale creazione controllata.

Regola consolidata:

missing association notice
≠
suggestion operativa

input_analysis_result può governare la visibilità del container,
ma non deve inventare contenuti se create_suggestion_state non li produce.

Il container non deve apparire vuoto.
------------------------------------------------
RELAZIONE CON COMMAND INTENT
------------------------------------------------

command_intent_state è un layer separato dal Match Engine
e da create_suggestion_state.

Consuma:

- input_raw.value / input_home.value
- projects_list.data
- entities_list.data

Produce:

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

Non produce:

- matches
- count
- isAmbiguous
- singleMatch
- moreSpecificMatches
- project_id salvabile per events
- entity_id salvabile per events
- amount
- unit
- event_date
- type

Regole:

- command intent ≠ match
- command intent ≠ suggestion create da evento
- command intent ≠ salvataggio evento
- command intent ≠ select decision
- command intent ≠ deduplicazione strutturale
- command intent intercetta comandi puri
- command intent può bloccare creazioni duplicate da command se riconosce elemento già esistente

Esempio evento ordinario con suggestion:

30 euro spesa villa nuova
→ project_state/entity_state
→ create_suggestion_state
→ suggestion create eventuale
→ Conferma evento manuale

Esempio comando puro:

crea progetto Villa Nuova
→ command_intent_state
→ container_command_intent
→ btn_command_create_project
→ insert_project
→ nessun evento salvato

Esempio elemento già presente:

crea progetto villa
→ command_intent_state
→ Elemento già presente
→ nessun bottone crea
→ nessuna duplicazione
→ nessun evento salvato

Nota:

command_intent_state può controllare l’esistenza di un project/entity,
ma questa verifica non sostituisce deduplicazione avanzata,
alias, fuzzy matching o vincoli DB.

------------------------------------------------
RELAZIONE CON UI READINESS / INPUT ANALYSIS RESULT
------------------------------------------------

Nota canonica:

La fonte completa per input_analysis_result nel contesto input è:

- 01_LOGOS_Input_System

La fonte completa per componenti, Hidden e wiring Retool è:

- 04_LOGOS_Retool_Architecture

Questo documento documenta solo il confine con il Match Engine:

- input_analysis_result può leggere project_state / entity_state
- input_analysis_result può comporre raw / selection / effective usability
- input_analysis_result non calcola matching
- input_analysis_result non modifica select_project / select_entity
- input_analysis_result non modifica button_input_confirm payload

UI Readiness / Input Analysis Result è una linea separata dal Match Engine.

Componenti:

- ui_visibility_mode
- preview_analysis_state
- input_analysis_result
- ui_visibility_state residuo tecnico deprecabile

---

ui_visibility_mode:

- distingue empty / event / command
- non legge project_state / entity_state come fonte matching
- non calcola project/entity
- non decide ambiguità
- non decide select
- non salva dati

---

ui_visibility_state:

- era aggregatore di visibilità del flow input
- dopo Visibility Migration Completion non è più letto da input_analysis_result
- non governa più gli Hidden principali migrati
- resta residuo tecnico deprecabile / rollback
- non è fonte matching
- non decide project/entity
- non salva dati

Non produce:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches
- project_id
- entity_id

Non modifica:

- project_state
- entity_state
- create_suggestion_state
- command_intent_state
- select_project
- select_entity
- button_input_confirm payload
- insert_event / update_event
- insert_project / insert_entity

Regola:

il Match Engine resta la fonte minima per project/entity matching.

preview_analysis_state:

- legge stati utili a costruire hint/status preview
- può leggere indirettamente informazioni derivate da project_state / entity_state
- non calcola matches
- non calcola singleMatch
- non seleziona project/entity
- non modifica il matching

input_analysis_result:

- legge project_state / entity_state come raw match source
- legge select_project / select_entity come selection source
- calcola effective usability
- distingue event / command / edit flow
- non calcola matches
- non calcola singleMatch
- non seleziona project/entity
- non modifica il matching
- non modifica confirm payload
- non salva dati
- governa gli Hidden principali del flow input
- espone canShowConfirm per la visibilità del bottone Conferma
- non governa Disabled come decisione funzionale finale

UI Readiness / Input Analysis Result è coordinamento visivo/compositivo,
non matching.

Visibility Migration Completion aumenta il consumo UI di input_analysis_result,
ma non cambia la responsabilità del Match Engine.

Risultato post UI Readiness:

✔ container vuoto durante digitazione risolto
✔ flow event / command più stabile
✔ suggestion container non compete più visivamente con command container
✔ Dati evento / Conferma evento più coerenti con flow event/command
✔ matching invariato

------------------------------------------------
RELAZIONE CON NORMALIZATION LAYER BASE
------------------------------------------------

Nota canonica:

La fonte completa per input flow, parser, normalization base,
duration normalization base e type classification nel contesto input è:

- 01_LOGOS_Input_System

Questo documento conserva solo il confine tra normalization e matching.

Regola:

il Match Engine non normalizza amount / unit / event_date
e non modifica ui_state.parsed.

Il Normalization Layer Base ha migliorato:

- amount
- unit
- event_date
- save flow
- insert/update
- qualità del payload DB

---

Non ha modificato:

- project matching
- entity matching
- hint matching
- auto-select
- preview detection
- priority match
- ranking

---

Effetto indiretto positivo:

poiché numeri senza unità non diventano più amount,
casi come:

villa 2 mario

mantengono meglio il valore semantico del numero nella label/preview.

Tuttavia:

- il matching resta testuale
- non usa ancora una normalizzazione unica
- non è stato rifattorizzato

------------------------------------------------
CASI NON SUPPORTATI
------------------------------------------------

- sinonimi
- errori ortografici
- abbreviazioni complesse
- fuzzy matching
- gerarchie project/entity
- relazioni entity-project
- match storico
- ranking basato su frequenza
- ranking avanzato
- disambiguazione automatica
- alias controllati
- command intent avanzato oltre create project/entity
- modifica project/entity da command
- dashboard/report intent
- Input Analysis Model completo
- decommission di ui_visibility_state
- button_input_confirm.Disabled/readiness migrato a input_analysis_result
- creazione automatica silenziosa project/entity

---

Motivo:

evitare inferenze errate
e mantenere controllo utente.

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- nessuna gerarchia entity/project
- nessun alias system
- nessun fuzzy matching
- nessun ranking avanzato
- nessuna deduplicazione entity/project
- nessuna relazione entity-project
- nessun match storico
- creazione guidata project/entity implementata solo a primo livello controllato
- command intent create project/entity implementato a primo livello controllato
- command intent avanzato non implementato
- input_analysis_result implementato come layer compositivo per Hidden principali del flow input
- Input Analysis Model completo non implementato
- ui_visibility_state ancora presente come residuo tecnico deprecabile
- ui_visibility_mode implementato solo come latch UI
- UI Readiness / Input Analysis Result non è Match Engine
- Linting / Retool Query Safety Pass completato senza modificare matching
- Full Visibility Migration degli Hidden principali completata
- button_input_confirm.Hidden migrato
- button_input_confirm.Disabled non migrato
- save readiness non centralizzata
- cleanup obsolete UI guards / query reduction non ancora eseguito
- nessuna creazione automatica silenziosa project/entity
- nessun audit trail dedicato per creazione project/entity
- nessuna deduplicazione strutturale avanzata per project/entity creati da command
- preview ancora layer ibrido
- hint duration/type ancora embedded nella preview
- match engine avanzato separato non implementato

---

Risolto a primo livello:

✔ duplicazione state / select ridotta  
✔ preview detection non più fonte decisionale  
✔ hint ambiguità matching allineati a state  
✔ priority match minimo implementato  
✔ confirm guard coerente con ambiguità non risolta  
✔ create/edit flow allineati  
✔ create_suggestion_state introdotto
✔ creazione guidata project/entity implementata a primo livello controllato
✔ no-match project/entity assistito da suggestion controllata
✔ entity autofill controlled minimal implementato
✔ command intent create project/entity implementato a primo livello controllato
✔ comandi puri esclusi dal save flow evento
✔ “crea progetto villa” riconosciuto come elemento già presente
✔ project/entity da command creati solo previa conferma utente
✔ UI Readiness / Visibility Aggregator completato senza modificare matching
✔ ui_visibility_state introdotto come aggregatore visibilità separato dal Match Engine
✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto
✔ flow event / command stabilizzato a primo livello
✔ preview_analysis_state introdotto senza modificare matching
✔ input_analysis_result introdotto senza modificare matching
✔ raw / selection / effective state introdotti
✔ Controlled UI Consumption Pass completato senza regressione matching
✔ visibility preview/data/command/suggestion migrata parzialmente a input_analysis_result
✔ Visibility Migration degli Hidden principali completata
✔ container_input.Hidden migrato a input_analysis_result
✔ text_input_analysis_loading.Hidden migrato a input_analysis_result
✔ btn_cancel_edit.Hidden migrato a input_analysis_result
✔ btn_cancel_input_home.Hidden migrato a input_analysis_result
✔ button_input_confirm.Hidden migrato a input_analysis_result
✔ input_analysis_result non legge più ui_visibility_state
✔ linting Retool azzerati senza modificare matching

------------------------------------------------
PROBLEMA STRUTTURALE CRITICO — STATO AGGIORNATO
------------------------------------------------

Prima dello STEP 6.4 esistevano 3 sistemi di matching indipendenti:

1. PROJECT_STATE / ENTITY_STATE

- calcolo matches
- non sempre live
- non pienamente usato da select / preview / confirm

2. SELECT MATCHING / DETERMINISTICO

- ricalcolava matching nel Default value
- poteva divergere da project_state/entity_state

3. PREVIEW DETECTION / TOKEN-BASED

- ricalcolava detection locale
- alimentava highlight e parte degli hint
- poteva divergere da select e state

---

Conseguenze precedenti:

- incoerenza risultati
- duplicazione logica
- difficoltà debugging
- hint non sempre coerenti
- rischio divergenza tra ciò che si vede e ciò che viene selezionato

---

STATO DOPO STEP 6.4:

✔ project_state / entity_state sono fonte minima matching  
✔ select_project / select_entity leggono singleMatch  
✔ preview hint legge isAmbiguous  
✔ preview highlight legge matches  
✔ confirm guard legge ambiguità non risolta  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ priority match minimo implementato  

---

STATO:

RISOLTO A PRIMO LIVELLO CONTROLLATO

---

Non ancora risolto:

- match engine avanzato separato
- fuzzy matching
- alias
- deduplicazione
- gerarchie
- relazioni entity-project
- input analysis model unico
- command intent avanzato oltre create project/entity
- filtro select su match ambigui
- deduplicazione avanzata project/entity

---

STATO DOPO PROJECT / ENTITY CREATE SUGGESTION:

✔ no-match project/entity può produrre suggestion controllata
✔ project/entity possono essere creati inline previa conferma
✔ select_project/select_entity vengono valorizzati dopo creazione controllata
✔ evento non viene salvato automaticamente dopo creazione project/entity
✔ salvataggio resta manuale
✔ project/entity mancanti non bloccano conferma
✔ project/entity ambigui bloccano conferma

STATO DOPO COMMAND INTENT — CREATE PROJECT / ENTITY:

✔ command_intent_state introdotto come helper separato
✔ comandi puri create project/entity intercettati
✔ comando generico “crea” guidato
✔ “modifica evento” gestito come guida non operativa
✔ comandi puri non salvano eventi
✔ project/entity da command richiedono conferma utente
✔ elemento già presente riconosciuto e non duplicato
✔ evento ordinario non regressivo validato
✔ edit flow non regressivo validato

Nota:

Command Intent non risolve il problema strutturale del match engine avanzato.
Aggiunge un layer separato per comandi puri.

STATO DOPO UI READINESS / VISIBILITY AGGREGATOR:

✔ ui_visibility_mode introdotto come latch UI empty / event / command
✔ ui_visibility_state introdotto come aggregatore read-only di visibilità
✔ ui_visibility_state può leggere project_state / entity_state
✔ ui_visibility_state non modifica il Match Engine
✔ project_state / entity_state restano fonte minima matching
✔ create_suggestion_state resta layer suggestion separato
✔ command_intent_state resta layer command separato
✔ select_project / select_entity restano fonti salvabili
✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto
✔ matching invariato

UI Readiness non risolve il problema strutturale del match engine avanzato.
Aggiunge un layer separato per visibilità/readiness UI.

STATO DOPO PREVIEW ANALYSIS STATE / INPUT ANALYSIS RESULT:

✔ preview_analysis_state introdotto come layer read-only preview/hint
✔ input_analysis_result introdotto come layer compositivo read-only
✔ raw / selection / effective state introdotti
✔ input_analysis_result legge project_state / entity_state ma non li sostituisce
✔ input_analysis_result legge select_project / select_entity ma non li valorizza
✔ input_analysis_result distingue raw match da effective usability
✔ in command flow project/entity raw non diventano dati evento usabili
✔ in edit flow command intent viene soppresso a livello effective
✔ Controlled UI Consumption Pass completato senza modificare il matching
✔ Match Engine invariato
✔ project_state / entity_state restano fonte minima matching

Nota:

Input Analysis Result non risolve il problema strutturale del Match Engine avanzato.
Aggiunge un layer compositivo sopra i moduli specializzati.

STATO DOPO VISIBILITY MIGRATION COMPLETION / LINTING SAFETY PASS:

✔ Hidden principali del flow input migrati a input_analysis_result
✔ button_input_confirm.Hidden migrato a canShowConfirm
✔ button_input_confirm.Disabled resta separato
✔ button_input_confirm payload invariato
✔ input_analysis_result non legge più ui_visibility_state
✔ ui_visibility_state residuo tecnico deprecabile
✔ linting Retool azzerati
✔ query legacy unused typing_state / handle_event_success eliminate
✔ Match Engine invariato
✔ project_state / entity_state invariati
✔ select_project / select_entity invariati
✔ create_suggestion_state invariato nella logica funzionale
✔ command_intent_state invariato nella logica funzionale

Nota:

Questo nodo non risolve il Match Engine avanzato.
Stabilizza solo il consumo UI/readiness intorno all’input flow.

------------------------------------------------
TARGET FUTURO — MATCH ENGINE EVOLUTION
------------------------------------------------

Lo STEP 6.4 ha completato:

MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL

Non riaprire come nodo base.

---

Evoluzioni future possibili solo come nodi dedicati:

1. ALIAS / SYNONYMS CONTROLLED MATCHING

- alias project/entity
- abbreviazioni controllate
- sinonimi validati
- nessun fuzzy aggressivo

2. DATA STRUCTURE / ENTITY HIERARCHY

- gerarchie entity/project
- parent_entity_id / parent_project_id
- relazioni entity-project
- deduplicazione

3. BUTTON CONFIRM READINESS ALIGNMENT

- button_input_confirm.Hidden già migrato
- valutare button_input_confirm.Disabled
- distinguere visibility / disabled / save readiness
- mantenere payload invariato
- non modificare project_state / entity_state
- non modificare insert_event / update_event

4. MATCH CONFIDENCE / RANKING ADVANCED

- ranking più evoluto
- confidence controllata
- audit ambiguità

---

Vincoli futuri:

- nessuna auto-decisione se ambiguo
- nessuna creazione automatica silenziosa
- nessun fuzzy aggressivo senza controllo
- utente sempre in controllo
- output/KPI non anticipati

5. SELECT OPTIONS FILTERING — AMBIGUITY UX

- filtrare opzioni select sui match ambigui
- migliorare risoluzione ambiguità
- non ridurre possibilità di selezione manuale libera senza nodo dedicato

6. ADVANCED COMMAND INTENT

- modifica project/entity da command
- dashboard/report intent
- eventuale routing avanzato
- nessun edit automatico senza conferma
- nessun output/KPI anticipato

7. MATCH ENGINE — MORE SPECIFIC MATCH POLICY

- valutare se warning “match più specifici” resta sempre non bloccante
- esempio: Mario selezionato automaticamente con warning entità più specifiche
- decidere se richiedere scelta manuale nei casi più delicati
- non modificare matching senza nodo dedicato

------------------------------------------------
EVOLUZIONE FUTURA NON ATTIVA
------------------------------------------------

- alias/sinonimi controllati
- fuzzy matching
- ranking per frequenza
- storico selezioni
- entity hierarchy
- project hierarchy
- relazioni entity-project
- deduplicazione
- command intent avanzato oltre create project/entity
- Input Analysis Model completo
- eventuale decommission di ui_visibility_state
- button_input_confirm Disabled / readiness alignment
- Match Engine — More Specific Match Policy
- creazione automatica silenziosa project/entity
- filtro select su match ambigui
- pending state avanzato per nuovi project/entity
- confidence score
- audit ambiguità

------------------------------------------------
OBIETTIVO MATCH ENGINE
------------------------------------------------

Ridurre ambiguità mantenendo controllo utente.

---

Deve:

- suggerire
- evidenziare
- bloccare ambiguità quando necessario
- mantenere coerenza tra select e preview
- ridurre falsi positivi

---

NON deve:

- automatizzare completamente
- interpretare intenzione utente in modo nascosto
- creare project/entity direttamente dal matching
- creare project/entity senza conferma utente
- forzare selezioni ambigue
- sostituire la validazione utente

---

Stato attuale:

Il primo livello controllato è stato implementato.
Il Match Engine ora riduce le divergenze tra state, select, preview e confirm.

Il successivo Project / Entity Create Suggestion First Controlled Level
ha aggiunto un layer di suggestion controllata che consuma il matching,
senza trasformare il match engine in un sistema decisionale o di scrittura DB.

Il successivo Command Intent — Create Project / Entity
ha aggiunto un layer separato per intercettare comandi puri,
senza trasformare il Match Engine in un sistema di command routing.

Il Match Engine resta dedicato a project/entity dentro eventi ordinari.

Il successivo UI Readiness / Visibility Aggregator
ha aggiunto un layer separato per coordinare la visibilità del flow input,
senza trasformare il Match Engine in un sistema di readiness UI.

Il successivo Preview Analysis State
ha aggiunto un layer separato per hint/status della Sintesi,
senza trasformare il Match Engine in un sistema preview.

Il successivo Input Analysis Result — Visibility Migration Completion
ha aumentato il consumo UI di input_analysis_result per gli Hidden principali del flow input,
senza modificare il Match Engine.

Il successivo Linting / Retool Query Safety Pass
ha azzerato i linting Retool e rimosso query legacy unused,
senza modificare il Match Engine.

Il Match Engine resta invariato.

project_state / entity_state restano la fonte minima matching.
select_project / select_entity restano la fonte finale salvabile.

Il prossimo livello non è “rifare il Match Engine”,
ma evolverlo tramite nodi dedicati.

------------------------------------------------
STATO ATTUALE
------------------------------------------------

✔ matching base funzionante  
✔ Match Engine Unification First Controlled Level completato  
✔ project_state / entity_state fonte minima matching  
✔ select_project / select_entity alimentati da singleMatch  
✔ auto-select limitato ai casi univoci  
✔ ambiguità bloccanti gestite tramite isAmbiguous  
✔ ambiguità risolta manualmente consente conferma  
✔ nessun match non blocca conferma  
✔ preview hint matching allineati a state  
✔ preview highlight alimentato da matches  
✔ priority match minimo implementato  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ utente mantiene controllo  
✔ create_suggestion_state consuma il match state
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ creazione guidata project/entity implementata a primo livello controllato
✔ no-match project/entity può generare suggestion controllata
✔ project/entity mancanti non bloccano conferma
✔ project/entity ambigui bloccano conferma
✔ entity autofill controlled minimal implementato
✔ Command Intent — Create Project / Entity completato
✔ command_intent_state introdotto come helper separato
✔ command intent non sostituisce project_state / entity_state
✔ command intent non sostituisce create_suggestion_state
✔ comandi puri non salvano eventi
✔ project/entity da command creati solo previa conferma utente
✔ elemento già presente da command riconosciuto e non duplicato
✔ UI Readiness / Visibility Aggregator completato
✔ ui_visibility_mode introdotto come latch UI
✔ ui_visibility_state introdotto come aggregatore read-only
✔ ui_visibility_state separato dal Match Engine
✔ project_state / entity_state restano fonte minima matching
✔ matching invariato dopo UI Readiness
✔ test obbligatori 1–16 superati senza regressione matching
✔ Preview Analysis State — First Controlled Layer completato
✔ preview_analysis_state introdotto senza modificare matching
✔ Input Analysis Result / Single Interpretation Layer Base completato come diagnostico
✔ input_analysis_result introdotto senza modificare matching
✔ raw / selection / effective state introdotti
✔ Controlled UI Consumption Pass completato senza regressione matching
✔ input_analysis_result legge project_state / entity_state ma non li sostituisce
✔ input_analysis_result legge select_project / select_entity ma non li valorizza
✔ project_state / entity_state restano fonte minima matching
✔ select_project / select_entity restano fonti salvabili
✔ Visibility Migration Completion completata senza regressione matching
✔ input_analysis_result governa Hidden principali senza calcolare matching
✔ button_input_confirm.Hidden migrato senza modificare Disabled / payload
✔ ui_visibility_state residuo tecnico deprecabile
✔ linting Retool azzerati senza modificare matching

---

⚠ match engine avanzato separato non implementato  
⚠ preview ancora ibrida  
⚠ hint duration/type ancora embedded nella preview  
⚠ nessuna gerarchia  
⚠ nessun alias system  
⚠ nessuna deduplicazione  
✔ creazione guidata project/entity implementata a primo livello controllato
⚠ command intent avanzato non implementato
✔ input_analysis_result implementato come layer compositivo per Hidden principali del flow input
⚠ Input Analysis Model completo non implementato
⚠ ui_visibility_state ancora presente fisicamente come residuo tecnico deprecabile
✔ Full Visibility Migration degli Hidden principali completata
✔ button_input_confirm.Hidden migrato
⚠ button_input_confirm.Disabled non migrato
⚠ save readiness non centralizzata
⚠ cleanup obsolete UI guards / query reduction non ancora eseguito
✔ linting Retool azzerati
⚠ filtro select su match ambigui non implementato
⚠ non ancora pronto per output/KPI affidabili senza ulteriori nodi data/economic/report readiness

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01  
- definizione base matching

v02 — 2026-04-03  
- retrofit entity matching  
- introduzione token significativi  
- eliminazione partial match aggressivo  
- riduzione falsi positivi  
- allineamento con runtime reale

v03 — 2026-04-23  
- identificazione sistemi di matching multipli  
- documentazione incoerenza strutturale  
- introduzione problema unificazione matching  
- allineamento con stato reale sistema

v04 — 2026-04-30  
- chiarito che Normalization Layer Base non ha modificato il matching  
- aggiornato rapporto tra matching e ui_state.parsed  
- esplicitato che amount/unit normalization è separata dal match engine  
- confermato problema strutturale dei tre sistemi di matching paralleli  
- definito Match Engine Unification come nodo futuro dedicato  
- confermato che priority match resta non implementato
v05 — 2026-05-02  
- completamento MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL  
- project_state aggiornato come fonte minima matching project  
- entity_state aggiornato come fonte minima matching entity  
- aggiunti output matches / count / hasMatch / isAmbiguous / singleMatch / moreSpecificMatches / hasMoreSpecificMatches  
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
- mario → Mario + hint entità più specifiche  
- villa → Villa + hint progetti più specifici  
- bug €500 nella label preview risolto  
- linting project_state/entity_state ripuliti  
- linting residui edit_mode/editing_event mantenuti come nodo futuro  
- nessuna modifica DB  
- nessuna modifica parser  
- nessuna modifica type classification  
- nessuna modifica duration normalization  
- nessun output/KPI anticipato

v06 — 2026-05-07
- aggiornamento post PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
- documentato rapporto tra project_state/entity_state e create_suggestion_state
- chiarito che create_suggestion_state consuma il matching ma non lo sostituisce
- chiarito che matching ≠ creazione
- chiarito che suggestion ≠ decisione
- chiarito che suggestion ≠ salvataggio evento
- documentata creazione project/entity solo previa conferma utente
- documentata regola select_project/select_entity come decisione utente finale
- documentato no-match project/entity come non bloccante
- documentato blocco solo su ambiguità attiva non risolta
- documentata relatione tra hint informativi e suggestion create
- documentata Project Create Suggestion su estensioni controllate
- documentata Entity Create Suggestion
- documentato entity autofill controlled minimal
- documentato che entity autofill non è matching entity
- aggiornati casi non supportati rimuovendo create suggestion base
- aggiunti command intent e select filtering come evoluzioni future
- confermato DB schema invariato
- confermato parser invariato
- confermato type classification invariata
- confermato duration normalization invariata
- nessun output/KPI anticipato

v07 — 2026-05-13

- aggiornamento post COMMAND INTENT — CREATE PROJECT / ENTITY
- documentato command_intent_state come helper separato dal Match Engine
- chiarito che command_intent_state non sostituisce project_state / entity_state
- chiarito che command_intent_state non sostituisce create_suggestion_state
- chiarito che matching ≠ command intent
- chiarito che suggestion ≠ command intent
- chiarito che command intent ≠ salvataggio evento
- documentato comando generico “crea”
- documentato create project incompleto
- documentato create project completo
- documentato create entity incompleto
- documentato create entity completo
- documentata guida non operativa “modifica evento”
- documentato elemento già presente da command
- documentato “crea progetto villa” come no-duplicate guard
- documentato che comandi puri non salvano eventi
- documentato che project/entity da command richiedono conferma utente
- documentato riuso insert_project / insert_entity da command
- documentato che command intent non modifica project_state/entity_state
- documentato che command intent non modifica create_suggestion_state
- documentato evento ordinario non regressivo dopo Command Intent
- documentato edit flow non regressivo dopo Command Intent
- aggiornati casi non supportati
- aggiornati limiti attuali
- aggiornato Target Futuro sostituendo Command Intent base con Input Analysis Model / Single Interpretation Layer
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato

v08 — 2026-05-18

- micro-allineamento post UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
- integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- documentato rapporto tra Match Engine e UI Readiness / Visibility Aggregator
- documentato ui_visibility_mode come latch UI separato dal Match Engine
- documentato ui_visibility_state come aggregatore read-only di visibilità separato dal Match Engine
- chiarito che ui_visibility_state può leggere project_state / entity_state solo per visibilità/hint
- chiarito che ui_visibility_state non calcola matches / count / singleMatch / isAmbiguous
- chiarito che ui_visibility_state non sostituisce project_state / entity_state
- chiarito che ui_visibility_state non modifica create_suggestion_state
- chiarito che ui_visibility_state non modifica command_intent_state
- chiarito che ui_visibility_state non modifica select_project / select_entity
- chiarito che ui_visibility_state non modifica confirm guard funzionale
- chiarito che ui_visibility_state non modifica payload o DB
- aggiornata pipeline runtime con ui_visibility_mode e ui_visibility_state
- documentato che container_association_suggestions è governato da ui_visibility_state.showAssociationSuggestions
- documentato che preview / Dati evento / Conferma evento sono governati da ui_visibility_state
- confermato Match Engine invariato
- confermato DB invariato
- confermato parser invariato
- confermato create_suggestion_state invariato
- confermato command_intent_state invariato
- confermati test 1–16 post UI Readiness senza regressione matching
- Input Analysis Model completo non implementato
- Event Interpretation Engine non implementato

v09 — 2026-05-20

- aggiornamento post PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
- documentato preview_analysis_state come layer read-only preview/hint
- chiarito che preview_analysis_state può leggere stati derivati dal matching ma non calcola matching
- chiarito che preview_analysis_state non modifica project_state / entity_state
- chiarito che preview_analysis_state non seleziona project/entity

- aggiornamento post INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
- documentato input_analysis_result come layer compositivo read-only
- documentata distinzione raw / selection / effective
- chiarito che input_analysis_result legge project_state / entity_state ma non li sostituisce
- chiarito che input_analysis_result legge select_project / select_entity ma non li valorizza
- chiarito che input_analysis_result non calcola matches, count, singleMatch o ambiguità
- chiarito che input_analysis_result non è Match Engine

- aggiornamento post INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS
- documentato che input_analysis_result è fonte UI controllata parziale
- documentato che input_analysis_result governa visibility/readiness senza modificare matching
- documentato che in command flow i raw match project/entity possono esistere ma non sono usabili come dati evento
- documentato che in edit flow il command intent viene soppresso a livello effective
- documentato che container_association_suggestions.Hidden ora legge input_analysis_result.readiness.canShowAssociationSuggestions
- documentata distinzione missing association notice ≠ suggestion operativa
- documentato che create_suggestion_state resta fonte del contenuto operativo dei suggerimenti
- documentato che in quella fase ui_visibility_state restava ancora operativo; stato successivamente superato da Visibility Migration Completion, che lo ha riclassificato come residuo tecnico deprecabile / rollback
- documentato che button_input_confirm non è ancora migrato
- confermato Match Engine invariato
- confermato project_state / entity_state invariati
- confermato select_project / select_entity invariati
- confermato create_suggestion_state invariato
- confermato command_intent_state invariato
- confermato button_input_confirm payload invariato
- confermato DB invariato
- confermato parser invariato
- documentato aumento linting Retool a 19 come debito tecnico generale

v10 — 2026-05-23

- aggiornamento post INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
- confermato Match Engine invariato
- confermato project_state / entity_state invariati
- confermato select_project / select_entity invariati
- confermato create_suggestion_state invariato nella logica funzionale
- confermato command_intent_state invariato nella logica funzionale
- documentato input_analysis_result come fonte UI controllata per Hidden principali del flow input senza diventare Match Engine
- documentata migrazione container_input.Hidden a input_analysis_result
- documentata migrazione text_input_analysis_loading.Hidden a input_analysis_result
- documentata migrazione btn_cancel_edit.Hidden a input_analysis_result
- documentata migrazione btn_cancel_input_home.Hidden a input_analysis_result
- documentata migrazione button_input_confirm.Hidden a input_analysis_result.readiness.canShowConfirm
- documentato canShowConfirm come visibility-only
- documentato button_input_confirm.Disabled come guard funzionale separata
- documentato button_input_confirm payload invariato
- documentata rimozione dipendenza input_analysis_result → ui_visibility_state
- documentato ui_visibility_state come residuo tecnico deprecabile
- documentato che ui_visibility_state non è fonte matching
- aggiornata pipeline match post Visibility Migration Completion
- aggiornata relazione con UI Readiness / Input Analysis Result
- aggiornata relazione con preview
- aggiornata relazione con create_suggestion_state
- documentata policy match più specifici come invariata e non bloccante
- aggiunto nodo futuro MATCH ENGINE — MORE SPECIFIC MATCH POLICY
- aggiornati limiti attuali
- aggiornato target futuro Match Engine Evolution
- aggiornato stato attuale

- aggiornamento post LINTING / RETOOL QUERY SAFETY PASS
- documentato linting Retool azzerato
- documentato che i fix linting non hanno modificato matching
- documentata eliminazione typing_state senza impatto matching
- documentata eliminazione handle_event_success senza impatto matching
- confermato DB invariato
- confermato parser invariato
- confermato save flow invariato
- confermato payload invariato

v11 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicato Pacchetto C — Documenti tecnici canonici su 02_LOGOS_Match_Engine
- documento aggiornato da v10 a v11
- confermato 02_LOGOS_Match_Engine come fonte canonica per project_state, entity_state, matches, count, isAmbiguous, singleMatch, moreSpecificMatches, auto-select, ambiguità, confirm guard matching e policy match più specifici
- aggiunta sezione RESPONSABILITÀ CANONICA DEL DOCUMENTO
- chiarito che State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo del Match Engine
- chiarito che il dettaglio completo resta in questo documento e nei documenti canonici collegati
- aggiunti richiami canonici a:
  - 01_LOGOS_Input_System per input flow, parser, normalization, Command Intent nel contesto input, create_suggestion_state e input_analysis_result
  - 03_LOGOS_Event_Lifecycle per lifecycle evento
  - 04_LOGOS_Retool_Architecture per componenti/query/Hidden/select/wiring Retool
  - 05_LOGOS_Database_Schema per schema DB
  - 06_LOGOS_View_Preview_System per Sintesi, preview, hint, warning, highlight e label visuali
  - LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
  - LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase as-is
- corretto residuo storico nel changelog v09 su ui_visibility_state operativo/non deprecato
- aggiunte note canoniche nelle sezioni:
  - RELAZIONE CON NORMALIZATION LAYER BASE
  - RELAZIONE CON PREVIEW
  - RELAZIONE CON UI READINESS / INPUT ANALYSIS RESULT
- nessuna riduzione aggressiva applicata
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica payload