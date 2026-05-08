# 00_PROJECT_State_v17

DATA: 2026-05-07

------------------------------------------------
NODO ATTIVO:
------------------------------------------------

PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL — COMPLETATO

------------------------------------------------
FASE:
------------------------------------------------

STEP 4 — EVENT EDITING (COMPLETATO)

STEP 4.1 — INPUT SYSTEM STABILIZATION (COMPLETATO)

STEP 6.1 — ENGINE BASE / NORMALIZATION LAYER BASE (COMPLETATO)

PREVIEW ALIGNMENT BASE (COMPLETATO)

STEP 6.2 — ENGINE BASE / DURATION NORMALIZATION (COMPLETATO)

STEP 6.3 — ENGINE BASE / TYPE CLASSIFICATION BASE (COMPLETATO)

STEP 6.4 — MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL (COMPLETATO)

UX / CLEANUP MICRO-BATCH POST MATCH ENGINE (COMPLETATO)

LINTING / STATE HELPER CLEANUP (COMPLETATO)

PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL (COMPLETATO)

TRANSIZIONE → NEXT NODE DA DEFINIRE IN ROADMAP DOPO AGGIORNAMENTO DOCUMENTALE

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- coperti tutti i layer sistema  
- parsing + normalization + duration + type documentati  
- Match Engine Unification First Controlled Level documentato  
- project_state / entity_state ora documentati come fonte minima matching  
- select_project / select_entity allineati a singleMatch  
- hint ambiguità allineati a isAmbiguous  
- confirm guard allineata ad ambiguità non risolta  
- create flow e edit flow aggiornati  
- preview highlight allineato a match state  
- nodi futuri residui esplicitati
- UX / Cleanup Micro-Batch Post Match Engine documentato
- annulla modifica documentato
- search/filter lista eventi documentato
- label creato/modificato lista eventi documentata
- no-op edit guard documentato
- fix UI state nuovo input da lista documentato 
- Linting / State Helper Cleanup documentato
- linting edit_mode / editing_event risolti
- helper edit_mode / editing_event ripuliti da additionalScope { value }   
- Project / Entity Create Suggestion First Controlled Level documentato
- creazione inline project validata
- creazione inline entity validata
- ignore globale validato
- entity autofill controlled minimal validato
- select manuale confermata come decisione utente finale
- salvataggio evento incompleto validato
- blocco solo su ambiguità attiva validato
- direzione LOGOS Core modulare riconfermata

Q (Qualità): 9.5/10  
- stato coerente con sistema reale  
- distinzione chiara parsing / matching / label / normalization / preview / type  
- UX migliorata senza regressioni  
- matching project/entity più coerente e meno duplicato  
- controllo manuale utente preservato  
- nessuna anticipazione output/KPI  
- preview ancora ibrida ma non più fonte decisionale matching  
- debiti residui esplicitati  
- rumore tecnico Retool residuo su edit_mode / editing_event eliminato
- creazione project/entity guidata senza automatismi silenziosi
- migliorata qualità dati tramite creazione inline controllata
- mantenuto controllo utente su select project/entity
- confermata separazione tra evento operativo e futuro command intent
- confermata direzione modulare a blocchi senza anticipare istanze verticali

D (Deployabilità): 10/10  
- pronto per Regia  
- stato completamente ricostruibile  
- nessuna dipendenza mancante  
- codice runtime principale documentato nel checkpoint  
- create flow validato runtime  
- edit flow validato runtime  
- DB invariato  
- parser invariato  
- type classification invariata  
- duration normalization invariata   
- linting edit_mode / editing_event risolti
- create/edit/annulla/no-op edit/WRITTEN/ERROR rivalidati dopo cleanup helper   
- project create suggestion validato su DB reale
- entity create suggestion validato su DB reale
- evento salvato con project_id/entity_id creati inline validato
- regressioni create/edit/no-op validate dopo nuovo nodo
- DB schema invariato      

------------------------------------------------
IDENTIFICAZIONE PROGETTO
------------------------------------------------

Nome: LOGOS  
Tipo: Event Operating System  

Stack:

Frontend: Retool  
Backend: Supabase  
Logica: Client-side (JavaScript)  
Modello dati: Event Ledger (append-only controllato)  

------------------------------------------------
STATO GENERALE SISTEMA
------------------------------------------------

Sistema funzionante end-to-end:

INPUT  
→ PARSING  
→ NORMALIZATION BASE  
→ MATCHING  
→ PREVIEW (LABEL)  
→ INSERT / UPDATE  
→ PROCESSING  
→ FEEDBACK  

✔ sistema funzionante  
✔ utilizzabile in produzione reale  
✔ comportamento quasi deterministico  
✔ parsing base stabilizzato  
✔ normalizzazione amount/unit base implementata  
✔ duration normalization base implementata  
✔ durate certe ore/minuti normalizzate in minuti  
✔ preview allineata visivamente a ui_state.parsed  
✔ insert/update verificati su DB reale  
✔ refresh lista eventi corretto dopo save/update  
✔ type classification base implementata  
✔ select1 allineato a ui_state.parsed  
✔ type salvato in events.type  
✔ Spesa / Incasso / Tempo / Evento persistiti in DB  
✔ override manuale utente validato  
✔ Match Engine Unification First Controlled Level completato  
✔ project_state / entity_state ora fonte minima matching project/entity  
✔ select_project / select_entity alimentati da singleMatch  
✔ hint ambiguità alimentati da isAmbiguous  
✔ confirm guard basata su ambiguità non risolta  
✔ preview highlight alimentato da matches  
✔ priority match minimo implementato  
✔ hint informativo per match più specifici implementato  
✔ match state live in create flow  
✔ match state live in edit flow 
✔ UX / Cleanup Micro-Batch Post Match Engine completato
✔ annulla modifica evento implementato
✔ edit senza modifiche reali non aggiorna updated_at
✔ lista eventi filtrabile con ricerca client-side
✔ label lista eventi distingue creato / modificato
✔ eventi modificati marcati visivamente
✔ nuovo input da lista eventi ripristina correttamente la vista input
✔ WRITTEN / ERROR validati dopo cleanup UX 
✔ Linting / State Helper Cleanup completato
✔ linting edit_mode / editing_event risolti
✔ helper edit_mode / editing_event ripuliti da additionalScope { value }
✔ create/edit/annulla/no-op edit/edit reale rivalidati dopo cleanup helper
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ create_suggestion_state introdotto come helper suggestion controllato
✔ insert_project implementato e validato
✔ insert_entity implementato e validato
✔ creazione inline project validata
✔ creazione inline entity validata
✔ select_project valorizzata dopo creazione progetto
✔ select_entity valorizzata dopo creazione entità
✔ evento salvabile con nuovo project_id creato inline
✔ evento salvabile con nuovo entity_id creato inline
✔ evento salvabile anche senza project/entity
✔ blocco Conferma solo su ambiguità attiva project/entity
✔ ignore globale suggestion implementato
✔ una sola creazione guidata aperta alla volta
✔ entity autofill controlled minimal implementato
✔ select manuale confermata come decisione utente anche se non presente nel raw_input

⚠ accoppiamento input / processing / UI ancora presente  
⚠ matching unificato solo a primo livello controllato  
⚠ preview ancora layer ibrido, non view pura  
⚠ hint più coerenti ma non ancora engine globale separato   
⚠ type classification base completata ma non ancora sufficiente per KPI avanzati    
⚠ giorni/settimane non convertiti automaticamente   
⚠ UI container suggestion ancora da rifinire graficamente
⚠ command intent non implementato
⚠ select options non filtrate in caso di ambiguità
⚠ istanze verticali ASPRI / ADEXIMA / MaurizioLab non ancora attive  

------------------------------------------------
AGGIORNAMENTO CRITICO (COMPLETATO)
------------------------------------------------

Il sistema è stabilizzato su undici layer fondamentali:

1. INPUT RELIABILITY — PARSING  
2. MATCHING BASE  
3. LABEL QUALITY  
4. ENGINE BASE — NORMALIZATION LAYER BASE  
5. PREVIEW ALIGNMENT BASE  
6. ENGINE BASE — DURATION NORMALIZATION  
7. ENGINE BASE — TYPE CLASSIFICATION BASE  
8. MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL  
9. UX / CLEANUP MICRO-BATCH POST MATCH ENGINE  
10. LINTING / STATE HELPER CLEANUP    
11. PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL             

---

RISULTATO:

✔ insert e update usano ui_state.parsed come fonte unica  
✔ aggiornata lista eventi dopo save completato  
✔ preview visualmente allineata ai dati normalizzati  
✔ amount mostrato in formato italiano  
✔ unit visualizzate in modo coerente  
✔ label cleaning migliorato sui casi normalizzati  
✔ date separate correttamente nella sintesi  
✔ highlight preview non interferisce più con unità tecniche 
✔ durate certe ore/minuti normalizzate in minuti  
✔ 1 ora e 15 minuti supportato  
✔ 2h30 supportato  
✔ 2 ore 30 supportato  
✔ 1,5 ore convertito in minuti  
✔ preview durata mostra forma umana + valore normalizzato  
✔ giorni/settimane segnalati come durata ambigua 
✔ select1 usa ui_state.parsed.unit come fonte primaria per il tempo  
✔ parsed.unit = "minuti" imposta Tempo  
✔ parsed.unit = "euro" con keyword controllate distingue Spesa / Incasso  
✔ euro senza direzione chiara resta Evento  
✔ scelta manuale utente preservata  
✔ type inserito nel payload di salvataggio  
✔ insert_event salva events.type  
✔ update_event aggiorna events.type    

