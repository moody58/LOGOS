# 02_LOGOS_Match_Engine_v07

DATA: 2026-05-13

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
- documentato rapporto tra match state e create_suggestion_state
- documentato Project / Entity Create Suggestion First Controlled Level
- documentato che la suggestion consuma il matching ma non lo sostituisce
- documentata creazione project/entity solo previa conferma utente
- documentata regola select = decisione utente finale
- documentato blocco solo su ambiguità attiva
- documentato entity autofill controlled minimal come supporto suggestion, non matching  
- documentato Command Intent — Create Project / Entity
- chiarito che command_intent_state non è parte del Match Engine
- chiarito che command_intent_state non sostituisce project_state / entity_state
- chiarito che command_intent_state non sostituisce create_suggestion_state
- documentato che i comandi puri non entrano nel save flow evento
- documentato blocco duplicati project/entity esistenti da command
- documentata separazione tra matching, suggestion e command intent

Q (Qualità): 9.5/10  
- logica matching ora più coerente  
- ridotta duplicazione tra state / select / preview / confirm  
- preview non è più fonte decisionale matching  
- controllo manuale utente preservato  
- nessuna automazione decisionale aggressiva  
- nessuna anticipazione data structure / KPI / output  
- limiti futuri chiari  
- chiarita separazione tra match, suggestion e salvataggio
- mantenuto il match engine non decisionale
- ridotto rischio di confondere no-match con errore bloccante
- preservata coerenza con Core Event System incrementale
- Command Intent integrato come layer separato e non concorrente al matching
- evitata duplicazione tra match engine e command intent
- chiarito che la rilevazione “elemento già presente” da command è una guardia UI, non deduplicazione strutturale
- mantenuto il principio select = decisione finale per gli eventi ordinari

D (Deployabilità): 10/10  
- direttamente utilizzabile come riferimento runtime  
- allineato a implementazione Retool reale  
- create flow validato  
- edit flow validato  
- DB invariato  
- parser invariato  
- type classification invariata  
- duration normalization invariata 
- Project / Entity Create Suggestion validato runtime
- flow combinato project + entity validato
- no-match generico salvabile validato
- edit/no-op non regressivo validato dopo create suggestion
- Command Intent — Create Project / Entity validato runtime
- evento ordinario non regressivo dopo Command Intent validato
- edit flow non regressivo dopo Command Intent validato
- comandi puri create project/entity esclusi dal save flow evento
- command_intent_state validato come helper separato dal matching

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
- rapporto tra matching e create suggestion
- distinzione tra match, suggestion, select e insert
- distinzione tra match engine, create suggestion e command intent
- rapporto tra project_state/entity_state e command_intent_state
- limiti del command intent rispetto al matching

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

---

7. MATCHING ≠ CREAZIONE

Il matching non crea project/entity.

La creazione guidata è gestita dal layer successivo:

create_suggestion_state
→ container suggestion
→ conferma utente
→ insert_project / insert_entity

Il matching alimenta la suggestion,
ma non scrive dati nel DB.

---

8. SELECT = DECISIONE UTENTE

La select resta la decisione finale salvabile.

select_project.value → events.project_id
select_entity.value → events.entity_id

La selezione manuale è valida anche se il valore selezionato
non è presente nel raw_input.

---

9. MATCHING ≠ COMMAND INTENT

Il Match Engine riconosce project/entity dentro input evento ordinario.

Il Command Intent riconosce comandi strutturali puri.

Esempi command intent:

- crea
- crea progetto
- crea progetto Villa Nuova
- crea entità Patrizio
- modifica evento

Regole:

- command_intent_state NON è il Match Engine
- command_intent_state NON sostituisce project_state / entity_state
- command_intent_state NON sostituisce create_suggestion_state
- command_intent_state NON salva eventi
- command_intent_state NON decide project_id/entity_id negli eventi ordinari
- command_intent_state può verificare se un project/entity esiste già
- la verifica “elemento già presente” è una guardia UI, non deduplicazione strutturale DB
- i comandi puri vengono esclusi dal save flow evento
- select_project / select_entity restano la decisione finale salvabile per eventi ordinari

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
→ command_intent_state  
→ parse_input_controlled  
→ ui_state.parsed  
→ project_state / entity_state  
→ create_suggestion_state  
→ select_project / select_entity  
→ preview / hint / highlight / suggestion container  
→ oppure container_command_intent  
→ button_input_confirm oppure command action  

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

