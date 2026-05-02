# 02_LOGOS_Match_Engine_v05

DATA: 2026-05-02

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- inclusa logica reale aggiornata post STEP 6.4  
- project_state / entity_state documentati come fonte minima matching  
- coperti project + entity + hint + auto-select + confirm guard  
- documentato singleMatch  
- documentato isAmbiguous  
- documentato moreSpecificMatches  
- documentato priority match minimo  
- documentato create flow con match state live  
- documentato edit flow con match state live  
- documentato rapporto con preview / highlight / hint  
- esplicitati limiti residui  

Q (Qualità): 9.5/10  
- logica matching ora più coerente  
- ridotta duplicazione tra state / select / preview / confirm  
- preview non è più fonte decisionale matching  
- controllo manuale utente preservato  
- nessuna automazione decisionale aggressiva  
- nessuna anticipazione data structure / KPI / output  
- limiti futuri chiari  

D (Deployabilità): 10/10  
- direttamente utilizzabile come riferimento runtime  
- allineato a implementazione Retool reale  
- create flow validato  
- edit flow validato  
- DB invariato  
- parser invariato  
- type classification invariata  
- duration normalization invariata 

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il comportamento reale del sistema di matching
tra input utente e dati esistenti.

Il documento guida:

- suggerimenti automatici
- selezione project/entity
- gestione ambiguità
- comportamento runtime coerente
- identificazione debiti strutturali del matching

------------------------------------------------
PRINCIPI FONDANTI
------------------------------------------------

1. SUGGERIRE ≠ DECIDERE

Il sistema suggerisce, non impone.

---

2. MATCH SOLO SE AFFIDABILE

Auto-selezione solo con certezza reale.

---

3. NO ASSUNZIONI

Nessuna inferenza implicita.

---

4. UTENTE IN CONTROLLO

La selezione finale è sempre manuale.

---

5. RIDUZIONE RUMORE

Il matching deve evitare falsi positivi.

---

6. MATCHING ≠ NORMALIZATION

Il matching non normalizza amount/unit/date.

La normalizzazione base è gestita dal layer input/parser:

parse_input_controlled
→ ui_state.parsed

Il matching resta dedicato a:

- project
- entity
- ambiguità
- suggerimenti

------------------------------------------------
ENTITÀ COINVOLTE
------------------------------------------------

PROJECT:

- projects_list
- struttura: {id, name}

---

ENTITY:

- entities_list
- struttura: {id, name}

------------------------------------------------
POSIZIONE NEL RUNTIME ATTUALE
------------------------------------------------

Il matching opera dentro il seguente flow:

input_home  
→ input_raw  
→ trigger_parse_debounced  
→ parse_input_controlled  
→ ui_state.parsed  
→ project_state / entity_state  
→ select_project / select_entity  
→ preview / hint / highlight  
→ button_input_confirm  

---

Dopo lo STEP 6.4 — MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL:

- amount / unit / event_date restano gestiti da ui_state.parsed
- type resta gestito da select1.value
- project/entity matching è calcolato da project_state / entity_state
- select_project / select_entity leggono singleMatch
- preview hint legge count / isAmbiguous
- preview highlight legge matches
- confirm guard legge ambiguità non risolta

Nota:

Il matching lavora sul testo input_raw,
non sui valori numerici normalizzati.

ui_state.parsed NON è stato esteso a project/entity.
Il matching resta un layer separato.

------------------------------------------------
PIPELINE MATCH
------------------------------------------------

Pipeline attuale post STEP 6.4:

input_raw  
→ project_state / entity_state  
→ matches / count / isAmbiguous / singleMatch  
→ select_project / select_entity  
→ preview hint / highlight  
→ button_input_confirm guard  
→ project_id / entity_id salvati solo se selezionati  

---

Fonte minima osservabile:

project_state  
entity_state  

---

Output standard di project_state / entity_state:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

Principio:

project_state / entity_state calcolano il matching.

select_project / select_entity NON ricalcolano più il matching.
Leggono singleMatch.

preview NON usa più detection locale come fonte decisionale.
Legge matches / count / isAmbiguous.

button_input_confirm NON valuta più direttamente array matches in modo fragile.
Legge ambiguità non risolta.

------------------------------------------------
NORMALIZZAZIONE MATCHING
------------------------------------------------

La normalizzazione testuale del matching è ora concentrata nei due state:

- project_state
- entity_state

Operazioni comuni:

- lowercase
- trim
- compressione spazi
- split parole significative
- full name match
- confronto su parole
- riduzione match generici coperti da match più specifici

