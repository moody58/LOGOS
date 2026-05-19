# CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL

DATA: 2026-05-16  
PROGETTO: LOGOS  
STACK: Retool + Supabase  
NODO: UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL  
STATO: COMPLETATO  
ESITO: OK CON RESIDUI MINORI  

------------------------------------------------
1. CONTESTO
------------------------------------------------

Il nodo è stato aperto dopo il completamento di:

INPUT ANALYSIS READINESS CHECK

con esito:

GO CONDIZIONATO

Decisione consolidata:

LOGOS deve tendere in futuro a un INPUT ANALYSIS RESULT / INPUT ANALYSIS MODEL completo,
ma non nel nodo corrente.

Nel nodo corrente è stato implementato un primo livello controllato di aggregazione visibilità UI, con focus su:

- flow input
- distinzione evento / command intent
- riduzione Hidden duplicate
- riduzione flash / rendering progressivo
- stabilità mobile

------------------------------------------------
2. SCOPO DEL NODO
------------------------------------------------

Obiettivo operativo dichiarato:

creare una fonte di visibilità UI interrogabile dai componenti Retool,
centralizzare progressivamente guardie Hidden duplicate,
ridurre rendering progressivo / flash visivo,
migliorare stabilità del flow input,
senza modificare dati salvabili o logiche core.

------------------------------------------------
3. VINCOLI RISPETTATI
------------------------------------------------

Durante il nodo NON sono stati modificati:

- DB
- schema Supabase
- parser amount/unit/date
- normalization
- duration normalization
- type classification
- matching engine
- create_suggestion_state
- command_intent_state
- preview content / sintesi
- button_input_confirm payload
- insert_event / update_event
- insert_project / insert_entity
- save flow evento
- payload dati
- dashboard / KPI
- Input Analysis Model completo
- Event Interpretation Engine
- Data Structure

Sono state effettuate solo modifiche di visibilità UI e micro-stati frontend Retool.

------------------------------------------------
4. IMPLEMENTAZIONI COMPLETATE
------------------------------------------------

4.1 ui_visibility_state

Creato Transformer:

ui_visibility_state

Funzione:

aggregatore read-only di visibilità UI.

Ruolo:

leggere lo stato già prodotto dai layer esistenti
e restituire flag semplici per i componenti UI.

Flag principali consolidati:

- rawInput
- view
- visibilityMode
- hasInput
- isInputFlow
- isAnalyzing
- isCommand
- isPureCommand
- isEventFlow
- isEditMode
- hasAssociationSuggestion
- hasBlockingAmbiguity
- showCommandContainer
- showEventPreview
- showAssociationSuggestions
- showEventData
- showConfirm
- showCancelEdit
- showCancelInputHome

Nota:

isAnalyzing resta diagnostico.
Non viene usato come guardia principale di visibilità perché causava alternanza true/false e peggiorava il flash.

---

4.2 ui_visibility_mode

Creata Variable Retool:

ui_visibility_mode

Valori:

- empty
- event
- command

Funzione:

latch leggero di modalità UI input.

Comportamento:

empty   → input vuoto / nessun flow input attivo  
event   → evento ordinario  
command → command intent / guida command  

La modalità viene aggiornata da:

trigger_parse_debounced

e viene poi letta da:

ui_visibility_state

---

4.3 Aggiornamento trigger_parse_debounced

trigger_parse_debounced è stato aggiornato per impostare ui_visibility_mode in modo controllato.

Logica consolidata:

input vuoto → ui_visibility_mode = "empty"

input riconosciuto come comando visivo minimo:

- crea
- aggiungi
- inserisci
- nuovo
- nuova
- crea progetto
- crea entità
- modifica evento
- varianti base già presenti nelle vecchie guardie Hidden

→ ui_visibility_mode = "command"

altri input → ui_visibility_mode = "event"

È stato introdotto un token tecnico:

window.__logos_visibility_run_id

Scopo:

evitare che cicli debounce vecchi aggiornino la visibilità dopo input successivi.

Nota:

La classificazione locale in trigger_parse_debounced serve solo alla visibilità UI.
Non sostituisce command_intent_state.
Non salva dati.
Non modifica DB.
Non modifica parser/matching.

