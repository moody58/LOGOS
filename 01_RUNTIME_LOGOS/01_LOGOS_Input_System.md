# 01_LOGOS_Input_System_v08

DATA: 2026-05-01

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
- duration normalization base
- type classification base
- allineamento preview ai dati parsati
- allineamento insert/update
- salvataggio type in events.type

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

6. FONTI CONTROLLATE PER IL SALVATAGGIO

I dati strutturati salvati nel DB devono derivare da fonti runtime controllate:

- amount / unit / event_date → ui_state.parsed
- type → select1.value
- project_id → select_project.value
- entity_id → select_entity.value

Il bottone di conferma NON deve ricalcolare parsing.

Deve solo costruire il payload usando lo stato già disponibile.

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
→ parser controllato + normalization base + duration normalization base

ui_state.parsed
→ fonte unica per preview/save/edit

select1
→ fonte runtime per type classification base
→ valore salvato in events.type

label / sintesi (preview)
→ derivato UI (non persistito)
→ allineato visualmente a ui_state.parsed per amount/unit/date
→ mostra durata normalizzata in forma umana + hint tecnico
→ mostra/supporta type tramite select1

---

FLOW ATTUALE:

input_home
→ sync
→ input_raw
→ trigger_parse_debounced
→ parse_input_controlled
→ ui_state.parsed
→ select1 / type classification base
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
→ select1 / type classification base
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
✔ parsed.unit alimenta select1 per la classificazione Tempo

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

Nota:

ui_state.parsed NON contiene type.

Il type viene gestito da select1.value e salvato nel DB tramite payload.type.

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
✔ parsing non classifica direttamente spesa/incasso
✔ parsing fornisce però unit utili alla type classification base
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

Questa normalizzazione riguarda:

amount
unit
event_date preservato
durate certe ore/minuti normalizzate in minuti

La Duration Normalization Base è parte del parsing controllato.

Regola:

tutte le durate certe espresse in ore/minuti vengono convertite in minuti.

Esempio:

1 ora e 15 minuti
→ amount 75
→ unit minuti

2h30
→ amount 150
→ unit minuti

raw_input resta sempre preservato.

Non riguarda direttamente:

label
project
entity
spesa/incasso
matching
hint
dashboard
KPI

Nota:

type classification base usa ui_state.parsed.unit come segnale,
ma resta gestita da select1, non dal parser.

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

h, ora, ore, min, minuto, minuti → minuti

Regola durata:

le unità tempo riconosciute vengono convertite in unità canonica "minuti".

Esempi:

1 ora → amount 60, unit minuti
2 ore → amount 120, unit minuti
1,5 ore → amount 90, unit minuti
18 minuti → amount 18, unit minuti
2h30 → amount 150, unit minuti

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

2h → amount 120, unit minuti
1ora → amount 60, unit minuti
18min → amount 18, unit minuti
1,5 ore → amount 90, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
2h30 → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti
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

pizza 20 euro → 20 / euro
2 ore lavoro → 120 / minuti
2 ore 30 → 150 / minuti
1 ora e 15 minuti → 75 / minuti
2h30 rendering → 150 / minuti
villa 2 mario → null / null
villa 2 mario rossi 3h → 180 / minuti

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

------------------------------------------------
DURATION NORMALIZATION BASE
------------------------------------------------

La Duration Normalization Base è stata implementata nel parser controllato.

Decisione:

- amount tempo = totale minuti
- unit tempo = minuti
- raw_input preservato
- nessuna modifica schema DB
- nessun payload duration
- nessun campo duration_minutes dedicato

------------------------------------------------
UNITÀ CANONICA TEMPO
------------------------------------------------

Unità canonica:

minuti

Motivo:

- rende i dati confrontabili
- evita mix tra ore e minuti
- facilita dashboard/report futuri
- permette somma diretta delle durate
- mantiene raw_input come fonte originaria

------------------------------------------------
CASI SUPPORTATI
------------------------------------------------

Minuti semplici:

18 minuti → amount 18, unit minuti
18min → amount 18, unit minuti
min30 → amount 30, unit minuti
90 minuti → amount 90, unit minuti

Ore semplici:

1 ora → amount 60, unit minuti
1ora → amount 60, unit minuti
2 ore → amount 120, unit minuti
2h → amount 120, unit minuti
h2 → amount 120, unit minuti

