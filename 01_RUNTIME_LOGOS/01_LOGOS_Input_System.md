# 01_LOGOS_Input_System_v06

DATA: 2026-04-30

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il comportamento operativo completo
del sistema di input LOGOS.

Il documento è utilizzato per:

- implementazione Retool
- sviluppo parsing
- gestione preview
- controllo qualità input
- normalizzazione base dei dati parsati
- allineamento preview ai dati parsati
- allineamento insert/update

------------------------------------------------
PRINCIPI FONDANTI
------------------------------------------------

1. INPUT NON BLOCCANTE

L’utente deve sempre poter inserire un evento.

---

2. SALVARE > CORREGGERE

È preferibile salvare un dato imperfetto
piuttosto che bloccare l’inserimento.

---

3. MIGLIORAMENTO PROGRESSIVO

La qualità del dato viene migliorata nel tempo,
non imposta all’ingresso.

---

4. UTENTE NON TECNICO

Il sistema deve essere comprensibile senza formazione.

---

5. SUGGERIRE ≠ DECIDERE

Il sistema suggerisce, l’utente decide.

---

6. FONTE UNICA PER IL SALVATAGGIO

I dati strutturati salvati nel DB devono derivare da:

ui_state.parsed

e non da parsing duplicato nel bottone di conferma.

------------------------------------------------
ARCHITETTURA INPUT
------------------------------------------------

COMPONENTI:

input_home
→ input utente (source of truth)

input_raw
→ derivato tecnico per parsing

trigger_parse_debounced
→ debounce del parsing

parse_input_controlled
→ parser controllato + normalization base

ui_state.parsed
→ fonte unica per preview/save/edit

label / sintesi (preview)
→ derivato UI (non persistito)
→ allineato visualmente a ui_state.parsed per amount/unit/date

---

FLOW ATTUALE:

input_home
→ sync
→ input_raw
→ trigger_parse_debounced
→ parse_input_controlled
→ ui_state.parsed
→ preview
→ conferma
→ insert_event / update_event
→ events_new refresh

---

EDIT FLOW:

evento selezionato
→ load raw_input
→ input_home
→ input_raw
→ parse_input_controlled
→ ui_state.parsed
→ preview
→ modifica utente
→ update_event
→ events_new refresh

------------------------------------------------
INPUT_HOME
------------------------------------------------

Ruolo:

- campo principale di input
- visibile all’utente
- source of truth lato UX

Caratteristiche:

- libero
- senza vincoli formali
- accetta qualsiasi testo

---

Regole:

✔ sempre modificabile  
✔ sempre attivo  
✔ non validato  
✔ non bloccante  

------------------------------------------------
INPUT_RAW
------------------------------------------------

Ruolo:

- adapter tecnico
- base per parsing
- valore sincronizzato da input_home

---

Caratteristiche:

- hidden
- derivato da input_home
- non modificato direttamente dall’utente

---

Sync:

input_home → input_raw

---

Nota:

Il precedente rischio di loop reattivo è stato ridotto tramite:

- trigger_parse_debounced
- parse_input_controlled
- ui_state.parsed come fonte unica

------------------------------------------------
TRIGGER_PARSE_DEBOUNCED
------------------------------------------------

Ruolo:

- evitare parsing per-lettera
- ridurre chiamate inutili
- stabilizzare UX
- mantenere preview reattiva senza loop critici

---

Comportamento:

input_raw aggiornato
→ attesa debounce
→ parse_input_controlled.trigger()

---

Esempio runtime:

