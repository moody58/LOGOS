# CHECKPOINT — INPUT SYSTEM REFACTOR + UX STABILIZATION

DATA: 2026-04-24

------------------------------------------------
NODO:
INPUT_SYSTEM — PARSE FLOW + UI STATE ALIGNMENT
------------------------------------------------

TIPO:
STABILIZZAZIONE + REFRACTOR CONTROLLED

------------------------------------------------
CONTESTO
------------------------------------------------

Il sistema di input presentava:

- parsing attivo su ogni digitazione (loop continuo)
- incoerenza tra create/edit (sintesi non allineata)
- errori su ui_state (setValue non valido)
- flash UI tra home / feedback
- duplicazione parsing (parse_input vs parse_input_controlled)

Obiettivo:
→ stabilizzare UX
→ unificare parsing
→ eliminare glitch visivi
→ mantenere suggerimenti live

------------------------------------------------
INTERVENTI ESEGUITI
------------------------------------------------

### 1. DEBOUNCE PARSING

- introdotto trigger_parse_debounced
- parsing non più per lettera ma ritardato

input_home → change:
→ trigger_parse_debounced.trigger()

RISULTATO:
✔ riduzione chiamate
✔ UX più fluida
✔ compatibile mobile

------------------------------------------------

### 2. INTRODUZIONE PARSER UNIFICATO

Nuova query:
→ parse_input_controlled

Sostituisce:
→ parse_input (transformer legacy)

Caratteristiche:
- parsing completo (amount, unit, date)
- indipendente da UI
- utilizzabile in:
  - sintesi
  - salvataggio
  - edit mode

------------------------------------------------

### 3. RIMOZIONE DEPENDENCY LEGACY

- eliminato uso di parse_input in:
  - sintesi
  - button_input_confirm

- mantenuto temporaneamente per verifica
→ poi disaccoppiato completamente

------------------------------------------------

### 4. FIX UI_STATE (CRITICO)

Problema:
→ ui_state era query JS → NON supporta setValue

Soluzione:
→ convertito in STATE Retool nativo

Ora:
ui_state.setValue({...})

Struttura:

{
  parsed,
  status,
  view,
  feedback_text,
  feedback_project
}

------------------------------------------------

### 5. FIX PARSE SUCCESS HANDLER

Corretto:

parse_input_controlled → success:

if (parse_input_controlled.data) {
  ui_state.setValue({
    ...ui_state.value,
    parsed: parse_input_controlled.data
  });
}

RISULTATO:
✔ niente errori data undefined
✔ stato consistente

------------------------------------------------

### 6. FIX EDIT MODE (BUG SINTESI)

Problema:
→ entrando in edit la sintesi era errata fino a digitazione

Causa:
→ parse non triggerato dopo set input

Soluzione:

btn_edit:

setTimeout(() => {
  input_home.setValue(item.raw_input);
  input_raw.setValue(item.raw_input);

  parse_input_controlled.trigger();
}, 0);

RISULTATO:
✔ sintesi immediata in edit
✔ coerenza create/edit

------------------------------------------------

### 7. FIX FLASH UI (HOME → FEEDBACK)

Problema:
→ doppio cambio view

Soluzione:
→ gestione view SOLO nel bottone confirm

Rimosso da:
- handle_event_success
- focus_input_home

Ora:

ui_state.setValue({
  view: "feedback"
})

RISULTATO:
✔ eliminato flicker
✔ transizione stabile

------------------------------------------------

### 8. RESET UX OTTIMIZZATO (PERFORMANCE)

Modificato button_input_confirm:

PRIMA:
→ await su tutto → UI bloccata

DOPO:

ui_state.setValue(...)  // subito
reset input             // subito

const savePromise = insert/update

events_new.trigger()    // NO await

await savePromise       // opzionale

RISULTATO:
✔ UI immediata
✔ backend async
✔ nessun rallentamento percepito

------------------------------------------------

### 9. FIX FEEDBACK RESUME

Problema:
→ seconda riga mancante

Soluzione:
→ usare ui_state invece di input resettati

feedback_resume:

{{
  [
    ui_state.value?.feedback_text,
    ui_state.value?.feedback_project
  ]
  .filter(Boolean)
  .join("\n")
}}

------------------------------------------------

### 10. ELIMINAZIONE PARSE DUPLICATO NEL SAVE

Rimosso parsing manuale nel bottone

Ora:

const parsed = ui_state.value?.parsed || {};

payload = {
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date
}

RISULTATO:
✔ single source of truth
✔ zero drift tra preview e salvataggio

------------------------------------------------
ARCHITETTURA FINALE
------------------------------------------------

INPUT FLOW:

input_home
→ input_raw
→ trigger_parse_debounced
→ parse_input_controlled
→ ui_state.parsed
→ sintesi

SAVE FLOW:

ui_state.parsed
→ payload
→ insert/update

EDIT FLOW:

btn_edit
→ set input
→ trigger parse
→ ui_state.parsed aggiornato

------------------------------------------------
STATO SISTEMA
------------------------------------------------

✔ parsing stabile
✔ UX fluida
✔ no loop inutili
✔ no errori console
✔ no flash UI
✔ create/edit allineati
✔ mobile-ready
✔ base pronta per input vocale

------------------------------------------------
DEBITO TECNICO RESIDUO
------------------------------------------------

- possibile rimozione definitiva parse_input (legacy)
- eventuale centralizzazione match engine (fase futura)
- ottimizzazione scoring entità/progetti

------------------------------------------------
CHECKPOINT
------------------------------------------------

STATO: STABILE

PRONTO PER:
→ aggiornamento STATE
→ aggiornamento ROADMAP
→ passaggio nodo successivo

------------------------------------------------