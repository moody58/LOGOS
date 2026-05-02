# 00_PROJECT_Gap_Register_v05

DATA: 2026-05-02

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
Project / Entity Create Suggestion

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

Sono stati avviati e completati quattro blocchi engine base:

- Normalization Layer Base
- Duration Normalization Base
- Type Classification Base
- Match Engine Unification First Controlled Level

Tuttavia non esiste ancora un Processor/Engine Flow completo.

Attualmente:

parsing, normalization base, duration normalization, type classification base e match state project/entity sono in Retool
durate certe ore/minuti sono normalizzate in minuti
type viene salvato in events.type
Spesa / Incasso / Tempo / Evento sono persistiti a livello base
project_state / entity_state sono fonte minima matching project/entity
select_project / select_entity leggono singleMatch
matching project/entity è unificato a primo livello controllato
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
Procedere per nodi minimi:

Linting / State Helper Cleanup
Edit Mode Cancel / Return to Events List
Events List Search / Filter Bar
Project / Entity Create Suggestion
Data Structure / Entity Hierarchy
Economic Direction Advanced
Duration Advanced — giorni/settimane

ID: G03

NOME:
Project / Entity Create Suggestion

FONTE:
Gap Analysis + Match Engine + Match Engine Unification First Controlled Level

STATO:
VALIDATO — NODO FUTURO

DESCRIZIONE:

Creazione guidata di project/entity quando l’input cita un project/entity
non ancora presente nel sistema.

Il sistema dovrà poter proporre all’utente:

- “Crea nuovo progetto?”
- “Crea nuova entità?”

solo quando non viene trovato un match affidabile.

NOTE:

Attualmente:

- matching project/entity unificato a primo livello controllato
- project_state / entity_state calcolano matches / count / isAmbiguous / singleMatch
- nessun match project/entity NON blocca il salvataggio
- project_id/entity_id restano null se non selezionati
- nessuna creazione automatica
- nessun pending state
- nessuna gerarchia entity/project
- nessuna deduplicazione strutturale

Decisione consolidata:

nessun match → salvataggio consentito con project_id/entity_id null

Questo mantiene input non bloccante
e prepara un futuro nodo di creazione guidata.

RISCHIO:

Creare project/entity automaticamente può generare duplicati
e peggiorare la qualità del dato.

Serve quindi:

- conferma esplicita utente
- controllo duplicati
- eventuale pending state
- valutazione Data Structure / Entity Hierarchy
- eventuale gestione alias

AZIONE:

Non implementato nel nodo Match Engine Unification.

Da sviluppare come nodo futuro dedicato:

PROJECT / ENTITY CREATE SUGGESTION

Utile per:

- input vocali
- Siri
- inserimenti rapidi
- project/entity non ancora presenti

Vincoli futuri:

- nessuna creazione automatica silenziosa
- creazione solo previa conferma utente
- evitare duplicati
- non modificare schema DB senza nodo dedicato

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

RISCHIO:

Introdurre modalità guidata troppo presto può duplicare logiche
e peggiorare la manutenzione.

AZIONE:

Non prioritario ora.

Da rivalutare dopo:

Match Engine Unification
Data Structure / Entity Hierarchy
Economic Direction Advanced

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
creazione guidata project/entity non implementata
input vocali/Siri non ancora pronti

RISCHIO:

Input multi-source aumenterebbe complessità prima della maturità dati.

AZIONE:

Non lavorare ora.

Da rivalutare solo dopo:

input system maturo
Project / Entity Create Suggestion implementato o valutato
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

solo se emerge un problema reale o se si decide un refactor preview dedicato.

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
- creazione automatica project/entity
- match engine separato come modulo autonomo
- modifica schema DB
- output/KPI

RISCHIO RESIDUO:

- match engine avanzato separato non implementato
- alias non implementati
- fuzzy matching non implementato
- gerarchie project/entity non implementate
- deduplicazione project/entity non implementata
- creazione guidata project/entity non implementata
- preview resta layer ibrido
- hint duration/type ancora embedded nella preview
- output/KPI non attivi

AZIONE:

Non riaprire come Match Engine Unification base.

Eventuali evoluzioni devono essere nodi dedicati:

- ALIAS / SYNONYMS CONTROLLED MATCHING
- DATA STRUCTURE / ENTITY HIERARCHY
- PROJECT / ENTITY CREATE SUGGESTION
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

RISCHIO:

Senza struttura:

matching ambiguo
entity duplicate
project/entity difficili da governare
report futuri deboli

AZIONE:

Non prioritario immediato rispetto ai micro-nodi UX/helper.

Da valutare prima di output/KPI avanzati
o prima di Project / Entity Create Suggestion strutturale.

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
Duration Normalization Session + Test runtime

STATO:
IDENTIFICATO

DESCRIZIONE:

La lista eventi mostra la dicitura “modificato oggi”
anche per eventi appena inseriti.

Causa probabile:

updated_at viene valorizzato anche in insert_event.
La UI della lista interpreta la presenza di updated_at come modifica,
senza distinguere created_at / updated_at o insert/update.

NOTE:

Il problema è solo visuale / UX.

Non impatta:

- parsing
- duration normalization
- save flow
- DB
- amount/unit
- status evento

RISCHIO:

Può generare confusione utente,
facendo apparire modificato un evento appena creato.