---

Distinzione importante:

NORMALIZATION LAYER BASE:

- amount
- unit
- event_date
- duration normalization

Fonte:
parse_input_controlled → ui_state.parsed

MATCH NORMALIZATION:

- testi project/entity
- nomi
- token
- ambiguità
- singleMatch
- moreSpecificMatches

Fonte:
input_raw → project_state / entity_state

---

Regola:

il matching può leggere input_raw perché project/entity sono contenuti nel testo libero.

input_raw NON torna fonte di verità per amount/unit/event_date.

ui_state.parsed resta fonte unica per i dati parsati strutturati.

------------------------------------------------
PROJECT MATCH ATTUALE
------------------------------------------------

Fonte:

project_state

Input:

- input_raw.value
- projects_list.data

Output:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

LOGICA:

1. Normalizzazione testo

- lowercase
- trim
- compressione spazi

2. Match base

- confronto su parole significative del nome progetto
- parole del progetto devono essere presenti nel testo input
- gestione numeri nei nomi progetto

3. Gestione numeri

Se il progetto contiene numeri,
gli stessi numeri devono essere presenti nell’input.

Esempio:

Villa 2
→ richiede presenza di 2 nell’input

Questo evita che:

villa
→ selezioni Villa 2

ma consente:

villa 2
→ selezioni Villa 2

4. Full name match

Se il nome completo del progetto è presente nel testo,
viene considerato match forte.

5. Priority match minimo

Se esistono match generici e match più specifici,
vengono rimossi i generici coperti dallo specifico.

Esempi:

Ristrutturazione + Ristrutturazione Bagno
→ Ristrutturazione Bagno

Casa + Casa Mare
→ Casa Mare

Villa + Villa 2
→ Villa 2

6. More specific hint

Se il match esatto breve è valido,
ma esistono progetti più specifici,
il sistema mantiene il match e mostra hint informativo non bloccante.

Esempio:

villa
→ select_project = Villa
→ hint: Esistono progetti più specifici

---

COMPORTAMENTO:

count = 1  
→ singleMatch valorizzato  
→ select_project auto-valorizzato  

count > 1  
→ isAmbiguous = true  
→ select_project vuoto  
→ hint rosso se non risolto  
→ confirm disabilitato finché l’utente non sceglie  

count = 0  
→ nessun suggerimento  
→ select_project vuoto  
→ confirm non bloccato  

---

NOTE:

- project_id viene salvato solo da select_project.value
- il sistema non crea project automaticamente
- il sistema non decide project in caso di ambiguità non risolta
- la scelta manuale utente prevale

------------------------------------------------
ENTITY MATCH ATTUALE
------------------------------------------------

Fonte:

entity_state

Input:

- input_raw.value
- entities_list.data

Output:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

LOGICA:

1. Normalizzazione testo

- lowercase
- trim
- compressione spazi

2. Match base

- confronto su parole significative del nome entità
- parole dell’entità devono essere presenti nel testo input

3. Full name match

Se il nome completo dell’entità è presente nel testo,
viene considerato match forte.

4. Priority match minimo

Se esistono match generici e match più specifici,
vengono rimossi i generici coperti dallo specifico.

Esempi:

Marco + Marco Rossi
→ Marco Rossi

Mario + Mario Rossi
→ Mario Rossi

Mario Rossi + Mario Rossi Alfredo
→ Mario Rossi Alfredo, quando il nome completo è presente

5. More specific hint

Se il match esatto breve è valido,
ma esistono entità più specifiche,
il sistema mantiene il match e mostra hint informativo non bloccante.

Esempi:

mario
→ select_entity = Mario
→ hint: Esistono entità più specifiche

mario rossi
→ select_entity = Mario Rossi
→ hint: Esistono entità più specifiche se esiste Mario Rossi Alfredo

mario rossi alfredo
→ select_entity = Mario Rossi Alfredo
→ nessun hint più specifico

---

COMPORTAMENTO:

count = 1  
→ singleMatch valorizzato  
→ select_entity auto-valorizzato  

count > 1  
→ isAmbiguous = true  
→ select_entity vuoto  
→ hint rosso se non risolto  
→ confirm disabilitato finché l’utente non sceglie  

count = 0  
→ nessun suggerimento  
→ select_entity vuoto  
→ confirm non bloccato  

---

NOTE:

- entity_id viene salvato solo da select_entity.value
- il sistema non crea entity automaticamente
- il sistema non decide entity in caso di ambiguità non risolta
- la scelta manuale utente prevale
- la presenza di duplicati o entità simili resta un limite strutturale

------------------------------------------------
AUTO-SELECT LOGIC
------------------------------------------------

Auto-select SOLO tramite:

project_state.data.singleMatch  
entity_state.data.singleMatch  

---

select_project:

legge project_state.data.singleMatch

Se singleMatch esiste:
→ select_project = singleMatch.id

Altrimenti:
→ select_project = null

---

select_entity:

legge entity_state.data.singleMatch

Se singleMatch esiste:
→ select_entity = singleMatch.id

Altrimenti:
→ select_entity = null

---

NON auto-select se:

- isAmbiguous = true
- count > 1
- nessun match
- valore manuale già scelto dall’utente in caso di ambiguità risolta

---

Regola:

il match engine suggerisce.
La select è la fonte finale salvabile.
L’utente mantiene controllo.

------------------------------------------------
GESTIONE AMBIGUITÀ
------------------------------------------------

Ambiguità calcolata da:

project_state.data.isAmbiguous  
entity_state.data.isAmbiguous  

---

CASO 1 — Ambiguità non risolta

Condizione:

project_state.isAmbiguous = true
e select_project vuoto

oppure:

entity_state.isAmbiguous = true
e select_entity vuoto

Comportamento:

- mostra hint rosso
- non auto-seleziona
- button_input_confirm disabilitato

---

CASO 2 — Ambiguità risolta manualmente

Condizione:

project_state.isAmbiguous = true
ma select_project valorizzato manualmente

oppure:

entity_state.isAmbiguous = true
ma select_entity valorizzato manualmente

Comportamento:

- hint rosso rimosso
- button_input_confirm abilitato
- valore scelto dall’utente viene salvato

---

CASO 3 — Nessun match

Condizione:

count = 0

Comportamento:

- nessun hint ambiguità
- select vuota
- confirm non bloccato

Motivo:

LOGOS deve restare non bloccante.
La creazione guidata project/entity sarà nodo futuro dedicato.

---

Confirm guard finale:

Conferma disabilitata se:

- input vuoto
- project ambiguo e select_project vuoto
- entity ambigua e select_entity vuoto

Conferma abilitata se:

- match univoco
- nessun match
- ambiguità risolta manualmente

------------------------------------------------
HINT SYSTEM
------------------------------------------------

Per il matching project/entity,
gli hint sono ora alimentati da project_state / entity_state.

---

HINT AMBIGUITÀ:

entity_state.isAmbiguous = true
e select_entity vuoto
→ "Più entità trovate"

project_state.isAmbiguous = true
e select_project vuoto
→ "Più progetti trovati"

---

HINT MATCH PIÙ SPECIFICI:

entity_state.hasMoreSpecificMatches = true
e singleMatch selezionato
→ "Esistono entità più specifiche"

project_state.hasMoreSpecificMatches = true
e singleMatch selezionato
→ "Esistono progetti più specifici"

---

Caratteristiche:

- hint ambiguità = bloccante finché non risolto
- hint match più specifici = informativo non bloccante
- nessuna inferenza automatica definitiva
- controllo utente preservato

---

Nota:

gli hint matching sono ora più state-driven.

Restano embedded nella preview altri hint:

- type / Spesa / Incasso
- durata normalizzata
- durata ambigua

Questi non sono stati separati in un hint engine globale.

------------------------------------------------
RELAZIONE CON PREVIEW
------------------------------------------------

La preview utilizza project_state / entity_state per:

- mostrare hint ambiguità
- mostrare hint match più specifici
- evidenziare project/entity
- supportare la scelta utente

---

Dopo STEP 6.4:

la preview NON usa più detection locale project/entity
come fonte decisionale matching.

Prima:

preview calcolava detectedProjects / detectedEntities
con logica token-based locale.

Dopo:

preview legge:

- project_state.data.matches
- entity_state.data.matches
- project_state.data.count
- entity_state.data.count
- project_state.data.isAmbiguous
- entity_state.data.isAmbiguous
- project_state.data.hasMoreSpecificMatches
- entity_state.data.hasMoreSpecificMatches

---

Highlight:

- project evidenziati da project_state.matches
- entity evidenziate da entity_state.matches
- nome completo evidenziato quando presente

Esempio:

villa 2 mario
→ villa 2 evidenziato come project
→ mario evidenziato come entity

---

Nota:

La preview resta layer ibrido:

- rendering
- label cleaning
- hint logic
- highlight
- formattazione visuale

Ma non è più fonte autonoma decisionale per il matching.

------------------------------------------------
RELAZIONE CON NORMALIZATION LAYER BASE
------------------------------------------------

Il Normalization Layer Base ha migliorato:

- amount
- unit
- event_date
- save flow
- insert/update
- qualità del payload DB

---

Non ha modificato:

- project matching
- entity matching
- hint matching
- auto-select
- preview detection
- priority match
- ranking

---

Effetto indiretto positivo:

poiché numeri senza unità non diventano più amount,
casi come:

villa 2 mario

mantengono meglio il valore semantico del numero nella label/preview.

Tuttavia:

- il matching resta testuale
- non usa ancora una normalizzazione unica
- non è stato rifattorizzato

------------------------------------------------
CASI NON SUPPORTATI
------------------------------------------------

- sinonimi
- errori ortografici
- abbreviazioni complesse
- fuzzy matching
- gerarchie project/entity
- relazioni entity-project
- match storico
- ranking basato su frequenza
- ranking avanzato
- disambiguazione automatica
- alias controllati
- creazione guidata project/entity

---

Motivo:

evitare inferenze errate
e mantenere controllo utente.

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- nessuna gerarchia entity/project
- nessun alias system
- nessun fuzzy matching
- nessun ranking avanzato
- nessuna deduplicazione entity/project
- nessuna relazione entity-project
- nessun match storico
- nessuna creazione guidata project/entity
- nessun pending state per nuovi project/entity
- preview ancora layer ibrido
- hint duration/type ancora embedded nella preview
- match engine avanzato separato non implementato

---

Risolto a primo livello:

✔ duplicazione state / select ridotta  
✔ preview detection non più fonte decisionale  
✔ hint ambiguità matching allineati a state  
✔ priority match minimo implementato  
✔ confirm guard coerente con ambiguità non risolta  
✔ create/edit flow allineati  

------------------------------------------------
PROBLEMA STRUTTURALE CRITICO — STATO AGGIORNATO
------------------------------------------------

Prima dello STEP 6.4 esistevano 3 sistemi di matching indipendenti:

1. PROJECT_STATE / ENTITY_STATE

- calcolo matches
- non sempre live
- non pienamente usato da select / preview / confirm

2. SELECT MATCHING / DETERMINISTICO

- ricalcolava matching nel Default value
- poteva divergere da project_state/entity_state

3. PREVIEW DETECTION / TOKEN-BASED

- ricalcolava detection locale
- alimentava highlight e parte degli hint
- poteva divergere da select e state

---

Conseguenze precedenti:

- incoerenza risultati
- duplicazione logica
- difficoltà debugging
- hint non sempre coerenti
- rischio divergenza tra ciò che si vede e ciò che viene selezionato

---

STATO DOPO STEP 6.4:

✔ project_state / entity_state sono fonte minima matching  
✔ select_project / select_entity leggono singleMatch  
✔ preview hint legge isAmbiguous  
✔ preview highlight legge matches  
✔ confirm guard legge ambiguità non risolta  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ priority match minimo implementato  

---

STATO:

RISOLTO A PRIMO LIVELLO CONTROLLATO

---

Non ancora risolto:

- match engine avanzato separato
- fuzzy matching
- alias
- deduplicazione
- gerarchie
- relazioni entity-project
- creazione guidata project/entity

------------------------------------------------
TARGET FUTURO — MATCH ENGINE EVOLUTION
------------------------------------------------

Lo STEP 6.4 ha completato:

MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL

Non riaprire come nodo base.

---

Evoluzioni future possibili solo come nodi dedicati:

1. ALIAS / SYNONYMS CONTROLLED MATCHING

- alias project/entity
- abbreviazioni controllate
- sinonimi validati
- nessun fuzzy aggressivo

2. DATA STRUCTURE / ENTITY HIERARCHY

- gerarchie entity/project
- parent_entity_id / parent_project_id
- relazioni entity-project
- deduplicazione

3. PROJECT / ENTITY CREATE SUGGESTION

- nessun match trovato
- proposta di creazione guidata
- creazione solo previa conferma utente
- utile per input vocali / Siri
- evitare duplicati

4. MATCH CONFIDENCE / RANKING ADVANCED

- ranking più evoluto
- confidence controllata
- audit ambiguità

---

Vincoli futuri:

- nessuna auto-decisione se ambiguo
- nessuna creazione automatica silenziosa
- nessun fuzzy aggressivo senza controllo
- utente sempre in controllo
- output/KPI non anticipati

