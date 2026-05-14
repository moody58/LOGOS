# 04_LOGOS_Retool_Architecture_v15

DATA: 2026-05-13

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- struttura UI completa  
- flow input → parsing → normalization → duration normalization → type classification → match state → preview → insert/update documentato  
- query e componenti allineati al runtime reale  
- ui_state.parsed documentato come fonte amount/unit/event_date  
- select1.value documentato come fonte type  
- project_state / entity_state documentati come fonte minima matching  
- select_project / select_entity documentati come derivati da singleMatch  
- confirm guard aggiornata su ambiguità non risolta  
- create flow e edit flow aggiornati con match state live  
- refresh lista dopo save documentato  
- preview alignment documentato  
- duration normalization documentata  
- type classification base documentata  
- Match Engine Unification First Controlled Level documentato   
- UX / Cleanup Micro-Batch Post Match Engine documentato
- btn_cancel_edit documentato
- input_events_search documentato
- no-op edit guard documentato
- label creato/modificato lista eventi documentata
- fix UI state nuovo input da lista documentato
- Linting / State Helper Cleanup documentato
- edit_mode / editing_event ripuliti da additionalScope { value }
- helper state tecnici documentati
- create/edit/annulla/no-op edit rivalidati dopo cleanup helper
- Project / Entity Create Suggestion First Controlled Level documentato
- create_suggestion_state documentato
- insert_project / insert_entity documentati
- variabili inline project/entity documentate
- container suggestion inline documentato
- micro-editor project/entity documentati
- ignore globale documentato
- entity autofill controlled minimal documentato
- flow combinato project + entity validato
- UX Mobile Coherence Pass documentato
- container_app_nav / navigation dock documentata
- feedback_summary documentato in ui_state
- feedback mobile stabilizzato
- routing post-save contestuale documentato
- insert → feedback → Home documentato
- update → feedback → Lista eventi documentato
- no-op edit → Lista eventi senza feedback documentato
- cancel create/edit contestuale documentato
- handle_event_success disabilitato come gestore UI documentato
- success handler UI duplicati rimossi da insert_event/update_event
- Dati evento compatti con label inline documentati
- Icon add-ons Retool documentati sui pulsanti reali
- font-size 16px input/select mobile Safari documentato
- Command Intent — Create Project / Entity documentato
- command_intent_state documentato come query page-level Retool
- container_command_intent documentato
- input_command_project_name / input_command_entity_name documentati
- btn_command_create_project / btn_command_create_entity documentati
- btn_command_go_events documentato
- feedback_mode documentato in ui_state
- feedback project_created / entity_created documentato
- guida modifica evento da command documentata
- blocco duplicati project/entity esistenti da command documentato
- evento ordinario non regressivo dopo Command Intent documentato

Q (Qualità): 9.5/10  
- architettura reale documentata  
- distinzione chiara tra parsing, normalization base, duration normalization, type classification, match state, preview, matching e save  
- preview visualmente allineata ai dati normalizzati  
- matching project/entity più coerente  
- select / hint / highlight / confirm guard allineati a project_state/entity_state  
- durate certe ore/minuti normalizzate in minuti  
- type persistito in events.type  
- controllo manuale utente preservato  
- debiti residui esplicitati  
- rumore tecnico Retool su edit_mode / editing_event eliminato
- helper edit mode più ricostruibili e meno ambigui
- non introduce modello ideale non implementato
- creazione project/entity guidata senza automatismi silenziosi
- select_project / select_entity confermati come decisione utente finale
- raw_input preservato anche dopo creazione inline
- evento non salvato automaticamente dopo creazione project/entity
- Core Event System rafforzato senza anticipare moduli verticali  
- UX mobile ora coerente tra Home, Input, Events list e Feedback
- feedback non bloccante e contestuale
- navigation dock predisposta senza anticipare Dashboard/KPI
- comportamento create/edit più coerente con contesto utente
- validazione reale iPhone 13 Safari integrata
- Command Intent introdotto senza creare logiche DB parallele
- command_intent_state separato da parser, matching e create_suggestion_state
- comandi puri esclusi dal save flow evento
- creazione project/entity da command solo previa conferma utente
- insert_project / insert_entity riusati come azioni operative controllate
- “modifica evento” gestito come guida non operativa, senza edit flow parallelo
- UX Command Intent rifinita in ottica mobile

D (Deployabilità): 10/10  
- utilizzabile come riferimento tecnico reale  
- coerente con implementazione Retool attuale  
- utile per ricostruzione runtime  
- nodo Preview Alignment Base validato runtime  
- nodo Duration Normalization validato runtime  
- nodo Type Classification Base validato runtime  
- nodo Match Engine Unification First Controlled Level validato runtime  
- nodo UX / Cleanup Micro-Batch Post Match Engine validato runtime
- create/edit/lista/annulla/ricerca/WRITTEN/ERROR validati
- nodo Linting / State Helper Cleanup validato runtime
- linting edit_mode / editing_event risolti
- create/edit/annulla/no-op edit/edit reale rivalidati dopo cleanup helper
- nodo Project / Entity Create Suggestion validato runtime
- insert_project validato su DB reale
- insert_entity validato su DB reale
- evento salvato con project_id/entity_id creati inline validato
- no-match generico salvabile validato
- edit/no-op non regressivo validato dopo create suggestion
- UX Mobile Coherence Pass validato runtime
- iPhone 13 Safari reale validato
- zoom automatico iOS risolto tramite font-size 16px
- select mobile validate in digitazione e dropdown
- routing insert/update/no-op validato
- cancel create/edit validato
- nodo Command Intent — Create Project / Entity validato runtime
- command_intent_state validato runtime
- btn_command_create_project validato runtime
- btn_command_create_entity validato runtime
- btn_command_go_events validato runtime
- feedback project_created / entity_created validato runtime
- evento normale non regressivo validato dopo Command Intent
- edit flow non regressivo validato dopo Command Intent

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Documentare l’architettura reale dell’interfaccia LOGOS
sviluppata in Retool.

Il documento descrive:

- struttura componenti
- organizzazione UI
- logica runtime
- flussi operativi reali
- parsing controllato
- normalization layer base
- duration normalization base
- type classification base
- preview alignment base
- insert/update flow
- stato UI condiviso
- salvataggio type in events.type
- Match Engine Unification First Controlled Level
- match state project/entity
- allineamento select / hint / highlight / confirm guard
- match state live in create/edit flow
- UX / Cleanup Micro-Batch Post Match Engine
- annulla modifica evento
- search/filter lista eventi
- label creato/modificato lista eventi
- no-op edit guard
- fix UI state nuovo input da lista eventi
- Linting / State Helper Cleanup
- helper edit_mode / editing_event senza additionalScope { value }
- passaggio tecnico controllato tramite window.__logos_edit_mode_value / window.__logos_editing_event_value
- Project / Entity Create Suggestion First Controlled Level
- create_suggestion_state
- insert_project / insert_entity
- container suggestion inline
- micro-editor project/entity
- ignore globale suggestion
- entity autofill controlled minimal
- regola select = decisione utente finale
- vincolo: evento non salvato automaticamente dopo creazione project/entity
- UX Mobile Coherence Pass
- Home mobile rifinita
- Events list mobile rifinita
- Feedback mobile stabilizzato
- feedback_summary
- routing post-save contestuale
- Navigation dock Home / Eventi / Dashboard
- cancel create/edit contestuale
- Dati evento compatti con label inline
- Icon add-ons Retool nei pulsanti reali
- font-size 16px come baseline mobile Safari per input/select
- Command Intent — Create Project / Entity
- command_intent_state
- container_command_intent
- distinzione input evento / comando strutturale puro
- creazione project/entity da command solo previa conferma utente
- esclusione dei comandi puri dal salvataggio evento
- guida non operativa “modifica evento”
- feedback_mode
- feedback project_created / entity_created
- riuso insert_project / insert_entity da command

------------------------------------------------
STRUTTURA GENERALE
------------------------------------------------

Applicazione:

- Single Page
- Nessun routing
- Navigazione tramite stato UI
- Logica client-side JavaScript
- Supabase come backend passivo

---

Gerarchia:

page1  
└── Main  
    └── wrapper  
        ├── container_home  
        ├── container_input  
        ├── container_feedback  
        ├── container_events_list  
        └── container_app_nav / navigation dock

Nota:

container_app_nav è usato come navigation dock contestuale.

Comportamento:

- Home vuota → nav visibile in basso
- Input/Sintesi attiva → nav nascosta
- Events list → nav visibile in alto
- Feedback → nav nascosta

La nav non è fixed/sticky.
La posizione resta controllata dal layout Retool per evitare instabilità mobile.

------------------------------------------------
GESTIONE STATO UI
------------------------------------------------

State Retool:

ui_state

---

Struttura attuale:

