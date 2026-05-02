#CHECKPOINT

CHECKPOINT — UX / CLEANUP MICRO-BATCH POST MATCH ENGINE

DATA:
2026-05-02

NODO:
UX / CLEANUP MICRO-BATCH POST MATCH ENGINE

STATO:
COMPLETATO

SCOPE:
Micro-problemi UX e cleanup successivi a Match Engine Unification.

INTERVENTI COMPLETATI:

1. EDIT MODE — ANNULLA MODIFICA

Implementato:
- nuovo pulsante btn_cancel_edit
- visibile solo in edit mode
- testo: Annulla
- stile secondario / outline neutro
- posizionato sotto Conferma per priorità mobile

Comportamento:
- reset edit_mode
- reset editing_event
- reset input_home
- reset input_raw
- reset select_project
- reset select_entity
- reset select1
- reset ui_state.parsed
- ritorno a container_events_list
- nessuna chiamata update_event

Validazione:
OK

------------------------------------------------

2. EDIT MODE — FIX DOPPIA VISIBILITÀ LISTA / INPUT

Problema:
Dopo Annulla, entrando in modifica su un altro evento, potevano restare visibili insieme:
- container_input
- container_events_list

Fix:
Rafforzato btn_edit con forzatura UI:
- ui_state.view = home
- container_events_list nascosto
- container_feedback nascosto
- container_home visibile
- container_input visibile

Validazione:
OK

------------------------------------------------

3. LINTING edit_mode / editing_event

Stato:
NON RISOLTO

Dettaglio:
- edit_mode e editing_event usano query JS con:
  return value;
- Retool segnala value non definito
- runtime corretto tramite additionalScope
- Temporary State non adottato perché già storicamente instabile nel setup reale

Classificazione:
ANOMALIA RESIDUA NON BLOCCANTE

Validazione:
OK runtime
KO linting formale

------------------------------------------------

4. LISTA EVENTI — SEARCH / FILTER BAR

Implementato:
- input_events_search
- posizionato nella testata lista eventi
- filtro client-side sulla Data source di list_events
- nessuna modifica a events_new
- nessuna modifica DB

Ricerca su:
- raw_input
- type
- status
- nome progetto
- nome entità

Validazione:
OK

------------------------------------------------

5. LISTA EVENTI — LABEL creato / modificato

Problema:
Eventi appena inseriti venivano mostrati come “modificato”.

Cause:
- updated_at valorizzato anche in insert_event
- created_at / updated_at con formati timezone non omogenei
- confronto iniziale troppo fragile

Fix:
- normalizzazione robusta date DB come UTC
- conversione visuale Europe/Rome
- soglia anti-falso positivo
- label “creato” per eventi mai modificati
- label “modificato” solo per update reale
- marcatore leggero per modificati

Validazione:
OK

------------------------------------------------

6. EDIT MODE — NO-OP EDIT GUARD

Problema:
Confermare un evento in edit mode senza modifiche reali aggiornava comunque updated_at.

Fix:
Aggiunto guard in button_input_confirm.

Logica:
Se in edit mode e non cambiano i campi utente:
- raw_input
- type
- project_id
- entity_id

allora:
- update_event NON viene eseguito
- edit_mode viene chiuso
- editing_event viene azzerato
- UI torna alla lista eventi
- updated_at resta invariato

Nota:
amount, unit, event_date NON sono usati per determinare il no-op perché sono campi derivati dal parser.

Validazione:
OK

------------------------------------------------

7. UI STATE — NUOVO INPUT DA LISTA EVENTI

Problema:
Durante test regressione, scrivendo un nuovo input partendo dalla lista eventi, restavano visibili insieme:
- sintesi/input
- lista eventi

Fix:
Aggiornato input_home change handler:
- ui_state.view = home
- container_events_list nascosto
- container_feedback nascosto
- container_home visibile
- container_input visibile
- sync input_raw
- trigger_parse_debounced rilanciato

Validazione:
OK

------------------------------------------------

TEST FINALI:

1. Create flow:
OK

2. Search lista:
OK

3. Edit senza modifiche:
OK

4. Edit con modifica reale:
OK

5. Annulla modifica:
OK

6. WRITTEN / ERROR:
OK

7. Regressione match/type/duration:
OK

------------------------------------------------

VINCOLI RISPETTATI:

✔ parser non modificato
✔ trigger_parse_debounced non modificato salvo uso esistente
✔ project_state non modificato
✔ entity_state non modificato
✔ Match Engine non modificato
✔ Type Classification non modificata
✔ Duration Normalization non modificata
✔ schema DB invariato
✔ insert_event invariato
✔ update_event invariato
✔ nessun output/KPI
✔ nessun refactor globale UI
✔ nessuna dashboard eventi

------------------------------------------------

ANOMALIE RESIDUE:

1. Linting edit_mode / editing_event:
- presenti
- runtime corretto
- non bloccanti

------------------------------------------------

ESITO:

MICRO-BATCH COMPLETATO.

Sistema stabile dopo:
- create
- edit
- annulla
- ricerca lista
- label creato/modificato
- WRITTEN / ERROR
- regressione match/type/duration