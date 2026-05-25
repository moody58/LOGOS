CHECKPOINT

@@LOGOS

TITOLO:
CHECKPOINT — INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION

DATA:
2026-05-22

PROGETTO:
LOGOS

STACK:
Retool + Supabase

NODO:
INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION

STATO:
COMPLETATO OPERATIVAMENTE

ESITO:
OK — MIGRAZIONE VISIBILITY PRINCIPALE COMPLETATA

1. CONTESTO

Il nodo nasce dopo il completamento di:

PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS

Situazione iniziale del nodo:

input_analysis_result era già fonte UI controllata parziale
sintesi, Dati evento, select, command container e suggestion container erano già migrati
ui_visibility_state restava operativo per visibility strutturale residua
button_input_confirm.Hidden non era ancora migrato
button_input_confirm.Disabled e payload erano esclusi dal nodo
ui_visibility_state era ancora letto da input_analysis_result come raw diagnostic
rischio principale: loop o doppia fonte tra ui_visibility_state e input_analysis_result
2. VINCOLI RISPETTATI

Durante il nodo NON sono stati modificati:

DB
Supabase
parser
parse_input_controlled
normalization
duration normalization
type classification
project_state
entity_state
create_suggestion_state
command_intent_state
select default/value logic
insert_event
update_event
insert_project
insert_entity
payload di button_input_confirm
save flow
Match Engine
query di salvataggio
schema dati

Non è stato introdotto:

Event Interpretation Engine
Input Analysis Model completo
motore monolitico
refactor globale
cleanup query fuori nodo
modifica dei 19 linting Retool
3. OBIETTIVO DEL NODO

Obiettivo dichiarato:

completare in modo controllato la migrazione visibility residua da ui_visibility_state a input_analysis_result, riducendo le doppie fonti senza creare un motore monolitico.

Obiettivo raggiunto:

Hidden principali del flow input migrati a input_analysis_result
button_input_confirm.Hidden migrato con flag dedicato
button_input_confirm.Disabled lasciato invariato
ui_visibility_state non è più letto da input_analysis_result
ui_visibility_mode resta attivo come latch leggero empty / event / command
routing principale app resta correttamente su ui_state.value.view
4. COMPONENTI MIGRATI

Sono stati migrati da ui_visibility_state a input_analysis_result:

4.1 container_input.Hidden

Da:

{{ !ui_visibility_state.value?.isInputFlow }}

A:

{{ !input_analysis_result.value?.mode?.effectiveIsInputFlow }}
4.2 text_input_analysis_loading.Hidden

Da:

{{
  !(
    input_home.value &&
    ui_visibility_state.value?.visibilityMode === "empty" &&
    edit_mode.data !== true
  )
}}

A:

{{
  !(
    input_analysis_result.value?.input?.hasInput === true &&
    input_analysis_result.value?.mode?.visibilityMode === "empty" &&
    input_analysis_result.value?.mode?.isEditMode !== true
  )
}}
4.3 btn_cancel_edit.Hidden

Da:

{{ !ui_visibility_state.value?.showCancelEdit }}

A:

{{
  !(
    input_analysis_result.value?.mode?.effectiveIsInputFlow === true &&
    input_analysis_result.value?.mode?.isEditMode === true
  )
}}
4.4 btn_cancel_input_home.Hidden

Da:

{{ !ui_visibility_state.value?.showCancelInputHome }}

A:

{{
  !(
    input_analysis_result.value?.mode?.effectiveIsInputFlow === true &&
    input_analysis_result.value?.mode?.isEditMode !== true
  )
}}
4.5 button_input_confirm.Hidden

È stato introdotto un flag visibility-only dedicato in input_analysis_result.readiness:

canShowConfirm: showConfirm,

Poi button_input_confirm.Hidden è stato migrato.

Da:

{{ !ui_visibility_state.value?.showConfirm }}

A:

{{ !input_analysis_result.value?.readiness?.canShowConfirm }}

Regola consolidata:

canShowConfirm governa solo la visibilità del bottone
canConfirm resta readiness funzionale
canConfirm NON va usato per Hidden
button_input_confirm.Disabled resta separato
5. COMPONENTI NON MODIFICATI
5.1 button_input_confirm.Disabled

Rimasto invariato:

{{
  (() => {
    const projectAmbiguous =
      Boolean(project_state.data?.isAmbiguous) ||
      ((project_state.data?.matches?.length ?? 0) > 1);

    const entityAmbiguous =
      Boolean(entity_state.data?.isAmbiguous) ||
      ((entity_state.data?.matches?.length ?? 0) > 1);

    return (
      !input_raw.value ||
      (projectAmbiguous && !select_project.value) ||
      (entityAmbiguous && !select_entity.value)
    );
  })()
}}

Motivo:

il nodo riguardava la visibility, non la save readiness funzionale.

5.2 Payload conferma

Nessuna modifica.

5.3 Routing principale app

Non sono stati modificati:

container_home.Hidden
{{ ui_state.value?.view !== "home" }}

container_feedback.Hidden
{{ ui_state.value?.view !== "feedback" }}

container_events_list.Hidden
{{ ui_state.value?.view !== "events" }}

Decisione:

questi componenti devono restare su ui_state.value.view, perché appartengono al routing principale dell’app, non alla visibility del flow input.

Regola consolidata:

ui_state.view = routing principale
input_analysis_result = readiness / visibility del flow input
6. RIMOZIONE DIPENDENZA DA ui_visibility_state

È stata rimossa da input_analysis_result la dipendenza residua:

const visibility = {{ ui_visibility_state.value || {} }};

Risultato:

input_analysis_result non legge più ui_visibility_state
nessun loop possibile tra ui_visibility_state e input_analysis_result
graph Retool conferma rimozione del collegamento
ui_visibility_state resta presente ma non più collegato agli Hidden principali trattati

Diagnostics aggiornati:

hasUiVisibilityDependency: false,
usesUiVisibilityOnlyAsRawDiagnostic: false,
effectiveReadinessComputedInternally: true,
isConsumptionReadyForUiVisibility: true,
antiLoopRule: "ui_visibility_state is no longer read by input_analysis_result; no reverse dependency is allowed"
7. STATO DI ui_visibility_mode

ui_visibility_mode NON è stato rimosso.

Decisione:

ui_visibility_mode → DA TENERE
ui_visibility_state → RESIDUO / DEPRECABILE / NON CANCELLARE ORA

Motivo:

ui_visibility_mode resta utile come latch leggero:

empty
event
command

Serve ancora a distinguere rapidamente il flow visivo prima della composizione effettiva di input_analysis_result.

8. STATO DI ui_visibility_state

ui_visibility_state non governa più gli Hidden principali trattati nel nodo.

Stato finale:

non più letto da input_analysis_result
non più fonte diretta degli Hidden migrati
presente nel progetto
non cancellato
conservato come residuo tecnico / possibile rollback fino a cleanup dedicato

Decisione:

non eliminarlo in questo nodo.

Nodo futuro possibile:

CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION
9. TEST ESEGUITI

È stato adottato uno standard test stabile:

TEST ID:
AREA:
INPUT/AZIONE:
COSA VERIFICARE:
RISULTATO ATTESO:
ESITO:
NOTE:
10. TEST SET PRINCIPALE — MICRO-BATCH 1
Test	Esito	Note
A1 — Home vuota	OK	Stato idle coerente
A2 — 20 euro villa	OK	Evento normale, warning e suggestion coerenti
C1 — 2h30 rendering lavoro	OK con nota	Visibility corretta; bug preesistente label “Importo” per durata
D1 — acquisto 120 euro aspri allevamento aspri	OK	Project/entity reali riconosciuti
E1 — mario sopralluogo villa 2	OK con nota	Warning entità più specifiche, conferma attiva perché entity selezionata
E2 — selezione Mario Rossi	OK	Scelta manuale recepita
F1 — 20 euro villa borghese	OK	Suggestion Villa Borghese coerente
F3 — Ignora suggerimenti	OK	Suggestion nascosta, flow stabile
G1 — crea	OK	Solo command container
G2 — crea progetto Nome Test	OK	Duplicato riconosciuto, nessun evento
H1 — edit input pieno	OK	Edit flow stabile
H2 — edit input vuoto	OK	Annulla modifica visibile, Conferma nascosta
11. TEST SET MICRO-BATCH 2 — CONFIRM HIDDEN
Test	Esito	Note
B2-1 — Home vuota	OK	Conferma nascosta
B2-2 — 20 euro villa	OK	Conferma visibile
B2-3 — 2h30 rendering lavoro	OK	Conferma visibile
B2-4 — crea	OK	Conferma nascosta
B2-5 — crea progetto Nome Test	OK	Conferma nascosta
B2-6 — mario sopralluogo villa 2	OK	Conferma visibile perché entity selezionata
B2-7 — edit input pieno	OK	Conferma visibile
B2-8 — edit input vuoto	OK	Conferma nascosta, Annulla modifica visibile
12. SMOKE TEST FINALE POST RIMOZIONE DIPENDENZA
Test	Esito	Note
S1 — Home vuota	OK	input flow nascosto, nav visibile
S2 — 20 euro villa	OK	Sintesi/Dati/Conferma visibili
S3 — crea	OK	solo command container
S4 — edit input vuoto	OK	Annulla modifica visibile, Conferma nascosta

Graph finale:

input_analysis_result non dipende più da ui_visibility_state
ui_visibility_state resta isolato / non collegato agli Hidden principali
ui_visibility_mode resta attivo
13. RESIDUI RILEVATI
13.1 Label “Importo” su durata

Caso:

2h30 rendering lavoro

La riga visuale mostra:

Importo → 2 ore 30 minuti

Nota:

bug / incoerenza preesistente, non generata dal nodo corrente.

Nodo futuro candidato:

PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT

Obiettivo futuro:

euro → Importo
minuti / ore → Durata
nessuna unità → riga assente o label neutra
13.2 Policy match più specifici

Caso:

mario sopralluogo villa 2

Comportamento attuale:

entity Mario selezionata automaticamente
warning “Esistono entità più specifiche”
Conferma attiva

Nota:

comportamento coerente con policy attuale: warning non bloccante se esiste una selezione effettiva.

Nodo futuro eventuale:

MATCH ENGINE — MORE SPECIFIC MATCH POLICY

Possibile decisione futura:

mantenere warning non bloccante
oppure richiedere selezione manuale quando esistono match più specifici

Non modificato in questo nodo.

13.3 ui_visibility_state residuo

Stato:

non più necessario per Hidden principali migrati
non più letto da input_analysis_result
ancora presente in Retool
non cancellato

Decisione:

rimandare eventuale eliminazione a cleanup dedicato.

14. DECISIONI CONSOLIDATE
Decisione 1

input_analysis_result diventa fonte operativa per gli Hidden principali del flow input.

Decisione 2

button_input_confirm.Hidden può leggere input_analysis_result.readiness.canShowConfirm.

Decisione 3

button_input_confirm.Disabled resta separato e non deve leggere canShowConfirm.

Decisione 4

canShowConfirm e canConfirm sono concetti diversi:

canShowConfirm = visibility
canConfirm = readiness funzionale
Decisione 5

ui_state.value.view resta fonte corretta per routing principale:

Home
Feedback
Events list
Decisione 6

ui_visibility_mode resta attivo.

Decisione 7

ui_visibility_state è deprecabile ma non va cancellato in questo nodo.

15. STATO FINALE DEL FLOW

Stato corretto post nodo:

ui_state.view
→ routing principale app

ui_visibility_mode
→ latch leggero empty / event / command

input_analysis_result
→ composizione raw / selection / effective
→ readiness / visibility del flow input

button_input_confirm.Hidden
→ input_analysis_result.readiness.canShowConfirm

button_input_confirm.Disabled
→ guard funzionale separata su input_raw + ambiguità

button_input_confirm payload
→ invariato
16. CRITERIO DI SUCCESSO

Criterio dichiarato:

ridurre in modo controllato la doppia visibility tra ui_visibility_state e input_analysis_result senza rompere edit flow, command flow, event flow, confirm flow o save flow.

Esito:

RAGGIUNTO

17. CRITERI DI STOP — VERIFICA

Non si sono verificati:

loop tra ui_visibility_state e input_analysis_result
perdita del pulsante Annulla modifica
Conferma visibile/invisibile in modo incoerente
command container mostrato in edit mode
Dati evento visibili con edit input vuoto
Home idle container visibili in edit mode in modo bloccante
regressione save flow
regressione matching
regressione select
aumento incoerenza UX
18. DOCUMENTI DA AGGIORNARE

Consigliato aggiornare:

00_PROJECT_State
00_PROJECT_Roadmap
00_PROJECT_Gap_Register
01_LOGOS_Input_System
04_LOGOS_Retool_Architecture
06_LOGOS_View_Preview_System
LOGOS_RETOOL_RUNTIME_REAL
02_LOGOS_Match_Engine

Non necessario aggiornare ora:

LOGOS_SUPABASE_RUNTIME_REAL
05_LOGOS_Database_Schema
03_LOGOS_Event_Lifecycle

Motivo:

nessuna modifica DB, schema, save flow o lifecycle evento.

19. PROSSIMO NODO CANDIDATO

Dopo aggiornamento documentale, candidati logici:

LINTING / RETOOL QUERY SAFETY PASS
PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT
MATCH ENGINE — MORE SPECIFIC MATCH POLICY
CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION
BUTTON CONFIRM READINESS ALIGNMENT

Priorità consigliata:

LINTING / RETOOL QUERY SAFETY PASS

Motivo:

i linting sono aumentati a 19 e conviene ridurre rumore tecnico prima di nuovi interventi logici.

20. CHIUSURA

Il nodo:

INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION

è completato operativamente.

La migrazione visibility principale è stata chiusa senza regressioni note.

input_analysis_result è ora fonte UI controllata per gli Hidden principali del flow input.

ui_visibility_state non è più dipendenza di input_analysis_result e può essere considerato residuo deprecabile, da non eliminare fino a cleanup dedicato.