Ore decimali:

1,5 ore → amount 90, unit minuti
1.5 ore → amount 90, unit minuti
1,5h → amount 90, unit minuti
1.5h → amount 90, unit minuti

Durate composte:

1 ora e 15 minuti → amount 75, unit minuti
1 ora 15 minuti → amount 75, unit minuti
2 ore e 30 minuti → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti
2h30 → amount 150, unit minuti
2 h 30 → amount 150, unit minuti

------------------------------------------------
CASI NON CONVERTITI AUTOMATICAMENTE
------------------------------------------------

Non vengono convertiti automaticamente:

- giorni
- settimane
- giornata
- giornate
- mezza giornata
- parole numeriche tipo “due ore”
- forme colloquiali tipo “un paio d’ore”
- 2h e mezza

Motivo:

questi casi introducono ambiguità operativa.

Esempio:

2 giorni

può significare:

- 48 ore
- due giornate lavorative
- due giornate evento
- due giorni di calendario
- due turni operativi

Decisione:

2 giorni rendering
→ amount null
→ unit null
→ raw_input preservato
→ preview mostra hint durata ambigua

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
visualizzazione umana della durata normalizzata
hint valore normalizzato
hint durata ambigua per giorni/settimane

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

AGGIORNAMENTO DURATION NORMALIZATION BASE:

✔ durata interna salvata in minuti
✔ preview durata mostrata in forma umana
✔ hint “Normalizzato: X minuti”
✔ hint durata ambigua per giorni/settimane
✔ rimozione dalla label della durata originale già normalizzata
✔ rimozione residui congiunzione “e/ed”

ESEMPI:

1.500,50 euro materiale
→ 1.500,50 € • materiale

1500 euro materiale
→ 1.500,00 € • materiale

18min test
→ 18 minuti • test

1ora lavoro
→ 1 ora
→ Normalizzato: 60 minuti

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

------------------------------------------------
TYPE CLASSIFICATION BASE
------------------------------------------------

La Type Classification Base è stata implementata.

Componente principale:

select1

Ruolo:

classificare l’evento in modo minimo, prudente e correggibile dall’utente.

Valori reali disponibili in select1:

- Evento
- Tempo
- Spesa
- Incasso

------------------------------------------------
REGOLE ATTUALI
------------------------------------------------

TEMPO:

parsed.unit = "minuti"
→ select1 = Tempo

Motivo:

dopo Duration Normalization,
tutte le durate certe ore/minuti vengono salvate come:

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

------------------------------------------------
SPESA
------------------------------------------------

Regola:

euro + keyword controllate di uscita
→ select1 = Spesa

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

20 euro saldo pagato
→ select1 = Spesa

------------------------------------------------
INCASSO
------------------------------------------------

Regola:

euro + keyword controllate di entrata
→ select1 = Incasso

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

------------------------------------------------
EVENTO / FALLBACK PRUDENTE
------------------------------------------------

Regola:

euro senza direzione chiara
→ select1 = Evento

segnali economici contrastanti
→ select1 = Evento

nessuna unit significativa
→ select1 = Evento

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
PRINCIPIO DI CONTROLLO UTENTE
------------------------------------------------

La classificazione automatica è solo base.

L’utente può sempre modificare manualmente select1.

La scelta manuale prevale sul default automatico
e viene salvata in events.type.

Esempi validati:

20 euro materiale
→ default Evento
→ utente seleziona Spesa
→ DB: type = Spesa

20 euro materiale
→ default Evento
→ utente seleziona Incasso
→ DB: type = Incasso

------------------------------------------------
PERSISTENZA TYPE
------------------------------------------------

Catena runtime:

select1.value
→ payload.type
→ insert_event / update_event
→ events.type

Il type viene salvato in DB.

Insert:

- salva type

Update:

- aggiorna type

Esempio:

2h30 rendering
→ select1 = Tempo
→ DB: type Tempo, amount 150, unit minuti

20 euro spesa materiale
→ select1 = Spesa
→ DB: type Spesa, amount 20, unit euro

20 euro incasso cliente
→ select1 = Incasso
→ DB: type Incasso, amount 20, unit euro

------------------------------------------------
CODICE LOGICO select1 — DEFAULT VALUE
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
LIMITI TYPE
------------------------------------------------