⚠ matching basato su stringhe (no fuzzy)  
⚠ hint limitati a logica base  
⚠ preview contiene ancora logiche proprie  
⚠ preview non è ancora view pura  
⚠ giorni/settimane non convertiti automaticamente  
⚠ forme colloquiali durata non implementate    

✔ introduzione EVENT EDITING

- edit_mode per distinzione INSERT / UPDATE
- update_event implementato
- riuso completo pipeline input per modifica

✔ introduzione updated_at

- tracciamento modifiche evento
- base per ordinamento dinamico lista

✔ introduzione NORMALIZATION BASE

- amount numerico coerente
- unit base standardizzate
- formato italiano numerico gestito
- numeri senza unità non interpretati come amount

✔ completamento PREVIEW ALIGNMENT BASE

- amount formattato in stile italiano nella sintesi
- euro mostrato con due decimali
- migliaia visualizzate correttamente
- ore/minuti mostrati con virgola italiana
- singolare/plurale unit gestito
- label ripulita da amount/unit già rappresentati
- bug "minuti" → "uti" risolto
- date separate dalla descrizione anche senza amount
- token tecnici esclusi dall'highlight locale
- nessuna modifica a parser, DB, matching o save flow

✔ completamento ENGINE BASE — DURATION NORMALIZATION

- durata canonica interna definita in minuti
- amount tempo salvato come totale minuti
- unit tempo salvata come "minuti"
- raw_input preservato come testo originario
- conversione ore → minuti implementata
- conversione ore + minuti implementata
- conversione h compatte implementata
- conversione ore decimali implementata
- giorni/settimane riconosciuti come ambigui ma non convertiti
- hint preview per valore normalizzato
- hint preview per durata ambigua
- nessuna modifica DB
- nessuna modifica save flow
- nessuna modifica matching
- nessuna type classification

✔ completamento ENGINE BASE — TYPE CLASSIFICATION BASE

- select1 allineato a ui_state.parsed
- parsed.unit = "minuti" → Tempo
- euro + keyword controllate di uscita → Spesa
- euro + keyword controllate di entrata → Incasso
- euro senza direzione chiara → Evento
- segnali economici contrastanti → Evento
- scelta manuale utente preservata
- type aggiunto al payload di button_input_confirm
- type salvato da insert_event
- type aggiornato da update_event
- events.type ora valorizzato nel DB
- override manuale validato su Spesa / Incasso
- reset/stale value verificato
- nessuna modifica schema DB
- nessuna modifica parser
- nessuna modifica matching
- nessun refactor preview
- nessun output/KPI anticipato

✔ completamento MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL

- project_state aggiornato come fonte minima del matching project
- entity_state aggiornato come fonte minima del matching entity
- output matching arricchito con:
  - matches
  - count
  - hasMatch
  - isAmbiguous
  - singleMatch
  - moreSpecificMatches
  - hasMoreSpecificMatches
- select_project allineato a project_state.data.singleMatch
- select_entity allineato a entity_state.data.singleMatch
- trigger_parse_debounced aggiorna parse_input_controlled + project_state + entity_state
- btn_edit aggiorna parse_input_controlled + project_state + entity_state
- match state live nel create flow
- match state live nell’edit flow
- preview hint allineati a count / isAmbiguous
- preview highlight allineato a matches
- detection locale preview non più usata come fonte decisionale matching
- confirm guard basata su ambiguità non risolta
- ambiguità risolta manualmente non blocca il salvataggio
- nessun match non blocca il salvataggio
- priority match minimo implementato
- match più specifici segnalati con hint informativo non bloccante
- bug €500 nella label preview risolto
- linting project_state/entity_state ripuliti
- DB invariato
- parser invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato

✔ completamento UX / CLEANUP MICRO-BATCH POST MATCH ENGINE

- aggiunto pulsante Annulla in edit mode
- pulsante Annulla visibile solo durante modifica evento
- Annulla resetta edit_mode
- Annulla resetta editing_event
- Annulla resetta input_home / input_raw
- Annulla resetta select_project / select_entity / select1
- Annulla ripristina ui_state.parsed
- Annulla torna alla lista eventi senza update_event
- btn_edit rafforzato per evitare doppia visibilità input/lista
- aggiunta barra ricerca nella lista eventi
- filtro client-side su eventi NEW
- ricerca su raw_input / type / status / nome progetto / nome entità
- nessuna modifica a events_new
- nessuna modifica DB
- corretta label lista eventi creato / modificato
- normalizzazione robusta created_at / updated_at
- confronto date coerente UTC → Europe/Rome
- marcatore leggero per eventi modificati
- aggiunto no-op edit guard in button_input_confirm
- edit senza modifiche reali non esegue update_event
- updated_at non cambia se il payload utente non cambia
- amount / unit / event_date esclusi dal confronto no-op perché derivati dal parser
- fix UI state quando si scrive un nuovo input partendo dalla lista eventi
- create flow validato
- edit flow validato
- annulla modifica validato
- search/filter lista validato
- WRITTEN / ERROR validati
- regressione match/type/duration validata
- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- nessun output/KPI anticipato

✔ completamento LINTING / STATE HELPER CLEANUP

- risolti linting Retool residui:
  - edit_mode: 'value' is not defined
  - editing_event: 'value' is not defined
- rimossa dipendenza da additionalScope { value } per edit_mode / editing_event
- introdotto passaggio controllato tramite window.__logos_edit_mode_value
- introdotto passaggio controllato tramite window.__logos_editing_event_value
- edit_mode legge valore tecnico da window.__logos_edit_mode_value
- editing_event legge valore tecnico da window.__logos_editing_event_value
- dopo lettura gli helper cancellano la chiave window usata
- aggiornato btn_edit
- aggiornato btn_cancel_edit
- aggiornato button_input_confirm:
  - ramo no-op edit guard
  - reset finale dopo salvataggio reale
- reset editing_event aggiunto dopo update reale
- create flow validato
- edit flow validato
- annulla modifica validato
- edit senza modifiche reali validato
- edit con modifica reale validato
- updated_at / label creato-modificato validati
- WRITTEN / ERROR validati
- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- preview invariata
- lista eventi invariata
- nessun output/KPI anticipato

✔ completamento PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL

- introdotto create_suggestion_state
- introdotte variabili project_create_inline_open / project_create_suggestion_dismissed
- introdotte variabili entity_create_inline_open / entity_create_suggestion_dismissed
- introdotta query insert_project
- introdotta query insert_entity
- introdotto container suggestion inline
- introdotto micro-editor inline project
- introdotto micro-editor inline entity
- introdotto ignore globale suggestion
- introdotti bottoni Annulla contestuali per micro-editor
- project create suggestion validata con Villa Sierri 6 / 7 / 15
- entity create suggestion validata con Tecnico Sierri 4 / Referente Kappa
- project/entity possono essere creati solo previa conferma utente
- nessuna creazione automatica silenziosa
- nessuna creazione simultanea project/entity
- una sola creazione guidata aperta alla volta
- entity autofill controlled minimal implementato
- entity autofill validato su referente kappa
- entity autofill non attivo su materiale nuovo
- entity ambigua blocca Conferma e non permette creazione nuova
- project/entity mancanti non bloccano salvataggio
- project/entity ambigui bloccano salvataggio finché non risolti manualmente
- select manuale confermata come decisione utente finale
- raw_input preservato
- evento non salvato automaticamente dopo creazione project/entity
- evento salvato manualmente con project_id/entity_id creati inline
- flow combinato project + entity validato
- regressione create normale validata
- regressione edit/no-op validata
- DB schema invariato
- parser invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato

------------------------------------------------
AGGIORNAMENTO CRITICO — INPUT FLOW
------------------------------------------------

Refactor completo del sistema di parsing:

✔ introduzione parse_input_controlled (parser unico)
✔ eliminazione parse_input come source di verità
✔ introduzione debounce parsing
✔ eliminazione trigger per-lettera
✔ separazione input → parsing → UI
✔ stabilizzazione ui_state.parsed
✔ eliminazione parsing legacy nel bottone confirm

---

ARCHITETTURA ATTUALE:

input_home
→ input_raw
→ trigger_parse_debounced
→ parse_input_controlled
→ ui_state.parsed
→ project_state / entity_state
→ create_suggestion_state
→ select_project / select_entity
→ preview / suggestion container / confirm guard / save / edit

---

SAVE FLOW ATTUALE:

ui_state.parsed
→ button_input_confirm payload
→ insert_event / update_event
→ Supabase
→ events_new refresh