Dopo PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL:

- create_suggestion_state consuma project_state / entity_state
- no-match project/entity può generare suggestion controllata
- project/entity possono essere creati inline solo previa conferma utente
- insert_project / insert_entity non sono parte del matching
- evento non viene salvato automaticamente dopo creazione project/entity
- select_project / select_entity restano fonte finale salvabile

Dopo COMMAND INTENT — CREATE PROJECT / ENTITY:

- command_intent_state riconosce comandi puri
- command_intent_state resta separato dal Match Engine
- command_intent_state non calcola il match primario project/entity per gli eventi
- command_intent_state può rilevare project/entity già esistenti per evitare duplicazioni da command
- container_command_intent sostituisce Sintesi evento / Dati evento quando l’input è comando puro
- i comandi puri non vengono salvati come eventi
- insert_project / insert_entity vengono usati solo dopo conferma utente
- button_input_confirm resta dedicato agli eventi ordinari

------------------------------------------------
PIPELINE MATCH
------------------------------------------------

Pipeline match attuale post PROJECT / ENTITY CREATE SUGGESTION FIRST CONTROLLED LEVEL:

input_raw  
→ project_state / entity_state  
→ matches / count / isAmbiguous / singleMatch  
→ create_suggestion_state  
→ select_project / select_entity  
→ preview hint / highlight / suggestion container  
→ button_input_confirm guard  
→ project_id / entity_id salvati solo se selezionati   

Pipeline command separata:

input_raw  
→ command_intent_state  
→ container_command_intent  
→ btn_command_create_project / btn_command_create_entity / btn_command_go_events  
→ insert_project / insert_entity oppure Lista eventi  

Nota:

questa pipeline NON è Match Engine.

Serve a intercettare comandi puri prima che vengano trattati come eventi.

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

create_suggestion_state legge il risultato del matching
e genera eventuali suggestion controllate.

create_suggestion_state NON calcola il match primario.
create_suggestion_state NON salva dati.
create_suggestion_state NON decide project/entity al posto dell’utente.

select_project / select_entity NON ricalcolano più il matching.
Leggono singleMatch.

preview NON usa più detection locale come fonte decisionale.
Legge matches / count / isAmbiguous.

button_input_confirm NON valuta più direttamente array matches in modo fragile.
Legge ambiguità non risolta.

command_intent_state NON modifica questa regola.

Per gli eventi ordinari:

- project_state resta fonte minima matching project
- entity_state resta fonte minima matching entity
- select_project / select_entity restano fonti salvabili
- button_input_confirm resta il punto di conferma evento

Per i comandi puri:

- il flow evento viene escluso
- container_command_intent usa azioni command dedicate
- nessun project_id/entity_id viene salvato in events

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
- project_state non crea project automaticamente
- eventuale creazione project è gestita da create_suggestion_state + insert_project
- eventuale creazione project da comando puro è gestita da command_intent_state + btn_command_create_project + insert_project
- il command intent non modifica il comportamento di project_state
- la creazione project richiede conferma esplicita utente
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
- entity_state non crea entity automaticamente
- eventuale creazione entity è gestita da create_suggestion_state + insert_entity
- eventuale creazione entity da comando puro è gestita da command_intent_state + btn_command_create_entity + insert_entity
- il command intent non modifica il comportamento di entity_state
- la creazione entity richiede conferma esplicita utente
- il sistema non decide entity in caso di ambiguità non risolta
- la scelta manuale utente prevale
- la presenza di duplicati o entità simili resta un limite strutturale

---

RELAZIONE CON CREATE SUGGESTION:

Se project_state rileva un match base valido e create_suggestion_state
individua una possibile estensione non ancora presente,
il sistema può proporre la creazione di un nuovo project.

Esempio:

input:
villa sierri 15 sopralluogo

project_state:
singleMatch = Villa

create_suggestion_state:
candidateName = Villa Sierri 15

Azione utente:
Crea progetto → insert_project → select_project = Villa Sierri 15

Nota:

questo non modifica la regola del matching.
Villa resta match base reale.
Villa Sierri 15 è una suggestion di creazione controllata.

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

Dopo Project / Entity Create Suggestion First Controlled Level,
il nessun match può generare una suggestion controllata,
ma non blocca il salvataggio.

