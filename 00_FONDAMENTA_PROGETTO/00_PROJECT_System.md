# 00_PROJECT_System_v08

DATA: 2026-05-25

------------------------------------------------
IDENTITÀ SISTEMA
------------------------------------------------

Nome: LOGOS

Tipo:
Event Operating System

Definizione:

Sistema per la registrazione, gestione e trasformazione di eventi
in dati strutturati utilizzabili per analisi operative.

Modello:

Event Ledger user-driven  
Append-only controllato

------------------------------------------------
RESPONSABILITÀ DOCUMENTALE
------------------------------------------------

00_PROJECT_System descrive l’architettura alta del sistema LOGOS.

Questo documento è fonte di riferimento per:

- identità sistema
- modello architetturale alto
- stack tecnologico
- principi architetturali
- layer funzionali principali
- direzione evolutiva generale
- limiti strutturali al livello sistema

Questo documento NON governa:

- nodo attivo
- roadmap operativa
- priorità immediate
- ordine dei prossimi nodi
- gap aperti
- checkpoint attivi
- dettagli runtime Retool completi
- dettagli runtime Supabase completi
- implementazioni tecniche puntuali

Fonti competenti:

- 00_PROJECT_State per stato corrente e prossimo nodo consigliato
- 00_PROJECT_Roadmap per sequenza operativa e priorità
- 00_PROJECT_Gap_Register per gap, debiti e futuri
- 00_PROJECT_KERNEL_MANIFEST per architettura documentale, fonti canoniche e Session Boot Matrix
- documenti tecnici canonici per logiche complete
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
- LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase reale as-is

Regola:

00_PROJECT_System non deve diventare Roadmap,
State, Gap Register o runtime manifest.

Deve restare documento di architettura alta.

------------------------------------------------
OBIETTIVO SISTEMA
------------------------------------------------

Trasformare input libero in:

- dati strutturati
- dati confrontabili
- dati progressivamente normalizzati
- dati analizzabili

Output atteso futuro:

- KPI
- analisi costi
- analisi tempi
- dashboard operative
- reportistica

Stato output:

❌ non ancora implementato

Motivo:

i dati non sono ancora sufficientemente completi per output affidabili.

------------------------------------------------
STACK TECNOLOGICO
------------------------------------------------

Frontend:

- Retool
- UI single page
- gestione stato lato client
- logica runtime JavaScript

Backend:

- Supabase
- database PostgreSQL
- REST API

Logica:

- JavaScript lato client
- parsing lato Retool
- normalization base lato Retool
- duration normalization lato Retool
- type classification base lato Retool
- matching lato Retool
- Match Engine Unification First Controlled Level lato Retool
- match state project/entity lato Retool
- preview lato Retool
- Project / Entity Create Suggestion lato Retool
- UX Mobile Coherence Pass lato Retool
- Command Intent — Create Project / Entity lato Retool
- UI Readiness / Visibility Aggregator lato Retool
- ui_visibility_mode lato Retool
- input_analysis_result lato Retool come layer compositivo read-only per gli Hidden principali del flow input
- ui_visibility_state lato Retool come residuo tecnico deprecabile / rollback, non più fonte primaria degli Hidden principali migrati
- feedback temporaneo lato Retool
- navigation dock lato Retool

Nota canonica:

Per il comportamento completo di input_analysis_result, raw / selection / effective, readiness e Hidden principali del flow input,
la fonte canonica è:

- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture per wiring/componenti Retool
- LOGOS_RETOOL_RUNTIME_REAL per stato runtime reale as-is

Server / Database:

- passivo
- nessuna business logic applicativa
- nessun parsing
- nessuna normalizzazione
- nessuna classificazione autonoma
- nessuna decisione type lato DB
- nessuna decisione project/entity lato DB
- nessuna risoluzione ambiguità lato DB
- nessuna creazione automatica project/entity lato DB
- nessuna gestione command intent lato DB
- nessuna gestione ui_visibility_mode lato DB
- nessuna gestione ui_visibility_state lato DB
- nessuna gestione feedback temporaneo lato DB
- nessuna gestione navigation dock lato DB

------------------------------------------------
PRINCIPI ARCHITETTURALI
------------------------------------------------

1. DATABASE PASSIVO

Il database:

- non contiene logica applicativa
- non valida semanticamente i dati
- non interpreta eventi
- non esegue parsing
- non esegue normalizzazione
- non decide project/entity
- non decide type
- riceve type già determinato lato UI
- riceve project_id/entity_id già determinati lato UI
- non riceve match state
- non salva matches / count / isAmbiguous / singleMatch
- non conosce command_intent_state
- non conosce create_suggestion_state
- non conosce ui_visibility_mode
- non conosce ui_visibility_state
- non conosce feedback_mode
- non governa visibilità UI
- non interpreta comandi puri
- non crea eventi da command intent

---

2. UI RESPONSABILE

La UI:

- gestisce input
- interpreta dati
- normalizza dati base
- normalizza durate certe ore/minuti
- classifica type a livello base
- calcola match state project/entity
- alimenta select_project/select_entity tramite singleMatch
- gestisce ambiguità project/entity non risolte
- costruisce preview
- guida decisione utente
- invia payload al database
- propone creazione project/entity controllata
- distingue input evento da command intent
- esclude comandi puri dal salvataggio evento
- crea project/entity da command solo previa conferma utente
- coordina feedback temporaneo post-save / post-create
- coordina navigation dock
- distingue empty / event / command tramite ui_visibility_mode
- governa gli Hidden principali del flow input tramite input_analysis_result
- mantiene ui_visibility_state come residuo tecnico deprecabile / rollback, non come fonte primaria degli Hidden principali migrati

