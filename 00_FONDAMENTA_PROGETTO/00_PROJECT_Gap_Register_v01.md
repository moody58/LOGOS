# 00_PROJECT_Gap_Register_v01

DATA: 2026-04-01

------------------------------------------------
SCOPO
------------------------------------------------

Tracciare i gap strutturali emersi durante audit e analisi,
valutandone utilità reale nel sistema LOGOS.

Il documento evita:

- creazione prematura di documenti inutili
- perdita di elementi strategici
- dimenticanza di componenti critiche

------------------------------------------------
STATO GAP
------------------------------------------------

Ogni gap può essere:

- IDENTIFICATO
- IN OSSERVAZIONE
- VALIDATO
- INTEGRATO
- SCARTATO

------------------------------------------------
GAP REGISTER
------------------------------------------------

ID: G01
NOME: Normalization Model
FONTE: Gap Analysis + Roadmap
STATO: IN OSSERVAZIONE
DESCRIZIONE:

Necessità di un layer dedicato alla normalizzazione
dei dati (unità, valori, struttura).

NOTE:

Attualmente distribuito tra:
- parsing input
- futuro engine

RISCHIO:

Dati non confrontabili → KPI impossibili

AZIONE:

Validare utilità durante sviluppo input + processing

------------------------------------------------

ID: G02
NOME: Processor / Engine Flow
FONTE: Gap Analysis
STATO: IN OSSERVAZIONE
DESCRIZIONE:

Pipeline strutturata post-insert:
matching → deduplica → normalizzazione → scrittura

NOTE:

Attualmente NON implementata

AZIONE:

Valutare dopo input reliability

------------------------------------------------

ID: G03
NOME: Entity/Project Async Workflow
FONTE: Gap Analysis
STATO: IN OSSERVAZIONE
DESCRIZIONE:

Creazione entità/progetti asincrona con pending state

NOTE:

Attualmente:
- solo selezione manuale

AZIONE:

Validare dopo match engine

------------------------------------------------

ID: G04
NOME: Logging System
FONTE: Gap Analysis
STATO: IN OSSERVAZIONE
DESCRIZIONE:

Sistema log eventi, errori, warning

NOTE:

Assente completamente

AZIONE:

Valutare quando emergono errori reali

------------------------------------------------

ID: G05
NOME: Input Modes (Libero vs Guidato)
FONTE: Chat utente
STATO: IN OSSERVAZIONE
DESCRIZIONE:

Doppia modalità input:
- free text
- guided form

NOTE:

Richiesta utente reale

AZIONE:

Validare dopo stabilizzazione input base

------------------------------------------------

ID: G06
NOME: Multi-source Input
FONTE: Gap Analysis
STATO: IN OSSERVAZIONE
DESCRIZIONE:

Input da:
- API
- voice (Siri)
- import

NOTE:

Non strutturato

AZIONE:

Non prioritario ora

------------------------------------------------

PRINCIPIO OPERATIVO
------------------------------------------------

Un gap diventa documento SOLO se:

✔ necessario nello sviluppo reale
✔ validato su uso concreto
✔ non sostituibile da soluzione più semplice

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01

- Creazione Gap Register
- Consolidamento gap da audit + gap analysis
- Introduzione sistema di validazione progressiva