L’utente può:

- creare project/entity inline
- ignorare la suggestion
- salvare evento con project_id/entity_id null

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

---

Regola post create suggestion:

project/entity mancanti ≠ blocco.

project/entity ambigui = blocco finché non risolti manualmente.

La suggestion non cambia il confirm guard:
lo arricchisce solo con un percorso guidato opzionale.

Il command intent non cambia il confirm guard degli eventi ordinari.

Se l’input è comando puro:

- il confirm guard evento non viene usato
- button_input_confirm non deve essere mostrato
- container_command_intent gestisce la guida o l’azione controllata

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

---

HINT / SUGGESTION DISTINCTION:

Hint informativo:

- segnala stato del match
- non apre insert
- non scrive DB

Suggestion create:

- propone azione guidata
- richiede conferma utente
- può eseguire insert_project / insert_entity
- non salva evento automaticamente

Esempio:

“Esistono progetti più specifici”
→ hint informativo

“Possibile nuovo progetto: Villa Sierri 15”
→ suggestion create

Command intent:

- riconosce comando strutturale puro
- non è un hint matching
- non è suggestion create dentro evento
- non salva evento
- può proporre creazione project/entity solo come azione command dedicata

Esempio:

“crea progetto Villa Nuova”
→ command intent
→ container_command_intent
→ btn_command_create_project
→ insert_project
→ nessun evento salvato

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

Dopo Command Intent:

la preview non deve rappresentare comandi puri come eventi.

Esempi:

crea progetto Villa Nuova
→ non deve mostrare Sintesi evento
→ deve mostrare container_command_intent

crea entità Patrizio
→ non deve mostrare Sintesi evento
→ deve mostrare container_command_intent

modifica evento
→ non deve mostrare Sintesi evento
→ deve mostrare guida command

Il command intent quindi riduce un caso di falsa preview evento,
ma non rende la preview un layer puro.

------------------------------------------------
RELAZIONE CON CREATE SUGGESTION
------------------------------------------------

create_suggestion_state è un layer successivo al matching.

Consuma:

- input_raw.value
- project_state.data
- entity_state.data
- projects_list.data
- entities_list.data
- select_project.value
- select_entity.value

Produce:

- project.noMatch
- project.shouldShowNoMatchHint
- project.shouldSuggestCreate
- project.candidateName
- project.draftName
- entity.noMatch
- entity.shouldShowNoMatchHint
- entity.shouldSuggestCreate
- entity.candidateName
- entity.draftName

Non produce:

- project_id salvabile direttamente
- entity_id salvabile direttamente
- amount
- unit
- event_date
- type

Regole:

- suggestion ≠ match
- suggestion ≠ decisione
- suggestion ≠ salvataggio evento
- suggestion ignorata non blocca conferma
- creazione project/entity richiede conferma utente
- evento resta non salvato dopo creazione project/entity

---

PROJECT CREATE SUGGESTION

Attiva quando:

- esiste una candidate controllata
- non c’è ambiguità project
- la candidate non esiste già
- l’utente conferma la creazione

Esempio:

villa sierri 15 sopralluogo
→ candidate project: Villa Sierri 15

---

ENTITY CREATE SUGGESTION

Attiva quando:

- entity no-match reale
- entity non ambigua
- nessuna entity già selezionata
- l’utente conferma la creazione

Entity autofill controlled minimal:

- solo su prefissi forti
- non crea entity automaticamente
- non seleziona entity automaticamente
- precompila solo input_new_entity_name

Esempio:

referente kappa
→ draft entity: Referente Kappa

---

AMBIGUITÀ E CREATE SUGGESTION

Se project/entity è ambiguo:

- create suggestion non viene mostrata per quel layer
- Conferma resta disabilitata finché l’utente non sceglie manualmente

Motivo:

non proporre creazioni nuove quando il sistema ha già più match possibili.

------------------------------------------------
RELAZIONE CON COMMAND INTENT
------------------------------------------------

command_intent_state è un layer separato dal Match Engine
e da create_suggestion_state.

Consuma:

- input_raw.value / input_home.value
- projects_list.data
- entities_list.data

Produce:

- isCommand
- isPureCommand
- commandFamily
- commandType
- targetType
- candidateName
- existingId
- needsCompletion
- canExecute
- guideMessage
- rawInput

