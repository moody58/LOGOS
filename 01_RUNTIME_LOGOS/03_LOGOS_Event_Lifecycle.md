# 03_LOGOS_Event_Lifecycle_v12

DATA: 2026-05-25

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- lifecycle attuale completo  
- stati, transizioni e responsabilità coperti  
- integrazione con input, normalization base, duration normalization, type classification, matching e processing esplicitata  
- update flow reale documentato  
- edit flow aggiornato con match state live  
- annulla modifica documentato
- no-op edit guard documentato
- distinzione edit reale / edit senza modifiche documentata
- lista eventi search/filter e label creato/modificato documentate come processing UX
- refresh lista dopo update documentato  
- fonti runtime di salvataggio chiarite  
- Linting / State Helper Cleanup documentato
- edit_mode / editing_event documentati come helper tecnici ripuliti
- rimozione additionalScope { value } da edit_mode / editing_event documentata
- reset helper edit flow post-update documentato
- Project / Entity Create Suggestion First Controlled Level documentato nel lifecycle
- creazione project/entity inline documentata come supporto al NEW event flow
- evento non salvato automaticamente dopo creazione project/entity documentato
- UX Mobile Coherence Pass documentato
- feedback_summary documentato come stato UI temporaneo
- feedback post-save temporaneo documentato
- routing post-save contestuale documentato
- insert → feedback → Home documentato
- update reale → feedback → Lista eventi documentato
- no-op edit → Lista eventi senza feedback documentato
- cancel create/input → Home documentato
- cancel edit → Lista eventi documentato
- navigation dock documentata come UI, non stato evento
- font-size 16px input/select mobile Safari documentato come vincolo UX/runtime
- Command Intent — Create Project / Entity documentato nel lifecycle
- command_intent_state documentato come helper UI/runtime separato dal lifecycle evento
- distinzione comando puro / evento ordinario documentata
- comandi puri esclusi da insert_event / update_event
- creazione project/entity da command documentata come azione strutturale, non evento
- feedback project_created / entity_created documentato come feedback UI temporaneo
- guida “modifica evento” documentata come routing UI, non transizione evento
- btn_command_create_project / btn_command_create_entity / btn_command_go_events documentati
- evento ordinario non regressivo dopo Command Intent documentato
- edit flow non regressivo dopo Command Intent documentato
- UI Readiness / Visibility Aggregator First Controlled Level documentato nel lifecycle come layer UI separato
- Input Analysis Result / Single Interpretation Layer Base documentato come layer compositivo read-only non lifecycle
- Input Analysis Result — Controlled UI Consumption Pass documentato come fonte UI controllata parziale
- Input Analysis Result — Visibility Migration Completion documentato nel lifecycle come completamento visibility degli Hidden principali del flow input
- ui_visibility_mode documentato come latch UI non persistente
- input_analysis_result documentato come fonte UI controllata per gli Hidden principali del flow input
- ui_visibility_state riclassificato come residuo tecnico deprecabile / rollback
- confermato che UI Readiness / input_analysis_result non introducono nuovi stati evento
- confermato che UI Readiness non modifica NEW / WRITTEN / ERROR
- confermato che edit mode prevale su Command Intent
- documentato text_edit_mode_notice come supporto UX al lifecycle edit
- documentato che durante edit mode scrivere “crea” non apre Command Intent
- documentato che UI Readiness non modifica insert_event / update_event
- micro-flash feedback project/entity documentato come residuo UI esterno al lifecycle evento
- residuo “modifica” generico non riconosciuto come guida edit documentato

Q (Qualità): 9.5/10  
- lifecycle coerente con sistema reale  
- append-only controllato chiarito  
- limiti storicizzazione / versioning esplicitati  
- distinzione tra correzione NEW e validazione WRITTEN mantenuta  
- chiarito che matching/type/duration migliorano qualità dati ma non validano l’evento  
- chiarito che Annulla non modifica evento e non aggiorna updated_at
- chiarito che edit senza modifiche reali non produce update_event
- nessuna anticipazione output/KPI  
- rumore tecnico Retool su edit_mode / editing_event eliminato
- lifecycle edit più ricostruibile perché gli helper non dipendono più da value implicito
- lifecycle invariato negli stati evento NEW / WRITTEN / ERROR
- migliorata distinzione tra lifecycle dati e routing UI post-save
- chiarito che feedback e navigation dock non cambiano stato evento
- chiarito che project/entity creation migliora la qualità dati ma non valida l’evento
- validazione reale iPhone 13 Safari integrata come requisito UX mobile
- chiarito che Command Intent non introduce nuovi stati evento
- chiarito che i comandi puri non generano eventi NEW
- chiarito che project/entity creati da command non validano e non creano eventi
- chiarito che “modifica evento” da command non apre edit flow automatico
- mantenuta separazione tra lifecycle dati e routing UI command
- feedback project/entity distinto dal feedback evento
- migliorata distinzione tra lifecycle dati e visibilità UI input flow
- chiarito che ui_visibility_state governa solo UI, non stati evento
- chiarito che ui_visibility_mode non è uno stato evento
- chiarito che il lifecycle edit resta dominante rispetto al flow command
- migliorata leggibilità del comportamento edit tramite notice dedicata
- mantenuta separazione tra evento ordinario, command intent e lifecycle dati
- nessuna anticipazione Input Analysis Model completo

D (Deployabilità): 10/10  
- documento stabile  
- utilizzabile come riferimento operativo  
- allineato al runtime Retool/Supabase attuale  
- create flow validato  
- edit flow validato  
- annulla modifica validato
- edit senza modifiche validato
- search/filter lista eventi validato
- WRITTEN / ERROR rivalidati dopo cleanup UX
- DB invariato
- linting edit_mode / editing_event risolti
- create/edit/annulla/no-op edit/edit reale rivalidati dopo cleanup helper
- WRITTEN / ERROR rivalidati dopo cleanup helper
- Project / Entity Create Suggestion validato runtime
- insert_project / insert_entity validati come supporto al lifecycle NEW
- UX Mobile Coherence Pass validato runtime
- insert → feedback → Home validato
- update → feedback → Lista eventi validato
- no-op edit → Lista eventi senza update_event validato
- cancel create/edit validato
- iPhone 13 Safari reale validato
- zoom automatico iOS risolto tramite font-size 16px
- chiarito che Command Intent non introduce nuovi stati evento
- chiarito che i comandi puri non generano eventi NEW
- chiarito che project/entity creati da command non validano e non creano eventi
- chiarito che “modifica evento” da command non apre edit flow automatico
- mantenuta separazione tra lifecycle dati e routing UI command
- feedback project/entity distinto dal feedback evento
- UI Readiness / Visibility Aggregator validato runtime
- test obbligatori 1–16 superati
- evento ordinario non regressivo dopo UI Readiness validato
- command intent non regressivo dopo UI Readiness validato
- edit reale non regressivo dopo UI Readiness validato
- edit no-op non regressivo dopo UI Readiness validato
- annulla edit non regressivo dopo UI Readiness validato
- feedback evento validato
- feedback project/entity validato con micro-flash residuo non bloccante
- events list validata
- Home vuota + navigation dock validata
- DB invariato
- stati evento invariati

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il ciclo di vita completo degli eventi
all’interno del sistema LOGOS.

Il documento stabilisce:

- stati evento
- transizioni
- responsabilità utente
- qualità del dato
- correzione pre-validazione
- annullamento modifica pre-validazione
- distinzione tra modifica reale e conferma senza variazioni
- rapporto tra input, normalization base, duration normalization, type classification, matching e processing
- evoluzione futura
- cleanup helper edit_mode / editing_event
- rimozione linting Retool residui dal lifecycle edit
- creazione guidata project/entity come supporto al lifecycle NEW
- distinzione tra creazione project/entity e salvataggio evento
- feedback post-save temporaneo
- routing post-save contestuale
- cancel create/input e cancel edit contestuali
- UX mobile coherence pass
- vincolo font-size 16px per input/select mobile Safari
- distinzione tra evento ordinario e comando puro
- Command Intent — Create Project / Entity
- esclusione dei comandi puri dal lifecycle evento
- creazione project/entity da command come azione strutturale separata
- feedback project_created / entity_created come feedback UI temporaneo
- guida “modifica evento” come routing UI non operativo sul dato
- UI Readiness / Visibility Aggregator come layer UI non persistente
- Input Analysis Result come layer compositivo read-only non lifecycle
- ui_visibility_mode come latch UI empty / event / command
- input_analysis_result come fonte UI controllata per gli Hidden principali del flow input
- ui_visibility_state come residuo tecnico deprecabile / rollback
- conferma che UI Readiness / input_analysis_result non modificano lifecycle evento
- conferma che edit mode prevale su Command Intent
- text_edit_mode_notice come supporto UX alla modifica evento
- micro-flash feedback project/entity come residuo UI non lifecycle

------------------------------------------------
RESPONSABILITÀ CANONICA DEL DOCUMENTO
------------------------------------------------

Questo documento è fonte canonica per:

- lifecycle evento LOGOS
- stati evento NEW / WRITTEN / ERROR
- transizioni evento
- create flow evento ordinario
- edit flow evento NEW
- update_event nel lifecycle
- no-op edit
- annulla modifica
- cancel create/input
- cancel edit
- distinzione tra edit reale ed edit senza modifiche
- rapporto tra evento ordinario e Command Intent
- esclusione dei comandi puri dal lifecycle evento
- routing post-save nel contesto lifecycle
- feedback temporaneo nel contesto lifecycle
- processing NEW / WRITTEN / ERROR
- responsabilità utente nella validazione evento
- limiti lifecycle attuali
- lifecycle futuro non attivo
- vincoli operativi sugli stati evento

Questo documento NON è fonte canonica completa per:

- input flow / parser / normalization nel dettaglio runtime frontend
- Match Engine project/entity nel dettaglio completo
- componenti / query / Hidden Retool nel dettaglio completo
- schema DB completo
- Preview / Sintesi / hint / warning completi
- runtime Retool as-is completo
- runtime Supabase as-is completo
- roadmap / priorità / gap governance

Fonti canoniche collegate:

- 01_LOGOS_Input_System per input flow, parser, normalization, duration normalization, type classification base nel contesto input, Command Intent, create_suggestion_state e input_analysis_result.
- 02_LOGOS_Match_Engine per project_state / entity_state / matches / isAmbiguous / singleMatch / moreSpecificMatches / confirm guard matching.
- 04_LOGOS_Retool_Architecture per componenti, query, Hidden, edit_mode, editing_event, button_input_confirm, insert_event, update_event, insert_project, insert_entity e wiring Retool.
- 05_LOGOS_Database_Schema per schema DB, tabelle, campi persistiti e comportamento Supabase passivo.
- 06_LOGOS_View_Preview_System per Sintesi, preview, hint, warning, label visuali e micro-copy.
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is.
- LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase / storage passivo.

Nota post Pacchetto B:

State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo del lifecycle evento.
Il dettaglio completo del ciclo di vita evento resta in questo documento e nei documenti canonici collegati.

------------------------------------------------
PRINCIPI FONDANTI
------------------------------------------------

1. EVENTO = UNITÀ BASE

Ogni informazione operativa viene registrata come evento.

Eccezione esplicita:

i comandi strutturali puri non sono eventi.

Esempi:

- crea
- crea progetto Villa Nuova
- crea entità Patrizio
- modifica evento

Questi input vengono gestiti da Command Intent
e non generano automaticamente eventi NEW.

Nota post Visibility Migration Completion:

La distinzione visiva tra evento ordinario e command intent è ora supportata da:

- ui_visibility_mode
- input_analysis_result

ui_visibility_state resta presente come residuo tecnico deprecabile / rollback,
ma non è più la fonte primaria degli Hidden principali del flow input.

Questi helper non sono stati evento.
Non generano eventi.
Non modificano il lifecycle NEW / WRITTEN / ERROR.

Fonte canonica per comportamento input_analysis_result / visibility / readiness:

- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

2. APPEND-ONLY CONTROLLATO

Gli eventi:

- sono append-only dopo validazione
- possono essere modificati in stato NEW
- possono uscire dall’edit mode senza modifiche tramite Annulla
- non vengono aggiornati se l’edit viene confermato senza cambiamenti reali
- mantengono raw_input come memoria dell’input utente
- non mantengono ancora storico revisioni
- usano helper edit_mode / editing_event ripuliti da linting Retool
- possono essere arricchiti con project_id/entity_id creati inline prima della conferma evento
- la creazione project/entity non salva automaticamente l’evento
- feedback e routing post-save non modificano il dato salvato
- non vengono creati se l’input è un comando puro riconosciuto da command_intent_state
- restano separati da project/entity creati tramite command intent
- non vengono modificati da “modifica evento” scritto come command intent
- non vengono modificati da ui_visibility_mode
- non vengono modificati da input_analysis_result
- non vengono modificati da ui_visibility_state residuo
- non cambiano lifecycle quando cambia la visibilità del flow input

---

3. EVOLUZIONE PER STATO + CORREZIONE PRE-VALIDAZIONE

Un evento:

- nasce in stato NEW
- può essere corretto mentre è NEW
- viene validato manualmente
- evolve verso WRITTEN o ERROR

---

4. DECISIONE UMANA

La validazione è sempre manuale.

Il sistema:

- suggerisce
- struttura
- normalizza dati base
- normalizza durate certe ore/minuti
- classifica type a livello base
- propone matching project/entity
- blocca ambiguità project/entity non risolte
- propone creazione project/entity quando controllata
- richiede conferma esplicita per creare project/entity
- richiede conferma esplicita separata per salvare l’evento
- riconosce comandi puri a primo livello controllato
- esclude i comandi puri dal salvataggio evento
- richiede conferma esplicita per creare project/entity da command
- guida l’utente alla lista eventi se scrive “modifica evento”
- non decide definitivamente
- coordina la visibilità UI tramite input_analysis_result per gli Hidden principali migrati
- mantiene ui_visibility_state come residuo tecnico deprecabile / rollback
- non considera input_analysis_result o ui_visibility_state fonti dati evento
- mantiene il lifecycle evento separato dal layer UI Readiness / input_analysis_result

---

5. INPUT NON BLOCCANTE

Eventi imperfetti possono essere salvati.

La qualità viene migliorata progressivamente tramite:

- preview
- selezione manuale
- editing NEW
- normalization base
- duration normalization base
- type classification base
- match state project/entity
- processing manuale
- suggestion project/entity controllata
- feedback post-save temporaneo
- routing UI coerente con insert/update
- riconosce comandi puri a primo livello controllato
- esclude i comandi puri dal salvataggio evento
- richiede conferma esplicita per creare project/entity da command
- guida l’utente alla lista eventi se scrive “modifica evento”
- rende più chiaro edit mode tramite text_edit_mode_notice
- mantiene edit mode prevalente su Command Intent
- durante edit mode non apre Command Intent se l’utente scrive “crea”

------------------------------------------------
STATI EVENTO ATTUALI
------------------------------------------------

NEW

- stato iniziale
- evento appena inserito
- non validato
- può contenere errori o ambiguità
- modificabile
- può essere normalizzato base in insert/update
- può contenere durate certe normalizzate in minuti
- può contenere type base valorizzato
- può contenere project_id/entity_id derivati da select_project/select_entity
- può usare project/entity creati inline prima del salvataggio evento
- project/entity creati inline vengono salvati solo su conferma utente
- evento resta NEW solo dopo Conferma evento / insert_event
- non nasce se l’input è un comando puro riconosciuto
- non nasce dopo “crea progetto...” o “crea entità...” da command intent
- non nasce dopo “modifica evento” usato come guida command
- la creazione project/entity non genera automaticamente un evento
- la creazione project/entity da Command Intent non genera automaticamente un evento
- feedback project_created / entity_created non rappresenta uno stato evento
- può essere corretto tramite edit flow con match state live
- può uscire dall’edit flow tramite Annulla senza update_event
- può essere confermato in edit senza modifiche reali senza aggiornare updated_at
- dopo insert reale mostra feedback temporaneo e ritorna Home
- dopo update reale mostra feedback temporaneo e ritorna Lista eventi
- dopo no-op edit torna Lista eventi senza feedback
- usa feedback_summary solo come riepilogo UI temporaneo
- usa edit_mode / editing_event come helper tecnici del flow edit
- può essere accompagnato da input_analysis_result per mostrare/nascondere gli Hidden principali del flow input
- può mantenere ui_visibility_state come residuo tecnico deprecabile / rollback
- input_analysis_result non modifica lo stato NEW
- ui_visibility_state non modifica lo stato NEW
- ui_visibility_mode non modifica lo stato NEW
- text_edit_mode_notice può essere mostrato durante edit mode
- edit_mode / editing_event non usano più additionalScope { value }
- resta sotto controllo utente

Nota:

UI Readiness / Visibility Aggregator non introduce nuovi stati evento.
Coordina solo la visibilità del flow input.

---

WRITTEN

- evento confermato
- considerato valido dall’utente
- utilizzabile
- non modificabile nel lifecycle attuale
- non necessariamente perfetto dal punto di vista semantico

---

ERROR

- evento annullato
- non valido
- escluso dal flusso operativo
- non modificabile nel lifecycle attuale

------------------------------------------------
FLUSSO ATTUALE
------------------------------------------------

INPUT  
↓  
UI VISIBILITY MODE CHECK  
↓  
COMMAND INTENT CHECK  
↓  
SE COMANDO PURO  
→ container_command_intent  
→ azione command controllata  
→ eventuale insert_project / insert_entity oppure Vai agli eventi  
→ feedback temporaneo project/entity oppure Lista eventi  
→ NESSUN EVENTO NEW  

SE EVENTO ORDINARIO  
↓  
INPUT ANALYSIS RESULT / UI READINESS  
↓  
PARSE CONTROLLED  
↓  
NORMALIZATION BASE  
↓  
DURATION NORMALIZATION BASE  
↓  
TYPE CLASSIFICATION BASE  
↓  
MATCH STATE PROJECT/ENTITY  
↓  
CREATE SUGGESTION STATE  
↓  
SELECT PROJECT / ENTITY  
↓  
PREVIEW / SINTESI  
↓  
DATI EVENTO  
↓  
CONFERMA EVENTO  
↓  
INSERT  
↓  
FEEDBACK TEMPORANEO  
↓  
HOME  
↓  
NEW  
↓  
EDIT opzionale  
↓  
UPDATE se modifica reale  
↓  
FEEDBACK TEMPORANEO  
↓  
LISTA EVENTI  
oppure  
ANNULLA senza update_event  
oppure  
CONFERMA senza modifiche → no-op  
↓  
NEW  
↓  
DECISIONE UTENTE  

→ WRITTEN  
→ ERROR

Nota:

Feedback, Home, Lista eventi e Navigation dock sono stati UI.
Non sono stati evento.

Anche container_command_intent, feedback project_created / entity_created
e guida “modifica evento” sono stati/UI flow.

Non sono stati evento.

Anche ui_visibility_mode, input_analysis_result e ui_visibility_state sono helper UI/runtime.
Non sono stati evento.

- ui_visibility_mode distingue empty / event / command
- input_analysis_result governa gli Hidden principali del flow input migrati
- ui_visibility_state resta residuo tecnico deprecabile / rollback

Non introducono transizioni lifecycle.

Command Intent non introduce nuovi stati lifecycle.

Gli stati evento restano:

- NEW
- WRITTEN
- ERROR

---

EDIT:

- modifica evento esistente
- disponibile solo per eventi NEW
- riuso pipeline input
- usa parse_input_controlled
- usa ui_state.parsed
- rilancia project_state / entity_state
- riallinea select_project / select_entity
- preserva project_id/entity_id salvati se presenti
- usa update_event solo se c’è una modifica reale
- mantiene status NEW
- aggiorna updated_at solo se c’è update_event
- può essere annullato senza update_event
- può essere confermato senza modifiche reali come no-op
- aggiorna lista eventi dopo save completato quando avviene update_event
- dopo update reale mostra feedback temporaneo
- dopo update reale ritorna alla lista eventi
- dopo no-op edit torna alla lista eventi senza feedback
- azzera edit_mode dopo update reale completato
- azzera editing_event dopo update reale completato
- usa helper edit_mode / editing_event senza additionalScope { value }
- mostra text_edit_mode_notice durante la modifica
- edit mode prevale su Command Intent
- se l’utente scrive “crea” durante edit mode, resta nel flow modifica
- per uscire dall’edit flow deve usare Annulla modifica