```js
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

Ruolo:

controllare la vista attiva
conservare dati parsati
mantenere feedback post-save
supportare create/edit
fornire fonte controllata per amount/unit/event_date in insert/update

feedback_summary:

oggetto UI temporaneo usato solo dal feedback mobile.

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

Binding principali:

container_home:
visibile quando view = "home"

container_feedback:
Hidden = view !== "feedback"

container_events_list:
visibile quando view = "events"

container_input:
visibile quando input_home / input_raw contiene testo operativo

container_app_nav:
visibile in Home vuota oppure Events list
nascosto durante input attivo e feedback

Principio:

UI = funzione dello stato

Stato dati:

ui_state.parsed è la fonte runtime per:

amount
unit
event_date

select1.value è la fonte runtime per:

type

Usato da:

preview
button_input_confirm
insert_event
update_event

Nota:

ui_state.parsed alimenta amount/unit/event_date.
select1.value alimenta type.

project_state / entity_state alimentano il matching project/entity.

select_project.value alimenta project_id.

select_entity.value alimenta entity_id.

Fonti controllate aggiornate:

- amount / unit / event_date → ui_state.parsed
- type → select1.value
- matching project/entity → project_state / entity_state
- project_id → select_project.value
- entity_id → select_entity.value
- feedback temporaneo → ui_state.feedback_summary
- modalità feedback → ui_state.feedback_mode
- command intent → command_intent_state
- view corrente → ui_state.view

ui_state.parsed NON contiene project/entity.

Nota:

ui_state.parsed deve restare sempre strutturato:

{
  amount: null,
  unit: null,
  event_date: null
}

e non deve tornare null.

ui_state.parsed NON contiene command intent.

Il command intent è gestito da:

input_home / input_raw
→ command_intent_state
→ container_command_intent

command_intent_state non è fonte dati salvabile per events.
Serve solo a distinguere comando puro da evento ordinario
e ad attivare UI/azioni controllate dedicate.

------------------------------------------------
HELPER STATE TECNICI
------------------------------------------------

Oltre a ui_state, il flow edit usa due helper Retool:

- edit_mode
- editing_event

Questi helper NON sono fonte business.

Servono solo per controllare:

- modalità inserimento / modifica
- evento NEW attualmente in modifica
- no-op edit guard
- annulla modifica
- reset del flow edit

---

EDIT_MODE

Ruolo:

indicare se il sistema è in modalità modifica evento.

Valori attesi:

- true
- false

Dopo Linting / State Helper Cleanup,
edit_mode non usa più:

additionalScope: { value: ... }

Nuovo pattern runtime:

- il chiamante scrive window.__logos_edit_mode_value
- edit_mode legge window.__logos_edit_mode_value
- edit_mode cancella la chiave window dopo la lettura
- edit_mode ritorna Boolean(nextValue)

Codice runtime:

```js
const key = "__logos_edit_mode_value";

if (!Object.prototype.hasOwnProperty.call(window, key)) {
  return false;
}

const nextValue = window[key];

delete window[key];

return Boolean(nextValue);

CONTAINER HOME

Componenti:

input_home
container_esempi
container_azioni_rapide
container_eventi_da_verificare
container_app_nav

Funzione:

punto ingresso sistema
input principale
accesso rapido alla creazione evento
accesso alla lista eventi da verificare
predisposizione UX a future azioni rapide

INPUT:

campo libero

AZIONI RAPIDE:

- Registra spesa
- Registra incasso
- Registra tempo
- Registra evento

Stato:

- presenti come scorciatoie UX
- graficamente rifinite
- Icon add-ons Retool introdotti
- non ancora operative come flow guidato
- non modificano modello dati
- non salvano eventi
- non bypassano input libero / select / conferma

EVENTI DA VERIFICARE:

card di accesso alla lista eventi NEW / da verificare.

Ruolo:

- rendere visibile il secondo asse operativo del sistema
- collegare Home e Events list
- ridurre ambiguità sul workflow WRITTEN / ERROR / Modifica

CONTAINER INPUT

Componenti:

input_raw (hidden)
sintesi (preview)
select1 (type)
select_project
select_entity
button_input_confirm
btn_cancel_edit
button_cancel_input_home / cancel contestuale
project_state
entity_state
create_suggestion_state
command_intent_state
edit_mode
editing_event
container_association_suggestions
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
input_new_project_name
input_new_entity_name
btn_open_project_create
btn_open_entity_create
btn_create_project_inline
btn_create_entity_inline
btn_ignore_global_suggestions / bottone Ignora globale
btn_cancel_project_inline
btn_cancel_entity_create

Funzione:

preview dati
classificazione type base tramite select1
validazione manuale
selezione project/entity
conferma inserimento o modifica
annullamento modifica senza update_event
creazione guidata project/entity inline
gestione suggestion no-match project/entity
ignore globale suggestion
annullamento contestuale create/edit
riconoscimento command intent base
distinzione comando puro / evento ordinario
creazione project/entity da command previa conferma utente
guida non operativa verso lista eventi
esclusione comandi puri dal salvataggio evento

Preview:

MAIN:

event_date + amount + unit + label

HINT:

- hint duration/type ancora embedded nella preview
- hint matching project/entity alimentati da project_state/entity_state
- hint match più specifici alimentati da moreSpecificMatches

Esempi:

entity_state.isAmbiguous = true + select_entity vuoto
→ "Più entità trovate"

project_state.isAmbiguous = true + select_project vuoto
→ "Più progetti trovati"

entity_state.hasMoreSpecificMatches = true
→ "Esistono entità più specifiche"

project_state.hasMoreSpecificMatches = true
→ "Esistono progetti più specifici"

Caratteristiche:

✔ preview rappresenta i dati principali parsati
✔ preview legge amount/unit/event_date da ui_state.parsed
✔ preview visualizza amount/unit in formato italiano

✔ preview non modifica DB
✔ preview non blocca input
✔ preview supporta create/edit
✔ label cleaning aggiornato sui casi normalizzati
✔ date separate correttamente dalla descrizione
✔ highlight locale reso unit-safe

⚠ contiene ancora logiche di derivazione
⚠ contiene label + hint
⚠ non è una view completamente pura
✔ matching project/entity alimentato da project_state/entity_state  
✔ hint ambiguità matching alimentati da isAmbiguous  
✔ highlight project/entity alimentato da matches  
✔ detection locale preview non più fonte decisionale matching  

⚠ preview ancora ibrida  
⚠ hint duration/type ancora embedded nella preview  

Nota:

La label è:

✔ generata in tempo reale
✔ non persistita
✔ derivata da raw_input
✔ embedded nella preview

Preview Alignment Base:

✔ completato  
✔ formattazione italiana amount implementata nella sintesi  
✔ euro visualizzato con due decimali  
✔ grouping migliaia visuale  
✔ ore/minuti visualizzati coerentemente  
✔ singolare/plurale unit gestito  
✔ rimozione amount/unit dalla label migliorata  
✔ bug "minuti" → "uti" risolto  
✔ separatore data/descrizione uniformato  
✔ unità tecniche escluse dall'highlight locale  
✔ durata visualizzata in forma umana dopo Duration Normalization  
✔ hint normalizzazione durata introdotto  
✔ hint durata ambigua introdotto  

Type Classification Base:

✔ completata  
✔ select1 allineato a ui_state.parsed.unit  
✔ parsed.unit = minuti → Tempo  
✔ euro + keyword controllate di uscita → Spesa  
✔ euro + keyword controllate di entrata → Incasso  
✔ euro senza direzione chiara → Evento  
✔ segnali economici contrastanti → Evento  
✔ scelta manuale utente preservata  
✔ type salvato in events.type tramite confirm flow  
✔ insert_event salva type  
✔ update_event aggiorna type  

Nota:

la formattazione è solo visuale.
Il dato interno resta numerico e viene salvato invariato.

Per le durate certe, dopo Duration Normalization:

- il dato interno è salvato in minuti
- amount = totale minuti
- unit = "minuti"
- raw_input conserva la forma originale
- la preview mostra una forma umana leggibile

Esempio:

2h30 rendering
→ ui_state.parsed.amount = 150
→ ui_state.parsed.unit = minuti
→ preview = 2 ore 30 minuti • rendering
→ hint = Normalizzato: 150 minuti

Type:

2h30 rendering
→ select1 = Tempo
→ events.type = Tempo

Match Engine Unification First Controlled Level:

✔ completato  
✔ project_state / entity_state come fonte minima matching  
✔ select_project / select_entity alimentati da singleMatch  
✔ hint ambiguità alimentati da isAmbiguous  
✔ highlight alimentato da matches  
✔ confirm guard basata su ambiguità non risolta  
✔ priority match minimo implementato  
✔ hint match più specifici implementato  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ bug €500 label preview risolto  
✔ linting edit_mode / editing_event risolti nel nodo successivo Linting / State Helper Cleanup

Project / Entity Create Suggestion First Controlled Level:

✔ completato
✔ create_suggestion_state introdotto
✔ insert_project implementato
✔ insert_entity implementato
✔ container suggestion inline implementato
✔ micro-editor project implementato
✔ micro-editor entity implementato
✔ bottone Ignora globale implementato
✔ bottoni Annulla contestuali implementati
✔ project/entity mancanti non bloccano salvataggio
✔ project/entity ambigui bloccano salvataggio finché non risolti manualmente
✔ project/entity possono essere creati solo previa conferma utente
✔ evento non viene salvato automaticamente dopo creazione project/entity
✔ select_project valorizzata dopo creazione project
✔ select_entity valorizzata dopo creazione entity
✔ entity autofill controlled minimal implementato
✔ una sola creazione guidata aperta alla volta
✔ flow combinato project + entity validato

