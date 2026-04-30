# 04_LOGOS_Retool_Architecture_v08

DATA: 2026-04-30

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- struttura UI completa  
- flow input → parsing → normalization → preview → insert/update documentato  
- query e componenti allineati al runtime reale  
- ui_state.parsed documentato come fonte unica  
- confirm flow aggiornato  
- refresh lista dopo save documentato  
- preview alignment documentato  
- duration normalization documentata   

Q (Qualità): 9.5/10  
- architettura reale documentata  
- distinzione chiara tra parsing, normalization base, preview, matching e save  
- preview visualmente allineata ai dati normalizzati  
- durate certe ore/minuti normalizzate in minuti   
- debiti residui esplicitati  
- non introduce modello ideale non implementato  

D (Deployabilità): 10/10  
- utilizzabile come riferimento tecnico reale  
- coerente con implementazione Retool attuale  
- utile per ricostruzione runtime  
- nodo Preview Alignment Base validato runtime  
- nodo Duration Normalization validato runtime   

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
- preview alignment base
- insert/update flow
- stato UI condiviso

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
        └── container_events_list  

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
  feedback_text: null,
  feedback_project: null
}

Ruolo:

controllare la vista attiva
conservare dati parsati
mantenere feedback post-save
supportare create/edit
fornire fonte unica per insert/update

Binding principali:

container_home:
Hidden = view === "feedback"

container_feedback:
Hidden = view !== "feedback"

container_input:
Hidden = !input_home.value

Principio:

UI = funzione dello stato

Stato dati:

ui_state.parsed è la fonte unica runtime per:

amount
unit
event_date

Usato da:

preview
button_input_confirm
insert_event
update_event

Nota:

ui_state.parsed deve restare sempre strutturato:

{
  amount: null,
  unit: null,
  event_date: null
}

e non deve tornare null.

CONTAINER HOME

Componenti:

input_home
container_esempi
container_suggerimenti
container_attivita

Funzione:

punto ingresso sistema
input principale
esperienza utente non bloccante

INPUT:

campo libero

SUGGERIMENTI:

registra spesa
registra incasso
registra tempo
registra evento

Nota:

i suggerimenti restano UX helper,
non modificano il modello dati.

CONTAINER INPUT

Componenti:

input_raw (hidden)
sintesi (preview)
select1 (type)
select_project
select_entity
button_input_confirm

Funzione:

preview dati
validazione manuale
selezione project/entity
conferma inserimento o modifica

Preview:

MAIN:

event_date + amount + unit + label

HINT:

basati su stato matching
basati su condizioni locali preview
non completamente state-driven

Esempi:

entity_matches > 1 → "Seleziona entità"
project_matches > 1 → "Seleziona progetto"

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
⚠ matching locale preview non unificato
⚠ hint non completamente state-driven

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

INPUT FLOW

Flow attuale:

input_home
→ input_raw
→ trigger_parse_debounced
→ parse_input_controlled
→ ui_state.parsed
→ preview / save / edit

input_home:

source of truth lato UX
campo modificato dall’utente

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

Principio:

input_home = fonte UX
ui_state.parsed = fonte dati strutturati

Risultato:

✔ ridotto loop reattivo critico
✔ parsing non duplicato nel save
✔ create/edit più coerenti
✔ input e salvataggio allineati
✔ durate certe ore/minuti normalizzate in minuti
✔ raw_input durata preservato

TRIGGER_PARSE_DEBOUNCED

Tipo:

JS Query / script runtime

Funzione:

cancellare timer precedente
attendere debounce
lanciare parse_input_controlled

Codice runtime:

if (window.__parseTimer) {
  clearTimeout(window.__parseTimer);
}

window.__parseTimer = setTimeout(() => {
  parse_input_controlled.trigger();
}, 350);

Nota:

Il debounce permette preview reattiva
senza parsing continuo a ogni singolo carattere.

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
⚠ type classification non consolidata

MATCHING FLOW

Eseguito tramite:

project_state
entity_state
select_project
select_entity
logiche locali preview

OUTPUT:

project_state.data?.matches
entity_state.data?.matches

LOGICA GENERALE:

match = 1
→ auto-select

match > 1
→ ambiguità
→ nessuna selezione

match = 0
→ nessun suggerimento

Caratteristiche:

✔ matching osservabile tramite state
✔ auto-select solo se match univoco
✔ utente mantiene controllo

⚠ presenza di più logiche di matching non unificate
⚠ possibili incoerenze tra preview e select
⚠ priority match non implementato
⚠ entity hierarchy non implementata

TYPE DETECTION

Componente:

select1

Logica attuale:

Tempo → presenza unità tempo
Economico → presenza euro
Evento → default

Nota:

rimosso fallback aggressivo su "h"
evitati falsi positivi tipo "macchina"
economico non distingue spesa/incasso
type non è ancora un dato affidabile per output/KPI

Nota post Duration Normalization:

le durate certe vengono ora salvate con:

unit = minuti

La logica select1/type non è ancora pienamente allineata a questa evoluzione.

Esempio osservato:

2h30 rendering
→ parsed.amount = 150
→ parsed.unit = minuti
→ select1 può restare Evento

Questo è fuori scope nel nodo Duration Normalization
e diventa tema del nodo TYPE CLASSIFICATION BASE.

NON IMPLEMENTATO:

classificazione spesa/incasso
parole chiave controllate
type engine
persistenza type pienamente affidabile

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
visualizzare amount/unit/label/project/entity/hint

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