```js
if (window.__parseTimer) {
  clearTimeout(window.__parseTimer);
}

window.__parseTimer = setTimeout(() => {
  parse_input_controlled.trigger();
}, 350);

UI_STATE.PARSED

Ruolo:

fonte unica dei dati strutturati parsati
base per preview
base per insert/update
base per edit flow

Struttura:

{
  amount: null,
  unit: null,
  event_date: null
}

ui_state completo:

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

Regole:

✔ parsed deve sempre esistere
✔ parsed non deve tornare null
✔ parsed deve contenere sempre amount/unit/event_date
✔ button_input_confirm usa parsed senza ricalcolare parsing

Relazione con preview:

✔ preview legge ui_state.parsed
✔ preview formatta amount/unit solo visualmente
✔ preview non modifica parsed
✔ preview non modifica il payload di salvataggio
✔ preview non modifica il DB

Esempio:

ui_state.parsed.amount = 1500.5
ui_state.parsed.unit = euro

preview:

1.500,50 €

DB:

amount 1500.5
unit euro

PARSING SYSTEM

FUNZIONE:

estrarre informazioni strutturate dall’input.

TIPO:

best-effort deterministico

OUTPUT:

amount
unit
event_date

⚠ label NON è output del parsing

REGOLE:

✔ parsing non blocca
✔ parsing può fallire
✔ parsing può essere parziale
✔ parsing non interpreta semanticamente l’evento
✔ parsing non classifica spesa/incasso
✔ parsing non modifica raw_input

CASI:

✔ parsing corretto
✔ parsing incompleto
✔ parsing errato

Tutti validi.

L’utente mantiene il controllo finale.

PARSING + NORMALIZATION BASE

Il parser attuale non si limita più a estrarre dati,
ma applica anche una normalizzazione base controllata.

Questa normalizzazione riguarda solo:

amount
unit
event_date preservato

Non riguarda:

label
project
entity
type
spesa/incasso
matching
hint
dashboard
KPI

Obiettivo:

rendere coerenti i dati strutturati minimi
prima di insert/update.

PARSING UNITÀ

Unità supportate:

euro
minuti
ore

RICONOSCIMENTO UNITÀ

EURO:

€
euro
eur
€20
20€
€ 20
20 euro
20 eur

TEMPO — ORE:

ora
ore
h
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

TEMPO — MINUTI:

min
minuto
minuti
30 min
30min
30 minuti
30minuti
min30

OUTPUT NORMALIZZATO UNIT:

€, euro, eur → euro

h, ora, ore → ore

min, minuto, minuti → minuti
NORMALIZZAZIONE INPUT RUNTIME

Applicata solo nel layer parsing.

Operazioni:

lowercase
trim
compressione spazi
riconoscimento simboli (€)
riconoscimento unit compatte
pulizia spazi
estrazione amount per prossimità alla unità

ESEMPI:

2h → amount 2, unit ore
1ora → amount 1, unit ore
18min → amount 18, unit minuti
€20 → amount 20, unit euro
1.500,50 euro → amount 1500.5, unit euro

IMPORTANTE:

✔ non modifica input utente
✔ non modifica raw_input
✔ usata solo per parsing interno
✔ produce dati strutturati per ui_state.parsed

GESTIONE ORARI

Formati:

HH:MM

COMPORTAMENTO:

✔ NON considerati amount
✔ NON considerati unit
✔ mantenuti come testo

ESEMPIO:

15:30 test
→ amount null
→ unit null
→ raw_input preservato
ESTRAZIONE AMOUNT

Regola:

estrarre il numero più rilevante rispetto alla unità rilevata.

STRATEGIA:

identificazione dei numeri presenti
identificazione della posizione della unità
selezione del numero con distanza minima dalla unità
conversione tramite normalizeNumberValue
se non esiste unità, amount = null

ESEMPI:

pizza 20 euro → 20
2 ore lavoro → 2
2 ore 30 → 2
villa 2 mario → null
villa 2 mario rossi 3h → 3

FORMATI SUPPORTATI:

interi
decimali con virgola
decimali con punto
migliaia italiane con punto
migliaia italiane + decimali con virgola

ESEMPI AMOUNT NORMALIZATION:

458,78 → 458.78
1,5 → 1.5
1.5 → 1.5
1.500 → 1500
1.500,50 → 1500.5
1500 → 1500

REGOLA CRITICA:

I numeri senza unità NON vengono interpretati come amount.

Esempi:

villa 2 → amount null
cliente 2026 → amount null
casa mare 2 → amount null

Motivo:

preservare numeri semantici
evitare dati quantitativi errati
ridurre errori permanenti in DB
NORMALIZE_NUMBER_VALUE

Funzione runtime utilizzata dal parser:

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
SUCCESS HANDLER PARSER

parse_input_controlled aggiorna ui_state.parsed tramite success handler.

Codice finale:

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

✔ parsed sempre strutturato
✔ nessun undefined
✔ nessun parsed null
✔ save/edit leggono dati coerenti

DATE PARSING

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
intervalli date

LABEL / SINTESI (RUNTIME)

FUNZIONE:

generare una descrizione leggibile per la preview.

TIPO:

✔ derivato runtime
✔ non persistito
✔ non strutturato
✔ visuale

INPUT:

raw_input
ui_state.parsed.amount
ui_state.parsed.unit
ui_state.parsed.event_date

COMPORTAMENTO:

rimozione amount + unit già rappresentati dal value
rimozione date già parse
normalizzazione spazi
preservazione numeri semantici
gestione compound token
formattazione visuale amount/unit

AGGIORNAMENTO PREVIEW ALIGNMENT BASE:

✔ formattazione italiana amount implementata nella sintesi
✔ euro mostrato con due decimali
✔ grouping migliaia visuale
✔ ore/minuti visualizzati coerentemente
✔ singolare/plurale unit gestito
✔ label cleaning aggiornato
✔ bug "minuti" → "uti" risolto
✔ data separata correttamente dalla descrizione
✔ highlight locale reso unit-safe

ESEMPI:

1.500,50 euro materiale
→ 1.500,50 € • materiale

1500 euro materiale
→ 1.500,00 € • materiale

18min test
→ 18 minuti • test

1ora lavoro
→ 1 ora • lavoro

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

villa 2 mario
→ villa 2 mario

IMPORTANTE:

✔ NON esiste ancora un label system separato
✔ logica applicata direttamente nella preview
✔ NON riutilizzabile come modulo indipendente
✔ NON influisce su parsing
✔ NON modifica ui_state.parsed
✔ NON salvata nel DB

⚠ logica accoppiata alla preview
⚠ non isolata come layer indipendente
⚠ preview non ancora view pura

TYPE DETECTION (BASE)

Tipi attuali:

tempo
economico
evento

Regole attuali:

tempo:

→ presenza unità tempo

economico:

→ presenza euro

evento:

→ default

IMPORTANTE:

economico NON distingue:

spesa
incasso

→ decisione utente

NON IMPLEMENTATO:

classificazione da parole chiave
benzina → spesa
acconto → incasso
pagamento → spesa
ricevuto → incasso
tipo persistito affidabile

Nota:

La type classification sarà un nodo dedicato futuro.

PREVIEW SYSTEM

FUNZIONE:

mostrare interpretazione sistema.

STRUTTURA:

MAIN:

event_date + amount + unit + label

META:

project
entity

HINT:

suggerimenti matching
suggerimenti tipo
hint durata ambigua

REGOLE:

✔ preview non blocca
✔ preview può essere parzialmente errata
✔ preview non modifica input
✔ preview non modifica DB
✔ preview legge dati parsati/normalizzati
✔ preview visualizza amount/unit/date in formato leggibile
✔ preview resta visuale

Preview = rendering di:

parsed (amount, unit, event_date)
label runtime
stato matching project/entity
hint

AGGIORNAMENTO PREVIEW ALIGNMENT BASE:

✔ amount formattato in stile italiano
✔ euro visualizzato con simbolo €
✔ euro visualizzato con due decimali
✔ migliaia visualizzate correttamente
✔ ore/minuti visualizzati coerentemente
✔ singolare/plurale unit gestito
✔ label cleaning coerente con amount/unit già rappresentati
✔ date separate correttamente dalla descrizione
✔ highlight locale non interferisce più con unità tecniche

Esempio:

Dato interno:

amount: 1500.5
unit: euro

Preview:

1.500,50 €

DB:

amount: 1500.5
unit: euro

REGOLA CRITICA:

La formattazione italiana è solo visuale.

Non modifica:

- parse_input_controlled
- ui_state.parsed
- button_input_confirm
- insert_event
- update_event
- DB

⚠ presenza logica interna
⚠ non pura view
⚠ dipendenza da più fonti
⚠ matching locale preview non unificato
⚠ hint non completamente state-driven

Preview Alignment Base:

✔ COMPLETATO

MATCHING BASE

Oggetti:

projects
entities

STRATEGIA:

includes
normalizzazione base
token matching
auto-select solo se match univoco

⚠ presenza di più sistemi di matching:

input_raw / ranking
select / deterministico
preview / detected

→ non unificati

OUTPUT:

✔ suggerimento
✔ auto-select solo se univoco

OUTPUT REALE:

project_matches
entity_matches

Fonte:

project_state.data?.matches
entity_state.data?.matches

COMPORTAMENTO:

match = 1
→ auto-select

match > 1
→ ambiguità
→ nessuna selezione

match = 0
→ nessun suggerimento

REGOLE:

✔ mai forzare selezione
✔ mai creare automaticamente
✔ utente in controllo

UX:

hint solo se input sufficiente
oppure input corto ma ambiguo
riduzione suggerimenti ridondanti

NON RISOLTO:

priority match
matching unificato
entity hierarchy
deduplicazione entità
ranking affidabile
CONFIRMA EVENTO

AZIONE:

utente conferma inserimento o modifica.

SEQUENZA ATTUALE:

lettura ui_state.parsed
costruzione payload
feedback immediato
reset input/select
insert_event / update_event
await savePromise
await events_new.trigger()
reset edit_mode se necessario

REGOLE:

✔ conferma consentita SOLO se:

entity_matches ≤ 1
project_matches ≤ 1

✔ bloccato in caso di ambiguità

✔ input comunque sempre modificabile

✔ gestione edit_mode:

true → update_event
false → insert_event

Il bottone NON ricalcola più parsing.

Fonte dati strutturata:

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
BUTTON_INPUT_CONFIRM — FLOW FINALE

Codice logico finale:

// --- INSERT / UPDATE SWITCH ---
const parsed = ui_state.value?.parsed || {
  amount: null,
  unit: null,
  event_date: null
};

const payload = {
  raw_input: input_raw.value,
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
};

const feedbackText = input_raw.value;
const feedbackProject = select_project.selectedItem?.name;

// RESET UI SUBITO
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

input_home.setValue("");
input_raw.setValue("");

select_project.clearValue();
select_entity.clearValue();

trigger_parse_debounced.cancel?.();

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

Risultato:

✔ parsing duplicato rimosso
✔ insert/update usano ui_state.parsed
✔ feedback immediato
✔ lista eventi aggiornata dopo save reale
✔ update visibile senza refresh pagina

INSERT FLOW

Trigger:

insert_event

Payload:

raw_input
amount
unit
event_date
project_id
entity_id
status: NEW
updated_at
payload: {}

Caratteristiche:

✔ insert consentito se non ci sono ambiguità bloccanti
✔ nessuna validazione DB
✔ nessuna label persistita
✔ amount coerente con ui_state.parsed
✔ unit coerente con ui_state.parsed
✔ raw_input preservato

Test validato:

1.500,50 euro test engine

DB:

amount: 1500.5
unit: euro
status: NEW
UPDATE FLOW

Trigger:

update_event

Utilizzato quando:

edit_mode = true

Payload:

raw_input
amount
unit
event_date
project_id
entity_id
updated_at

Caratteristiche:

✔ modifica eventi NEW
✔ status invariato
✔ dati aggiornati correttamente in DB
✔ lista eventi aggiornata dopo salvataggio completato

Problema risolto:

Prima:

events_new veniva aggiornato prima del completamento update_event.

Risultato:

DB corretto
lista momentaneamente vecchia
fix visibile solo dopo refresh pagina

Dopo:

await savePromise
→ await events_new.trigger()

Risultato:

✔ lista aggiornata subito
✔ nessun refresh pagina necessario

GESTIONE ERRORI

✔ errori UI gestiti tramite feedback state
✔ nessun blocco runtime
✔ parsing non blocca
✔ input resta modificabile

TIPI:

parsing error
match error
input ambiguo
save error
update error

COMPORTAMENTO:

✔ NON bloccare input
✔ NON interrompere UX inutilmente
✔ mostrare feedback implicito o toaster Retool
✔ preservare possibilità di correzione

TEST VALIDATI

PARSER / PREVIEW:

18min test                  → 18 / minuti
18 minuti test              → 18 / minuti
1ora lavoro                 → 1 / ore
1 ora lavoro                → 1 / ore
20€ materiale               → 20 / euro
villa 2 mario               → null / null
458,78 euro mangime         → 458.78 / euro
1.500 euro materiale        → 1500 / euro
1.500,50 euro materiale     → 1500.5 / euro
1.5 ore sopralluogo         → 1.5 / ore
1,5 ore sopralluogo         → 1.5 / ore
2 ore sopralluogo villa 2   → 2 / ore

INSERT:

1.500,50 euro test engine
→ amount 1500.5
→ unit euro
→ status NEW

INSERT DOPO RIMOZIONE PARSING LEGACY:

1.500,50 euro test engine 2
→ amount 1500.5
→ unit euro
→ status NEW

UPDATE:

1,5 ore test engine update
→ amount 1.5
→ unit ore
→ status NEW

UPDATE LISTA:

update_event
→ await save
→ events_new refresh
→ lista aggiornata subito

PREVIEW ALIGNMENT BASE:

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

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

4 aprile benzina 50 euro alfie allevamento aspri
→ 4 apr • 50,00 € • benzina alfie allevamento aspri

villa 2 mario
→ villa 2 mario

2 ore sopralluogo villa 2
→ 2 ore • sopralluogo villa 2

2,7 ore sviluppo sistema aspri
→ 2,7 ore • sviluppo sistema aspri

Nota:

eventuale hint "Verifica durata" resta ammesso.
La duration normalization non è stata implementata.

LIMITI ATTUALI

INPUT / PARSING:

multi-unit parsing non supportato
1 ora e 15 minuti non normalizzato
2h30 non normalizzato
2 ore 30 non convertito
giorni non supportati
settimane non supportate
date relative non supportate
parsing semantico non implementato

NORMALIZATION:

solo amount/unit base
nessuna unità canonica durata
nessuna conversione tempo
nessuna retro-normalizzazione dati storici

TYPE:

economico non distingue spesa/incasso
type non usato in modo affidabile
parole chiave non implementate

MATCHING:

matching debole
matching non unificato
più logiche parallele
no priority match
no gerarchia entity

PREVIEW:

non completamente read-only
formattazione italiana base allineata nella sintesi
contiene ancora logica label/hint
non è una view pura
label cleaning ancora embedded
hint non completamente state-driven

ARCHITETTURA:

alcuni layer ancora accoppiati
preview e matching ancora distribuiti
input system stabilizzato ma non completamente separato da tutti i layer
OBIETTIVO INPUT SYSTEM

Rendere l’input:

veloce
comprensibile
sufficientemente affidabile
non bloccante
coerente nel salvataggio
progressivamente normalizzato

NON:

perfetto
completamente automatico
semantico avanzato
decisionale
orientato a KPI prima della qualità dati

NEXT STEP CONSIGLIATI

ENGINE BASE — DURATION NORMALIZATION

Obiettivo:

1 ora e 15 minuti
2h30
2 ore 30
90 minuti
eventuale gestione giorni
definizione unità canonica durata
chiarimento rapporto tra raw_input, amount, unit e durata normalizzata

ENGINE BASE — TYPE CLASSIFICATION BASE

Obiettivo:

evento / tempo / economico
eventuale spesa/incasso
parole chiave controllate
mantenimento controllo utente

MATCH ENGINE UNIFICATION

Obiettivo:

eliminazione logiche parallele
priority match
hint state-driven
select / preview / matching coerenti

CHANGELOG

v01 — 2026-04-01

Definizione completa sistema input

v02 — 2026-04-02

Consolidamento parsing, preview, matching
Allineamento con implementazione Retool

v03 — 2026-04-04

introduzione separazione parsing / label
introduzione label system (non persistito)
aggiornamento preview (label + hint)
miglioramento UX suggerimenti

v04 — 2026-04-23

introduzione update_event
introduzione edit_mode
supporto editing eventi
refactor confirm flow (insert/update)
centralizzazione UI feedback
identificazione loop reattivo
allineamento comportamento reale sistema

v05 — 2026-04-30

completamento Normalization Layer Base
stabilizzazione ui_state.parsed
introduzione normalization amount formato italiano
introduzione normalization unit base
supporto unità compatte testuali
rimozione amount per numeri senza unità
eliminazione parsing legacy da button_input_confirm
allineamento insert/update a ui_state.parsed
validazione insert con dati normalizzati
validazione update con dati normalizzati
fix refresh lista dopo update
esplicitazione limiti: multi-unit, duration normalization, type classification

v06 — 2026-04-30

completamento PREVIEW ALIGNMENT BASE
documentato allineamento preview a ui_state.parsed
documentata formattazione italiana amount solo visuale
documentata visualizzazione euro con due decimali
documentato grouping migliaia visuale
documentata visualizzazione coerente ore/minuti
documentato singolare/plurale unit
documentato label cleaning preview aggiornato
documentata correzione bug "minuti" → "uti"
documentato separatore data/descrizione
documentato highlight unit-safe
confermato che parse_input_controlled non è stato modificato
confermato che ui_state.parsed non è stato modificato
confermato che save flow e DB restano invariati
aggiornamento prossimo nodo consigliato: ENGINE BASE — DURATION NORMALIZATION