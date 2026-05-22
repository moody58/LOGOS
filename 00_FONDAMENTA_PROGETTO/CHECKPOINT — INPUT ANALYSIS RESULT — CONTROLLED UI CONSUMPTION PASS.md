#CHECKPOINT
@@LOGOS

TITOLO:
CHECKPOINT — INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS

DATA:
2026-05-20

PROGETTO:
LOGOS

STACK:
Retool + Supabase

NODO:
INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS

STATO:
COMPLETATO

ESITO:
OK CON RESIDUI NON BLOCCANTI

------------------------------------------------
1. CONTESTO
------------------------------------------------

Il nodo nasce dopo il completamento di:

1. PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
2. INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC

Situazione precedente:

- preview_analysis_state era già operativo nella Sintesi per:
  - hints
  - status
  - warning
  - “Da verificare”
  - associazioni mancanti
  - azioni consigliate

- input_analysis_result era stato creato come transformer read-only diagnostico,
  ma non era ancora fonte operativa per la UI.

Obiettivo del nodo corrente:

rendere input_analysis_result progressivamente operativo come fonte UI/readiness controllata,
senza modificare dati salvabili, parser, matching, suggestion, command intent, save flow o DB.

------------------------------------------------
2. VINCOLI RISPETTATI
------------------------------------------------

Durante il nodo NON sono stati modificati:

- DB
- schema Supabase
- parser
- parse_input_controlled
- normalization
- duration normalization
- type classification
- project_state
- entity_state
- create_suggestion_state
- command_intent_state
- insert_event
- update_event
- insert_project
- insert_entity
- button_input_confirm payload
- save flow
- select_project default/value logic
- select_entity default/value logic
- matching logic
- command logic

Non è stato implementato:

- Input Analysis Model completo
- Event Interpretation Engine
- Match Engine avanzato
- refactor globale
- sostituzione delle select
- sostituzione del save flow

------------------------------------------------
3. PRINCIPI ARCHITETTURALI CONSOLIDATI
------------------------------------------------

input_analysis_result NON è alternativo al Match Engine.

Gerarchia corretta:

parse_input_controlled
→ produce parsed

project_state / entity_state
→ producono match

select_project / select_entity
→ rappresentano la decisione finale corrente per project_id/entity_id

create_suggestion_state
→ produce suggestion operative

command_intent_state
→ produce command intent

preview_analysis_state
→ produce hint/status preview

input_analysis_result
→ compone raw + selection + effective state
→ diventa fonte progressiva di lettura UI/readiness

Regola confermata:

input_analysis_result legge le select,
ma NON le alimenta.

È vietato:

- usare input_analysis_result come default value delle select
- usare input_analysis_result per valorizzare select_project/select_entity
- usare input_analysis_result come fonte del payload save
- ricalcolare matching dentro input_analysis_result
- bypassare il controllo utente sulle select

------------------------------------------------
4. RAW / SELECTION / EFFECTIVE STATE
------------------------------------------------

È stata introdotta e validata la distinzione:

RAW:
stato tecnico prodotto dai layer esistenti.

SELECTION:
valore attuale delle select.

EFFECTIVE:
stato realmente valido nel flow corrente.

Esempio command flow:

raw project/entity match possono esistere,
ma effective.isUsableForEvent = false
e isIgnoredByCommandFlow = true.

Esempio edit mode con input “crea”:

command_intent_state può rilevare raw command,
ma effective command = false
perché edit mode prevale su command intent.

------------------------------------------------
5. MODIFICHE A input_analysis_result
------------------------------------------------

input_analysis_result è stato esteso con:

- effectiveFlowType
- effectiveIsInputFlow
- effectiveIsEventFlow
- effectiveIsCommandFlow
- effectiveCanUseEventFields
- effectiveCanUseCommandFields

È stata mantenuta la lettura raw di ui_visibility_state solo come diagnostica:

mode.rawVisibility:
- isInputFlow
- isEventFlow
- showEventPreview
- showCommandContainer
- showEventData
- showConfirm