⚠ contiene logiche di trasformazione
⚠ contiene label cleaning
⚠ contiene hint logic
⚠ non è ancora view pura
⚠ utilizza fonti multiple
⚠ matching locale preview non unificato

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

questo filtro agisce solo sull'highlight locale della preview.
Non modifica project_state, entity_state, select_project o select_entity.

CONFIRM FLOW

Componente:

button_input_confirm

Ruolo:

confermare inserimento
confermare modifica evento NEW
costruire payload da ui_state.parsed
lanciare insert_event o update_event
aggiornare feedback e lista

Sequenza attuale:

legge ui_state.parsed
costruisce payload
salva feedbackText / feedbackProject
mostra feedback subito
resetta input/select
cancella debounce pending
determina wasEditMode
esegue insert_event o update_event
attende savePromise
aggiorna events_new
resetta edit_mode se necessario

EDIT MODE:

edit_mode = true → update_event
edit_mode = false → insert_event

VINCOLI:

✔ conferma bloccata se:

entity_matches > 1
project_matches > 1

✔ nessuna ambiguità consentita in insert/update

Principio:

button_input_confirm NON esegue parsing.

Il parsing legacy è stato rimosso.

Fonte unica:

const parsed = ui_state.value?.parsed || {
  amount: null,
  unit: null,
  event_date: null
};

Payload:

const payload = {
  raw_input: input_raw.value,
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
};

Reset UI:

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

Save / refresh:

const wasEditMode = edit_mode.data;

const savePromise = wasEditMode
  ? update_event.trigger({ additionalScope: payload })
  : insert_event.trigger({ additionalScope: payload });

await savePromise;

await events_new.trigger();

if (wasEditMode) {
  edit_mode.trigger({
    additionalScope: { value: false }
  });
}

Risultati:

✔ parsing duplicato eliminato
✔ insert/update coerenti
✔ feedback immediato
✔ lista aggiornata dopo salvataggio reale
✔ update visibile senza refresh pagina

INSERT_EVENT

Tipo:

REST Query Supabase

Uso:

inserimento nuovo evento
status iniziale NEW

Body:

JSON.stringify({
  raw_input: raw_input,
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
amount
unit
event_date
project_id
entity_id
status
updated_at
payload

Validato:

1.500,50 euro test engine
→ amount 1500.5
→ unit euro
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

Fix recente:

events_new non viene più aggiornato prima del completamento update_event.

Nuovo ordine:

await savePromise
→ await events_new.trigger()

Risultato:

✔ lista aggiornata subito
✔ nessun refresh pagina necessario

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

QUERY ATTIVE

GLOBAL:

projects_list
entities_list

PAGE1 — INPUT / PARSING:

trigger_parse_debounced
parse_input_controlled

PAGE1 — DATA / MATCHING:

project_state
entity_state

PAGE1 — EVENTI:

insert_event
update_event
events_new
update_written
update_error

PAGE1 — STATE / UI:

ui_state
edit_mode
focus_input_home
handle_event_success

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
classifica spesa/incasso
PATTERN ARCHITETTURALI

✔ Adapter Pattern (input_raw)
✔ State-driven UI
✔ Client-side logic
✔ Append-only controllato (editing su NEW)
✔ Single Source of Truth per dati strutturati: ui_state.parsed
✔ Async save con refresh lista post-save
✔ Progressive enhancement

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

UI:

⚠ input non multilinea
⚠ preview migliorabile come architettura
⚠ preview non pura
⚠ label cleaning ancora embedded
⚠ hint non completamente state-driven

✔ formattazione italiana amount allineata nella sintesi

DATA:

⚠ nessuna gerarchia entity
⚠ dati storici non retro-normalizzati
⚠ payload non usato

TYPE:

⚠ nessuna distinzione spesa/incasso
⚠ type non pienamente affidabile

ARCHITETTURA:

⚠ accoppiamento preview / label / hint
⚠ matching non unificato
⚠ hint non completamente state-driven
⚠ giorni/settimane non convertiti automaticamente
⚠ type detection non pienamente allineata a unit = minuti

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
✔ durate certe ore/minuti salvate in minuti
✔ preview durata in forma umana
✔ amount/unit/date visualizzati coerentemente
✔ label pipeline stabile
✔ UX migliorata

⚠ non completamente stabile nei layer evolutivi
⚠ preview ancora ibrida
⚠ matching funzionale ma non unificato
⚠ type classification debole
⚠ giorni/settimane non convertiti automaticamente
⚠ type classification da allineare alla durata normalizzata
⚠ output non attivo

NEXT STEP ARCHITETTURALE CONSIGLIATO

ENGINE BASE — TYPE CLASSIFICATION BASE

Obiettivo:

definire e implementare, se coerente, il primo livello controllato
di classificazione evento.

Casi target:

- tempo se parsed.unit = minuti
- economico se parsed.unit = euro
- evento come default controllato
- verifica select1 su input tipo 2h30 rendering
- valutazione spesa/incasso solo come decisione separata e controllata

Ammesso:

- analisi comportamento attuale select1
- allineamento minimo con ui_state.parsed
- uso di parsed.unit come segnale controllato
- mantenimento selezione manuale utente
- test runtime su preview/save

Vietato nel prossimo nodo:

- dashboard/KPI
- match engine unification
- refactor globale parser
- refactor globale preview
- modifica schema DB non motivata
- parole chiave economiche aggressive
- automazioni decisionali definitive
- retro-normalizzazione storico

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