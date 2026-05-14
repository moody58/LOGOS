# 00_PROJECT_Gap_Register_v10

DATA: 2026-05-13

------------------------------------------------
SCOPO
------------------------------------------------

Tracciare i gap strutturali emersi durante audit, sviluppo reale
e sessioni operative, valutandone utilità effettiva nel sistema LOGOS.

Il documento evita:

- creazione prematura di documenti inutili
- perdita di elementi strategici
- dimenticanza di componenti critiche
- apertura di nodi non prioritari
- confusione tra gap osservati e funzionalità da implementare subito

------------------------------------------------
STATO GAP
------------------------------------------------

Ogni gap può essere:

- IDENTIFICATO
- IN OSSERVAZIONE
- VALIDATO
- INTEGRATO PARZIALE
- INTEGRATO
- INTEGRATO BASE
- SCARTATO
- NON PRIORITARIO

------------------------------------------------
GAP REGISTER
------------------------------------------------

ID: G01

NOME:
Normalization Model

FONTE:
Gap Analysis + Roadmap + Engine Base Session

STATO:
INTEGRATO PARZIALE

DESCRIZIONE:

Necessità di un layer dedicato alla normalizzazione
dei dati minimi del sistema:

- amount
- unit
- event_date
- struttura base evento

STATO REALE:

È stato implementato il primo blocco minimo:

ENGINE BASE — NORMALIZATION LAYER BASE

Implementato:

- normalizzazione amount base
- normalizzazione unit base
- gestione formato numerico italiano
- supporto unità compatte testuali
- rimozione amount per numeri senza unità
- salvataggio tramite ui_state.parsed
- insert/update validati su DB reale

Esempi gestiti:

