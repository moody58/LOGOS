# 00_PROJECT_KERNEL_MANIFEST_v03

DATA: 2026-05-25

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
PRINCIPIO FONTI CANONICHE
------------------------------------------------

A seguito del nodo:

DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION

la documentazione LOGOS adotta il principio di fonte canonica.

Regola:

una logica fondamentale deve essere completa in un solo documento madre.
Gli altri documenti devono richiamarla esplicitamente senza duplicarla in modo esteso.

Documenti di governance:

- 00_PROJECT_State
- 00_PROJECT_Roadmap
- 00_PROJECT_Gap_Register

Funzione:

- stato corrente
- direzione
- priorità
- gap
- debiti
- decisioni di governance

Non devono duplicare implementazioni tecniche lunghe.

Documenti tecnici canonici:

- 01_LOGOS_Input_System
- 02_LOGOS_Match_Engine
- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture
- 05_LOGOS_Database_Schema
- 06_LOGOS_View_Preview_System

Funzione:

- contenere il dettaglio completo delle logiche tecniche fondamentali
- preservare ricostruibilità
- evitare ricalcolo di decisioni consolidate
- mantenere esempi, vincoli e limiti necessari

Manifest runtime reali:

- LOGOS_RETOOL_RUNTIME_REAL
- LOGOS_SUPABASE_RUNTIME_REAL

Funzione:

- fotografare il runtime reale as-is
- documentare ciò che esiste davvero nel sistema
- non sostituire i documenti tecnici madre
- non diventare Roadmap, Gap Register o State

Regola futura:

quando cambia una logica fondamentale,
si aggiorna prima il documento canonico competente.

Gli altri documenti ricevono solo:

- richiamo esplicito
- nota di impatto
- aggiornamento di stato
- eventuale changelog sintetico

------------------------------------------------
REGOLE DI UTILIZZO / SESSION BOOT MATRIX
------------------------------------------------

Per avviare una nuova sessione operativa servono sempre:

Core Boot obbligatorio:

- 00_PROJECT_State
- 00_PROJECT_Roadmap
- ultimo checkpoint rilevante

Documenti da aggiungere in base al nodo:

Input / parser / command / input_analysis_result:

- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture se coinvolge componenti Retool
- LOGOS_RETOOL_RUNTIME_REAL se serve stato runtime reale

Preview / hint / warning / Sintesi:

- 06_LOGOS_View_Preview_System
- 01_LOGOS_Input_System se coinvolge input_analysis_result
- 04_LOGOS_Retool_Architecture se coinvolge Hidden/componenti
- LOGOS_RETOOL_RUNTIME_REAL se serve runtime reale

Matching project/entity:

- 02_LOGOS_Match_Engine
- 01_LOGOS_Input_System se coinvolge input flow
- 06_LOGOS_View_Preview_System se coinvolge hint/preview
- 04_LOGOS_Retool_Architecture se coinvolge select/componenti

Retool UI / componenti / graph / Hidden:

- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL
- 01_LOGOS_Input_System se coinvolge flow input

DB / Supabase:

- 05_LOGOS_Database_Schema
- LOGOS_SUPABASE_RUNTIME_REAL
- 03_LOGOS_Event_Lifecycle se coinvolge lifecycle evento

Lifecycle evento / edit / no-op / processing:

- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture se coinvolge query/componenti Retool
- 05_LOGOS_Database_Schema se coinvolge campi persistiti
- LOGOS_RETOOL_RUNTIME_REAL se serve runtime reale

Gap / roadmap / pianificazione:

- 00_PROJECT_State
- 00_PROJECT_Roadmap
- 00_PROJECT_Gap_Register

Runtime manifest / verifica sistema reale:

- LOGOS_RETOOL_RUNTIME_REAL per Retool
- LOGOS_SUPABASE_RUNTIME_REAL per Supabase
- documento tecnico canonico competente in base al layer analizzato

Regola:

Il Kernel Manifest non è sufficiente da solo per operare.
Serve solo a dichiarare architettura documentale, fonti, gerarchia e boot.

Il documento operativo vero va sempre scelto in base al nodo.

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

v03 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- aggiornato Kernel Manifest da v02 a v03
- aggiunto PRINCIPIO FONTI CANONICHE
- recepita distinzione tra:
  - documenti di governance
  - documenti tecnici canonici
  - manifest runtime reali
- chiarito che una logica fondamentale deve essere completa in un solo documento madre
- chiarito che State, Roadmap e Gap Register non devono duplicare implementazioni tecniche lunghe
- chiarito che LOGOS_RETOOL_RUNTIME_REAL e LOGOS_SUPABASE_RUNTIME_REAL fotografano il runtime reale as-is
- aggiunta Session Boot Matrix
- chiarito il Core Boot obbligatorio:
  - 00_PROJECT_State
  - 00_PROJECT_Roadmap
  - ultimo checkpoint rilevante
- aggiunti criteri di caricamento documenti per nodo:
  - input / parser / command / input_analysis_result
  - preview / hint / warning / Sintesi
  - matching project/entity
  - Retool UI / componenti / graph / Hidden
  - DB / Supabase
  - lifecycle evento / edit / no-op / processing
  - gap / roadmap / pianificazione
  - runtime manifest / verifica sistema reale
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica payload