Non produce:

- matches
- count
- isAmbiguous
- singleMatch
- moreSpecificMatches
- project_id salvabile per events
- entity_id salvabile per events
- amount
- unit
- event_date
- type

Regole:

- command intent ≠ match
- command intent ≠ suggestion create da evento
- command intent ≠ salvataggio evento
- command intent ≠ select decision
- command intent ≠ deduplicazione strutturale
- command intent intercetta comandi puri
- command intent può bloccare creazioni duplicate da command se riconosce elemento già esistente

Esempio evento ordinario con suggestion:

30 euro spesa villa nuova
→ project_state/entity_state
→ create_suggestion_state
→ suggestion create eventuale
→ Conferma evento manuale

Esempio comando puro:

crea progetto Villa Nuova
→ command_intent_state
→ container_command_intent
→ btn_command_create_project
→ insert_project
→ nessun evento salvato

Esempio elemento già presente:

crea progetto villa
→ command_intent_state
→ Elemento già presente
→ nessun bottone crea
→ nessuna duplicazione
→ nessun evento salvato

Nota:

command_intent_state può controllare l’esistenza di un project/entity,
ma questa verifica non sostituisce deduplicazione avanzata,
alias, fuzzy matching o vincoli DB.

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
- command intent avanzato oltre create project/entity
- modifica project/entity da command
- dashboard/report intent
- input analysis model unico
- creazione automatica silenziosa project/entity

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
- creazione guidata project/entity implementata solo a primo livello controllato
- command intent create project/entity implementato a primo livello controllato
- command intent avanzato non implementato
- input analysis model unico non implementato
- nessuna creazione automatica silenziosa project/entity
- nessun audit trail dedicato per creazione project/entity
- nessuna deduplicazione strutturale avanzata per project/entity creati da command
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
✔ create_suggestion_state introdotto
✔ creazione guidata project/entity implementata a primo livello controllato
✔ no-match project/entity assistito da suggestion controllata
✔ entity autofill controlled minimal implementato
✔ command intent create project/entity implementato a primo livello controllato
✔ comandi puri esclusi dal save flow evento
✔ “crea progetto villa” riconosciuto come elemento già presente
✔ project/entity da command creati solo previa conferma utente

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
- input analysis model unico
- command intent avanzato oltre create project/entity
- filtro select su match ambigui
- deduplicazione avanzata project/entity

---

STATO DOPO PROJECT / ENTITY CREATE SUGGESTION:

✔ no-match project/entity può produrre suggestion controllata
✔ project/entity possono essere creati inline previa conferma
✔ select_project/select_entity vengono valorizzati dopo creazione controllata
✔ evento non viene salvato automaticamente dopo creazione project/entity
✔ salvataggio resta manuale
✔ project/entity mancanti non bloccano conferma
✔ project/entity ambigui bloccano conferma

STATO DOPO COMMAND INTENT — CREATE PROJECT / ENTITY:

✔ command_intent_state introdotto come helper separato
✔ comandi puri create project/entity intercettati
✔ comando generico “crea” guidato
✔ “modifica evento” gestito come guida non operativa
✔ comandi puri non salvano eventi
✔ project/entity da command richiedono conferma utente
✔ elemento già presente riconosciuto e non duplicato
✔ evento ordinario non regressivo validato
✔ edit flow non regressivo validato

Nota:

Command Intent non risolve il problema strutturale del match engine avanzato.
Aggiunge un layer separato per comandi puri.

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

3. INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER

- valutare un layer unico di analisi interrogabile
- coordinare parse_input_controlled, project_state, entity_state, create_suggestion_state, command_intent_state
- ridurre rami ibridi e fonti parallele
- evitare duplicazioni future tra matching, suggestion e command intent
- non introdurre refactor globale senza nodo dedicato

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

5. SELECT OPTIONS FILTERING — AMBIGUITY UX

- filtrare opzioni select sui match ambigui
- migliorare risoluzione ambiguità
- non ridurre possibilità di selezione manuale libera senza nodo dedicato

6. ADVANCED COMMAND INTENT