---

RISULTATI:

✔ eliminato loop reattivo critico
✔ parsing stabile
✔ UX fluida (desktop + mobile)
✔ riduzione chiamate inutili
✔ base pronta per input vocale
✔ salvataggio coerente con parser controllato
✔ update coerente con parser controllato
✔ lista eventi aggiornata dopo save concluso

---

PRINCIPIO INTRODOTTO:

→ SINGLE SOURCE OF TRUTH = ui_state.parsed

- preview usa ui_state.parsed
- salvataggio usa ui_state.parsed
- edit usa ui_state.parsed
- insert/update non ricalcolano parsing

✔ eliminata duplicazione parsing
✔ eliminata divergenza save / DB
✔ ridotto rischio drift tra create/edit

PRINCIPIO MATCHING INTRODOTTO:

→ MATCH STATE MINIMO = project_state / entity_state

- project_state calcola il matching project
- entity_state calcola il matching entity
- select_project legge project_state.data.singleMatch
- select_entity legge entity_state.data.singleMatch
- preview legge matches / count / isAmbiguous
- button_input_confirm legge ambiguità non risolta
- edit flow rilancia project_state/entity_state

✔ ridotta duplicazione logiche matching
✔ ridotta divergenza select / preview / hint / confirm
✔ create/edit allineati
✔ utente mantiene controllo finale

PRINCIPIO SUGGESTION INTRODOTTO:

→ CREATE SUGGESTION STATE = helper controllato per creazione project/entity

- create_suggestion_state legge input_raw
- legge project_state / entity_state
- legge projects_list / entities_list
- calcola no-match project/entity
- calcola candidate project controllata
- calcola entity autofill candidate minimale
- alimenta container suggestion inline
- NON crea record
- NON modifica raw_input
- NON decide al posto dell’utente
- NON salva eventi

✔ creazione project/entity resta previa conferma utente
✔ suggestion ignorata non blocca salvataggio
✔ suggestion non equivale a decisione

------------------------------------------------
AGGIORNAMENTO CRITICO — NORMALIZATION LAYER BASE
------------------------------------------------

È stato implementato il primo blocco minimo di Engine Base:

ENGINE BASE — NORMALIZATION LAYER BASE

Obiettivo:

- rendere più coerenti i dati già parsati
- normalizzare amount e unit
- evitare interpretazioni errate di numeri non quantitativi
- mantenere il database invariato
- non introdurre semantica avanzata

---

AMBITO IMPLEMENTATO:

✔ amount normalization  
✔ unit normalization base  
✔ numeri senza unità ignorati come amount  
✔ formato numerico italiano supportato  
✔ insert/update verificati  
✔ refresh lista corretto dopo update  

---

AMBITO ORA EVOLUTO NEL NODO SUCCESSIVO:

✔ conversione ore/minuti implementata in Duration Normalization  
✔ 1 ora e 15 minuti → 75 minuti  
✔ 2h30 → 150 minuti  
✔ 2 ore 30 → 150 minuti  
✔ 1,5 ore → 90 minuti  

AMBITO ANCORA NON IMPLEMENTATO:

✘ conversione automatica giorni / settimane  
✘ giornata lavorativa  
✘ mezza giornata  
✘ parole numeriche tipo “due ore”  
✘ forme colloquiali tipo “un paio d’ore”  
✘ spesa / incasso  

------------------------------------------------
NORMALIZATION RULES — BASE
------------------------------------------------

## UNIT NORMALIZATION

Unità supportate:

EURO:

- €
- euro
- eur

Output normalizzato:

- euro

TEMPO:

- ora
- ore
- h
- min
- minuto
- minuti

Output normalizzato dopo Duration Normalization:

- minuti

Regola:

tutte le durate certe espresse in ore/minuti vengono convertite in minuti.

Formati supportati:

- 1 ora
- 1ora
- 2 ore
- 2ore
- 2h
- h2
- 18 min
- 18min
- 30 minuti
- 30minuti
- min30
- 1,5 ore
- 1.5 ore
- 1,5h
- 1.5h

Conversione canonica:

1 ora → 60 minuti  
1ora → 60 minuti  
2 ore → 120 minuti  
2h → 120 minuti  
h2 → 120 minuti  
18 min → 18 minuti  
18min → 18 minuti  
30 minuti → 30 minuti  
min30 → 30 minuti  
1,5 ore → 90 minuti  
1.5 ore → 90 minuti  
1 ora e 15 minuti → 75 minuti  
2h30 → 150 minuti  
2 ore 30 → 150 minuti  
2 ore e 30 minuti → 150 minuti  

---

## AMOUNT NORMALIZATION

Amount viene salvato come numero, non come stringa localizzata.

Regole:

458,78 → 458.78  
1,5 → 1.5  
1.5 → 1.5  
1.500 → 1500  
1.500,50 → 1500.5  
1500 → 1500  

---

## NUMERI SENZA UNITÀ

Regola:

Se non esiste unità riconosciuta, amount = null.

Esempi:

villa 2 → amount null  
villa 2 mario → amount null  
cliente 2026 → amount null  

Motivo:

- evitare che numeri semantici diventino quantità
- preservare casi come “villa 2”
- ridurre errori permanenti nel DB

---

## DATE

event_date continua a essere gestito dal parser controllato.

Supporto attuale:

- 6/4/26
- 06/04/2026
- 4 aprile

Non implementato:

- oggi
- domani
- ieri
- prossima settimana
- date relative

------------------------------------------------
PREVIEW ALIGNMENT — BASE
------------------------------------------------

È stato completato il nodo:

PREVIEW ALIGNMENT BASE

Obiettivo:

- allineare la sintesi ai dati già normalizzati in ui_state.parsed
- migliorare la leggibilità del dato parsato
- formattare amount/unit in stile italiano
- correggere label cleaning nei casi già normalizzati
- evitare interferenze visuali dell'highlight sulle unità tecniche
- mantenere invariati parser, DB, matching e save flow

---

AMBITO IMPLEMENTATO:

✔ formatAmountIT  
✔ formatUnitIT  
✔ grouping migliaia  
✔ euro con due decimali  
✔ ore/minuti con decimali italiani  
✔ singolare/plurale unit  
✔ label cleaning amount/unit  
✔ rimozione residuo "uti"  
✔ separatore data/descrizione  
✔ previewStopTokens per highlight locale  

---

ESEMPI VALIDATI:

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

---

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

---

AMBITO NON IMPLEMENTATO:

✔ duration normalization implementata nel nodo successivo  
✔ 1 ora e 15 minuti supportato  
✔ 2h30 supportato  
✔ 2 ore 30 supportato  
✘ giorni / settimane non convertiti automaticamente   
✘ type classification  
✘ spesa / incasso  
✘ matching unificato  
✘ preview come view pura completa  

------------------------------------------------
TYPE CLASSIFICATION — BASE
------------------------------------------------

È stato completato il nodo:

ENGINE BASE — TYPE CLASSIFICATION BASE

Obiettivo:

- distinguere in modo controllato Evento / Tempo / Spesa / Incasso
- allineare select1 alla nuova Duration Normalization
- usare ui_state.parsed.unit come segnale primario
- rendere persistente il type nel DB
- mantenere controllo manuale utente
- evitare classificazioni economiche aggressive

---

AMBITO IMPLEMENTATO:

✔ select1 allineato a ui_state.parsed.unit  
✔ parsed.unit = "minuti" → Tempo  
✔ euro + keyword controllate di uscita → Spesa  
✔ euro + keyword controllate di entrata → Incasso  
✔ euro senza direzione chiara → Evento  
✔ segnali contrastanti → Evento  
✔ type aggiunto al payload di button_input_confirm  
✔ insert_event salva events.type  
✔ update_event aggiorna events.type  
✔ override manuale utente validato  
✔ reset/stale value verificato  
✔ DB schema invariato  
✔ parser invariato  
✔ matching invariato  
✔ preview globale invariata  

---

VALORI TYPE ATTUALI:

- Evento
- Tempo
- Spesa
- Incasso

---

REGOLE CONSOLIDATE:

Tempo:

parsed.unit = "minuti"
→ select1 = Tempo

Esempi:

2h30 rendering  
→ type Tempo  
→ amount 150  
→ unit minuti  

1 ora e 45 minuti lavoro  
→ type Tempo  
→ amount 105  
→ unit minuti  

---

Spesa:

euro + keyword controllate di uscita

Esempi:

20 euro spesa materiale  
→ type Spesa  

20 euro acquisto materiale  
→ type Spesa  

20 euro pagato materiale  
→ type Spesa  

20 euro acconto dato  
→ type Spesa  

20 euro saldo pagato  
→ type Spesa  

---

Incasso:

euro + keyword controllate di entrata

Esempi:

20 euro incasso cliente  
→ type Incasso  

20 euro vendita cucciolo  
→ type Incasso  

20 euro acconto ricevuto  
→ type Incasso  

20 euro pagamento ricevuto  
→ type Incasso  

---

Evento / fallback prudente:

