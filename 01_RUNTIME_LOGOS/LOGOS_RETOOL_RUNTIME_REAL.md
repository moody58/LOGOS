# LOGOS_RETOOL_RUNTIME_REAL_v11

DATA: 2026-05-09

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

------------------------------------------------
DESCRIZIONE OPERATIVA DEL SISTEMA
------------------------------------------------

Il sistema LOGOS è un Event Operating System client-side
in cui tutta la logica applicativa è gestita in Retool tramite JavaScript.

Supabase funge da storage layer passivo.

Flusso attuale:

INPUT  
→ PARSING CONTROLLED  
→ NORMALIZATION BASE  
→ DURATION NORMALIZATION  
→ TYPE CLASSIFICATION BASE  
→ MATCH STATE  
→ CREATE SUGGESTION STATE  
→ SELECT PROJECT / ENTITY  
→ PREVIEW / SINTESI  
→ DATI EVENTO  
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

Query/script:

trigger_parse_debounced

Ruolo:

- evitare parsing per-lettera
- ridurre trigger inutili
- stabilizzare la UX
- prevenire loop reattivo critico input → parsing → UI

Codice runtime:

if (window.__parseTimer) {
  clearTimeout(window.__parseTimer);
}

window.__parseTimer = setTimeout(async () => {
  project_create_inline_open.setValue(false);
  project_create_suggestion_dismissed.setValue(false);
  input_new_project_name.setValue("");

  entity_create_inline_open.setValue(false);
  entity_create_suggestion_dismissed.setValue(false);
  input_new_entity_name.setValue("");

  await Promise.allSettled([
    parse_input_controlled.trigger(),
    project_state.trigger(),
    entity_state.trigger()
  ]);

  await create_suggestion_state.trigger();
}, 350);

Comportamento:

input_raw aggiornato
→ debounce
→ reset micro-state creazione inline
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
- select_project.value / select_entity.value = project_id / entity_id
- ui_state.feedback_summary = riepilogo temporaneo feedback

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

PARSING CONTROLLED + NORMALIZATION BASE + DURATION NORMALIZATION

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
- creazione guidata project/entity
- ranking avanzato
- match engine separato come modulo autonomo

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

Costruita da:

input_raw
ui_state.parsed
select_project
select_entity
project_state
entity_state
select1
liste projects/entities

Nota:

select1 alimenta il type visuale e il payload di salvataggio.
La preview può mostrare/supportare il type,
ma non salva direttamente il dato.

MAIN:

event_date + amount + unit + label

META:

project + entity

HINT:

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
✔ mostra hint “Normalizzato: X minuti”
✔ mostra hint durata ambigua per giorni/settimane
✔ separa correttamente data e descrizione
✔ applica label cleaning sui casi già normalizzati
✔ highlight locale reso unit-safe

Limiti:

⚠ contiene logiche di trasformazione
⚠ contiene label cleaning
⚠ contiene hint logic
⚠ utilizza fonti multiple
⚠ non è view pura
✔ matching project/entity letto da project_state/entity_state
✔ hint ambiguità matching alimentati da isAmbiguous
✔ highlight alimentato da matches
✔ detection locale preview non più fonte decisionale matching

⚠ preview resta layer ibrido
⚠ hint duration/type ancora embedded nella preview

VALUE BUILDER:

Il value builder della sintesi costruisce il valore visuale partendo da ui_state.parsed.

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
- project_state.isAmbiguous = true e select_project vuoto
- entity_state.isAmbiguous = true e select_entity vuoto

Conferma abilitata se:

- match univoco
- nessun match
- ambiguità risolta manualmente

Il bottone non ricalcola matching.
Legge solo lo stato già disponibile.

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
✔ handle_event_success non più gestore UI post-save
✔ insert_event/update_event non devono avere success handler UI duplicati
✔ routing post-save contestuale
✔ insert reale → feedback 1800 ms → Home
✔ update reale → feedback 1800 ms → Lista eventi
✔ no-op edit → Lista eventi immediata senza feedback

BUTTON_INPUT_CONFIRM — DISABLED LOGIC

Codice runtime:

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

Decisione:

- ambiguità non risolta → blocco
- ambiguità risolta manualmente → conferma consentita
- nessun match → conferma consentita

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

HELPER TECNICI WINDOW:

window.__logos_edit_mode_value
window.__logos_editing_event_value
window.__logos_feedback_timer

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

Nota:

select1 è un componente UI Select di Retool,
non una query.
Il suo Default value contiene la logica Type Classification Base.
Il valore runtime select1.value viene letto da button_input_confirm
e salvato come payload.type.

Nota:

select_project e select_entity non ricalcolano più matching.
Leggono singleMatch da project_state/entity_state.

INPUT / PARSING:

trigger_parse_debounced
parse_input_controlled

LEGACY / DEBITO:

typing_state non è più fonte principale del parsing
parse_input non è più fonte di verità se ancora presente
button_input_confirm non deve contenere parsing duplicato

SUPABASE

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
decide Dashboard/KPI

Nota:

Supabase riceve events.type già determinato lato Retool.
Il DB non decide e non corregge il type.
insert_project / insert_entity vengono eseguiti solo da azione esplicita utente.
La creazione project/entity non salva automaticamente l’evento.

LIMITI ATTUALI

INPUT:

nessun parsing semantico
date relative non supportate
giorni/settimane non convertiti automaticamente
giornata / mezza giornata non normalizzate
parole numeriche tipo “due ore” non supportate
forme colloquiali tipo “un paio d’ore” non supportatei

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
nessun ranking avanzato

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
hint duration/type ancora embedded
UX mobile base completata
Cambia / Scegli nella Sintesi ancora non cliccabili
Azioni rapide presenti ma non operative
Dashboard presente in nav ma disabilitata
Icon System non completamente standardizzato

ARCHITETTURA:

accoppiamento preview / label / hint
matching project/entity allineato a primo livello
hint matching project/entity state-driven
preview ancora ibrida
feedback/routing centralizzati in button_input_confirm
navigation dock contestuale implementata
Mobile Safari font-size 16px baseline consolidata

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

Debiti:

⚠ giorni/settimane durata non convertiti automaticamente
⚠ type classification avanzata da definire
⚠ economic direction advanced non implementata
⚠ match engine avanzato separato non implementato
⚠ alias / gerarchie / deduplicazione non implementati
✔ creazione guidata project/entity implementata a primo livello controllato
⚠ suggestion create vs edit consistency da verificare
⚠ project creation override con match generico non implementato
⚠ preview ancora non view pura
⚠ output non attivo
⚠ Azioni rapide non operative
⚠ Dashboard non implementata
⚠ Icon System non completamente standardizzato

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
- creazione guidata project/entity non implementata
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