È stata aggiunta la sezione effective per project/entity:

project.effective:
- isUsableForEvent
- isBlocking
- hasNonBlockingWarning
- isIgnoredByCommandFlow

entity.effective:
- isUsableForEvent
- isBlocking
- hasNonBlockingWarning
- isIgnoredByCommandFlow

È stata aggiunta la readiness interna:

readiness:
- canShowEventPreview
- canShowCommandContainer
- canShowEventData
- canShowAssociationSuggestions
- canConfirm
- hasBlockingIssue
- hasNonBlockingWarnings

È stato aggiunto il tracciamento diagnostico:

diagnostics:
- hasUiVisibilityDependency: true
- usesUiVisibilityOnlyAsRawDiagnostic: true
- effectiveReadinessComputedInternally: true
- isConsumptionReadyForUiVisibility: false
- antiLoopRule:
  input_analysis_result still reads ui_visibility_state only as raw diagnostic;
  ui_visibility_state must not read input_analysis_result yet

Nota:

input_analysis_result legge ancora ui_visibility_state,
ma non lo usa più come fonte primaria per la readiness effettiva.
Lo usa solo come raw diagnostic.

------------------------------------------------
6. PRIMA UI CONSUMPTION COMPLETATA
------------------------------------------------

Sono stati migrati a input_analysis_result i seguenti Hidden:

1. sintesi.Hidden

Da:

{{ !ui_visibility_state.value?.showEventPreview }}

A:

{{ !input_analysis_result.value?.readiness?.canShowEventPreview }}

---

2. text_event_data_title.Hidden

Da:

{{ !ui_visibility_state.value?.showEventData }}

A:

{{ !input_analysis_result.value?.readiness?.canShowEventData }}

---

3. select1.Hidden

Da:

{{ !ui_visibility_state.value?.showEventData }}

A:

{{ !input_analysis_result.value?.readiness?.canShowEventData }}

---

4. select_project.Hidden

Da:

{{ !ui_visibility_state.value?.showEventData }}

A:

{{ !input_analysis_result.value?.readiness?.canShowEventData }}

---

5. select_entity.Hidden

Da:

{{ !ui_visibility_state.value?.showEventData }}

A:

{{ !input_analysis_result.value?.readiness?.canShowEventData }}

---

6. container_command_intent.Hidden

Da:

{{ !ui_visibility_state.value?.showCommandContainer }}

A:

{{ !input_analysis_result.value?.readiness?.canShowCommandContainer }}

---

7. container_association_suggestions.Hidden

Da:

{{ !ui_visibility_state.value?.showAssociationSuggestions }}

A:

{{ !input_analysis_result.value?.readiness?.canShowAssociationSuggestions }}

------------------------------------------------
6B. STATO RESIDUO DI ui_visibility_state
------------------------------------------------

ui_visibility_state NON è stato sostituito.

Dopo il Controlled UI Consumption Pass, ui_visibility_state resta ancora operativo
per alcune parti strutturali del flow.

Restano collegati a ui_visibility_state almeno:

- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit / btn_cancel_input_home
- button_input_confirm Hidden / visibility logic
- eventuali altri controlli strutturali visibili nel graph Retool

input_analysis_result legge ancora ui_visibility_state come raw diagnostic,
non come fonte primaria della propria effective readiness.

Stato corretto:

- input_analysis_result governa già una parte della UI/readiness;
- ui_visibility_state resta ancora layer operativo per il contenitore input,
  loading state, cancel controls e confirm visibility;
- non esiste ancora una full visibility migration.

Decisione:

non migrare ora container_input, cancel buttons, loading e button_input_confirm.
Queste parti richiedono un nodo separato o micro-step dedicato,
perché sono safety/structural controls.

Nodo futuro possibile:

INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION

oppure:

UI VISIBILITY STATE — CONTROLLED DECOMMISSION PASS

------------------------------------------------
7. MICRO-COPY SINTESI AGGIORNATA
------------------------------------------------

