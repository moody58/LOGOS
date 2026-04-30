# 00_PROJECT_State_v10

DATA: 2026-04-30

------------------------------------------------
NODO ATTIVO:
------------------------------------------------

ENGINE BASE — NORMALIZATION LAYER BASE COMPLETED

------------------------------------------------
FASE:
------------------------------------------------

STEP 4 — EVENT EDITING (COMPLETATO)

STEP 4.1 — INPUT SYSTEM STABILIZATION (COMPLETATO)

STEP 6.1 — ENGINE BASE / NORMALIZATION LAYER BASE (COMPLETATO)

TRANSIZIONE → PREVIEW ALIGNMENT BASE / ENGINE BASE CONTINUATION

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- coperti tutti i layer sistema  
- parsing + matching completamente documentati  
- label layer integrato  
- normalizzazione base documentata  
- insert/update flow aggiornato  

Q (Qualità): 9.5/10  
- stato coerente con sistema reale  
- distinzione chiara parsing / matching / label / normalization  
- UX migliorata senza regressioni  
- debiti residui esplicitati  

D (Deployabilità): 10/10  
- pronto per Regia  
- stato completamente ricostruibile  
- nessuna dipendenza mancante  
- codice runtime principale documentato nei checkpoint  

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
✔ insert/update verificati su DB reale  
✔ refresh lista eventi corretto dopo save/update  

⚠ accoppiamento input / processing / UI ancora presente  
⚠ preview non ancora completamente allineata al nuovo layer normalizzato  
⚠ matching non unificato  
⚠ hint non completamente state-driven  
⚠ type classification ancora limitata  

------------------------------------------------
AGGIORNAMENTO CRITICO (COMPLETATO)
------------------------------------------------

Il sistema è stabilizzato su quattro layer fondamentali:

1. INPUT RELIABILITY — PARSING  
2. MATCHING BASE  
3. LABEL QUALITY  
4. ENGINE BASE — NORMALIZATION LAYER BASE  

---

RISULTATO:

✔ eliminata fragilità input  
✔ eliminata divergenza preview / confirm nei dati persistiti  
✔ ridotti falsi positivi matching  
✔ introdotta normalizzazione base di amount/unit  
✔ rimosso parsing duplicato dal bottone confirm  
✔ insert e update usano ui_state.parsed come fonte unica  
✔ aggiornata lista eventi dopo save completato  

⚠ matching basato su stringhe (no fuzzy)  
⚠ hint limitati a logica base  
⚠ preview contiene ancora logiche proprie  
⚠ normalizzazione durata avanzata non implementata  

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
→ preview / save / edit

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

AMBITO NON IMPLEMENTATO:

✘ conversione multi-unità  
✘ 1 ora e 15 minuti → durata normalizzata  
✘ 2h30 → durata normalizzata  
✘ giorni / settimane  
✘ spesa / incasso  
✘ type classification da parole chiave  
✘ normalizzazione project/entity  
✘ matching engine unificato  
✘ dashboard / KPI  

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

Output normalizzato:

- ore
- minuti

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
AGGIORNAMENTO UX
------------------------------------------------

Il sistema è stato aggiornato nel layer preview/hint prima del presente nodo:

✔ introduzione hint multipli
✔ introduzione gerarchia visiva
✔ eliminazione hint prematuri
✔ attivazione controllata
✔ separazione semantica colori

RISULTATO:

✔ UX più chiara
✔ nessuna ambiguità nascosta
✔ miglior supporto decisionale utente

⚠ hint ancora scollegati da state unificato
⚠ duplicazione logica detection
⚠ preview non ancora completamente allineata alla normalizzazione base

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
- preserva event_date
- non modifica raw_input
- non modifica DB schema
- non interpreta semanticamente l’evento

---

MATCHING LAYER

- select_project
- select_entity
- project_state
- entity_state
- logiche di matching distribuite

---

LABEL LOGIC (EMBEDDED)

- generazione label dentro preview
- pipeline non distruttiva
- NON separata come layer runtime
- NON persistita

---

PROCESSING LAYER

- lista eventi NEW
- gestione WRITTEN / ERROR
- supporto edit su eventi NEW

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

- multi-unit non supportato
- parsing non semantico
- giorni non supportati
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

⚠ preview/label non sono ancora view pure
⚠ formattazione italiana amount non ancora allineata
⚠ logica ancora embedded nella sintesi

------------------------------------------------
MATCHING SYSTEM (STABILIZZATO MA NON UNIFICATO)
------------------------------------------------

PRINCIPI:

✔ suggerire ≠ decidere  
✔ no inferenze automatiche definitive  
✔ utente in controllo  

---

PROJECT MATCH

- split parole nome
- filtro parole
- match per parole
- disambiguazione numerica

---

ENTITY MATCH

STRONG:

- match nome completo

FULL:

- tutte parole presenti
- parole ≥4 caratteri

PARTIAL:

- match su token significativi
- almeno una parola ≥4 caratteri in comune

---

AUTO-SELECT

✔ solo match univoco
✔ nessuna forzatura

---

AGGIUNTE UX MATCHING

- soglia attivazione hint
- gestione ambiguità input corto
- riduzione suggerimenti ridondanti

---

RISULTATI

✔ riduzione falsi positivi

⚠ ambiguità non sempre correttamente segnalata
⚠ riconoscimento entity non sempre consistente
⚠ affidabilità suggerimenti variabile su input complessi

---

PROBLEMA STRUTTURALE APERTO

Presenza di più sistemi di matching:

1. input_raw / ranking
2. select deterministico
3. preview / detected

Conseguenze:

- incoerenza architetturale
- duplicazione logica
- difficoltà evoluzione engine

⚠ PRIORITY MATCH NON IMPLEMENTATO

------------------------------------------------
PREVIEW SYSTEM
------------------------------------------------

✔ preview = parsing reale + label  
✔ rappresentazione coerente lato utente  
✔ allineata ai dati salvati nei valori principali  

⚠ contiene logiche di trasformazione
⚠ non è una view pura
⚠ formattazione italiana amount non ancora implementata
⚠ hint non completamente state-driven
⚠ presenza duplicazione detected vs state

STRUTTURA:

MAIN:

amount + unit + label  

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

NOTA:

Dopo Normalization Layer Base, la preview può ancora mostrare valori tecnici come:

1500.5 €

La trasformazione visuale:

1500.5 → 1.500,50

è rinviata a nodo Preview Alignment Base.

------------------------------------------------
INSERT
------------------------------------------------

insert_event attivo

Scrittura:

- raw_input
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
✔ DB aggiornato correttamente
✔ lista eventi aggiornata subito dopo save

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

---

LIMITI:

- entity senza gerarchia
- type non utilizzato
- dati storici non normalizzati retroattivamente
- nessun versioning modifiche
- payload non utilizzato

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

FLOW:

NEW → EDIT → NEW  
NEW → WRITTEN  
NEW → ERROR  

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

------------------------------------------------
FUNZIONALITÀ NON IMPLEMENTATE
------------------------------------------------

INPUT

- multi-unit parsing
- parsing semantico
- giorni / settimane
- date relative

---

NORMALIZATION

- conversione durata
- unità canonica tempo
- 1 ora e 15 minuti
- 2h30
- 2 giorni rendering

---

TYPE

- spesa/incasso
- classificazione da parole chiave
- classificazione economico/tempo/evento consolidata

---

MATCHING

- gerarchia entity
- disambiguazione avanzata
- ranking
- priority match engine
- unificazione logiche

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
- durata avanzata non normalizzata
- dati storici non retro-normalizzati

---

2. ENTITY NON STRUTTURATE

- nessuna gerarchia
- ambiguità inevitabile

---

3. TYPE LIMITATO

- nessuna distinzione spesa/incasso
- type non utilizzato in modo operativo

---

4. UI LIMITI

- input non multilinea
- preview migliorabile
- formattazione amount non localizzata