- modifica project/entity da command
- dashboard/report intent
- eventuale routing avanzato
- nessun edit automatico senza conferma
- nessun output/KPI anticipato

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
- command intent avanzato oltre create project/entity
- input analysis model unico
- creazione automatica silenziosa project/entity
- filtro select su match ambigui
- pending state avanzato per nuovi project/entity
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
- creare project/entity direttamente dal matching
- creare project/entity senza conferma utente
- forzare selezioni ambigue
- sostituire la validazione utente

---

Stato attuale:

Il primo livello controllato è stato implementato.
Il Match Engine ora riduce le divergenze tra state, select, preview e confirm.

Il successivo Project / Entity Create Suggestion First Controlled Level
ha aggiunto un layer di suggestion controllata che consuma il matching,
senza trasformare il match engine in un sistema decisionale o di scrittura DB.

Il successivo Command Intent — Create Project / Entity
ha aggiunto un layer separato per intercettare comandi puri,
senza trasformare il Match Engine in un sistema di command routing.

Il Match Engine resta dedicato a project/entity dentro eventi ordinari.

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
✔ create_suggestion_state consuma il match state
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ creazione guidata project/entity implementata a primo livello controllato
✔ no-match project/entity può generare suggestion controllata
✔ project/entity mancanti non bloccano conferma
✔ project/entity ambigui bloccano conferma
✔ entity autofill controlled minimal implementato
✔ Command Intent — Create Project / Entity completato
✔ command_intent_state introdotto come helper separato
✔ command intent non sostituisce project_state / entity_state
✔ command intent non sostituisce create_suggestion_state
✔ comandi puri non salvano eventi
✔ project/entity da command creati solo previa conferma utente
✔ elemento già presente da command riconosciuto e non duplicato

---

⚠ match engine avanzato separato non implementato  
⚠ preview ancora ibrida  
⚠ hint duration/type ancora embedded nella preview  
⚠ nessuna gerarchia  
⚠ nessun alias system  
⚠ nessuna deduplicazione  
✔ creazione guidata project/entity implementata a primo livello controllato
⚠ command intent avanzato non implementato
⚠ input analysis model unico non implementato
⚠ filtro select su match ambigui non implementato
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

v06 — 2026-05-07
- aggiornamento post PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
- documentato rapporto tra project_state/entity_state e create_suggestion_state
- chiarito che create_suggestion_state consuma il matching ma non lo sostituisce
- chiarito che matching ≠ creazione
- chiarito che suggestion ≠ decisione
- chiarito che suggestion ≠ salvataggio evento
- documentata creazione project/entity solo previa conferma utente
- documentata regola select_project/select_entity come decisione utente finale
- documentato no-match project/entity come non bloccante
- documentato blocco solo su ambiguità attiva non risolta
- documentata relatione tra hint informativi e suggestion create
- documentata Project Create Suggestion su estensioni controllate
- documentata Entity Create Suggestion
- documentato entity autofill controlled minimal
- documentato che entity autofill non è matching entity
- aggiornati casi non supportati rimuovendo create suggestion base
- aggiunti command intent e select filtering come evoluzioni future
- confermato DB schema invariato
- confermato parser invariato
- confermato type classification invariata
- confermato duration normalization invariata
- nessun output/KPI anticipato

v07 — 2026-05-13

- aggiornamento post COMMAND INTENT — CREATE PROJECT / ENTITY
- documentato command_intent_state come helper separato dal Match Engine
- chiarito che command_intent_state non sostituisce project_state / entity_state
- chiarito che command_intent_state non sostituisce create_suggestion_state
- chiarito che matching ≠ command intent
- chiarito che suggestion ≠ command intent
- chiarito che command intent ≠ salvataggio evento
- documentato comando generico “crea”
- documentato create project incompleto
- documentato create project completo
- documentato create entity incompleto
- documentato create entity completo
- documentata guida non operativa “modifica evento”
- documentato elemento già presente da command
- documentato “crea progetto villa” come no-duplicate guard
- documentato che comandi puri non salvano eventi
- documentato che project/entity da command richiedono conferma utente
- documentato riuso insert_project / insert_entity da command
- documentato che command intent non modifica project_state/entity_state
- documentato che command intent non modifica create_suggestion_state
- documentato evento ordinario non regressivo dopo Command Intent
- documentato edit flow non regressivo dopo Command Intent
- aggiornati casi non supportati
- aggiornati limiti attuali
- aggiornato Target Futuro sostituendo Command Intent base con Input Analysis Model / Single Interpretation Layer
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato