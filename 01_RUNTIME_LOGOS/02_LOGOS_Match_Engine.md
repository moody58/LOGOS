# 02_LOGOS_Match_Engine_v04

DATA: 2026-04-30

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- inclusa logica reale aggiornata  
- coperti project + entity + hint + auto-select  
- allineato a runtime reale  
- esplicitato rapporto con Normalization Layer Base  
- dichiarato che il matching NON è stato modificato nel nodo engine base  

Q (Qualità): 8/10  
- logica definita ma non unificata  
- presenza di più sistemi di matching  
- incoerenza tra select / preview / ranking ancora aperta  
- separazione chiara tra normalizzazione dati e matching  

D (Deployabilità): 10/10  
- direttamente utilizzabile come riferimento runtime  
- nessuna dipendenza mancante  
- nessuna modifica operativa implicita richiesta  

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
→ preview  
→ button_input_confirm  

---

Nota:

Dopo il completamento del Normalization Layer Base:

- amount/unit/event_date sono più stabili
- il save flow usa ui_state.parsed
- il bottone confirm non esegue più parsing duplicato

MA:

- il matching non è stato modificato
- la logica project/entity resta distribuita
- la preview può ancora avere detection proprie

------------------------------------------------
PIPELINE MATCH
------------------------------------------------

input_raw  
→ sistemi di matching paralleli  
→ calcolo matches  
→ suggestion / select / preview  
→ auto-select solo in select layer  

---

Fonte osservabile principale:

project_state.data?.matches  
entity_state.data?.matches  

---

Il matching lavora sul testo input,
non sui valori numerici normalizzati.

------------------------------------------------
NORMALIZZAZIONE
------------------------------------------------

La normalizzazione testuale del matching è ancora gestita
implicitamente e in modo NON uniforme nei diversi sistemi.

Non esiste ancora un layer esplicito e unico di match normalization.

---

Distinzione importante:

NORMALIZATION LAYER BASE:

- amount
- unit
- event_date

MATCH NORMALIZATION:

- testi project/entity
- token
- nomi
- ambiguità
- ranking

---

Stato attuale:

✔ normalizzazione amount/unit base completata  
✘ normalizzazione matching non completata  
✘ match engine unico non implementato  

------------------------------------------------
PROJECT MATCH ATTUALE
------------------------------------------------

⚠ esistono più logiche:

- matching deterministico nei select
- matching/ranking legato a input_raw
- matching/detection in preview

→ non unificate

---

COMPORTAMENTO REALE:

matching basato su confronto testuale tra input_raw e projects_list.

---

OUTPUT:

- project_matches

Fonte:

project_state.data?.matches

---

LOGICA:

match = 1  
→ auto-select  

match > 1  
→ ambiguità  
→ nessuna selezione  

match = 0  
→ nessun suggerimento

---

NOTE:

- project_id viene salvato solo se selezionato
- il sistema non crea project automaticamente
- il sistema non decide project in caso di ambiguità

------------------------------------------------
ENTITY MATCH ATTUALE
------------------------------------------------

⚠ logica non unificata con project match e preview

→ possibili incoerenze nei risultati

---

COMPORTAMENTO REALE:

matching basato su confronto testuale tra input_raw e entities_list.

---

OUTPUT:

- entity_matches

Fonte:

entity_state.data?.matches

---

LOGICA:

match = 1  
→ auto-select  

match > 1  
→ ambiguità  
→ nessuna selezione  

match = 0  
→ nessun suggerimento

---

NOTE:

- entity_id viene salvato solo se selezionato
- il sistema non crea entity automaticamente
- la presenza di duplicati entity può generare ambiguità
- non esiste gerarchia entity attiva

------------------------------------------------
AUTO-SELECT LOGIC
------------------------------------------------

Auto-select SOLO se:

- match = 1
- campo vuoto

---

NON auto-select se:

- ambiguità
- valore già presente
- match multipli
- input insufficiente

---

⚠ auto-select basato solo su uno dei sistemi di matching,
principalmente select layer.

Conseguenza:

può non essere sempre coerente con ciò che la preview evidenzia o suggerisce.

------------------------------------------------
GESTIONE AMBIGUITÀ
------------------------------------------------

Se più match:

- mostrare hint:
  "Più entità trovate" / "Più progetti trovati"

- NON selezionare automaticamente

---

Obiettivo:

evitare errori silenziosi.

---

Effetto sul confirm:

button_input_confirm viene disabilitato se:

- entity_state.data?.matches > 1
- project_state.data?.matches > 1

---

Nota:

questa regola protegge il salvataggio da ambiguità project/entity,
ma non risolve l’incoerenza tra i sistemi di matching.

------------------------------------------------
HINT SYSTEM
------------------------------------------------

Basato su stato derivato, non ancora completamente unificato.

---

Condizioni principali:

entity_matches > 1  
→ "Seleziona entità"

project_matches > 1  
→ "Seleziona progetto"

---

Caratteristiche:

- non invasivo
- derivato da stato osservabile
- nessuna inferenza automatica definitiva

---

⚠ utilizzo di detection parallela nella preview  
⚠ non sempre coerente con select  
⚠ hint non ancora completamente state-driven  
⚠ hint system non ancora alimentato da un match engine unico  

------------------------------------------------
RELAZIONE CON PREVIEW
------------------------------------------------

La preview utilizza risultati del matching per:

- evidenziare project/entity
- mostrare hint
- aiutare l’utente nella scelta

---

MA:

la preview contiene ancora logiche proprie:

- detection locale
- highlight
- hint logic
- label cleaning

---

Conseguenza:

la preview può divergere dal comportamento dei select.

Esempio strutturale:

- select non auto-seleziona
- preview evidenzia parzialmente
- hint segnala ambiguità

Questa divergenza non è stata risolta dal Normalization Layer Base.

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
- priority match
- disambiguazione automatica

---

Motivo:

evitare inferenze errate
e mantenere controllo utente.

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- nessuna gerarchia entity
- nessun ranking avanzato unificato
- duplicazione logiche matching
- incoerenza tra select / preview / ranking
- assenza priority match
- nessuna disambiguazione automatica
- hint non completamente state-driven
- preview detection non unificata
- match normalization non centralizzata

------------------------------------------------
PROBLEMA STRUTTURALE CRITICO
------------------------------------------------

Attualmente esistono 3 sistemi di matching indipendenti:

1. INPUT_RAW MATCHING / RANKING

- lavora sul testo input_raw
- contribuisce a suggerimenti o stati osservabili
- non è match engine unico

---

2. SELECT MATCHING / DETERMINISTICO

- alimenta select_project / select_entity
- può auto-selezionare se match unico
- blocca se ambiguità

---

3. PREVIEW DETECTION / TOKEN-BASED

- evidenzia project/entity
- alimenta parte degli hint
- contiene logiche locali

---

CONSEGUENZE:

- incoerenza risultati
- duplicazione logica
- difficoltà debugging
- difficoltà evoluzione engine
- hint non sempre coerenti
- rischio divergenza tra ciò che si vede e ciò che viene selezionato

---

STATO:

❗ NON RISOLTO  
❗ NON TOCCATO NEL NODO NORMALIZATION LAYER BASE  
❗ BLOCCANTE PER ENGINE AVANZATO E OUTPUT AFFIDABILE  

---

TARGET:

unificazione in un unico Match Engine.

------------------------------------------------
TARGET FUTURO — MATCH ENGINE UNIFICATION
------------------------------------------------

Nodo futuro consigliato:

MATCH ENGINE UNIFICATION

---

Obiettivo:

rendere project/entity/hint/select/preview coerenti tramite una sola logica osservabile.

---

Output atteso:

- match list unica
- priority match
- stato ambiguità unico
- hint derivati da state
- select alimentate dallo stesso risultato
- preview non decisionale
- eliminazione detection parallela

---

Possibile struttura futura:

input_raw  
→ normalize text  
→ match_engine  
→ match_state  
→ select_project / select_entity  
→ preview / hint  
→ confirm guard  

---

Vincoli:

- nessuna auto-decisione se ambiguo
- nessuna creazione automatica project/entity
- nessun fuzzy aggressivo senza controllo
- utente sempre in controllo

------------------------------------------------
EVOLUZIONE FUTURA NON ATTIVA
------------------------------------------------

- unificazione sistemi di matching
- ranking per frequenza
- storico selezioni
- entity hierarchy
- relazioni entity-project
- disambiguazione guidata
- alias/sinonimi controllati
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

------------------------------------------------
STATO ATTUALE
------------------------------------------------

✔ matching base funzionante  
✔ project/entity suggeriti in modo utile  
✔ auto-select limitato ai casi univoci  
✔ ambiguità bloccanti gestite almeno nel confirm  
✔ utente mantiene controllo  

---

⚠ matching non unificato  
⚠ hint non completamente coerenti  
⚠ preview detection parallela  
⚠ assenza priority match  
⚠ assenza gerarchie  
⚠ non pronto per output/KPI affidabili  

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