---

Nota:

Il matching migliora la qualità,
ma NON modifica il lifecycle.

La normalization base, la duration normalization, la type classification base
e il match state migliorano la qualità strutturale dell’evento,
ma NON validano l’evento.

La validazione resta manuale.

------------------------------------------------
PROJECT / ENTITY CREATE SUGGESTION NEL LIFECYCLE
------------------------------------------------

Project / Entity Create Suggestion First Controlled Level supporta il lifecycle
prima del salvataggio evento.

Il sistema può proporre:

- creazione nuovo progetto
- creazione nuova entità
- ignorare suggerimenti
- salvare comunque evento incompleto
- bloccare solo ambiguità project/entity attive non risolte

Regole lifecycle:

- la creazione project/entity NON crea un evento
- la creazione project/entity NON salva automaticamente l’evento corrente
- insert_project / insert_entity scrivono solo nelle rispettive tabelle
- select_project / select_entity vengono valorizzate dopo creazione controllata
- l’evento viene salvato solo quando l’utente clicca Conferma evento
- project/entity mancanti non bloccano il salvataggio evento
- project/entity ambigui bloccano il salvataggio finché non risolti manualmente

Flow project/entity:

input evento
→ suggestion project/entity
→ eventuale Crea progetto / Crea entità
→ insert_project / insert_entity
→ select_project / select_entity valorizzate
→ evento ancora non salvato
→ Conferma evento
→ insert_event
→ NEW

Decisione:

Project/entity creation migliora la qualità dati del NEW event,
ma non modifica il lifecycle stati.

------------------------------------------------
COMMAND INTENT NEL LIFECYCLE
------------------------------------------------

Command Intent — Create Project / Entity è un layer UI/runtime
che intercetta comandi strutturali puri prima del save flow evento.

Componenti principali:

- command_intent_state
- container_command_intent
- input_command_project_name
- input_command_entity_name
- btn_command_create_project
- btn_command_create_entity
- btn_command_go_events
- feedback_mode

Regola principale:

un comando puro NON genera un evento NEW.

Esempi:

crea
→ guida con esempi
→ nessun insert_event
→ nessun evento NEW

crea progetto
→ input nome progetto
→ nessun insert_event
→ nessun evento NEW

crea progetto Villa Nuova
→ btn_command_create_project
→ insert_project
→ feedback project_created
→ nessun evento NEW

crea entità Patrizio
→ btn_command_create_entity
→ insert_entity
→ feedback entity_created
→ nessun evento NEW

crea progetto villa
→ elemento già presente
→ nessun insert_project
→ nessun insert_event
→ nessun evento NEW

modifica evento
→ guida con step
→ btn_command_go_events
→ Lista eventi
→ nessun update_event
→ nessun evento modificato automaticamente

---

Regole lifecycle:

- command_intent_state non crea eventi
- container_command_intent non crea eventi
- btn_command_create_project non crea eventi
- btn_command_create_entity non crea eventi
- btn_command_go_events non modifica eventi
- insert_project scrive solo in projects
- insert_entity scrive solo in entities
- feedback project_created / entity_created è feedback UI temporaneo
- feedback project_created / entity_created non è stato evento
- “modifica evento” da command non equivale a edit mode
- edit_mode viene attivato solo dalla lista eventi tramite pulsante Modifica

---

Flow command project:

input command
→ command_intent_state
→ container_command_intent
→ btn_command_create_project
→ insert_project
→ feedback project_created
→ Home
→ nessun evento creato

---

Flow command entity:

input command
→ command_intent_state
→ container_command_intent
→ btn_command_create_entity
→ insert_entity
→ feedback entity_created
→ Home
→ nessun evento creato

---

Flow command guida evento:

input “modifica evento”
→ command_intent_state
→ container_command_intent
→ btn_command_go_events
→ Lista eventi
→ nessuna modifica evento
→ nessun update_event

---

Decisione:

Command Intent migliora la leggibilità del sistema
e impedisce che comandi puri vengano salvati come eventi.

Non modifica:

- stati evento
- schema DB
- lifecycle NEW / WRITTEN / ERROR
- edit flow reale
- processing WRITTEN / ERROR

------------------------------------------------
UI READINESS / INPUT ANALYSIS RESULT NEL LIFECYCLE
------------------------------------------------

UI Readiness / Visibility Aggregator — First Controlled Level
è un layer UI/runtime che coordina la visibilità del flow input.

Componenti / helper principali:

- ui_visibility_mode
- input_analysis_result
- ui_visibility_state
- text_input_analysis_loading
- text_edit_mode_notice

Regola principale:

UI Readiness non introduce stati evento.

Gli stati evento restano:

- NEW
- WRITTEN
- ERROR

---

ui_visibility_mode:

- Variable Retool
- valori:
  - empty
  - event
  - command
- aggiornata da trigger_parse_debounced
- serve solo a distinguere il flow visivo dell’input
- non viene salvata nel DB
- non modifica eventi
- non modifica project/entity
- non modifica status

---

input_analysis_result:

- Transformer Retool compositivo read-only
- compone raw / selection / effective state
- espone readiness del flow input
- governa gli Hidden principali del flow input migrati
- non salva dati
- non modifica DB
- non modifica parser
- non modifica matching
- non modifica command_intent_state
- non modifica create_suggestion_state
- non modifica insert_event / update_event
- non modifica insert_project / insert_entity
- non costruisce payload
- non introduce nuovi stati evento

Hidden principali migrati a input_analysis_result:

- container_input
- text_input_analysis_loading
- btn_cancel_edit
- btn_cancel_input_home
- button_input_confirm
- sintesi
- text_event_data_title
- select1
- select_project
- select_entity
- container_command_intent
- container_association_suggestions

ui_visibility_state:

- Transformer Retool read-only legacy/residuo
- residuo tecnico deprecabile / rollback
- non è più letto da input_analysis_result
- non governa più gli Hidden principali migrati
- non va eliminato fuori da un nodo cleanup dedicato
- non introduce nuovi stati evento

Componenti non governati direttamente dal flow input:

- container_home
- container_feedback
- container_events_list
- list_events

---

Effetti sul lifecycle:

- nessuna nuova transizione evento
- nessun nuovo status DB
- nessuna modifica a NEW / WRITTEN / ERROR
- nessuna modifica al processing WRITTEN / ERROR
- nessuna modifica al save flow
- nessuna modifica alla validazione manuale
- input_analysis_result modifica solo visibility/readiness UI
- ui_visibility_state resta solo residuo tecnico / rollback

Effetti sulla UX:

- container vuoto durante digitazione risolto
- flash input flow ridotto
- bottom bar flash risolto
- flow event / command più stabile
- edit mode più chiaro tramite notice dedicata

---

EDIT MODE E COMMAND INTENT

Regola consolidata:

edit mode prevale su Command Intent.

Durante edit mode:

- l’utente sta modificando un evento NEW
- scrivere “crea” non apre Command Intent
- scrivere “crea progetto” non avvia create project command
- il testo resta parte dell’evento in modifica
- per uscire bisogna premere Annulla modifica

Supporto UX:

text_edit_mode_notice

Contenuto:

Evento in modifica · Premi Annulla modifica per uscire.

Questa notice non modifica eventi.
Serve solo a chiarire il contesto.

---

CANCEL CONTESTUALE:

Il pulsante cancel ha comportamento diverso in base al contesto.

CREATE / INPUT MODE:

- label: “Torna alla home”
- non esegue insert_event
- non crea evento
- resetta input_home / input_raw
- resetta select_project / select_entity / select1
- resetta ui_state.parsed
- azzera feedback_mode / feedback_text / feedback_project / feedback_summary
- torna Home
- nessuna modifica DB

EDIT MODE:

- label: “Annulla modifica”
- non esegue update_event
- non aggiorna updated_at
- resetta edit_mode tramite window.__logos_edit_mode_value
- resetta editing_event tramite window.__logos_editing_event_value
- non usa additionalScope { value } per edit_mode / editing_event
- resetta input_home / input_raw
- resetta select_project / select_entity / select1
- resetta ui_state.parsed
- azzera feedback_mode / feedback_text / feedback_project / feedback_summary
- torna alla lista eventi NEW
- nasconde text_edit_mode_notice perché edit_mode torna false
- ripristina il comportamento ordinario event / command

Nota:

Cancel create/input e cancel edit sono routing UI.
Non modificano lo stato evento.
Non modificano nemmeno ui_visibility_state come dato.
La visibilità si riallinea automaticamente leggendo input/edit_mode/ui_state.

---

NO-OP EDIT GUARD:

Se l’utente entra in edit mode e conferma senza modificare campi utente,
button_input_confirm non esegue update_event.

Campi confrontati:

- raw_input
- type
- project_id
- entity_id

Campi esclusi dal confronto:

- amount
- unit
- event_date

Motivo:

amount / unit / event_date sono derivati dal parser.
Una rielaborazione del parser non deve essere trattata come modifica utente.

In caso di no-op edit:

- edit_mode viene chiuso tramite window.__logos_edit_mode_value = false
- editing_event viene azzerato tramite window.__logos_editing_event_value = null
- non viene usato additionalScope { value } per edit_mode / editing_event
- non viene mostrato feedback
- ritorna immediatamente alla lista eventi
- feedback_summary viene azzerato

------------------------------------------------
TRANSIZIONI CONSENTITE
------------------------------------------------

NEW → NEW (EDIT)