```text
1.500,50 euro → amount 1500.5, unit euro
1ora lavoro → amount 60, unit minuti
18min test → amount 18, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
2h30 → amount 150, unit minuti
villa 2 mario → amount null, unit null

NOTE:

La normalizzazione è attualmente integrata in:

parse_input_controlled
ui_state.parsed
button_input_confirm tramite payload derivato

Non esiste ancora un modulo engine separato.

Dati ancora parzialmente confrontabili perché restano non implementati:

type classification avanzata
economic direction advanced
amount firmato / direction field
match engine avanzato project/entity
giorni/settimane come durata automatica
retro-normalizzazione storico

AZIONE:

Mantenere il gap aperto come INTEGRATO PARZIALE.

Prossimi sotto-gap:

Match Engine Evolution Advanced
Economic Direction Advanced
Duration Advanced — giorni/settimane
Project / Entity Create Suggestion — INTEGRATO BASE

ID: G02

NOME:
Processor / Engine Flow

FONTE:
Gap Analysis + Roadmap + Normalization Layer Base

STATO:
VALIDATO / PARZIALMENTE AVVIATO

DESCRIZIONE:

Pipeline strutturata post-input e pre-output.

Possibile evoluzione:

input
→ parsing
→ normalization
→ matching
→ classification
→ processing
→ output

STATO REALE:

Sono stati avviati e completati sette blocchi funzionali/base-operativi:

- Normalization Layer Base
- Duration Normalization Base
- Type Classification Base
- Match Engine Unification First Controlled Level
- Project / Entity Create Suggestion First Controlled Level
- UX Mobile Coherence Pass
- Command Intent — Create Project / Entity

Tuttavia non esiste ancora un Processor/Engine Flow completo.

Attualmente:

parsing, normalization base, duration normalization, type classification base e match state project/entity sono in Retool
durate certe ore/minuti sono normalizzate in minuti
type viene salvato in events.type
Spesa / Incasso / Tempo / Evento sono persistiti a livello base
project_state / entity_state sono fonte minima matching project/entity
select_project / select_entity leggono singleMatch
matching project/entity è unificato a primo livello controllato
project/entity possono essere creati inline tramite suggestion controllata
UX mobile base è stata rifinita e validata
feedback post-save è centralizzato in button_input_confirm
routing post-save è contestuale
navigation dock Home / Eventi / Dashboard è predisposta
font-size input/select 16px è baseline mobile Safari
insert_project / insert_entity sono operativi
select_project / select_entity vengono valorizzati dopo creazione controllata
command_intent_state riconosce comandi puri create project/entity
i comandi puri non vengono salvati come eventi
project/entity da command vengono creati solo previa conferma utente
btn_command_create_project / btn_command_create_entity riusano insert_project / insert_entity
modifica evento da input libero viene gestita come guida non operativa
preview contiene ancora logiche proprie
processing resta manuale
output non attivo

NOTE:

Il sistema non ha ancora una pipeline engine autonoma.
L’evoluzione deve restare incrementale.

RISCHIO:

Anticipare engine completo può rompere il sistema esistente.

AZIONE:

Non creare ancora un documento engine globale.
Procedere per nodi minimi.

Micro-nodi UX post Match Engine già completati:

- Edit Mode Cancel / Return to Events List
- Events List Search / Filter Bar
- Events List Label / Updated At Display

Nodi residui candidati:

- Input Rendering Stability / Container Structure
- Preview Model / Hint State Consolidation
- Input Analysis Model / Single Interpretation Layer
- Data Structure / Entity Hierarchy
- Economic Direction Advanced
- Duration Advanced — giorni/settimane
- Suggestion Create vs Edit Consistency
- Project Create Suggestion — Match Present / User Override
- Azioni Rapide Operative
- Dashboard Base

ID: G03

NOME:
Project / Entity Create Suggestion

FONTE:
Gap Analysis + Match Engine + Match Engine Unification First Controlled Level + Project/Entity Create Suggestion Session

STATO:
INTEGRATO BASE

DESCRIZIONE:

Creazione guidata e controllata di project/entity quando l’input utente
non produce un match sufficiente oppure contiene una estensione specifica
non ancora presente nel sistema.

Il sistema può ora proporre all’utente:

- creazione nuovo progetto
- creazione nuova entità
- ignorare i suggerimenti
- salvare comunque evento incompleto
- bloccare solo in presenza di ambiguità attiva

STATO REALE:

Il nodo PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
è stato completato e validato.

Implementato:

- create_suggestion_state
- project_create_inline_open
- project_create_suggestion_dismissed
- entity_create_inline_open
- entity_create_suggestion_dismissed
- insert_project
- insert_entity
- container suggestion inline
- micro-editor project
- micro-editor entity
- bottone Ignora globale
- bottoni Annulla contestuali
- controllo duplicati frontend project/entity
- entity autofill controlled minimal

Regole consolidate:

- nessuna creazione automatica silenziosa
- creazione solo previa conferma utente
- evento non salvato automaticamente dopo creazione project/entity
- select_project / select_entity restano decisione utente finale
- raw_input resta testo sorgente
- project/entity mancanti non bloccano il salvataggio
- project/entity ambigui bloccano il salvataggio finché non risolti manualmente
- una sola creazione guidata aperta alla volta
- suggestion ignorata non blocca il salvataggio

Project flow validato:

- input con progetto base + estensione specifica
- candidate project proposta
- input_new_project_name precompilato
- insert_project crea record in projects
- projects_list viene aggiornata
- select_project viene valorizzato
- evento resta non salvato finché l’utente non conferma

Esempi validati:

- Villa Sierri 6
- Villa Sierri 7
- Villa Sierri 15

Entity flow validato:

- input con entity mancante
- creazione entity inline manuale
- insert_entity crea record in entities
- entities_list viene aggiornata
- select_entity viene valorizzata
- evento resta non salvato finché l’utente non conferma

Esempi validati:

- Tecnico Sierri 4
- Referente Kappa

Entity Autofill Controlled Minimal:

implementato solo per casi con prefisso forte e no-match entity reale.

Prefissi ammessi:

- referente
- tecnico
- cliente
- fornitore
- operaio
- collaboratore
- contatto
- responsabile
- muratore
- idraulico
- elettricista
- geometra
- architetto

Esempio positivo validato:

villa sierri 15 sopralluogo referente kappa
→ Referente Kappa

Esempio negativo validato:

acquisto 50 euro materiale nuovo
→ nessun autofill entity

Caso ambiguo validato:

alfie mario rossi
→ Crea entità non visibile
→ Conferma disabilitata finché l’utente sceglie manualmente entity

RISCHIO RESIDUO:

- UI suggestion container rifinita a livello mobile base durante UX Mobile Coherence Pass
- resta da verificare consistenza suggestion create/edit
- filtro select su match ambigui non implementato
- command intent create project/entity implementato a primo livello controllato
- resta da coordinare eventuale evoluzione futura con Input Analysis Model / Single Interpretation Layer
- gerarchie project/entity non implementate
- alias non implementati
- deduplicazione avanzata non implementata
- entities senza deduplicazione strutturale avanzata
- nessun audit trail dedicato per creazione project/entity

AZIONE:

Gap integrato a livello base.

Non riaprire come Project / Entity Create Suggestion base.

Eventuali evoluzioni devono diventare gap/nodi dedicati:

- Input Analysis Model / Single Interpretation Layer
- Data Structure / Entity Hierarchy
- Select Options Filtering — Ambiguity UX
- Alias / Deduplication Advanced
- Suggestion Create vs Edit Consistency
- Project Create Suggestion — Match Present / User Override

ID: G04

NOME:
Logging System

FONTE:
Gap Analysis + Supabase Schema

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Sistema log eventi, errori, warning, modifiche e audit trail.

NOTE:

Attualmente:

tabella system_logs presente
non utilizzata
update_event sovrascrive eventi NEW
updated_at traccia solo ultima modifica
nessuno storico revisioni

RISCHIO:

Senza logging/versioning:

modifiche non ricostruibili
nessun audit trail
impossibile rollback
difficile analisi errori

AZIONE:

Non prioritario per il nodo corrente.

Da rivalutare quando emergerà una necessità reale di:

versioning eventi
audit modifiche
incident tracking runtime
rollback su eventi NEW

Possibile evoluzione futura:

event_revisions
system_logs operativo
audit trail update_event

ID: G05

NOME:
Input Modes (Libero vs Guidato)

FONTE:
Chat utente + UX Evolution

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Doppia modalità input:

free text
guided form

NOTE:

Attualmente:

input libero funzionante
parsing stabilizzato
preview disponibile
editing NEW disponibile
nessun form guidato
Azioni rapide Home predisposte graficamente ma non operative.
Navigation dock predisposta.
Dashboard presente in nav ma disabilitata.
Command Intent — Create Project / Entity implementato a primo livello controllato.
Il command intent non è un form guidato completo, ma introduce una prima distinzione tra input evento e comando strutturale puro.

RISCHIO:

Introdurre modalità guidata troppo presto può duplicare logiche
e peggiorare la manutenzione.

AZIONE:

Non prioritario ora.

Da rivalutare dopo:

Command Intent implementato a primo livello controllato
Preview / Input Analysis eventualmente consolidati
Data Structure / Entity Hierarchy valutata
Azioni rapide operative definite come nodo dedicato
Dashboard base eventualmente attivata

Possibile uso futuro:

inserimenti complessi
spesa/incasso
eventi con più campi
correzione dati strutturati

ID: G06

NOME:
Multi-source Input

FONTE:
Gap Analysis

STATO:
NON PRIORITARIO

DESCRIZIONE:

Input da fonti diverse:

API
voice
Siri / assistenti vocali
import
automazioni esterne

NOTE:

Attualmente:

solo input manuale Retool
sistema non ancora pronto per fonti multiple
parsing base stabilizzato ma non completo
duration normalization base completata
type classification base completata
matching project/entity unificato a primo livello controllato
creazione guidata project/entity implementata a primo livello controllato
input vocali/Siri non ancora pronti
command intent create project/entity implementato a primo livello controllato

RISCHIO:

Input multi-source aumenterebbe complessità prima della maturità dati.

AZIONE:

Non lavorare ora.

Da rivalutare solo dopo:

input system maturo
Command Intent stabilizzato oltre il primo livello controllato
engine base più completo
output/reportistica almeno definita
sicurezza API valutata

ID: G07

NOME:
Preview Alignment

FONTE:
Normalization Layer Base + View Preview System

STATO:
INTEGRATO

DESCRIZIONE:

Allineamento visuale della preview ai dati normalizzati in ui_state.parsed.

Il nodo PREVIEW ALIGNMENT BASE è stato completato.

Implementato:

- formattazione italiana amount
- euro visualizzato con due decimali
- grouping migliaia visuale
- ore/minuti visualizzati coerentemente
- singolare/plurale unit
- label cleaning aggiornato
- correzione bug "minuti" → "uti"
- separatore data/descrizione
- highlight unit-safe
- previewStopTokens
- nessuna modifica DB
- nessuna modifica matching
- nessuna modifica save flow

Esempi validati:

1.500,50 euro materiale
→ 1.500,50 € • materiale

1500 euro materiale
→ 1.500,00 € • materiale

18min test
→ 18 minuti • test

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

villa 2 mario
→ villa 2 mario

NOTE:

La preview resta comunque layer ibrido:

- view
- label cleaning
- hint logic
- highlight
- formattazione locale

RISCHIO RESIDUO:

- preview non ancora view pura
- hint duration/type ancora embedded nella preview
- preview model unico non implementato
- “Da verificare” resta dentro Sintesi perché non è blocco autonomo
- separazione tra hint bloccanti, warning informativi e suggestion non ancora consolidata
- matching project/entity allineato a primo livello nello STEP 6.4

AZIONE:

Gap integrato come Preview Alignment Base.

Non aprire ulteriori nodi preview generici.
Eventuali modifiche preview devono essere conseguenza controllata di nodi futuri specifici.

Nota post Match Engine Unification:

la parte critica di hint/highlight matching project/entity
è stata allineata a project_state/entity_state.

Non aprire “Hint / Preview State Alignment” come nodo immediato generico.

Eventuale nodo futuro:

PREVIEW MODEL / HINT STATE CONSOLIDATION

Motivi ora rafforzati dopo Command Intent:

- “Da verificare” non è spostabile perché interno alla Sintesi
- preview resta layer ibrido
- hint/warning/suggestion non sono ancora separati in blocchi autonomi
- evitare che l’utente legga una cosa diversa da ciò che verrà salvato

Da aprire solo se il problema diventa prioritario o se si decide un refactor preview dedicato.

ID: G08

NOME:
Duration Normalization

FONTE:
Domande utente + Engine Base

STATO:
INTEGRATO BASE

DESCRIZIONE:

Gestione durate certe espresse in ore/minuti tramite unità canonica.

Il nodo ENGINE BASE — DURATION NORMALIZATION è stato completato.

Decisione consolidata:

- unità canonica tempo = minuti
- amount = totale minuti
- unit = "minuti"
- raw_input preservato
- nessuna modifica schema DB
- nessun payload.duration
- nessun campo duration_minutes

Implementato:

- 18min → 18 minuti
- 1 ora → 60 minuti
- 1ora → 60 minuti
- 2 ore → 120 minuti
- 1,5 ore → 90 minuti
- 1.5 ore → 90 minuti
- 1 ora e 15 minuti → 75 minuti
- 1 ora 15 minuti → 75 minuti
- 2h30 → 150 minuti
- 2 h 30 → 150 minuti
- 2 ore 30 → 150 minuti
- 2 ore e 30 minuti → 150 minuti
- 90 minuti → 90 minuti

Preview aggiornata:

2h30 rendering
→ 2 ore 30 minuti • rendering
→ Normalizzato: 150 minuti

Giorni/settimane:

Non convertiti automaticamente.

Esempio:

2 giorni rendering
→ amount null
→ unit null
→ hint durata ambigua

Motivo:

“giorno” e “settimana” sono semanticamente ambigui:
possono indicare calendario, lavoro, cantiere, evento o turno.

RISCHIO RESIDUO:

- giorni/settimane non normalizzati
- giornata/mezza giornata non normalizzate
- parole numeriche tipo “due ore” non supportate
- forme colloquiali tipo “un paio d’ore” non supportate
- dati storici non retro-normalizzati
- type/select1 ora allineato a unit = minuti
- resta aperta solo type classification avanzata / economic direction

AZIONE:

Gap integrato a livello base.

Tenere aperto solo come sotto-gap futuro:

DURATION ADVANCED — GIORNI / SETTIMANE

Da non riaprire come Duration Normalization Base.

ID: G09

NOME:
Type Classification Base

FONTE:
Input System + domanda utente + Roadmap + Checkpoint Type Classification Base

STATO:
INTEGRATO BASE

DESCRIZIONE:

Classificazione base evento tramite select1:

- Evento
- Tempo
- Spesa
- Incasso

Nota terminologica:

select1 è un componente UI Select di Retool,
non una query.

La logica Type Classification Base è contenuta nel Default value del componente select1.

Il valore runtime:

select1.value

viene letto da button_input_confirm e salvato come:

payload.type
→ events.type

STATO REALE:

Il nodo ENGINE BASE — TYPE CLASSIFICATION BASE è stato completato.

Implementato:

- parsed.unit = minuti → Tempo
- euro + keyword controllate di uscita → Spesa
- euro + keyword controllate di entrata → Incasso
- euro senza direzione chiara → Evento
- segnali economici contrastanti → Evento
- nessuna unit significativa → Evento
- scelta manuale utente preservata
- type aggiunto al payload di button_input_confirm
- insert_event salva events.type
- update_event aggiorna events.type
- override manuale validato
- reset/stale value verificato

Esempi validati:

2h30 rendering
→ type Tempo
→ amount 150
→ unit minuti

1 ora e 45 minuti lavoro
→ type Tempo
→ amount 105
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

Override manuale validato:

20 euro materiale
→ default Evento
→ utente seleziona Spesa
→ DB type Spesa

20 euro materiale
→ default Evento
→ utente seleziona Incasso
→ DB type Incasso

NOTE:

La classificazione automatica resta prudente.

"benzina", "materiale", "mangime" e altre parole di dominio
non classificano automaticamente Spesa.

Il sistema suggerisce,
ma l’utente mantiene controllo finale.

RISCHIO RESIDUO:

- classificazione economica avanzata non implementata
- dizionario keyword esteso non implementato
- amount firmato non implementato
- direction field non implementato
- type non sufficiente da solo per KPI avanzati
- eventi storici non retro-normalizzati
- match engine avanzato separato non implementato
- data structure / entity relations non implementate

AZIONE:

Gap integrato a livello base.

Non riaprire come Type Classification Base.

Tenere aperti solo sotto-gap futuri:

- Economic Direction Advanced
- Type Classification Advanced
- eventuale bonifica type storico

Nodo operativo successivo consigliato:

NEXT NODE DA DEFINIRE IN ROADMAP

ID: G10

NOME:
Match Engine Unification

FONTE:
Match Engine + Preview System + State + Checkpoint Match Engine Unification

STATO:
INTEGRATO BASE

DESCRIZIONE:

Unificazione a primo livello controllato dei sistemi di matching project/entity.

Prima del nodo, il matching era distribuito tra:

- project_state / entity_state
- select_project / select_entity
- preview / detection locale
- hint locali
- confirm guard

Il nodo ha reso coerenti:

- match state
- select
- hint ambiguità
- highlight preview
- confirm guard
- create flow
- edit flow

STATO REALE:

Il nodo MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL è completato.

Implementato:

- project_state come fonte minima matching project
- entity_state come fonte minima matching entity
- output matching:
  - matches
  - count
  - hasMatch
  - isAmbiguous
  - singleMatch
  - moreSpecificMatches
  - hasMoreSpecificMatches
- select_project legge project_state.data.singleMatch
- select_entity legge entity_state.data.singleMatch
- trigger_parse_debounced rilancia parse_input_controlled + project_state + entity_state
- btn_edit rilancia parse_input_controlled + project_state + entity_state
- match state live in create flow
- match state live in edit flow
- hint ambiguità da isAmbiguous
- highlight preview da matches
- detection locale preview non più fonte decisionale matching
- confirm guard da ambiguità non risolta
- ambiguità risolta manualmente non blocca salvataggio
- nessun match non blocca salvataggio
- priority match minimo implementato
- hint informativo per match più specifici
- bug €500 label preview risolto
- linting project_state/entity_state ripuliti

Esempi validati:

villa 2 mario
→ project Villa 2
→ entity Mario
→ conferma abilitata

18 min ristrutturazione bagno
→ project Ristrutturazione Bagno
→ type Tempo
→ conferma abilitata

mario
→ entity Mario
→ hint entità più specifiche
→ conferma abilitata

villa
→ project Villa
→ hint progetti più specifici
→ conferma abilitata

alfie mario rossi
→ ambiguità reale entity
→ conferma disabilitata finché non viene scelta entità

4 aprile benzina 50 euro alfie allevamento aspri
→ project ASPRI
→ entity ambigua
→ conferma disabilitata finché non viene scelta entità

NOTE:

Il nodo non ha introdotto:

- fuzzy matching
- alias
- gerarchie
- deduplicazione
- creazione automatica silenziosa project/entity
- match engine separato come modulo autonomo
- modifica schema DB
- output/KPI

RISCHIO RESIDUO:

- match engine avanzato separato non implementato
- alias non implementati
- fuzzy matching non implementato
- gerarchie project/entity non implementate
- deduplicazione project/entity non implementata
- creazione guidata project/entity implementata a primo livello controllato
- command intent create project/entity implementato a primo livello controllato
- resta assente input analysis model unico
- deduplicazione project/entity avanzata non implementata
- preview resta layer ibrido
- hint duration/type ancora embedded nella preview
- output/KPI non attivi

AZIONE:

Non riaprire come Match Engine Unification base.

Eventuali evoluzioni devono essere nodi dedicati:

- ALIAS / SYNONYMS CONTROLLED MATCHING
- DATA STRUCTURE / ENTITY HIERARCHY
- INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER
- SELECT OPTIONS FILTERING — AMBIGUITY UX
- MATCH CONFIDENCE / RANKING ADVANCED

ID: G11

NOME:
Data Structure / Entity Hierarchy

FONTE:
Database Schema + Match Engine + Roadmap

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Strutturazione relazioni project/entity:

gerarchie
parent_project_id
parent_entity_id
relazioni entity-project
deduplicazione
alias

NOTE:

Attualmente:

parent_project_id non operativo
parent_entity_id non operativo
entities senza UNIQUE name
possibili duplicati
integrità demandata a Retool

Match Engine Unification First Controlled Level ha ridotto
le ambiguità operative a livello runtime,
ma non ha risolto la struttura dati.

Restano aperti:

- parent_project_id non operativo
- parent_entity_id non operativo
- entities senza UNIQUE name
- possibili duplicati
- alias assenti
- deduplicazione assente
- relazioni entity-project assenti

Project / Entity Create Suggestion First Controlled Level ha introdotto
creazione inline controllata di project/entity,
ma non ha risolto la struttura dati avanzata.

La creazione inline migliora usabilità e completezza dati,
ma non introduce:

- gerarchie
- alias
- deduplicazione avanzata
- relazioni entity-project
- audit trail dedicato

UX Mobile Coherence Pass ha migliorato la fruibilità dei campi project/entity
e delle select su mobile, ma non ha modificato la struttura dati.

Command Intent — Create Project / Entity ha introdotto la creazione project/entity da comando puro,
ma non ha modificato la struttura dati.

Il nodo Command Intent:

- non introduce gerarchie
- non introduce alias
- non introduce deduplicazione avanzata
- non introduce relazioni entity-project
- non introduce vincoli DB
- blocca duplicati solo a livello UI quando riconosce un elemento già esistente

Durante il test UX sono emersi due sotto-gap collegati:

- suggestion create/edit consistency
- project creation override in presenza di match generico

RISCHIO:

Senza struttura:

matching ambiguo
entity duplicate
project/entity difficili da governare
report futuri deboli

AZIONE:

Micro-nodi UX/helper completati.

Da valutare come nodo strutturale futuro,
prima di output/KPI avanzati,
prima di deduplicazione evoluta
e prima di istanze verticali ASPRI / ADEXIMA / MaurizioLab.

Il nodo Project / Entity Create Suggestion base è già completato.
Le evoluzioni strutturali successive devono essere trattate qui o in nodi dedicati.

PRINCIPIO OPERATIVO

Un gap diventa documento SOLO se:

✔ necessario nello sviluppo reale
✔ validato su uso concreto
✔ non sostituibile da soluzione più semplice
✔ utile al nodo operativo imminente
✔ coerente con Roadmap e State

Un gap NON diventa nodo operativo se:

anticipa la roadmap
richiede refactor globale
introduce complessità non validata
non è necessario al problema immediato

ID: G12

NOME:
Events List Label / Updated At Display

FONTE:
Duration Normalization Session + Test runtime + UX Cleanup Micro-Batch

STATO:
INTEGRATO

DESCRIZIONE:

La lista eventi mostrava la dicitura “modificato oggi”
anche per eventi appena inseriti.

Il problema era visuale / UX,
ma poteva generare confusione utente.

CAUSE IDENTIFICATE:

- updated_at valorizzato anche in insert_event
- created_at / updated_at con formati timezone non omogenei
- confronto iniziale troppo fragile
- edit senza modifiche reali aggiornava comunque updated_at

STATO REALE:

Il nodo EVENTS LIST LABEL / UPDATED_AT DISPLAY FIX
è stato completato dentro:

UX / CLEANUP MICRO-BATCH POST MATCH ENGINE

Implementato:

- normalizzazione robusta created_at / updated_at
- parsing date DB trattato in modo coerente come UTC
- conversione visuale Europe/Rome
- soglia anti-falso positivo tra created_at e updated_at
- label “creato” per eventi mai modificati
- label “modificato” solo per eventi realmente aggiornati
- marcatore leggero per eventi modificati
- no-op edit guard in button_input_confirm
- conferma edit senza modifiche reali non esegue update_event
- updated_at non cambia se non cambiano campi utente
- amount / unit / event_date esclusi dal confronto no-op perché derivati dal parser

TEST VALIDATI:

- nuovo evento mostra “creato”
- edit senza modifiche resta “creato”
- annulla modifica resta “creato”
- edit con modifica reale mostra “modificato”
- evento modificato sale in alto nella lista
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica Match Engine
- nessuna modifica Type Classification
- nessuna modifica Duration Normalization

RISCHIO RESIDUO:

- non esiste audit trail storico delle modifiche
- updated_at traccia solo ultima modifica
- distinzione storica completa richiederebbe logging/versioning dedicato
- deduplicazione strutturale dopo command intent
- eventuale normalizzazione project/entity creati da command

AZIONE:

Gap integrato.

Non riaprire come fix label lista eventi.

Eventuali evoluzioni future devono passare da nodo dedicato:

- Logging / Versioning
- Event Revisions
- UI finale lista eventi

ID: G13

NOME:
Economic Direction Advanced

FONTE:
Type Classification Base + Database Schema + Roadmap

STATO:
IDENTIFICATO

DESCRIZIONE:

Gestione avanzata della direzione economica degli eventi.

Dopo Type Classification Base il sistema distingue:

- Spesa
- Incasso

ma il valore amount resta positivo.

Attualmente:

20 euro spesa materiale
→ type Spesa
→ amount 20
→ unit euro

20 euro incasso cliente
→ type Incasso
→ amount 20
→ unit euro

NON esiste ancora:

- amount firmato
- direction field
- money_direction
- regola contabile applicativa
- report economico attivo
- KPI basato su entrate/uscite

NOTE:

La distinzione Spesa / Incasso è già persistita in events.type.

La direzione economica può essere interpretata in futuro dai report,
oppure consolidata tramite nodo dedicato.

Rischio:

anticipare amount firmato o direction field ora potrebbe introdurre
complessità contabile prima della stabilizzazione matching/data quality.

AZIONE:

Non prioritario ora.

Da rivalutare dopo:

- Match Engine Unification First Controlled Level completato
- UX / Cleanup Micro-Batch completato
- Linting / State Helper Cleanup completato
- valutazione Data Structure / Entity Hierarchy
- prima definizione output/report
- valutazione dati economici reali
- Project / Entity Create Suggestion First Controlled Level completato
- Command Intent — Create Project / Entity completato a primo livello controllato

Possibili decisioni future:

1. mantenere amount sempre positivo e usare type per la direzione
2. introdurre direction field
3. introdurre amount firmato
4. derivare entrate/uscite solo in fase report

ID: G14

NOME:
Linting / State Helper Cleanup

FONTE:
Match Engine Unification Session + Retool runtime + Linting Cleanup Session

STATO:
INTEGRATO

DESCRIZIONE:

Risoluzione dei linting Retool residui sugli helper state:

- edit_mode
- editing_event

Prima del nodo, restavano 2 linting non bloccanti:

- edit_mode: 'value' is not defined
- editing_event: 'value' is not defined

CAUSA:

Gli helper edit_mode / editing_event usavano:

return value;

con valore passato tramite:

additionalScope: { value: ... }

Il runtime era corretto,
ma Retool segnalava value come variabile non definita.

STATO REALE:

Il nodo LINTING / STATE HELPER CLEANUP è stato completato.

Implementato:

- rimosso additionalScope { value } da edit_mode / editing_event
- introdotto passaggio controllato tramite window.__logos_edit_mode_value
- introdotto passaggio controllato tramite window.__logos_editing_event_value
- edit_mode legge window.__logos_edit_mode_value
- editing_event legge window.__logos_editing_event_value
- gli helper cancellano la chiave window dopo la lettura
- aggiornato btn_edit
- aggiornato btn_cancel_edit
- aggiornato button_input_confirm:
  - ramo no-op edit guard
  - reset finale dopo salvataggio reale
- editing_event azzerato anche dopo update reale completato

TEST VALIDATI:

- linting edit_mode risolto
- linting editing_event risolto
- create flow validato
- edit flow validato
- annulla modifica validato
- edit senza modifiche reali validato
- edit con modifica reale validato
- updated_at / label creato-modificato validati
- WRITTEN / ERROR validati

NOTE:

Il fix non ha modificato:

- parser
- trigger_parse_debounced
- project_state
- entity_state
- Match Engine
- Type Classification
- Duration Normalization
- schema DB
- insert_event
- update_event
- preview
- lista eventi

RISCHIO RESIDUO:

Nessun rischio operativo rilevato dopo i test.

Eventuali ulteriori warning Retool dovranno essere trattati solo se reali,
riproducibili e collegati a regressioni runtime.

AZIONE:

Gap integrato.

Non riaprire come micro-nodo base.

---

ID: G15

NOME:
Edit Mode Cancel / Return to Events List

FONTE:
Match Engine Unification Session + osservazione UX + UX Cleanup Micro-Batch

STATO:
INTEGRATO

DESCRIZIONE:

In modalità modifica evento mancava un pulsante per annullare
e tornare alla lista eventi senza salvare.

STATO REALE:

Il nodo EDIT MODE CANCEL / RETURN TO EVENTS LIST
è stato completato dentro:

UX / CLEANUP MICRO-BATCH POST MATCH ENGINE

ed è stato successivamente evoluto durante:

UX MOBILE COHERENCE PASS

in una logica cancel contestuale create/edit.

Implementato:

- nuovo pulsante btn_cancel_edit
- visibile solo in edit mode
- label “Annulla”
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

Comportamento aggiornato:

Create/input mode:

- label dinamica “Torna alla home”
- svuota input_home / input_raw
- resetta select_project / select_entity / select1
- resetta ui_state.parsed
- azzera feedback_text / feedback_project / feedback_summary
- torna Home
- nessun salvataggio

Edit mode:

- label dinamica “Annulla modifica”
- esce da edit_mode
- azzera editing_event
- svuota input/select
- resetta ui_state.parsed
- torna Lista eventi
- nessun update_event

Timer feedback pendente:

- viene cancellato se presente

Fix collegato:

btn_edit è stato rafforzato per evitare doppia visibilità tra:

- container_input
- container_events_list

TEST VALIDATI:

- entra in edit mode
- Annulla visibile solo in edit mode
- Annulla torna alla lista eventi
- nessun update_event eseguito
- edit_mode.data = false
- editing_event.data = null
- edit evento A → annulla → edit evento B senza doppia lista
- create/edit non regressi
- create/input → Torna alla home validato
- edit → Annulla modifica → Lista eventi validato
- nav corretta dopo cancel create/edit validata

RISCHIO RESIDUO:

Nessun rischio operativo rilevato.

AZIONE:

Gap integrato.

Non riaprire come micro-nodo base.
Eventuali miglioramenti grafici del pulsante devono restare fuori scope
fino a revisione UI finale del sistema stabile.

---

ID: G16

NOME:
Events List Search / Filter Bar

FONTE:
Richiesta utente + gestione lista eventi + UX Cleanup Micro-Batch

STATO:
INTEGRATO

DESCRIZIONE:

Aggiungere una barra di ricerca nella lista eventi
per facilitare ricerca e filtro degli eventi visualizzati.

STATO REALE:

Il nodo EVENTS LIST SEARCH / FILTER BAR
è stato completato dentro:

UX / CLEANUP MICRO-BATCH POST MATCH ENGINE

La lista eventi è stata successivamente rifinita durante:

UX MOBILE COHERENCE PASS

Implementato:

- input_events_search
- posizionato nella testata della lista eventi
- filtro client-side sulla Data source di list_events
- nessuna modifica a events_new
- nessuna modifica DB
- nessuna modifica insert/update
- nessuna modifica parser/matching/type/duration

La ricerca filtra su:

- raw_input
- type
- status
- nome progetto
- nome entità

Aggiornamenti UX Mobile Coherence Pass:

- titolo lista eventi rifinito
- sottotitolo aggiunto
- search bar ridimensionata
- icona search monotona tramite add-on Retool
- card evento rese più leggibili
- pulsanti OK / No / Modifica rifiniti con Icon add-ons
- navigation dock visibile in alto nella vista Events
- freccia indietro resa non necessaria dalla nav

TEST VALIDATI:

- campo vuoto mostra lista completa
- ricerca “materiale” funzionante
- ricerca “villa” funzionante
- ricerca “alfie” funzionante
- clear search funzionante
- lista resta operativa
- pulsanti WRITTEN / ERROR / EDIT invariati
- edit da lista filtrata funzionante
- annulla da lista filtrata funzionante

RISCHIO RESIDUO:

- layout mobile base ora rifinito
- eventuali filtri avanzati restano fuori scope
- polish finale font/spaziature rimandato
- non sono stati introdotti filtri avanzati strutturali

AZIONE:

Gap integrato.

Non riaprire come Search / Filter Bar base.
Eventuali filtri avanzati devono essere nodo dedicato,
non semplice estensione implicita.

---

ID: G17

NOME:
Preview Model / Hint State Consolidation

FONTE:
Preview System + Roadmap + Match Engine Unification

STATO:
IN OSSERVAZIONE — CANDIDATO PRINCIPALE POST COMMAND INTENT

DESCRIZIONE:

Consolidamento futuro della preview come modello più ordinato,
eventualmente più vicino a una view pura.

Dopo Match Engine Unification:

- hint matching project/entity sono allineati a project_state/entity_state
- highlight project/entity legge matches
- detection locale preview non è più fonte decisionale matching

Restano embedded nella preview:

- label cleaning
- hint duration normalization
- hint durata ambigua
- hint type / Spesa / Incasso
- highlight rendering
- formattazioni locali

Nota post UX Cleanup:

La label creato/modificato della lista eventi è stata corretta,
ma non modifica il modello preview.
Resta un intervento di lista/processing UX,
non un refactor preview.

Nota post Command Intent:

Durante il nodo COMMAND INTENT — CREATE PROJECT / ENTITY è emerso che il blocco “Da verificare” non è spostabile sotto la CTA perché fa parte della Sintesi.

Questo conferma che la preview resta un layer ibrido che contiene:

- contenuto principale
- hint
- warning informativi
- suggestion visive
- logiche di rendering

Il problema non ha generato regressioni dati,
ma rende più forte il candidato PREVIEW MODEL / HINT STATE CONSOLIDATION.

RISCHIO:

Un refactor preview globale può introdurre regressioni
in un layer UX già stabilizzato.

AZIONE:

Candidato principale post Command Intent, ma da aprire solo se scelto consapevolmente come nodo dedicato.

Non aprire come “Hint / Preview State Alignment” generico.

Eventuale nodo futuro solo se emerge un problema reale
o se si decide un refactor dedicato:

PREVIEW MODEL / HINT STATE CONSOLIDATION

Vincoli:

- nessun refactor globale senza nodo dedicato
- preservare preview alignment
- preservare duration visualization
- preservare type hints
- preservare match hints
- nessuna modifica DB

ID: G18

NOME:
UX Mobile Coherence Pass

FONTE:
Project / Entity Create Suggestion Session + UX mobile testing + iPhone Safari real test

STATO:
INTEGRATO BASE

DESCRIZIONE:

Rifinitura grafica e funzionale della UX mobile di LOGOS,
estendendo il lavoro sul suggestion container anche a:

- Home
- Input / Sintesi
- Da verificare
- Suggerimenti associazione
- Dati evento
- Events list
- Feedback
- Navigation dock
- Cancel create/edit
- Routing post-save

STATO REALE:

Il nodo UX MOBILE COHERENCE PASS è stato completato.

Implementato:

- Home mobile rifinita
- card Esempi resa coerente
- Azioni rapide rifinite e predisposte
- Suggestion container mobile rifinito
- Dati evento compattati con label inline nelle select
- Events list mobile rifinita
- Feedback mobile stabilizzato
- feedback_summary introdotto in ui_state
- Navigation dock Home / Eventi / Dashboard introdotta
- Dashboard presente ma disabilitata
- Icon add-ons Retool introdotti nei pulsanti reali
- cancel create/edit contestuale
- routing post-save contestuale
- font-size input/select portato a 16px per Safari iOS

Routing consolidato:

Insert reale:
→ feedback 1800 ms
→ Home

Update reale:
→ feedback 1800 ms
→ Lista eventi

Edit senza modifiche:
→ nessun update_event
→ nessun feedback
→ Lista eventi immediata

Cancel create/input:
→ Home

Cancel edit:
→ Lista eventi

Mobile Safari fix:

Durante test reale su iPhone 13 Safari sono stati rilevati:

- zoom automatico dopo tap input
- troncamento laterale dell’interfaccia
- select non pienamente utilizzabili come dropdown

Fix:

- font-size 16px sui campi editabili/select principali

Esito:

- zoom iOS risolto
- layout non troncato
- select funzionanti sia in digitazione sia in dropdown

Regola consolidata:

input/select mobile Safari devono mantenere font-size minimo 16px.

RISCHIO RESIDUO:

- Cambia / Scegli nella Sintesi ancora non cliccabili
- Azioni rapide non operative
- Dashboard non implementata
- suggestion create vs edit consistency da verificare
- project creation override con match generico non implementato
- Icon System non completamente standardizzato
- mobile compact advanced / polish finale rimandato
- rendering progressivo input evento normale osservato dopo Command Intent
- “Da verificare” resta dentro Sintesi e non è spostabile senza refactor preview

AZIONE:

Gap integrato a livello base.

Non riaprire come UX Cleanup — Suggestion Container / Mobile.

Eventuali evoluzioni devono diventare gap/nodi dedicati:

- Cambia / Scegli Actions
- Hint / Ambiguità Advanced
- Azioni Rapide Operative
- Dashboard Base
- Suggestion Create vs Edit Consistency
- Project Create Suggestion — Match Present / User Override
- Icon System / Mobile Polish Finale
- Input Rendering Stability / Container Structure
- Preview Model / Hint State Consolidation

ID: G19

NOME:
Command Intent — Create Project / Entity

FONTE:
Osservazione utente su placeholder/input mobile + Project / Entity Create Suggestion Session + Command Intent Session

STATO:
INTEGRATO BASE

DESCRIZIONE:

Riconoscimento controllato di frasi comando per creare project/entity
distinguendole da eventi ordinari.

Esempi:

- crea
- crea progetto
- crea progetto Aspri
- aggiungi progetto Villa Nuova
- inserisci progetto Villa Nuova
- nuovo progetto Villa Nuova
- crea entità Patrizio
- aggiungi entità Referente Kappa
- inserisci entità Marco Parisi
- nuova entità Marco Parisi
- modifica evento

STATO REALE:

Il nodo COMMAND INTENT — CREATE PROJECT / ENTITY è stato completato e validato.

Implementato:

- command_intent_state come query Retool page-level
- riconoscimento comando generico “crea”
- riconoscimento create project incompleto
- riconoscimento create project completo
- riconoscimento create entity incompleto
- riconoscimento create entity completo
- sinonimi base: crea, aggiungi, inserisci, nuovo, nuova
- riconoscimento elemento già presente
- blocco duplicazione project/entity già esistenti
- guida non operativa per “modifica evento”
- container_command_intent dentro container_input
- UI mobile Command Intent rifinita
- btn_command_create_project collegato a insert_project esistente
- btn_command_create_entity collegato a insert_entity esistente
- btn_command_go_events collegato alla lista eventi
- feedback_mode introdotto in ui_state
- feedback project_created implementato
- feedback entity_created implementato
- feedback evento ordinario preservato

Regole consolidate:

- comando puro non salva eventi
- project/entity da command vengono creati solo previa conferma utente
- insert_project / insert_entity restano le query operative di creazione
- command_intent_state non modifica DB
- command_intent_state non modifica parser
- command_intent_state non modifica matching
- command_intent_state non sostituisce create_suggestion_state
- select_project / select_entity restano decisione utente finale per gli eventi
- “modifica evento” non apre edit flow alternativo
- “modifica evento” non modifica record automaticamente

Esempi validati:

crea
→ guida con esempi
→ nessun evento salvato

crea progetto
→ campo nome progetto
→ conferma richiesta
→ nessun evento salvato

crea progetto Command Final Project 2
→ project creato
→ feedback Progetto creato
→ ritorno Home
→ nessun evento salvato

crea entità
→ campo nome entità
→ conferma richiesta
→ nessun evento salvato

crea entità Command Final Entity 2
→ entity creata
→ feedback Entità creata
→ ritorno Home
→ nessun evento salvato

crea progetto villa
→ elemento già presente
→ nessuna duplicazione
→ nessun evento salvato

modifica evento
→ guida con step
→ Vai agli eventi
→ nessuna modifica automatica

30 euro spesa villa citrignano
→ flow evento ordinario non regressivo

RISCHIO RESIDUO:

- Command Intent è solo un primo livello controllato
- non è ancora engine intent globale
- non gestisce dashboard/report
- non gestisce modifica project/entity da command
- non apre edit flow evento automatico
- non sostituisce parser, matching o suggestion
- non unifica ancora tutte le fonti di interpretazione
- rendering progressivo input evento normale ancora migliorabile
- “Da verificare” resta dentro Sintesi perché non è blocco autonomo

AZIONE:

Gap integrato a livello base.

Non riaprire come Command Intent — Create Project / Entity base.

Eventuali evoluzioni devono diventare gap/nodi dedicati:

- Input Analysis Model / Single Interpretation Layer
- Advanced Command Intent
- Dashboard Command / Report Intent
- Project / Entity Edit Command
- Azioni Rapide Operative

ID: G20

NOME:
Core Event System / Modular Instances

FONTE:
Allineamento strategico utente + Roadmap + State

STATO:
VALIDATO — VINCOLO STRATEGICO

DESCRIZIONE:

LOGOS mantiene l’obiettivo originario di essere un sistema espandibile a blocchi
fondato su un Core Event System stabile.

Il core è:

input libero
→ interpretazione controllata
→ project / entity / type / amount / date
→ evento normalizzato
→ ledger eventi
→ viste / moduli / dashboard futuri

Istanze future previste:

- ASPRI
- ADEXIMA
- MaurizioLab
- uso personale
- lavoro
- ristrutturazioni
- clienti / fornitori / attività

STATO REALE:

Il Core Event System è in costruzione avanzata.

Sono già consolidate:

- input reliability
- parser controllato
- normalization base
- duration normalization
- type classification base
- match engine unification first level
- project/entity create suggestion first level
- edit flow
- processing NEW / WRITTEN / ERROR
- UX mobile coherence pass
- command intent create project/entity first controlled level
- navigation dock Home / Eventi / Dashboard predisposta
- feedback post-save contestuale
- cancel create/edit contestuale

Non sono ancora attive:

- istanze verticali
- dashboard specifiche
- moduli ASPRI
- moduli ADEXIMA
- moduli MaurizioLab
- output/KP- Dashboard operativa, anche se predisposta in nav
- Azioni rapide operative, anche se predisposte in Home
- Command Intent avanzato per report/dashboard/modifiche strutturali

RISCHIO:

Anticipare istanze verticali prima della stabilità core può trasformare LOGOS
in un gestionale monolitico o frammentato,
perdendo l’obiettivo di sistema modulare.

AZIONE:

Mantenere come vincolo strategico anti-deriva.

Regola:

Le istanze ASPRI / ADEXIMA / MaurizioLab sono derivate future del core,
non nodi da anticipare ora.

Non aprire nodi verticali specifici come:

- dashboard ASPRI
- CRM ADEXIMA
- gestione MaurizioLab
- moduli animali / allevamento
- moduli fatture / preventivi
- moduli clienti avanzati

prima che il Core Event System sia sufficientemente stabile.

Sequenza corretta:

1. consolidare cuore eventi
2. consolidare gestione project/entity
3. rifinire UX mobile base
4. introdurre command intent guidato
5. consolidare rendering / preview / input analysis
6. consolidare data structure / qualità dati
7. solo dopo aprire dashboard operative, viste, istanze o moduli verticali

ID: G21

NOME:
Suggestion Create vs Edit Consistency

FONTE:
UX Mobile Coherence Pass + test edit flow

STATO:
IDENTIFICATO

DESCRIZIONE:

Durante il test del flow edit è stata osservata una possibile divergenza
tra suggestion mostrate in create flow e suggestion mostrate in edit flow.

Caso osservato:

- in create/input flow possono comparire suggestion project/entity
- in alcuni edit flow compare solo suggestion entity
- project suggestion può non comparire come atteso

STATO REALE:

Non corretto durante UX Mobile Coherence Pass.

Motivo:

La correzione potrebbe richiedere interventi su:

- create_suggestion_state
- condizioni di visibilità suggestion
- interazione tra edit_mode, input_raw, project_state/entity_state
- stato dismissed/open dei micro-editor

RISCHIO:

Intervenire dentro un nodo UX grafico avrebbe rischiato regressioni su:

- matching
- suggestion
- edit flow
- salvataggio
- create_suggestion_state

AZIONE:

Da valutare in nodo dedicato.

Vincoli:

- non modificare DB
- non modificare parser
- non introdurre creazioni automatiche
- preservare select_project / select_entity come decisione utente
- verificare prima comportamento reale create vs edit con casi riproducibili

ID: G22

NOME:
Project Create Suggestion — Match Present / User Override

FONTE:
UX Mobile Coherence Pass + osservazione input “villa”

STATO:
IDENTIFICATO

DESCRIZIONE:

Quando l’input produce un match generico esistente,
il sistema può mostrare hint “esistono progetti più specifici”,
ma non propone la creazione di un nuovo progetto.

Caso osservato:

input:
villa

Comportamento attuale:

- project Villa selezionabile / riconosciuto
- hint progetti più specifici disponibile
- nessuna proposta di creazione nuovo progetto

Problema potenziale:

L’utente potrebbe voler creare un nuovo progetto correlato,
anche se esiste un match generico.

STATO REALE:

Non implementato.

Decisione attuale:

Il sistema evita creazioni aggressive se esiste già un match,
per ridurre rischio duplicati.

RISCHIO:

Permettere creazione progetto in presenza di match generico può causare:

- duplicati
- rumore nei progetti
- peggioramento matching
- confusione tra selezione progetto esistente e creazione nuovo progetto

AZIONE:

Da valutare in nodo dedicato.

Possibile direzione:

- mostrare una opzione esplicita “Crea comunque nuovo progetto”
- richiedere conferma forte
- mostrare progetti simili prima di creare
- non attivare su ambiguità bloccante
- non creare automaticamente

ID: G23

NOME:
Azioni Rapide Operative

FONTE:
UX Mobile Coherence Pass + Home mobile

STATO:
VALIDATO — NODO FUTURO

DESCRIZIONE:

La Home contiene ora una sezione “Azioni rapide” con pulsanti:

- Registra spesa
- Registra incasso
- Registra tempo
- Registra evento

STATO REALE:

I pulsanti sono stati rifiniti graficamente e predisposti,
ma non sono ancora operativi come flow guidato.

Attualmente non devono bypassare:

- input libero
- select Tipo evento
- project/entity decision
- Conferma evento

RISCHIO:

Renderli operativi troppo presto può duplicare logiche già presenti
in input libero, type classification e button_input_confirm.

Dopo Command Intent, il rischio include anche la duplicazione di logiche tra:

- Azioni rapide
- command_intent_state
- type classification
- input libero
- button_input_confirm

AZIONE:

Da sviluppare come nodo futuro dedicato.

Possibili comportamenti:

- preimpostare select1
- focalizzare input
- mostrare placeholder contestuale
- guidare l’utente senza creare eventi automaticamente
- non salvare nulla senza conferma
- coordinarsi con command_intent_state senza duplicare riconoscimenti

ID: G24

NOME:
Dashboard Base

FONTE:
UX Mobile Coherence Pass + Navigation Dock

STATO:
VALIDATO — NODO FUTURO NON IMMEDIATO

DESCRIZIONE:

La navigation dock ora prevede tre aree:

- Home
- Eventi
- Dashboard

La voce Dashboard è presente ma disabilitata.

STATO REALE:

Dashboard non implementata.
Nessun KPI attivo.
Nessuna reportistica attiva.

Decisione:

La voce Dashboard è stata predisposta per evitare di rifare la struttura UX,
ma non abilita lo STEP 7 OUTPUT.

RISCHIO:

Attivare Dashboard troppo presto può produrre metriche fuorvianti perché:

- data structure non consolidata
- economic direction non avanzata
- amount firmato non definito
- type base non sufficiente per KPI avanzati
- dati storici non retro-normalizzati

AZIONE:

Non immediato.

Da valutare solo dopo:

- Command Intent base completato
- Data Structure, se necessaria
- eventuale Dashboard Command / Report Intent solo in nodo dedicato
- Economic Direction Advanced, se necessaria
- sufficienza dati reali
- decisione su KPI minimi non fuorvianti

ID: G25

NOME:
Icon System / Mobile Polish Finale

FONTE:
UX Mobile Coherence Pass + Retool add-ons

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Durante UX Mobile Coherence Pass sono stati introdotti Icon add-ons Retool
nei pulsanti reali:

- Azioni rapide
- Navigation dock
- Conferma evento
- Torna alla home / Annulla modifica
- Events list OK / No / Modifica
- Search events

Nella Sintesi e nel Feedback restano icone/emoji HTML già funzionanti.

STATO REALE:

Sistema misto:

- Icon add-ons Retool nei componenti reali
- emoji/icon HTML nella Sintesi e Feedback

Decisione attuale:

Non modificare Sintesi/Feedback perché funzionano e sono sensibili a regressioni HTML.

RISCHIO:

Standardizzare tutto ora potrebbe riaprire codice già validato.

AZIONE:

Da rivalutare solo in polish finale.

Vincoli:

- non toccare parser
- non toccare matching
- non toccare salvataggio
- non rompere Sintesi / Feedback
- preservare leggibilità mobile

ID: G26

NOME:
Mobile Safari Font Baseline

FONTE:
Test reale iPhone 13 Safari + UX Mobile Coherence Pass

STATO:
INTEGRATO COME REGOLA TECNICA

DESCRIZIONE:

Su iPhone 13 Safari è stato osservato zoom automatico sui campi editabili
e comportamento anomalo delle select.

Problemi osservati:

- tap su input causava zoom automatico
- app troncata lateralmente dopo zoom
- select Tipo / Progetto / Entità non pienamente utilizzabili come dropdown

Fix applicato:

- font-size portato a 16px su input/select principali

Esito:

- zoom automatico risolto
- layout non troncato
- select funzionanti sia in digitazione sia in dropdown

Regola:

Input e select principali su mobile Safari devono mantenere font-size minimo 16px.

AZIONE:

Gap integrato come regola tecnica.
Non riaprire salvo regressioni reali.

Da ricordare nel polish finale:

- eventuali riduzioni font non devono riattivare zoom iOS
- testare sempre su iPhone reale / Safari o WebKit

ID: G27

NOME:
Input Rendering Stability / Container Structure

FONTE:
Command Intent Session + test runtime input evento normale

STATO:
IDENTIFICATO — CANDIDATO PRINCIPALE

DESCRIZIONE:

Durante il nodo Command Intent è stato osservato un residuo UX:

input evento normale
→ Sintesi / hint / suggestion possono comparire progressivamente

Il comportamento non rompe:

- parser
- matching
- salvataggio
- DB
- edit flow
- feedback

ma può disturbare la percezione di stabilità dell’interfaccia mobile.

STATO REALE:

Non corretto nel nodo Command Intent.

Motivo:

Intervenire avrebbe richiesto modifiche più ampie su:

- struttura container_input
- separazione preview / hint / dati evento
- eventuale stato unico input_analysis_ready
- timing tra parse_input_controlled, project_state, entity_state, create_suggestion_state e command_intent_state

RISCHIO:

Un fix locale non progettato potrebbe peggiorare:

- input evento normale
- command intent
- suggestion container
- edit flow
- rendering mobile

AZIONE:

Da valutare come nodo dedicato.

Possibili direzioni:

- stato unico input_analysis_ready
- skeleton / placeholder durante analisi
- separazione container preview / hint / dati evento
- riduzione rendering progressivo
- mantenimento parser/matching/DB invariati

ID: G28

NOME:
Input Analysis Model / Single Interpretation Layer

FONTE:
Command Intent Session + Match Engine Unification + osservazioni utente su fonti parallele

STATO:
IDENTIFICATO — STRUTTURALE FUTURO

DESCRIZIONE:

Direzione futura verso un solo layer di analisi interrogabile dalle UI.

Oggi LOGOS usa più fonti controllate:

- parse_input_controlled
- ui_state.parsed
- project_state
- entity_state
- create_suggestion_state
- command_intent_state
- preview logic
- select_project / select_entity / select1

Questa struttura è funzionante,
ma resta distribuita.

STATO REALE:

Non implementato.

Il nodo Command Intent ha aggiunto command_intent_state come helper controllato,
senza sostituire parser, matching o suggestion.

Questo è corretto per il nodo,
ma conferma la necessità futura di valutare un modello unico di analisi.

RISCHIO:

Unificare troppo presto può rompere il sistema stabile.

Non unificare mai può aumentare:

- fonti parallele
- difficoltà di debug
- incoerenza tra ciò che l’utente legge e ciò che viene salvato
- rischio di comportamenti divergenti tra preview, suggestion, command e save

AZIONE:

Da valutare solo in nodo dedicato.

Vincoli:

- non introdurre refactor globale senza checkpoint
- non sostituire componenti stabili senza test
- mantenere compatibilità con Retool
- preservare parser, matching, suggestion e save flow finché non esiste alternativa validata
- procedere per consolidamento progressivo

ORDINE CONSIGLIATO GAP / NODI

Ordine attuale consigliato dopo Command Intent:

NODI STRUTTURALI / OPERATIVI FUTURI:

1. G27 — Input Rendering Stability / Container Structure
2. G17 — Preview Model / Hint State Consolidation
3. G28 — Input Analysis Model / Single Interpretation Layer
4. G11 — Data Structure / Entity Hierarchy
5. G21 — Suggestion Create vs Edit Consistency
6. G22 — Project Create Suggestion — Match Present / User Override
7. G13 — Economic Direction Advanced
8. G08A — Duration Advanced / Giorni-Settimane
9. G23 — Azioni Rapide Operative
10. G24 — Dashboard Base
11. G04 — Logging / Versioning
12. G05 — Input Modes
13. G06 — Multi-source Input

POLISH / UX FUTURO:

- G25 — Icon System / Mobile Polish Finale

VINCOLI TECNICI:

- G26 — Mobile Safari Font Baseline

VINCOLI STRATEGICI:

- G20 — Core Event System / Modular Instances

Gap già integrati:

G03 — Project / Entity Create Suggestion
G07 — Preview Alignment
G08 — Duration Normalization Base
G09 — Type Classification Base
G10 — Match Engine Unification First Controlled Level
G12 — Events List Label / Updated At Display
G14 — Linting / State Helper Cleanup
G15 — Edit Mode Cancel / Return to Events List
G16 — Events List Search / Filter Bar
G18 — UX Mobile Coherence Pass
G19 — Command Intent — Create Project / Entity
G26 — Mobile Safari Font Baseline

Nota:

l’ordine deve sempre essere verificato contro:

00_PROJECT_State
00_PROJECT_Roadmap
checkpoint più recente

CHANGELOG

v01 — 2026-04-01

Creazione Gap Register
Consolidamento gap da audit + gap analysis
Introduzione sistema di validazione progressiva

v02 — 2026-04-30

aggiornato G01 Normalization Model a INTEGRATO PARZIALE
aggiornato G02 Processor / Engine Flow a VALIDATO / PARZIALMENTE AVVIATO
aggiunti gap G07 Preview Alignment
aggiunto gap G08 Duration Normalization
aggiunto gap G09 Type Classification Base
aggiunto gap G10 Match Engine Unification
aggiunto gap G11 Data Structure / Entity Hierarchy
classificato G06 Multi-source Input come NON PRIORITARIO
aggiornato ordine consigliato gap/nodi
allineamento con State v10 e Roadmap v04

v03 — 2026-04-30

aggiornato G07 Preview Alignment a INTEGRATO
aggiornato G08 Duration Normalization a INTEGRATO BASE
documentata unità canonica tempo = minuti
documentata normalizzazione durate certe ore/minuti
documentato raw_input preservato
documentato che giorni/settimane restano sotto-gap avanzato
aggiornato G01 Normalization Model dopo Duration Normalization
aggiornato G02 Processor / Engine Flow
aggiornato G09 Type Classification Base come prossimo nodo candidato
aggiunto G12 Events List Label / Updated At Display
aggiornato ordine consigliato gap/nodi
allineamento con State v12 e Roadmap v06

v05 — 2026-05-02

aggiornato G10 Match Engine Unification a INTEGRATO BASE
documentato completamento Match Engine Unification First Controlled Level
documentato project_state/entity_state come fonte minima matching
documentato singleMatch / isAmbiguous / moreSpecificMatches
documentato select_project/select_entity allineati al match state
documentato confirm guard su ambiguità non risolta
documentato match state live in create/edit flow
documentato priority match minimo
documentato hint match più specifici
documentato bug €500 preview risolto
aggiornato G03 come Project / Entity Create Suggestion
aggiunto G14 Linting / State Helper Cleanup
aggiunto G15 Edit Mode Cancel / Return to Events List
aggiunto G16 Events List Search / Filter Bar
aggiunto G17 Preview Model / Hint State Consolidation
aggiornato G07 Preview Alignment con nota post Match Engine
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G12 Events List Label / Updated At Display
aggiornato G13 Economic Direction Advanced
aggiornato G06 Multi-source Input
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
allineamento con State v14 e Roadmap v08

v06 — 2026-05-02

aggiornato Gap Register dopo UX / CLEANUP MICRO-BATCH POST MATCH ENGINE
aggiornato G12 Events List Label / Updated At Display a INTEGRATO
documentata correzione label creato/modificato
documentata normalizzazione robusta created_at / updated_at
documentato no-op edit guard
documentato che edit senza modifiche non aggiorna updated_at
aggiornato G15 Edit Mode Cancel / Return to Events List a INTEGRATO
documentato btn_cancel_edit
documentato reset edit_mode / editing_event / input / select / ui_state.parsed
documentato ritorno lista eventi senza update_event
documentato fix doppia visibilità input/lista
aggiornato G16 Events List Search / Filter Bar a INTEGRATO
documentato input_events_search
documentato filtro client-side su list_events
documentata ricerca su raw_input / type / status / project / entity
aggiornato G14 Linting / State Helper Cleanup come unico micro-nodo residuo
confermato linting edit_mode/editing_event come residuo non bloccante
aggiornato G02 Processor / Engine Flow
aggiornato G17 Preview Model / Hint State Consolidation con nota post UX cleanup
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
allineamento con State v15 e Roadmap v09

v07 — 2026-05-03

aggiornato Gap Register dopo LINTING / STATE HELPER CLEANUP
aggiornato G14 Linting / State Helper Cleanup a INTEGRATO
documentata risoluzione linting edit_mode: 'value' is not defined
documentata risoluzione linting editing_event: 'value' is not defined
documentata rimozione additionalScope { value } da edit_mode / editing_event
documentato passaggio controllato tramite window.__logos_edit_mode_value
documentato passaggio controllato tramite window.__logos_editing_event_value
documentato reset chiavi window dopo lettura helper
documentato aggiornamento btn_edit
documentato aggiornamento btn_cancel_edit
documentato aggiornamento button_input_confirm nel ramo no-op edit guard
documentato aggiornamento button_input_confirm nel reset finale dopo salvataggio reale
documentato azzeramento editing_event dopo update reale completato
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
aggiornato G02 Processor / Engine Flow rimuovendo Linting Cleanup dai nodi residui
aggiornato G11 Data Structure / Entity Hierarchy dopo chiusura micro-nodi helper
aggiornato G13 Economic Direction Advanced con Linting Cleanup completato
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
allineamento con State v16 e Roadmap v10

v08 — 2026-05-07

aggiornato Gap Register dopo PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
aggiornato G03 Project / Entity Create Suggestion a INTEGRATO BASE
documentato create_suggestion_state
documentate variabili project/entity inline open e dismissed
documentate query insert_project / insert_entity
documentato container suggestion inline
documentati micro-editor project/entity
documentato bottone Ignora globale
documentati bottoni Annulla contestuali
documentata creazione project inline validata su DB reale
documentata creazione entity inline validata su DB reale
documentato select_project valorizzato dopo creazione project
documentato select_entity valorizzato dopo creazione entity
documentato evento non salvato automaticamente dopo creazione project/entity
documentato evento salvato manualmente con project_id/entity_id corretti
documentato blocco solo su ambiguità project/entity attiva
documentato salvataggio consentito senza project/entity
documentato entity autofill controlled minimal
documentato flow combinato project + entity
aggiunto G18 UX Cleanup — Suggestion Container / Mobile
aggiunto G19 Command Intent — Create Project / Entity
aggiunto G20 Core Event System / Modular Instances
aggiornato G02 Processor / Engine Flow
aggiornato G06 Multi-source Input
aggiornato G10 Match Engine Unification
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G13 Economic Direction Advanced
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
confermata direzione LOGOS Core modulare
confermate istanze ASPRI / ADEXIMA / MaurizioLab come derivate future del core
allineamento con State v17 e Roadmap v11

v09 — 2026-05-09

aggiornato Gap Register dopo UX MOBILE COHERENCE PASS
aggiornato G18 da UX Cleanup — Suggestion Container / Mobile a UX Mobile Coherence Pass
aggiornato G18 a INTEGRATO BASE
documentata Home mobile rifinita
documentata Events list mobile rifinita
documentato Feedback mobile stabilizzato
documentato feedback_summary in ui_state
documentato routing post-save contestuale
documentato insert → feedback → Home
documentato update → feedback → Lista eventi
documentato no-op edit → Lista eventi senza update_event
documentato cancel create/input → Home
documentato cancel edit → Lista eventi
documentata Navigation dock Home / Eventi / Dashboard
documentata Dashboard predisposta ma disabilitata
documentate Azioni rapide predisposte ma non operative
documentato font-size 16px input/select come fix iOS Safari
documentato zoom automatico Safari iOS risolto
documentata select mobile funzionante in digitazione/dropdown
aggiunto G21 Suggestion Create vs Edit Consistency
aggiunto G22 Project Create Suggestion — Match Present / User Override
aggiunto G23 Azioni Rapide Operative
aggiunto G24 Dashboard Base
aggiunto G25 Icon System / Mobile Polish Finale
aggiunto G26 Mobile Safari Font Baseline
aggiornato G02 Processor / Engine Flow
aggiornato G03 Project / Entity Create Suggestion
aggiornato G05 Input Modes
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G15 Edit Mode Cancel / Return to Events List
aggiornato G16 Events List Search / Filter Bar
aggiornato G19 Command Intent — Create Project / Entity
aggiornato G20 Core Event System / Modular Instances
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
confermata direzione LOGOS Core modulare
allineamento con State v18 e Roadmap v12

v10 — 2026-05-13

aggiornato Gap Register dopo COMMAND INTENT — CREATE PROJECT / ENTITY
aggiornato G19 Command Intent — Create Project / Entity a INTEGRATO BASE
documentato command_intent_state
documentato riconoscimento comando generico “crea”
documentato create project incompleto
documentato create project completo
documentato create entity incompleto
documentato create entity completo
documentati sinonimi base crea / aggiungi / inserisci / nuovo / nuova
documentato blocco duplicati project/entity già esistenti
documentato “crea progetto villa” come elemento già presente
documentata guida non operativa “modifica evento”
documentato container_command_intent
documentati btn_command_create_project / btn_command_create_entity / btn_command_go_events
documentato riuso insert_project / insert_entity
documentato feedback_mode in ui_state
documentato feedback project_created
documentato feedback entity_created
documentato feedback evento ordinario preservato
documentato che comandi puri non salvano eventi
documentato che project/entity da command richiedono conferma utente
documentato che Command Intent non modifica DB/parser/matching/create_suggestion_state
aggiornato G02 Processor / Engine Flow
aggiornato G03 Project / Entity Create Suggestion
aggiornato G05 Input Modes
aggiornato G06 Multi-source Input
aggiornato G07 Preview Alignment
aggiornato G10 Match Engine Unification
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G13 Economic Direction Advanced
aggiornato G17 Preview Model / Hint State Consolidation
aggiornato G18 UX Mobile Coherence Pass
aggiornato G20 Core Event System / Modular Instances
aggiornato G23 Azioni Rapide Operative
aggiornato G24 Dashboard Base
aggiunto G27 Input Rendering Stability / Container Structure
aggiunto G28 Input Analysis Model / Single Interpretation Layer
aggiornato ordine consigliato gap/nodi post Command Intent
confermato output/KPI non attivi
confermata direzione LOGOS Core modulare
allineamento con State v19 e Roadmap v13