Nota:

ui_visibility_mode resta un latch UI leggero.
input_analysis_result compone lo stato operativo del flow input e governa gli Hidden principali migrati.
ui_visibility_state non è più letto da input_analysis_result e non deve tornare fonte primaria della visibility del flow input.

---

3. RAW INPUT COME VERITÀ ORIGINARIA

raw_input:

- è sempre salvato
- preserva il testo utente
- non viene alterato
- consente ricostruzione/correzione futura

---

4. DATI STRUTTURATI COME DERIVATI

amount, unit, event_date, type, project_id, entity_id:

- amount / unit / event_date derivano da parsing e normalization
- type deriva da select1.value
- project_id deriva da select_project.value
- entity_id deriva da select_entity.value
- project_id/entity_id sono supportati da project_state/entity_state
- project_id/entity_id possono essere supportati da create_suggestion_state prima della conferma evento
- type/project/entity restano decisioni UI/utente prima del salvataggio
- possono essere incompleti
- possono essere corretti mentre l’evento è NEW
- non sostituiscono raw_input

Nota:

command_intent_state, ui_visibility_mode e ui_visibility_state non sono dati strutturati evento.
Sono helper runtime/UI e non vengono salvati negli eventi.

---

5. APPEND-ONLY CONTROLLATO

Eventi:

- append-only dopo validazione
- modificabili in fase NEW
- evolvono tramite stato dopo validazione
- non hanno ancora versioning storico

Nota:

l’editing su eventi NEW è una violazione controllata
del modello append-only, accettata per migliorare qualità dati
prima della validazione.

---

6. SEPARAZIONE PROGRESSIVA DEI LAYER

Il sistema tende a separare:

- input
- parsing
- normalization
- duration normalization
- type classification
- preview
- matching
- insert/update
- processing
- output

Stato attuale:

✔ input/parsing/save più separati  
✔ normalization base introdotta  
✔ duration normalization base introdotta  
✔ type classification base introdotta  
✔ Match Engine Unification First Controlled Level introdotto  
✔ matching project/entity unificato a primo livello controllato  
✔ select / hint / highlight / confirm guard allineati a match state  
✔ Project / Entity Create Suggestion First Controlled Level introdotto
✔ UX Mobile Coherence Pass completato
✔ Command Intent — Create Project / Entity introdotto
✔ UI Readiness / Visibility Aggregator introdotto a primo livello
✔ ui_visibility_mode introdotto come latch UI empty / event / command
✔ input_analysis_result introdotto come layer compositivo read-only per raw / selection / effective / readiness
✔ Hidden principali del flow input migrati progressivamente a input_analysis_result
✔ ui_visibility_state riclassificato come residuo tecnico deprecabile / rollback
✔ input_analysis_result non legge più ui_visibility_state
✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto
⚠ preview ancora ibrida nel contenuto
⚠ input analysis model unico non implementato
⚠ match engine avanzato separato non implementato  
⚠ output non attivo      

------------------------------------------------
ARCHITETTURA FUNZIONALE
------------------------------------------------

LIVELLI ATTUALI:

1. INPUT LAYER
2. PARSING LAYER
3. NORMALIZATION BASE LAYER
4. DURATION NORMALIZATION BASE LAYER
5. TYPE CLASSIFICATION BASE LAYER
6. MATCH STATE LAYER — FIRST CONTROLLED LEVEL
7. PROJECT / ENTITY CREATE SUGGESTION LAYER
8. COMMAND INTENT LAYER — FIRST CONTROLLED LEVEL
9. UI READINESS / INPUT ANALYSIS RESULT LAYER — FIRST CONTROLLED LEVEL
10. PREVIEW / VIEW LAYER
11. UI STATE LAYER
12. INSERT / UPDATE LAYER
13. PROCESSING LAYER
14. UX MOBILE / NAVIGATION / FEEDBACK LAYER
15. DOCUMENTATION ARCHITECTURE / CANONICAL SOURCES LAYER

LIVELLI FUTURI:

16. PREVIEW MODEL / HINT STATE CONSOLIDATION
17. INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER
18. MATCH ENGINE EVOLUTION ADVANCED
19. DATA STRUCTURE / ENTITY HIERARCHY
20. ECONOMIC DIRECTION ADVANCED
21. OUTPUT / ANALYTICS LAYER

Nota post Visibility Migration Completion:

Il layer UI Readiness non coincide più solo con ui_visibility_state.

Lo stato attuale distingue:

- ui_visibility_mode: latch UI leggero empty / event / command
- input_analysis_result: Transformer compositivo read-only che governa gli Hidden principali del flow input
- ui_visibility_state: residuo tecnico deprecabile / rollback

Fonte canonica per il comportamento completo:

- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

Nota post Documentation Architecture Audit:

La documentazione LOGOS è stata normalizzata secondo il principio di fonti canoniche.

Stato consolidato:

- documenti core alleggeriti
- documenti tecnici canonici preservati come fonti madri
- runtime manifest distinti dai documenti tecnici
- Kernel Manifest aggiornato con Principio Fonti Canoniche
- Session Boot Matrix consolidata
- regola aggiornamenti futuri consolidata

Questa modifica è documentale.
Non modifica runtime LOGOS, Retool, Supabase, DB, parser, matching, preview, payload o save flow.

Fonte canonica documentale:

- 00_PROJECT_KERNEL_MANIFEST
- CHECKPOINT — DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION

------------------------------------------------
1 — INPUT LAYER
------------------------------------------------

Componenti:

