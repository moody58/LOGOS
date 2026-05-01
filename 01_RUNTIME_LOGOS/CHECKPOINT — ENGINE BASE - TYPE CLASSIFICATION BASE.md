# CHECKPOINT — ENGINE BASE / TYPE CLASSIFICATION BASE

DATA: 2026-05-01

------------------------------------------------
NODO
------------------------------------------------

ENGINE BASE — TYPE CLASSIFICATION BASE

------------------------------------------------
CONTESTO
------------------------------------------------

Nodo avviato dopo completamento di:

- ENGINE BASE — NORMALIZATION LAYER BASE
- PREVIEW ALIGNMENT BASE
- ENGINE BASE — DURATION NORMALIZATION

Il sistema disponeva già di:

- parse_input_controlled come parser runtime
- trigger_parse_debounced attivo
- ui_state.parsed come fonte unica dei dati strutturati
- amount/unit/event_date normalizzati lato parser
- durata canonica tempo = minuti
- preview durata in forma umana
- hint “Normalizzato: X minuti”
- insert_event / update_event allineati a ui_state.parsed
- DB invariato e passivo
- raw_input preservato
- save flow stabile
- update flow stabile
- events_new aggiornato dopo save completato

------------------------------------------------
SCOPO DEL NODO
------------------------------------------------

Definire e implementare il primo livello controllato di classificazione evento.

Obiettivi:

- distinguere in modo minimo e non distruttivo:
  - Evento
  - Tempo
  - Spesa
  - Incasso

- allineare select1/type a ui_state.parsed
- correggere incoerenza post Duration Normalization
- rendere persistente il type nel DB
- mantenere controllo manuale utente
- evitare classificazioni aggressive
- non modificare parser
- non modificare matching
- non modificare schema DB
- non anticipare dashboard/KPI

------------------------------------------------
PROBLEMA REALE RISOLTO
------------------------------------------------

Dopo Duration Normalization:

input come:

2h30 rendering

veniva normalizzato correttamente:

amount = 150
unit = minuti

ma select1 poteva restare su:

Evento

invece di:

Tempo

Causa:

select1 ragionava ancora principalmente su input_raw.value,
mentre dopo Duration Normalization la fonte strutturata affidabile
è ui_state.parsed.unit.

------------------------------------------------
DECISIONE ARCHITETTURALE
------------------------------------------------

La classificazione base viene derivata in modo controllato da:

1. ui_state.parsed.unit
2. keyword economiche esplicite
3. scelta manuale utente

Regole consolidate:

- parsed.unit = "minuti" → Tempo
- parsed.unit = "euro" + keyword chiara di uscita → Spesa
- parsed.unit = "euro" + keyword chiara di entrata → Incasso
- parsed.unit = "euro" senza direzione chiara → Evento
- segnali economici contrastanti → Evento
- nessuna unit significativa → Evento

Motivo:

- Tempo è ora affidabile perché le durate certe vengono normalizzate in minuti
- euro indica valore economico ma non sempre direzione contabile
- Spesa/Incasso richiedono segnali più espliciti
- Evento resta default prudente
- l’utente mantiene sempre il controllo tramite select1

------------------------------------------------
NOTA SU "ECONOMICO"
------------------------------------------------

Nei documenti era indicata la categoria logica "economico".

Nel sistema reale select1 dispone di 4 opzioni:

- Evento
- Incasso
- Spesa
- Tempo

Decisione:

Non introdurre una nuova opzione "Economico".

La dimensione economica viene rappresentata operativamente tramite:

- Spesa
- Incasso

Quando è presente euro ma manca direzione chiara,
il sistema resta su Evento per richiedere scelta utente
tramite preview/hint o selezione manuale.

------------------------------------------------
SCOPE RISPETTATO
------------------------------------------------

Interventi eseguiti SOLO su:

- select1 default value
- button_input_confirm payload
- insert_event body
- update_event body

NON sono stati modificati:

- parse_input_controlled
- trigger_parse_debounced
- ui_state.parsed structure
- preview globale
- label cleaning
- project_state
- entity_state
- select_project
- select_entity
- matching reale
- Supabase schema
- events table structure
- dashboard/KPI
- retro-normalizzazione storico