AZIONE:

Nodo candidato dopo Match Engine Unification,
soprattutto come micro-fix UX.

Possibile micro-nodo futuro:

EVENTS LIST LABEL / UPDATED_AT DISPLAY FIX

Scope:

- distinguere “creato oggi” da “modificato oggi”
- confrontare created_at / updated_at
- evitare falsa indicazione di modifica su primo inserimento
- nessuna modifica engine
- nessuna modifica parsing
- nessuna modifica DB salvo decisione dedicata

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
- eventuali micro-nodi UX/helper
- valutazione Data Structure / Entity Hierarchy
- prima definizione output/report
- valutazione dati economici reali

Possibili decisioni future:

1. mantenere amount sempre positivo e usare type per la direzione
2. introdurre direction field
3. introdurre amount firmato
4. derivare entrate/uscite solo in fase report

ID: G14

NOME:
Linting / State Helper Cleanup

FONTE:
Match Engine Unification Session + Retool runtime

STATO:
IDENTIFICATO — MICRO-NODO CANDIDATO

DESCRIZIONE:

Restano 2 linting Retool non bloccanti:

- edit_mode: 'value' is not defined
- editing_event: 'value' is not defined

Stato runtime:

- edit_mode funziona
- editing_event funziona
- edit flow validato
- create flow validato
- nessun errore runtime rilevato
- probabile origine: additionalScope { value: ... }

NOTE:

Durante Match Engine Unification sono stati invece risolti
i linting project_state/entity_state.

RISCHIO:

Rumore tecnico futuro.
Possibile confusione durante debug Retool.

AZIONE:

Micro-nodo candidato.

Scope:

- ripulire edit_mode / editing_event
- eliminare riferimento ambiguo a value
- preservare comportamento edit flow
- nessuna modifica matching
- nessuna modifica parser
- nessuna modifica DB

---

ID: G15

NOME:
Edit Mode Cancel / Return to Events List

FONTE:
Match Engine Unification Session + osservazione UX

STATO:
IDENTIFICATO — MICRO-NODO CANDIDATO

DESCRIZIONE:

In modalità modifica evento manca un pulsante per annullare
e tornare alla lista eventi.

Attualmente:

- edit flow funziona
- btn_edit carica evento
- match state viene rilanciato
- update_event funziona
- ma manca uscita esplicita da edit mode senza salvare

RISCHIO:

L’utente può restare nel flusso modifica senza chiara via di uscita.
Possibile confusione tra inserimento nuovo e modifica evento.

AZIONE:

Micro-nodo candidato.

Scope:

- aggiungere controllo “Annulla modifica”
- uscire da edit_mode
- svuotare input_home/input_raw
- pulire select_project/select_entity
- ripristinare ui_state.parsed
- tornare alla lista eventi o vista coerente
- nessuna modifica engine
- nessuna modifica DB

---

ID: G16

NOME:
Events List Search / Filter Bar

FONTE:
Richiesta utente + gestione lista eventi

STATO:
IDENTIFICATO — MICRO-NODO CANDIDATO

DESCRIZIONE:

Aggiungere una barra di ricerca nella lista eventi
per facilitare ricerca e filtro degli eventi visualizzati.

Motivo:

con l’aumento degli eventi NEW,
la lista diventa più difficile da gestire manualmente.

Scope possibile:

- ricerca testuale su raw_input / descrizione evento
- eventuale filtro futuro per project/entity/type/status
- nessuna modifica engine
- nessuna modifica DB obbligatoria nella prima versione
- nessuna alterazione insert/update

RISCHIO:

Basso, se implementato come filtro UI client-side o query controllata.
Evitare però refactor lista eventi non necessario.

AZIONE:

Micro-nodo candidato post Match Engine Unification.

ID: G17

NOME:
Preview Model / Hint State Consolidation

FONTE:
Preview System + Roadmap + Match Engine Unification

STATO:
IN OSSERVAZIONE — NON IMMEDIATO

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

RISCHIO:

Un refactor preview globale può introdurre regressioni
in un layer UX già stabilizzato.

AZIONE:

Non immediato.

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

ORDINE CONSIGLIATO GAP / NODI

Ordine attuale consigliato dopo Match Engine Unification:

MICRO-NODI CANDIDATI:

1. G14 — Linting / State Helper Cleanup
2. G15 — Edit Mode Cancel / Return to Events List
3. G16 — Events List Search / Filter Bar
4. G12 — Events List Label / Updated At Display

NODI STRUTTURALI FUTURI:

5. G03 — Project / Entity Create Suggestion
6. G11 — Data Structure / Entity Hierarchy
7. G13 — Economic Direction Advanced
8. G08A — Duration Advanced / Giorni-Settimane
9. G17 — Preview Model / Hint State Consolidation
10. G04 — Logging / Versioning
11. G05 — Input Modes
12. G06 — Multi-source Input

Gap già integrati:

G07 — Preview Alignment
G08 — Duration Normalization Base
G09 — Type Classification Base
G10 — Match Engine Unification First Controlled Level

Nota:

l’ordine deve sempre essere verificato contro:

00_PROJECT_State
00_PROJECT_Roadmap
checkpoint più recente

Attualmente nessun gap è completamente scartato.

G06 è classificato NON PRIORITARIO,
ma non viene eliminato perché può tornare utile in futuro.

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