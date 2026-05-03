#CHECKPOINT
@@LOGOS

NODO:
LINTING / STATE HELPER CLEANUP

STATO:
COMPLETATO

INTERVENTO:
Risolti i due linting residui Retool:

- edit_mode: 'value' is not defined
- editing_event: 'value' is not defined

CAUSA:
Gli helper edit_mode / editing_event usavano `return value;`
con valore passato tramite `additionalScope: { value: ... }`.
Il runtime era corretto, ma Retool segnalava `value` come variabile non definita.

FIX APPLICATO:
Rimosso l’uso di `additionalScope { value }` per questi due helper.

Nuovo pattern:

- btn_edit scrive su:
  - window.__logos_edit_mode_value
  - window.__logos_editing_event_value

- edit_mode legge:
  - window.__logos_edit_mode_value

- editing_event legge:
  - window.__logos_editing_event_value

- dopo lettura, gli helper cancellano la chiave window usata.

PUNTI AGGIORNATI:
- edit_mode
- editing_event
- btn_edit
- btn_cancel_edit
- button_input_confirm:
  - ramo no-op edit guard
  - reset finale dopo salvataggio reale

TEST VALIDATI:
- create nuovo evento: OK
- edit evento: OK
- annulla modifica: OK
- edit senza modifiche reali: OK
- edit con modifica reale: OK
- updated_at / label creato-modificato: OK
- WRITTEN / ERROR: OK
- linting edit_mode / editing_event: risolti

REGRESSIONI:
Nessuna regressione rilevata.

DB:
Invariato.

PARSER:
Invariato.

MATCH ENGINE:
Invariato.

TYPE CLASSIFICATION:
Invariata.

DURATION NORMALIZATION:
Invariata.

PREVIEW:
Invariata.

LISTA EVENTI:
Invariata.

ESITO:
Nodo chiuso.
Residuo G14 risolto.