La notice associazioni mancanti nella Sintesi è stata resa coerente con la presenza reale del container Suggerimenti associazione.

Prima:

la Sintesi mostrava sempre:

“Puoi selezionare i dati nei campi sotto o usare i suggerimenti.”

anche quando il container Suggerimenti associazione non era visibile.

Dopo:

la Sintesi legge:

input_analysis_result.value?.readiness?.canShowAssociationSuggestions

e mostra:

se i suggerimenti sono visibili:

“Puoi selezionare i dati nei campi sotto o usare i suggerimenti.”

se i suggerimenti non sono visibili:

“Puoi selezionare i dati nei campi sotto.”

Obiettivo raggiunto:

evitare che la Sintesi prometta suggerimenti non presenti nella UI.

------------------------------------------------
8. BUG FIX — EDIT MODE + INPUT VUOTO
------------------------------------------------

Durante i test è emerso un bug reale:

in edit mode, premendo la X per svuotare l’input,
input_home.value diventava vuoto e ui_visibility_state.isInputFlow diventava false.

Effetto:

l’utente poteva restare bloccato nella modifica,
con controlli di uscita non coerenti.

Correzione applicata a ui_visibility_state:

prima:

const isInputFlow =
  isHomeView &&
  hasInput &&
  (
    visibilityMode !== "empty" ||
    isEditMode
  );

dopo:

const isInputFlow =
  isHomeView &&
  (
    (
      hasInput &&
      visibilityMode !== "empty"
    ) ||
    isEditMode
  );

Inoltre:

- showEventPreview ora richiede hasInput
- showEventData ora richiede hasInput
- showConfirm ora richiede hasInput
- showCancelEdit resta visibile in edit mode anche con input vuoto

Comportamento finale:

edit mode + input vuoto:

- notice “Evento in modifica” visibile
- Annulla modifica visibile
- Sintesi nascosta
- Dati evento nascosti
- Conferma nascosta
- Home idle container nascosti

------------------------------------------------
9. BUG FIX — HOME IDLE CONTAINER IN EDIT MODE
------------------------------------------------

I container Home idle avevano Hidden:

{{ !!input_home.value }}

Questo faceva riapparire Esempi / Azioni rapide / Eventi da verificare
quando l’input veniva svuotato in edit mode.

Correzione applicata ai container Home idle:

Da:

{{ !!input_home.value }}

A:

{{ !!input_home.value || edit_mode.data === true }}

Componenti aggiornati:

- container_esempi
- container_attivita
- container_suggerimenti / Eventi da verificare
  o equivalente reale nel tree Retool

Effetto:

Home idle resta visibile solo in Home vuota normale,
non durante edit mode.

------------------------------------------------
10. ASSOCIAZIONI MANCANTI VS SUGGERIMENTI OPERATIVI
------------------------------------------------

È stata chiarita una distinzione importante:

missing association notice
≠
suggestion operativa

La Sintesi può mostrare:

“Manca un progetto e un’entità”

anche quando create_suggestion_state non produce contenuti operativi.

Il container Suggerimenti associazione deve comparire solo se esiste suggestion reale da create_suggestion_state.

Decisione:

non forzare il container a comparire sulla sola base della notice.
Evitare container vuoti.
Adeguare invece il testo della notice.

------------------------------------------------
11. TEST ESEGUITI
------------------------------------------------

Test effective state:

1. 30 euro cliente test
Esito: OK

Confermato:
- effectiveFlowType = event
- entity.effective.isBlocking = true
- readiness.canConfirm = false

2. crea progetto Nome Test
Esito: OK

Confermato:
- effectiveFlowType = command
- effectiveCanUseEventFields = false
- project/entity ignored by command flow
- command container true

3. edit mode + input crea
Esito: OK

Confermato:
- effectiveFlowType = edit
- raw command true
- effective command false
- command suppressed by edit mode

4. 1 ora sopralluogo mario villa
Esito: OK

Confermato:
- effectiveFlowType = event
- project/entity usable
- warning non bloccanti
- canConfirm true