- azione: modifica evento
- eseguita da utente
- runtime: update_event
- status invariato
- aggiorna raw_input
- aggiorna amount
- aggiorna unit
- aggiorna event_date
- aggiorna type
- aggiorna project_id
- aggiorna entity_id
- project_id/entity_id derivano da select_project/select_entity
- select_project/select_entity sono alimentati da project_state/entity_state
- aggiorna updated_at
- al termine dell’update reale azzera edit_mode
- al termine dell’update reale azzera editing_event
- il reset degli helper edit avviene senza additionalScope { value }
- dopo update_event mostra feedback temporaneo
- dopo feedback torna alla lista eventi

---

NEW → NEW (ANNULLA EDIT)

- azione: annulla modifica
- eseguita da utente
- runtime: btn_cancel_edit
- status invariato
- nessun update_event
- raw_input invariato
- amount invariato
- unit invariata
- event_date invariata
- type invariato
- project_id invariato
- entity_id invariato
- updated_at invariato
- ritorno alla lista eventi
- edit_mode viene chiuso tramite window.__logos_edit_mode_value
- editing_event viene svuotato tramite window.__logos_editing_event_value
- btn_cancel_edit non usa più additionalScope { value } per edit_mode / editing_event
- feedback_summary azzerato
- ritorno alla lista eventi
- nessun feedback mostrato

---

NEW → NEW (EDIT NO-OP)

- azione: conferma edit senza modifiche reali
- eseguita da utente
- runtime: button_input_confirm con no-op edit guard
- status invariato
- nessun update_event
- raw_input invariato
- amount invariato
- unit invariata
- event_date invariata
- type invariato
- project_id invariato
- entity_id invariato
- updated_at invariato
- ritorno alla lista eventi
- edit_mode viene chiuso tramite window.__logos_edit_mode_value
- editing_event viene svuotato tramite window.__logos_editing_event_value
- button_input_confirm non usa più additionalScope { value } per resettare edit_mode / editing_event
- nessun feedback mostrato
- feedback_summary azzerato
- ritorno immediato alla lista eventi

---

CREATE INPUT → HOME (CANCEL CREATE)

Nota:

questa NON è una transizione evento perché nessun evento è ancora stato creato.

- azione: Torna alla home
- eseguita da utente
- runtime: cancel contestuale
- nessun insert_event
- nessun evento NEW creato
- input/select/ui_state.parsed resettati
- feedback_summary azzerato
- ritorno Home

---

COMMAND INPUT → HOME / EVENTS LIST

Nota:

questa NON è una transizione evento perché nessun evento viene creato.

Casi:

- crea
- crea progetto
- crea progetto [nome]
- crea entità
- crea entità [nome]
- crea progetto [nome esistente]
- modifica evento

Comportamento:

- comando generico → guida → nessun evento
- create project completo → insert_project → feedback → Home → nessun evento
- create entity completo → insert_entity → feedback → Home → nessun evento
- elemento già presente → nessun insert → nessun evento
- modifica evento → Lista eventi → nessun update_event

Stati evento coinvolti:

nessuno.

---

UI VISIBILITY CHANGE

Nota:

questa NON è una transizione evento.

Casi:

- input vuoto → ui_visibility_mode empty
- input evento → ui_visibility_mode event
- input command → ui_visibility_mode command
- edit mode attivo → notice edit mode visibile

Comportamento:

- cambia cosa viene mostrato nella UI
- non crea eventi
- non modifica eventi
- non aggiorna status
- non modifica updated_at
- non salva dati
- non valida eventi

Stati evento coinvolti:

nessuno.

Helper coinvolti:

- ui_visibility_mode
- ui_visibility_state
- text_input_analysis_loading
- text_edit_mode_notice

---

NEW → WRITTEN

- azione: conferma / scrittura
- eseguita da utente
- evento considerato valido

---

NEW → ERROR

- azione: annullamento / scarto
- eseguita da utente
- evento escluso

---

Transizioni NON consentite:

- WRITTEN → NEW
- ERROR → NEW
- WRITTEN → ERROR
- ERROR → WRITTEN
- WRITTEN → EDIT
- ERROR → EDIT

Routing UI post-save / post-command:

- insert evento reale → feedback temporaneo → Home
- update evento reale → feedback temporaneo → Lista eventi
- no-op edit → Lista eventi senza feedback
- command create project → feedback project_created → Home
- command create entity → feedback entity_created → Home
- command guida modifica evento → Lista eventi

Questo routing non introduce nuovi stati evento.

------------------------------------------------
RESPONSABILITÀ UTENTE
------------------------------------------------

L’utente deve:

- validare eventi
- correggere tramite editing o selezione
- annullare l’edit se non vuole salvare modifiche
- selezionare project/entity quando necessario
- risolvere ambiguità project/entity prima della conferma
- correggere manualmente type se la classificazione base non è sufficiente
- scartare errori
- confermare solo eventi ritenuti utilizzabili
- confermare esplicitamente la creazione project/entity quando proposta
- confermare esplicitamente la creazione project/entity quando richiesta da command intent
- usare la lista eventi per modificare un evento quando guidato dal comando “modifica evento”
- confermare separatamente il salvataggio evento dopo eventuale creazione project/entity
- distinguere tra Torna alla home e Annulla modifica
- verificare il riepilogo feedback solo come conferma UI temporanea
- riconoscere quando è in modifica evento tramite il notice dedicato
- usare Annulla modifica per uscire dall’edit mode prima di inserire nuovi comandi

---

Il sistema NON:

- valida automaticamente
- corregge automaticamente in modo semantico
- modifica eventi validati WRITTEN / ERROR
- decide definitivamente spesa/incasso
- decide definitivamente project/entity in caso di ambiguità
- decide qualità finale del dato
- crea project/entity automaticamente
- salva automaticamente eventi dopo creazione project/entity
- salva eventi da comandi puri
- crea eventi da “crea progetto...” o “crea entità...”
- modifica eventi automaticamente quando l’utente scrive “modifica evento”
- usa feedback_summary come dato persistente
- considera la navigation dock parte del lifecycle evento
- considera ui_visibility_mode parte del lifecycle evento
- considera ui_visibility_state parte del lifecycle evento
- cambia stato evento quando cambia visibilità UI
- apre Command Intent durante edit mode

------------------------------------------------
QUALITÀ DEL DATO
------------------------------------------------

Dato in NEW dopo Normalization / Duration / Type / Match Base:

- amount/unit più coerenti
- formato numerico gestito
- numeri senza unità non salvati come amount
- durate certe ore/minuti salvate in minuti
- raw_input preservato
- type valorizzato a livello base
- project/entity più coerenti se match univoco o scelti manualmente
- ambiguità project/entity non risolta bloccata lato frontend
- nessun match project/entity consente salvataggio con project_id/entity_id null
- project/entity possono essere creati inline prima del salvataggio evento
- project/entity creati inline migliorano il collegamento dell’evento
- l’evento resta non validato fino a WRITTEN
- non è ancora validato dall’utente

Nota Command Intent:

i comandi puri non producono dati NEW.

La creazione project/entity da command può migliorare la struttura disponibile
per eventi futuri, ma non produce un evento NEW.

---

Dato in NEW dopo Normalization Layer Base:

- amount/unit più coerenti
- formato numerico gestito
- numeri senza unità non salvati come amount
- raw_input preservato
- project/entity ancora soggetti ad ambiguità
- type ancora non affidabile

---

Dato in WRITTEN:

- validato manualmente
- utilizzabile
- non necessariamente normalizzato semanticamente
- non necessariamente pronto per KPI evoluti
- type/matching base aiutano ma non sostituiscono validazione e qualità dati avanzata

---

Dato normalizzato avanzato futuro:

- coerente
- standardizzato
- analizzabile
- eventualmente classificato
- eventualmente relazionato

------------------------------------------------
NORMALIZATION / DURATION / TYPE BASE NEL LIFECYCLE
------------------------------------------------

Il lifecycle attuale include ora più livelli di miglioramento dati
prima dell’inserimento o modifica dell’evento.

Normalizzazione implementata:

- amount
- unit
- event_date
- durate certe ore/minuti
- type base

---

Esempi:

1.500,50 euro  
→ amount 1500.5  
→ unit euro  

1ora lavoro  
→ amount 60  
→ unit minuti  
→ type Tempo  

1 ora e 15 minuti sopralluogo  
→ amount 75  
→ unit minuti  
→ type Tempo  

2h30 rendering  
→ amount 150  
→ unit minuti  
→ type Tempo  

20 euro spesa materiale  
→ amount 20  
→ unit euro  
→ type Spesa  

20 euro incasso cliente  
→ amount 20  
→ unit euro  
→ type Incasso  

villa 2 mario  
→ amount null  
→ unit null  
→ type Evento  

---

Regole:

- amount salvato come numero
- unit salvata come testo normalizzato
- raw_input preservato
- numeri senza unità non diventano amount
- durate certe ore/minuti salvate come minuti
- type salvato da select1.value
- nessuna modifica schema DB
- nessuna validazione automatica evento

---

Non implementato:

- giorni/settimane convertiti automaticamente
- giornata / mezza giornata
- parole numeriche tipo “due ore”
- forme colloquiali tipo “un paio d’ore”
- amount firmato
- direction field
- type classification avanzata
- retro-normalizzazione storico

------------------------------------------------
INTEGRAZIONE CON INPUT SYSTEM
------------------------------------------------

INPUT SYSTEM:

- genera eventi NEW
- consente modifica eventi NEW
- usa input_home come input utente
- usa input_raw come adapter tecnico
- usa parse_input_controlled come parser runtime
- usa ui_state.parsed come fonte unica dei dati strutturati
- usa select1.value come fonte type
- usa project_state/entity_state come fonte minima matching
- usa select_project/select_entity come fonte project_id/entity_id
- usa create_suggestion_state per suggestion project/entity
- usa command_intent_state per distinguere comandi puri da eventi ordinari
- usa ui_visibility_mode per distinguere visivamente empty / event / command
- usa input_analysis_result per governare gli Hidden principali del flow input migrati
- mantiene ui_visibility_state come residuo tecnico deprecabile / rollback
- usa text_input_analysis_loading come micro-stato UX
- usa text_edit_mode_notice per chiarire edit mode
- usa insert_project / insert_entity solo su conferma utente
- usa btn_command_create_project / btn_command_create_entity per project/entity da command
- usa btn_command_go_events per guidare alla lista eventi da “modifica evento”
- usa feedback_mode per distinguere feedback evento/progetto/entità
- usa feedback_summary per riepilogo feedback temporaneo
- usa routing post-save contestuale
- usa cancel contestuale create/edit