euro senza direzione chiara
→ Evento

segnali economici contrastanti
→ Evento

nessuna unit significativa
→ Evento

Esempi:

20 euro materiale  
→ type Evento  

20 euro acconto  
→ type Evento  

20 euro spesa incasso  
→ type Evento  

villa 2 mario  
→ type Evento  

2 giorni rendering  
→ type Evento  

4 aprile benzina 50 euro alfie allevamento aspri  
→ type Evento  

---

REGOLA CRITICA:

La classificazione automatica è prudente.

Il sistema suggerisce una classificazione base,
ma l’utente può sempre modificare select1 manualmente.

La scelta manuale viene salvata in events.type.

---

TEST VALIDATI:

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

Update evento precedente:

1 ora e 45 minuti lavoro  
→ type Tempo  
→ amount 105  
→ unit minuti  
→ updated_at aggiornato  

Override manuale:

20 euro materiale + select1 manuale Spesa  
→ type Spesa  

20 euro materiale + select1 manuale Incasso  
→ type Incasso  

---

AMBITO NON IMPLEMENTATO:

✘ classificazione economica avanzata  
✘ dizionario esteso keyword  
✘ classificazione automatica da parole di dominio  
✘ benzina/materiale/mangime → Spesa automatica  
✘ valori negativi automatici per Spesa  
✘ valori positivi automatici per Incasso  
✘ amount firmato  
✘ direction field  
✘ KPI / dashboard / reportistica  
✘ retro-normalizzazione eventi storici  
✘ bonifica type eventi precedenti  
✘ match engine unification  

---

ANOMALIE RESIDUE:

1. Eventi storici senza type:

eventi creati prima della patch possono avere type null.

Stato:

fuori scope.

Azione futura:

eventuale bonifica solo con nodo dedicato.

---

2. Eventi storici senza type:

eventi creati prima della patch possono avere type null.

Stato:

fuori scope.

Azione futura:

eventuale bonifica solo con nodo dedicato.

------------------------------------------------
AGGIORNAMENTO UX
------------------------------------------------

Il sistema è stato aggiornato nel layer preview/hint:

✔ introduzione hint multipli  
✔ introduzione gerarchia visiva  
✔ eliminazione hint prematuri  
✔ attivazione controllata  
✔ separazione semantica colori  
✔ allineamento visuale amount/unit  
✔ formattazione italiana amount  
✔ separazione data/descrizione  
✔ label cleaning migliorato  
✔ highlight unit-safe  

RISULTATO:

✔ UX più chiara  
✔ nessuna ambiguità nascosta  
✔ miglior supporto decisionale utente  
✔ sintesi più leggibile  
✔ dato visuale coerente con dato normalizzato  
✔ ridotta divergenza parser / preview  
✔ durata visualizzata in forma umana quando internamente normalizzata  
✔ hint “Normalizzato: X minuti” introdotto  
✔ hint durata ambigua per giorni/settimane introdotto  

⚠ hint ancora scollegati da state unificato  
⚠ duplicazione logica detection  
⚠ preview ancora layer ibrido  
⚠ preview non ancora view pura  

------------------------------------------------
COMPONENTI ATTIVI
------------------------------------------------

INPUT LAYER

- input_home (input utente)
- input_raw (adapter tecnico)
- trigger_parse_debounced
- parse_input_controlled

---

NORMALIZATION BASE

- incorporata attualmente in parse_input_controlled
- normalizza amount
- normalizza unit
- normalizza durate certe in minuti
- preserva event_date
- non modifica raw_input
- non modifica DB schema
- non converte automaticamente giorni/settimane

---

TYPE CLASSIFICATION BASE

- select1
- usa ui_state.parsed.unit come segnale primario
- classifica Tempo se unit = minuti
- classifica Spesa / Incasso tramite keyword controllate
- mantiene Evento come default prudente
- mantiene scelta manuale utente
- type salvato in events.type
- non modifica parser
- non modifica matching
- non modifica schema DB

---

MATCHING / SUGGESTION LAYER

- select_project
- select_entity
- project_state
- entity_state
- create_suggestion_state
- project_create_inline_open
- project_create_suggestion_dismissed
- entity_create_inline_open
- entity_create_suggestion_dismissed
- insert_project
- insert_entity
- input_new_project_name
- input_new_entity_name

Principi:

- project_state / entity_state calcolano il match
- create_suggestion_state calcola suggestion controllate
- select_project / select_entity restano decisione utente
- insert_project / insert_entity scrivono solo previa conferma
- raw_input non viene modificato
- evento non viene salvato automaticamente dopo creazione project/entity

---

LABEL LOGIC (EMBEDDED)

- generazione label dentro preview
- pipeline non distruttiva
- cleaning amount/unit aggiornato
- gestione unità compatte migliorata
- preservazione numeri semantici
- NON separata come layer runtime
- NON persistita

---

PROCESSING LAYER

- lista eventi NEW
- gestione WRITTEN / ERROR
- supporto edit su eventi NEW
- supporto annulla modifica
- search/filter client-side lista eventi
- label creato/modificato su lista eventi
- no-op edit guard per evitare update_event senza modifiche reali
- helper edit_mode / editing_event ripuliti da linting Retool

---

UI STATE

ui_state:

{
  view: "home" | "feedback" | "events",
  parsed: {
    amount,
    unit,
    event_date
  },
  status,
  feedback_text,
  feedback_project
}

✔ state centralizzato
✔ parsed sempre strutturato
✔ parsing condiviso tra layer
✔ UI completamente state-driven

HELPER STATE TECNICI:

edit_mode:

- indica se il sistema è in modalità modifica evento
- non usa più additionalScope { value }
- legge valore tecnico da window.__logos_edit_mode_value
- cancella la chiave window dopo la lettura

editing_event:

- conserva l’evento NEW in modifica
- non usa più additionalScope { value }
- legge valore tecnico da window.__logos_editing_event_value
- cancella la chiave window dopo la lettura

Nota:

questi helper non sono fonte business.
Servono solo per controllare il flow edit.

---

FEEDBACK SYSTEM

✔ attivazione immediata
✔ gestione view tramite ui_state
✔ eliminato doppio trigger UI
✔ nessun flash feedback rilevato

FLOW:

submit →
ui_state.view = feedback →
reset input →
insert/update async →
await save →
events_new refresh

---

✔ UX immediata
✔ nessun flicker
✔ feedback consistente
✔ resume basato su ui_state
✔ lista eventi aggiornata dopo save reale

------------------------------------------------
PARSING SYSTEM (STABILIZZATO)
------------------------------------------------

TIPO:

✔ deterministico  
✔ proximity-based  
✔ multi-formato  
✔ normalizzato base  

---

UNITÀ SUPPORTATE

EURO:

€, euro, eur  
€20 / 20€ / € 20  

---

TEMPO:

ore: ora, ore, h  
minuti: min, minuto, minuti  

formati:

2h, h2, 2 h  
1ora, 2ore  
30min, min30, 30 minuti, 30minuti  
0.5h, 1.5 ore, 1,5 ore  

✔ supporto unit compatte senza spazi
✔ supporto forme testuali compatte
✔ conversione canonica ore/minuti in minuti
✔ supporto durate composte
✔ supporto 1 ora e 15 minuti
✔ supporto 2h30
✔ supporto 2 ore 30
✔ supporto ore decimali convertite in minuti

---

ESTRAZIONE AMOUNT

- matchAll numeri
- selezione per prossimità alla unità
- gestione corretta multi-numero
- numero selezionato in base alla unit più rilevante
- nessun amount se manca unità

---

DECIMALI E MIGLIAIA

✔ virgola decimale italiana  
✔ punto decimale compatibile  
✔ punto migliaia italiano  
✔ migliaia + decimali  

Esempi:

1,5 → 1.5  
1.5 → 1.5  
1.500 → 1500  
1.500,50 → 1500.5  

---

GESTIONE ORARI

✔ HH:MM ignorato come amount  

Esempio:

15:30 test → amount null

---

FIX CRITICI INTRODOTTI

✔ eliminato fallback su "h"  
→ evitati falsi positivi ("macchina")

✔ numero finale senza unità ignorato  
→ "villa 2" NON genera amount

✔ gestione corretta unit compatte  
→ "2h", "18min", "0.5h", "1ora", "2ore"

✔ selezione amount corretta su input complessi  
→ "villa 2 mario rossi 3h" → 3

✔ gestione separatore italiano  
→ "1.500,50 euro" → 1500.5

---

LABEL CLEANING

- rimozione amount + unit
- rimozione preposizioni base
- mantenimento significato

⚠ NON utilizzato per persistenza
⚠ NON utilizzato come fonte dati strutturata
⚠ resta logica embedded nella preview

---

LIMITI CONSAPEVOLI

- giorni/settimane non convertiti automaticamente
- giornata/mezza giornata non normalizzate
- parole numeriche tipo “due ore” non supportate
- forme colloquiali tipo “un paio d’ore” non supportate
- parsing non semantico
- type classification non consolidata

---

ARCHITETTURA PARSING (AGGIORNATA)