---

Test consumption Sintesi / Dati evento:

1. evento normale
Esito: OK

2. command flow
Esito: OK

3. edit input pieno
Esito: OK

4. edit input vuoto
Esito: OK dopo fix

---

Test command container:

1. crea
Esito: OK

2. crea progetto Nome Test
Esito: OK

3. 30 euro spesa materiale
Esito: OK

4. edit mode + crea
Esito: OK funzionale
Residuo UX tracciato

---

Test association suggestions:

1. edit mode + 2 ore sviluppo progetto
Esito: OK dopo correzione micro-copy

Risultato:
- Sintesi mostra associazioni mancanti
- container suggestion nascosto se non ci sono suggestion operative
- testo non promette suggerimenti

2. edit mode + crea
Esito: OK

Risultato:
- container suggestion visibile se create_suggestion_state produce contenuti
- command container nascosto
- edit mode prevale

3. evento normale no-match
Esito: OK

Risultato:
- container suggestion visibile quando create_suggestion_state produce contenuti

---

Test finale edit empty:

1. edit mode + input vuoto
Esito: OK

Risultato:
- solo Annulla modifica visibile
- Home idle nascosta
- Dati evento nascosti
- Sintesi nascosta
- Conferma nascosta

2. edit mode + input valorizzato
Esito: OK

Risultato:
- Sintesi visibile
- Dati evento visibili
- Conferma visibile
- Annulla modifica visibile

------------------------------------------------
12. COMPONENTI NON TOCCATI
------------------------------------------------

Non sono stati modificati:

- button_input_confirm.Hidden
- button_input_confirm.Disabled
- button_input_confirm payload
- insert_event
- update_event
- insert_project
- insert_entity
- parser
- matching
- select default/value logic
- command_intent_state
- create_suggestion_state
- DB

Decisione:

button_input_confirm resta fuori dal consumption pass corrente perché distingue:
- visibilità bottone
- abilitazione/disabilitazione
- readiness logica
- payload save

Questa parte richiede un nodo o micro-step separato.

------------------------------------------------
13. RESIDUI TRACCIATI
------------------------------------------------

RESIDUO 1 — Command intent suppressed in edit mode needs user guidance

Caso:

durante la modifica evento, l’utente scrive “crea”.

Comportamento attuale:

- il sistema resta correttamente in edit mode
- command intent viene soppresso
- “crea” viene trattato come testo evento
- possono apparire suggestion project/entity se progetto/entità risultano mancanti

Valutazione:

la logica è corretta perché edit mode prevale su command intent.
L’incoerenza è UX: manca un messaggio esplicito per spiegare che i comandi di creazione non sono disponibili durante la modifica evento.

Possibile miglioramento futuro:

mostrare un alert/hint tipo:
“Se vuoi creare un progetto o un’entità, annulla prima la modifica evento.”

Nodo futuro consigliato:

COMMAND INTENT — EDIT MODE GUIDANCE
oppure
EDIT MODE UX GUARD / COMMAND SUPPRESSION NOTICE.

---

RESIDUO 2 — Edit empty state UX refinement

Caso:

edit mode con input vuoto.

Comportamento attuale:

- sistema sicuro e coerente
- resta visibile solo Annulla modifica
- non è possibile confermare evento vuoto

Possibile miglioramento futuro:

mostrare un micro-messaggio dedicato tipo:
“Inserisci un testo o annulla la modifica.”

Non prioritario.

---

RESIDUO 3 — Missing association notice vs suggestion container

Caso:

la Sintesi può mostrare “Manca un progetto e un’entità”
mentre il container Suggerimenti associazione non appare,
perché create_suggestion_state non produce contenuti operativi.

Valutazione:

non è regressione.
È distinzione corretta tra notice informativa e suggestion operativa.

Decisione:

non forzare container vuoti.
Eventuale riallineamento futuro tra preview_analysis_state,
create_suggestion_state e suggestion container.

---

RESIDUO 4 — Status semantics alignment