---

Create flow evento ordinario:

input_home  
→ input_raw  
→ trigger_parse_debounced  
→ ui_visibility_mode  
→ command_intent_state  
→ se NON è comando puro  
→ parse_input_controlled  
→ ui_state.parsed  
→ project_state / entity_state  
→ create_suggestion_state  
→ input_analysis_result  
→ eventuale insert_project / insert_entity inline su conferma utente  
→ select_project / select_entity  
→ select1  
→ feedback_summary  
→ button_input_confirm  
→ insert_event  
→ feedback temporaneo  
→ Home  
→ NEW

Command flow strutturale:

input_home  
→ input_raw  
→ trigger_parse_debounced  
→ ui_visibility_mode  
→ command_intent_state  
→ input_analysis_result  
→ se è comando puro  
→ container_command_intent  
→ eventuale btn_command_create_project / btn_command_create_entity / btn_command_go_events  
→ insert_project / insert_entity oppure Lista eventi  
→ feedback temporaneo project/entity oppure Lista eventi  
→ nessun evento NEW

---

Edit flow:

evento NEW selezionato  
→ window.__logos_editing_event_value = item  
→ editing_event  
→ window.__logos_edit_mode_value = true  
→ edit_mode  
→ load raw_input  
→ text_edit_mode_notice visibile  
→ input_home  
→ input_raw  
→ parse_input_controlled  
→ project_state / entity_state  
→ ui_state.parsed  
→ select_project / select_entity  
→ select1  
→ scelta utente  

Nota Command Intent:

scrivere “modifica evento” nell’input libero NON attiva edit_mode.

Il comando mostra solo una guida e il pulsante Vai agli eventi.

L’edit flow reale resta attivato solo da un evento NEW nella lista eventi
tramite il pulsante Modifica.

Nota UI Readiness:

Durante edit mode, il sistema mostra text_edit_mode_notice
e non lascia che Command Intent prenda controllo del flow.

Questo evita che una modifica evento venga interrotta da un comando scritto per errore.

Percorsi possibili:

1. Conferma con modifica reale:
button_input_confirm  
→ feedback_summary  
→ update_event  
→ events_new refresh  
→ reset edit_mode / editing_event senza additionalScope { value }  
→ feedback temporaneo  
→ Lista eventi  
→ NEW

1. Conferma senza modifiche reali:
button_input_confirm  
→ no-op edit guard  
→ nessun update_event  
→ reset edit_mode / editing_event senza additionalScope { value }  
→ NEW

1. Annulla:
btn_cancel_edit  
→ reset edit_mode / editing_event senza additionalScope { value }  
→ nessun update_event  
→ NEW
→ nessun feedback  
→ Lista eventi

1. Cancel create/input:

input in creazione  
→ Torna alla home  
→ reset input/select/ui_state.parsed  
→ nessun insert_event  
→ Home

Nota edit flow:

btn_edit rilancia anche project_state/entity_state.
Questo mantiene coerenti suggerimenti, select, hint e confirm guard
anche in modalità modifica evento.

Nota no-op:

Il sistema distingue edit reale da semplice apertura/conferma.
Questo evita aggiornamenti impropri di updated_at
e false label “modificato” nella lista eventi.

------------------------------------------------
HELPER EDIT FLOW
------------------------------------------------

Il lifecycle edit usa due helper tecnici Retool:

- edit_mode
- editing_event

Ruolo:

edit_mode:

- distingue create flow da edit flow
- abilita Annulla
- permette a button_input_confirm di scegliere insert_event oppure update_event

editing_event:

- conserva l’evento NEW attualmente in modifica
- permette il confronto no-op con i dati originali
- viene azzerato quando l’edit termina

Dopo Linting / State Helper Cleanup,
questi helper non usano più:

additionalScope: { value }

Nuovo pattern:

- il chiamante scrive una chiave tecnica temporanea su window
- l’helper legge la chiave
- l’helper cancella la chiave dopo la lettura
- l’helper ritorna il valore controllato

Chiavi tecniche:

- window.__logos_edit_mode_value
- window.__logos_editing_event_value

Uso nel lifecycle:

btn_edit:

- valorizza window.__logos_editing_event_value con l’evento selezionato
- rilancia editing_event
- valorizza window.__logos_edit_mode_value = true
- rilancia edit_mode

btn_cancel_edit:

- valorizza window.__logos_edit_mode_value = false
- rilancia edit_mode
- valorizza window.__logos_editing_event_value = null
- rilancia editing_event

button_input_confirm:

- in caso di no-op edit, resetta edit_mode / editing_event tramite chiavi window
- in caso di update reale, dopo save ed events_new refresh resetta edit_mode / editing_event tramite chiavi window

button_input_confirm:

- in caso di update reale crea feedback_summary
- dopo update reale mostra feedback temporaneo
- dopo feedback torna alla lista eventi
- in caso di no-op edit non mostra feedback

cancel contestuale:

- in create/input mode torna Home senza creare eventi
- in edit mode torna Lista eventi senza update_event

Command Intent:

- non usa edit_mode
- non usa editing_event
- non attiva update_event
- btn_command_go_events fa solo routing alla lista eventi

UI Readiness / input_analysis_result:

- legge edit_mode per determinare la visibilità del flow
- mostra text_edit_mode_notice quando edit_mode è true
- governa gli Hidden principali migrati del flow input
- non modifica edit_mode
- non modifica editing_event
- non modifica update_event
- non costruisce payload
- non modifica lifecycle evento

ui_visibility_state resta residuo tecnico deprecabile / rollback.

Effetto:

- linting edit_mode risolto
- linting editing_event risolto
- edit flow invariato nel comportamento
- lifecycle invariato negli stati
- DB invariato
- nessuna modifica a parser, matching, preview, type o duration

------------------------------------------------
INTEGRAZIONE CON MATCHING
------------------------------------------------

Il Match Engine First Controlled Level:

- riduce ambiguità in fase input
- migliora suggerimenti
- supporta selezione project/entity
- alimenta select_project/select_entity tramite singleMatch
- alimenta hint ambiguità tramite isAmbiguous
- alimenta highlight preview tramite matches
- può bloccare conferma se ci sono ambiguità project/entity non risolte

---

Fonte minima matching:

project_state  
entity_state  

Output:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

Regole:

match univoco  
→ select valorizzata  
→ conferma consentita  

match ambiguo non risolto  
→ select vuota  
→ hint rosso  
→ conferma bloccata  

match ambiguo risolto manualmente  
→ select valorizzata  
→ conferma consentita  

nessun match  
→ select vuota  
→ project_id/entity_id null  
→ conferma consentita  

---

Importante:

matching ≠ validazione

---

Il matching NON:

- cambia stato evento
- valida evento
- normalizza amount/unit/event_date
- decide type
- decide spesa/incasso
- crea project/entity automaticamente
- salva automaticamente l’evento dopo creazione project/entity
- gestisce command intent
- decide se un input è comando puro
- risolve ambiguità in modo silenzioso

---

Project / Entity Create Suggestion:

- consuma project_state / entity_state
- può proporre creazione project/entity
- non decide project/entity al posto dell’utente
- non cambia lifecycle
- non valida evento

---

Command Intent:

- è separato dal matching
- intercetta comandi puri
- può creare project/entity solo tramite conferma utente
- non modifica project_state / entity_state
- non modifica create_suggestion_state
- non cambia lifecycle evento
- non valida evento

UI Readiness:

- legge project_state / entity_state solo per visibilità/hint
- non modifica matching
- non modifica select_project / select_entity come fonti salvabili
- non cambia lifecycle evento
- non valida evento

---

Limiti:

- match engine avanzato separato non implementato
- fuzzy matching non implementato
- alias system non implementato
- entity/project hierarchy assente
- deduplicazione assente
- creazione guidata project/entity implementata a primo livello controllato
- suggestion create vs edit consistency da verificare
- project creation override con match generico non implementato

------------------------------------------------
INTEGRAZIONE CON PREVIEW
------------------------------------------------

La preview:

- mostra dati parsati
- mostra dati normalizzati base
- mostra label runtime
- mostra project/entity
- mostra hint
- aiuta l’utente prima della conferma

---

La preview NON:

- modifica DB
- valida evento
- cambia stato
- è fonte del salvataggio
- rappresenta comandi puri come eventi

---

Fonte dati strutturata condivisa:

ui_state.parsed

---

Stato attuale:

- preview allineata visualmente a amount/unit/date
- preview allineata alla duration normalization base
- preview mostra type tramite select1
- preview legge project_state/entity_state per hint/highlight matching
- preview non è fonte del salvataggio
- preview resta layer ibrido
- per i comandi puri la preview viene sostituita da container_command_intent

Dopo Input Analysis Result — Visibility Migration Completion:

- la visibilità preview è governata da input_analysis_result.readiness.canShowEventPreview
- container_command_intent è governato da input_analysis_result.readiness.canShowCommandContainer
- Dati evento è governato da input_analysis_result.readiness.canShowEventData
- Conferma evento è governata da input_analysis_result.readiness.canShowConfirm
- la preview resta visuale e non salva
- input_analysis_result non è fonte lifecycle
- ui_visibility_state resta residuo tecnico deprecabile / rollback

Limite attuale:

la preview non è ancora una view pura.
UI Readiness ha stabilizzato quando mostrarla,
ma non ha modificato il contenuto interno della Sintesi.

Dopo Command Intent:

i comandi puri sono esclusi dalla preview evento,
ma “Da verificare” e altri hint restano ancora embedded nella Sintesi
per gli eventi ordinari.

Restano embedded:

- label cleaning
- hint duration/type
- hint matching
- highlight
- formattazioni locali

------------------------------------------------
INTEGRAZIONE CON DATABASE
------------------------------------------------

Database:

Supabase

Tabelle principali:

- events
- projects
- entities

---

Ruolo DB:

- persistenza eventi
- persistenza stato
- fetch lista eventi
- update status
- update eventi NEW

---

Il database NON:

- interpreta input
- normalizza
- valida
- decide stato
- gestisce semantica
- mantiene storico revisioni
- decide type
- decide project/entity
- risolve ambiguità
- crea project/entity automaticamente
- salva evento automaticamente dopo insert_project / insert_entity
- salva feedback_summary
- salva feedback_mode
- interpreta command intent
- crea eventi da comandi puri
- conosce ui_visibility_mode
- conosce input_analysis_result
- conosce ui_visibility_state
- salva ui_visibility_mode
- salva input_analysis_result
- salva ui_visibility_state
- modifica eventi in base alla visibilità UI

---

Campi evento principali:

- id
- created_at
- event_date
- project_id
- entity_id
- type
- amount
- unit
- raw_input
- payload
- status
- updated_at

Fonti runtime dei campi:

- amount / unit / event_date → ui_state.parsed
- type → select1.value
- project_id → select_project.value
- entity_id → select_entity.value
- raw_input → input_raw.value

Project/entity creation:

- insert_project scrive nella tabella projects
- insert_entity scrive nella tabella entities
- entrambe le azioni avvengono solo su conferma utente
- possono essere invocate da suggestion inline oppure da command intent
- nessuna delle due azioni crea automaticamente un evento
- nessun comando puro crea automaticamente un record in events
- Nessun cambio di visibilità UI crea o modifica un record in events.

------------------------------------------------
INTEGRAZIONE CON PROCESSING
------------------------------------------------

Lista eventi NEW:

events_new

---

Query:

events?select=*&status=eq.NEW&order=updated_at.desc.nullslast,created_at.desc

---

Azioni:

NEW → WRITTEN  
NEW → ERROR  
NEW → NEW (EDIT con modifica reale)  
NEW → NEW (ANNULLA EDIT)  
NEW → NEW (EDIT NO-OP)  
CREATE INPUT → HOME (nessun evento creato) 
COMMAND INPUT → HOME / EVENTS LIST (nessun evento creato)
UI VISIBILITY CHANGE → nessun evento creato / nessun evento modificato

---

Dopo insert/update:

button_input_confirm attende il completamento del salvataggio
e poi aggiorna events_new.

Dopo insert reale:

- feedback temporaneo 1800 ms
- ritorno Home

Dopo update reale:

- feedback temporaneo 1800 ms
- ritorno Lista eventi

Dopo no-op edit:

- nessun feedback
- ritorno immediato Lista eventi

Dopo command create project:

- insert_project
- feedback project_created
- ritorno Home
- nessun evento NEW

Dopo command create entity:

- insert_entity
- feedback entity_created
- ritorno Home
- nessun evento NEW

Dopo command “modifica evento”:

- routing Lista eventi
- nessun update_event
- nessun evento modificato

Dopo cambio ui_visibility_mode / input_analysis_result / ui_visibility_state:

- nessun insert_event
- nessun update_event
- nessun cambio status
- nessun updated_at aggiornato

Ordine corretto:

savePromise  
→ await savePromise  
→ await events_new.trigger()  

---

Problema risolto:

Prima:

- update_event aggiornava correttamente il DB
- events_new veniva aggiornato troppo presto
- la lista mostrava temporaneamente il dato vecchio
- refresh pagina mostrava il dato corretto

Dopo:

- lista aggiornata subito dopo update
- nessun refresh pagina necessario

---

Lista eventi dopo UX Cleanup:

La lista eventi NEW supporta ora:

- ricerca/filtro client-side
- label creato/modificato
- marcatore leggero per eventi modificati

La ricerca non modifica il lifecycle.

La label creato/modificato è UX di processing:

- non viene persistita
- non cambia status
- non valida evento
- non modifica DB

Regole label:

- evento mai modificato → creato
- evento modificato realmente → modificato
- edit annullato → resta creato/modificato come prima
- edit senza modifiche reali → resta creato/modificato come prima

Dopo Linting / State Helper Cleanup:

- edit reale resetta edit_mode / editing_event dopo update_event completato
- annulla edit resetta edit_mode / editing_event senza update_event
- edit no-op resetta edit_mode / editing_event senza update_event
- nessuno di questi reset modifica direttamente il lifecycle dell’evento

Dopo UX Mobile Coherence Pass:

- lista eventi rifinita graficamente
- navigation dock visibile in alto
- search bar mobile rifinita
- pulsanti OK / No / Modifica rifiniti

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- editing limitato a eventi NEW
- nessuna correzione post-WRITTEN
- nessuna correzione post-ERROR
- nessun tracking storico modifiche
- no-op edit guard evita update non necessari ma non crea storico revisioni
- nessuna revisione batch
- assenza versioning modifiche
- update distruttivo su evento NEW solo quando avviene modifica reale
- dati storici non retro-normalizzati
- giorni/settimane non convertiti automaticamente
- type classification avanzata non implementata
- amount firmato non implementato
- direction field non implementato
- match engine avanzato separato non implementato
- alias system non implementato
- fuzzy matching non implementato
- project/entity hierarchy non implementata
- deduplicazione project/entity non implementata
- creazione guidata project/entity implementata a primo livello controllato
- suggestion create vs edit consistency da verificare
- project creation override con match generico non implementato
- preview ancora layer ibrido
- output/KPI non attivi
- Dashboard non implementata
- Azioni rapide non operative
- Cambia / Scegli nella Sintesi non cliccabili
- feedback_summary non persistente
- feedback_mode non persistente
- command intent implementato solo a primo livello controllato
- command intent avanzato non implementato
- input analysis model unico non implementato
- input_analysis_result implementato come layer compositivo read-only e fonte UI controllata per gli Hidden principali del flow input
- input_analysis_result non è Input Analysis Model completo
- ui_visibility_state resta residuo tecnico deprecabile / rollback
- ui_visibility_mode implementato solo come latch UI
- UI Readiness / input_analysis_result non sono Input Analysis Model completo
- “modifica” generico non ancora riconosciuto come guida edit
- micro-flash feedback project/entity ancora presente come residuo UI non lifecycle
- linting Retool azzerati dopo Linting / Retool Query Safety Pass
- cleanup obsolete UI guards / query reduction non ancora eseguito
- navigation dock non rappresenta stato evento

------------------------------------------------
PROBLEMA STRUTTURALE
------------------------------------------------

La modifica eventi non è tracciata storicamente.

Conseguenze:

- update_event sovrascrive i valori precedenti
- updated_at mostra ultima modifica
- updated_at non cambia su Annulla
- updated_at non cambia su edit confermato senza modifiche reali
- raw_input mostra ultima versione
- non esiste audit trail revisioni
- non esiste event_version
- non esiste history table

---

NEW contiene eventi:

- non validati
- non necessariamente completi
- potenzialmente ambigui
- parzialmente normalizzati

---

WRITTEN:

- assume validità umana
- non garantisce qualità dati assoluta
- non garantisce normalizzazione avanzata
- non garantisce classificazione corretta

------------------------------------------------
ESTENSIONE FUTURA NON ATTIVA
------------------------------------------------

STATI POSSIBILI:

DRAFT

- evento incompleto

---

TO_REVIEW

- evento ambiguo

---

NORMALIZED

- evento pulito

---

LINKED

- relazioni corrette

---

ARCHIVED

- evento consolidato

---

REVISIONED

- evento con storico modifiche

------------------------------------------------
LIFECYCLE FUTURO MODELLO
------------------------------------------------

INPUT  
↓  
DRAFT  
↓  
TO_REVIEW  
↓  
WRITTEN  
↓  
NORMALIZED  
↓  
LINKED  
↓  
ARCHIVED  

---

Con storico revisioni:

NEW  
↓  
EDIT  
↓  
REVISIONED  
↓  
WRITTEN  

---

Nota:

NON implementato attualmente.

------------------------------------------------
INTERAZIONE CON ALTRI LAYER
------------------------------------------------

INPUT SYSTEM

→ genera eventi NEW  
→ consente modifica eventi NEW
→ consente annulla modifica senza update_event
→ impedisce update_event su edit senza modifiche reali 
→ usa helper edit_mode / editing_event senza additionalScope { value }
→ azzera editing_event al termine del flow edit
→ produce ui_state.parsed  
→ propone creazione project/entity controllata
→ non salva evento automaticamente dopo creazione project/entity
→ gestisce feedback_summary temporaneo
→ gestisce routing post-save contestuale
→ gestisce cancel create/edit contestuale
→ gestisce command_intent_state
→ intercetta comandi puri prima del save flow evento
→ gestisce feedback_mode per project/entity da command
→ non crea eventi da comandi puri
→ gestisce ui_visibility_mode
→ usa input_analysis_result come fonte UI controllata per gli Hidden principali del flow input
→ mantiene ui_visibility_state come residuo tecnico deprecabile / rollback
→ mostra text_edit_mode_notice durante edit mode
→ non modifica lifecycle tramite UI Readiness / input_analysis_result

---

NORMALIZATION BASE

→ normalizza amount/unit  
→ non valida evento  
→ non cambia lifecycle  

---

MATCH ENGINE

→ migliora suggerimenti  
→ alimenta select_project/select_entity  
→ blocca conferma in caso di ambiguità non risolta  
→ non cambia stato  
→ non valida evento   

---

PREVIEW

→ visualizza interpretazione  
→ non salva  
→ non valida  
→ visibilità governata da input_analysis_result.readiness.canShowEventPreview

---

COMMAND INTENT

→ distingue comando puro da evento ordinario  
→ non cambia stato evento  
→ non valida evento  
→ non crea eventi  
→ può creare project/entity solo tramite conferma utente  
→ può guidare alla lista eventi senza modificare dati  
→ non sostituisce edit flow reale  
→ non sostituisce matching  
→ non sostituisce suggestion  

---

UI READINESS / INPUT ANALYSIS RESULT

