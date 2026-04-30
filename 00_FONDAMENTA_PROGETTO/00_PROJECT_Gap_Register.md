# 00_PROJECT_Gap_Register_v03

DATA: 2026-04-30

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

RISCHIO RESIDUO:

Dati ancora parzialmente confrontabili perché restano non implementati:

type classification
spesa/incasso
normalizzazione project/entity
giorni/settimane come durata automatica
retro-normalizzazione storico

AZIONE:

Mantenere il gap aperto come INTEGRATO PARZIALE.

Prossimi sotto-gap:

Type Classification Base
Match Engine Unification
Duration Advanced — giorni/settimane

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

Sono stati avviati e completati due blocchi engine base:

- Normalization Layer Base
- Duration Normalization Base

Tuttavia non esiste ancora un Processor/Engine Flow completo.

Attualmente:

parsing, normalization base e duration normalization sono in Retool
durate certe ore/minuti sono normalizzate in minuti
matching resta distribuito
preview contiene logiche proprie
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

Type Classification Base
Match Engine Unification
Data Structure / Entity Hierarchy
Duration Advanced — giorni/settimane

ID: G03

NOME:
Entity/Project Async Workflow

FONTE:
Gap Analysis + Match Engine

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Creazione entità/progetti asincrona con pending state,
quando l’input cita project/entity non ancora presenti.

NOTE:

Attualmente:

solo selezione manuale
nessuna creazione automatica
nessun pending state
nessuna gerarchia entity/project
matching non unificato

RISCHIO:

Creare project/entity automaticamente può generare duplicati
e peggiorare la qualità del dato.

AZIONE:

Non prioritario ora.

Da rivalutare dopo:

Match Engine Unification
Data Structure / Entity Hierarchy
eventuale gestione duplicati

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

Type Classification Base
Match Engine Unification
Data Structure / Entity Hierarchy

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
type classification ancora assente
matching ancora non unificato

RISCHIO:

Input multi-source aumenterebbe complessità prima della maturità dati.

AZIONE:

Non lavorare ora.

Da rivalutare solo dopo:

input system maturo
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
- hint non completamente state-driven
- matching locale preview non unificato

AZIONE:

Gap integrato come Preview Alignment Base.

Non aprire ulteriori nodi preview generici.
Eventuali modifiche preview devono essere conseguenza controllata di nodi futuri specifici.

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
- type/select1 non sempre allineato a unit = minuti

AZIONE:

Gap integrato a livello base.

Tenere aperto solo come sotto-gap futuro:

DURATION ADVANCED — GIORNI / SETTIMANE

Da non riaprire come Duration Normalization Base.

ID: G09

NOME:
Type Classification Base

FONTE:
Input System + domanda utente + Roadmap

STATO:
VALIDATO

DESCRIZIONE:

Classificazione base evento:

evento
tempo
economico
spesa
incasso

NOTE:

Attualmente:

tempo dedotto da unità tempo
economico dedotto da euro
evento come default
nessuna distinzione affidabile spesa/incasso
type non utilizzato per KPI

Problema reale emerso dopo Duration Normalization:

input come 2h30 rendering viene normalizzato correttamente:

amount 150
unit minuti

ma select1 può restare su Evento.

La type detection deve essere allineata a ui_state.parsed,
in particolare a:

unit = minuti → tempo
unit = euro → economico

RISCHIO:

Senza type affidabile:

dashboard economiche non fondate
spese/incassi non distinguibili
reportistica prematura fuorviante

AZIONE:

Da aprire in nodo dedicato futuro.

Nodo attualmente candidato come prossimo step operativo:

ENGINE BASE — TYPE CLASSIFICATION BASE

Vincoli:

nessuna automazione decisionale nascosta
utente sempre in controllo
parole chiave controllate
nessun KPI prima della validazione

ID: G10

NOME:
Match Engine Unification

FONTE:
Match Engine + Preview System + State

STATO:
VALIDATO

DESCRIZIONE:

Unificazione dei sistemi di matching attualmente paralleli:

input_raw / ranking
select / deterministico
preview / detection

NOTE:

Attualmente:

matching base funzionante
auto-select solo se match unico
hint non completamente state-driven
preview può divergere dai select
priority match assente

RISCHIO:

Senza unificazione:

hint incoerenti
selezioni ambigue
preview non affidabile
output basato su project/entity fragile

AZIONE:

Nodo futuro dedicato:

MATCH ENGINE UNIFICATION

Non aprire durante Preview Alignment Base.

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

RISCHIO:

Senza struttura:

matching ambiguo
entity duplicate
project/entity difficili da governare
report futuri deboli

AZIONE:

Non prioritario immediato.
Da valutare prima di engine avanzato o output.

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

Non prioritario rispetto a Type Classification Base.

Possibile micro-nodo futuro:

EVENTS LIST LABEL / UPDATED_AT DISPLAY FIX

Scope:

- distinguere “creato oggi” da “modificato oggi”
- confrontare created_at / updated_at
- evitare falsa indicazione di modifica su primo inserimento
- nessuna modifica engine
- nessuna modifica parsing
- nessuna modifica DB salvo decisione dedicata

ORDINE CONSIGLIATO GAP / NODI

Ordine attuale consigliato:

G09 — Type Classification Base
G10 — Match Engine Unification
G12 — Events List Label / Updated At Display
G11 — Data Structure / Entity Hierarchy
G08A — Duration Advanced / Giorni-Settimane
G04 — Logging / Versioning
G05 — Input Modes
G06 — Multi-source Input

Gap già integrati:

G07 — Preview Alignment
G08 — Duration Normalization Base

Nota:

l’ordine deve sempre essere verificato contro:

00_PROJECT_State
00_PROJECT_Roadmap
checkpoint più recente
GAP ARCHIVIATI / NON PRIORITARI

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