---

5. ENGINE PARZIALE

- Normalization Layer Base completato
- engine semantico non implementato
- duration normalization non implementata
- type classification non implementata

---

6. DUPLICAZIONE MATCHING

- più logiche indipendenti
- incoerenza tra layer

---

7. HINT NON STATE-DRIVEN COMPLETO

- uso detected*
- non pienamente allineati a select / engine

---

8. PRIORITÀ MATCH ASSENTE

- impossibile distinguere match dominante

---

9. LOOP REATTIVO

RISOLTO per input/parsing principale

---

10. ACCOPPIAMENTO LAYER

- input non completamente separato da processing
- preview non read-only puro

---

11. MATCHING NON UNIFICATO

- 3 logiche separate
- incoerenza tra select / preview / ranking

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

------------------------------------------------
STATO LAYER SISTEMA
------------------------------------------------

Layer 1 — Input: ~96%  
Layer 2 — Matching: ~75%  
Layer 3 — View / Preview: ~80%  
Layer HINT SYSTEM: ~90%  
Layer 4 — Data Structure: ~20%  
Layer 5 — Engine: ~15%  
Layer 6 — Output: 0%  

---

STATO COMPLESSIVO:

~70%

------------------------------------------------
FASE ATTUALE
------------------------------------------------

✔ INPUT RELIABILITY — COMPLETATA  
✔ MATCHING BASE — COMPLETATO  
✔ LABEL QUALITY — COMPLETATO  
✔ EVENT EDITING — COMPLETATO  
✔ INPUT SYSTEM STABILIZATION — COMPLETATA  
✔ ENGINE BASE — NORMALIZATION LAYER BASE — COMPLETATO  

---

TRANSIZIONE:

→ PREVIEW ALIGNMENT BASE  
→ poi ENGINE BASE CONTINUATION

------------------------------------------------
OBIETTIVO IMMEDIATO
------------------------------------------------

Stabilizzare il passaggio successivo senza introdurre nuova complessità.

Priorità immediata consigliata:

PREVIEW ALIGNMENT BASE

Obiettivo:

- allineare la visualizzazione ai dati normalizzati
- formattare amount in modo italiano
- evitare divergenza visiva parser / sintesi
- non modificare DB
- non modificare matching
- non introdurre type classification

------------------------------------------------
VINCOLI OPERATIVI
------------------------------------------------

✔ nessun refactor globale  
✔ nessuna modifica architettura non necessaria  
✔ nessuna AI  
✔ nessuna automazione decisionale  
✔ miglioramenti incrementali  
✔ una sessione = un nodo  
✔ ogni nodo deve produrre checkpoint  

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
4. preview alignment  
5. duration normalization  
6. type classification base  
7. match engine unification  
8. output  

---

Il sistema attuale è:

✔ UX-driven  
✔ safe  
✔ non decisionale  
✔ progressivamente normalizzato  

---

PRIORITÀ FUTURE:

1. preview alignment base  
2. duration normalization  
3. type classification base  
4. matching unification  
5. hint state-driven  
6. semantic engine  
7. dashboard / KPI  

------------------------------------------------
NEXT NODES CANDIDATI
------------------------------------------------

1. PREVIEW ALIGNMENT BASE

Scopo:

- allineare sintesi/lista ai valori normalizzati
- formattare numeri in stile italiano
- mantenere preview come visualizzazione
- non introdurre nuova logica semantica

---

2. ENGINE BASE — DURATION NORMALIZATION

Scopo:

- gestire 1 ora e 15 minuti
- gestire 2h30
- valutare giorni / ore / minuti
- definire unità canonica durata

---

3. ENGINE BASE — TYPE CLASSIFICATION BASE

Scopo:

- distinguere evento / tempo / economico
- valutare spesa/incasso tramite parole chiave
- mantenere controllo utente

---

4. MATCH ENGINE UNIFICATION

Scopo:

- eliminare logiche parallele
- costruire priority match
- rendere hint/select/preview coerenti

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