Non implementato:

- classificazione economica avanzata
- dizionario esteso keyword
- classificazione automatica da parole di dominio
- benzina → Spesa automatica
- materiale → Spesa automatica
- mangime → Spesa automatica
- amount firmato
- direction field
- KPI/reportistica
- retro-normalizzazione eventi storici

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
select1.value / type
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

AGGIORNAMENTO DURATION NORMALIZATION BASE:

✔ preview durata in forma umana
✔ valore tecnico normalizzato mostrato come hint
✔ giorni/settimane segnalati come durata ambigua
✔ label cleaning aggiornato per rimuovere durate composte già normalizzate

Esempio:

Dato interno:

amount: 150
unit: minuti

raw_input:

2h30 rendering

Preview:

2 ore 30 minuti • rendering
Normalizzato: 150 minuti

DB:

amount: 150
unit: minuti

AGGIORNAMENTO TYPE CLASSIFICATION BASE:

✔ select1 allineato a ui_state.parsed.unit
✔ parsed.unit = minuti → Tempo
✔ euro + keyword controllate → Spesa / Incasso
✔ euro senza direzione chiara → Evento
✔ scelta manuale utente preservata
✔ type persistito nel DB tramite confirm

Esempio:

2h30 rendering
→ preview durata: 2 ore 30 minuti
→ select1: Tempo
→ DB: type Tempo, amount 150, unit minuti

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

CONFERMA EVENTO

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
  type: select1.value || "Evento",
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
  type: select1.value || "Evento",
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
✔ insert/update salvano type da select1.value
✔ feedback immediato
✔ lista eventi aggiornata dopo save reale
✔ update visibile senza refresh pagina

INSERT FLOW

Trigger:

insert_event

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

Caratteristiche:

✔ insert consentito se non ci sono ambiguità bloccanti
✔ nessuna validazione DB
✔ nessuna label persistita
✔ amount coerente con ui_state.parsed
✔ unit coerente con ui_state.parsed
✔ raw_input preservato
✔ type salvato in events.type

Test validati:

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

UPDATE FLOW

Trigger:

update_event

Utilizzato quando:

edit_mode = true

Payload:

raw_input
type
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
✔ type aggiornato correttamente in DB
✔ lista eventi aggiornata dopo salvataggio completato

Test validato:

Evento precedente senza type valorizzato
modificato in:

1 ora e 45 minuti lavoro

DB:

type Tempo
amount 105
unit minuti
raw_input aggiornato
updated_at aggiornato
status NEW

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

18min test
→ parsed: amount 18, unit minuti
→ preview: 18 minuti • test

18 minuti test
→ parsed: amount 18, unit minuti
→ preview: 18 minuti • test

1ora lavoro
→ parsed: amount 60, unit minuti
→ preview: 1 ora
→ hint: Normalizzato: 60 minuti

1 ora lavoro
→ parsed: amount 60, unit minuti
→ preview: 1 ora • lavoro
→ hint: Normalizzato: 60 minuti

2 ore sopralluogo villa 2
→ parsed: amount 120, unit minuti
→ preview: 2 ore • sopralluogo villa 2
→ hint: Normalizzato: 120 minuti

1,5 ore sopralluogo
→ parsed: amount 90, unit minuti
→ preview: 1 ora 30 minuti • sopralluogo
→ hint: Normalizzato: 90 minuti

1.5 ore sopralluogo
→ parsed: amount 90, unit minuti
→ preview: 1 ora 30 minuti • sopralluogo
→ hint: Normalizzato: 90 minuti

1 ora e 15 minuti sopralluogo
→ parsed: amount 75, unit minuti
→ preview: 1 ora 15 minuti • sopralluogo
→ hint: Normalizzato: 75 minuti

2h30 rendering
→ parsed: amount 150, unit minuti
→ preview: 2 ore 30 minuti • rendering
→ hint: Normalizzato: 150 minuti

2 h 30 rendering
→ parsed: amount 150, unit minuti
→ preview: 2 ore 30 minuti • rendering
→ hint: Normalizzato: 150 minuti

2 ore 30 rendering
→ parsed: amount 150, unit minuti
→ preview: 2 ore 30 minuti • rendering
→ hint: Normalizzato: 150 minuti

90 minuti rendering
→ parsed: amount 90, unit minuti
→ preview: 90 minuti • rendering