Nota:

create_suggestion_state non sostituisce project_state / entity_state.
Li consuma per generare suggestion controllate.

Regola critica:

select_project / select_entity sono decisione utente finale.
Valgono anche se il valore selezionato non è presente nel raw_input.

UX Mobile Coherence Pass:

✔ Sintesi strutturata mantenuta
✔ card “Da verificare” confermata
✔ notice associazioni mancanti confermato
✔ suggestion container rifinito graficamente
✔ Dati evento compattati con label inline nelle select
✔ pulsante Conferma evento rifinito
✔ pulsante cancel reso contestuale:
  - create/input → Torna alla home
  - edit → Annulla modifica
✔ nav nascosta durante input attivo
✔ font-size 16px applicato a input/select principali per stabilità Safari iOS

Command Intent — Create Project / Entity:

✔ completato
✔ command_intent_state introdotto come query Retool page-level
✔ command_intent_state riconosce comandi puri
✔ comando generico “crea” gestito
✔ create project incompleto gestito
✔ create project completo gestito
✔ create entity incompleto gestito
✔ create entity completo gestito
✔ sinonimi base supportati: crea, aggiungi, inserisci, nuovo, nuova
✔ comandi puri non mostrano Sintesi evento / Dati evento
✔ comandi puri non salvano eventi
✔ container_command_intent introdotto dentro container_input
✔ input_command_project_name introdotto
✔ input_command_entity_name introdotto
✔ btn_command_create_project collegato a insert_project esistente
✔ btn_command_create_entity collegato a insert_entity esistente
✔ btn_command_go_events collegato alla lista eventi
✔ elementi già presenti riconosciuti e non duplicati
✔ “crea progetto villa” validato come elemento già presente
✔ “modifica evento” gestito come guida non operativa
✔ nessun edit flow parallelo introdotto
✔ feedback_mode introdotto in ui_state
✔ feedback project_created implementato
✔ feedback entity_created implementato
✔ feedback evento ordinario preservato
✔ feedback_resume adattato a Evento / Progetto / Entità
✔ ritorno Home automatico dopo feedback project/entity validato
✔ evento normale non regressivo validato
✔ edit flow non regressivo validato
✔ DB invariato
✔ parser invariato
✔ matching invariato
✔ create_suggestion_state invariato
✔ type classification invariata
✔ duration normalization invariata

Limiti:

⚠ Command Intent è solo un primo livello controllato
⚠ non è intent engine globale
⚠ non gestisce dashboard/report
⚠ non gestisce modifica project/entity da command
⚠ non apre edit flow evento automatico
⚠ non unifica tutte le fonti di interpretazione
⚠ rendering progressivo input evento normale ancora migliorabile
⚠ “Da verificare” resta dentro Sintesi perché non è blocco autonomo

INPUT FLOW

Flow attuale:

input_home
→ input_raw
→ trigger_parse_debounced
→ command_intent_state
→ parse_input_controlled
→ ui_state.parsed
→ project_state / entity_state
→ create_suggestion_state
→ select_project / select_entity
→ select1 / type classification base
→ preview / command intent / hint / highlight / suggestion container
→ Dati evento compatti oppure container_command_intent
→ confirm guard oppure command action
→ feedback_summary
→ save / edit / insert_project / insert_entity / go events
→ feedback / routing post-save

input_home:

source of truth lato UX
campo modificato dall’utente

Fix post UX Cleanup:

quando l’utente scrive un nuovo input partendo dalla lista eventi,
input_home change handler forza la vista corretta:

- ui_state.view = "home"
- container_events_list nascosto
- container_feedback nascosto
- container_home visibile
- container_input visibile
- input_raw sincronizzato
- trigger_parse_debounced rilanciato

Motivo:

evitare doppia visibilità tra sintesi/input e lista eventi.

input_raw:

adapter tecnico
derivato da input_home
hidden
base per parsing e matching

trigger_parse_debounced:

riduce parsing per-lettera
richiama parse_input_controlled con ritardo controllato

parse_input_controlled:

esegue parsing
applica normalization base
applica duration normalization base
restituisce amount/unit/event_date

ui_state.parsed:

riceve il risultato del parser
alimenta preview e confirm

select1:

riceve indirettamente il segnale da ui_state.parsed.unit
alimenta type classification base
alimenta payload.type

project_state / entity_state:

ricevono input_raw
calcolano il matching project/entity
espongono matches / count / isAmbiguous / singleMatch / moreSpecificMatches
alimentano select_project/select_entity
alimentano hint/highlight
alimentano confirm guard

select_project / select_entity:

leggono singleMatch
restano fonte finale salvabile per project_id/entity_id

Principio:

input_home = fonte UX
ui_state.parsed = fonte dati strutturati amount/unit/event_date
select1.value = fonte type
project_state/entity_state = fonte minima matching
create_suggestion_state = fonte suggestion project/entity
command_intent_state = fonte command intent controllata
select_project/select_entity = fonte project_id/entity_id

Regola Command Intent:

command_intent_state NON è fonte salvabile per events.
I comandi puri devono essere intercettati prima del save flow evento.

Se command_intent_state riconosce un comando puro:

- Sintesi evento e Dati evento vengono nascosti
- container_command_intent viene mostrato
- button_input_confirm non deve essere usato
- eventuale creazione project/entity avviene solo tramite conferma utente
- insert_project / insert_entity restano le query operative

Risultato:

✔ ridotto loop reattivo critico
✔ parsing non duplicato nel save
✔ create/edit più coerenti
✔ input e salvataggio allineati
✔ durate certe ore/minuti normalizzate in minuti
✔ raw_input durata preservato
✔ type classification base allineata a parsed.unit
✔ type salvato in events.type
✔ match state live in create flow  
✔ match state live in edit flow  
✔ select_project/select_entity allineati a singleMatch  
✔ hint/highlight/confirm guard allineati a match state  
✔ priority match minimo implementato  
✔ suggestion project/entity controllata implementata
✔ creazione inline project/entity implementata
✔ salvataggio evento separato dalla creazione project/entity
✔ Dati evento compattati con label inline
✔ feedback_summary creato prima del reset input/select
✔ feedback post-save centralizzato
✔ routing post-save contestuale
✔ nav nascosta durante input attivo
✔ input/select mobile Safari stabilizzati con font-size 16px

TRIGGER_PARSE_DEBOUNCED

Tipo:

JS Query / script runtime

Funzione:

cancellare timer precedente
attendere debounce
lanciare command_intent_state
lanciare parsing controllato
aggiornare match state project/entity
aggiornare create_suggestion_state

Codice runtime:

// Reset micro-editor project/entity quando cambia input principale.
// Evita stati stale tra input consecutivi.
project_create_inline_open.setValue(false);
project_create_suggestion_dismissed.setValue(false);
input_new_project_name.setValue("");

entity_create_inline_open.setValue(false);
entity_create_suggestion_dismissed.setValue(false);
input_new_entity_name.setValue("");

if (window.__parseTimer) {
  clearTimeout(window.__parseTimer);
}

window.__parseTimer = setTimeout(async () => {
  await Promise.allSettled([
    command_intent_state.trigger(),
    parse_input_controlled.trigger(),
    project_state.trigger(),
    entity_state.trigger()
  ]);

  await create_suggestion_state.trigger();
}, 350);

Nota:

Il debounce permette preview reattiva
senza parsing continuo a ogni singolo carattere.

Dopo Project / Entity Create Suggestion First Controlled Level,
il debounce aggiorna anche:

- project_state
- entity_state
- create_suggestion_state

Inoltre resetta i micro-state di creazione inline quando cambia input principale,
evitando stati stale tra input consecutivi.

Risultato:

✔ parser aggiornato  
✔ ui_state.parsed aggiornato  
✔ match state aggiornato  
✔ select_project/select_entity coerenti  
✔ preview hint/highlight coerenti  
✔ confirm guard coerente  
✔ command_intent_state aggiornato
✔ command intent coerente con input corrente
✔ comandi puri possono escludere il flow evento ordinario

PARSING FLOW + NORMALIZATION BASE + DURATION NORMALIZATION

Eseguito in:

parse_input_controlled

Non più eseguito in:

button_input_confirm

Output:

{
  amount,
  unit,
  event_date
}

Success handler:

const parsed = parse_input_controlled.data || {};

ui_state.setValue({
  ...ui_state.value,
  parsed: {
    amount: parsed.amount ?? null,
    unit: parsed.unit ?? null,
    event_date: parsed.event_date ?? null
  }
});

Caratteristiche:

✔ normalizzazione input
✔ riconoscimento unità
✔ selezione amount per prossimità
✔ gestione decimali
✔ gestione migliaia italiane
✔ esclusione formato HH:MM
✔ supporto unit compatte
✔ supporto forme testuali compatte
✔ duration normalization base
✔ conversione ore/minuti in minuti
✔ supporto durate composte
✔ supporto forme compatte tipo 2h30
✔ gestione input multi-numero
✔ nessun amount se manca unità
✔ output stabile in ui_state.parsed

UNIT SUPPORTATE:

EURO:

€
euro
eur
€20
20€
€ 20

TEMPO:

ora
ore
h
min
minuto
minuti

Output canonico dopo Duration Normalization:

minuti

Formati supportati:

2h
h2
2 h
1ora
2ore
18min
min30
30 minuti
30minuti
0.5h
1.5 ore
1,5 ore
1 ora e 15 minuti
1 ora 15 minuti
2 ore e 30 minuti
2 ore 30
2h30
2 h 30
90 minuti

Conversioni validate:

1 ora → amount 60, unit minuti
2 ore → amount 120, unit minuti
1,5 ore → amount 90, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
2h30 → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti
90 minuti → amount 90, unit minuti

AMOUNT NORMALIZATION:

458,78 → 458.78
1,5 → 1.5
1.5 → 1.5
1.500 → 1500
1.500,50 → 1500.5
1500 → 1500

REGOLA CRITICA:

Numeri senza unità NON diventano amount.

Esempi:

villa 2 → amount null
villa 2 mario → amount null
cliente 2026 → amount null

LIMITI:

⚠ giorni/settimane non convertiti automaticamente
⚠ giornata / mezza giornata non normalizzate
⚠ parole numeriche tipo “due ore” non supportate
⚠ forme colloquiali tipo “un paio d’ore” non supportate
⚠ 2h e mezza non supportato
⚠ parsing non semantico
✔ type classification base consolidata nello STEP 6.3
⚠ type classification avanzata non implementata

------------------------------------------------
MOBILE SAFARI BASELINE
------------------------------------------------

Durante test reale su iPhone 13 Safari sono stati rilevati due problemi:

1. tap su input causava zoom automatico iOS
2. dopo lo zoom l’app veniva troncata lateralmente
3. le select Tipo / Progetto / Entità non mostravano correttamente il dropdown completo

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

Esito:

✔ zoom automatico Safari iOS risolto
✔ layout non più troncato
✔ select funzionanti sia in digitazione sia in dropdown
✔ validazione reale su iPhone 13 Safari completata

Regola architetturale:

Su mobile Safari, input e select principali devono mantenere font-size minimo 16px.

Eventuali rifiniture visive future non devono scendere sotto una soglia che riattivi lo zoom automatico iOS.

MATCHING FLOW — FIRST CONTROLLED LEVEL

Eseguito tramite:

project_state
entity_state

Consumatori:

select_project
select_entity
sintesi / preview
button_input_confirm.disabled

OUTPUT STANDARD:

project_state / entity_state espongono:

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
→ project_state.data.singleMatch

select_entity:
→ entity_state.data.singleMatch

---

COMPORTAMENTO:

match univoco:
→ singleMatch valorizzato
→ select valorizzata
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

Caratteristiche:

✔ matching osservabile tramite state  
✔ select non ricalcolano matching  
✔ preview non usa detection locale come fonte decisionale  
✔ confirm guard basata su ambiguità non risolta  
✔ auto-select solo se match univoco  
✔ utente mantiene controllo  
✔ match state live in create/edit  

---

Non implementato:

- fuzzy matching
- alias system
- gerarchia entity/project
- deduplicazione
- creazione guidata project/entity
- ranking avanzato
- match engine separato come modulo autonomo

PROJECT_STATE

Ruolo:

fonte minima matching project.

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

Comportamento:

- count = 1 → singleMatch valorizzato
- count > 1 → isAmbiguous true
- count = 0 → nessun match
- più specifici disponibili → hasMoreSpecificMatches true

Nota:

project_state non salva dati.
project_id viene salvato solo tramite select_project.value.

---

ENTITY_STATE

Ruolo:

fonte minima matching entity.

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

Comportamento:

- count = 1 → singleMatch valorizzato
- count > 1 → isAmbiguous true
- count = 0 → nessun match
- più specifici disponibili → hasMoreSpecificMatches true

Nota:

entity_state non salva dati.
entity_id viene salvato solo tramite select_entity.value.

---

SELECT_PROJECT

Default value:

legge project_state.data.singleMatch.

Comportamento:

- se singleMatch esiste → ritorna singleMatch.id
- altrimenti → null

select_project.value resta fonte finale salvabile per project_id.

---

SELECT_ENTITY

Default value:

legge entity_state.data.singleMatch.

Comportamento:

- se singleMatch esiste → ritorna singleMatch.id
- altrimenti → null

select_entity.value resta fonte finale salvabile per entity_id.

------------------------------------------------
CREATE SUGGESTION FLOW — FIRST CONTROLLED LEVEL
------------------------------------------------

Eseguito tramite:

create_suggestion_state

Consumatori:

- container_association_suggestions
- create_suggestion_hint
- btn_open_project_create
- btn_open_entity_create
- input_new_project_name
- input_new_entity_name
- btn_create_project_inline
- btn_create_entity_inline
- bottone Ignora globale

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

---

PROJECT CREATE SUGGESTION

Comportamento:

- se input contiene un project base esistente più possibile estensione specifica
- e non c’è ambiguità
- e la candidate non esiste già
- allora viene proposta creazione project inline

Esempio:

villa sierri 15 sopralluogo
→ base project = Villa
→ candidate project = Villa Sierri 15

Flow:

1. utente clicca Crea progetto
2. input_new_project_name viene precompilato
3. utente conferma Crea progetto
4. insert_project crea record in projects
5. projects_list viene aggiornata
6. select_project viene valorizzata con nuovo id
7. micro-editor si chiude
8. evento NON viene salvato automaticamente

---

ENTITY CREATE SUGGESTION

Comportamento:

- se entity no-match reale
- e non c’è ambiguità
- e non esiste una entity selezionata
- allora viene proposta creazione entity inline

Flow:

1. utente clicca Crea entità
2. input_new_entity_name viene mostrato
3. utente inserisce o conferma nome entità
4. insert_entity crea record in entities
5. entities_list viene aggiornata
6. select_entity viene valorizzata con nuovo id
7. micro-editor si chiude
8. evento NON viene salvato automaticamente

---

ENTITY AUTOFILL CONTROLLED MINIMAL

Per entity è disponibile un autofill minimale controllato.

Regole:

- non crea automaticamente entità
- non seleziona automaticamente entità
- non modifica DB
- non modifica raw_input
- precompila solo input_new_entity_name quando la candidate è sicura

Candidate consentite solo se:

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

IGNORE GLOBALE

Un solo bottone Ignora globale è visibile nello stato chiuso del container.

Comportamento:

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

---

ANNULLA MICRO-EDITOR

Annulla project:

- chiude micro-editor project
- ignora solo la proposta project corrente
- non cancella il match base già riconosciuto
- non cancella select_project

Annulla entity:

- chiude micro-editor entity
- ignora proposta entity corrente
- svuota input_new_entity_name
- non modifica raw_input
- non modifica project

---

DUPLICATE GUARD

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
COMMAND INTENT FLOW — CREATE PROJECT / ENTITY
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

btn_command_create_entity:

- legge candidateName o input_command_entity_name
- valorizza input_new_entity_name
- trigger insert_entity
- refresh entities_list
- imposta feedback_mode = entity_created
- mostra feedback entità
- ritorna Home automaticamente

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

LABEL (RUNTIME)

Eseguito in:

sintesi (preview)

Caratteristiche:

✔ generata runtime
✔ non persistita
✔ non esiste come layer separato
✔ derivata da raw_input
✔ utile per UX
✔ allineata ai casi normalizzati principali


Operazioni:

rimozione amount + unit già rappresentati dal value
rimozione date già parse
normalizzazione spazi
preservazione numeri semantici
compound token
gestione unità compatte
rimozione durate composte già normalizzate
rimozione residui “e/ed” dopo cleaning durata
label leggibile

Aggiornamenti Preview Alignment Base:

✔ euro separati / compatti rimossi dalla label  
✔ ore separate / compatte rimosse dalla label  
✔ minuti separati / compatti rimossi dalla label  
✔ bug "minuti" → "uti" risolto  
✔ "villa 2" preservato  
✔ data separata dalla descrizione  
✔ durate composte rimosse dalla label dopo Duration Normalization  
✔ forme compatte tipo 2h30 rimosse dalla label  
✔ residui congiunzione “e/ed” rimossi  
✔ bug duplicazione €500 risolto  
✔ gestione € prima del numero corretta  

Nota:

✔ utile per UX
✔ non modifica DB
✔ non è fonte dati strutturata
✔ non modifica ui_state.parsed

⚠ parte della logica preview
⚠ non riutilizzabile come modulo
⚠ non isolata
⚠ preview non ancora view pura

PREVIEW (SINTESI)

Ruolo:

mostrare interpretazione sistema
aiutare l’utente prima del salvataggio
visualizzare amount/unit/type/label/project/entity/hint

Input usati:

input_raw.value
ui_state.parsed
select_project.value
select_entity.value
projects_list.data
entities_list.data
project_state.data
entity_state.data
select1.value

Nota:

select1.value viene usato per type.
La preview può mostrare/supportare il type,
ma la persistenza avviene tramite button_input_confirm.

Output:

labelStyled
typeBadge
hint

Caratteristiche:

✔ non blocca input
✔ non salva dati
✔ supporta correzione utente
✔ mostra dati principali
✔ legge amount/unit/event_date da ui_state.parsed
✔ visualizza amount/unit in formato italiano
✔ visualizza durata normalizzata in forma umana
✔ mostra valore tecnico normalizzato come hint
✔ segnala giorni/settimane come durata ambigua
✔ separa correttamente data e descrizione
✔ applica label cleaning sui casi normalizzati
✔ highlight locale reso unit-safe
✔ legge project_state/entity_state per matching project/entity  
✔ hint ambiguità matching alimentati da isAmbiguous  
✔ hint match più specifici alimentati da hasMoreSpecificMatches  
✔ highlight project/entity alimentato da matches  
✔ detection locale preview non più fonte decisionale matching  

⚠ contiene logiche di trasformazione
⚠ contiene label cleaning
⚠ contiene hint logic
⚠ non è ancora view pura
⚠ utilizza fonti multiple
⚠ preview resta layer ibrido

VALUE BUILDER:

Il value builder costruisce la rappresentazione visuale del dato normalizzato.

Funzioni runtime introdotte:

formatAmountIT
formatUnitIT
formatDurationHumanIT
formatDurationMinutesIT

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

2 giorni rendering
→ 2 giorni rendering
→ Durata ambigua: specifica ore/minuti per salvarla come tempo analizzabile

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

REGOLA DURATION:

Per le durate certe il dato interno viene salvato in minuti.

Esempio:

input:
2h30 rendering

ui_state.parsed.amount:
150

ui_state.parsed.unit:
minuti

preview:
2 ore 30 minuti • rendering

hint:
Normalizzato: 150 minuti

DB:
amount 150
unit minuti
raw_input 2h30 rendering

REGOLA TYPE:

Il type viene determinato da select1.

Esempio:

input:
2h30 rendering

ui_state.parsed.amount:
150

ui_state.parsed.unit:
minuti

select1:
Tempo

DB:
type Tempo
amount 150
unit minuti
raw_input 2h30 rendering

REGOLA MATCHING:

Il matching project/entity è determinato da project_state/entity_state.

La preview legge il match state per:

- hint ambiguità
- hint match più specifici
- highlight project/entity

La preview non decide project/entity
e non è fonte di salvataggio.

Esempio:

villa 2 mario
→ project_state.singleMatch = Villa 2
→ entity_state.singleMatch = Mario
→ preview evidenzia villa 2 e mario
→ DB salva project_id/entity_id solo tramite select_project/select_entity

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

È stato introdotto un filtro locale per evitare che unità tecniche vengano evidenziate come match.

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
l’highlight project/entity legge i matches da:

- project_state.data.matches
- entity_state.data.matches

La preview non usa più detection locale come fonte decisionale matching.

CONFIRM FLOW

Componente:

button_input_confirm

Ruolo:

confermare inserimento
confermare modifica evento NEW
costruire payload da ui_state.parsed e select1.value
lanciare insert_event o update_event
aggiornare feedback, lista e routing post-save

Sequenza attuale:

legge ui_state.parsed
costruisce payload
determina wasEditMode
esegue no-op edit guard se in edit mode
costruisce feedbackText / feedbackProject / feedbackEntity
costruisce feedbackSummary prima del reset input/select
cancella debounce pending
resetta input/select
mostra feedback come ultimo stato UI visibile
esegue insert_event o update_event
attende savePromise
aggiorna events_new
resetta edit_mode / editing_event se necessario
avvia timer feedback 1800 ms
ritorna a Home o Events list in base a insert/update

EDIT MODE:

edit_mode = true → update_event
edit_mode = false → insert_event

VINCOLI:

✔ conferma bloccata se:

- input_raw vuoto
- project_state.isAmbiguous = true e select_project vuoto
- entity_state.isAmbiguous = true e select_entity vuoto

✔ conferma consentita se:

- match univoco
- nessun match
- ambiguità risolta manualmente

✔ nessuna ambiguità non risolta consentita in insert/update

Principio:

button_input_confirm NON esegue parsing.

Il parsing legacy è stato rimosso.

Fonte dati:

const parsed = ui_state.value?.parsed || {
  amount: null,
  unit: null,
  event_date: null
};

type viene letto da:

select1.value

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

NO-OP EDIT GUARD:

In edit mode, prima di eseguire update_event,
button_input_confirm verifica se i campi realmente modificabili dall’utente
sono rimasti invariati.

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
Una rielaborazione del parser non deve essere considerata modifica utente.

Comportamento:

se edit_mode = true
e raw_input / type / project_id / entity_id non cambiano:

- update_event NON viene eseguito
- updated_at NON viene aggiornato
- edit_mode viene chiuso
- editing_event viene azzerato
- input/select/ui_state.parsed vengono resettati
- la UI torna alla lista eventi

Risultato:

edit senza modifiche reali non produce falsa label “modificato”.

Disabled logic:

button_input_confirm non ricalcola parsing.
button_input_confirm non ricalcola matching.
button_input_confirm non gestisce command intent.

I comandi puri riconosciuti da command_intent_state devono essere esclusi
dal save flow evento.

Per command intent:

- create project/entity usa btn_command_create_project / btn_command_create_entity
- guida modifica evento usa btn_command_go_events
- button_input_confirm resta dedicato agli eventi ordinari

Legge:

- input_raw.value
- project_state.data.isAmbiguous
- entity_state.data.isAmbiguous
- select_project.value
- select_entity.value

Decisione:

- ambiguità non risolta → blocco
- ambiguità risolta manualmente → conferma consentita
- nessun match → conferma consentita

Reset UI / Feedback:

button_input_confirm crea feedbackSummary prima del reset input/select.

ui_state viene aggiornato con:

{
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
}

container_home.setHidden(true)
container_input.setHidden(true)
container_events_list.setHidden(true)
container_feedback.setHidden(false)

Nota:

Per feedback da Command Intent:

- feedback_mode = project_created dopo btn_command_create_project
- feedback_mode = entity_created dopo btn_command_create_entity

Per feedback evento ordinario:

- feedback_mode = null / event_created

Regola:

Il feedback viene mostrato come ultimo stato UI visibile,
per evitare che input_home.setValue("") o altri handler di change sovrascrivano la vista.

Save / refresh / routing:

const wasEditMode = edit_mode.data;

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

Routing post-save:

- insert reale → feedback 1800 ms → Home
- update reale → feedback 1800 ms → Lista eventi
- no-op edit → Lista eventi immediata, senza feedback, senza update_event

handle_event_success:

non è più responsabile della gestione UI post-save.

Decisione:

button_input_confirm centralizza feedback e routing post-save.
insert_event / update_event non devono avere success handler UI duplicati che cambiano view.

Risultati:

✔ parsing duplicato eliminato
✔ insert/update coerenti
✔ type salvato in insert/update
✔ feedback immediato
✔ lista aggiornata dopo salvataggio reale
✔ update visibile senza refresh pagina
✔ edit senza modifiche reali non esegue update_event
✔ updated_at non cambia su conferma senza modifiche
✔ label creato/modificato resta coerente
✔ edit_mode azzerato senza additionalScope { value }
✔ editing_event azzerato anche dopo update reale completato
✔ linting edit_mode / editing_event risolti
✔ feedback_summary introdotto
✔ feedback mobile stabilizzato
✔ handle_event_success disabilitato come gestore UI post-save
✔ routing post-save contestuale
✔ insert → feedback → Home
✔ update → feedback → Lista eventi
✔ no-op edit → Lista eventi senza feedback

INSERT_EVENT

Tipo:

REST Query Supabase

Uso:

inserimento nuovo evento
status iniziale NEW

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

additionalScope generato da button_input_confirm.

Campi valorizzati:

raw_input
type
amount
unit
event_date
project_id
entity_id
status
updated_at
payload

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

Tipo:

REST Query Supabase

Uso:

modifica evento esistente
consentita su eventi NEW
status invariato

Origine valori:

additionalScope generato da button_input_confirm.

Campi aggiornati:

raw_input
type
amount
unit
event_date
project_id
entity_id
updated_at

Validato:

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

Fix recente:

events_new non viene più aggiornato prima del completamento update_event.

Nuovo ordine:

await savePromise
→ await events_new.trigger()

Risultato:

✔ lista aggiornata subito
✔ nessun refresh pagina necessario

No-op edit guard:

button_input_confirm impedisce update_event quando l’utente conferma una modifica
senza cambiare realmente:

- raw_input
- type
- project_id
- entity_id

In questo caso:

- update_event non parte
- updated_at resta invariato
- l’evento resta visualizzato come creato nella lista

BTN_EDIT — FLOW AGGIORNATO

Il pulsante edit rilancia anche il match state.

Sequenza:

1. window.__logos_editing_event_value = item
2. editing_event.trigger()
3. window.__logos_edit_mode_value = true
4. edit_mode.trigger()
5. mostra container input
5A. forza container_events_list nascosto
5B. forza container_feedback nascosto
1. pulisce select_project / select_entity
2. carica item.raw_input in input_home e input_raw
3. rilancia:
   - parse_input_controlled
   - project_state
   - entity_state