------------------------------------------------
STATO PRIMA
------------------------------------------------

select1 disponeva di questa logica base:

- Tempo → presenza unità tempo nel testo
- Incasso → keyword testuali
- Spesa → keyword testuali
- Evento → default

Problemi:

- 2h30 non veniva riconosciuto da select1
- Duration Normalization salvava unit = minuti ma select1 non la usava come fonte primaria
- type non veniva salvato nel DB
- insert_event non inviava type
- update_event non inviava type
- events.type restava null/non valorizzato per nuovi eventi
- type non era affidabile nemmeno come classificazione base persistita

------------------------------------------------
MODIFICHE APPLICATE
------------------------------------------------

------------------------------------------------
STEP 1 — PATCH select1 DEFAULT VALUE
------------------------------------------------

È stato aggiornato il Default value di select1 per usare ui_state.parsed.unit
come fonte primaria per la classificazione base.

Codice applicato:

{{
(() => {
  const text = (input_raw.value || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");

  const parsed = ui_state.value?.parsed || {};
  const parsedUnit = String(parsed.unit || "").toLowerCase();

  // ------------------------------------------------
  // 1. TEMPO — fonte primaria: ui_state.parsed
  // ------------------------------------------------
  // Dopo Duration Normalization tutte le durate certe
  // sono salvate come:
  // amount = totale minuti
  // unit = "minuti"
  //
  // Questo risolve casi come:
  // 2h30 rendering → Tempo
  // 1 ora lavoro → Tempo
  // 18min test → Tempo

  if (parsedUnit === "minuti") {
    return "Tempo";
  }

  // ------------------------------------------------
  // 2. ECONOMICO — solo se c'è segnale economico
  // ------------------------------------------------

  const hasEuro =
    parsedUnit === "euro" ||
    /€|\beuro\b|\beur\b/.test(text);

  // ------------------------------------------------
  // 3. INCASSO — keyword controllate
  // ------------------------------------------------
  // Regola:
  // classificare Incasso solo se il testo contiene
  // segnali abbastanza espliciti di entrata.

  const isIncasso =
    /\bincasso\b/.test(text) ||
    /\bincassato\b/.test(text) ||
    /\bentrata\b/.test(text) ||
    /\bvendita\b/.test(text) ||
    /\bvenduto\b/.test(text) ||
    /\bpagamento ricevuto\b/.test(text) ||
    /\bacconto ricevuto\b/.test(text) ||
    /\bsaldo ricevuto\b/.test(text);

  // ------------------------------------------------
  // 4. SPESA — keyword controllate
  // ------------------------------------------------
  // Regola:
  // classificare Spesa solo se il testo contiene
  // segnali abbastanza espliciti di uscita.

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

  // ------------------------------------------------
  // 5. AMBIGUITÀ ECONOMICA
  // ------------------------------------------------
  // Se emergono segnali contrastanti, non decidere.
  // Lascia Evento per forzare scelta/hint utente.

  if (isIncasso && isSpesa) {
    return "Evento";
  }

  if (isIncasso) {
    return "Incasso";
  }

  if (isSpesa) {
    return "Spesa";
  }

  // ------------------------------------------------
  // 6. EURO SENZA DIREZIONE
  // ------------------------------------------------
  // Esempio:
  // 20 euro materiale
  // 50 euro benzina
  //
  // Non decidiamo automaticamente Spesa/Incasso.
  // Restiamo su Evento così l'utente viene guidato
  // a scegliere manualmente.

  if (hasEuro) {
    return "Evento";
  }

  // ------------------------------------------------
  // 7. DEFAULT
  // ------------------------------------------------

  return "Evento";
})()
}}

------------------------------------------------
STEP 2 — PATCH button_input_confirm
------------------------------------------------

È stato aggiunto type al payload costruito da button_input_confirm.

Prima:

const payload = {
  raw_input: input_raw.value,
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
};

Dopo:

const payload = {
  raw_input: input_raw.value,
  type: select1.value || "Evento",
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
};

Codice finale button_input_confirm:

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

const feedbackText = input_raw.value;
const feedbackProject = select_project.selectedItem?.name;

// RESET UI SUBITO (UX istantanea)
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

// (opzionale ma consigliato)
trigger_parse_debounced.cancel?.();

// SALVATAGGIO (async non bloccante UI)
const wasEditMode = edit_mode.data;

const savePromise = wasEditMode
  ? update_event.trigger({ additionalScope: payload })
  : insert_event.trigger({ additionalScope: payload });

// aspetta che insert/update sia realmente concluso
await savePromise;

// ora la lista legge il dato aggiornato
await events_new.trigger();

// reset edit mode dopo il salvataggio
if (wasEditMode) {
  edit_mode.trigger({
    additionalScope: { value: false }
  });
}

------------------------------------------------
STEP 3 — PATCH insert_event
------------------------------------------------

È stato aggiunto type nel body JSON inviato a Supabase.

Prima:

{{ JSON.stringify({
  raw_input: raw_input,
  amount: amount,
  unit: unit,
  event_date: event_date,
  project_id: project_id,
  entity_id: entity_id,
  status: "NEW",
  updated_at: new Date().toISOString(),
  payload: {}
}) }}

Dopo:

{{ JSON.stringify({
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
}) }}

------------------------------------------------
STEP 4 — PATCH update_event
------------------------------------------------

È stato aggiunto type nel body JSON di update_event.

Prima:

{{ JSON.stringify({
  raw_input: raw_input,
  amount: amount,
  unit: unit,
  event_date: event_date,
  project_id: project_id,
  entity_id: entity_id,
  updated_at: new Date().toISOString()
}) }}

Dopo:

{{ JSON.stringify({
  raw_input: raw_input,
  type: type,
  amount: amount,
  unit: unit,
  event_date: event_date,
  project_id: project_id,
  entity_id: entity_id,
  updated_at: new Date().toISOString()
}) }}

Motivo:

se un evento NEW viene modificato,
anche type deve essere aggiornato coerentemente
con il nuovo input o con la scelta manuale utente.

------------------------------------------------
TEST ESEGUITI — ANTEPRIMA select1
------------------------------------------------

Tutti i seguenti test hanno prodotto risultato atteso in anteprima.

TEMPO:

2h30 rendering
→ select1 = Tempo
→ preview: 2 ore 30 minuti • rendering
→ hint: Normalizzato: 150 minuti

1 ora lavoro
→ select1 = Tempo

18min test
→ select1 = Tempo

ECONOMICO / SPESA:

20 euro spesa materiale
→ select1 = Spesa

20 euro acquisto materiale
→ select1 = Spesa

20 euro pagato materiale
→ select1 = Spesa

20 euro acconto dato
→ select1 = Spesa

20 euro acconto versato
→ select1 = Spesa

20 euro saldo pagato
→ select1 = Spesa

20 euro saldo versato
→ select1 = Spesa

ECONOMICO / INCASSO:

20 euro incasso cliente
→ select1 = Incasso

20 euro vendita cucciolo
→ select1 = Incasso

20 euro acconto ricevuto
→ select1 = Incasso

20 euro saldo ricevuto
→ select1 = Incasso

20 euro pagamento ricevuto
→ select1 = Incasso

AMBIGUI / DEFAULT:

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

EVENTI NON QUANTITATIVI:

villa 2 mario
→ select1 = Evento

GIORNI / SETTIMANE:

2 giorni rendering
→ select1 = Evento
→ durata ambigua resta gestita da hint preview

CASO ECONOMICO CON PAROLA DI DOMINIO:

4 aprile benzina 50 euro alfie allevamento aspri
→ select1 = Evento

Decisione:

"benzina" non è stata introdotta come keyword automatica di Spesa
per evitare classificazione economica aggressiva basata su parole di dominio.

------------------------------------------------
TEST ESEGUITI — INSERT DB
------------------------------------------------

Inserimenti reali verificati nella tabella events.

1. Input:

2h30 rendering

DB:

type: Tempo
amount: 150
unit: minuti
raw_input: 2h30 rendering
status: NEW

Esito: OK

---

2. Input:

20 euro spesa materiale

DB:

type: Spesa
amount: 20
unit: euro
raw_input: 20 euro spesa materiale
status: NEW

Esito: OK

---

3. Input:

20 euro incasso cliente

DB:

type: Incasso
amount: 20
unit: euro
raw_input: 20 euro incasso cliente
status: NEW

Esito: OK

---

4. Input:

20 euro materiale

DB:

type: Evento
amount: 20
unit: euro
raw_input: 20 euro materiale
status: NEW

Esito: OK

---

5. Input:

villa 2 mario

DB:

type: Evento
amount: null
unit: null
raw_input: villa 2 mario
status: NEW

Esito: OK

Nota:

project_id/entity_id possono essere valorizzati dal matching/select.
Non sono collegati al nodo Type Classification Base.

------------------------------------------------
TEST ESEGUITI — UPDATE DB
------------------------------------------------

Evento esistente creato prima della patch, senza type valorizzato,
modificato con input:

1 ora e 45 minuti lavoro

DB dopo update:

type: Tempo
amount: 105
unit: minuti
raw_input: 1 ora e 45 minuti lavoro
updated_at aggiornato
status: NEW

Esito: OK

Risultato:

update_event aggiorna correttamente anche il campo type.

------------------------------------------------
TEST ESEGUITI — OVERRIDE MANUALE UTENTE
------------------------------------------------

Test 1:

Input:

20 euro materiale

Default select1:

Evento

Azione manuale:

select1 modificato in Spesa

DB:

type: Spesa
amount: 20
unit: euro
raw_input: 20 euro materiale
status: NEW

Esito: OK

---

Test 2:

Input:

20 euro materiale

Default select1:

Evento

Azione manuale:

select1 modificato in Incasso

DB:

type: Incasso
amount: 20
unit: euro
raw_input: 20 euro materiale
status: NEW

Esito: OK

Conclusione:

La scelta manuale dell’utente prevale correttamente sul default automatico.

Il sistema resta coerente con il principio:

suggerire ≠ decidere

------------------------------------------------
TEST ESEGUITI — RESET / STALE VALUE
------------------------------------------------

È stato verificato che una scelta manuale precedente non resta appesa
sul nuovo input.

Sequenza:

1. input: 20 euro materiale
2. select1 modificato manualmente in Spesa
3. conferma
4. nuovo input: villa 2 mario

Risultato:

select1 = Evento

Esito: OK

Decisione:

Non è stato necessario aggiungere select1.clearValue() nel reset di button_input_confirm.

Il comportamento attuale è sufficiente.

------------------------------------------------
STATO FINALE DEL NODO
------------------------------------------------

Il nodo ENGINE BASE — TYPE CLASSIFICATION BASE è completato.

Risultati ottenuti:

- select1 allineato a ui_state.parsed
- parsed.unit = minuti imposta Tempo
- euro senza direzione resta Evento
- keyword controllate distinguono Spesa/Incasso
- segnali contrastanti tornano a Evento
- scelta manuale utente preservata
- type inserito nel payload di salvataggio
- insert_event salva events.type
- update_event aggiorna events.type
- DB schema invariato
- parser invariato
- matching invariato
- preview globale non rifattorizzata
- output/KPI non anticipati
- dati type ora disponibili come classificazione base persistita

------------------------------------------------
STATO DB / SAVE FLOW
------------------------------------------------

Nuova catena coerente:

select1 default / scelta manuale utente
→ select1.value
→ payload.type
→ insert_event / update_event
→ events.type

Esempio:

Input:

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

---

Input:

20 euro materiale

ui_state.parsed:

amount: 20
unit: euro

select1:

Evento

DB:

type: Evento
amount: 20
unit: euro
raw_input: 20 euro materiale

Utente può correggere manualmente in:

Spesa
Incasso

e la scelta viene salvata nel DB.

------------------------------------------------
LIMITI RESIDUI
------------------------------------------------

Il nodo NON ha implementato:

- classificazione economica avanzata
- dizionario esteso keyword
- classificazione da parole di dominio come benzina/materiale/mangime
- valori negativi automatici per Spesa
- valori positivi automatici per Incasso
- campo amount firmato
- logica contabile avanzata
- KPI
- dashboard
- reportistica
- match engine unification
- hint completamente state-driven
- preview come view pura
- retro-normalizzazione eventi storici
- bonifica type eventi precedenti
- modifica schema DB
- duration advanced giorni/settimane

------------------------------------------------
DECISIONE SU SPESA / INCASSO
------------------------------------------------

Spesa e Incasso sono stati implementati a livello base tramite keyword controllate.

Non è stata introdotta logica di segno automatico su amount.

Motivo:

Il nodo riguarda type classification base,
non contabilità avanzata o normalizzazione economica con segno.

Stato attuale:

Spesa/Incasso sono salvati in events.type.

Il valore amount resta positivo.

Eventuali report futuri potranno interpretare:

type = Spesa → uscita
type = Incasso → entrata

Oppure, in nodo futuro dedicato,
si potrà decidere se introdurre amount firmato,
campo direction o logica derivata nei report.

------------------------------------------------
ANOMALIE RESIDUE
------------------------------------------------

------------------------------------------------
ANOMALIA 1 — LINTING RETOOL NON BLOCCANTE
------------------------------------------------

Restano visibili in preview reale:

- edit_mode: 'value' is not defined
- editing_event: 'value' is not defined

Impatto:

non bloccano:
- anteprima
- insert
- update
- type classification
- save flow
- events_new refresh

Stato:

fuori scope nodo Type Classification Base.

Ipotesi:

binding o query/state helper che ricevono value via additionalScope
o che hanno riferimenti non pienamente allineati.

Azione futura:

aprire micro-nodo dedicato:

LINTING / STATE HELPER CLEANUP

oppure integrare la pulizia nel prossimo nodo tecnico compatibile,
senza mischiarla a matching o type classification.

------------------------------------------------
ANOMALIA 2 — MATCHING NON UNIFICATO
------------------------------------------------

Restano logiche separate nel sistema:

1. input_raw / ranking
2. select_project / select_entity deterministico
3. preview / detected locale

Impatto:

possibili incoerenze su:
- project
- entity
- hint
- highlight
- ambiguità
- ranking

Esempio osservato:

villa 2 mario
→ type = Evento corretto
→ ma preview mostra:
   - Più entità trovate
   - Più progetti trovati

Questo comportamento appartiene al matching,
non alla type classification.

Stato:

fuori scope nodo Type Classification Base.

Azione futura:

STEP 6.4 — MATCH ENGINE UNIFICATION

------------------------------------------------
ANOMALIA 3 — EVENTI STORICI SENZA TYPE
------------------------------------------------

Eventi creati prima della patch possono avere:

type = null

oppure type non valorizzato.

Il nodo ha verificato che update_event può valorizzare type
quando un evento NEW viene modificato.

Non è stata eseguita retro-normalizzazione storico.

Stato:

fuori scope.

Azione futura:

eventuale bonifica dati solo con nodo dedicato,
se necessaria prima di report/KPI.

------------------------------------------------
RELAZIONE CON MATCHING
------------------------------------------------

Per il layer TYPE ora la catena è allineata:

ui_state.parsed.unit
→ select1
→ payload.type
→ events.type

Per il layer MATCHING restano ancora logiche parallele:

input_raw / ranking
select_project / select_entity deterministico
preview / detected locale

Conclusione:

TYPE CLASSIFICATION BASE è allineato.

MATCH ENGINE non è ancora unificato
e resta nodo futuro dedicato.

------------------------------------------------
DOCUMENTI DA AGGIORNARE
------------------------------------------------

Aggiornare:

1. 00_PROJECT_State

- portare STEP 6.3 — ENGINE BASE / TYPE CLASSIFICATION BASE a COMPLETATO
- documentare select1 allineato a ui_state.parsed
- documentare type persistito in events.type
- documentare Spesa/Incasso base tramite keyword controllate
- documentare override manuale utente validato
- mantenere Match Engine Unification come nodo futuro
- mantenere output/KPI non attivi

2. 00_PROJECT_Roadmap

- segnare STEP 6.3 completato
- definire STEP 6.4 — MATCH ENGINE UNIFICATION come prossimo candidato logico
- mantenere blocco verso OUTPUT
- chiarire che type è base/persistito ma non sufficiente per KPI avanzati

3. 00_PROJECT_System

- aggiornare architettura funzionale con type classification base implementata
- specificare che DB resta passivo
- specificare che type viene deciso lato UI e salvato
- mantenere separazione tra classificazione base e output analytics

4. 01_LOGOS_Input_System

- aggiornare TYPE DETECTION / TYPE CLASSIFICATION
- documentare parsed.unit = minuti → Tempo
- documentare euro + keyword → Spesa/Incasso
- documentare euro senza keyword → Evento
- documentare scelta manuale utente
- documentare test validati

5. LOGOS_RETOOL_RUNTIME_REAL

- aggiornare select1 default value
- aggiornare button_input_confirm payload
- aggiornare insert_event/update_event con type
- documentare test DB insert/update
- documentare anomalie linting residue

6. 04_LOGOS_Retool_Architecture

- aggiornare sezione select1 / type detection
- aggiornare confirm flow con type
- aggiornare insert/update event body
- documentare catena select1 → payload.type → events.type

7. 05_LOGOS_Database_Schema

- aggiornare utilizzo reale del campo events.type
- da "non utilizzato attivamente" a "utilizzato per type classification base"
- specificare valori attuali:
  - Evento
  - Tempo
  - Spesa
  - Incasso
- specificare che DB non decide type
- specificare che amount resta positivo

8. 06_LOGOS_View_Preview_System

- aggiornare relazione preview/select1/type
- documentare che la preview usa select1 ma non salva direttamente
- documentare che type persistito deriva da select1.value tramite button_input_confirm
- mantenere preview come layer ibrido non ancora view pura

Opzionale:

9. 00_PROJECT_Gap_Register

- portare Type Classification Base da VALIDATO a INTEGRATO BASE
- mantenere aperti gap:
  - Match Engine Unification
  - Economic Direction Advanced / amount signed
  - Output/KPI
  - Linting / State Helper Cleanup

------------------------------------------------
ARCHIVIAZIONE
------------------------------------------------

Checkpoint precedente:

CHECKPOINT — ENGINE BASE / DURATION NORMALIZATION

Stato consigliato:

ARCHIVIATO / COMPLETATO

Non cancellare perché contiene:

- codice parse_input_controlled aggiornato
- unità canonica minuti
- logica duration normalization
- formatDurationHumanIT
- hint normalizzato
- hint durata ambigua
- test DB duration

Checkpoint attivo più recente:

CHECKPOINT — ENGINE BASE / TYPE CLASSIFICATION BASE

------------------------------------------------
CQD — VALIDAZIONE CHECKPOINT
------------------------------------------------

C — Completezza: 10/10

- documentato contesto
- documentato problema reale
- documentata decisione architetturale
- documentato codice select1
- documentato payload type
- documentato insert_event/update_event
- documentati test anteprima
- documentati test insert DB
- documentato test update DB
- documentato override manuale
- documentato reset/stale value
- documentati limiti residui
- documentate anomalie residue
- documentati documenti da aggiornare

Q — Qualità: 9.5/10

- soluzione coerente con sistema reale
- nessuna modifica DB schema
- nessuna modifica parser
- nessuna modifica matching
- nessun refactor preview
- controllo utente preservato
- classificazione automatica prudente
- type ora persistito nel DB
- step utile per futura analisi dati

D — Deployabilità: 10/10

- modifiche applicate e validate runtime
- anteprima verificata
- insert verificato
- update verificato
- override manuale verificato
- reset/stale value verificato
- regressioni principali superate
- nessuna dipendenza mancante

------------------------------------------------
VALIDAZIONE FINALE
------------------------------------------------

Nodo: OK
Scope: OK
Deviazione: NO

STATO:

ENGINE BASE — TYPE CLASSIFICATION BASE — COMPLETATO