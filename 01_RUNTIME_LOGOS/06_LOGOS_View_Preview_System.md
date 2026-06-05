# 06_LOGOS_View_Preview_System_v16

DATA: 2026-06-04

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il comportamento reale del sistema di preview (sintesi)
nel sistema LOGOS.

Il documento descrive:

- cosa fa realmente la preview oggi
- quali logiche contiene
- quali layer ingloba
- come si comporta a runtime
- quali fonti dati utilizza dopo l’introduzione di ui_state.parsed
- quali limiti restano aperti dopo il Normalization Layer Base
- quali allineamenti visuali sono stati completati con Preview Alignment Base
- come la preview rappresenta la Duration Normalization Base
- come vengono mostrati durata normalizzata e durata ambigua
- come la preview interagisce con select1 / Type Classification Base
- cosa la preview mostra ma non salva direttamente
- come la preview legge il match state project/entity
- come gli hint ambiguità matching derivano da isAmbiguous
- come l’highlight project/entity deriva da matches
- come vengono mostrati i match più specifici
- come la preview resta non decisionale per project/entity
- come la preview convive con create_suggestion_state
- come distinguere hint informativi e suggestion create
- come il container suggestion supporta la preview senza essere fonte di salvataggio
- come la preview resta separata da insert_project / insert_entity
- come entity autofill controlled minimal resta fuori dalla preview
- come la Sintesi è stata confermata dentro UX Mobile Coherence Pass
- come la card “Da verificare” resta separata dalla Sintesi
- come il notice associazioni mancanti resta collegato alla Sintesi
- come Dati evento resta la zona decisionale separata dalla Sintesi
- come “Cambia” / “Scegli” restano micro-azioni visive non cliccabili
- come Feedback mobile e Navigation dock restano esterni alla preview
- come la baseline 16px mobile Safari riguarda input/select, non la logica preview
- come la preview convive con Command Intent — Create Project / Entity
- come container_command_intent sostituisce Sintesi / Dati evento quando l’input è comando puro
- come preview_analysis_state raccoglie hint/status/warning/Da verificare/associazioni mancanti della Sintesi
- come input_analysis_result legge preview_analysis_state e compone raw / selection / effective state
- come input_analysis_result governa ora la visibilità degli Hidden principali del flow input
- come sintesi.Hidden legge input_analysis_result.readiness.canShowEventPreview
- come Dati evento, command container e suggestion container sono stati migrati a input_analysis_result
- come container_input, loading, cancel controls e button_input_confirm.Hidden sono stati migrati a input_analysis_result
- come button_input_confirm.Hidden legge input_analysis_result.readiness.canShowConfirm
- come canShowConfirm è distinto da canConfirm
- come button_input_confirm.Disabled resta guard funzionale separata
- come button_input_confirm payload resta invariato
- come input_analysis_result non legge più ui_visibility_state
- come ui_visibility_state resta residuo tecnico deprecabile e non fonte della preview
- come la notice associazioni mancanti usa una micro-copy coerente con la presenza reale dei suggerimenti operativi
- come command_intent_state resta separato dalla preview
- come i comandi puri non devono essere rappresentati come eventi
- come “crea progetto”, “crea entità” e “modifica evento” vengono gestiti fuori dalla Sintesi evento
- come “Da verificare” resta ancora interno alla Sintesi e non è blocco autonomo
- come il rendering progressivo dell’input evento normale è stato ridotto tramite UI Readiness / Visibility Aggregator
- come input_analysis_result governa la visibilità della Sintesi e degli Hidden principali del flow input
- come ui_visibility_mode distingue empty / event / command
- come container_command_intent / Sintesi / Dati evento / Conferma Hidden sono coordinati da input_analysis_result
- come la Sintesi resta ibrida nel contenuto, anche se la sua visibilità è più stabile
- come il micro-flash feedback project/entity resta esterno alla preview
- come “modifica” generico resta residuo Command Intent, non preview
- come la label visuale della riga valore è stata allineata semanticamente a Importo / Durata / Valore
- come i linting Retool sono stati azzerati nel nodo Linting / Retool Query Safety Pass
- come typing_state e handle_event_success sono stati eliminati come query legacy unused
- come G22 Project Create Suggestion — Match Present / User Override è stato risolto lato Preview/Sintesi
- come la card Da verificare mostra ora warning mirati “Associazione progetto/entità da controllare”
- come preview_analysis_state consuma create_suggestion_state.requiresUserOverride
- come il container Suggerimenti associazione resta area di azione e non duplica il warning decisionale
- come i vecchi warning generici “Esistono progetti/entità più specifiche” non sono più usati come segnale principale nei casi G22
- come la suggestion extension resta non bloccante e non modifica Conferma, payload, save flow o DB

⚠ NON descrive un modello ideale
⚠ descrive lo stato reale attuale

------------------------------------------------
RESPONSABILITÀ CANONICA DEL DOCUMENTO
------------------------------------------------

Questo documento è fonte canonica per:

- Preview / Sintesi LOGOS
- comportamento visuale della Sintesi
- labelStyled
- value builder visuale
- formattazione amount/unit/date in preview
- formattazione durata umana in preview
- hint normalizzazione durata
- hint durata ambigua
- label cleaning visuale
- highlight project/entity nella Sintesi
- hint / warning / status visuali della Sintesi
- card “Da verificare”
- notice associazioni mancanti
- micro-copy preview
- label semantica della riga valore nella Sintesi: Importo / Durata / Valore
- micro-azioni visive “Cambia” / “Scegli”
- relazione tra Sintesi e Dati evento
- relazione tra Sintesi e create_suggestion_state
- relazione tra Sintesi e container_command_intent
- relazione tra preview_analysis_state e Sintesi
- relazione tra input_analysis_result e visibilità della Sintesi
- limiti della preview come layer ibrido
- residui semantici visuali della preview
- futuri nodi Preview / Hint / Status / Label Alignment
- warning visuali G22 “Associazione progetto da controllare” / “Associazione entità da controllare”
- separazione semantica tra card Da verificare e container Suggerimenti associazione
- micro-copy preview per match presente + suggestion extension

Questo documento NON è fonte canonica completa per:

- parser / normalization nel dettaglio algoritmico completo
- Match Engine project/entity nel dettaglio algoritmico completo
- wiring completo dei componenti Retool
- lifecycle evento completo
- schema DB completo
- runtime Retool as-is completo
- runtime Supabase as-is completo
- roadmap / priorità / gap governance

Fonti canoniche collegate:

- 01_LOGOS_Input_System per input flow, parser, normalization, duration normalization, type classification base nel contesto input, Command Intent, create_suggestion_state e input_analysis_result.
- 02_LOGOS_Match_Engine per project_state / entity_state / matches / isAmbiguous / singleMatch / moreSpecificMatches / confirm guard matching.
- 03_LOGOS_Event_Lifecycle per lifecycle evento, edit, no-op, cancel, NEW / WRITTEN / ERROR e processing.
- 04_LOGOS_Retool_Architecture per componenti, query, Hidden, Sintesi come componente Retool, input_analysis_result wiring e preview_analysis_state wiring.
- 05_LOGOS_Database_Schema per schema DB, tabelle, campi e vincoli.
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is.
- LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase / storage passivo.

Nota post Pacchetto B:

State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo della Preview/Sintesi.
Il dettaglio completo del comportamento visuale e semantico della preview resta in questo documento e nei documenti canonici collegati.

------------------------------------------------
POSIZIONE NEL SISTEMA
------------------------------------------------

Nota canonica:

Questo documento descrive la posizione della Preview/Sintesi nel sistema e il suo comportamento visuale.

Per la pipeline input/parser completa la fonte canonica è:

- 01_LOGOS_Input_System

Per il wiring Retool reale dei componenti coinvolti la fonte canonica è:

- 04_LOGOS_Retool_Architecture

Per il Match Engine project/entity la fonte canonica è:

- 02_LOGOS_Match_Engine

Regola:

la Preview rappresenta e supporta.
Non salva, non decide project/entity, non costruisce payload e non sostituisce Dati evento.

Layer:

→ sintesi (Retool)

Collocazione attuale:

input_raw
→ trigger_parse_debounced
→ ui_visibility_mode
→ command_intent_state
→ parse_input_controlled
→ ui_state.parsed
→ project_state / entity_state
→ create_suggestion_state
→ preview_analysis_state
→ input_analysis_result
→ preview (sintesi) / card Da verificare / suggestion container
→ oppure container_command_intent
→ Dati evento / Conferma Hidden oppure command action
→ select_project / select_entity / select1
→ confirm evento / insert_project / insert_entity / go events
→ feedback temporaneo
→ routing post-save

Nota post UX Mobile Coherence Pass:

Feedback temporaneo, routing post-save e Navigation dock NON fanno parte della preview.

Sono layer UI separati:

- preview / Sintesi = rappresentazione input evento interpretato
- Da verificare = controllo/hint operativo ancora interno alla Sintesi
- suggestion container = proposta azione project/entity da input evento
- container_command_intent = rappresentazione comando puro
- Dati evento = decisione salvabile per evento ordinario
- command action = azione controllata per comando puro
- feedback = conferma temporanea post-save / post-create
- navigation dock = navigazione UI

Nota post Input Analysis Result Controlled UI Consumption:

La visibilità della Sintesi non dipende più direttamente da ui_visibility_state.

Dopo il Controlled UI Consumption Pass:

sintesi.Hidden legge:

input_analysis_result.readiness.canShowEventPreview

Il container command legge:

input_analysis_result.readiness.canShowCommandContainer

La sezione Dati evento e le select leggono:

input_analysis_result.readiness.canShowEventData

Il container suggestion legge:

input_analysis_result.readiness.canShowAssociationSuggestions

Questo ha ridotto le letture sparse e ha portato una prima parte della UI a leggere una verità operativa più coerente.

Nota post Input Analysis Result — Visibility Migration Completion:

La migrazione visibility degli Hidden principali è stata completata.

Ora leggono input_analysis_result anche:

- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden

button_input_confirm.Hidden legge:

input_analysis_result.readiness.canShowConfirm

Regole consolidate:

- canShowConfirm = visibilità del bottone Conferma
- canConfirm = readiness funzionale
- button_input_confirm.Disabled = guard funzionale separata
- button_input_confirm payload = invariato
- insert_event / update_event = invariati

ui_visibility_state:

- non è più letto da input_analysis_result
- non governa più gli Hidden principali migrati
- resta residuo tecnico deprecabile
- non va cancellato fuori da cleanup dedicato

Nota:

input_analysis_result governa ora la visibilità degli Hidden principali del flow input,
ma non modifica il contenuto interno della Sintesi,
non modifica parser,
non modifica matching,
non modifica create_suggestion_state,
non modifica command_intent_state,
non modifica save flow
e non modifica DB.

---

La preview si colloca dopo il parsing controllato
e legge i dati strutturati principalmente da:

ui_state.parsed

Dopo Preview Analysis State:

la logica hint/status/warning/Da verificare/associazioni mancanti
è stata raccolta a primo livello in:

preview_analysis_state

Nota post G22:

preview_analysis_state ora legge anche create_suggestion_state per i casi
di match presente + suggestion extension.

Fonte:

create_suggestion_state.data.project.requiresUserOverride
create_suggestion_state.data.entity.requiresUserOverride

Quando requiresUserOverride = true, la card Da verificare mostra un warning mirato:

Project:
Associazione progetto da controllare
[baseName] selezionato · testo letto: [candidateName]

Entity:
Associazione entità da controllare
[baseName] selezionata · testo letto: [candidateName]

Regola:

Da verificare segnala il rischio decisionale.
Suggerimenti associazione propone l’azione disponibile.

Il warning G22 è non bloccante e non modifica:

- select_project / select_entity
- button_input_confirm.Disabled
- button_input_confirm.Hidden
- payload
- insert_event / update_event
- save flow
- DB
- Supabase

La Sintesi legge preview_analysis_state per:

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

Dopo Input Analysis Result:

input_analysis_result legge anche preview_analysis_state
e compone lo stato preview dentro un layer più ampio raw / selection / effective.

Regola:

preview_analysis_state resta fonte specializzata per hint/status della Sintesi.
input_analysis_result non deve ricalcolare gli stessi hint,
ma leggerli e comporli.

Per il type, la preview legge anche:

select1.value

Nota terminologica:

select1 è un componente UI Select di Retool,
non una query.

Per il matching project/entity, la preview legge anche:

project_state.data
entity_state.data

In particolare:

- matches
- count
- isAmbiguous
- singleMatch
- hasMoreSpecificMatches

Per le suggestion project/entity, il container suggestion legge anche:

create_suggestion_state.data

Nota:

create_suggestion_state non è preview pura.
È un helper controllato che alimenta suggestion create.

command_intent_state non è preview pura.

È un helper controllato che distingue:

- input evento ordinario
- comando strutturale puro
- guida non operativa

command_intent_state alimenta container_command_intent,
non la Sintesi evento.

ui_visibility_state è ora residuo tecnico deprecabile.

Dopo Visibility Migration Completion,
ui_visibility_state non è più la fonte diretta di visibilità per gli Hidden principali del flow input.

Componenti che leggono input_analysis_result.readiness:

- Sintesi evento
- container_command_intent
- suggestion container
- Dati evento
- select1
- select_project
- select_entity
- container_input
- text_input_analysis_loading
- btn_cancel_edit
- btn_cancel_input_home
- button_input_confirm.Hidden

Componenti NON migrati perché routing principale app:

- container_home.Hidden
- container_feedback.Hidden
- container_events_list.Hidden

Regola:

ui_state.view = routing principale app
input_analysis_result = readiness / visibility flow input
ui_visibility_mode = latch empty / event / command
ui_visibility_state = residuo tecnico deprecabile

Regola:

la preview non deve leggere ui_visibility_state come fonte dati evento.
input_analysis_result non legge più ui_visibility_state.
Non introdurre dipendenze circolari tra helper visibility/readiness.

Regola:

quando l’input è in flow command,
la Sintesi evento e Dati evento devono essere nascosti.

Dopo Visibility Migration Completion questa separazione è governata da:

