#CHECKPOINT
@@LOGOS

NODO:
MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL

DATA:
2026-05-02

------------------------------------------------
STATO PRIMA DEL NODO
------------------------------------------------

Il sistema LOGOS aveva già stabilizzato:

- INPUT RELIABILITY
- MATCHING BASE funzionante ma non unificato
- LABEL QUALITY
- EVENT EDITING
- INPUT SYSTEM STABILIZATION
- ENGINE BASE — NORMALIZATION LAYER BASE
- PREVIEW ALIGNMENT BASE
- ENGINE BASE — DURATION NORMALIZATION
- ENGINE BASE — TYPE CLASSIFICATION BASE

Catene già consolidate:

amount / unit / event_date:
parse_input_controlled
→ ui_state.parsed
→ button_input_confirm
→ insert_event / update_event
→ events

type:
ui_state.parsed.unit
→ select1.value
→ payload.type
→ insert_event / update_event
→ events.type

Debito aperto:

project/entity matching ancora distribuito tra:
- project_state / entity_state
- select_project / select_entity
- preview detection locale
- hint locali
- highlight locale
- confirm guard

Rischio:
incoerenze tra ciò che viene suggerito, evidenziato, selezionato, bloccato e salvato.

------------------------------------------------
OBIETTIVO DEL NODO
------------------------------------------------

Implementare il primo livello controllato di unificazione matching project/entity.

Obiettivo operativo:

ridurre le logiche parallele e rendere coerenti:

- match state
- select project/entity
- hint ambiguità
- highlight preview
- confirm guard
- create flow
- edit flow

Senza introdurre:

- data structure avanzata
- gerarchie project/entity
- deduplicazione
- creazione automatica project/entity
- schema DB
- dashboard/KPI
- output
- refactor globale preview
- refactor parser
- modifiche type classification
- modifiche duration normalization

------------------------------------------------
DECISIONE DI CONFINE
------------------------------------------------

LOGOS non usa una fonte unica globale per tutto.

LOGOS usa fonti controllate per layer:

- raw_input / input_raw:
  testo originario e input testuale per matching

- ui_state.parsed:
  fonte unica per amount / unit / event_date

- select1.value:
  fonte runtime per type

- project_state / entity_state:
  fonte minima osservabile per matching project/entity

- select_project.value / select_entity.value:
  fonte finale salvabile per project_id / entity_id

- preview:
  rappresentazione visuale, non fonte decisionale

Il nodo ha lavorato solo sul layer matching project/entity.

------------------------------------------------
MAPPA LOGICHE MATCHING PRIMA DEL NODO
------------------------------------------------

1. project_state / entity_state

Logica precedente:
- includes diretto sul nome completo
- output matches semplice
- non sempre live rispetto a input_raw
- non usato in modo completo da select / preview / confirm

2. select_project / select_entity

Logica precedente:
- ricalcolo locale del matching nel Default value
- auto-select se match univoco
- logiche diverse da project_state/entity_state

3. preview / sintesi

Logica precedente:
- detectedProjects / detectedEntities locali
- token matching separato
- hint basati parzialmente su detection locale
- highlight locale autonomo

4. button_input_confirm.disabled

Logica precedente:
- guard legata a matches ma con rischio array > number
- ambiguità non pienamente coerente con match state

------------------------------------------------
MODIFICHE IMPLEMENTATE
------------------------------------------------

1. project_state aggiornato

Ora project_state calcola:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

Logiche introdotte:

- normalizzazione testo base
- match per parole significative
- gestione numeri nei nomi progetto
- full name match
- priority match minimo
- rimozione match generici coperti da match più specifici
- hint potenziale per progetti più specifici

Esempi:
- villa → Villa + hint progetti più specifici
- villa 2 → Villa 2
- casa mare → Casa Mare
- ristrutturazione bagno → Ristrutturazione Bagno

2. entity_state aggiornato

Ora entity_state calcola:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

Logiche introdotte:

- normalizzazione testo base
- match per parole significative
- full name match
- priority match minimo
- rimozione match generici coperti da match più specifici
- hint potenziale per entità più specifiche

Esempi:
- mario → Mario + hint entità più specifiche
- mario rossi → Mario Rossi + hint entità più specifiche
- mario rossi alfredo → Mario Rossi Alfredo
- alfie mario rossi → ambiguità reale

3. trigger_parse_debounced aggiornato

Prima:
- rilanciava solo parse_input_controlled

Ora:
- rilancia parse_input_controlled
- rilancia project_state
- rilancia entity_state

Nuovo flow create:

input_home
→ input_raw
→ trigger_parse_debounced
→ parse_input_controlled
→ project_state
→ entity_state
→ select / preview / confirm guard

Risultato:
match state live anche durante inserimento nuovo evento.

4. btn_edit aggiornato

Prima:
- edit flow rilanciava parse_input_controlled
- non rilanciava project_state/entity_state

Bug:
in modalità modifica evento, i suggerimenti project/entity non funzionavano più correttamente.

Ora:
btn_edit aggiorna:

- editing_event
- edit_mode
- input_home
- input_raw
- parse_input_controlled
- project_state
- entity_state
- ripristino project_id/entity_id salvati se presenti

Nuovo flow edit:

evento selezionato
→ input_raw
→ parse_input_controlled
→ project_state
→ entity_state
→ select / preview / confirm guard

Risultato:
match state live anche in modalità modifica.

5. select_project aggiornato

Prima:
- ricalcolava matching nel Default value

Ora:
- legge project_state.data.singleMatch
- se singleMatch esiste, ritorna singleMatch.id
- altrimenti null

Risultato:
select_project non ha più logica autonoma di matching.

6. select_entity aggiornato

Prima:
- ricalcolava matching nel Default value

Ora:
- legge entity_state.data.singleMatch
- se singleMatch esiste, ritorna singleMatch.id
- altrimenti null

Risultato:
select_entity non ha più logica autonoma di matching.

7. sintesi / preview aggiornata

Modifiche:

- hint ambiguità leggono project_state/entity_state
- detectedProjects/detectedEntities locali eliminati come logica autonoma
- highlight legge matches da project_state/entity_state
- highlight su nome completo introdotto
- hint “Più entità trovate” mostrato solo se ambiguità non risolta
- hint “Più progetti trovati” mostrato solo se ambiguità non risolta
- hint informativo non bloccante per match più specifici introdotto
- debug match temporaneo introdotto e poi rimosso

Nuovi hint informativi:

- “Esistono entità più specifiche”
- “Esistono progetti più specifici”

Caratteristiche:
- non bloccanti
- colore informativo
- non modificano select
- non modificano DB
- aiutano l’utente a verificare match esatti brevi

8. button_input_confirm.disabled aggiornato

Decisione implementata:

- input vuoto → blocca
- match ambiguo non risolto → blocca
- match ambiguo risolto manualmente → consente
- nessun match → consente
- match univoco → consente

Regola finale:

project ambiguo + select_project vuoto → disabled
entity ambiguo + select_entity vuoto → disabled

project ambiguo + select_project valorizzato manualmente → enabled
entity ambiguo + select_entity valorizzato manualmente → enabled

Motivo:
utente in controllo; evitare salvataggio silenzioso di relazioni ambigue.

9. bug €500 nella preview risolto

Problema:
input “€500 acconto alfie mario rossi”
produceva preview con duplicazione:

500,00 € • € 500 acconto ...

Causa:
label cleaning non gestiva correttamente simbolo € prima del numero.

Fix:
regex dedicata per rimuovere pattern:
- €500
- € 500
- €500,50
- € 1.500,50

Risultato:
500,00 € • acconto alfie mario rossi

10. linting project_state/entity_state ripuliti

Risolti linting:
- project_state: misleading line break before ?
- entity_state: misleading line break before ?

Metodo:
sostituiti ternari multilinea con if espliciti.

------------------------------------------------
COMPORTAMENTO FINALE VALIDATO
------------------------------------------------

Caso:
villa 2 mario

Risultato:
- project_state.count = 1
- entity_state.count = 1
- select_project = Villa 2
- select_entity = Mario
- nessun hint ambiguità
- Conferma abilitata

OK

---

Caso:
4 aprile benzina 50 euro alfie allevamento aspri

Risultato:
- project_state.count = 1
- entity_state.count = 2
- select_project = ASPRI
- select_entity vuoto
- hint Più entità trovate
- hint Definisci spesa o incasso
- Conferma disabilitata

OK

---

Stesso caso con scelta manuale entity Alfie:

Risultato:
- entity_state.count resta 2
- entity_state.isAmbiguous = true
- select_entity = Alfie
- hint Più entità trovate sparisce
- Conferma abilitata

OK

---

Caso:
18 min ristrutturazione bagno

Risultato:
- project_state.count = 1
- select_project = Ristrutturazione Bagno
- type = Tempo
- nessun hint Più progetti trovati
- Conferma abilitata

OK

---

Caso:
acquisto 50 euro materiale nuovo

Risultato:
- project_state.count = 0
- entity_state.count = 0
- select_project vuoto
- select_entity vuoto
- type = Spesa
- amount = 50
- unit = euro
- Conferma abilitata

OK

---

Caso:
mario

Risultato:
- entity_state.count = 1
- select_entity = Mario
- hint informativo: Esistono entità più specifiche
- Conferma abilitata

OK

---

Caso:
mario rossi

Risultato:
- entity_state.count = 1
- select_entity = Mario Rossi
- hint informativo: Esistono entità più specifiche
- Conferma abilitata

OK

---

Caso:
mario rossi alfredo

Risultato:
- entity_state.count = 1
- select_entity = Mario Rossi Alfredo
- nessun hint più specifico
- Conferma abilitata

OK

---

Caso:
villa

Risultato:
- project_state.count = 1
- select_project = Villa
- hint informativo: Esistono progetti più specifici
- Conferma abilitata

OK

---

Caso:
villa 2

Risultato:
- project_state.count = 1
- select_project = Villa 2
- nessun hint più specifico
- Conferma abilitata

OK

---

Caso:
alfie mario rossi

Risultato:
- entity_state.count = 2
- select_entity vuoto
- hint Più entità trovate
- Conferma disabilitata

OK

---

Caso edit flow:
villa 2 mario

Risultato:
- input caricato
- project = Villa 2
- entity = Mario
- preview coerente
- Conferma abilitata

OK

---

Caso edit flow:
18 min ristrutturazione bagno

Risultato:
- input caricato
- project = Ristrutturazione Bagno
- type = Tempo
- Conferma abilitata

OK

---

Caso edit flow:
4 aprile benzina 50 euro alfie allevamento aspri

Risultato:
- input caricato
- project = ASPRI
- entity vuota se non salvata
- hint Più entità trovate
- Conferma disabilitata finché non viene scelta entità

OK

------------------------------------------------
DECISIONI CONSOLIDATE
------------------------------------------------

1. Match state come fonte minima del matching

project_state / entity_state diventano la fonte minima osservabile per:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

2. Select come fonte salvabile

select_project.value resta fonte finale per project_id.
select_entity.value resta fonte finale per entity_id.

3. Preview non decisionale

La preview legge match state per hint/highlight, ma non decide e non salva.

4. Ambiguità

Ambiguità non risolta:
- hint rosso
- select vuota
- confirm disabilitato

Ambiguità risolta manualmente:
- hint rosso rimosso
- confirm abilitato

5. Nessun match

Nessun match project/entity non blocca il salvataggio.

Motivo:
il sistema deve restare non bloccante.
La creazione guidata project/entity sarà nodo futuro dedicato.

6. Match esatto con match più specifici

Il match esatto resta valido e non bloccante.

Esempio:
mario → Mario

Se esistono:
Mario Rossi
Mario Rossi Alfredo

Il sistema mostra hint informativo:
“Esistono entità più specifiche”

Conferma resta abilitata.

------------------------------------------------
BUG RISOLTI
------------------------------------------------

- preview hint incoerenti rispetto a project_state/entity_state
- hint “Più progetti trovati” mostrato con project_state.count = 1
- hint “Più entità trovate” non mostrato con entity_state.isAmbiguous = true
- confirm guard fragile su matches array
- confirm bloccato anche dopo scelta manuale
- match state non live nel create flow
- match state non live nell’edit flow
- select_project / select_entity con logiche autonome duplicate
- ristrutturazione bagno ambiguo con Ristrutturazione
- casa mare / project specifici gestiti via priority match
- villa 2 evidenziato parzialmente solo come villa
- €500 duplicato nella preview
- linting project_state/entity_state da ternari multilinea

------------------------------------------------
LIMITI RESIDUI
------------------------------------------------

1. Linting residui Retool

Restano 2 linting:

- edit_mode: 'value' is not defined
- editing_event: 'value' is not defined

Stato:
- runtime funzionante
- edit flow validato
- nessun errore operativo
- probabilmente legati ad additionalScope { value: ... }

Decisione:
non intervenire in questo nodo.

Nodo futuro:
LINTING / STATE HELPER CLEANUP

2. Preview ancora ibrida

La preview resta un layer ibrido:

- rendering
- label cleaning
- hint logic
- highlight
- format visuale

Non è ancora view pura.

Decisione:
non refactor globale nel nodo corrente.

3. Creazione project/entity non implementata

Nessun match non blocca il salvataggio.

Non è stata introdotta:
- creazione automatica project/entity
- pending state
- proposta “crea nuovo progetto”
- proposta “crea nuova entità”

Nodo futuro:
PROJECT / ENTITY CREATE SUGGESTION
oppure
ENTITY / PROJECT ASYNC WORKFLOW

4. Nessuna gerarchia/deduplicazione

Non implementato:

- entity hierarchy
- project hierarchy
- alias
- deduplicazione entity/project
- relazioni entity-project

5. Output/KPI non attivati

Il nodo migliora la qualità dei dati project/entity,
ma non attiva dashboard, KPI o reportistica.

------------------------------------------------
NODI FUTURI DA SEGNARE
------------------------------------------------

1. PROJECT / ENTITY CREATE SUGGESTION

Obiettivo:
quando nessun project/entity viene trovato,
proporre all’utente la creazione guidata.

Utile per:
- input vocali
- Siri
- inserimenti rapidi
- project/entity non ancora presenti

Vincoli futuri:
- nessuna creazione automatica silenziosa
- creazione solo previa conferma utente
- evitare duplicati
- valutare pending state
- valutare relazione con Data Structure / Entity Hierarchy

2. LINTING / STATE HELPER CLEANUP

Obiettivo:
ripulire linting residui:

- edit_mode: 'value' is not defined
- editing_event: 'value' is not defined

Vincoli:
- preservare edit flow
- nessuna modifica matching
- nessuna modifica parser
- nessuna modifica DB

3. EDIT MODE CANCEL / RETURN TO EVENTS LIST

Obiettivo:
aggiungere un controllo per annullare la modifica evento.

Scope futuro:
- uscire da edit_mode
- svuotare input_home/input_raw
- pulire select_project/select_entity
- ripristinare ui_state.parsed
- tornare alla lista eventi o vista coerente
- nessuna modifica engine
- nessuna modifica DB

4. EVENTS LIST SEARCH / FILTER BAR

Obiettivo:
aggiungere una barra di ricerca nella lista eventi per filtrare rapidamente gli eventi visualizzati.

Scope futuro:
- ricerca testuale su raw_input / descrizione evento
- eventuale filtro per project/entity/type/status
- nessuna modifica engine
- nessuna modifica DB obbligatoria nella prima versione
- nessuna alterazione insert/update
- miglioramento UX lista eventi

5. DATA STRUCTURE / ENTITY HIERARCHY

Resta futuro e non attivo.

Da valutare dopo stabilizzazione ulteriore:
- gerarchie
- alias
- deduplicazione
- relazioni entity-project

6. ECONOMIC DIRECTION ADVANCED

Resta futuro e non attivo.

Da valutare dopo:
- matching stabile
- prima definizione output/report
- dati economici reali

------------------------------------------------
DOCUMENTI DA AGGIORNARE
------------------------------------------------

Documenti core:

1. 00_PROJECT_State
- aggiornare stato nodo STEP 6.4
- segnare MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL completato
- indicare match state live in create/edit
- indicare select/hint/highlight/confirm allineati a project_state/entity_state
- registrare nodi futuri

2. 00_PROJECT_Roadmap
- segnare STEP 6.4 completato
- ridefinire prossimo nodo logico
- inserire nodi futuri non immediati

Documenti tecnici:

3. 02_LOGOS_Match_Engine
- aggiornare logica reale project_state/entity_state
- documentare singleMatch / isAmbiguous / moreSpecificMatches
- documentare priority match minimo
- documentare hint match più specifici
- documentare confirm guard da ambiguità non risolta
- documentare edit flow allineato

4. 01_LOGOS_Input_System
- aggiornare sezione matching
- indicare che matching è ora alimentato da project_state/entity_state live
- confermare fonti controllate:
  amount/unit/date → ui_state.parsed
  type → select1.value
  project_id → select_project.value
  entity_id → select_entity.value

5. LOGOS_RETOOL_RUNTIME_REAL
- aggiornare trigger_parse_debounced
- aggiornare btn_edit
- aggiornare project_state/entity_state
- aggiornare select_project/select_entity
- aggiornare sintesi
- aggiornare button_input_confirm.disabled

6. 04_LOGOS_Retool_Architecture
- aggiornare architettura runtime matching
- indicare create/edit flow con match state live
- indicare preview ancora ibrida ma matching allineato

7. 06_LOGOS_View_Preview_System
- aggiornare preview hint/highlight da match state
- documentare rimozione detection locale decisionale
- documentare hint più specifici
- documentare fix €500 label cleaning

8. 05_LOGOS_Database_Schema
- aggiornamento minimo:
  nessuna modifica DB
  project_id/entity_id restano derivati da select_project/select_entity
  qualità matching migliorata lato frontend

9. 00_PROJECT_Gap_Register
- aggiornare G10 Match Engine Unification a INTEGRATO BASE / COMPLETATO PRIMO LIVELLO
- aggiungere o aggiornare nodi futuri:
  PROJECT / ENTITY CREATE SUGGESTION
  LINTING / STATE HELPER CLEANUP
  EDIT MODE CANCEL / RETURN TO EVENTS LIST
  EVENTS LIST SEARCH / FILTER BAR

------------------------------------------------
CQD — VALIDAZIONE CHECKPOINT
------------------------------------------------

C — Completezza:
10/10

Il checkpoint copre:
- stato iniziale
- problemi reali
- modifiche applicate
- test runtime
- decisioni
- limiti residui
- nodi futuri
- documenti da aggiornare

Q — Qualità:
9.5/10

Il nodo ha ridotto logiche parallele senza refactor globale.
La preview resta ibrida, ma non più decisionale per il matching.

D — Deployabilità:
10/10

Patch validate su runtime reale Retool.
Create flow e edit flow testati.
DB invariato.
Parser invariato.
Type classification invariata.
Duration normalization invariata.

------------------------------------------------
STATO FINALE
------------------------------------------------

MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL:

COMPLETATO

Il sistema ora ha:

- project_state / entity_state come fonte minima del matching
- select_project / select_entity alimentati da singleMatch
- hint ambiguità alimentati da isAmbiguous
- confirm guard basata su ambiguità non risolta
- highlight preview alimentato da matches
- priority match minimo
- hint informativo per match più specifici
- match state live in create flow
- match state live in edit flow

------------------------------------------------
VALIDAZIONE
------------------------------------------------

VALIDAZIONE:
- nodo: OK
- scope: OK
- deviazione: NO