------------------------------------------------
5. COMPONENTI HIDDEN CENTRALIZZATI
------------------------------------------------

Sono stati centralizzati tramite ui_visibility_state i seguenti componenti:

- container_command_intent.Hidden
- sintesi.Hidden
- container_association_suggestions.Hidden
- text_event_data_title.Hidden
- select1.Hidden
- select_project.Hidden
- select_entity.Hidden
- button_input_confirm.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- container_input.Hidden

Formula ricorrente usata dove coerente:

```js
{{ !ui_visibility_state.value?.showEventData }}

Oppure flag specifici:

{{ !ui_visibility_state.value?.showCommandContainer }}
{{ !ui_visibility_state.value?.showEventPreview }}
{{ !ui_visibility_state.value?.showAssociationSuggestions }}
{{ !ui_visibility_state.value?.showConfirm }}
{{ !ui_visibility_state.value?.showCancelEdit }}
{{ !ui_visibility_state.value?.showCancelInputHome }}
{{ !ui_visibility_state.value?.isInputFlow }}
COMPONENTI NON CENTRALIZZATI / RISPETTATI

Come da perimetro iniziale, non sono stati governati direttamente dal nuovo aggregatore:

container_home
container_feedback
container_events_list
list_events

container_app_nav è stato modificato solo con micro-fix mirato per eliminare il flash della bottom bar.

MICRO-FIX container_app_nav

Problema rilevato:

bottom bar / navigation dock lampeggiava durante la digitazione.

Causa:

container_app_nav.Hidden leggeva input_raw.value,
che può aggiornarsi con ritardo rispetto a input_home.value.

Formula precedente:

{{
  !(
    ui_state.value?.view === "events" ||
    (ui_state.value?.view === "home" && !input_raw.value)
  )
}}

Formula aggiornata:

{{
  !(
    ui_state.value?.view === "events" ||
    (ui_state.value?.view === "home" && !input_home.value)
  )
}}

Esito:

flash bottom bar risolto.

MICRO-UX AGGIUNTE

8.1 text_input_analysis_loading

È stato riutilizzato/spostato il precedente Text debug come micro-messaggio:

Analisi input…

Collocazione finale:

area input_home, non dentro container_input

Motivo:

dentro container_input appariva troppo rapidamente e sembrava un bug.
Spostato vicino all’input principale risulta leggibile e colma il gap visivo durante il debounce.

Hidden:

{{
  !(
    input_home.value &&
    ui_visibility_state.value?.visibilityMode === "empty" &&
    edit_mode.data !== true
  )
}}

Esito:

messaggio coerente e non invasivo.

8.2 text_edit_mode_notice

Creato messaggio compatto per chiarire la modalità modifica evento.

Motivo:

Durante edit mode, scrivere "crea" non deve aprire Command Intent.
Il comportamento è corretto, ma prima non era chiaro per l’utente.

Contenuto finale:

<div style="
  padding: 8px 10px;
  border: 1px solid #fed7aa;
  background: #fff7ed;
  border-radius: 10px;
  color: #9a3412;
  font-size: 13px;
  line-height: 1.25;
">
  <strong>Evento in modifica</strong> · Premi Annulla modifica per uscire.
</div>

Hidden:

{{ edit_mode.data !== true }}

Esito:

edit mode ora più chiaro.
Command Intent resta correttamente disabilitato durante edit mode.

FEEDBACK PROJECT / ENTITY — ALLINEAMENTO

Sono stati allineati i flussi feedback di:

btn_command_create_project
btn_command_create_entity

con pattern comune:

preparare nextFeedbackState
await ui_state.setValue(nextFeedbackState)
micro-tick setTimeout 0
mostrare container_feedback

Scopo:

rendere project/entity coerenti nel timing del feedback.

Esito:

flussi project/entity allineati.
micro-flash feedback project/entity ancora presente.

Nota:

Il micro-flash residuo non è stato ulteriormente inseguito perché non bloccante,
non chiaramente identificabile e fuori dal focus principale del nodo.

TEST ESEGUITI

Test obbligatori completati:

evento normale
30 euro spesa villa citrignano
comando generico
crea
create project incompleto
crea progetto
create project completo
crea progetto Nome Test
create entity incompleto
crea entità
create entity completo
crea entità Nome Test
elemento già presente
crea progetto villa
guida edit
modifica evento
suggestion project/entity da evento normale
edit evento reale
edit no-op
annulla edit
feedback evento
feedback project/entity
events list
Home vuota + navigation dock

Esito:

TUTTI OK

REGRESSIONI VERIFICATE

Verificati senza regressioni:

evento normale
command intent
create project command
create entity command
elemento già presente
guida modifica evento
suggestion project/entity
edit evento reale
edit no-op
annulla edit
feedback evento
feedback project/entity
events list
Home vuota
navigation dock
container_input
bottom bar
RISULTATI RAGGIUNTI

Risultati effettivi:

flash input ridotto
container vuoto durante digitazione risolto
bottom bar flash risolto
Hidden duplicate principali centralizzati
flow event / command più stabile
edit mode preservato
edit mode più chiaro per l’utente
Command Intent preservato
Suggestion container preservato
save flow preservato
nessuna modifica DB
nessuna modifica parser/matching
test obbligatori superati
RESIDUI

Residui aperti:

Micro-flash feedback project/entity ancora presente.
Stato: residuo minore non bloccante.
5 linting ancora presenti.
Stato: non trattati nel nodo corrente.
Nota: da affrontare solo in eventuale nodo Linting / Minor Cleanup dedicato.
ui_visibility_mode contiene classificazione locale minima per la visibilità command/event.
Stato: accettata come latch UI, non come Command Intent engine.
COSA NON È STATO FATTO

Non è stato introdotto:

Input Analysis Model completo
Input Analysis Result strutturale
Event Interpretation Engine
Data Structure
Engine avanzato
dashboard/KPI
nuovo modello dati
nuove tabelle
nuovi payload salvabili
refactor preview
refactor command intent
cleanup componenti/query obsolete
DECISIONI CONSOLIDATE

Decisioni operative:

ui_visibility_state diventa fonte aggregata read-only per la visibilità del flow input.
ui_visibility_mode diventa latch UI leggero per distinguere empty/event/command.
Command Intent resta separato e non viene sostituito.
Edit mode prevale su Command Intent:
durante una modifica evento, scrivere "crea" resta testo dell’evento in modifica.
Per uscire, l’utente deve premere Annulla modifica.

Le guardie interne dei micro-editor project/entity restano locali.
Esempio:

{{ !entity_create_inline_open.value }}
container_home / container_feedback / container_events_list / list_events restano fuori dal governo diretto dell’aggregatore.
container_app_nav è stato corretto solo per bug visivo bottom bar, non rifatto.
STATO FINALE

NODO COMPLETATO
ESITO: OK CON RESIDUI MINORI
SISTEMA: STABILE
TEST: SUPERATI
REGRESSIONI: NON RILEVATE

RESIDUO MINORE — Command Intent guida edit generica

Attualmente “modifica evento” viene riconosciuto correttamente come guida alla modifica,
mentre “modifica” da solo viene ancora trattato come evento ordinario e mostra la Sintesi.

Da valutare in micro-nodo futuro:
COMMAND INTENT — EDIT GUIDE GENERIC ALIAS

Casi candidati:
- modifica
- correggi
- cambia

Vincolo:
non confondere frasi evento reali tipo “modifica preventivo villa” o “modifica colore bagno”
con comando guida.

RACCOMANDAZIONE PROSSIMO PASSO

Prima di aprire nuovi nodi operativi, aggiornare documentazione minima:

00_PROJECT_State
00_PROJECT_Roadmap
04_LOGOS_Retool_Architecture
LOGOS_RETOOL_RUNTIME_REAL
01_LOGOS_Input_System
06_LOGOS_View_Preview_System, solo se necessario
00_PROJECT_Gap_Register, solo per residuo feedback / linting se utile

Possibili nodi futuri da non aprire ora:

Feedback Micro-flash Cleanup
Linting / Minor Cleanup
Preview / Hint State Consolidation
Input Analysis Model / Single Interpretation Layer
Cleanup componenti/query obsolete