- ui_visibility_mode = command
- input_analysis_result.readiness.canShowCommandContainer = true
- input_analysis_result.readiness.canShowEventPreview = false
- input_analysis_result.readiness.canShowEventData = false
- input_analysis_result.readiness.canShowConfirm = false

command_intent_state resta la fonte funzionale del comando,
ma ui_visibility_mode può anticipare la visibilità command per evitare flash.

La preview/sintesi, il suggestion container e il command container devono restare concettualmente distinti:

- preview = rappresentazione dell’input evento interpretato
- hint informativi = stato del match / durata / type
- suggestion create = proposta di azione guidata dentro flow evento
- command intent = comando puro separato dal flow evento
- command action = azione controllata fuori dal salvataggio evento

---

Nota:

Il save flow non dipende più da parsing interno alla preview
né da parsing duplicato nel bottone confirm.

Il save flow non dipende da create_suggestion_state.

create_suggestion_state può aiutare a creare project/entity,
ma l’evento viene salvato solo tramite:

select_project.value
select_entity.value

dentro button_input_confirm.

insert_project / insert_entity non salvano eventi.

Command Intent non salva eventi.

Quando l’input è un comando puro:

- button_input_confirm non deve essere usato
- insert_event / update_event non devono essere eseguiti
- Sintesi evento non deve rappresentare il comando come evento
- Dati evento non devono essere mostrati
- container_command_intent diventa il layer UI principale

Il save flow non dipende dalla preview per il type.

Il type viene salvato tramite:

select1.value
→ button_input_confirm payload.type
→ insert_event / update_event
→ events.type

Il save flow non dipende dalla preview per project/entity.

project_id viene salvato tramite:

select_project.value
→ button_input_confirm payload.project_id
→ insert_event / update_event
→ events.project_id

entity_id viene salvato tramite:

select_entity.value
→ button_input_confirm payload.entity_id
→ insert_event / update_event
→ events.entity_id

------------------------------------------------
RUOLO DELLA PREVIEW
------------------------------------------------

La preview è il punto di visualizzazione dello stato input.

Mostra:

✔ dati parsati  
✔ dati normalizzati base 
✔ label semantica della riga valore: Importo per euro, Durata per ore/minuti, Valore per fallback non riconosciuti
✔ durate normalizzate in minuti  
✔ durata in forma umana  
✔ hint normalizzazione durata  
✔ hint durata ambigua 
✔ type corrente tramite select1.value  
✔ supporto visivo alla Type Classification Base    
✔ label derivata  
✔ stato matching  
✔ match state project/entity  
✔ hint ambiguità da isAmbiguous  
✔ warning G22 per match presente + suggestion extension
✔ hint match più specifici come segnale informativo non principale nei casi G22
✔ highlight project/entity da matches  
✔ hint utente  
✔ supporto visuale al container suggestion
✔ separazione tra warning decisionale in Da verificare e azione nel container Suggerimenti associazione
✔ distinzione tra hint informativo e suggestion create
✔ Sintesi strutturata mobile confermata
✔ card “Da verificare” separata dalla Sintesi
✔ notice associazioni mancanti nella Sintesi
✔ micro-azioni visive “Cambia” / “Scegli”
✔ coerenza visuale con Dati evento compatti
✔ esclusione dei comandi puri dal rendering evento
✔ convivenza controllata con container_command_intent
✔ separazione tra input evento e command intent
✔ visibilità stabilizzata inizialmente tramite ui_visibility_state.showEventPreview
✔ visibilità Sintesi migrata a input_analysis_result.readiness.canShowEventPreview
✔ Hidden principali flow input migrati a input_analysis_result
✔ button_input_confirm.Hidden migrato a input_analysis_result.readiness.canShowConfirm
✔ hint/status ora alimentati da preview_analysis_state
✔ esclusione più stabile dei command intent dalla Sintesi
✔ riduzione del rendering progressivo input flow

---

ATTENZIONE:

La preview NON è ancora una view pura.

Attualmente è ancora:

👉 un layer ibrido (view + trasformazione)

Contiene:

- rendering dati
- label cleaning
- hint logic
- highlight
- formattazioni locali
- logiche di supporto UX

Nota post Command Intent:

La preview continua a rappresentare solo input evento ordinari.

Non deve rappresentare come evento:

- crea
- crea progetto
- crea progetto [nome]
- crea entità
- crea entità [nome]
- modifica evento

Questi casi appartengono a container_command_intent.

Nota post Project / Entity Create Suggestion:

Il container suggestion NON trasforma la preview in fonte di salvataggio.

La preview continua a mostrare lo stato interpretato dell’input.
La suggestion create è un’azione separata, controllata e confermata dall’utente.

Nota post UX Mobile Coherence Pass:

La Sintesi è stata resa più leggibile e coerente su mobile,
ma non è diventata una form.

La Sintesi non sostituisce:

- select1
- select_project
- select_entity
- button_input_confirm

La zona decisionale resta Dati evento.

Nota post Command Intent:

Per input evento ordinari, la zona decisionale resta Dati evento.

Per comandi puri, la zona decisionale diventa container_command_intent.

Esempi:

crea progetto Villa Nuova
→ container_command_intent
→ btn_command_create_project
→ insert_project

crea entità Patrizio
→ container_command_intent
→ btn_command_create_entity
→ insert_entity

modifica evento
→ container_command_intent
→ btn_command_go_events
→ Lista eventi

---

Rispetto allo stato precedente:

✔ il parsing strutturato non è più duplicato nel confirm  
✔ amount/unit/event_date arrivano da ui_state.parsed  
✔ save/DB sono più coerenti  
✔ amount/unit sono ora visualizzati in formato italiano coerente  
✔ label cleaning aggiornato sui casi già normalizzati  
✔ date separate correttamente dalla descrizione  
✔ highlight locale reso unit-safe  
✔ durata certa visualizzata in forma umana  
✔ valore tecnico normalizzato mostrato come hint  
✔ giorni/settimane segnalati come durata ambigua  
✔ select1 allineato a ui_state.parsed.unit  
✔ parsed.unit = minuti → type Tempo  
✔ Spesa / Incasso / Evento gestiti tramite select1  
✔ scelta manuale utente preservata  

Ma:

⚠ la preview contiene ancora trasformazioni proprie  
⚠ la preview non è ancora un layer read-only puro  
⚠ label cleaning, hint logic e highlight restano embedded nella sintesi  
⚠ type mostrato/supportato dalla preview, ma salvato dal confirm flow  
⚠ hint duration/type restano embedded nella preview  
⚠ preview model unico non implementato   
⚠ Cambia / Scegli sono ancora indicatori visivi, non azioni cliccabili
⚠ Feedback mobile non è preview
⚠ Navigation dock non è preview
⚠ Dati evento resta separato dalla Sintesi
⚠ “Da verificare” resta ancora interno alla Sintesi
⚠ hint bloccanti / warning informativi / suggestion visuali non sono ancora separati in stati autonomi
✔ rendering progressivo dell’input evento normale ridotto tramite UI Readiness
⚠ micro-flash feedback project/entity ancora presente, ma esterno alla preview
⚠ “modifica” generico non ancora riconosciuto come guida edit, residuo Command Intent
⚠ Command Intent è separato dalla preview ma non esiste ancora un input analysis model unico
⚠ ui_visibility_state non è Input Analysis Model completo
⚠ input_analysis_result non è ancora Input Analysis Model completo
✔ input_analysis_result è operativo come fonte UI controllata per gli Hidden principali del flow input
⚠ ui_visibility_state resta presente come residuo tecnico deprecabile
⚠ button_input_confirm.Disabled resta fuori da input_analysis_result
⚠ save readiness completa non è centralizzata
✔ label “Importo” non viene più usata per valori durata
✔ la riga valore mostra “Durata” per unità temporali ore/minuti
✔ la riga valore usa “Valore” come fallback per unità non riconosciute

------------------------------------------------
INPUT DELLA PREVIEW
------------------------------------------------

Fonti dati utilizzate:

- input_raw.value
- ui_state.parsed
- select_project.value
- select_entity.value
- projects_list.data
- entities_list.data
- project_state.data
- entity_state.data
- select1.value
- create_suggestion_state.data
- project_create_suggestion_dismissed.value
- entity_create_suggestion_dismissed.value
- preview_analysis_state.value per hint/status/warning/missing association
- input_analysis_result.value per visibility/readiness degli Hidden principali del flow input

Nota post Input Analysis Result:

La preview non usa ui_visibility_state come fonte di contenuto.

La visibilità diretta della Sintesi ora legge:

input_analysis_result.readiness.canShowEventPreview

ui_visibility_state non è stato eliminato:
resta presente come residuo tecnico deprecabile,
ma non governa più container_input, loading, cancel controls o button_input_confirm.Hidden.

Fonte visibilità Sintesi:

input_analysis_result.readiness.canShowEventPreview

Fonte hint/status Sintesi:

preview_analysis_state

Fonte contenuto:

- input_raw.value
- ui_state.parsed
- select1.value
- project_state.data
- entity_state.data
- create_suggestion_state.data
- select_project.value
- select_entity.value

Nota Command Intent:

La preview NON deve usare command_intent_state come fonte di rappresentazione evento.

command_intent_state appartiene al container_command_intent.

La preview viene nascosta quando:

input_analysis_result.readiness.canShowEventPreview = false

In particolare:

- input vuoto
- command intent
- input non ancora pronto
- edit mode gestito dal flow event ma con notice dedicata se attivo

Nota:

command_intent_state resta la fonte funzionale del comando.
ui_visibility_mode / input_analysis_result governano la visibilità del flow input.

Nota UX Mobile Coherence Pass:

La preview NON legge:

- feedback_summary
- feedback_mode
- container_app_nav
- stato Dashboard
- Navigation dock
- command_intent_state come fonte evento

Motivo:

feedback_summary / feedback_mode appartengono al feedback post-save o post-create.
container_app_nav appartiene alla navigazione UI.
command_intent_state appartiene al container_command_intent.
La preview resta limitata alla rappresentazione dell’input evento interpretato.

Nota:

select1.value è la fonte runtime del type per la preview.

La preview può usare select1.value per rappresentare il type,
ma non scrive direttamente events.type.

La persistenza avviene solo nel confirm flow.

Dopo Match Engine Unification First Controlled Level:

project_state.data / entity_state.data forniscono:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

Dopo Project / Entity Create Suggestion First Controlled Level:

create_suggestion_state.data fornisce:

- project.noMatch
- project.shouldShowNoMatchHint
- project.shouldSuggestCreate
- project.candidateName
- project.draftName
- project.baseName
- project.requiresUserOverride
- entity.noMatch
- entity.shouldShowNoMatchHint
- entity.shouldSuggestCreate
- entity.candidateName
- entity.draftName
- entity.baseName
- entity.requiresUserOverride

Nota post G22:

requiresUserOverride viene usato da preview_analysis_state per mostrare
warning mirati nella card Da verificare quando esiste già una selezione
attiva ma l’input suggerisce una nuova associazione più specifica.

requiresUserOverride non salva dati e non blocca Conferma.

---

Fonte dati strutturata principale:

```js
ui_state.parsed = {
  amount,
  unit,
  event_date
}

Fonti ancora multiple:

parsed data
raw input
match state project/entity
select values
select1.value
create_suggestion_state
command_intent_state
dismissed state project/entity
local label logic
local hint logic
command UI logic
ui_visibility_mode
ui_visibility_state residuo tecnico deprecabile
preview_analysis_state
input_analysis_result

Conseguenza:

✔ dati principali coerenti con save flow
⚠ preview ancora dipendente da più fonti
✔ matching project/entity più coerente con select/confirm
⚠ preview ancora dipendente da più fonti
⚠ possibile incoerenza visuale su hint non matching
⚠ possibile divergenza tra dato interno e formattazione mostrata
✔ command intent separato dal salvataggio evento
✔ preview_analysis_state introdotto come fonte hint/status della Sintesi
✔ input_analysis_result introdotto come layer compositivo raw / selection / effective
✔ input_analysis_result ora fonte UI controllata per gli Hidden principali del flow input
⚠ input analysis model completo non implementato
⚠ ui_visibility_state resta residuo tecnico deprecabile
⚠ esistono ancora più helper specializzati, ma input_analysis_result ne compone una parte

OUTPUT DELLA PREVIEW

Output UI composto da:

- card Sintesi
- labelStyled
- stato OK / Verifica / Attenzione
- righe dati:
  - Tipo
  - Data
  - riga valore con label semantica:
    - Importo per euro
    - Durata per ore/minuti
    - Valore per fallback non riconosciuti
  - Progetto
  - Entità
- micro-azioni visive:
  - Cambia
  - Scegli
- card Da verificare, se necessaria
- warning G22 “Associazione progetto/entità da controllare”, se presente match + suggestion extension
- notice associazioni mancanti, se necessario

Non include:

- container_command_intent
- txt_command_intent_title
- txt_command_intent_description
- txt_command_edit_steps
- input_command_project_name
- input_command_entity_name
- btn_command_create_project
- btn_command_create_entity
- btn_command_go_events

Non include inoltre:

- ui_visibility_mode
- ui_visibility_state
- input_analysis_result
- preview_analysis_state

Nota:

preview_analysis_state non è output preview.
È il layer read-only che prepara hint/status/missing association per la Sintesi.

input_analysis_result non è output preview.
È il layer compositivo che decide parte della readiness/visibility UI.

ui_visibility_state non è output preview.
È un residuo tecnico deprecabile e non governa più gli Hidden principali migrati.

Nota:

Le micro-azioni “Cambia” / “Scegli” sono solo indicatori visivi.

Non sono ancora cliccabili.

Possibili comportamenti futuri:

- focus campo relativo
- scroll verso Dati evento
- highlight temporaneo select
- apertura dropdown solo se Retool lo consente stabilmente

Container suggestion separato:

create_suggestion_hint
azioni Crea progetto / Crea entità / Ignora
micro-editor project/entity

Dopo UX Mobile Coherence Pass:

Il container suggestion è stato rifinito graficamente,
ma resta separato dalla Sintesi.

La suggestion create continua a non essere dato preview persistito.

Nota:

questi elementi sono collegati alla preview UX,
ma non fanno parte della stringa `labelStyled`.

La suggestion create è UI di supporto,
non dato preview persistito.

Container command separato:

container_command_intent
azioni Crea progetto / Crea entità / Vai agli eventi
input_command_project_name
input_command_entity_name

Dopo Command Intent — Create Project / Entity:

Il container_command_intent è stato introdotto per evitare che
i comandi puri vengano trattati come eventi.

Dopo Input Analysis Result Controlled UI Consumption, questa sostituzione è coordinata da:

- ui_visibility_mode
- input_analysis_result.readiness.canShowCommandContainer
- input_analysis_result.readiness.canShowEventPreview
- input_analysis_result.readiness.canShowEventData

button_input_confirm.Hidden è stato migrato a input_analysis_result.readiness.canShowConfirm.
button_input_confirm.Disabled e payload restano fuori dalla migrazione.

Risultato:

- meno flash tra evento e command
- meno rendering progressivo
- Hidden principali più centralizzati

Il command container non fa parte della stringa labelStyled.

Regola:

container_command_intent sostituisce Sintesi evento e Dati evento
quando l’input è un comando puro.

La UI command è supporto operativo controllato,
non dato preview persistito.

Formato:

[labelStyled]
[typeBadge]
[hint]

Join:

.filter(Boolean).join("\n")

Output visivo attuale:

amount
unit
type / typeBadge
label
eventuale data
eventuale project/entity
eventuale hint

Nota:

Il dato interno resta numerico e non localizzato.

La visualizzazione viene formattata solo nella preview.

Esempio durata normalizzata:

Dato interno:

amount: 150
unit: minuti

raw_input:

2h30 rendering

Preview attuale:

2 ore 30 minuti • rendering
Normalizzato: 150 minuti

DB:

amount 150
unit minuti

Regola:

la durata viene salvata come minuti canonici.
La forma umana è solo visuale.
raw_input conserva la forma originaria inserita dall’utente.

Esempio type classification:

Dato interno parsing:

amount: 150
unit: minuti

raw_input:

2h30 rendering

select1:

Tempo

Preview:

2 ore 30 minuti • rendering
Normalizzato: 150 minuti
typeBadge / select1: Tempo

DB dopo confirm:

type Tempo
amount 150
unit minuti

Regola:

la preview rappresenta il type corrente,
ma non salva direttamente il dato.

Esempio command generico:

raw_input:

crea

Preview evento:

non mostrata

Command container:

guida con esempi di creazione progetto / entità

DB:

nessun evento salvato

---

Esempio create project:

raw_input:

crea progetto Villa Nuova

Preview evento:

non mostrata

Command container:

riepilogo progetto + CTA Crea progetto

Azione:

btn_command_create_project
→ insert_project

DB:

nuovo record in projects
nessun evento salvato

---

Esempio create entity:

raw_input:

crea entità Patrizio

Preview evento:

non mostrata

Command container:

riepilogo entità + CTA Crea entità

Azione:

btn_command_create_entity
→ insert_entity

DB:

nuovo record in entities
nessun evento salvato

---

Esempio elemento già presente:

raw_input:

crea progetto villa

Preview evento:

non mostrata

Command container:

Elemento già presente

Azione:

nessun bottone crea

DB:

nessuna duplicazione
nessun evento salvato

---

Esempio guida modifica evento:

raw_input:

modifica evento

Preview evento:

non mostrata

Command container:

guida operativa + CTA Vai agli eventi

Azione:

btn_command_go_events
→ Lista eventi

DB:

nessuna modifica
nessun evento salvato

------------------------------------------------
COMMAND INTENT E PREVIEW
------------------------------------------------

Il nodo Command Intent — Create Project / Entity ha introdotto
un layer UI separato dalla Sintesi.

Componenti coinvolti:

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

Regola principale:

la preview non deve competere con il command intent.

Dopo Input Analysis Result Controlled UI Consumption,
questa regola viene applicata tramite input_analysis_result.readiness.

Pattern:

evento ordinario:
- effectiveFlowType = event
- canShowEventPreview = true
- canShowCommandContainer = false
- canShowEventData = true

command:
- effectiveFlowType = command
- canShowEventPreview = false
- canShowCommandContainer = true
- canShowEventData = false

edit:
- effectiveFlowType = edit
- command raw può essere true
- command effective viene soppresso
- event flow resta prevalente

input vuoto in edit:
- canShowEventPreview = false
- canShowEventData = false
- canShowConfirm = false
- Annulla modifica resta visibile tramite input_analysis_result

Nota:

button_input_confirm.Hidden è governato da input_analysis_result.
button_input_confirm.Disabled e payload restano separati.

Se l’input è un evento ordinario:

- mostra Sintesi
- mostra eventuale Da verificare
- mostra suggestion container se necessario
- mostra Dati evento
- button_input_confirm salva evento dopo conferma

Se l’input è comando puro:

- nasconde Sintesi
- nasconde Dati evento
- nasconde suggestion container evento se necessario
- mostra container_command_intent
- usa azioni command dedicate
- non salva eventi

---

Casi gestiti:

crea
→ guida con esempi
→ nessuna preview evento

crea progetto
→ input_command_project_name
→ nessuna preview evento

crea progetto [nome]
→ riepilogo command
→ btn_command_create_project
→ nessuna preview evento

crea entità
→ input_command_entity_name
→ nessuna preview evento

crea entità [nome]
→ riepilogo command
→ btn_command_create_entity
→ nessuna preview evento

crea progetto villa
→ Elemento già presente
→ nessun bottone crea
→ nessuna preview evento

modifica evento
→ guida step
→ btn_command_go_events
→ nessuna preview evento

---

Nota:

Command Intent non rende la preview più pura.
La separa solo dal caso comando puro.

La preview resta ibrida per gli input evento ordinari.

------------------------------------------------
UI READINESS / INPUT ANALYSIS RESULT E PREVIEW
------------------------------------------------

Il nodo UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
ha introdotto un primo layer read-only di visibilità UI.

Successivamente, il nodo INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS
ha migrato una prima parte della visibilità UI verso input_analysis_result.

Il nodo INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
ha completato la migrazione degli Hidden principali del flow input a input_analysis_result.

Componenti coinvolti:

- ui_visibility_mode
- ui_visibility_state residuo tecnico deprecabile
- preview_analysis_state
- input_analysis_result

Ruolo:

stabilizzare quando mostrare Sintesi, command container, suggestion,
Dati evento, input container, loading, cancel e Conferma Hidden.

---

ui_visibility_mode:

- Variable Retool
- valori:
  - empty
  - event
  - command
- aggiornata da trigger_parse_debounced
- serve solo come latch UI
- non salva dati
- non sostituisce command_intent_state

---

ui_visibility_state:

- Transformer Retool legacy/residuo
- precedentemente aggregatore read-only di visibilità
- non è più letto da input_analysis_result
- non governa più gli Hidden principali migrati
- non modifica il contenuto della Sintesi
- non modifica labelStyled
- non modifica hint
- non modifica highlight
- non modifica parser
- non modifica matching
- non modifica create_suggestion_state
- non modifica command_intent_state
- non modifica DB
- non costruisce payload
- non va eliminato fuori da cleanup dedicato

---

input_analysis_result:

- Transformer Retool compositivo read-only
- fonte UI controllata per gli Hidden principali del flow input
- legge preview_analysis_state
- espone readiness / visibility
- espone raw / selection / effective
- non salva dati
- non costruisce payload
- non sostituisce parser, matching, suggestion, command, select o save flow

Componenti ora governati da input_analysis_result:

- sintesi.Hidden
- container_command_intent.Hidden
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

Readiness principali:

- canShowEventPreview
- canShowCommandContainer
- canShowAssociationSuggestions
- canShowEventData
- canShowConfirm

Regola Conferma:

- canShowConfirm = visibilità bottone Conferma
- canConfirm = readiness funzionale
- button_input_confirm.Disabled = guard funzionale separata
- button_input_confirm payload = invariato

Componenti NON migrati perché routing principale app:

- container_home.Hidden
- container_feedback.Hidden
- container_events_list.Hidden

Regola:

ui_state.view = routing principale app
input_analysis_result = readiness / visibility flow input
ui_visibility_mode = latch empty / event / command

Risultati:

✔ Sintesi mostrata solo nel flow evento
✔ Sintesi nascosta nel flow command
✔ container command mostrato in modo più stabile
✔ Dati evento nascosti nel flow command
✔ Conferma evento nascosta nel flow command
✔ container vuoto durante digitazione risolto
✔ flash input flow ridotto
✔ bottom bar flash risolto tramite container_app_nav
✔ Hidden principali migrati a input_analysis_result
✔ edit mode + input vuoto stabilizzato
✔ Home idle container nascosti durante edit mode
✔ Dati evento / Sintesi / Conferma nascosti con edit input vuoto
✔ Annulla modifica visibile con edit input vuoto
✔ notice associazioni mancanti resa coerente con presenza reale dei suggerimenti
✔ nessun loop input_analysis_result / ui_visibility_state
✔ save flow invariato

Limiti:

⚠ la Sintesi resta ibrida nel contenuto
⚠ hint/warning restano embedded
⚠ “Da verificare” resta interno alla Sintesi / card collegata
⚠ input_analysis_result non è Input Analysis Model completo
⚠ button_input_confirm.Disabled non è migrato
⚠ save readiness completa non centralizzata
⚠ ui_visibility_state resta presente fisicamente come residuo tecnico
⚠ label “Importo” ancora usata anche per valori durata

COMPONENTI LOGICI INTERNI

La preview contiene attualmente:

Solo per input evento ordinari.

Per command intent, questi componenti devono essere bypassati
o nascosti lato UI.

VALUE BUILDER

costruzione amount + unit
lettura da ui_state.parsed
formattazione visuale italiana

Gestione formati:

euro
minuti
durate normalizzate

Funzioni introdotte:

- formatAmountIT
- formatUnitIT
- formatDurationHumanIT
- formatDurationMinutesIT

Comportamento:

- euro → simbolo €
- euro → due decimali
- amount euro con grouping migliaia
- ore/minuti → massimo due decimali
- virgola italiana nei decimali
- singolare/plurale unit gestito

Esempi:

1500 euro → 1.500,00 €
1.500,50 euro → 1.500,50 €
18min → 18 minuti
1ora → 1 ora + hint Normalizzato: 60 minuti
1 ora e 15 minuti → 1 ora 15 minuti + hint Normalizzato: 75 minuti
2h30 → 2 ore 30 minuti + hint Normalizzato: 150 minuti
2,7 ore → 2 ore 42 minuti + hint Normalizzato: 162 minuti

Nota:

il value builder non modifica ui_state.parsed
e non modifica il dato salvato.

Nel caso delle durate, il value builder mostra una forma umana
partendo dal valore interno già normalizzato in minuti.

Esempio:

ui_state.parsed.amount = 150
ui_state.parsed.unit = minuti

preview value:

2 ore 30 minuti

hint:

Normalizzato: 150 minuti

Nota post PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT:

La riga valore della card Sintesi usa ora una label derivata da parsed.unit.

Regola runtime:

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

DATE FORMATTER
converte YYYY-MM-DD → formato breve leggibile
mesi localizzati

TYPE DISPLAY / SELECT1 SUPPORT

La preview utilizza select1.value come fonte runtime del type.

select1 è il componente UI Select dedicato alla classificazione base.

Valori attuali:

- Evento
- Tempo
- Spesa
- Incasso

Relazione con Type Classification Base:

parsed.unit = minuti
→ select1 = Tempo

euro + keyword controllate di uscita
→ select1 = Spesa

euro + keyword controllate di entrata
→ select1 = Incasso

euro senza direzione chiara
→ select1 = Evento

segnali contrastanti
→ select1 = Evento

nessuna unit significativa
→ select1 = Evento

Esempi:

2h30 rendering
→ preview durata: 2 ore 30 minuti
→ select1: Tempo

20 euro spesa materiale
→ preview amount: 20,00 €
→ select1: Spesa

20 euro incasso cliente
→ preview amount: 20,00 €
→ select1: Incasso

20 euro materiale
→ preview amount: 20,00 €
→ select1: Evento

Nota:

la preview non decide autonomamente il type.
La logica è nel Default value del componente select1.

La preview mostra/supporta lo stato risultante.

LABEL CLEANING (ATTIVO)

Operazioni:

- normalizzazione testo
- separazione simboli (€)
- gestione unit compatte
- rimozione amount + unit già rappresentati dal value
- rimozione date già parse
- compressione spazi
- preservazione numeri semantici
- ricomposizione parola + numero
- rimozione durate composte già normalizzate
- rimozione forme compatte tipo 2h30
- rimozione residui congiunzione e/ed

Aggiornamenti Preview Alignment Base:

✔ rimozione migliorata di euro separati e compatti  
✔ rimozione migliorata di ore separate e compatte  
✔ rimozione migliorata di minuti separati e compatti  
✔ corretto bug "minuti" → "uti"  
✔ preservato caso "villa 2"  
✔ label più coerente con ui_state.parsed 
✔ durate composte rimosse dopo Duration Normalization  
✔ forme compatte 2h30 / 2 h 30 rimosse dalla label  
✔ residui “e/ed” rimossi dopo cleaning durata  
✔ gestione € prima del numero corretta  
✔ bug duplicazione €500 risolto   

Esempi:

1.500,50 euro materiale
→ 1.500,50 € • materiale

18 minuti test
→ 18 minuti • test

18min test
→ 18 minuti • test

1 ora e 15 minuti sopralluogo
→ 1 ora 15 minuti • sopralluogo
→ Normalizzato: 75 minuti

2h30 rendering
→ 2 ore 30 minuti • rendering
→ Normalizzato: 150 minuti

2 ore e 30 minuti rendering
→ 2 ore 30 minuti • rendering
→ Normalizzato: 150 minuti

villa 2 mario
→ villa 2 mario

€500 acconto alfie mario rossi
→ 500,00 € • acconto alfie mario rossi

Nota:

il label cleaning resta visuale,
embedded nella sintesi e non persistito.

TOKEN LOGIC
split parole
recombine parola + numero
(es: "villa 2")
limitazione lunghezza label

LABEL BUILDING

Struttura:

MAIN:

[data] • [value] • [primary]

oppure, senza amount/unit:

[data] • [primary]

Output:

labelFull / labelStyled

Aggiornamento:

la data viene separata dalla descrizione anche quando non esiste amount/unit.

Esempio:

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

HIGHLIGHT ENGINE

evidenzia:

entity → verde (#059669)
project → blu (#2563eb)

Fonte dati dopo Match Engine Unification First Controlled Level:

project_state.data.matches
entity_state.data.matches

---

Comportamento:

- project evidenziati dai matches di project_state
- entity evidenziate dai matches di entity_state
- quando possibile viene evidenziato il nome completo
- la preview non calcola più detection locale come fonte decisionale matching

Esempio:

villa 2 mario
→ villa 2 evidenziato come project
→ mario evidenziato come entity

---

Protezione:

escape regex

---

Token tecnici esclusi:

- ora
- ore
- h
- min
- minuto
- minuti
- euro
- eur
- giorno
- giorni
- settimana
- settimane
- giornata
- giornate

Funzioni runtime ancora presenti:

previewStopTokens
getPreviewTokens

Nota:

questo filtro resta utile per evitare highlight impropri
su unità tecniche o parole non rilevanti.

Dopo Match Engine Unification,
l’highlight project/entity legge però i matches da:

- project_state.data.matches
- entity_state.data.matches

La preview non usa più detection locale come fonte decisionale matching.

HINT SYSTEM

Nota post Preview Analysis State:

La logica hint/status principale della Sintesi è stata raccolta a primo livello in preview_analysis_state.

preview_analysis_state espone:

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

La Sintesi legge questi valori per costruire la card Da verificare,
lo status e le notice collegate.

La Sintesi resta comunque responsabile del rendering HTML finale.

Basato su:

- project_state.data
- entity_state.data
- parsed.unit
- select1.value
- contenuto testo
- condizioni locali preview

---

TIPI DI HINT:

AMBIGUITÀ MATCHING:

entity_state.isAmbiguous = true
e select_entity vuoto
→ "⚠️ Più entità trovate"

project_state.isAmbiguous = true
e select_project vuoto
→ "⚠️ Più progetti trovati"

------------------------------------------------
STRUTTURA UX MOBILE DELLA SINTESI
------------------------------------------------

Durante UX Mobile Coherence Pass, la Sintesi è stata confermata come card strutturata.

Struttura:

- intestazione Sintesi
- indicatore stato:
  - OK
  - Verifica
  - Attenzione
- frase interpretata
- righe dati:
  - Tipo
  - Data
  - Importo / Durata / Valore in base all’unità rilevata
  - Progetto
  - Entità
- micro-azioni visive:
  - Cambia
  - Scegli

Regola:

La Sintesi rappresenta ciò che LOGOS ha interpretato.

Non decide cosa salvare.

Le fonti salvabili restano:

- select1.value
- select_project.value
- select_entity.value
- ui_state.parsed

La Sintesi non è una form.

Nota post PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT:

La riga valore della Sintesi non usa più una label fissa “Importo”.

Comportamento consolidato:

- parsed.unit = euro → label Importo, icona €
- parsed.unit = ore / minuti → label Durata, icona temporale
- altro valore non riconosciuto → label Valore, icona neutra

La modifica è solo visuale / micro-copy.

Non modifica:

- parser
- duration normalization
- type classification
- matching
- input_analysis_result
- preview_analysis_state
- button_input_confirm
- payload
- insert_event / update_event
- DB

------------------------------------------------
CARD “DA VERIFICARE”
------------------------------------------------

Durante UX Mobile Coherence Pass, gli hint operativi sono stati confermati
come blocco separato dalla Sintesi.

Ruolo:

- mostrare controlli richiesti
- evidenziare ambiguità
- evidenziare warning non bloccanti
- guidare l’utente verso Dati evento

Esempi:

- Più entità trovate
- Più progetti trovati
- Definisci spesa o incasso
- Associazione progetto da controllare
- Associazione entità da controllare
- Normalizzato: X minuti
- Durata ambigua

Regola:

La Sintesi mostra cosa LOGOS ha interpretato.
La card Da verificare mostra cosa l’utente deve controllare.

Nota post UI Readiness:

La card Da verificare resta collegata alla Sintesi/event flow.
Non è stata trasformata in un modello hint autonomo.

La sua visibilità può essere coordinata dal flow event,
ma il contenuto e la logica interna restano parte del Preview System.

Decisione:

Non è stata creata una tab Ambiguità.
La separazione resta una card visibile solo quando serve.

Nota post Preview Analysis State:

La logica che decide se esistono hint, warning, ambiguità o stati “Da verificare”
è stata spostata a primo livello in preview_analysis_state.

La card resta visualmente nella Sintesi,
ma la fonte logica primaria non è più interamente embedded nel codice Sintesi.

Nota post G22:

La card Da verificare segnala anche il rischio decisionale nei casi:

match presente + suggestion extension

Esempi:

Associazione progetto da controllare
Villa selezionato · testo letto: Villa Sierri

Associazione entità da controllare
Mario selezionata · testo letto: Mario Giordano

Questi warning sono non bloccanti.

La card Da verificare non propone direttamente l’azione di creazione.
L’azione resta nel container Suggerimenti associazione.

Residui:

status OK + card Da verificare può ancora produrre incoerenza semantica.
Questo è tracciato come futuro Status Semantics Alignment.

Il balloon blu “Manca progetto / Manca entità” può risultare ridondante
rispetto al container Suggerimenti associazione in alcuni casi.
Questo è tracciato come futuro Preview / Missing Association Notice Cleanup.

------------------------------------------------
NOTICE ASSOCIAZIONI MANCANTI
------------------------------------------------

Durante UX Mobile Coherence Pass è stato confermato il notice informativo
quando mancano progetto e/o entità ma non c’è ambiguità bloccante.

Esempi:

- Manca un progetto e un’entità
- Manca un progetto
- Manca un’entità

Testo dinamico dopo Input Analysis Result Controlled UI Consumption:

Se i suggerimenti operativi sono visibili:

“Puoi selezionare i dati nei campi sotto o usare i suggerimenti.”

Se i suggerimenti operativi non sono visibili:

“Puoi selezionare i dati nei campi sotto.”

Regola:

Il notice NON compare in presenza di ambiguità bloccante.

Motivo:

In presenza di ambiguità, la priorità comunicativa resta la card Da verificare.

Decisione:

Il notice resta nella Sintesi perché collega:

- interpretazione
- suggestion container
- Dati evento

Decisione consolidata:

missing association notice
≠
suggestion operativa

La Sintesi può mostrare che manca un progetto o un’entità
anche quando create_suggestion_state non produce contenuti operativi.

In quel caso:

- non si forza il container suggestion a comparire
- si evita un container vuoto
- il testo della notice non promette suggerimenti non presenti

Fonte per la presenza reale dei suggerimenti:

input_analysis_result.readiness.canShowAssociationSuggestions

---

SUGGESTION CREATE:

create_suggestion_state può produrre hint/azioni di creazione, ad esempio:

- Nessun progetto associato
- Nessuna entità associata
- Crea progetto “Villa Sierri 15”
- Crea entità “Referente Kappa”

Nota post G22:

Nel caso match presente + suggestion extension, il container Suggerimenti associazione
mostra solo l’azione disponibile.

Esempi:

- Possibile nuovo progetto: Villa Sierri
- Possibile nuova entità: Mario Giordano

Non deve duplicare la selezione corrente già mostrata in Da verificare.

Ruoli consolidati:

Da verificare:
segnala il rischio decisionale.

Suggerimenti associazione:
propone l’azione disponibile.

Questi non sono semplici hint informativi.

Sono suggestion create, cioè azioni guidate.

Differenza:

HINT INFORMATIVO:

- segnala uno stato
- non apre insert
- non modifica DB
- non modifica select

Esempi:

- Esistono progetti più specifici
- Esistono entità più specifiche
- Normalizzato: 150 minuti

SUGGESTION CREATE:

- propone una possibile azione
- può aprire micro-editor
- può eseguire insert_project / insert_entity
- richiede conferma utente
- non salva evento automaticamente

Esempi:

- Crea progetto Villa Sierri 15
- Crea entità Referente Kappa

Distinzione da Command Intent:

create_suggestion_state opera dentro il flow evento ordinario.

Esempio:

30 euro spesa villa nuova
→ evento ordinario
→ possibile suggestion progetto
→ eventuale creazione inline
→ poi Conferma evento

command_intent_state opera fuori dal flow evento ordinario.

Esempio:

crea progetto Villa Nuova
→ comando puro
→ container_command_intent
→ insert_project
→ nessun evento salvato

Regola:

Le due UI non devono competere.

- suggestion container = supporto associazione evento
- command container = comando strutturale puro

Dopo UI Readiness:

container_association_suggestions viene mostrato/nascosto tramite:

input_analysis_result.readiness.canShowAssociationSuggestions

Questo riduce la competizione visuale con:

- container_command_intent
- Sintesi
- Dati evento

Ma non modifica create_suggestion_state.

---

G22 — MATCH PRESENT / USER OVERRIDE:

Quando esiste già una selezione attiva ma l’input suggerisce una nuova
associazione più specifica, la card Da verificare mostra un warning mirato.

Fonte:

create_suggestion_state.data.project.requiresUserOverride
create_suggestion_state.data.entity.requiresUserOverride

Project:

project.requiresUserOverride = true
→ "ℹ️ Associazione progetto da controllare"

Action / dettaglio:

[baseName] selezionato · testo letto: [candidateName]

Entity:

entity.requiresUserOverride = true
→ "ℹ️ Associazione entità da controllare"

Action / dettaglio:

[baseName] selezionata · testo letto: [candidateName]

Esempio project:

20 euro villa sierri
→ select_project = Villa
→ candidateName = Villa Sierri
→ Da verificare:
  Associazione progetto da controllare
  Villa selezionato · testo letto: Villa Sierri

Esempio entity:

20 euro mario giordano
→ select_entity = Mario
→ candidateName = Mario Giordano
→ Da verificare:
  Associazione entità da controllare
  Mario selezionata · testo letto: Mario Giordano

Regole:

- warning non bloccante
- Conferma resta attiva
- select_project / select_entity restano valorizzate
- suggestion ignorata non blocca il salvataggio
- payload invariato
- save flow invariato

MATCH PIÙ SPECIFICI — STATO POST G22:

entity_state.hasMoreSpecificMatches / project_state.hasMoreSpecificMatches
restano segnali informativi del Match Engine.

Tuttavia, il vecchio warning generico:

- "ℹ️ Esistono entità più specifiche"
- "ℹ️ Esistono progetti più specifici"

non è più usato come segnale principale per i casi G22.

Motivo:

hasMoreSpecificMatches indica solo che nel DB esistono record più specifici.
Non indica necessariamente che l’input corrente stia chiedendo una nuova
associazione più specifica.

Per i casi G22 il segnale corretto deriva da:

create_suggestion_state.requiresUserOverride

---

ECONOMICO / TYPE:

ℹ️ Definisci spesa o incasso

Usato quando:

- è presente euro
- manca una direzione economica chiara
- select1 resta Evento
- l’utente deve scegliere manualmente Spesa o Incasso

---

TEMPO:

ℹ️ Normalizzato: X minuti

⚠️ Durata ambigua: specifica ore/minuti per salvarla come tempo analizzabile

---

Caratteristiche:

✔ hint matching project/entity alimentati da state  
✔ hint ambiguità matching bloccanti finché non risolti  
✔ hint match più specifici informativi e non bloccanti  
✔ hint rossi spariscono se l’utente risolve manualmente l’ambiguità  
✔ hint duration/type ancora embedded nella preview  
✔ controllo utente preservato  

---

Aggiornamento Duration Normalization Base:

- il vecchio hint generico “Verifica durata” è stato superato
- le durate certe mostrano il valore tecnico normalizzato
- giorni/settimane mostrano hint ambiguità

---

Aggiornamento Type Classification Base:

- select1 è allineato a ui_state.parsed.unit
- le durate certe con unit = minuti impostano Tempo
- euro + keyword controllate imposta Spesa o Incasso
- euro senza direzione chiara resta Evento
- la preview può guidare l’utente alla scelta manuale
- il type viene poi salvato dal confirm flow

---

Aggiornamento Match Engine Unification First Controlled Level:

- hint matching project/entity derivano da project_state/entity_state
- hint ambiguità derivano da isAmbiguous
- hint più specifici derivano da hasMoreSpecificMatches
- preview non ricalcola matching decisionale
- confirm guard blocca solo ambiguità non risolte

Limite:

non esiste ancora un hint engine globale separato.

Nota post Preview Analysis State / Input Analysis Result:

preview_analysis_state ha separato a primo livello la logica hint/status dalla Sintesi,
ma non ha trasformato la Sintesi in view pura.

input_analysis_result legge preview_analysis_state e ne usa lo stato dentro la propria composizione.

Il nodo Input Analysis Result Controlled UI Consumption ha agito sul livello di visibilità e readiness parziale:

- mostrare/nascondere Sintesi
- mostrare/nascondere suggestion container
- mostrare/nascondere Dati evento
- mostrare/nascondere command container
- allineare micro-copy della notice associazioni mancanti

Restano ancora fuori:

- button_input_confirm.Disabled
- save readiness completa
- separazione finale della card “Da verificare”
- Status Semantics Alignment
- Event Data Label Semantic Alignment

Nota post Visibility Migration Completion:

La migrazione degli Hidden principali a input_analysis_result non modifica il contenuto degli hint,
ma stabilizza quando la Sintesi, Dati evento, suggestion container e Conferma Hidden vengono mostrati.

Il residuo principale non è più “quando mostrare”,
ma “cosa mostrare” e con quale semantica.

Residuo osservato:

2h30 rendering lavoro
→ label Dati evento “Importo” anche se il valore rappresenta durata

Nodo futuro candidato:

PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT

Per completare davvero il modello preview/hint serve ancora un nodo dedicato:

PREVIEW MODEL / HINT STATE CONSOLIDATION

Aggiornamento Project / Entity Create Suggestion First Controlled Level:

- no-match project/entity può generare suggestion create
- suggestion create non è salvataggio evento
- suggestion ignorata non blocca conferma
- project/entity ambigui non mostrano create suggestion per quel layer
- project/entity mancanti non bloccano conferma
- entity autofill controlled minimal precompila input_new_entity_name, ma non è preview

COMPORTAMENTO MATCHING IN PREVIEW

Nota canonica:

La fonte completa per la logica Match Engine project/entity è:

- 02_LOGOS_Match_Engine

Questo documento conserva il comportamento visuale della preview rispetto al matching:

- highlight project/entity
- hint ambiguità
- hint match più specifici
- separazione tra match visuale e decisione salvabile

Regola:

la preview rappresenta il match state.
La decisione finale resta nelle select.

La preview NON è fonte primaria di matching.

Dopo Match Engine Unification First Controlled Level:

✔ utilizza project_state/entity_state  
✔ evidenzia matches da match state  
✔ mostra ambiguità tramite isAmbiguous  
✔ mostra match più specifici tramite hasMoreSpecificMatches  
✔ non usa detection locale come fonte decisionale  
✔ resta supporto visuale alla scelta utente  

---

Regole generali:

count = 1
→ singleMatch
→ select_project/select_entity valorizzati
→ preview evidenzia match
→ conferma abilitata

count > 1
→ isAmbiguous
→ select vuota
→ hint rosso
→ conferma disabilitata finché l’utente non sceglie

count = 0
→ nessuna ambiguità
→ conferma non bloccata
→ possibile suggestion create tramite create_suggestion_state

hasMoreSpecificMatches = true
→ segnale informativo interno/non principale nei casi G22

match presente + suggestion extension
→ create_suggestion_state.requiresUserOverride = true
→ warning mirato in Da verificare
→ suggestion operativa nel container Suggerimenti associazione
→ Conferma resta attiva

---

Esempi:

villa 2 mario
→ project Villa 2
→ entity Mario
→ evidenza project/entity
→ conferma abilitata

mario
→ entity Mario
→ nessun warning G22 se l’input non suggerisce una nuova entità più specifica
→ conferma abilitata

villa
→ project Villa
→ nessun warning G22 se l’input non suggerisce un nuovo progetto più specifico
→ conferma abilitata

villa sierri
→ project Villa
→ create_suggestion_state.project.requiresUserOverride = true
→ Da verificare: Associazione progetto da controllare
→ Suggerimenti associazione: Possibile nuovo progetto Villa Sierri
→ conferma abilitata

mario giordano
→ entity Mario
→ create_suggestion_state.entity.requiresUserOverride = true
→ Da verificare: Associazione entità da controllare
→ Suggerimenti associazione: Possibile nuova entità Mario Giordano
→ conferma abilitata

alfie mario rossi
→ ambiguità reale entity
→ hint Più entità trovate
→ conferma disabilitata

---

Nota:

la preview rappresenta il match state,
ma non salva direttamente project/entity.

Il salvataggio avviene tramite:

select_project.value
select_entity.value

Dopo Project / Entity Create Suggestion:

se l’utente crea project/entity inline,
la select relativa viene valorizzata.

La preview continua comunque a non salvare direttamente project/entity.

------------------------------------------------
RELAZIONE CON CREATE SUGGESTION
------------------------------------------------

Nota canonica:

La fonte completa per create_suggestion_state nel contesto input è:

- 01_LOGOS_Input_System

La fonte completa per il wiring Retool del container suggestion e delle azioni inline è:

- 04_LOGOS_Retool_Architecture

Questo documento conserva il rapporto visuale tra Preview/Sintesi, notice associazioni mancanti e suggestion container.

Regola:

la suggestion create non è preview pura,
non è salvataggio evento
e non sostituisce select_project / select_entity.

La preview/sintesi convive con un container suggestion separato.

create_suggestion_state legge:

- input_raw
- project_state
- entity_state
- projects_list
- entities_list
- select_project
- select_entity

e produce suggestion controllate per project/entity.

---

PRINCIPIO:

Preview ≠ suggestion create.

La preview mostra ciò che il sistema ha interpretato.

La suggestion create propone un’azione possibile.

Nota post G22:

Quando una suggestion create nasce come extension di un match già selezionato,
la preview non deve trattarla come semplice no-match e non deve trasformarla
in ambiguità bloccante.

Classificazione:

MATCH PRESENT + SUGGESTION EXTENSION

Esempio project:

20 euro villa sierri
→ project_state.singleMatch = Villa
→ create_suggestion_state.project.candidateName = Villa Sierri
→ create_suggestion_state.project.baseName = Villa
→ create_suggestion_state.project.requiresUserOverride = true

Output Preview:

Da verificare:
Associazione progetto da controllare
Villa selezionato · testo letto: Villa Sierri

Suggerimenti associazione:
Possibile nuovo progetto: Villa Sierri

Esempio entity:

20 euro mario giordano
→ entity_state.singleMatch = Mario
→ create_suggestion_state.entity.candidateName = Mario Giordano
→ create_suggestion_state.entity.baseName = Mario
→ create_suggestion_state.entity.requiresUserOverride = true

Output Preview:

Da verificare:
Associazione entità da controllare
Mario selezionata · testo letto: Mario Giordano

Suggerimenti associazione:
Possibile nuova entità: Mario Giordano

Regola:

La preview segnala il controllo.
La suggestion propone l’azione.
La select resta decisione finale salvabile.

Nota post Input Analysis Result:

container_association_suggestions.Hidden ora legge:

input_analysis_result.readiness.canShowAssociationSuggestions

Tuttavia il contenuto del container suggestion resta governato da:

create_suggestion_state

Regola:

input_analysis_result può decidere se mostrare il container,
ma non deve inventare contenuti operativi.

Se create_suggestion_state non produce contenuti,
il container non deve apparire vuoto.

La notice associazioni mancanti nella Sintesi resta informativa
e non equivale a una suggestion operativa.

---

ESEMPI:

1. Match informativo più specifico

input:

villa

preview/hint:

Esistono progetti più specifici

Comportamento:

- hint informativo
- nessun insert
- Conferma abilitata

2. Suggestion create project

input:

villa sierri 15 sopralluogo

container suggestion:

Crea progetto “Villa Sierri 15”

Comportamento:

- azione guidata
- richiede click utente
- insert_project solo dopo conferma
- evento non salvato automaticamente

3. Suggestion create entity

input:

villa sierri 15 sopralluogo referente kappa

container suggestion:

Crea entità “Referente Kappa”

Comportamento:

- input_new_entity_name può essere precompilato
- insert_entity solo dopo conferma
- evento non salvato automaticamente

4. No-match generico ignorato

input:

acquisto 50 euro materiale nuovo

container suggestion:

Nessun progetto associato
Nessuna entità associata

utente clicca Ignora

Comportamento:

- container suggestion nascosto
- preview resta valida
- Conferma abilitata
- evento salvabile con project_id/entity_id null

---

ENTITY AUTOFILL CONTROLLED MINIMAL

L’autofill entity:

- non è preview
- non è matching
- non è salvataggio
- non crea entità
- precompila solo input_new_entity_name

Esempio:

referente kappa
→ input_new_entity_name = Referente Kappa

Non viene usato per labelStyled
e non modifica raw_input.

RELAZIONE CON PARSING

Nota canonica:

La fonte completa per parser, normalization base,
duration normalization base e type classification base nel contesto input è:

- 01_LOGOS_Input_System

Questo documento conserva solo il rapporto tra dati parsati e rappresentazione visuale in preview.

Regola:

la Preview legge ui_state.parsed e select1.value,
ma non esegue parsing,
non normalizza il dato salvabile
e non scrive nel payload.

Parsing strutturato avviene ora in:

✔ parse_input_controlled

e viene trasferito in:

✔ ui_state.parsed

La preview legge:

ui_state.parsed.amount
ui_state.parsed.unit
ui_state.parsed.event_date

Per il type, la preview legge:

select1.value

select1.value può dipendere da ui_state.parsed.unit.

Esempio:

ui_state.parsed.unit = minuti
→ select1.value = Tempo

Dopo il Normalization Layer Base:

ui_state.parsed contiene:

amount numerico
unit normalizzata
event_date
numeri senza unità esclusi da amount
amount con formato italiano convertito a numero

Esempi dati interni:

1.500,50 euro → amount 1500.5, unit euro
1ora lavoro → amount 60, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
2h30 rendering → amount 150, unit minuti
2 ore 30 rendering → amount 150, unit minuti
villa 2 mario → amount null, unit null
2 giorni rendering → amount null, unit null

Esempi type:

2h30 rendering
→ amount 150, unit minuti
→ select1 Tempo

20 euro spesa materiale
→ amount 20, unit euro
→ select1 Spesa

20 euro incasso cliente
→ amount 20, unit euro
→ select1 Incasso

20 euro materiale
→ amount 20, unit euro
→ select1 Evento

villa 2 mario
→ amount null, unit null
→ select1 Evento

Nota:

dopo Duration Normalization Base,
le durate certe ore/minuti vengono salvate sempre in minuti.

La preview può però mostrare una forma umana:

amount 150 / unit minuti
→ 2 ore 30 minuti
→ Normalizzato: 150 minuti

MA:

⚠ la preview applica ancora ulteriori trasformazioni:

cleaning
rimozione pattern
ricostruzione label
formattazione locale
hint logic

Quindi:

✔ la preview è più coerente nei dati principali
✘ ma non è ancora pura rappresentazione

RELAZIONE CON NORMALIZATION LAYER BASE / DURATION NORMALIZATION / TYPE CLASSIFICATION / MATCH ENGINE / CREATE SUGGESTION

Il Normalization Layer Base ha consolidato:

- amount normalization
- unit normalization
- numeri senza unità ignorati come amount
- formato numerico italiano convertito a numero
- insert/update basati su ui_state.parsed

Preview Alignment Base ha allineato la rappresentazione visuale
a questo stato.

Duration Normalization Base ha poi introdotto:

- unità canonica tempo = minuti
- conversione ore/minuti in minuti
- conversione durate composte
- conversione forme compatte tipo 2h30
- visualizzazione umana della durata in preview
- hint “Normalizzato: X minuti”
- hint durata ambigua per giorni/settimane

Type Classification Base ha poi introdotto:

- select1 allineato a ui_state.parsed.unit
- parsed.unit = minuti → Tempo
- euro + keyword controllate di uscita → Spesa
- euro + keyword controllate di entrata → Incasso
- euro senza direzione chiara → Evento
- scelta manuale utente preservata
- type salvato tramite confirm flow

Match Engine Unification First Controlled Level ha poi introdotto:

- project_state / entity_state come fonte minima matching
- select_project / select_entity alimentati da singleMatch
- hint ambiguità alimentati da isAmbiguous
- hint match più specifici alimentati da hasMoreSpecificMatches
- highlight alimentato da matches
- confirm guard basata su ambiguità non risolta
- match state live in create flow
- match state live in edit flow
- bug €500 label preview risolto

Project / Entity Create Suggestion First Controlled Level ha poi introdotto:

- create_suggestion_state
- suggestion create per project/entity
- container suggestion inline
- ignore globale suggestion
- micro-editor project/entity
- entity autofill controlled minimal
- distinzione tra hint informativo e suggestion create
- salvataggio evento separato dalla creazione project/entity

Project Create Suggestion — Match Present / User Override ha poi introdotto:

- requiresUserOverride in create_suggestion_state
- warning mirato in Da verificare per match presente + suggestion extension
- separazione semantica tra warning decisionale e azione di creazione
- rimozione della duplicazione informativa nel container Suggerimenti associazione
- conferma che il caso G22 non blocca Conferma
- conferma che G22 non modifica payload, save flow o DB

Implementato:

✔ 1500.5 → 1.500,50 €  
✔ 1500 → 1.500,00 €  
✔ 1.5 ore → 1,5 ore  
✔ 1 ora → 1 ora  
✔ 18 minuti → 18 minuti  
✔ 6/4/26 → 6 apr separato dalla descrizione  
✔ label cleaning coerente con amount/unit già rappresentati  
✔ unità tecniche escluse dall'highlight locale  
✔ 1 ora → 60 minuti  
✔ 1,5 ore → 90 minuti  
✔ 1 ora e 15 minuti → 75 minuti  
✔ 2h30 → 150 minuti  
✔ 2 ore 30 → 150 minuti  
✔ preview durata in forma umana  
✔ hint valore normalizzato  
✔ hint durata ambigua  
✔ select1 allineato a unit = minuti  
✔ 2h30 rendering → Tempo  
✔ Spesa / Incasso base tramite keyword controllate  
✔ euro senza direzione chiara → Evento  
✔ type rappresentato in preview tramite select1.value 
✔ villa 2 mario → project Villa 2 + entity Mario  
✔ ristrutturazione bagno → Ristrutturazione Bagno  
✔ mario → Mario + hint entità più specifiche  
✔ villa → Villa + hint progetti più specifici  
✔ alfie mario rossi → ambiguità reale entity  
✔ €500 → 500,00 € senza duplicazione in label  
✔ highlight project/entity alimentato da matches  
✔ hint matching alimentati da project_state/entity_state  
✔ suggestion create alimentate da create_suggestion_state
✔ container suggestion inline validato
✔ ignore globale suggestion validato
✔ entity autofill controlled minimal validato
✔ preview non diventa fonte di salvataggio 
✔ requiresUserOverride usato per warning G22 non bloccante
✔ Da verificare mostra “Associazione progetto/entità da controllare”
✔ Suggerimenti associazione mostra solo l’azione disponibile
✔ duplicazione tra warning e suggestion rimossa
✔ G22 non richiede G10A per questo caso

Esempi validati:

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
→ Normalizzato: 60 minuti

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

4 aprile benzina 50 euro alfie allevamento aspri
→ 4 apr • 50,00 € • benzina alfie allevamento aspri

villa 2 mario
→ villa 2 mario

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

Type Classification Base — esempi validati:

2h30 rendering
→ preview: 2 ore 30 minuti • rendering
→ select1: Tempo
→ DB dopo confirm: type Tempo, amount 150, unit minuti

20 euro spesa materiale
→ preview: 20,00 € • spesa materiale
→ select1: Spesa
→ DB dopo confirm: type Spesa, amount 20, unit euro

20 euro incasso cliente
→ preview: 20,00 € • incasso cliente
→ select1: Incasso
→ DB dopo confirm: type Incasso, amount 20, unit euro

20 euro materiale
→ preview: 20,00 € • materiale
→ select1: Evento
→ DB dopo confirm: type Evento, amount 20, unit euro

villa 2 mario
→ preview: villa 2 mario
→ select1: Evento
→ DB dopo confirm: type Evento, amount null, unit null

Nessuna alterazione diretta del dato salvato da parte della preview.

La preview resta visuale.

Il type viene salvato dal confirm flow leggendo select1.value.

Match Engine Unification — esempi validati:

villa 2 mario
→ preview evidenzia Villa 2 e Mario
→ Conferma abilitata

4 aprile benzina 50 euro alfie allevamento aspri
→ project ASPRI
→ entity ambigua
→ hint Più entità trovate
→ Conferma disabilitata finché non viene scelta entità

18 min ristrutturazione bagno
→ project Ristrutturazione Bagno
→ type Tempo
→ Conferma abilitata

mario
→ entity Mario
→ hint Esistono entità più specifiche
→ Conferma abilitata

villa
→ project Villa
→ hint Esistono progetti più specifici
→ Conferma abilitata

€500 acconto alfie mario rossi
→ 500,00 € • acconto alfie mario rossi

Project / Entity Create Suggestion — esempi validati:

villa sierri 15 sopralluogo referente kappa
→ suggestion project Villa Sierri 15
→ suggestion entity Referente Kappa
→ project/entity creati inline previa conferma
→ evento salvato manualmente con project_id/entity_id corretti

acquisto 50 euro materiale nuovo
→ suggestion project/entity visibile
→ Ignora
→ Conferma abilitata
→ evento salvato con project_id null / entity_id null

alfie mario rossi
→ entity ambigua
→ Crea entità non visibile
→ Conferma disabilitata finché non viene scelta entity

RELAZIONE CON INSERT / UPDATE

Nota canonica:

La fonte completa per il lifecycle evento, edit, no-op, cancel,
WRITTEN / ERROR e processing è:

- 03_LOGOS_Event_Lifecycle

La fonte completa per lo schema DB e i campi persistiti è:

- 05_LOGOS_Database_Schema

La fonte completa per il wiring Retool di button_input_confirm,
insert_event e update_event è:

- 04_LOGOS_Retool_Architecture

Regola:

la Preview non salva direttamente.
Il salvataggio avviene solo tramite button_input_confirm e le fonti salvabili finali.

Dati salvati:

raw_input
type
amount
unit
event_date
project_id
entity_id

Fonti dati salvate:

✔ ui_state.parsed per amount/unit/event_date  
✔ select1.value per type  
✔ select_project.value per project_id  
✔ select_entity.value per entity_id  

button_input_confirm:

✔ non ricalcola più parsing
✔ non contiene più parsing legacy
✔ costruisce payload da ui_state.parsed e select1.value
✔ usa insert_event/update_event
✔ aggiorna events_new dopo save completato

Relazione:

✔ preview e DB leggono lo stesso parsed data di base
✔ dati persistiti sono coerenti con parser controllato
✔ durate certe persistite come amount in minuti e unit = minuti
✔ type persistito in events.type
✔ project_id/entity_id persistiti solo tramite select_project/select_entity  
✔ preview non è fonte di salvataggio project/entity  
✔ match state influenza select/hint/confirm, non scrive direttamente DB  
✔ create_suggestion_state non è fonte di salvataggio evento
✔ insert_project / insert_entity non salvano eventi
✔ dopo creazione inline, l’evento richiede comunque Conferma manuale
✔ suggestion ignorata non blocca insert_event/update_event
✘ label NON persistita
✘ preview applica ancora trasformazioni visive aggiuntive

Esempio durata + type:

input:

2h30 rendering

ui_state.parsed:

amount: 150
unit: minuti

select1:

Tempo

DB:

type: Tempo
amount: 150
unit: minuti
raw_input: 2h30 rendering

preview:

2 ore 30 minuti
Normalizzato: 150 minuti

VINCOLI ATTUALI (REALI)

✔ preview non blocca input
✔ preview attiva quando input_analysis_result.readiness.canShowEventPreview è true
✔ preview può essere parzialmente errata
✔ preview non modifica DB
✔ preview non è fonte del salvataggio
✔ preview legge ui_state.parsed per amount/unit/event_date
✔ preview legge select1.value per type
✔ preview non salva direttamente type
✔ preview legge project_state/entity_state per matching  
✔ preview mostra hint ambiguità da isAmbiguous  
✔ preview mostra warning G22 da create_suggestion_state.requiresUserOverride
✔ hasMoreSpecificMatches resta segnale informativo, non warning principale nei casi G22
✔ preview evidenzia project/entity da matches  
✔ preview non decide project/entity  
✔ preview non decide create project/entity
✔ preview non esegue insert_project / insert_entity
✔ create_suggestion_state non salva eventi
✔ suggestion create richiede conferma utente
✔ Sintesi strutturata confermata dentro UX Mobile Coherence Pass
✔ card Da verificare separata dalla Sintesi
✔ notice associazioni mancanti confermato
✔ Dati evento resta zona decisionale separata
✔ feedback mobile resta esterno alla preview
✔ navigation dock resta esterna alla preview
✔ preview_analysis_state alimenta hint/status della Sintesi
✔ input_analysis_result governa la visibilità degli Hidden principali del flow input
✔ ui_visibility_state resta presente come residuo tecnico deprecabile


MA:

✘ contiene logica duplicata
✘ contiene cleaning
✘ contiene costruzione label
✘ contiene hint logic embedded
✘ contiene highlight logic embedded
✘ non è ancora view pura
✘ type display e hint sono ancora accoppiati alla preview/select
✘ Cambia / Scegli non sono ancora cliccabili
✘ feedback_summary non è fonte preview
✘ navigation dock non è fonte preview

⚠ dipende da aggiornamenti multipli
⚠ usa ancora fonti multiple
✔ allineata visualmente al Normalization Layer Base per amount/unit/date
✔ allineata visualmente alla Duration Normalization Base per ore/minuti
✔ mostra durata normalizzata senza modificare il dato salvato
✔ matching project/entity allineato a primo livello  
✔ hint matching project/entity state-driven  

⚠ non ancora separata come view pura
✔ container suggestion UI rifinito a livello mobile base
⚠ suggestion create vs edit consistency da verificare
✔ project creation override con match generico risolto a primo livello in G22
⚠ create_suggestion_state aggiunge una fonte UI ulteriore
✔ command intent implementato a primo livello controllato
✔ Full Visibility Migration degli Hidden principali completata
✔ button_input_confirm.Hidden migrato a input_analysis_result
⚠ button_input_confirm.Disabled non migrato
⚠ save readiness non centralizzata
✔ linting Retool azzerati
⚠ flash residui durante digitazione/cambio schermata ancora presenti
⚠ label “Importo” usata anche per valori durata

------------------------------------------------
RELAZIONE CON DATI EVENTO
------------------------------------------------

Dati evento è la zona decisionale finale.

Contiene:

- Tipo evento
- Progetto
- Entità

Durante UX Mobile Coherence Pass, Dati evento è stato compattato
con label inline / affiancate alle select.

Regola:

La Sintesi rappresenta.
Dati evento decide.
button_input_confirm salva.

La preview non sostituisce:

- select1
- select_project
- select_entity

Le micro-azioni “Cambia” / “Scegli” nella Sintesi indicano dove intervenire,
ma non modificano ancora i campi.

Dopo Input Analysis Result Controlled UI Consumption:

Dati evento viene mostrato/nascosto tramite:

input_analysis_result.readiness.canShowEventData

Regola:

- visibile nel flow evento
- visibile nel flow edit quando l’input è valorizzato
- nascosto nel flow command
- nascosto quando l’input edit viene svuotato
- nascosto quando il flow input non è pronto

Questo non modifica:

- select1.value
- select_project.value
- select_entity.value

Le select restano le fonti salvabili finali.

------------------------------------------------
RELAZIONE CON FEEDBACK MOBILE
------------------------------------------------

Il feedback mobile introdotto durante UX Mobile Coherence Pass
NON è parte della preview.

feedback_summary appartiene al post-save.

La preview opera prima della conferma evento.
Il feedback opera dopo insert_event / update_event.

Differenza:

Preview / Sintesi:

- rappresenta input interpretato
- usa ui_state.parsed
- usa select1 / select_project / select_entity
- guida l’utente prima del salvataggio

Feedback:

- conferma salvataggio avvenuto
- usa feedback_summary
- è temporaneo
- non modifica DB
- non modifica preview
- viene azzerato dopo auto-return

Regola:

Non usare feedback_summary come fonte preview.

Nota post UI Readiness:

Il micro-flash feedback project/entity osservato nei test finali
non appartiene alla preview.

È residuo del feedback/routing post-create,
non del rendering Sintesi.

Il feedback project/entity resta esterno alla preview.

------------------------------------------------
RELAZIONE CON NAVIGATION DOCK
------------------------------------------------

La Navigation dock introdotta durante UX Mobile Coherence Pass
NON è parte della preview.

Componente:

container_app_nav

Voci:

- Home
- Eventi
- Dashboard

La voce Dashboard è presente ma disabilitata.

Regola:

La navigation dock non modifica:

- input_raw
- ui_state.parsed
- project_state
- entity_state
- create_suggestion_state
- select1
- select_project
- select_entity
- button_input_confirm

La navigation dock è solo UI di navigazione contestuale.

Non abilita output.
Non abilita KPI.
Non modifica il comportamento della Sintesi.

Micro-fix post UI Readiness:

container_app_nav.Hidden usa input_home.value invece di input_raw.value.

Motivo:

input_raw può aggiornarsi con ritardo rispetto a input_home
e causare flash della bottom bar durante la digitazione.

Esito:

✔ bottom bar flash risolto

Nota:

questo fix non modifica la preview.

------------------------------------------------
RELAZIONE CON MOBILE SAFARI BASELINE
------------------------------------------------

Durante test reale su iPhone 13 Safari sono stati rilevati:

- zoom automatico su tap input
- troncamento laterale dell’interfaccia
- select non pienamente utilizzabili come dropdown

Fix applicato nel sistema UI:

- font-size 16px sui campi editabili/select principali

Campi coinvolti:

- input_home
- input_events_search
- select1
- select_project
- select_entity
- input_new_project_name
- input_new_entity_name

Impatto sulla preview:

- nessuna modifica alla logica preview
- nessuna modifica a label cleaning
- nessuna modifica a hint logic
- nessuna modifica a highlight
- nessuna modifica a save flow

Regola:

Il vincolo 16px riguarda campi editabili e select,
non il modello logico della preview.

Eventuali polish futuri non devono riattivare lo zoom automatico iOS.

LIMITI STRUTTURALI
DUPLICAZIONE LOGICA
label costruita qui
non esiste layer label dedicato runtime
CLEANING DISTRIBUITO
parsing controllato
preview
label cleaning
HINT NON CENTRALIZZATI
hint matching project/entity ora derivati da match state
hint durata normalizzata ancora locale alla preview
hint durata ambigua ancora locale alla preview
hint type/economico ancora locale alla preview/select1
NON È VIEW PURA
contiene trasformazioni dati
contiene label logic
contiene hint logic
DEBUG COMPLESSO
difficile isolare origine problemi visuali
MULTI-SOURCE STATE
parsed
raw_input
select_project/select_entity
select1.value
match state project/entity
project_state/entity_state
create_suggestion_state
dismissed state project/entity
liste project/entity
type select
Dati evento compatti
card Da verificare
notice associazioni mancanti
duration hint locale
ui_visibility_mode
ui_visibility_state residuo tecnico deprecabile

→ assenza di preview model unico
→ assenza di suggestion model separato come layer documentale autonomo
→ Cambia / Scegli ancora non azionabili
→ feedback mobile separato ma non parte del preview model
→ navigation dock separata ma non parte del preview model

COMMAND INTENT / PREVIEW:

✔ command intent separato dalla Sintesi evento
✔ comandi puri non renderizzati come eventi
✔ container_command_intent introdotto
✔ feedback command separato dal feedback evento tramite feedback_mode

⚠ input analysis model unico non implementato
⚠ command_intent_state è ancora helper Retool separato
⚠ create_suggestion_state è ancora helper Retool separato
⚠ preview continua a contenere hint/label/highlight embedded
⚠ “Da verificare” resta interno alla Sintesi
✔ rendering progressivo input evento normale ridotto tramite UI Readiness
⚠ micro-flash feedback project/entity ancora presente, esterno alla preview
⚠ “modifica” generico non ancora riconosciuto come guida edit
⚠ ui_visibility_state è residuo tecnico deprecabile, non input analysis model completo

COMMAND INTENT — TEST VALIDATI:

1. Comando generico

Input:

crea

Esito:

- container_command_intent mostrato
- esempi leggibili
- Sintesi evento nascosta
- Dati evento nascosti
- nessun evento salvato

RISULTATO:
OK

---

2. Create project incompleto

Input:

crea progetto

Esito:

- input_command_project_name visibile
- CTA disabilitata a campo vuoto
- Sintesi evento nascosta
- nessun evento salvato

RISULTATO:
OK

---

3. Create project completo

Input:

crea progetto Command Final Project 2

Esito:

- riepilogo command mostrato
- project creato tramite insert_project
- feedback Progetto creato
- ritorno Home automatico
- nessun evento salvato

RISULTATO:
OK

---

4. Create entity incompleto

Input:

crea entità

Esito:

- input_command_entity_name visibile
- CTA disabilitata a campo vuoto
- Sintesi evento nascosta
- nessun evento salvato

RISULTATO:
OK

---

5. Create entity completo

Input:

crea entità Command Final Entity 2

Esito:

- riepilogo command mostrato
- entity creata tramite insert_entity
- feedback Entità creata
- ritorno Home automatico
- nessun evento salvato

RISULTATO:
OK

---

6. Elemento già presente

Input:

crea progetto villa

Esito:

- Elemento già presente riconosciuto
- nessun bottone crea
- nessuna duplicazione
- Sintesi evento nascosta
- nessun evento salvato

RISULTATO:
OK

---

7. Guida modifica evento

Input:

modifica evento

Esito:

- guida mostrata
- step leggibili
- CTA Vai agli eventi funzionante
- nessuna modifica automatica
- nessun evento salvato

RISULTATO:
OK

---

8. Evento ordinario non regressivo

Input:

30 euro spesa villa citrignano

Esito:

- flow evento ordinario preservato
- Sintesi evento mostrata
- Dati evento mostrati
- Conferma evento funzionante
- feedback evento corretto
- ritorno Home automatico

RISULTATO:
OK

---

9. Edit evento non regressivo

Esito:

- update_event eseguito se modifica reale
- no-op edit preservato se nessuna modifica
- ritorno Lista eventi coerente
- Sintesi evento ancora funzionante in edit flow

RISULTATO:
OK

FORMATO AMOUNT ALLINEATO IN PREVIEW

dato interno numerico corretto
visualizzazione localizzata in preview

Esempio:

dato interno:
1500.5

preview:
1.500,50 €

Nota:

questa localizzazione resta visuale
e non modifica il valore persistito.

------------------------------------------------
FORMATO DURATA ALLINEATO IN PREVIEW
------------------------------------------------

Dato interno:

amount = totale minuti
unit = minuti

Visualizzazione:

forma umana calcolata in preview

Esempio:

dato interno:
150 minuti

preview:
2 ore 30 minuti

hint:
Normalizzato: 150 minuti

raw_input:
2h30 rendering

Nota:

la visualizzazione umana non modifica il dato interno.
Il dato persistito resta amount = 150, unit = minuti.

PROPRIETÀ DEL SISTEMA

✔ deterministico localmente
✔ funzionante lato utente
✔ coerente con DB nei dati principali
✔ usa ui_state.parsed come fonte strutturata
✔ usa select1.value come fonte runtime type
✔ type persistito dal confirm flow
✔ non modifica DB
✔ usa project_state/entity_state come fonte matching project/entity  
✔ preview hint matching allineati a isAmbiguous  
✔ preview highlight alimentato da matches  
✔ confirm guard coerente con ambiguità non risolta
✔ suggestion create opzionale e non bloccante
✔ project/entity mancanti non bloccano conferma
✔ project/entity ambigui bloccano conferma
✔ evento non salvato automaticamente dopo creazione project/entity
✔ Sintesi strutturata confermata su mobile
✔ card Da verificare separata
✔ notice associazioni mancanti confermato
✔ Dati evento compatti separati dalla Sintesi
✔ feedback mobile temporaneo separato dalla preview
✔ navigation dock separata dalla preview
✔ visibilità Sintesi governata da input_analysis_result.readiness.canShowEventPreview
✔ container_command_intent governato da input_analysis_result.readiness.canShowCommandContainer
✔ Dati evento governati da input_analysis_result.readiness.canShowEventData
✔ suggestion container governato da input_analysis_result.readiness.canShowAssociationSuggestions
✔ button_input_confirm.Hidden migrato a input_analysis_result.readiness.canShowConfirm
⚠ button_input_confirm.Disabled non ancora migrato a input_analysis_result
✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto

MA:

✔ allineato visualmente ai dati normalizzati principali

⚠ non allineato al modello ideale di view pura
⚠ accoppiamento alto
⚠ difficile evoluzione
⚠ ancora non completamente separato architetturalmente
⚠ non ancora pronto per output/KPI
⚠ type base non sufficiente da solo per report avanzati
✔ container suggestion rifinito a livello mobile base
⚠ Cambia / Scegli ancora non cliccabili
⚠ suggestion create vs edit consistency da verificare
⚠ project creation override con match generico non implementato
⚠ suggestion create non ancora separata in modello dedicato
⚠ ui_visibility_state resta residuo tecnico deprecabile
⚠ ui_visibility_state non è Input Analysis Model completo
✔ linting Retool azzerati

STATO ATTUALE

✔ preview funzionante
✔ UX utilizzabile
✔ preview alimentata da ui_state.parsed
✔ save flow non dipende dalla preview
✔ DB coerente con dati normalizzati
✔ amount/unit/date visualizzati coerentemente
✔ formattazione italiana amount implementata
✔ label cleaning aggiornato
✔ date separate correttamente dalla descrizione
✔ highlight unit-safe
✔ duration normalization visualizzata correttamente
✔ durata certa mostrata in forma umana
✔ hint normalizzato introdotto
✔ hint durata ambigua introdotto
✔ Type Classification Base completata
✔ select1 allineato a ui_state.parsed.unit
✔ type rappresentato tramite select1.value
✔ type persistito da insert/update tramite confirm flow
✔ Match Engine Unification First Controlled Level completato  
✔ preview legge project_state/entity_state per matching  
✔ hint ambiguità matching allineati a isAmbiguous  
✔ warning G22 “Associazione progetto/entità da controllare” introdotto
✔ hint match più specifici riclassificati come segnale informativo non principale nei casi G22
✔ highlight project/entity alimentato da matches  
✔ detection locale preview non più fonte decisionale matching  
✔ bug €500 label preview risolto  
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ create_suggestion_state collegato alla UX preview/suggestion
✔ container suggestion inline implementato
✔ hint/suggestion no-match project/entity implementati
✔ ignore globale suggestion implementato
✔ entity autofill controlled minimal implementato
✔ flow combinato project + entity validato
✔ preview resta non fonte di salvataggio evento
✔ UX Mobile Coherence Pass completato
✔ Sintesi strutturata confermata
✔ card Da verificare separata
✔ notice associazioni mancanti confermato
✔ Dati evento compatti separati dalla Sintesi
✔ feedback mobile separato dalla preview
✔ navigation dock separata dalla preview
✔ font-size 16px mobile Safari validato per input/select
✔ UI Readiness / Visibility Aggregator First Controlled Level completato
✔ ui_visibility_mode implementato
✔ ui_visibility_state implementato
✔ preview_analysis_state implementato
✔ hint/status/missing association della Sintesi letti da preview_analysis_state
✔ input_analysis_result implementato
✔ raw / selection / effective state introdotti
✔ Sintesi governata da input_analysis_result.readiness.canShowEventPreview
✔ container_command_intent governato da input_analysis_result.readiness.canShowCommandContainer
✔ suggestion container governato da input_analysis_result.readiness.canShowAssociationSuggestions
✔ Dati evento governati da input_analysis_result.readiness.canShowEventData
✔ button_input_confirm.Hidden migrato a input_analysis_result.readiness.canShowConfirm
⚠ button_input_confirm.Disabled non ancora migrato a input_analysis_result
⚠ ui_visibility_state resta presente come residuo tecnico deprecabile
✔ container vuoto durante digitazione risolto
✔ flash input flow ridotto
✔ bottom bar flash risolto
✔ edit mode chiarito da text_edit_mode_notice

⚠ preview ancora ibrida
✔ hint matching project/entity state-driven  
✔ matching project/entity unificato a primo livello controllato  
⚠ hint duration/type ancora embedded nella preview  
⚠ match engine avanzato separato non implementato  
⚠ architettura non separata
⚠ preview non ancora view pura
✔ container suggestion UI rifinita a livello mobile base
⚠ Cambia / Scegli ancora non cliccabili
⚠ suggestion create vs edit consistency da verificare
✔ project creation override con match generico risolto a primo livello in G22
✔ command intent implementato a primo livello controllato
⚠ micro-flash feedback project/entity ancora presente, esterno alla preview
⚠ “modifica” generico non ancora riconosciuto come guida edit
✔ Input Analysis Result introdotto come layer compositivo per Hidden principali del flow input
⚠ Input Analysis Model completo non implementato
✔ Full Visibility Migration degli Hidden principali completata
✔ button_input_confirm.Hidden migrato
⚠ button_input_confirm.Disabled non migrato
⚠ cleanup obsolete UI guards / query reduction non ancora eseguito
✔ label “Importo” su durata risolta
✔ riga valore semanticamente allineata a Importo / Durata / Valore
⚠ flash residui digitazione/cambio schermata ancora presenti
⚠ balloon blu “Manca progetto / Manca entità” da rivalutare in nodo Preview/UX futuro
⚠ badge OK / status Sintesi da riallineare semanticamente

STATO DOCUMENTALE / REGOLE DI AGGIORNAMENTO

06_LOGOS_View_Preview_System è documento tecnico canonico.

Questo documento non governa:

- nodo attivo
- roadmap
- priorità operative
- ordine dei prossimi nodi

Nodo attivo, priorità e sequenza sono governati da:

- 00_PROJECT_State
- 00_PROJECT_Roadmap
- 00_PROJECT_Gap_Register

Questo documento va aggiornato solo quando cambia una logica dell’area Preview / Sintesi oppure quando serve registrare un impatto documentale diretto su:

- Sintesi
- preview visuale
- labelStyled
- value builder
- formattazione amount/unit/date
- durata umana
- hint normalizzazione durata
- hint durata ambigua
- label cleaning
- highlight project/entity
- card “Da verificare”
- hint / warning / status visuali
- notice associazioni mancanti
- micro-copy preview
- micro-azioni visive “Cambia” / “Scegli”
- preview_analysis_state
- relazione tra preview e input_analysis_result
- relazione tra Sintesi, Dati evento, suggestion container e command container

Regola:

non usare questo documento come Roadmap.
Non inserire qui “nodo corrente”, “prossimo nodo” o pacchetti documentali in corso.

Le evoluzioni future collegate alla Preview devono restare in:

- 00_PROJECT_Roadmap per sequenza e priorità
- 00_PROJECT_Gap_Register per gap e debiti
- checkpoint operativo solo durante il nodo attivo

Stato tecnico attuale stabile:

- nessun refactor preview globale attivo immediato
- Preview Alignment Base completato
- Duration Normalization Base completata
- Type Classification Base completata
- Match Engine Unification First Controlled Level completato
- Project / Entity Create Suggestion First Controlled Level completato
- Project Create Suggestion — Match Present / User Override completato a primo livello controllato
- UX Mobile Coherence Pass completato
- Command Intent — Create Project / Entity completato
- UI Readiness / Visibility Aggregator — First Controlled Level completato
- Preview Analysis State — First Controlled Layer completato
- Input Analysis Result / Single Interpretation Layer Base — Read-only Diagnostic completato
- Input Analysis Result — Controlled UI Consumption Pass completato
- Input Analysis Result — Visibility Migration Completion completato
- Linting / Retool Query Safety Pass completato
- Documentation Architecture Audit / Redundancy Reduction completato

Residui tecnici della Preview da non perdere:

- la Sintesi resta un layer ibrido, non ancora view pura
- “Da verificare” resta interno alla Sintesi / card collegata
- hint / warning / status non sono ancora un modello autonomo completo
- balloon blu “Manca progetto / Manca entità” da rivalutare in nodo Preview/UX futuro
- badge OK / status Sintesi da riallineare semanticamente
- residui grafici/mobile polish da trattare in nodi UX dedicati o sessioni brevi
- button_input_confirm.Disabled non è migrato a input_analysis_result
- save readiness completa non è centralizzata
- ui_visibility_state resta residuo tecnico deprecabile / rollback
- cleanup obsolete UI guards / query reduction non ancora eseguito
- label “Importo” su durata risolta tramite micro-copy semantica della riga valore
- flash residui digitazione/cambio schermata ancora presenti

Possibili futuri tecnici collegati alla Preview:

- PREVIEW MODEL / HINT STATE CONSOLIDATION
- STATUS SEMANTICS ALIGNMENT
- PREVIEW / MISSING ASSOCIATION NOTICE CLEANUP
- MOBILE POLISH FINALE / ICON SYSTEM

Nota:

BUTTON CONFIRM READINESS ALIGNMENT è stato completato in G33.
G22 Project Create Suggestion — Match Present / User Override è stato completato a primo livello controllato.

Nota:

questi sono residui tecnici collegati al dominio Preview.
La decisione se e quando aprirli resta in 00_PROJECT_State / 00_PROJECT_Roadmap / 00_PROJECT_Gap_Register.

CHANGELOG

v01 — 2026-04-07

documento basato su runtime reale
descrizione completa preview system
evidenziate duplicazioni e limiti
allineamento con stato attuale sistema

v02 — 2026-04-23

identificazione loop reattivo
evidenziata dipendenza preview dal flusso reattivo
documentata incoerenza tra fonti dati
integrazione con stato reale sistema

v03 — 2026-04-30

aggiornamento fonte parsing da parse_input a parse_input_controlled
introduzione ui_state.parsed come fonte strutturata preview/save
integrazione Normalization Layer Base
documentata normalizzazione amount/unit
documentato che il save flow non dipende più dalla preview
aggiornati limiti preview dopo normalizzazione
apertura nodo consigliato PREVIEW ALIGNMENT BASE

v04 — 2026-04-30

completamento PREVIEW ALIGNMENT BASE
documentata formattazione italiana amount in preview
documentate funzioni formatAmountIT / formatUnitIT
documentato grouping migliaia visuale
documentato euro con due decimali
documentata gestione singolare/plurale unit
documentato label cleaning aggiornato
documentata correzione bug "minuti" → "uti"
documentato separatore data/descrizione
documentato filtro previewStopTokens
documentato highlight unit-safe
confermato che preview non modifica DB/save flow
confermato che preview resta layer ibrido non ancora view pura

v05 — 2026-04-30

completamento ENGINE BASE — DURATION NORMALIZATION
documentata visualizzazione durata normalizzata
documentate funzioni formatDurationHumanIT / formatDurationMinutesIT
documentato hint “Normalizzato: X minuti”
documentato hint durata ambigua
documentato cleaning durate composte
documentata rimozione forme compatte tipo 2h30 dalla label
documentata rimozione residui e/ed dopo cleaning durata
aggiornati previewStopTokens con giorni/settimane/giornata
confermato che preview non modifica DB/save flow
confermato che amount tempo resta salvato in minuti
confermato che raw_input preserva la forma originale
confermato che preview resta layer ibrido non ancora view pura
aggiornato prossimo nodo logico: TYPE CLASSIFICATION BASE

v06 — 2026-05-01

completamento ENGINE BASE — TYPE CLASSIFICATION BASE
documentata relazione preview / select1
chiarito che select1 è componente UI Retool, non query
documentato che select1.value alimenta type visuale
documentato che la preview non salva direttamente type
documentata catena select1.value → button_input_confirm payload.type → events.type
documentato parsed.unit = minuti → select1 Tempo
documentati esempi type: Tempo, Spesa, Incasso, Evento
documentato euro senza direzione chiara → Evento
documentato override manuale utente
documentato che type viene persistito da insert/update
confermato che preview resta layer ibrido non ancora view pura
confermato che preview non modifica DB/save flow
confermato che type base non abilita ancora KPI/output
aggiornato prossimo nodo logico: MATCH ENGINE UNIFICATION

v07 — 2026-05-02

completamento MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL
documentata relazione preview / project_state / entity_state
documentato che la preview legge matches da match state
documentato che hint ambiguità derivano da isAmbiguous
documentato che hint match più specifici derivano da hasMoreSpecificMatches
documentato che highlight project/entity deriva da matches
documentato che detection locale preview non è più fonte decisionale matching
documentato che preview non salva project/entity
documentato salvataggio project_id/entity_id tramite select_project/select_entity
documentato confirm guard da ambiguità non risolta
documentati esempi villa 2 mario, ristrutturazione bagno, mario, villa, alfie mario rossi
documentato fix bug €500 nella label preview
confermato che preview resta layer ibrido non ancora view pura
confermato che hint duration/type restano embedded nella preview
confermato che non esiste ancora preview model unico
confermato che nessun output/KPI è stato anticipato
aggiornato prossimo nodo: da definire in Roadmap

v08 — 2026-05-07

aggiornamento post PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
documentata relazione preview / create_suggestion_state
documentata distinzione preview / hint informativo / suggestion create
documentato container suggestion inline
documentato che create_suggestion_state non salva eventi
documentato che preview non esegue insert_project / insert_entity
documentato che suggestion create richiede conferma utente
documentato che evento non viene salvato automaticamente dopo creazione project/entity
documentato ignore globale suggestion
documentato entity autofill controlled minimal come non-preview e non-matching
documentato no-match generico ignorabile
documentato flow combinato project + entity
documentata ambiguità entity bloccante senza create suggestion
aggiornati limiti: container suggestion UI grezza, command intent non implementato
confermato che preview resta layer ibrido
confermato che nessun output/KPI è stato anticipato
aggiornato prossimo nodo candidato: UX Cleanup Suggestion Container / Mobile oppure Command Intent

v09 — 2026-05-09

aggiornamento post UX MOBILE COHERENCE PASS
documentata Sintesi strutturata mobile confermata
documentata card Da verificare separata dalla Sintesi
documentato notice associazioni mancanti
documentato Dati evento come zona decisionale separata
documentato che Cambia / Scegli restano indicatori visivi non cliccabili
documentato che feedback mobile non è preview
documentato che feedback_summary non è fonte preview
documentato che Navigation dock non è preview
documentata Dashboard in nav come voce disabilitata non collegata alla preview
documentato che container suggestion è rifinito a livello mobile base
documentato vincolo mobile Safari font-size 16px su input/select
documentato che il fix Safari non modifica la logica preview
aggiornati limiti futuri:
- Cambia / Scegli Actions
- Hint / Ambiguità Advanced
- Suggestion Create vs Edit Consistency
- Project Create Suggestion — Match Present / User Override
- Mobile Polish Finale / Icon System
confermato che preview resta layer ibrido
confermato che nessun output/KPI è stato anticipato
confermato DB invariato
confermato parser invariato
confermato matching invariato
confermato create_suggestion_state invariato
confermato save flow invariato lato preview

v10 — 2026-05-13

- integrazione Command Intent — Create Project / Entity
- documentato rapporto tra preview e command_intent_state
- documentato container_command_intent come layer separato dalla Sintesi
- documentato che i comandi puri non vengono renderizzati come eventi
- documentato che Sintesi evento e Dati evento vengono nascosti per command intent
- documentato comando generico “crea”
- documentato create project incompleto
- documentato create project completo
- documentato create entity incompleto
- documentato create entity completo
- documentato elemento già presente
- documentata guida non operativa “modifica evento”
- documentato che command intent non salva eventi
- documentato che insert_project / insert_entity restano azioni controllate
- documentato che create_suggestion_state e command_intent_state non devono competere
- documentato feedback command separato tramite feedback_mode
- aggiunti esempi preview non mostrata per comandi puri
- aggiunti test Command Intent validati
- documentati residui:
  - “Da verificare” ancora interno alla Sintesi
  - preview ancora ibrida
  - hint/warning non ancora separati
  - rendering progressivo input evento normale ancora migliorabile
  - input analysis model unico non implementato
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- save flow evento ordinario invariato
- nessun output/KPI anticipato

v11 — 2026-05-18

- integrazione UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
- integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- documentato ui_visibility_mode come latch UI empty / event / command
- documentato ui_visibility_state come aggregatore read-only di visibilità
- documentato che in quella fase ui_visibility_state governava ancora la visibilità della Sintesi tramite showEventPreview; stato successivamente superato da Visibility Migration Completion, che ha migrato la visibilità Sintesi a input_analysis_result.readiness.canShowEventPreview
- documentato che in quella fase container_command_intent era governato da showCommandContainer; stato successivamente superato dalla migrazione a input_analysis_result.readiness.canShowCommandContainer
- documentato che in quella fase Dati evento era governato da showEventData; stato successivamente superato dalla migrazione a input_analysis_result.readiness.canShowEventData
- documentato che in quella fase button_input_confirm era governato da showConfirm; stato successivamente superato dalla migrazione di button_input_confirm.Hidden a input_analysis_result.readiness.canShowConfirm
- documentata distinzione tra visibilità preview e contenuto preview
- documentato che ui_visibility_state non modifica labelStyled
- documentato che ui_visibility_state non modifica hint, highlight, parser, matching o DB
- documentato container vuoto durante digitazione risolto
- documentato flash input flow ridotto
- documentato bottom bar flash risolto tramite container_app_nav
- documentato che rendering progressivo input evento normale è stato ridotto a primo livello
- documentato che la Sintesi resta layer ibrido nel contenuto
- documentato che “Da verificare” resta interno alla Sintesi / card collegata
- documentato che hint/warning non sono ancora modello autonomo
- documentato che micro-flash feedback project/entity è esterno alla preview
- documentato residuo “modifica” generico non riconosciuto come guida edit
- documentato Input Analysis Model completo non implementato
- aggiornati nodi futuri candidati post UI Readiness
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- command_intent_state invariato
- save flow evento ordinario invariato
- nessun output/KPI anticipato

v12 — 2026-05-20

- integrazione PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
- documentato preview_analysis_state come Transformer read-only
- documentato che preview_analysis_state raccoglie hint / warning / status / Da verificare / associazioni mancanti della Sintesi
- documentato che la Sintesi legge hint/status/missing association da preview_analysis_state
- documentato che preview_analysis_state non modifica parser, matching, save flow o DB
- documentato che la Sintesi resta responsabile del rendering HTML finale
- documentato residuo status OK + card Da verificare

- integrazione INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
- documentato input_analysis_result come layer compositivo read-only
- documentata distinzione raw / selection / effective
- documentato che input_analysis_result legge preview_analysis_state
- documentato che input_analysis_result non sostituisce parser, matching, select, suggestion, command o save flow
- documentato edit mode prevalente su command intent a livello effective

- integrazione INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS
- documentato che input_analysis_result è ora fonte UI controllata parziale
- documentato che sintesi.Hidden legge input_analysis_result.readiness.canShowEventPreview
- documentato che Dati evento e select leggono input_analysis_result.readiness.canShowEventData
- documentato che container_command_intent legge input_analysis_result.readiness.canShowCommandContainer
- documentato che container_association_suggestions legge input_analysis_result.readiness.canShowAssociationSuggestions
- documentato che button_input_confirm resta fuori dalla migrazione corrente
- documentato che in quella fase ui_visibility_state restava ancora operativo; stato successivamente superato da Visibility Migration Completion, che lo ha riclassificato come residuo tecnico deprecabile / rollback
- documentato edit mode + input vuoto stabilizzato
- documentato Home idle container nascosti durante edit mode
- documentato Dati evento / Sintesi / Conferma nascosti con edit input vuoto
- documentata micro-copy dinamica della notice associazioni mancanti
- documentata distinzione missing association notice ≠ suggestion operativa
- documentato che il container suggestion non deve apparire vuoto
- documentato che create_suggestion_state resta fonte del contenuto operativo dei suggerimenti
- documentati residui Full Visibility Migration / Button Confirm Readiness / Status Semantics
- documentato aumento linting Retool a 19 come debito tecnico esterno alla preview
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- command_intent_state invariato
- save flow evento ordinario invariato
- nessun output/KPI anticipato

v13 — 2026-05-23

- integrazione INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
- documentato input_analysis_result come fonte UI controllata per gli Hidden principali del flow input
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
- documentato ui_visibility_mode come latch empty / event / command
- documentato routing principale app su ui_state.view
- documentata differenza tra preview visibility e contenuto preview
- documentato residuo label “Importo” su durata
- documentato residuo flash digitazione/cambio schermata

- integrazione LINTING / RETOOL QUERY SAFETY PASS
- documentato linting Retool azzerato
- documentata eliminazione query legacy typing_state
- documentata eliminazione query legacy handle_event_success
- documentata Performance unused query risolta
- confermato DB invariato
- confermato parser invariato
- confermato matching invariato
- confermato create_suggestion_state invariato
- confermato command_intent_state invariato nella logica funzionale
- confermato save flow evento ordinario invariato
- confermato payload invariato
- aggiornati limiti attuali
- aggiornati nodi futuri candidati
- prossimo nodo candidato prioritario: DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION

v14 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicato Pacchetto C — Documenti tecnici canonici su 06_LOGOS_View_Preview_System
- documento aggiornato da v13 a v14
- confermato 06_LOGOS_View_Preview_System come fonte canonica per Preview / Sintesi, labelStyled, value builder visuale, formattazione amount/unit/date, durata umana, hint normalizzazione, hint durata ambigua, label cleaning, highlight, hint/warning/status, card Da verificare, notice associazioni mancanti, micro-copy e limiti della preview come layer ibrido
- aggiunta sezione RESPONSABILITÀ CANONICA DEL DOCUMENTO
- chiarito che State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo della Preview/Sintesi
- chiarito che il dettaglio completo resta in questo documento e nei documenti canonici collegati
- aggiunti richiami canonici a:
  - 01_LOGOS_Input_System per input flow, parser, normalization, duration normalization, type classification base nel contesto input, Command Intent, create_suggestion_state e input_analysis_result
  - 02_LOGOS_Match_Engine per Match Engine project/entity
  - 03_LOGOS_Event_Lifecycle per lifecycle evento
  - 04_LOGOS_Retool_Architecture per componenti/query/Hidden/Sintesi/input_analysis_result/preview_analysis_state wiring
  - 05_LOGOS_Database_Schema per schema DB
  - LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
  - LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase as-is
- aggiunte note canoniche nelle sezioni:
  - POSIZIONE NEL SISTEMA
  - RELAZIONE CON PARSING
  - COMPORTAMENTO MATCHING IN PREVIEW
  - RELAZIONE CON CREATE SUGGESTION
  - RELAZIONE CON INSERT / UPDATE
- riallineati riferimenti storici nel changelog v11 su ui_visibility_state/showEventPreview/showCommandContainer/showEventData/showConfirm
- riallineato riferimento storico nel changelog v12 su ui_visibility_state operativo/non deprecato
- aggiornata sezione OBIETTIVO FUTURO IMMEDIATO con stato Pacchetto C
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

v15 — 2026-05-26

- completamento PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT
- risolto residuo semantico visuale della label “Importo” su valori durata
- documentata label semantica della riga valore nella Sintesi
- introdotta distinzione visuale:
  - euro → Importo
  - ore / minuti → Durata
  - fallback non riconosciuto → Valore
- documentata icona dinamica della riga valore:
  - € per dati economici
  - ⏱️ per dati temporali
  - 🔢 per fallback valore
- aggiornata documentazione della riga valore nella card Sintesi
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
- test runtime superati:
  - 20 euro materiale → Importo
  - 2h30 rendering lavoro → Durata
  - 1 ora lavoro → Durata
  - villa 2 mario → nessuna falsa durata/importo con amount null
  - Command Intent non regressivo
  - edit flow non regressivo

  v16 — 2026-06-04

- completamento PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE / AUTO-SELECT CONFIDENCE
- documento aggiornato da v15 a v16
- G22 completato a primo livello controllato
- documentato requiresUserOverride come segnale preview per match presente + suggestion extension
- documentata lettura di create_suggestion_state.project/entity da parte di preview_analysis_state
- introdotti warning mirati in card Da verificare:
  - Associazione progetto da controllare
  - Associazione entità da controllare
- documentata micro-copy:
  - [baseName] selezionato · testo letto: [candidateName]
  - [baseName] selezionata · testo letto: [candidateName]
- chiarito che Da verificare segnala il rischio decisionale
- chiarito che Suggerimenti associazione propone l’azione disponibile
- rimossa duplicazione della selezione corrente dal container Suggerimenti associazione
- chiarito che hasMoreSpecificMatches non è più warning principale nei casi G22
- documentato comportamento project:
  - 20 euro villa
  - 20 euro villa sierri
  - 20 euro villa sierri 6
- documentato comportamento entity:
  - 20 euro tecnico mario
  - 20 euro mario rossi
  - 20 euro mario giordano
- confermato che il warning G22 è non bloccante
- confermato che suggestion ignorata non blocca salvataggio
- confermato che button_input_confirm.Disabled resta invariato
- confermato payload invariato
- confermato save flow invariato
- confermato DB invariato
- confermato Supabase invariato
- confermato che G22 non richiede G10A
- registrati residui fuori nodo:
  - balloon blu “Manca progetto / Manca entità” da rivalutare in nodo Preview/UX futuro
  - badge OK / status Sintesi da riallineare semanticamente
  - residui grafici/mobile polish da trattare in nodi UX dedicati o sessioni brevi