→ distingue visivamente empty / event / command tramite ui_visibility_mode
→ governa gli Hidden principali del flow input tramite input_analysis_result
→ mantiene ui_visibility_state come residuo tecnico deprecabile / rollback
→ non cambia stato evento
→ non valida evento
→ non crea eventi
→ non modifica eventi
→ non costruisce payload
→ non sostituisce command_intent_state
→ non sostituisce parser/matching/suggestion
→ non sostituisce Input Analysis Model completo

---

DATABASE

→ memorizza eventi  
→ non viene aggiornato dal reset degli helper edit_mode / editing_event
→ non interpreta  
→ non salva feedback_summary
→ non conosce navigation dock
→ non conosce routing UI post-save
→ non conosce command_intent_state
→ non conosce ui_visibility_state
→ non conosce ui_visibility_mode
→ non conosce feedback_mode
→ non intercetta comandi
→ non governa visibilità UI
→ non crea eventi da comandi puri

---

ENGINE FUTURO

→ match engine avanzato  
→ alias / fuzzy / ranking controllato  
→ economic direction advanced  
→ data structure / entity relations  
→ migliora confrontabilità dati   

---

OUTPUT FUTURO

→ utilizza dati affidabili  
→ richiede normalizzazione sufficiente  

---

UX MOBILE COHERENCE PASS

→ migliora Home, Input, Events list e Feedback
→ migliora navigazione senza modificare lifecycle eventi
→ introduce navigation dock contestuale
→ introduce feedback temporaneo con routing post-save
→ consolida font-size 16px input/select mobile Safari
→ non modifica stati evento
→ non modifica DB

------------------------------------------------
OBIETTIVO LIFECYCLE
------------------------------------------------

Trasformare eventi:

da input grezzo  
a dato affidabile  

---

Senza bloccare l’utente.

---

Strategia:

1. salvare velocemente
1A. proporre creazione project/entity solo quando utile e controllata
1B. non salvare automaticamente eventi dopo creazione project/entity
1C. non salvare comandi puri come eventi
1D. guidare comandi strutturali verso azioni controllate separate
1E. coordinare visibilità input tramite input_analysis_result senza trasformarla in lifecycle evento
1F. mantenere edit mode prevalente su Command Intent
2. correggere in NEW
2A. evitare aggiornamenti inutili se l’edit non cambia il dato
2B. permettere uscita sicura dall’edit senza salvare
2C. chiudere in modo pulito edit_mode / editing_event al termine del flow edit
2D. usare feedback breve e routing contestuale per non bloccare il flusso utente
3. normalizzare progressivamente
4. validare manualmente
5. usare per output solo quando sufficientemente affidabile

------------------------------------------------
VINCOLI OPERATIVI
------------------------------------------------

- non modificare struttura stati senza nodo dedicato
- non introdurre stati inutili
- mantenere semplicità
- non modificare eventi WRITTEN/ERROR
- non introdurre versioning senza decisione architetturale
- non usare dati non affidabili per KPI evoluti
- non confondere normalization base con validazione
- non confondere command intent con lifecycle evento
- non creare eventi da comandi puri
- non aprire edit flow automatico da “modifica evento”
- non usare feedback project/entity come stato evento
- non usare ui_visibility_mode come stato evento
- non usare input_analysis_result come stato evento
- non usare ui_visibility_state come stato evento
- non confondere visibility/readiness UI con transizione lifecycle
- non aprire Command Intent durante edit mode
- non trasformare UI Readiness in Input Analysis Model completo senza nodo dedicato

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il lifecycle attuale è:

✔ semplice  
✔ stabile  
✔ coerente con append-only controllato  
✔ compatibile con uso reale  
✔ migliorato da editing NEW  
✔ migliorato da normalization base  
✔ migliorato da duration normalization base  
✔ migliorato da type classification base  
✔ migliorato da match engine unification first controlled level  
✔ migliorato da UX / Cleanup Micro-Batch Post Match Engine
✔ edit mode ora supporta Annulla
✔ edit senza modifiche reali non aggiorna updated_at
✔ lista eventi distingue creato/modificato in modo più coerente
✔ linting / state helper cleanup completato
✔ edit_mode / editing_event non usano più additionalScope { value }
✔ editing_event viene azzerato anche dopo update reale completato
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ creazione project/entity inline controllata
✔ evento non salvato automaticamente dopo creazione project/entity
✔ UX Mobile Coherence Pass completato
✔ feedback temporaneo stabilizzato
✔ routing post-save contestuale
✔ insert → feedback → Home
✔ update → feedback → Lista eventi
✔ no-op edit → Lista eventi senza feedback
✔ cancel create/input → Home
✔ cancel edit → Lista eventi
✔ navigation dock introdotta come UI contestuale
✔ font-size 16px input/select mobile Safari validato
✔ Command Intent — Create Project / Entity completato
✔ command_intent_state introdotto come helper separato
✔ comandi puri esclusi dal lifecycle evento
✔ crea progetto / crea entità non generano eventi NEW
✔ project/entity da command creati solo previa conferma utente
✔ feedback project_created / entity_created introdotto
✔ “modifica evento” da command gestito come guida non operativa
✔ evento ordinario non regressivo dopo Command Intent validato
✔ edit flow non regressivo dopo Command Intent validato
✔ UI Readiness / Visibility Aggregator First Controlled Level completato
✔ Input Analysis Result / Single Interpretation Layer Base introdotto come layer compositivo read-only
✔ Input Analysis Result — Controlled UI Consumption Pass completato
✔ Input Analysis Result — Visibility Migration Completion completato
✔ ui_visibility_mode introdotto come latch UI empty / event / command
✔ input_analysis_result consolidato come fonte UI controllata per gli Hidden principali del flow input
✔ ui_visibility_state riclassificato come residuo tecnico deprecabile / rollback
✔ input_analysis_result non legge più ui_visibility_state
✔ UI Readiness / input_analysis_result non introducono nuovi stati evento
✔ UI Readiness / input_analysis_result non modificano NEW / WRITTEN / ERROR
✔ container vuoto durante digitazione risolto
✔ flash input flow ridotto
✔ bottom bar flash risolto
✔ edit mode chiarito tramite text_edit_mode_notice
✔ edit mode prevale su Command Intent
✔ durante edit mode scrivere “crea” non apre Command Intent
✔ test obbligatori 1–16 superati dopo UI Readiness

---

Ma:

⚠ non scalabile su revisioni  
⚠ non controlla qualità dato in modo assoluto  
⚠ editing introduce violazione controllata del modello append-only  
⚠ accettata per migliorare qualità dati prima della validazione  
⚠ non gestisce storico modifiche  
✔ distingue Spesa/Incasso/Tempo/Evento a livello base  
✔ normalizza durate certe ore/minuti  
⚠ non gestisce direzione economica avanzata  
⚠ non normalizza giorni/settimane  
⚠ suggestion create vs edit consistency da verificare
⚠ project creation override con match generico non implementato
⚠ Azioni rapide non operative
⚠ Dashboard non implementata
⚠ Command Intent è solo primo livello controllato
⚠ command intent avanzato non implementato
⚠ input analysis model unico non implementato
⚠ input_analysis_result è layer compositivo read-only e non Input Analysis Model completo
⚠ ui_visibility_state resta residuo tecnico deprecabile / rollback
⚠ “modifica” generico non ancora riconosciuto come guida edit
⚠ micro-flash feedback project/entity residuo UI non lifecycle
✔ linting Retool azzerati dopo Linting / Retool Query Safety Pass

---

Evoluzione necessaria:

solo dopo stabilizzazione:

1. input reliability ✔  
2. matching base ✔  
3. label quality ✔  
4. input stabilization ✔  
5. normalization layer base ✔  
6. preview alignment ✔  
7. duration normalization ✔  
8. type classification ✔  
9. match engine unification first controlled level ✔  
10. UX / cleanup post match engine ✔  
11. linting / state helper cleanup ✔  
12. Project / Entity Create Suggestion First Controlled Level ✔
13. UX Mobile Coherence Pass ✔
14. Command Intent — Create Project / Entity ✔
15. UI Readiness / Visibility Aggregator ✔
16. Preview Analysis State / Input Analysis Result First Controlled Layers ✔
17. Input Analysis Result — Visibility Migration Completion ✔
18. Linting / Retool Query Safety Pass ✔
19. preview / hint consolidation
20. input analysis model completo / single interpretation layer avanzato
21. data structure / project-entity evolution
22. economic direction advanced
23. output / dashboard base

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01  
- definizione lifecycle base  

v02 — 2026-04-03  
- integrazione matching layer  
- chiarita separazione matching / lifecycle  
- esplicitata qualità dato  
- allineamento con stato reale sistema

v03 — 2026-04-23  

- introduzione editing eventi (NEW → NEW)
- aggiornamento modello append-only controllato
- introduzione update_event
- aggiornamento responsabilità utente
- allineamento lifecycle con sistema reale

v04 — 2026-04-30  

- integrazione Normalization Layer Base nel lifecycle
- chiarito che normalization base non equivale a validazione
- documentato uso di ui_state.parsed in create/edit
- aggiornato create flow con parse_input_controlled
- aggiornato edit flow con update_event e ui_state.parsed
- documentato refresh events_new dopo save completato
- documentata correzione race condition update → lista
- esplicitati limiti: no versioning, no duration normalization, no type classification

v05 — 2026-05-02  

- integrazione Duration Normalization Base nel lifecycle
- integrazione Type Classification Base nel lifecycle
- integrazione Match Engine Unification First Controlled Level nel lifecycle
- aggiornato flow: input → parsing → normalization → duration → type → match state → select → preview → insert/update
- documentato type da select1.value
- documentato project_id da select_project.value
- documentato entity_id da select_entity.value
- documentato match state live in create/edit flow
- documentato btn_edit con rilancio project_state/entity_state
- documentato confirm guard su ambiguità project/entity non risolta
- chiarito che matching migliora qualità ma non valida evento
- chiarito che nessun match non blocca salvataggio
- chiarito che ambiguità risolta manualmente consente salvataggio
- aggiornati limiti: no alias, no fuzzy, no gerarchie, no deduplicazione, no creazione guidata project/entity
- confermato DB passivo
- confermato lifecycle invariato negli stati NEW / WRITTEN / ERROR
- nessun output/KPI anticipato