4. ripristina project_id/entity_id salvati se presenti

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
✔ doppia visibilità input/lista dopo Annulla evitata

------------------------------------------------
CANCEL CONTESTUALE — CREATE / EDIT FLOW
------------------------------------------------

Componente:

pulsante cancel contestuale

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

Codice helper aggiornato:

```js
window.__logos_edit_mode_value = false;
await edit_mode.trigger();

window.__logos_editing_event_value = null;
await editing_event.trigger();

EVENTS_NEW

Tipo:

REST Query Supabase

Uso:

recupera eventi NEW
alimenta lista processing
mostra eventi modificabili

Query attuale:

events?select=*&status=eq.NEW&order=updated_at.desc.nullslast,created_at.desc

Ruolo nel flow:

Dopo insert/update:

await events_new.trigger()

Motivo:

evitare race condition tra save e refresh lista.

Lista eventi:

events_new alimenta list_events.

Dopo UX Cleanup, list_events usa un filtro client-side
basato su input_events_search.

events_new NON è stato modificato.

La Data source di list_events filtra su:

- raw_input
- type
- status
- nome progetto
- nome entità

La ricerca è solo UX client-side:

- non modifica DB
- non modifica query Supabase
- non modifica status eventi
- non modifica insert/update

------------------------------------------------
LISTA EVENTI — SEARCH / FILTER / LABEL
------------------------------------------------

Componenti:

container_events_list
events_title
input_events_search
list_events

---

INPUT_EVENTS_SEARCH

Tipo:

Text Input

Ruolo:

filtrare rapidamente la lista eventi NEW.

Placeholder:

Cerca evento...

Comportamento:

- campo vuoto → lista completa
- testo inserito → filtro client-side

Ricerca su:

- item.raw_input
- item.type
- item.status
- nome progetto
- nome entità

Vincoli:

✔ nessuna modifica events_new
✔ nessuna modifica DB
✔ nessuna modifica insert/update
✔ nessuna modifica parser
✔ nessuna modifica matching
✔ nessuna modifica type/duration

UX Mobile Coherence Pass:

- search bar ridimensionata
- icona search monotona tramite add-on Retool
- font-size 16px per stabilità Safari iOS

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

Hidden logic concettuale:

la nav è visibile solo quando serve come navigazione principale,
non durante inserimento attivo o feedback temporaneo.

Decisione:

Navigation dock contestuale.
Non fixed/sticky.

Motivo:

- evitare sovrapposizioni mobile
- evitare instabilità Retool
- rendere la nav utile in lista eventi lunga
- non disturbare input/sintesi
- predisporre Dashboard senza implementarla

Pattern:

Navigation Dock Pattern
Future Section Placeholder Pattern

---

LIST_EVENTS

Tipo:

ListView

Data source:

events_new.data filtrato client-side tramite input_events_search.

Azioni disponibili:

- edit
- WRITTEN
- ERROR

UX Mobile Coherence Pass:

- card evento rese più leggibili
- pulsanti OK / No / Modifica rifiniti
- Icon add-ons Retool introdotti nei pulsanti
- navigation dock visibile in alto nella vista Events
- freccia indietro non più necessaria

---

LABEL DATA LISTA EVENTI

La lista eventi distingue:

- creato
- modificato

Regole:

- created_at / updated_at normalizzati in modo robusto
- date DB trattate coerentemente come UTC
- visualizzazione convertita Europe/Rome
- updated_at vicino a created_at non viene considerato modifica reale
- eventi mai modificati → creato
- eventi modificati realmente → modificato
- eventi modificati mostrano marcatore leggero

Esempio:

creato oggi • 13:02

✎ modificato oggi • 13:19

Nota:

La label lista eventi è UX/processing.
Non è preview.
Non viene persistita.
Non modifica DB.

QUERY ATTIVE

GLOBAL:

projects_list
entities_list

PAGE1 — INPUT / PARSING:

trigger_parse_debounced
parse_input_controlled

PAGE1 — DATA / MATCHING / SUGGESTION:

project_state
entity_state
create_suggestion_state
command_intent_state

command_intent_state:

query page-level Run JS Code.
Riconosce comandi puri e distingue input evento da comando strutturale.

Non salva dati.
Non modifica DB.
Non modifica parser.
Non modifica matching.
Non sostituisce create_suggestion_state.

PAGE1 — EVENTI:

insert_event
update_event
events_new
update_written
update_error
insert_project
insert_entity

PAGE1 — STATE / UI:

ui_state
edit_mode
focus_input_home
handle_event_success
editing_event
project_create_inline_open
project_create_suggestion_dismissed
entity_create_inline_open
entity_create_suggestion_dismissed

window.__logos_edit_mode_value
window.__logos_editing_event_value

handle_event_success:

presente come query legacy/di supporto,
ma non deve più gestire la UI post-save.
La gestione feedback/routing è centralizzata in button_input_confirm.

PAGE1 — COMPONENTI UI RILEVANTI:

select1
select_project
select_entity
btn_cancel_edit
input_events_search
list_events
container_association_suggestions
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
input_new_project_name
input_new_entity_name
btn_open_project_create
btn_open_entity_create
btn_create_project_inline
btn_create_entity_inline
bottone Ignora globale
btn_cancel_project_inline
btn_cancel_entity_create
container_app_nav
btn_nav_home
btn_nav_events
btn_nav_dashboard
btn_cancel_edit / pulsante cancel contestuale

Nota:

select1 è un componente UI Select di Retool,
non una query.
Il suo Default value contiene la logica Type Classification Base.
Il valore runtime select1.value alimenta payload.type.

Nota:

select_project e select_entity non ricalcolano più matching.
Leggono singleMatch da project_state/entity_state.

Nota:

create_suggestion_state non è fonte di salvataggio.
Serve solo a mostrare suggestion controllate e alimentare i micro-flow di creazione inline.

insert_project / insert_entity vengono eseguite solo da azione esplicita utente.

LEGACY / DEBITO:

eventuali residui parse_input o typing_state non devono essere considerati fonte di verità se ancora presenti
fonte operativa parsing = parse_input_controlled
fonte operativa salvataggio = ui_state.parsed
SUPABASE INTEGRAZIONE

Connessione:

REST API

Uso:

fetch projects
fetch entities
insert project controllato
insert entity controllato
insert eventi
update eventi
update status
fetch eventi NEW

Nota:

database passivo

Supabase:

✔ salva dati
✔ espone API
✔ restituisce lista eventi

NON:

interpreta input
valida semantica
normalizza amount/unit
decide project/entity
classifica autonomamente spesa/incasso
decide autonomamente type
crea automaticamente project/entity
deduplica automaticamente project/entity
interpreta command intent
distingue evento ordinario da comando puro

Nota Command Intent:

Command Intent è gestito interamente lato Retool.

Supabase riceve scritture solo quando l’utente conferma:

- insert_project per progetto da command
- insert_entity per entità da command

Nessun evento viene creato da un comando puro.

PATTERN ARCHITETTURALI

✔ Adapter Pattern (input_raw)
✔ State-driven UI
✔ Client-side logic
✔ Append-only controllato (editing su NEW)
✔ Single Source of Truth per amount/unit/event_date: ui_state.parsed
✔ Fonte runtime type: select1.value
✔ Async save con refresh lista post-save
✔ Progressive enhancement
✔ Match State Pattern per project/entity  
✔ Controlled Select Pattern tramite singleMatch  
✔ Confirm Guard basata su ambiguità non risolta 
✔ No-op Edit Guard
✔ Client-side List Filter
✔ Controlled Edit Cancel Flow
✔ Created/Updated Display Guard 
✔ Window-backed Helper State per edit_mode / editing_event
✔ Linting-safe Edit Helper Pattern
✔ Create Suggestion State Pattern
✔ Inline Resource Creation Pattern
✔ User-confirmed Insert Pattern
✔ Suggestion Dismiss Pattern
✔ Manual Select Override Pattern
✔ One Inline Creation At A Time Pattern
✔ Feedback Summary Pattern
✔ Centralized Post-save Routing Pattern
✔ Contextual Cancel Pattern
✔ Navigation Dock Pattern
✔ Future Section Placeholder Pattern
✔ Mobile Safari 16px Input Baseline Pattern
✔ Retool Icon Add-on Pattern
✔ Compact Select Label Pattern
✔ Command Intent State Pattern
✔ Command Intent Container Pattern
✔ Pure Command Exclusion Pattern
✔ Guided Command Action Pattern
✔ Existing Resource Guard Pattern
✔ Command Feedback Mode Pattern

PROBLEMI NOTI

RISOLTI:

✔ parsing fragile → risolto
✔ perdita unit → risolta
✔ mismatch amount → risolto
✔ numeri senza unità → risolti
✔ parsing duplicato nel confirm → risolto
✔ divergenza save / DB → risolta
✔ race condition update → events_new → risolta
✔ lista vecchia dopo update → risolta
✔ loop input/parsing critico → risolto
✔ preview alignment base → completato
✔ formattazione italiana amount in preview → risolta
✔ grouping migliaia visuale → risolto
✔ bug "minuti" → "uti" → risolto
✔ separatore data/descrizione → risolto
✔ highlight improprio su unità → risolto
✔ duration normalization base → completata
✔ durate ore/minuti non confrontabili → risolte
✔ 1 ora e 15 minuti non normalizzato → risolto
✔ 2h30 non normalizzato → risolto
✔ 2 ore 30 non normalizzato → risolto
✔ ore decimali non convertite in minuti → risolto
✔ preview durata tecnica poco leggibile → risolta
✔ giorni/settimane silenziosi → ridotti tramite hint ambiguità
✔ select1 non allineato a Duration Normalization → risolto
✔ 2h30 mostrato come Evento → risolto
✔ type non persistito in DB → risolto
✔ insert_event senza type → risolto
✔ update_event senza type → risolto
✔ override manuale type non validato → risolto
✔ matching non unificato tra state/select/preview/confirm → RISOLTO A PRIMO LIVELLO  
✔ select_project/select_entity con logica autonoma duplicata → RISOLTO  
✔ hint ambiguità incoerenti rispetto a project_state/entity_state → RISOLTO  
✔ confirm guard fragile su matches array → RISOLTO  
✔ confirm bloccato anche dopo scelta manuale → RISOLTO  
✔ match state non live nel create flow → RISOLTO  
✔ match state non live nell’edit flow → RISOLTO  
✔ ristrutturazione bagno ambiguo con Ristrutturazione → RISOLTO  
✔ villa 2 evidenziato solo come villa → RISOLTO  
✔ bug €500 nella label preview → RISOLTO  
✔ linting project_state/entity_state → RISOLTO  
✔ assenza annulla modifica in edit mode → RISOLTO
✔ doppia visibilità input/lista dopo Annulla → RISOLTO
✔ lista eventi non filtrabile → RISOLTO
✔ eventi appena inseriti mostrati come modificati → RISOLTO
✔ edit senza modifiche aggiornava updated_at → RISOLTO
✔ nuovo input da lista eventi lasciava visibili input e lista insieme → RISOLTO
✔ linting edit_mode: 'value' is not defined → RISOLTO
✔ linting editing_event: 'value' is not defined → RISOLTO
✔ additionalScope { value } su helper edit_mode / editing_event → RIMOSSO
✔ creazione guidata project/entity non implementata → RISOLTA A PRIMO LIVELLO
✔ no-match project/entity senza assistenza → RISOLTO A PRIMO LIVELLO
✔ creazione project inline → IMPLEMENTATA
✔ creazione entity inline → IMPLEMENTATA
✔ salvataggio evento dopo creazione project/entity → VALIDATO
✔ evento salvabile senza project/entity → VALIDATO
✔ blocco solo su ambiguità attiva → VALIDATO
✔ entity autofill controllato → IMPLEMENTATO
✔ UI suggestion container grezza → RISOLTA A LIVELLO MOBILE BASE
✔ Home mobile grezza → RISOLTA
✔ Events list mobile poco rifinita → RISOLTA
✔ Feedback rapido/conflittuale → RISOLTO
✔ handle_event_success duplicava gestione UI post-save → RISOLTO
✔ routing post-save non contestuale → RISOLTO
✔ cancel create/edit non contestuale → RISOLTO
✔ assenza navigation dock → RISOLTA A LIVELLO BASE
✔ Dati evento troppo alti → RIDOTTI con label inline
✔ pulsanti non uniformi → RIDOTTI con Icon add-ons Retool
✔ zoom automatico Safari iOS su input → RISOLTO
✔ app troncata lateralmente dopo zoom iOS → RISOLTO
✔ select mobile senza dropdown stabile → RISOLTO con font-size 16px
✔ command intent non implementato → RISOLTO A PRIMO LIVELLO
✔ input “crea progetto...” trattato come evento ordinario → RISOLTO
✔ input “crea entità...” trattato come evento ordinario → RISOLTO
✔ comando puro salvabile come evento → RISOLTO
✔ duplicazione project/entity già esistenti da command → RISOLTA
✔ feedback “Evento salvato” su creazione project/entity → RISOLTO
✔ “modifica evento” senza guida da input libero → RISOLTO

UI:

⚠ input non multilinea
⚠ preview migliorabile come architettura
⚠ preview non pura
⚠ label cleaning ancora embedded
✔ hint matching project/entity state-driven  
✔ annulla modifica implementato
✔ lista eventi filtrabile
✔ label creato/modificato coerente
✔ nuovo input da lista eventi non lascia più doppia vista
⚠ hint duration/type ancora embedded nella preview  
⚠ “Da verificare” resta dentro Sintesi e non è blocco autonomo
⚠ rendering progressivo input evento normale ancora migliorabile

✔ formattazione italiana amount allineata nella sintesi

DATA:

⚠ nessuna gerarchia entity
⚠ dati storici non retro-normalizzati
⚠ payload non usato

TYPE:

✔ Type Classification Base implementata
✔ Spesa / Incasso / Tempo / Evento persistiti in events.type
⚠ type classification avanzata non implementata
⚠ amount firmato non implementato
⚠ direction field non implementato
⚠ type non sufficiente da solo per KPI avanzati

ARCHITETTURA:

⚠ accoppiamento preview / label / hint
✔ matching project/entity unificato a primo livello controllato  
✔ hint matching project/entity state-driven  
⚠ match engine avanzato separato non implementato  
⚠ alias / gerarchie / deduplicazione non implementati  
✔ creazione guidata project/entity implementata a primo livello controllato
✔ command intent create project/entity implementato a primo livello controllato
⚠ command intent avanzato non implementato
⚠ input analysis model unico non implementato
✔ UI suggestion container rifinita a livello mobile base
⚠ Cambia / Scegli nella Sintesi ancora non cliccabili
⚠ Azioni rapide non operative
⚠ Dashboard predisposta ma non implementata
⚠ mobile polish finale font/spaziature rimandato 

STATO ARCHITETTURA

✔ funzionante
✔ coerente nei dati strutturati principali
✔ insert stabile
✔ update stabile
✔ lista eventi coerente dopo save
✔ parsing affidabile
✔ normalization base implementata
✔ preview alignment base completato
✔ duration normalization base completata
✔ type classification base completata
✔ select1 allineato a ui_state.parsed.unit
✔ events.type persistito in insert/update
✔ durate certe ore/minuti salvate in minuti
✔ preview durata in forma umana
✔ amount/unit/date visualizzati coerentemente
✔ label pipeline stabile
✔ UX migliorata
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
✔ input_events_search implementato
✔ no-op edit guard implementato
✔ label creato/modificato lista eventi corretta
✔ nuovo input da lista eventi gestito correttamente
✔ create/edit/lista/WRITTEN/ERROR validati dopo cleanup
✔ Linting / State Helper Cleanup completato
✔ edit_mode / editing_event non usano più additionalScope { value }
✔ linting edit_mode / editing_event risolti
✔ create/edit/annulla/no-op edit/edit reale rivalidati dopo cleanup helper
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ create_suggestion_state implementato
✔ insert_project implementato e validato
✔ insert_entity implementato e validato
✔ container suggestion inline implementato
✔ micro-editor project/entity implementati
✔ ignore globale suggestion implementato
✔ entity autofill controlled minimal implementato
✔ flow combinato project + entity validato
✔ salvataggio evento con project_id/entity_id creati inline validato
✔ UX Mobile Coherence Pass completato
✔ Home mobile rifinita
✔ Events list mobile rifinita
✔ Feedback mobile stabilizzato
✔ feedback_summary introdotto
✔ routing post-save contestuale
✔ insert → feedback → Home
✔ update → feedback → Lista eventi
✔ no-op edit → Lista eventi senza update_event
✔ cancel create/input → Home
✔ cancel edit → Lista eventi
✔ Navigation dock Home / Eventi / Dashboard introdotta
✔ Dashboard predisposta ma disabilitata
✔ Dati evento compattati con label inline
✔ Icon add-ons Retool introdotti nei pulsanti reali
✔ font-size 16px input/select validato su Safari iOS
✔ validazione reale iPhone 13 Safari completata
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
✔ evento normale non regressivo dopo Command Intent validato
✔ edit flow non regressivo dopo Command Intent validato

⚠ non completamente stabile nei layer evolutivi
⚠ preview ancora ibrida
⚠ match engine avanzato separato non implementato
⚠ alias / gerarchie / deduplicazione non implementati
✔ creazione guidata project/entity implementata a primo livello controllato
⚠ command intent avanzato non implementato
⚠ input analysis model unico non implementato
⚠ rendering progressivo input evento normale ancora migliorabile
⚠ suggestion create vs edit consistency da verificare
⚠ project creation override con match generico non implementato
⚠ Azioni rapide non operative
⚠ Dashboard non implementata
⚠ Icon System non completamente standardizzato
⚠ output non attivo

------------------------------------------------
NEXT STEP ARCHITETTURALE CONSIGLIATO
------------------------------------------------

NEXT NODE POST COMMAND INTENT DA DEFINIRE

Candidati principali residui:

1. INPUT RENDERING STABILITY / CONTAINER STRUCTURE

- ridurre rendering progressivo / flash su input evento normale
- valutare separazione container preview / hint / dati evento
- valutare stato unico input_analysis_ready
- migliorare stabilità visiva senza modificare parser/matching/DB
- non rompere command intent
- non rompere suggestion container
- non rompere edit flow

2. PREVIEW MODEL / HINT STATE CONSOLIDATION

- consolidare hint/warning ancora embedded nella Sintesi
- valutare se “Da verificare” debba diventare blocco autonomo
- separare hint bloccanti, warning informativi e suggestion create
- rendere la preview più vicina a una view pura
- evitare divergenze tra ciò che l’utente legge e ciò che viene salvato

3. INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER

- valutare direzione verso un solo layer di analisi interrogabile
- coordinare parse_input_controlled, project_state, entity_state, create_suggestion_state, command_intent_state
- ridurre rami ibridi e fonti parallele
- non introdurre refactor globale senza nodo dedicato

4. DATA STRUCTURE / ENTITY HIERARCHY

- valutare gerarchie
- alias
- deduplicazione avanzata
- relazioni entity-project
- filtro select su match ambigui

5. SUGGESTION CREATE VS EDIT CONSISTENCY

- verificare differenze suggestion tra create flow e edit flow
- capire perché in alcuni edit flow compare solo suggestion entity
- non modificare create_suggestion_state senza casi riproducibili

6. PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE

- valutare creazione progetto anche con match generico
- esempio input “villa”
- evitare duplicati e creazioni aggressive

7. ECONOMIC DIRECTION ADVANCED

- valutare amount firmato
- valutare direction field
- valutare regole contabili avanzate Spesa/Incasso

8. DURATION ADVANCED — GIORNI / SETTIMANE

- decidere conversione giorni/settimane
- valutare giornata lavorativa
- valutare mezza giornata
- evitare conversioni automatiche ambigue

9. AZIONI RAPIDE OPERATIVE

- rendere operative le scorciatoie Home
- coordinarsi con command_intent_state
- non bypassare Conferma evento
- non salvare automaticamente

10. DASHBOARD BASE

- attivare la voce Dashboard solo quando i dati sono sufficienti
- evitare KPI fuorvianti

11. ICON SYSTEM / MOBILE POLISH FINALE

- standardizzare Icon add-ons / emoji / eventuali SVG
- preservare font-size input/select 16px su Safari iOS

CHANGELOG

v01 — 2026-04-01

documentazione architettura base

v02 — 2026-04-03

integrazione parsing retrofit
integrazione matching step 2

v03 — 2026-04-03

fix pipeline insert
supporto unit compatte

v04 — 2026-04-04

introduzione label layer
integrazione label pipeline
miglioramento UX hint
gestione ambiguità input corto

v05 — 2026-04-23

introduzione update_event
introduzione edit_mode
aggiornamento confirm flow
centralizzazione UI state
aggiornamento append-only controllato
identificazione loop reattivo
allineamento architettura con runtime reale

v06 — 2026-04-30

introduzione parse_input_controlled come fonte parsing runtime
introduzione trigger_parse_debounced
stabilizzazione ui_state.parsed
completamento Normalization Layer Base
normalizzazione amount formato italiano
normalizzazione unit base
supporto unità compatte testuali
rimozione amount per numeri senza unità
rimozione parsing legacy da button_input_confirm
allineamento insert/update a ui_state.parsed
validazione insert con amount/unit normalizzati
validazione update con amount/unit normalizzati
fix race condition update → events_new
aggiornamento lista eventi dopo save completato
apertura prossimo nodo consigliato: Preview Alignment Base

v07 — 2026-04-30

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
aggiornamento prossimo nodo consigliato: STEP 6.2 — DURATION NORMALIZATION

v08 — 2026-04-30

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
aggiornamento prossimo nodo consigliato: STEP 6.3 — TYPE CLASSIFICATION BASE

v09 — 2026-05-01

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

v10 — 2026-05-02

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

v11 — 2026-05-02

completamento UX / CLEANUP MICRO-BATCH POST MATCH ENGINE
documentato btn_cancel_edit
documentato annulla modifica senza update_event
documentato reset edit_mode / editing_event / input / select / ui_state.parsed
documentato fix doppia visibilità input/lista dopo Annulla
documentato input_events_search
documentato filtro client-side su list_events
documentata ricerca su raw_input / type / status / project / entity
documentata label creato/modificato lista eventi
documentata normalizzazione robusta created_at / updated_at
documentato marcatore leggero per eventi modificati
documentato no-op edit guard in button_input_confirm
documentato edit senza modifiche reali non aggiorna updated_at
documentato fix UI state per nuovo input da lista eventi
create flow validato
edit flow validato
annulla modifica validato
search/filter lista validato
WRITTEN / ERROR validati
regressione match/type/duration validata
DB invariato
parser invariato
Match Engine invariato
Type Classification invariata
Duration Normalization invariata
linting edit_mode/editing_event ancora residui non bloccanti
aggiornamento prossimo nodo consigliato a NEXT NODE da definire dopo chiusura aggiornamento documentale minimo

v12 — 2026-05-03

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
aggiornamento prossimo nodo consigliato a NEXT NODE POST LINTING CLEANUP DA DEFINIRE

v13 — 2026-05-07

completamento PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
documentato create_suggestion_state
documentate variabili project_create_inline_open / project_create_suggestion_dismissed
documentate variabili entity_create_inline_open / entity_create_suggestion_dismissed
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
documentato ignore globale suggestion
documentato che evento non viene salvato automaticamente dopo creazione project/entity
documentato che select_project/select_entity sono decisione utente finale
documentato flow combinato project + entity validato
documentato no-match generico salvabile
documentato blocco solo su ambiguità attiva
documentate nuove query attive insert_project / insert_entity
aggiornata integrazione Supabase con insert project/entity controllato
aggiunti pattern Create Suggestion State / Inline Resource Creation / User-confirmed Insert
DB schema invariato
parser invariato
type classification invariata
duration normalization invariata
nessun output/KPI anticipato
aggiornamento prossimo nodo consigliato a NEXT NODE POST PROJECT / ENTITY CREATE SUGGESTION DA DEFINIRE

v14 — 2026-05-09

completamento UX MOBILE COHERENCE PASS
documentata Home mobile rifinita
documentata card Esempi coerente
documentate Azioni rapide rifinite e predisposte
documentata Events list mobile rifinita
documentato Feedback mobile stabilizzato
documentato feedback_summary in ui_state
documentato handle_event_success non più gestore UI post-save
documentata rimozione success handler UI duplicati da insert_event / update_event
documentato button_input_confirm come gestore centrale feedback/routing
documentato insert reale → feedback 1800 ms → Home
documentato update reale → feedback 1800 ms → Lista eventi
documentato no-op edit → Lista eventi immediata senza update_event
documentato cancel create/input → Home
documentato cancel edit → Lista eventi
documentata Navigation dock Home / Eventi / Dashboard
documentata Dashboard presente ma disabilitata
documentata nav contestuale Home/Events
documentata nav nascosta durante input attivo e feedback
documentati Dati evento compatti con label inline nelle select
documentati Icon add-ons Retool nei pulsanti reali
documentato font-size input/select 16px per Safari iOS
documentato zoom automatico iOS Safari risolto
documentate select mobile funzionanti sia in digitazione sia in dropdown
documentata validazione reale iPhone 13 Safari
DB invariato
parser invariato
matching invariato
create_suggestion_state invariato
type classification invariata
duration normalization invariata
nessun output/KPI anticipato
aggiornamento prossimo nodo consigliato a NEXT NODE POST UX MOBILE COHERENCE PASS DA DEFINIRE

v15 — 2026-05-13

completamento COMMAND INTENT — CREATE PROJECT / ENTITY
documentato command_intent_state come query Retool page-level
documentato container_command_intent
documentati input_command_project_name / input_command_entity_name
documentati btn_command_create_project / btn_command_create_entity / btn_command_go_events
documentato comando generico “crea”
documentato create project incompleto
documentato create project completo
documentato create entity incompleto
documentato create entity completo
documentati sinonimi base crea / aggiungi / inserisci / nuovo / nuova
documentato elemento già presente
documentato “crea progetto villa” come blocco duplicato controllato
documentata guida non operativa “modifica evento”
documentato che comandi puri non salvano eventi
documentato che project/entity da command richiedono conferma utente
documentato riuso insert_project / insert_entity
documentato feedback_mode in ui_state
documentato feedback project_created
documentato feedback entity_created
documentato feedback evento ordinario preservato
documentato feedback_resume adattato a Evento / Progetto / Entità
aggiornato trigger_parse_debounced con command_intent_state
aggiornata pipeline input con command intent
aggiunto Command Intent Flow
aggiunti pattern Command Intent State / Pure Command Exclusion / Guided Command Action
evento normale non regressivo validato
edit flow non regressivo validato
DB invariato
parser invariato
matching invariato
create_suggestion_state invariato
type classification invariata
duration normalization invariata
nessun output/KPI anticipato
documentati residui:
- rendering progressivo input evento normale
- “Da verificare” interno alla Sintesi
- input analysis model unico non implementato
aggiornato next step architetturale post Command Intent