------------------------------------------------
EVOLUZIONE FUTURA NON ATTIVA
------------------------------------------------

- alias/sinonimi controllati
- fuzzy matching
- ranking per frequenza
- storico selezioni
- entity hierarchy
- project hierarchy
- relazioni entity-project
- deduplicazione
- creazione guidata project/entity
- pending state per nuovi project/entity
- confidence score
- audit ambiguità

------------------------------------------------
OBIETTIVO MATCH ENGINE
------------------------------------------------

Ridurre ambiguità mantenendo controllo utente.

---

Deve:

- suggerire
- evidenziare
- bloccare ambiguità quando necessario
- mantenere coerenza tra select e preview
- ridurre falsi positivi

---

NON deve:

- automatizzare completamente
- interpretare intenzione utente in modo nascosto
- creare project/entity
- forzare selezioni ambigue
- sostituire la validazione utente

---

Stato attuale:

Il primo livello controllato è stato implementato.
Il Match Engine ora riduce le divergenze tra state, select, preview e confirm.

Il prossimo livello non è “rifare il Match Engine”,
ma evolverlo tramite nodi dedicati.

------------------------------------------------
STATO ATTUALE
------------------------------------------------

✔ matching base funzionante  
✔ Match Engine Unification First Controlled Level completato  
✔ project_state / entity_state fonte minima matching  
✔ select_project / select_entity alimentati da singleMatch  
✔ auto-select limitato ai casi univoci  
✔ ambiguità bloccanti gestite tramite isAmbiguous  
✔ ambiguità risolta manualmente consente conferma  
✔ nessun match non blocca conferma  
✔ preview hint matching allineati a state  
✔ preview highlight alimentato da matches  
✔ priority match minimo implementato  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ utente mantiene controllo  

---

⚠ match engine avanzato separato non implementato  
⚠ preview ancora ibrida  
⚠ hint duration/type ancora embedded nella preview  
⚠ nessuna gerarchia  
⚠ nessun alias system  
⚠ nessuna deduplicazione  
⚠ nessuna creazione guidata project/entity  
⚠ non ancora pronto per output/KPI affidabili senza ulteriori nodi data/economic/report readiness

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01  
- definizione base matching

v02 — 2026-04-03  
- retrofit entity matching  
- introduzione token significativi  
- eliminazione partial match aggressivo  
- riduzione falsi positivi  
- allineamento con runtime reale

v03 — 2026-04-23  
- identificazione sistemi di matching multipli  
- documentazione incoerenza strutturale  
- introduzione problema unificazione matching  
- allineamento con stato reale sistema

v04 — 2026-04-30  
- chiarito che Normalization Layer Base non ha modificato il matching  
- aggiornato rapporto tra matching e ui_state.parsed  
- esplicitato che amount/unit normalization è separata dal match engine  
- confermato problema strutturale dei tre sistemi di matching paralleli  
- definito Match Engine Unification come nodo futuro dedicato  
- confermato che priority match resta non implementato
v05 — 2026-05-02  
- completamento MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL  
- project_state aggiornato come fonte minima matching project  
- entity_state aggiornato come fonte minima matching entity  
- aggiunti output matches / count / hasMatch / isAmbiguous / singleMatch / moreSpecificMatches / hasMoreSpecificMatches  
- select_project allineato a project_state.data.singleMatch  
- select_entity allineato a entity_state.data.singleMatch  
- trigger_parse_debounced aggiorna parse_input_controlled + project_state + entity_state  
- btn_edit aggiorna parse_input_controlled + project_state + entity_state  
- match state live in create flow  
- match state live in edit flow  
- preview hint ambiguità allineati a isAmbiguous  
- preview highlight alimentato da matches  
- detection locale preview rimossa come fonte decisionale matching  
- confirm guard basata su ambiguità non risolta  
- ambiguità risolta manualmente non blocca salvataggio  
- nessun match non blocca salvataggio  
- priority match minimo implementato  
- ristrutturazione bagno → Ristrutturazione Bagno  
- casa mare → Casa Mare  
- villa 2 → Villa 2  
- hint informativo match più specifici introdotto  
- mario → Mario + hint entità più specifiche  
- villa → Villa + hint progetti più specifici  
- bug €500 nella label preview risolto  
- linting project_state/entity_state ripuliti  
- linting residui edit_mode/editing_event mantenuti come nodo futuro  
- nessuna modifica DB  
- nessuna modifica parser  
- nessuna modifica type classification  
- nessuna modifica duration normalization  
- nessun output/KPI anticipato