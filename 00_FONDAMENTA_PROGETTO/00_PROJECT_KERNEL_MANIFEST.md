# 00_PROJECT_KERNEL_MANIFEST_v02

DATA: 2026-04-30

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Il Kernel Manifest dichiara l’architettura documentale del progetto
e la sua integrazione con il metasistema AIOS.

Il documento ha funzione dichiarativa.

Serve a permettere al sistema di comprendere:

- la struttura del progetto
- i componenti fondamentali del sistema
- la relazione con AIOS
- la gerarchia dei protocolli operativi
- il set minimo di documenti necessari per ricostruire il progetto

------------------------------------------------
ARCHITETTURA DEL METASISTEMA
------------------------------------------------

AIOS rappresenta il metasistema che governa il metodo
e coordina i progetti.

Il progetto rappresenta un’istanza operativa autonoma
del metasistema.

Relazione architetturale:

AIOS
↓
PROJECT
↓
MACROAREE OPERATIVE
↓
SESSIONI OPERATIVE
↓
DOCUMENTI

------------------------------------------------
IDENTITÀ PROGETTO
------------------------------------------------

Nome progetto:

LOGOS

Tipo:

Event Operating System

Stack reale:

- Retool
- Supabase

Principio:

LOGOS è un sistema reale, non teorico.

Il sistema viene sviluppato tramite:

- Regia
- State
- Roadmap
- micro-sessioni operative
- checkpoint
- aggiornamento documentale controllato

------------------------------------------------
KERNEL DOCUMENTALE DEL PROGETTO
------------------------------------------------

Il kernel del progetto è costituito dai documenti fondamentali
che permettono al sistema di ricostruire:

- identità
- stato
- direzione
- struttura
- vincoli
- gap aperti

Documenti kernel attivi:

- 00_PROJECT_Regia
- 00_PROJECT_State
- 00_PROJECT_Roadmap
- 00_PROJECT_System
- 00_PROJECT_Gap_Register
- 00_PROJECT_KERNEL_MANIFEST

------------------------------------------------
DOCUMENTI TECNICI ATTIVI
------------------------------------------------

I documenti tecnici descrivono il sistema reale e i suoi layer.

Documenti tecnici principali:

- 01_LOGOS_Input_System
- 02_LOGOS_Match_Engine
- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture
- 05_LOGOS_Database_Schema
- 06_LOGOS_View_Preview_System
- LOGOS_RETOOL_RUNTIME_REAL
- LOGOS_SUPABASE_RUNTIME_REAL

------------------------------------------------
RUNTIME CONVERSAZIONALE
------------------------------------------------

Il comportamento delle chat del progetto è governato
dal runtime conversazionale.

Documenti runtime:

- PROJECT_RUNTIME_INSTRUCTIONS
- 98_PROJECT_RUNTIME
- 98_PROJECT_Session_Management_Protocol

------------------------------------------------
METODO OPERATIVO
------------------------------------------------

Il metodo operativo del progetto è definito dai protocolli AIOS
e dal sistema di anchor.

Documenti metodo:

- 98_PROJECT_Anchor_System
- 98_PROJECT_CQD_Protocol
- 98_PROJECT_STP_Protocol
- 98_PROJECT_Sistema_Fonti
- 98_PROJECT_Incident_Management

------------------------------------------------
GERARCHIA OPERATIVA
------------------------------------------------

Gerarchia documentale:

AIOS_RUNTIME
↓
PROJECT_RUNTIME
↓
00_PROJECT_Regia
↓
00_PROJECT_Roadmap
↓
00_PROJECT_State
↓
00_PROJECT_System
↓
Documenti tecnici runtime
↓
Checkpoint operativi

------------------------------------------------
FUNZIONE DEL KERNEL MANIFEST
------------------------------------------------

Il Kernel Manifest permette al sistema di:

- identificare il progetto
- stabilire la gerarchia dei protocolli
- evitare conflitti tra sistema e progetto
- mantenere coerenza tra metasistema e istanza
- distinguere documenti attivi, tecnici, runtime e storici
- supportare il boot corretto delle nuove sessioni

Questo documento non sostituisce:

- Regia
- State
- Roadmap
- documenti tecnici
- checkpoint

Ne dichiara solo la posizione nel sistema documentale.

------------------------------------------------
REGOLE DI UTILIZZO
------------------------------------------------

Per avviare una nuova sessione operativa servono almeno:

- 00_PROJECT_State
- 00_PROJECT_Roadmap
- ultimo checkpoint rilevante

A seconda del nodo, possono servire anche:

- 00_PROJECT_System
- documento tecnico specifico
- runtime reale Retool/Supabase
- Gap Register

Il Kernel Manifest non è sufficiente da solo per operare.

------------------------------------------------
ARCHIVIO
------------------------------------------------

I checkpoint e gli snapshot storici non fanno parte del kernel attivo.

Devono essere conservati in archivio quando:

- documentano una sessione chiusa
- sono stati superati da documenti runtime aggiornati
- non sono più fonte primaria operativa

Esempi:

- checkpoint completati
- snapshot Supabase storici
- documenti sostituiti da versioni runtime aggiornate

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — data originaria

- definizione iniziale Kernel Manifest
- relazione AIOS / Project / Documenti
- dichiarazione documenti kernel e protocolli

v02 — 2026-04-30

- aggiornato riferimento da 00_PROJECT_System_Map a 00_PROJECT_System
- aggiunto 00_PROJECT_Roadmap tra i documenti kernel attivi
- aggiunto 00_PROJECT_Gap_Register tra i documenti kernel attivi
- aggiunti documenti tecnici LOGOS attivi
- aggiunto riferimento a 98_PROJECT_Session_Management_Protocol
- chiarita distinzione tra kernel, runtime, tecnici, checkpoint e archivio
- allineamento alla pulizia documentale post Normalization Layer Base