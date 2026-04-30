# 00_PROJECT_Gap_Register_v02

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
1ora lavoro → amount 1, unit ore
18min test → amount 18, unit minuti
villa 2 mario → amount null, unit null

NOTE:

La normalizzazione è attualmente integrata in:

parse_input_controlled
ui_state.parsed
button_input_confirm tramite payload derivato

Non esiste ancora un modulo engine separato.

RISCHIO RESIDUO:

Dati solo parzialmente confrontabili perché non sono ancora implementati:

duration normalization
multi-unit parsing
type classification
spesa/incasso
normalizzazione project/entity
retro-normalizzazione storico

AZIONE:

Mantenere il gap aperto come INTEGRATO PARZIALE.

Prossimi sotto-gap:

Duration Normalization
Type Classification Base
Match Engine Unification

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

È stato avviato il primo blocco engine:

Normalization Layer Base

Tuttavia non esiste ancora un Processor/Engine Flow completo.

Attualmente:

parsing e normalization base sono in Retool
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

Preview Alignment Base
Duration Normalization
Type Classification Base
Match Engine Unification

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

Preview Alignment Base
Duration Normalization
Type Classification Base

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
type classification e duration normalization assenti

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
VALIDATO

DESCRIZIONE:

Dopo l’introduzione della normalizzazione base, la preview può mostrare
valori tecnicamente corretti ma visualmente non ancora localizzati.

Esempio:

Dato interno:

amount: 1500.5
unit: euro

Possibile visualizzazione attuale:

1500.5 €

Visualizzazione desiderata:

1.500,50 €

NOTE:

La preview è ancora layer ibrido:

view
label cleaning
hint logic
highlight
formattazione locale

RISCHIO:

Divergenza percepita tra dato salvato corretto e sintesi visiva.

AZIONE:

Aprire nodo dedicato:

PREVIEW ALIGNMENT BASE

Scope ammesso:

formattazione italiana amount
visualizzazione unit coerente
allineamento visuale a ui_state.parsed
nessuna modifica DB
nessuna nuova semantica
nessun matching refactor

ID: G08

NOME:
Duration Normalization

FONTE:
Domande utente + Engine Base

STATO:
VALIDATO

DESCRIZIONE:

Gestione durate complesse e multi-unità.

Esempi:

1 ora e 15 minuti
2h30
2 ore 30
90 minuti
2 giorni rendering

NOTE:

Attualmente:

supporto ore/minuti base
supporto unità compatte semplici
nessuna conversione durata
nessuna unità canonica
nessuna gestione giorni

RISCHIO:

Senza duration normalization:

tempi non sempre confrontabili
report ore/minuti incompleti
KPI tempo non affidabili

AZIONE:

Aprire solo dopo Preview Alignment Base oppure in nodo dedicato.

Decisioni richieste:

unità canonica durata
ore vs minuti
gestione giorni
preservazione unit originale
visualizzazione finale

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

RISCHIO:

Senza type affidabile:

dashboard economiche non fondate
spese/incassi non distinguibili
reportistica prematura fuorviante

AZIONE:

Da aprire in nodo dedicato futuro.

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
ORDINE CONSIGLIATO GAP / NODI

Ordine attuale consigliato:

G07 — Preview Alignment
G08 — Duration Normalization
G09 — Type Classification Base
G10 — Match Engine Unification
G11 — Data Structure / Entity Hierarchy
G04 — Logging / Versioning
G05 — Input Modes
G06 — Multi-source Input

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