Caso:

card “Da verificare” può apparire con badge OK.

Esempio:

30 euro materiale

Valutazione:

anomalia storica, non introdotta dal nodo.

Decisione:

da ottimizzare in futuro.

---

RESIDUO 5 — Match partial ambiguity not detected

Casi noti:

- cucciolata marzo
- rossi

Valutazione:

problema Match Engine, non input_analysis_result.

Decisione:

rimandato a nodo Match Engine Evolution Advanced / Select Options Filtering / Alias-Deduplication.

---

RESIDUO 6 — Suggestion Create vs Match Present / More Specific

Casi noti:

- villa sierri
- tecnico sierri villa sierri

Valutazione:

residuo Match Engine / Suggestion Create.

Decisione:

rimandato a nodo futuro:
PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE
oppure Match Engine Evolution Advanced.

---

RESIDUO 7 — Feedback project/entity non uniforme

Caso:

- command create project/entity mostra feedback dedicato
- suggestion inline durante evento crea e valorizza select, ma non mostra feedback dedicato

Decisione:

rimandato a Feedback Consistency Pass.

---

RESIDUO 8 — Flash residui UI

Sono ancora presenti micro-flash nel sistema.

Valutazione:

logica funzionante.
Non introdotti dal nodo corrente.

Decisione:

rimandato a UI Rendering / Flash Cleanup se prioritario.

------------------------------------------------
14. CQD
------------------------------------------------

C — Completezza:
10/10

Il nodo ha completato una prima consumption reale di input_analysis_result.
Sono stati migrati Hidden importanti.
Sono stati gestiti bug emersi in edit mode.
I residui sono stati tracciati.

Q — Qualità:
9/10

La soluzione riduce letture sparse della UI.
Mantiene separazione tra layer tecnici e layer compositivo.
Non duplica matching.
Non cambia dati salvabili.
Migliora coerenza tra Sintesi, Dati evento, Command e Suggestion.

Resta da completare la parte più delicata:
button_input_confirm e save readiness.

D — Deployabilità:
10/10

Modifiche già testate nel sistema reale Retool.
Nessuna modifica DB.
Nessuna modifica parser.
Nessuna modifica matching.
Nessuna modifica save flow.
Nessuna regressione funzionale osservata.

------------------------------------------------
15. STATO FINALE
------------------------------------------------

NODO:
INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS

STATO:
COMPLETATO

ESITO:
OK CON RESIDUI NON BLOCCANTI

input_analysis_result ora è:

- layer read-only compositivo
- fonte UI controllata parziale per:
  - Sintesi visibility
  - Dati evento visibility
  - Command container visibility
  - Association suggestion container visibility
  - micro-copy associazioni mancanti nella Sintesi

input_analysis_result NON è ancora fonte per:

- button_input_confirm
- payload save
- insert/update
- select values
- matching
- command_intent_state
- create_suggestion_state
- DB

ui_visibility_state resta ancora attivo e non deprecato.
Il nodo corrente non completa la sostituzione di ui_visibility_state.

------------------------------------------------
16. PROSSIMA AZIONE CONSIGLIATA
------------------------------------------------

Procedere con aggiornamento documentale selettivo unico.

Documenti candidati:

1. 00_PROJECT_State
2. 00_PROJECT_Roadmap
3. 00_PROJECT_Gap_Register
4. 01_LOGOS_Input_System
5. 04_LOGOS_Retool_Architecture
6. 06_LOGOS_View_Preview_System
7. LOGOS_RETOOL_RUNTIME_REAL
8. 02_LOGOS_Match_Engine

Note aggiornamento:

- dichiarare preview_analysis_state operativo
- dichiarare input_analysis_result operativo solo per controlled UI consumption
- non dichiararlo fonte di save flow
- non dichiararlo sostituto del matching
- registrare raw / selection / effective state
- registrare residui
- registrare bug fix edit mode input vuoto
- registrare consumption Hidden già migrati

------------------------------------------------
FINE CHECKPOINT
------------------------------------------------