- input_home
- input_raw

Caratteristiche:

- input libero
- nessun vincolo formale
- non bloccante
- source UX = input_home
- adapter tecnico = input_raw

Flow:

input_home
→ input_raw

Principio:

input_home = source of truth lato UX  
raw_input = source of truth lato persistenza

------------------------------------------------
2 — PARSING LAYER
------------------------------------------------

Componente principale:

- parse_input_controlled

Trigger:

- trigger_parse_debounced

Funzione:

Interpretazione base input.

Operazioni:

- estrazione amount
- riconoscimento unit
- parsing event_date
- esclusione orari HH:MM
- gestione multi-numero per prossimità
- supporto unità compatte
- supporto durate composte ore/minuti
- normalizzazione durata base in minuti

Caratteristiche:

- best-effort
- deterministico
- non bloccante
- lato client
- non semantico

Output:

```js
{
  amount,
  unit,
  event_date
}

Consumo:

ui_state.parsed
preview
insert_event
update_event

Nota:

project/entity non sono contenuti in ui_state.parsed.

Il matching project/entity è gestito da:

input_raw
→ project_state / entity_state
→ select_project / select_entity

------------------------------------------------
3 — NORMALIZATION BASE LAYER
------------------------------------------------

Stato:

✔ implementato come primo blocco ENGINE BASE

Collocazione attuale:

incorporato in parse_input_controlled

Funzione:

rendere coerenti i dati minimi già parsati.

Ambito:

amount
unit
event_date preservato

Regole principali:

amount salvato come numero
unit salvata come testo normalizzato
raw_input preservato
numeri senza unità non diventano amount
formato italiano numerico convertito a numero

Esempi:

1.500,50 euro → amount 1500.5, unit euro
20 euro materiale → amount 20, unit euro
villa 2 mario → amount null, unit null

Non implementato:

giorni/settimane come conversione automatica
giornata lavorativa
mezza giornata
parole numeriche tipo “due ore”
forme colloquiali tipo “un paio d’ore”

------------------------------------------------
4 — DURATION NORMALIZATION BASE LAYER
------------------------------------------------

Stato:

✔ implementato

Collocazione attuale:

incorporato in parse_input_controlled

Funzione:

rendere confrontabili le durate certe espresse in ore/minuti.

Decisione:

amount tempo = totale minuti
unit tempo = "minuti"
raw_input preservato
nessuna modifica schema DB
nessun payload duration
nessun campo duration_minutes dedicato

Esempi:

1 ora → amount 60, unit minuti
1,5 ore → amount 90, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
2h30 → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti
18min → amount 18, unit minuti
90 minuti → amount 90, unit minuti

Ambiguità non convertite:

2 giorni rendering → amount null, unit null
1 settimana lavoro → amount null, unit null
mezza giornata → amount null, unit null

Motivo:

giorni/settimane/giornate possono indicare calendario,
giornata lavorativa, evento, cantiere o turno operativo.

------------------------------------------------
5 — TYPE CLASSIFICATION BASE LAYER
------------------------------------------------

Stato:

✔ implementato

Componente principale:

select1

Funzione:

classificare l’evento a livello base,
in modo prudente e correggibile dall’utente.

Valori attuali:

- Evento
- Tempo
- Spesa
- Incasso

Regole principali:

parsed.unit = "minuti"
→ Tempo

euro + keyword controllate di uscita
→ Spesa

euro + keyword controllate di entrata
→ Incasso

euro senza direzione chiara
→ Evento

segnali economici contrastanti
→ Evento

nessuna unit significativa
→ Evento

Esempi:

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

Principio:

La classificazione automatica è base e prudente.
L’utente può sempre modificare select1 manualmente.

Persistenza:

select1.value
→ payload.type
→ insert_event / update_event
→ events.type

Limiti:

nessuna classificazione economica avanzata
nessun amount firmato
nessun direction field
nessuna retro-normalizzazione storico
type non ancora sufficiente per KPI avanzati

6 — MATCH STATE LAYER — FIRST CONTROLLED LEVEL

Funzione:

Associazione input a project/entity esistenti.

Entità coinvolte:

projects
entities

Componenti / fonti:

projects_list
entities_list
project_state
entity_state
select_project
select_entity

Fonte minima matching:

project_state
entity_state

Output standard:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

Strategia attuale:

- matching testuale
- normalizzazione testo base
- full name match
- priority match minimo
- rimozione match generici coperti da match specifici
- auto-select solo tramite singleMatch
- nessuna inferenza definitiva
- nessuna creazione automatica project/entity

Regole:

match univoco
→ singleMatch
→ select_project/select_entity valorizzata
→ conferma consentita

match ambiguo non risolto
→ isAmbiguous = true
→ select vuota
→ hint rosso
→ conferma bloccata

match ambiguo risolto manualmente
→ select valorizzata dall’utente
→ conferma consentita

nessun match
→ select vuota
→ project_id/entity_id null
→ conferma consentita

Esempi:

villa 2 mario
→ project Villa 2
→ entity Mario

18 min ristrutturazione bagno
→ project Ristrutturazione Bagno

mario
→ entity Mario
→ hint entità più specifiche

villa
→ project Villa
→ hint progetti più specifici

alfie mario rossi
→ ambiguità reale entity

Limiti:

match engine avanzato separato non implementato
nessun fuzzy matching
nessun alias system
nessuna gerarchia entity/project
nessuna deduplicazione
nessuna creazione guidata project/entity
nessun ranking avanzato

------------------------------------------------
7 — PROJECT / ENTITY CREATE SUGGESTION LAYER
------------------------------------------------

Stato:

✔ implementato a primo livello controllato

Componenti:

- create_suggestion_state
- container_association_suggestions
- input_new_project_name
- input_new_entity_name
- insert_project
- insert_entity
- project_create_inline_open
- entity_create_inline_open
- project_create_suggestion_dismissed
- entity_create_suggestion_dismissed

Funzione:

proporre creazione project/entity quando l’input evento ordinario
non trova associazioni controllate.

Regole:

- suggestion create opera dentro il flow evento ordinario
- non salva eventi automaticamente
- insert_project scrive solo in projects
- insert_entity scrive solo in entities
- dopo creazione, l’evento richiede comunque Conferma evento
- project/entity mancanti non bloccano il salvataggio evento
- project/entity ambigui bloccano conferma finché non risolti

Limiti:

- suggestion create vs edit consistency da verificare
- project creation override con match generico non implementato
- entity/project hierarchy non implementata

------------------------------------------------
8 — COMMAND INTENT LAYER — FIRST CONTROLLED LEVEL
------------------------------------------------

Stato:

✔ implementato a primo livello controllato

Componenti:

- command_intent_state
- container_command_intent
- input_command_project_name
- input_command_entity_name
- btn_command_create_project
- btn_command_create_entity
- btn_command_go_events

Funzione:

distinguere comandi strutturali puri da eventi ordinari.

Casi gestiti:

- crea
- crea progetto
- crea progetto [nome]
- crea entità
- crea entità [nome]
- crea progetto [nome esistente]
- modifica evento

Regole:

- i comandi puri non generano eventi NEW
- button_input_confirm resta dedicato agli eventi ordinari
- insert_project / insert_entity restano azioni controllate
- “modifica evento” guida alla lista eventi, non apre edit flow automatico
- Command Intent non modifica stati evento
- Command Intent non sostituisce parser/matching/suggestion

Limiti:

- alias guida edit generici non implementati:
  - modifica
  - correggi
  - cambia
- command intent avanzato non implementato
- non è intent engine globale

------------------------------------------------
9 — UI READINESS / INPUT ANALYSIS RESULT LAYER — FIRST CONTROLLED LEVEL
------------------------------------------------

Stato:

✔ implementato a primo livello controllato

Componenti / helper principali:

- ui_visibility_mode
- input_analysis_result
- ui_visibility_state
- text_input_analysis_loading
- text_edit_mode_notice

Funzione:

governare la visibilità del flow input senza modificare dati salvabili.

ui_visibility_mode:

- Variable Retool
- valori:
  - empty
  - event
  - command
- aggiornata da trigger_parse_debounced
- latch UI leggero
- non è fonte dati
- non sostituisce command_intent_state

input_analysis_result:

- Transformer Retool compositivo read-only
- compone raw / selection / effective state
- espone readiness del flow input
- governa gli Hidden principali del flow input migrati
- non salva dati
- non costruisce payload
- non sostituisce parser, matching, suggestion, command, select o save flow

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

Regole:

- input_analysis_result non salva dati
- input_analysis_result non modifica DB
- input_analysis_result non modifica parser
- input_analysis_result non modifica matching
- input_analysis_result non modifica command_intent_state
- input_analysis_result non modifica create_suggestion_state
- input_analysis_result non costruisce payload
- input_analysis_result non sostituisce select_project / select_entity
- input_analysis_result non è Input Analysis Model completo
- ui_visibility_state resta residuo tecnico deprecabile / rollback
- non reintrodurre dipendenze circolari tra input_analysis_result e ui_visibility_state

Risultati:

✔ container vuoto durante digitazione risolto
✔ flash input flow ridotto
✔ bottom bar flash risolto
✔ flow event / command più stabile
✔ edit mode chiarito con notice dedicata

Limiti:

⚠ micro-flash feedback project/entity ancora presente
⚠ 5 linting Retool residui
⚠ cleanup obsolete UI guards / query reduction non ancora eseguito

10 — PREVIEW / VIEW LAYER

Funzione:

Mostrare all’utente l’interpretazione del sistema.

Mostra:

amount
unit
event_date
type / select1
label runtime
project/entity
hint
tipo evento base
match state project/entity
hint ambiguità matching
hint match più specifici
highlight project/entity

Caratteristiche:

✔ utile lato UX
✔ non salva dati
✔ non modifica DB
✔ supporta correzione manuale

Limiti:

⚠ non è view pura
⚠ contiene label cleaning
⚠ contiene hint logic
⚠ contiene highlight
⚠ usa fonti multiple
✔ visibilità principale del flow input governata da input_analysis_result
    Nota:

    ui_visibility_state resta residuo tecnico deprecabile / rollback.
    Non è più fonte primaria degli Hidden principali migrati.
✔ nascosta durante command intent puro
✔ container_command_intent separato
✔ rendering progressivo input ridotto tramite UI Readiness
✔ hint matching project/entity alimentati da project_state/entity_state
✔ highlight project/entity alimentato da matches
✔ detection locale preview non più fonte decisionale matching
✔ formattazione italiana amount allineata
✔ durata normalizzata mostrata in forma umana
⚠ contenuto interno preview ancora ibrido
⚠ “Da verificare” ancora interno alla Sintesi / card collegata
⚠ Preview Model / Hint State Consolidation non implementato

Esempi attuali:

amount: 1500.5
unit: euro
→ preview: 1.500,50 €

amount: 150
unit: minuti
raw_input: 2h30 rendering
→ preview: 2 ore 30 minuti
→ hint: Normalizzato: 150 minuti

Nota:

la preview usa anche select1.value per mostrare il tipo,
ma non salva direttamente il type.
La persistenza avviene tramite button_input_confirm.

Nota matching:

la preview legge project_state/entity_state per hint e highlight,
ma non salva project/entity.

La persistenza avviene tramite:

select_project.value → project_id
select_entity.value → entity_id

11 — UI STATE LAYER

State principale:

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
  feedback_text: null,
  feedback_project: null,
  feedback_mode: null,
  feedback_summary: null
}

Ruolo:

gestione view
stato feedback
fonte dati parsati
base save/edit
supporto create/update

Principio:

UI = funzione dello stato

Fonte unica dati strutturati parsing/normalization:

ui_state.parsed

Fonte type:

select1.value

Fonte matching:

project_state / entity_state

Fonte project/entity salvabile:

select_project.value
select_entity.value

Fonte visibility/readiness:

ui_visibility_mode
input_analysis_result

Residuo tecnico:

ui_visibility_state

Nota:

ui_visibility_mode, input_analysis_result e ui_visibility_state non sono dati evento.

- ui_visibility_mode distingue il flow visivo empty / event / command
- input_analysis_result governa gli Hidden principali del flow input migrati
- ui_visibility_state resta residuo tecnico deprecabile / rollback

Nessuno di questi helper viene salvato nel DB.

Usato da:

preview
button_input_confirm
insert_event
update_event

Nota:

ui_state.parsed alimenta amount/unit/event_date.
select1.value alimenta type.

project_state/entity_state alimentano il matching project/entity.
select_project/select_entity alimentano project_id/entity_id.

Regola:

ui_state.parsed deve restare sempre oggetto strutturato,
non null.

12 — INSERT / UPDATE LAYER

Componenti:

button_input_confirm
insert_event
update_event

Principio:

button_input_confirm NON esegue parsing.

Il payload viene costruito da:

const parsed = ui_state.value?.parsed || {
  amount: null,
  unit: null,
  event_date: null
};

Payload:

{
  raw_input: input_raw.value,
  type: select1.value || "Evento",
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
}

Fonti controllate payload:

- raw_input → input_raw.value
- amount / unit / event_date → ui_state.parsed
- type → select1.value
- project_id → select_project.value
- entity_id → select_entity.value

button_input_confirm non ricalcola parsing.
button_input_confirm non ricalcola matching.
button_input_confirm non legge la preview come fonte dati.
button_input_confirm non legge ui_visibility_state come fonte payload.

La visibilità del bottone Conferma è stata migrata a:

input_analysis_result.readiness.canShowConfirm

button_input_confirm.Disabled resta guard funzionale separata.
Il payload resta invariato.

Insert:

crea evento NEW
non viene eseguito se l’input è un comando puro
salva raw_input
salva type
salva amount/unit/event_date
salva project/entity se selezionati
blocca conferma solo se ambiguità project/entity non risolta

Update:

modifica evento NEW
mantiene status NEW
aggiorna type
aggiorna amount/unit/event_date
aggiorna project_id/entity_id se modificati
aggiorna type
aggiorna updated_at
aggiorna lista dopo save completato

Ordine corretto:

savePromise
→ await savePromise
→ await events_new.trigger()

Risultato:

✔ insert stabile
✔ update stabile
✔ lista aggiornata senza refresh pagina
✔ parsing duplicato nel save rimosso
✔ comandi puri esclusi dal save flow
✔ project/entity da command creati senza creare eventi
✔ feedback temporaneo post-save / post-create separato dal DB

13 — PROCESSING LAYER

Funzione:

Gestione eventi inseriti.

Componenti:

events_new
update_written
update_error
edit su eventi NEW

Stati:

NEW
WRITTEN
ERROR

Transizioni:

NEW → NEW (edit)
NEW → WRITTEN
NEW → ERROR

Caratteristiche:

decisione manuale
nessuna automazione
editing solo su eventi NEW
updated_at usato per ordinamento/modifica

Limiti:

lifecycle limitato
no versioning storico
no stati intermedi
no revisione batch

------------------------------------------------
14 — UX MOBILE / NAVIGATION / FEEDBACK LAYER
------------------------------------------------

Stato:

✔ implementato a primo livello controllato

Componenti:

- feedback_summary
- feedback_mode
- container_feedback
- container_app_nav
- input_events_search
- text_input_analysis_loading
- text_edit_mode_notice

Funzione:

migliorare usabilità mobile e chiarezza del flow.

Elementi consolidati:

- feedback temporaneo post insert/update
- feedback project_created / entity_created
- routing post-save contestuale
- Home / Events / Feedback separati
- navigation dock contestuale
- events list mobile rifinita
- search/filter lista eventi
- font-size 16px su input/select per Safari iOS
- edit mode notice
- bottom bar flash risolto

Regole:

- feedback non è dato DB
- navigation dock non è stato evento
- feedback_mode non è stato evento
- text_edit_mode_notice non modifica eventi
- container_app_nav non abilita output/KPI

FLOW COMPLETO SISTEMA

CREATE FLOW:

utente scrive in input_home

↓

SYNC:

input_home → input_raw

↓

DEBOUNCE / UI READINESS:

trigger_parse_debounced
→ ui_visibility_mode

UI READINESS / INPUT ANALYSIS RESULT:

ui_visibility_mode
→ input_analysis_result

↓

COMMAND INTENT CHECK:

command_intent_state

↓

SE COMMAND:

ui_visibility_state
→ container_command_intent
→ eventuale insert_project / insert_entity / go events
→ feedback temporaneo oppure Lista eventi
→ nessun evento creato

↓

SE EVENTO:

parse_input_controlled

↓

NORMALIZATION BASE:

amount/unit/event_date

↓

DURATION NORMALIZATION:

durate certe ore/minuti → minuti

↓

TYPE CLASSIFICATION:

select1.value

↓

MATCH STATE:

project_state / entity_state

↓

CREATE SUGGESTION:

create_suggestion_state
→ eventuale insert_project / insert_entity inline
→ evento ancora non salvato

↓

SELECT:

select_project / select_entity

↓

STATE:

ui_state.parsed

↓

UI VISIBILITY:

input_analysis_result

Nota:

ui_visibility_state resta residuo tecnico deprecabile / rollback,
non fonte primaria degli Hidden principali migrati.

↓

PREVIEW:

sintesi

↓

DATI EVENTO:

select1 / select_project / select_entity

↓

CONFERMA:

button_input_confirm

↓

INSERT:

insert_event

↓

DATABASE:

evento salvato con status NEW, type valorizzato,
project_id/entity_id valorizzati se selezionati

↓

FEEDBACK:

feedback temporaneo

↓

REFRESH:

events_new

↓

PROCESSING:

utente decide:

✔ WRITTEN
✖ ERROR

EDIT FLOW:

evento NEW selezionato

↓

LOAD:

raw_input → input_home / input_raw

EDIT NOTICE:

text_edit_mode_notice visibile

↓

PARSING:

parse_input_controlled

↓

MATCH STATE:

project_state / entity_state

↓

STATE:

ui_state.parsed

↓

SELECT:

select_project / select_entity

↓

TYPE CLASSIFICATION:

select1.value

↓

PREVIEW:

sintesi

↓

CONFERMA:

button_input_confirm

↓

UPDATE:

update_event

Nota:

Durante edit mode, Command Intent non prende controllo del flow.
Scrivere “crea” resta testo dell’evento in modifica.
Per uscire bisogna usare Annulla modifica.

↓

DATABASE:

evento aggiornato, status NEW, type/project_id/entity_id aggiornati se modificati

↓

REFRESH:

events_new

↓

PROCESSING:

WRITTEN / ERROR

MODELLO DATI

Tabella principale:

events

Campi principali:

id
created_at
updated_at
event_date
project_id
entity_id
type
amount
unit
reference_id
source
payment_method
notes
raw_input
payload
status

Tabelle correlate:

projects
entities

Tabelle non operative:

system_logs

STATO ARCHITETTURALE

✔ sistema coerente end-to-end
✔ flusso create funzionante
✔ flusso edit/update funzionante
✔ input stabilizzato
✔ parsing controllato attivo
✔ normalization base attiva
✔ duration normalization base attiva
✔ type classification base attiva
✔ Match Engine Unification First Controlled Level attivo
✔ project_state/entity_state fonte minima matching
✔ select_project/select_entity alimentati da singleMatch
✔ priority match minimo implementato
✔ hint ambiguità matching allineati a isAmbiguous
✔ confirm guard basata su ambiguità non risolta
✔ match state live in create flow
✔ match state live in edit flow
✔ save flow allineato a ui_state.parsed e select1.value
✔ DB coerente con payload
✔ events.type valorizzato in insert/update
✔ lista aggiornata dopo save/update
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ create_suggestion_state introdotto
✔ creazione project/entity inline controllata
✔ evento non salvato automaticamente dopo creazione project/entity
✔ UX Mobile Coherence Pass completato
✔ feedback temporaneo post-save introdotto
✔ routing post-save contestuale introdotto
✔ navigation dock introdotta
✔ font-size 16px mobile Safari validato per input/select
✔ Command Intent — Create Project / Entity completato
✔ command_intent_state introdotto
✔ container_command_intent introdotto
✔ comandi puri esclusi dal save flow evento
✔ project/entity da command creati senza creare eventi
✔ “modifica evento” gestito come guida non operativa
✔ UI Readiness / Visibility Aggregator First Controlled Level completato
✔ Input Analysis Result / Single Interpretation Layer Base introdotto come layer compositivo read-only
✔ Input Analysis Result — Controlled UI Consumption Pass completato
✔ Input Analysis Result — Visibility Migration Completion completato
✔ ui_visibility_mode introdotto
✔ input_analysis_result consolidato come fonte UI controllata per gli Hidden principali del flow input
✔ ui_visibility_state riclassificato come residuo tecnico deprecabile / rollback
✔ input_analysis_result non legge più ui_visibility_state
✔ Hidden principali del flow input migrati a input_analysis_result
✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto
✔ edit mode chiarito con text_edit_mode_notice
✔ Documentation Architecture Audit / Redundancy Reduction completato
✔ fonti canoniche consolidate
✔ Kernel Manifest aggiornato
✔ Session Boot Matrix consolidata
✔ regola aggiornamenti futuri consolidata

⚠ sistema incompleto nei layer evolutivi:

preview model / hint state consolidation
input analysis model unico
match engine avanzato separato
alias / fuzzy / ranking avanzato
data structure avanzata
economic direction advanced
output

Layer esistenti ma parziali:

engine base
preview
matching avanzato
lifecycle

Layer non attivi:

analytics
dashboard
KPI

LIMITI STRUTTURALI

preview non ancora view pura nel contenuto
“Da verificare” ancora interno alla Sintesi / card collegata
hint/warning non ancora separati in modello autonomo
input_analysis_result non è Input Analysis Model completo
input analysis model unico non implementato
ui_visibility_state resta residuo tecnico deprecabile / rollback
matching project/entity unificato solo a primo livello controllato
match engine avanzato separato non implementato
hint duration/type ancora embedded nella preview
type classification base implementata ma non avanzata
spesa/incasso implementati solo a livello base
amount firmato non implementato
direction field non implementato
giorni/settimane non convertiti automaticamente
multi-unit avanzato non supportato
dati storici non retro-normalizzati
lifecycle senza versioning
output non attivo
micro-flash feedback project/entity ancora presente
linting Retool azzerati dopo Linting / Retool Query Safety Pass
cleanup obsolete UI guards / query reduction non ancora eseguito
alias guida edit generici non implementati
creazione guidata project/entity implementata a primo livello controllato
suggestion create vs edit consistency da verificare
project creation override con match generico non implementato
alias / gerarchie / deduplicazione non implementati

DIREZIONE EVOLUTIVA

Ordine corretto sviluppo aggiornato:

input reliability ✔
event editing ✔
input system stabilization ✔
normalization layer base ✔
preview alignment base ✔
duration normalization ✔
type classification base ✔
match engine unification first controlled level ✔
micro-nodi UX/helper ✔
linting / state helper cleanup ✔
project/entity create suggestion ✔
UX mobile coherence pass ✔
command intent create project/entity ✔
UI readiness / visibility aggregator ✔
preview analysis state / input analysis result first controlled layers ✔
input_analysis_result visibility migration completion ✔
linting / Retool query safety pass ✔
documentation architecture audit / redundancy reduction ✔
preview / hint consolidation
input analysis model completo / single interpretation layer avanzato
data structure avanzata
economic direction advanced
output / dashboard

Candidati micro-nodo:

- COMMAND INTENT — EDIT GUIDE GENERIC ALIAS
- FEEDBACK MICRO-FLASH CLEANUP
- LINTING / MINOR CLEANUP
- CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION

Candidati non immediati:

- PREVIEW MODEL / HINT STATE CONSOLIDATION
- INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER
- DATA STRUCTURE / ENTITY HIERARCHY
- ECONOMIC DIRECTION ADVANCED
- ALIAS / SYNONYMS CONTROLLED MATCHING
- MATCH CONFIDENCE / RANKING ADVANCED
- DASHBOARD BASE

Nota:

l’ordine può essere raffinato dalla Roadmap,
ma non deve essere anticipato senza checkpoint.

DOCUMENTI TECNICI COLLEGATI

Core / governance:

- 00_PROJECT_State
- 00_PROJECT_Roadmap
- 00_PROJECT_Gap_Register
- 00_PROJECT_KERNEL_MANIFEST

Tecnici canonici:

- 01_LOGOS_Input_System
- 02_LOGOS_Match_Engine
- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture
- 05_LOGOS_Database_Schema
- 06_LOGOS_View_Preview_System

Runtime manifest:

- LOGOS_RETOOL_RUNTIME_REAL
- LOGOS_SUPABASE_RUNTIME_REAL

Checkpoint attivo post-audit:

- CHECKPOINT — DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION

Checkpoint precedenti archiviabili:

- CHECKPOINT - INPUT ANALYSIS RESULT - VISIBILITY MIGRATION COMPLETION
- CHECKPOINT — LINTING RETOOL QUERY SAFETY PASS
- CHECKPOINT — DOCUMENTATION ARCHITECTURE MAP

Regola:

i checkpoint sono riferimenti storico-operativi.
Le regole permanenti devono restare nei documenti attivi,
in particolare:

- 00_PROJECT_KERNEL_MANIFEST per fonti canoniche e Session Boot Matrix
- 00_PROJECT_State per stato corrente
- 00_PROJECT_Roadmap per sequenza operativa
- 00_PROJECT_Gap_Register per gap e debiti

CHANGELOG

v01 — 2026-04-01

Definizione architettura reale sistema LOGOS
Allineamento completo con Retool e Supabase
Consolidamento layer funzionali
Eliminazione incoerenze tra documenti precedenti

v02 — 2026-04-23

aggiornamento modello append-only (editing su NEW)
introduzione update flow
allineamento parsing deterministico
aggiornamento UI state
introduzione problemi reattivi e accoppiamento layer

v03 — 2026-04-30

aggiornamento architettura dopo Input System Stabilization
introduzione parse_input_controlled
introduzione trigger_parse_debounced
aggiornamento ui_state.parsed come fonte unica dati strutturati
integrazione Engine Base / Normalization Layer Base
documentata normalizzazione amount/unit
documentata rimozione parsing duplicato da button_input_confirm
aggiornato insert/update flow
documentato refresh events_new dopo save completato
aggiornati limiti strutturali e direzione evolutiva

v04 — 2026-05-01

aggiornamento architettura dopo Type Classification Base
integrazione Duration Normalization Base
integrazione Type Classification Base
documentata unità canonica tempo = minuti
documentata catena select1.value → payload.type → events.type
documentato type persistito in insert_event/update_event
documentati valori type: Evento, Tempo, Spesa, Incasso
documentato che DB resta passivo e non decide type
documentato che type è deciso lato UI
documentato override manuale utente
documentato che amount resta positivo
documentato che output/KPI non sono attivi
documentato matching non unificato come prossimo nodo architetturale
aggiornati limiti strutturali e direzione evolutiva

v05 — 2026-05-02

aggiornamento architettura dopo Match Engine Unification First Controlled Level
documentato project_state/entity_state come fonte minima matching
documentato singleMatch / isAmbiguous / moreSpecificMatches
documentato select_project/select_entity alimentati da match state
documentato confirm guard su ambiguità non risolta
documentato match state live in create/edit flow
documentato priority match minimo
documentato hint match più specifici
documentato che preview legge matches/isAmbiguous ma non salva project/entity
documentato che DB resta passivo e non riceve match state
documentato che project_id/entity_id derivano da select_project/select_entity
documentato bug €500 preview risolto nei documenti tecnici collegati
aggiornati flow create/edit
aggiornati limiti strutturali
aggiornata direzione evolutiva
confermato output/KPI non attivi

v06 — 2026-05-18

- aggiornamento sistemico post Project / Entity Create Suggestion First Controlled Level
- aggiornamento sistemico post UX Mobile Coherence Pass
- aggiornamento sistemico post Command Intent — Create Project / Entity
- aggiornamento sistemico post UI Readiness / Visibility Aggregator — First Controlled Level
- documentato create_suggestion_state come layer project/entity create suggestion
- documentato Command Intent Layer come primo livello controllato
- documentato container_command_intent
- documentato che i comandi puri non generano eventi
- documentato che project/entity da command non generano eventi
- documentato “modifica evento” come guida non operativa
- documentato UI Readiness / Visibility Layer
- documentato ui_visibility_mode
- documentato ui_visibility_state
- documentato che ui_visibility_state non è Input Analysis Model completo
- documentata centralizzazione Hidden principali
- documentato container vuoto durante digitazione risolto
- documentato bottom bar flash risolto
- documentato text_edit_mode_notice
- documentato edit mode prevalente su Command Intent
- documentato feedback temporaneo post-save / post-create
- documentata navigation dock
- documentato font-size 16px mobile Safari per input/select
- aggiornati livelli architetturali attuali da 10 a 14
- aggiornati livelli futuri
- aggiornato flow completo create/edit
- aggiornati limiti strutturali
- aggiornata direzione evolutiva
- confermato DB passivo
- confermato output/KPI non attivi
- confermato Input Analysis Model completo non implementato
- confermato Event Interpretation Engine non implementato

v07 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicata normalizzazione controllata Pacchetto A — Allineamento alto / Lifecycle / Supabase
- allineato il documento allo stato post INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
- allineato il documento allo stato post LINTING / RETOOL QUERY SAFETY PASS
- aggiornato riferimento al layer UI Readiness / Visibility
- introdotto input_analysis_result come layer compositivo read-only per raw / selection / effective / readiness
- documentato input_analysis_result come fonte UI controllata per gli Hidden principali del flow input
- riclassificato ui_visibility_state come residuo tecnico deprecabile / rollback
- chiarito che ui_visibility_state non è più letto da input_analysis_result
- chiarito che ui_visibility_state non governa più gli Hidden principali migrati
- chiarito che ui_visibility_state non va eliminato fuori da nodo cleanup dedicato
- aggiornato il livello architetturale 9 in UI READINESS / INPUT ANALYSIS RESULT LAYER — FIRST CONTROLLED LEVEL
- aggiunti richiami canonici a:
  - 01_LOGOS_Input_System per comportamento input_analysis_result / raw / selection / effective / readiness
  - 04_LOGOS_Retool_Architecture per wiring, componenti Retool e Hidden
  - LOGOS_RETOOL_RUNTIME_REAL per stato runtime reale as-is
- aggiornato UI STATE LAYER distinguendo:
  - ui_visibility_mode come latch UI empty / event / command
  - input_analysis_result come fonte visibility/readiness per Hidden principali migrati
  - ui_visibility_state come residuo tecnico deprecabile
- aggiornato FLOW COMPLETO SISTEMA sostituendo ui_visibility_state con input_analysis_result come fonte primaria della visibility del flow input
- aggiornato STATO ARCHITETTURALE con:
  - Input Analysis Result / Single Interpretation Layer Base
  - Input Analysis Result — Controlled UI Consumption Pass
  - Input Analysis Result — Visibility Migration Completion
  - Linting / Retool Query Safety Pass
- aggiornati LIMITI STRUTTURALI:
  - input_analysis_result non è Input Analysis Model completo
  - ui_visibility_state resta residuo tecnico deprecabile / rollback
  - linting Retool azzerati dopo Linting / Retool Query Safety Pass
- aggiornata DIREZIONE EVOLUTIVA con preview_analysis_state / input_analysis_result first controlled layers completati
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica save flow
- nessuna modifica preview
- nessuna anticipazione output / KPI / dashboard
- mantenuto 00_PROJECT_System come documento di architettura alta, non come documento tecnico operativo

v08 — 2026-05-25

- aggiornamento finale post DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- System aggiornato da v07 a v08
- aggiunta sezione RESPONSABILITÀ DOCUMENTALE
- chiarito che 00_PROJECT_System descrive architettura alta e non governa nodo attivo, roadmap, priorità o gap
- aggiunto Documentation Architecture / Canonical Sources Layer
- registrato completamento Documentation Architecture Audit / Redundancy Reduction
- registrato consolidamento fonti canoniche
- registrato aggiornamento Kernel Manifest
- registrata Session Boot Matrix consolidata
- registrata regola aggiornamenti futuri consolidata
- corretto riferimento storico a ui_visibility_state nella Preview
- chiarito che la visibility principale del flow input è governata da input_analysis_result
- chiarito che ui_visibility_state resta residuo tecnico deprecabile / rollback
- corretto riferimento a button_input_confirm.showConfirm
- chiarito che button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm
- confermato che button_input_confirm.Disabled resta guard funzionale separata
- aggiornata sezione DOCUMENTI TECNICI COLLEGATI
- sostituiti checkpoint precedenti con checkpoint attivo post-audit
- chiarito che i checkpoint sono riferimenti storico-operativi e non unica fonte delle regole permanenti
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