✔ parsing NON più inline nel save
✔ parsing NON duplicato nel bottone confirm
✔ parsing NON dipendente dal bottone
✔ parsing consumato tramite ui_state.parsed

---

TRIGGER:

✔ debounce
✔ trigger controllato

---

CONSUMO:

✔ preview → ui_state.parsed
✔ save → ui_state.parsed
✔ edit → trigger parse manuale

---

✔ sistema consistente in create/edit
✔ insert verificato
✔ update verificato

------------------------------------------------
LABEL SYSTEM (STABILIZZATO)
------------------------------------------------

TIPO:

✔ deterministico  
✔ non distruttivo  
✔ derivato  
✔ non persistito  

---

PIPELINE:

- normalizzazione testo
- rimozione amount + unit
- gestione unit compatte
- rimozione stopwords base
- numeric safe
- compound token
- sorting alfabetico stabile

---

PRINCIPI:

✔ nessuna perdita informazione
✔ nessuna interpretazione semantica
✔ nessuna modifica DB

---

OUTPUT:

- label coerenti
- variabilità ridotta
- maggiore leggibilità

✔ formattazione italiana amount allineata nella preview  
✔ rimozione amount/unit dalla label migliorata  
✔ bug residuo "uti" risolto  
✔ numeri semantici preservati  

⚠ preview/label non sono ancora view pure  
⚠ logica ancora embedded nella sintesi  
⚠ cleaning non ancora separato come modulo runtime  

------------------------------------------------
MATCHING SYSTEM (UNIFICATO — FIRST CONTROLLED LEVEL)
------------------------------------------------

PRINCIPI:

✔ suggerire ≠ decidere  
✔ no inferenze automatiche definitive  
✔ utente in controllo  
✔ match ambiguo non risolto = blocco conferma  
✔ match ambiguo risolto manualmente = conferma consentita  
✔ nessun match = conferma consentita  

---

FONTE MINIMA MATCHING:

project_state  
entity_state  

Entrambi espongono:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

PROJECT MATCH

- normalizzazione testo base
- match per parole significative
- gestione numeri nei nomi progetto
- full name match
- priority match minimo
- rimozione match generici coperti da match più specifici
- hint informativo per progetti più specifici

Esempi:

villa → Villa + hint progetti più specifici  
villa 2 → Villa 2  
casa mare → Casa Mare  
ristrutturazione bagno → Ristrutturazione Bagno  

---

ENTITY MATCH

- normalizzazione testo base
- match per parole significative
- full name match
- priority match minimo
- rimozione match generici coperti da match più specifici
- hint informativo per entità più specifiche

Esempi:

mario → Mario + hint entità più specifiche  
mario rossi → Mario Rossi + hint entità più specifiche  
mario rossi alfredo → Mario Rossi Alfredo  
alfie mario rossi → ambiguità reale  

---

AUTO-SELECT

✔ solo tramite singleMatch  
✔ select_project legge project_state.data.singleMatch  
✔ select_entity legge entity_state.data.singleMatch  
✔ nessuna forzatura se isAmbiguous = true  
✔ scelta manuale utente preservata  

---

CONFIRM GUARD

Conferma disabilitata se:

- input vuoto
- project ambiguo e select_project vuoto
- entity ambigua e select_entity vuoto

Conferma abilitata se:

- nessun match
- match univoco
- ambiguità risolta manualmente

---

RISULTATI

✔ riduzione logiche parallele  
✔ select / hint / preview / confirm più coerenti  
✔ priority match minimo implementato  
✔ bug ristrutturazione bagno risolto  
✔ bug villa 2 / Villa gestito  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ preview highlight alimentato da matches  
✔ hint ambiguità alimentato da isAmbiguous  

---

LIMITI RESIDUI

⚠ non è un match engine avanzato separato  
⚠ nessun fuzzy matching  
⚠ nessuna gerarchia entity/project  
⚠ nessuna deduplicazione  
⚠ nessun alias system  
⚠ nessuna creazione automatica project/entity  
⚠ preview resta layer ibrido  

---

CREATE SUGGESTION — FIRST CONTROLLED LEVEL

È stato aggiunto un primo livello controllato di creazione project/entity.

Regole:

- nessun match project/entity non blocca il salvataggio
- no-match può generare suggestion inline
- creazione project/entity solo previa conferma utente
- nessuna creazione automatica silenziosa
- suggestion ignorata non blocca salvataggio
- project/entity ambigui non permettono nuova creazione
- project/entity ambigui bloccano Conferma finché non risolti manualmente

Project:

- possibile estensione controllata di project esistenti
- esempio: Villa → Villa Sierri 15
- dopo creazione, select_project viene valorizzata
- evento resta non salvato finché l’utente non clicca Conferma

Entity:

- creazione inline manuale
- entity autofill controlled minimal su prefissi forti
- esempio: referente kappa → Referente Kappa
- dopo creazione, select_entity viene valorizzata
- evento resta non salvato finché l’utente non clicca Conferma

Regola critica:

select_project / select_entity sono decisioni utente.
Valgono anche se il valore selezionato non compare nel raw_input.

------------------------------------------------
PREVIEW SYSTEM
------------------------------------------------

✔ preview = parsing reale + label  
✔ rappresentazione coerente lato utente  
✔ allineata ai dati salvati nei valori principali  
✔ allineata visualmente a ui_state.parsed per amount/unit/date  
✔ amount formattato in stile italiano  
✔ euro con due decimali  
✔ migliaia visualizzate correttamente  
✔ unit tempo coerenti  
✔ singolare/plurale gestito  
✔ date separate correttamente dalla descrizione  
✔ label cleaning migliorato sui casi normalizzati  
✔ highlight unit-safe  

⚠ contiene ancora logiche di trasformazione  
⚠ non è una view pura  
✔ hint ambiguità alimentati da project_state/entity_state  
✔ highlight project/entity alimentato da matches  
✔ detection locale non più usata come fonte decisionale matching  
✔ hint match più specifici introdotti  

⚠ preview resta layer ibrido  
⚠ contiene ancora label cleaning / hint logic / highlight  
⚠ non è ancora view pura    

STRUTTURA:

MAIN:

event_date + amount + unit + label  

META:

project + entity  

HINT:

- suggerimenti matching
- suggerimenti tipo
- hint durata ambigua

✔ supporto multi-hint
✔ hint NON bloccanti

Gerarchia visiva:

- rosso → ambiguità
- arancione → azione richiesta
- grigio → suggerimento soft

---

Esempi validati:

1.500,50 euro materiale
→ 1.500,50 € • materiale

18 minuti test
→ 18 minuti • test

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

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

---

NOTA:

La preview rappresenta meglio i dati normalizzati,
ma resta ancora embedded con:

- label cleaning
- hint logic
- highlight locale
- rendering hint/highlight derivato da match state

La separazione in view pura non è stata implementata.

------------------------------------------------
INSERT
------------------------------------------------

insert_event attivo

Scrittura:

- raw_input
- type
- amount
- unit
- event_date
- project_id
- entity_id
- status = NEW
- updated_at
- payload = {}

✔ amount coerente con ui_state.parsed
✔ unit coerente con ui_state.parsed
✔ type coerente con select1.value
✔ raw_input sempre valorizzato
✔ dati salvati correttamente
✔ nessun blocco runtime attuale
✔ label NON persistita
✔ nessuna validazione bloccante
✔ parser duplicato nel bottone rimosso

Test validato:

1.500,50 euro test engine
→ amount 1500.5
→ unit euro
→ status NEW

------------------------------------------------
UPDATE
------------------------------------------------

update_event attivo

Scrittura:

- raw_input
- type
- amount
- unit
- project_id
- entity_id
- event_date
- updated_at

✔ modifica evento senza duplicazione
✔ riuso pipeline input
✔ update consentito solo su eventi NEW
✔ update usa ui_state.parsed
✔ update aggiorna events.type
✔ DB aggiornato correttamente
✔ lista eventi aggiornata subito dopo save
✔ edit senza modifiche reali non esegue update_event
✔ updated_at non viene aggiornato su conferma senza modifiche
✔ distinzione creato/modificato coerente nella lista eventi

Problema risolto:

- events_new veniva refreshato prima del completamento update_event
- la lista mostrava temporaneamente dati vecchi
- corretto con await savePromise → await events_new.trigger()

------------------------------------------------
DATABASE
------------------------------------------------

Tabelle:

- events
- projects
- entities

---

CARATTERISTICHE:

✔ database passivo
✔ nessuna logica business
✔ nessuna validazione applicativa
✔ presenza campo updated_at
✔ amount numeric
✔ unit text
✔ raw_input preservato
✔ projects popolabili tramite insert_project controllato
✔ entities popolabili tramite insert_entity controllato
✔ creazione project/entity validata da Retool
✔ nessuna logica business nel DB
✔ nessuna creazione automatica lato DB

---

LIMITI:

- entity senza gerarchia
- type utilizzato per classificazione base Evento / Tempo / Spesa / Incasso
- dati storici non normalizzati retroattivamente
- nessun versioning modifiche
- payload non utilizzato
- projects/entities possono ancora contenere dati test se non ripuliti manualmente
- nessun vincolo applicativo avanzato su deduplicazione entity
- nessun audit trail dedicato per creazione project/entity

---

NOTA:

Lo schema DB NON è stato modificato durante il nodo Normalization Layer Base.

------------------------------------------------
PROCESSING
------------------------------------------------

Lista eventi NEW

Azioni:

✔ WRITTEN  
✔ ERROR  

---

✔ decisione manuale
✔ nessuna automazione
✔ supporto EDIT
✔ supporto ANNULLA MODIFICA
✔ filtro ricerca lista eventi
✔ label creato/modificato coerente
✔ marcatore eventi modificati

FLOW:

NEW → EDIT → NEW  
NEW → WRITTEN  
NEW → ERROR  
NEW → EDIT → ANNULLA → NEW
NEW → EDIT senza modifiche → NEW senza update_event

---

Aggiornamento:

- events_new ordinata su updated_at / created_at
- refresh dopo save completato
- update visibile senza refresh pagina

------------------------------------------------
UI ARCHITECTURE
------------------------------------------------

Single Page App (Retool)

Container:

- home
- input
- feedback
- events_list

---

✔ state-driven
✔ nessun routing
✔ logica client-side
✔ gestione stato centralizzata via ui_state
✔ eliminati trigger multipli UI critici
✔ save flow ripulito
✔ bottone confirm non contiene più parsing duplicato

------------------------------------------------
FUNZIONALITÀ IMPLEMENTATE
------------------------------------------------

✔ inserimento eventi rapido  
✔ parsing robusto reale  
✔ supporto varianti input  
✔ normalizzazione amount base  
✔ normalizzazione unit base  
✔ supporto formato numerico italiano  
✔ gestione numeri senza unità  
✔ matching project/entity stabile  
✔ suggerimenti non invasivi  
✔ preview coerente nei dati principali  
✔ allineamento save = DB  
✔ label cleaning non distruttivo  
✔ riduzione variabilità descrizioni  
✔ hint intelligenti  
✔ gestione eventi NEW  
✔ conferma manuale  
✔ UI stabile  
✔ feedback post-insert  
✔ gestione multi-hint  
✔ gerarchia visiva feedback  
✔ controllo attivazione hint  
✔ EVENT EDITING  
✔ UPDATE FLOW  
✔ tracciamento updated_at  
✔ ordinamento eventi per modifica  
✔ centralizzazione UI state  
✔ stabilizzazione feedback flow  
✔ parser duplicato nel bottone rimosso  
✔ refresh lista dopo save completato
✔ preview alignment base completato  
✔ formattazione italiana amount in preview  
✔ euro con due decimali visuali  
✔ grouping migliaia visuale  
✔ unità tempo visualizzate coerentemente  
✔ label cleaning preview aggiornato  
✔ bug "minuti" → "uti" risolto  
✔ date separate correttamente in sintesi  
✔ highlight unit-safe    
✔ duration normalization base completata  
✔ durate certe convertite in minuti  
✔ unità canonica tempo = minuti  
✔ 1 ora e 15 minuti supportato  
✔ 2h30 supportato  
✔ 2 ore 30 supportato  
✔ 1,5 ore convertito in 90 minuti  
✔ preview durata in forma umana  
✔ hint normalizzazione durata  
✔ hint durata ambigua per giorni/settimane 
✔ type classification base completata  
✔ select1 allineato a ui_state.parsed  
✔ parsed.unit = minuti → Tempo  
✔ euro + keyword controllate → Spesa / Incasso  
✔ euro senza direzione chiara → Evento  
✔ type salvato in events.type  
✔ update_event aggiorna type  
✔ override manuale utente validato  
✔ reset/stale value type verificato   
✔ Match Engine Unification First Controlled Level completato  
✔ project_state / entity_state come fonte minima matching  
✔ select_project / select_entity alimentati da singleMatch  
✔ priority match minimo implementato  
✔ hint ambiguità da isAmbiguous  
✔ confirm guard da ambiguità non risolta  
✔ hint match più specifici implementato  
✔ highlight preview da matches  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ bug €500 label preview risolto
✔ annulla modifica evento implementato
✔ edit senza modifiche reali non aggiorna updated_at
✔ search/filter lista eventi implementato
✔ label creato/modificato lista eventi corretta
✔ marcatore visuale per eventi modificati
✔ nuovo input da lista eventi ripristina correttamente la vista input
✔ WRITTEN / ERROR validati dopo cleanup UX 
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ create_suggestion_state implementato
✔ suggestion project controllata implementata
✔ creation project inline implementata
✔ suggestion entity controllata implementata
✔ creation entity inline implementata
✔ insert_project validato
✔ insert_entity validato
✔ project_id valorizzato dopo creazione project
✔ entity_id valorizzato dopo creazione entity
✔ evento salvabile dopo creazione project/entity
✔ evento salvabile anche senza project/entity
✔ blocco solo su ambiguità project/entity attiva
✔ ignore globale suggestion implementato
✔ una sola creazione guidata alla volta
✔ entity autofill controlled minimal implementato
✔ flow combinato project + entity validato   

------------------------------------------------
FUNZIONALITÀ NON IMPLEMENTATE
------------------------------------------------

INPUT

- parsing semantico
- giorni / settimane come conversione automatica
- parole numeriche tipo “due ore”
- forme colloquiali tipo “un paio d’ore”
- date relative

---

NORMALIZATION

- conversione automatica giorni/settimane
- giornata lavorativa
- mezza giornata
- 2 giorni rendering come minuti automatici
- payload duration
- campo duration_minutes dedicato

---

TYPE

- classificazione economica avanzata
- dizionario esteso keyword
- classificazione automatica da parole di dominio
- amount firmato per Spesa/Incasso
- direction field
- retro-normalizzazione type eventi storici
- uso type per KPI avanzati

---

MATCHING

- gerarchia entity
- disambiguazione avanzata
- ranking
- match engine avanzato separato
- fuzzy matching
- alias system
- deduplicazione project/entity
- gerarchie project/entity
- command intent per creazione project/entity
- alias system
- deduplicazione avanzata project/entity
- gerarchie project/entity
- filtro select su match ambigui

---

COMMAND INTENT

- frasi “crea progetto...”
- frasi “crea entità...”
- distinzione comando di sistema / evento operativo
- conferma guidata command intent
- non salvare evento se input è comando puro

---

HINT SYSTEM

- integrazione completa con state unificato
- hint totalmente derivati da engine

---

DATA STRUCTURE

- relazioni entity
- deduplicazione
- normalizzazione relazioni

---

OUTPUT

- dashboard
- analytics
- KPI
- reportistica

------------------------------------------------
PROBLEMI REALI IDENTIFICATI
------------------------------------------------

1. DATA PARZIALMENTE NORMALIZZATI

- amount/unit base ora normalizzati
- durate certe ore/minuti ora normalizzate in minuti
- giorni/settimane non convertiti automaticamente
- dati storici non retro-normalizzati

---

2. PROJECT / ENTITY MIGLIORATE MA NON ANCORA STRUTTURATE

- creazione guidata project/entity implementata a primo livello
- project/entity possono essere creati inline
- select manuale è decisione utente finale
- restano assenti gerarchie
- restano assenti alias
- resta assente deduplicazione avanzata
- resta assente filtro select su match ambigui

---

3. TYPE BASE IMPLEMENTATO MA NON AVANZATO

- type classification base completata
- Evento / Tempo / Spesa / Incasso salvati in events.type
- Spesa / Incasso distinguibili solo tramite keyword controllate o scelta manuale
- euro senza direzione chiara resta Evento
- amount resta positivo
- nessuna logica contabile avanzata
- type non ancora sufficiente da solo per KPI avanzati

---

4. UI LIMITI

- input non multilinea
- preview ancora ibrida
- preview migliorabile come separazione architetturale
- formattazione amount localizzata in preview

---

5. ENGINE PARZIALE

- Normalization Layer Base completato
- engine semantico non implementato
- duration normalization base implementata
- duration avanzata giorni/settimane non implementata
- type classification base implementata
- type classification avanzata non implementata

---

6. MATCHING FIRST LEVEL COMPLETATO, ENGINE AVANZATO NON IMPLEMENTATO

- project_state/entity_state ora fonte minima matching
- select/hint/highlight/confirm allineati a match state
- priority match minimo implementato
- resta assente match engine avanzato separato
- restano assenti alias, gerarchie, deduplicazione e fuzzy matching

---

7. HINT MATCHING ALLINEATI A STATE, HINT GLOBALI ANCORA EMBEDDED

- hint ambiguità project/entity ora leggono isAmbiguous
- hint match più specifici introdotti
- hint durata/type restano embedded nella preview
- preview non è ancora view pura

---

8. PRIORITÀ MATCH MINIMA IMPLEMENTATA

- match generici coperti da match specifici vengono ridotti
- ristrutturazione bagno → Ristrutturazione Bagno
- casa mare → Casa Mare
- villa 2 → Villa 2
- restano fuori scope ranking avanzato e fuzzy matching