v06 — 2026-05-02  

- integrazione UX / Cleanup Micro-Batch Post Match Engine nel lifecycle
- documentato btn_cancel_edit
- documentato Annulla modifica come NEW → NEW senza update_event
- documentato reset edit_mode / editing_event / input / select / ui_state.parsed
- documentato no-op edit guard
- documentato edit senza modifiche reali come NEW → NEW senza update_event
- chiarito che updated_at non cambia su Annulla
- chiarito che updated_at non cambia su edit confermato senza modifiche reali
- documentata distinzione tra edit reale e conferma senza variazioni
- documentata label lista eventi creato/modificato
- documentato search/filter client-side lista eventi come processing UX
- chiarito che ricerca e label lista non modificano lifecycle
- WRITTEN / ERROR rivalidati dopo cleanup UX
- create/edit/lista/annulla/search validati
- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- nessun output/KPI anticipato

v07 — 2026-05-03  

- integrazione LINTING / STATE HELPER CLEANUP nel lifecycle
- documentata risoluzione linting edit_mode: 'value' is not defined
- documentata risoluzione linting editing_event: 'value' is not defined
- rimossa dipendenza da additionalScope { value } per edit_mode / editing_event
- documentato passaggio controllato tramite window.__logos_edit_mode_value
- documentato passaggio controllato tramite window.__logos_editing_event_value
- documentato btn_edit con valorizzazione window helper
- documentato btn_cancel_edit senza additionalScope { value }
- documentato button_input_confirm senza additionalScope { value } nel reset helper
- documentato reset edit_mode / editing_event nel ramo no-op edit
- documentato reset edit_mode / editing_event dopo update reale completato
- chiarito che reset helper non modifica lifecycle evento
- chiarito che reset helper non modifica DB
- create flow validato
- edit flow validato
- annulla modifica validato
- edit senza modifiche reali validato
- edit con modifica reale validato
- updated_at / label creato-modificato validati
- WRITTEN / ERROR rivalidati
- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- preview invariata
- lista eventi invariata
- nessun output/KPI anticipato

v08 — 2026-05-09

- integrazione PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL nel lifecycle
- documentata creazione guidata project/entity come supporto al NEW event flow
- documentato che insert_project / insert_entity non salvano automaticamente eventi
- documentato che select_project / select_entity restano decisione utente finale
- documentato che project/entity mancanti non bloccano salvataggio evento
- documentato che ambiguità project/entity non risolte bloccano conferma
- integrazione UX MOBILE COHERENCE PASS nel lifecycle
- documentato feedback_summary come UI temporanea non persistente
- documentato feedback post-save temporaneo
- documentato routing post-save contestuale
- documentato insert reale → feedback 1800 ms → Home
- documentato update reale → feedback 1800 ms → Lista eventi
- documentato no-op edit → Lista eventi senza feedback
- documentato cancel create/input → Home
- documentato cancel edit → Lista eventi
- chiarito che feedback, Home, Lista eventi e navigation dock non sono stati evento
- documentata navigation dock come UI contestuale
- documentato font-size 16px input/select mobile Safari
- documentato fix zoom automatico iOS Safari
- documentate select mobile funzionanti sia in digitazione sia in dropdown
- confermati stati evento NEW / WRITTEN / ERROR invariati
- DB invariato
- parser invariato
- matching invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato

v09 — 2026-05-13

- integrazione COMMAND INTENT — CREATE PROJECT / ENTITY nel lifecycle
- documentato command_intent_state come helper separato dal lifecycle evento
- chiarito che comandi puri non generano eventi NEW
- chiarito che “crea progetto...” non salva eventi
- chiarito che “crea entità...” non salva eventi
- chiarito che “modifica evento” da command non apre edit flow automatico
- documentato container_command_intent come UI command separata dalla preview evento
- documentati btn_command_create_project / btn_command_create_entity / btn_command_go_events
- documentato feedback_mode
- documentato feedback project_created
- documentato feedback entity_created
- documentato che feedback project/entity non è stato evento
- documentato command create project → insert_project → feedback → Home → nessun evento
- documentato command create entity → insert_entity → feedback → Home → nessun evento
- documentato command guida modifica evento → Lista eventi → nessun update_event
- aggiornato flow attuale con COMMAND INTENT CHECK
- aggiunta sezione COMMAND INTENT NEL LIFECYCLE
- aggiunta pseudo-transizione COMMAND INPUT → HOME / EVENTS LIST come non-transizione evento
- aggiornata integrazione con Input System
- aggiornata integrazione con Matching
- aggiornata integrazione con Preview
- aggiornata integrazione con Database
- aggiornata integrazione con Processing
- aggiornati limiti attuali
- confermati stati evento invariati: NEW / WRITTEN / ERROR
- evento ordinario non regressivo validato
- edit flow non regressivo validato
- DB invariato
- parser invariato
- matching invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato

v10 — 2026-05-18

- integrazione UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL nel lifecycle
- integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
- integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- documentato ui_visibility_mode come latch UI empty / event / command
- documentato ui_visibility_state come aggregatore read-only di visibilità input flow
- chiarito che UI Readiness non introduce nuovi stati evento
- confermati stati evento invariati: NEW / WRITTEN / ERROR
- chiarito che ui_visibility_mode non è stato evento
- chiarito che ui_visibility_state non è stato evento
- documentato UI VISIBILITY CHANGE come non-transizione evento
- aggiornato flow attuale con UI VISIBILITY MODE CHECK
- aggiornata integrazione con Input System
- aggiornata integrazione con Preview
- aggiornata integrazione con Database
- aggiornata integrazione con Processing
- documentato text_edit_mode_notice come supporto UX al lifecycle edit
- documentato edit mode prevalente su Command Intent
- documentato che durante edit mode scrivere “crea” non apre Command Intent
- documentato che per uscire da edit flow bisogna usare Annulla modifica
- documentato che UI Readiness non modifica insert_event / update_event
- documentato che UI Readiness non modifica insert_project / insert_entity
- documentato che UI Readiness non modifica parser/matching/suggestion/DB
- documentato container vuoto durante digitazione risolto
- documentato flash input flow ridotto
- documentato bottom bar flash risolto
- documentato micro-flash feedback project/entity come residuo UI non lifecycle
- documentato residuo “modifica” generico non riconosciuto come guida edit
- documentati 5 linting Retool residui
- corretto blocco Database: DB non conosce command_intent_state / ui_visibility_state / ui_visibility_mode / feedback_mode
- test obbligatori 1–16 superati dopo UI Readiness
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- command_intent_state invariato
- save flow evento ordinario invariato
- nessun output/KPI anticipato

v11 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicata normalizzazione controllata Pacchetto A — Allineamento alto / Lifecycle / Supabase
- allineato il lifecycle allo stato post INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
- allineato il lifecycle allo stato post LINTING / RETOOL QUERY SAFETY PASS
- aggiornato il documento da UI READINESS / VISIBILITY a UI READINESS / INPUT ANALYSIS RESULT dove necessario
- introdotto input_analysis_result come layer compositivo read-only non lifecycle
- documentato input_analysis_result come fonte UI controllata per gli Hidden principali del flow input
- riclassificato ui_visibility_state come residuo tecnico deprecabile / rollback
- chiarito che ui_visibility_state non è più letto da input_analysis_result
- chiarito che ui_visibility_state non governa più gli Hidden principali migrati
- chiarito che input_analysis_result non introduce nuovi stati evento
- chiarito che input_analysis_result non modifica NEW / WRITTEN / ERROR
- chiarito che input_analysis_result non salva dati, non costruisce payload e non modifica DB
- aggiornata sezione UI READINESS / INPUT ANALYSIS RESULT NEL LIFECYCLE
- aggiornati riferimenti in:
  - Principi fondanti
  - NEW
  - Flusso attuale
  - Integrazione con Input System
  - Integrazione con Preview
  - Integrazione con Database
  - Integrazione con Processing
  - Interazione con altri layer
  - Note strategiche
- aggiunti richiami canonici a:
  - 01_LOGOS_Input_System per input_analysis_result / raw / selection / effective / readiness
  - 04_LOGOS_Retool_Architecture per wiring e Hidden Retool
  - LOGOS_RETOOL_RUNTIME_REAL per stato runtime reale as-is
- aggiornati limiti:
  - input_analysis_result non è Input Analysis Model completo
  - ui_visibility_state resta residuo tecnico deprecabile / rollback
  - linting Retool azzerati dopo Linting / Retool Query Safety Pass
- confermati stati evento invariati:
  - NEW
  - WRITTEN
  - ERROR
- confermato che Command Intent, feedback, navigation dock, ui_visibility_mode, input_analysis_result e ui_visibility_state non sono stati evento
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica lifecycle reale
- nessuna anticipazione output / KPI / dashboard

v12 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicato Pacchetto C — Documenti tecnici canonici su 03_LOGOS_Event_Lifecycle
- documento aggiornato da v11 a v12
- confermato 03_LOGOS_Event_Lifecycle come fonte canonica per lifecycle evento, stati NEW / WRITTEN / ERROR, create flow, edit flow, update_event, no-op edit, annulla modifica, cancel create/edit, processing e vincoli sugli stati evento
- aggiunta sezione RESPONSABILITÀ CANONICA DEL DOCUMENTO
- chiarito che State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo del lifecycle evento
- chiarito che il dettaglio completo resta in questo documento e nei documenti canonici collegati
- aggiunti richiami canonici a:
  - 01_LOGOS_Input_System per input flow, parser, normalization, Command Intent, create_suggestion_state e input_analysis_result
  - 02_LOGOS_Match_Engine per Match Engine project/entity
  - 04_LOGOS_Retool_Architecture per componenti/query/Hidden/edit_mode/editing_event/button_input_confirm/insert_event/update_event/wiring Retool
  - 05_LOGOS_Database_Schema per schema DB e comportamento Supabase passivo
  - 06_LOGOS_View_Preview_System per Sintesi, preview, hint e warning
  - LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
  - LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase as-is
- nessuna riduzione aggressiva applicata
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica lifecycle reale
- nessuna anticipazione output / KPI / dashboard