20€ materiale
→ parsed: amount 20, unit euro

villa 2 mario
→ parsed: amount null, unit null
→ preview: villa 2 mario

458,78 euro mangime
→ parsed: amount 458.78, unit euro

1.500 euro materiale
→ parsed: amount 1500, unit euro

1.500,50 euro materiale
→ parsed: amount 1500.5, unit euro

2 giorni rendering
→ parsed: amount null, unit null
→ preview: 2 giorni rendering
→ hint: Durata ambigua

1 settimana lavoro
→ parsed: amount null, unit null
→ preview: 1 settimana lavoro
→ hint: Durata ambigua

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

DURATION NORMALIZATION — INSERT:

1 ora e 15 minuti test duration
→ amount 75
→ unit minuti
→ raw_input preservato
→ status NEW

2h30 test duration
→ amount 150
→ unit minuti
→ raw_input preservato
→ status NEW

1,5 ore test duration
→ amount 90
→ unit minuti
→ raw_input preservato
→ status NEW

2 giorni test duration
→ amount null
→ unit null
→ raw_input preservato
→ status NEW

DURATION NORMALIZATION — UPDATE:

2 ore e 30 minuti test duration update
→ amount 150
→ unit minuti
→ raw_input aggiornato
→ status NEW

1 ora e 45 minuti regressione finale update
→ amount 105
→ unit minuti
→ raw_input aggiornato
→ status NEW

DURATION NORMALIZATION — REGRESSIONI:

30 euro regressione finale
→ amount 30
→ unit euro
→ status NEW

villa 2 test duration
→ amount null
→ unit null
→ raw_input preservato
→ status NEW

TYPE CLASSIFICATION BASE — ANTEPRIMA:

2h30 rendering
→ select1 Tempo

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

TYPE CLASSIFICATION BASE — INSERT DB:

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

TYPE CLASSIFICATION BASE — UPDATE DB:

1 ora e 45 minuti lavoro
→ type Tempo
→ amount 105
→ unit minuti
→ updated_at aggiornato

TYPE CLASSIFICATION BASE — OVERRIDE MANUALE:

20 euro materiale + select1 manuale Spesa
→ DB type Spesa

20 euro materiale + select1 manuale Incasso
→ DB type Incasso

TYPE CLASSIFICATION BASE — RESET / STALE VALUE:

20 euro materiale
→ select1 manuale Spesa
→ conferma
→ nuovo input villa 2 mario
→ select1 Evento

Esito:

nessuna modifica necessaria al reset select1.

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

giorni non convertiti automaticamente
settimane non convertite automaticamente
giornata / mezza giornata non normalizzate
parole numeriche tipo “due ore” non supportate
forme colloquiali tipo “un paio d’ore” non supportate
2h e mezza non supportato
date relative non supportate
parsing semantico non implementato

NORMALIZATION:

amount/unit base implementati
unità canonica tempo = minuti
conversione ore/minuti implementata
giorni/settimane non convertiti automaticamente
nessuna retro-normalizzazione dati storici
nessun payload duration
nessun campo duration_minutes dedicato

TYPE:

type classification base implementata
Tempo / Spesa / Incasso / Evento persistiti in events.type
spesa/incasso riconosciuti solo tramite keyword controllate o scelta manuale
euro senza direzione chiara resta Evento
amount firmato non implementato
direction field non implementato
classificazione economica avanzata non implementata
parole di dominio non usate come classificazione automatica
type non ancora sufficiente da solo per KPI avanzati
eventi storici non retro-normalizzati

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

MATCH ENGINE UNIFICATION

Obiettivo:

eliminazione logiche parallele
priority match
hint state-driven
select / preview / matching coerenti
riduzione incoerenze project/entity

LINTING / STATE HELPER CLEANUP

Obiettivo:

risolvere linting residui Retool:

- edit_mode: 'value' is not defined
- editing_event: 'value' is not defined

ECONOMIC DIRECTION ADVANCED

Obiettivo futuro non attivo:

valutare amount firmato
valutare direction field
valutare regole contabili avanzate Spesa/Incasso

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
aggiornamento prossimo nodo consigliato: ENGINE BASE — TYPE CLASSIFICATION BASE

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
aggiornamento prossimo nodo consigliato: MATCH ENGINE UNIFICATION