---

9. LOOP REATTIVO

RISOLTO per input/parsing principale

---

10. ACCOPPIAMENTO LAYER

- input non completamente separato da processing
- preview non read-only puro
- preview alignment migliorato ma non separato come view pura

---

11. MATCHING UNIFICATO A PRIMO LIVELLO

- project_state/entity_state fonte minima matching
- select_project/select_entity leggono singleMatch
- preview hint/highlight leggono match state
- confirm guard legge ambiguità non risolta
- resta fuori scope engine avanzato separato

---

12. COMMAND INTENT NON IMPLEMENTATO

- input del tipo “crea progetto Aspri” non è ancora gestito come comando
- placeholder “Scrivi cosa vuoi fare...” può generare aspettativa di comandi diretti
- decisione consolidata: non introdurre command intent nel nodo create suggestion
- nodo futuro candidato: COMMAND INTENT — CREATE PROJECT / ENTITY

------------------------------------------------
PROBLEMI RISOLTI
------------------------------------------------

✔ parsing fragile → RISOLTO  
✔ preview incoerente nei dati salvati → RISOLTO  
✔ falsi positivi matching → RIDOTTI  
✔ comportamento non deterministico → RISOLTO  
✔ perdita unit → RISOLTA  
✔ mismatch amount → RISOLTO  
✔ divergenza save / DB → RISOLTA  
✔ variabilità label → RIDOTTA  
✔ rumore UX → RIDOTTO  
✔ unit attaccate → RISOLTE  
✔ unit compatte testuali → RISOLTE  
✔ duplicazione suggerimenti → RISOLTA  
✔ hint incoerenti → RIDOTTI  
✔ hint prematuri → RISOLTI  
✔ perdita multi-anomalia → RISOLTA  
✔ UX hint migliorata → RISOLTA  
✔ loop reattivo input → RISOLTO  
✔ parsing per-lettera → RISOLTO  
✔ duplicazione parsing nel save → RISOLTA  
✔ desync edit/preview → RISOLTO  
✔ errore ui_state.setValue → RISOLTO  
✔ flash UI feedback → RISOLTO  
✔ blocco UX su save → RISOLTO  
✔ amount senza unità → RISOLTO  
✔ formato italiano numerico → RISOLTO  
✔ refresh lista dopo update → RISOLTO 
✔ formattazione amount preview → RISOLTA  
✔ visualizzazione euro italiana → RISOLTA  
✔ grouping migliaia preview → RISOLTO  
✔ bug "minuti" → "uti" → RISOLTO  
✔ duplicazione amount/unit nella label → RIDOTTA  
✔ separatore data/label → RISOLTO  
✔ highlight improprio su unità → RISOLTO  
✔ preview alignment base → COMPLETATO  
✔ duration normalization base → COMPLETATO  
✔ durate ore/minuti non confrontabili → RISOLTE  
✔ 1 ora e 15 minuti non normalizzato → RISOLTO  
✔ 2h30 non normalizzato → RISOLTO  
✔ 2 ore 30 non normalizzato → RISOLTO  
✔ ore decimali non convertite in minuti → RISOLTO  
✔ preview durata tecnica poco leggibile → RISOLTA  
✔ giorni/settimane silenziosi → RIDOTTI tramite hint ambiguità  
✔ select1 non allineato a Duration Normalization → RISOLTO  
✔ 2h30 mostrato come Evento → RISOLTO  
✔ type non persistito in DB → RISOLTO  
✔ insert_event senza type → RISOLTO  
✔ update_event senza type → RISOLTO  
✔ override manuale type non validato → RISOLTO 
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
✔ additionalScope { value } su helper edit mode → RIMOSSO

------------------------------------------------
STATO LAYER SISTEMA
------------------------------------------------

Layer 1 — Input: ~98%
Layer 2 — Matching / Suggestion: ~92%
Layer 3 — View / Preview: ~92%
Layer HINT SYSTEM: ~93%
Layer 4 — Data Structure: ~32%
Layer 5 — Engine: ~46%
Layer 6 — Output: 0%

---

STATO COMPLESSIVO:

~87%

------------------------------------------------
FASE ATTUALE
------------------------------------------------

✔ INPUT RELIABILITY — COMPLETATA  
✔ MATCHING BASE — COMPLETATO  
✔ LABEL QUALITY — COMPLETATO  
✔ EVENT EDITING — COMPLETATO  
✔ INPUT SYSTEM STABILIZATION — COMPLETATA  
✔ ENGINE BASE — NORMALIZATION LAYER BASE — COMPLETATO  
✔ PREVIEW ALIGNMENT BASE — COMPLETATO  
✔ ENGINE BASE — DURATION NORMALIZATION — COMPLETATO  
✔ ENGINE BASE — TYPE CLASSIFICATION BASE — COMPLETATO  
✔ MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL — COMPLETATO 
✔ UX / CLEANUP MICRO-BATCH POST MATCH ENGINE — COMPLETATO 
✔ LINTING / STATE HELPER CLEANUP — COMPLETATO
✔ PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL — COMPLETATO

---

TRANSIZIONE:

→ NEXT NODE DA DEFINIRE IN ROADMAP DOPO AGGIORNAMENTO DOCUMENTALE

------------------------------------------------
OBIETTIVO IMMEDIATO
------------------------------------------------

Dopo il completamento di Project / Entity Create Suggestion First Controlled Level,
il sistema ha consolidato anche la creazione guidata delle strutture trasversali
project/entity.

Catene principali attuali:

amount / unit / event_date:
parse_input_controlled
→ ui_state.parsed
→ insert_event / update_event
→ DB

type:
ui_state.parsed.unit
→ select1.value
→ events.type

project/entity matching:
input_raw
→ project_state / entity_state
→ create_suggestion_state
→ select_project / select_entity
→ events.project_id / events.entity_id

project/entity creation:
create_suggestion_state
→ container suggestion
→ input_new_project_name / input_new_entity_name
→ insert_project / insert_entity
→ projects_list / entities_list refresh
→ select_project / select_entity
→ Conferma evento manuale

processing UX:
events_new
→ lista eventi NEW
→ search/filter client-side
→ edit / annulla / WRITTEN / ERROR

edit flow:
btn_edit
→ editing_event
→ edit_mode
→ input pipeline
→ conferma update oppure no-op guard oppure annulla

La prossima priorità deve essere definita in Roadmap,
senza anticipare output/KPI né istanze verticali.

Nodi candidati principali residui:

- UX CLEANUP — SUGGESTION CONTAINER / MOBILE
- COMMAND INTENT — CREATE PROJECT / ENTITY
- DATA STRUCTURE / ENTITY HIERARCHY
- ECONOMIC DIRECTION ADVANCED
- DURATION ADVANCED — GIORNI / SETTIMANE

Vincolo:

output, dashboard, KPI e istanze verticali restano non attivi finché il Core Event System
non sarà ulteriormente consolidato.

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il sistema:

✔ è funzionale  
✔ è utilizzabile  
✔ è estendibile  
✔ ha una prima base engine reale  
⚠ non è ancora stabile architetturalmente in tutti i layer  

---

DIREZIONE STRATEGICA CONFERMATA:

LOGOS mantiene l’obiettivo di essere un sistema espandibile a blocchi,
fondato su un Core Event System centrale.

Il core attuale è:

input libero
→ interpretazione controllata
→ project / entity / type / amount / date
→ evento normalizzato
→ ledger eventi
→ viste / moduli / dashboard futuri

Le istanze ASPRI / ADEXIMA / MaurizioLab restano derivate future del core,
non nodi da anticipare ora.

Regola anti-deriva:

Non aprire moduli verticali specifici prima che il Core Event System sia consolidato.

Esempi di moduli da NON anticipare ora:

- dashboard ASPRI
- CRM ADEXIMA
- gestione MaurizioLab
- moduli animali / allevamento
- moduli fatture / preventivi
- moduli clienti avanzati

Sequenza corretta futura:

1. consolidare cuore eventi
2. consolidare gestione project/entity
3. introdurre command intent guidato
4. rifinire UX mobile
5. solo dopo aprire viste, istanze o moduli verticali

---

La label è:

→ layer derivato  
→ non persistito  
→ base utile per evoluzione preview / engine  
→ ancora embedded nella preview  

---

Priorità aggiornata:

1. input reliability ✔  
2. label quality ✔  
3. normalization layer base ✔  
4. preview alignment ✔  
5. duration normalization ✔  
6. type classification base ✔  
7. match engine unification first controlled level ✔  
8. UX / cleanup post match engine ✔  
9. linting / state helper cleanup ✔
10. project/entity create suggestion ✔
11. UX cleanup suggestion container / mobile
12. command intent create project/entity
13. data structure / entity relations
14. economic direction advanced
15. output               

---

Il sistema attuale è:

✔ UX-driven  
✔ safe  
✔ non decisionale  
✔ progressivamente normalizzato  

---

PRIORITÀ FUTURE:

1. project/entity create suggestion  
2. data structure / entity relations  
3. economic direction advanced  
4. semantic engine avanzato  
5. dashboard / KPI   

------------------------------------------------
NEXT NODES CANDIDATI
------------------------------------------------

1. UX CLEANUP — SUGGESTION CONTAINER / MOBILE

Scopo:

- rifinire layout container suggestion
- migliorare spaziature e gerarchia visiva
- ottimizzare mobile
- non modificare logica
- non modificare DB
- non modificare matching

---

2. COMMAND INTENT — CREATE PROJECT / ENTITY

Scopo:

- riconoscere frasi tipo “crea progetto Aspri”
- riconoscere frasi tipo “crea entità Patrizio”
- distinguere comando di sistema da evento operativo
- mostrare conferma guidata
- riusare insert_project / insert_entity
- non salvare evento se l’input è comando puro
- evitare creazioni automatiche silenziose

---

3. ECONOMIC DIRECTION ADVANCED

Scopo:

- valutare amount firmato
- valutare direction field
- valutare regole contabili per Spesa/Incasso
- non attivo finché matching/data quality/report readiness non saranno stabilizzati

---

4. DATA STRUCTURE / ENTITY HIERARCHY

Scopo:

- valutare gerarchie
- valutare alias
- valutare deduplicazione
- valutare relazioni entity-project
- non introdurre prima di nodo dedicato

---

5. DURATION ADVANCED — GIORNI / SETTIMANE

Scopo:

- decidere conversione giorni/settimane
- valutare giornata lavorativa
- valutare mezza giornata
- evitare conversioni automatiche ambigue

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01  
documento iniziale  

v02 — 2026-04-02  
parsing retrofit  

v03 — 2026-04-03  
matching retrofit  

v04 — 2026-04-03  
fix insert pipeline  

v05 — 2026-04-04  
introduzione label layer  
implementazione label pipeline  
miglioramento UX hint  
riduzione variabilità descrizioni  

v06 — 2026-04-09  
refinement UX hint  
introduzione multi-hint  
introduzione gerarchia visiva  
emersione criticità matching duplicato  

v07 — 2026-04-22  
introduzione event editing  
implementazione update_event  
introduzione updated_at  

v08 — 2026-04-23  
stabilizzazione UI state  
fix feedback flow  
ordinamento eventi per updated_at  
identificazione loop reattivo  
allineamento stato sistema reale  

v09 — 2026-04-24  
introduzione parse_input_controlled  
introduzione debounce parsing  
eliminazione loop reattivo  
unificazione parsing (single source of truth)  
fix edit mode (trigger parse)  
stabilizzazione UI state  
eliminazione flash feedback  
ottimizzazione UX async save  

v10 — 2026-04-30  
completamento ENGINE BASE — NORMALIZATION LAYER BASE  
stabilizzazione ui_state.parsed  
normalizzazione amount formato italiano  
normalizzazione unit base  
supporto unità compatte testuali  
rimozione amount senza unità  
rimozione parsing legacy da button_input_confirm  
validazione insert con dati normalizzati  
validazione update con dati normalizzati  
fix refresh lista eventi dopo update  
aggiornamento stato Engine da 0% a 15%  
apertura transizione verso Preview Alignment Base  

v11 — 2026-04-30  
completamento PREVIEW ALIGNMENT BASE  
formattazione italiana amount in preview  
introduzione formatAmountIT  
introduzione formatUnitIT  
euro visualizzato con due decimali  
grouping migliaia visuale  
ore/minuti visualizzati coerentemente  
singolare/plurale unit gestito  
label cleaning preview aggiornato  
rimozione amount/unit dalla label migliorata  
risolto bug "minuti" → "uti"  
separatore data/label uniformato  
introduzione previewStopTokens  
highlight unit-safe  
nessuna modifica a parser, DB, matching o save flow  
transizione verso STEP 6.2 — DURATION NORMALIZATION 

v12 — 2026-04-30  
completamento ENGINE BASE — DURATION NORMALIZATION  
definita unità canonica durata in minuti  
durate certe ore/minuti convertite in minuti  
1 ora → 60 minuti  
1,5 ore → 90 minuti  
1 ora e 15 minuti → 75 minuti  
2h30 → 150 minuti  
2 ore 30 → 150 minuti  
aggiornato parse_input_controlled  
aggiornata preview durata con forma umana  
aggiunto hint “Normalizzato: X minuti”  
aggiunto hint durata ambigua per giorni/settimane  
giorni/settimane non convertiti automaticamente  
raw_input preservato  
nessuna modifica DB  
nessuna modifica button_input_confirm  
nessuna modifica insert_event/update_event  
nessuna modifica matching  
nessuna type classification  
insert/update validati runtime con amount/unit normalizzati  
transizione verso STEP 6.3 — TYPE CLASSIFICATION BASE  

v13 — 2026-05-01  
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
matching non unificato confermato come prossimo nodo logico  
transizione verso STEP 6.4 — MATCH ENGINE UNIFICATION  

v14 — 2026-05-02  
completamento MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL  
project_state aggiornato come fonte minima matching project  
entity_state aggiornato come fonte minima matching entity  
aggiunti output matches / count / hasMatch / isAmbiguous / singleMatch / moreSpecificMatches / hasMoreSpecificMatches  
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
transizione verso NEXT NODE da definire in Roadmap

v15 — 2026-05-02  
completamento UX / CLEANUP MICRO-BATCH POST MATCH ENGINE  
aggiunto btn_cancel_edit in edit mode  
Annulla modifica resetta edit_mode / editing_event / input / select / ui_state.parsed  
Annulla torna alla lista eventi senza update_event  
rafforzato btn_edit per evitare doppia visibilità input/lista  
aggiunta barra ricerca lista eventi  
filtro client-side su raw_input / type / status / project / entity  
nessuna modifica a events_new  
corretta label creato/modificato nella lista eventi  
normalizzazione robusta created_at / updated_at  
marcatore leggero per eventi modificati  
aggiunto no-op edit guard in button_input_confirm  
edit senza modifiche reali non esegue update_event  
updated_at non cambia su conferma senza modifiche  
amount / unit / event_date esclusi dal confronto no-op perché derivati dal parser  
fix input_home change handler per nuovo input da lista eventi  
create flow validato  
edit flow validato  
annulla modifica validato  
search/filter lista validato  
WRITTEN / ERROR validati  
regressione match/type/duration validata  
linting edit_mode/editing_event ancora residui non bloccanti  
DB invariato  
parser invariato  
Match Engine invariato  
Type Classification invariata  
Duration Normalization invariata  
nessun output/KPI anticipato  
transizione verso NEXT NODE da definire in Roadmap

v16 — 2026-05-03  
completamento LINTING / STATE HELPER CLEANUP  
risolto linting Retool edit_mode: 'value' is not defined  
risolto linting Retool editing_event: 'value' is not defined  
rimossa dipendenza da additionalScope { value } per edit_mode / editing_event  
introdotto passaggio controllato tramite window.__logos_edit_mode_value  
introdotto passaggio controllato tramite window.__logos_editing_event_value  
edit_mode ora legge valore tecnico da window.__logos_edit_mode_value  
editing_event ora legge valore tecnico da window.__logos_editing_event_value  
gli helper cancellano la chiave window dopo la lettura  
aggiornato btn_edit  
aggiornato btn_cancel_edit  
aggiornato button_input_confirm nel ramo no-op edit guard  
aggiornato button_input_confirm nel reset finale dopo salvataggio reale  
editing_event viene azzerato anche dopo update reale completato  
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
transizione verso NEXT NODE da definire in Roadmap

v17 — 2026-05-07
completamento PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
introdotto create_suggestion_state
introdotte variabili project_create_inline_open / project_create_suggestion_dismissed
introdotte variabili entity_create_inline_open / entity_create_suggestion_dismissed
introdotta query insert_project
introdotta query insert_entity
introdotto container suggestion inline
introdotti micro-editor project/entity
introdotto ignore globale suggestion
introdotti bottoni Annulla contestuali
creazione project inline validata su DB reale
creazione entity inline validata su DB reale
select_project valorizzata dopo creazione project
select_entity valorizzata dopo creazione entity
evento non salvato automaticamente dopo creazione project/entity
evento salvato manualmente con project_id/entity_id corretti
project/entity mancanti non bloccano salvataggio
project/entity ambigui bloccano salvataggio finché non risolti manualmente
select manuale confermata come decisione utente finale
entity autofill controlled minimal implementato
entity autofill validato su Referente Kappa
entity autofill non attivo su materiale nuovo
flow combinato project + entity validato
no-match generico salvabile validato
edit/no-op non regressivo validato
DB schema invariato
parser invariato
type classification invariata
duration normalization invariata
nessun output/KPI anticipato
command intent registrato come nodo futuro
UX cleanup suggestion container registrato come nodo futuro
direzione LOGOS Core modulare riconfermata
istanze ASPRI / ADEXIMA / MaurizioLab confermate come derivate future del core
transizione verso NEXT NODE da definire in Roadmap