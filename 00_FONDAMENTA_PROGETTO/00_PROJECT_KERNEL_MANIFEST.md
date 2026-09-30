# 00_PROJECT_KERNEL_MANIFEST_v04

DATA: 2026-09-30

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
FONTI CANONICHE / ACCESSO AI SERVIZI
------------------------------------------------

Il presente blocco è la fonte madre delle regole di acquisizione delle fonti LOGOS.
Le istruzioni del progetto lo richiamano; State registra soltanto l'esito del nodo.

Repository documentale canonico:
- repository: moody58/LOGOS
- URL: https://github.com/moody58/LOGOS
- branch di riferimento al boot: main, salvo scelta esplicita dell'utente
- prima acquisire il commit SHA della branch; poi leggere ogni file a quello SHA
- non mescolare file letti da main in momenti diversi né selezionare fonti solo per data/versione
- non includere tools/compare/old.md o tools/compare/new.md tra le fonti canoniche

Percorsi canonici nella repository:

| Fonte | Percorso |
|---|---|
| Istruzioni del progetto; nome file storico conservato | UNIVERSAL_PROJECT_RUNTIME_INSTRUCTIONS.md |
| Kernel Manifest | 00_FONDAMENTA_PROGETTO/00_PROJECT_KERNEL_MANIFEST.md |
| State | 00_FONDAMENTA_PROGETTO/00_PROJECT_State.md |
| Roadmap | 00_FONDAMENTA_PROGETTO/00_PROJECT_Roadmap.md |
| Gap Register | 00_FONDAMENTA_PROGETTO/00_PROJECT_Gap_Register.md |
| Regia | 00_FONDAMENTA_PROGETTO/00_PROJECT_Regia.md |
| System | 00_FONDAMENTA_PROGETTO/00_PROJECT_System.md |
| Input System | 01_RUNTIME_LOGOS/01_LOGOS_Input_System.md |
| Match Engine | 01_RUNTIME_LOGOS/02_LOGOS_Match_Engine.md |
| Event Lifecycle | 01_RUNTIME_LOGOS/03_LOGOS_Event_Lifecycle.md |
| Retool Architecture | 01_RUNTIME_LOGOS/04_LOGOS_Retool_Architecture.md |
| Database Schema | 01_RUNTIME_LOGOS/05_LOGOS_Database_Schema.md |
| View Preview System | 01_RUNTIME_LOGOS/06_LOGOS_View_Preview_System.md |
| Retool runtime documentato | 01_RUNTIME_LOGOS/LOGOS_RETOOL_RUNTIME_REAL.md |
| Supabase runtime documentato | 01_RUNTIME_LOGOS/LOGOS_SUPABASE_RUNTIME_REAL.md |
| Session Management Protocol | 98_SISTEMA_TECNICO/98_PROJECT_Session_Management_Protocol.md |
| Protocolli AIOS necessari al nodo | 98_SISTEMA_TECNICO/98_PROJECT_*.md; selezionare quelli pertinenti |

La presenza di un percorso nel manifest non dimostra la disponibilità del file: verificarla al boot.
Il file delle istruzioni nella repository deve coincidere con il testo recepito nella tab del progetto.
La tab dell'app non si sincronizza da sola: ogni sua modifica richiede recepimento esplicito.
La discordanza tra istruzioni applicate e copia canonica va segnalata prima dell'operatività.
Lettura tramite connettore preferita; recupero diretto dallo stesso repository/SHA ammesso
se disponibile. Dichiarare il mezzo di acquisizione effettivamente riuscito.

Fonte live Supabase autorizzata per LOGOS:
- nome atteso: logos_template
- project_ref: utvwefciuxtwoqvvcwel
- schema applicativo iniziale: public
- usare l'identificativo, non scegliere il progetto soltanto per somiglianza del nome
- la documentazione GitHub definisce decisioni e comportamento documentato;
  Supabase verifica soltanto gli oggetti e le proprietà realmente interrogati
- il risultato live non modifica automaticamente la specifica né autorizza una correzione

Retool:
- LOGOS_RETOOL_RUNTIME_REAL è una fotografia documentale, non una lettura live
- GitHub e Supabase non certificano query, handler, componenti o configurazioni Retool
- quando il nodo richiede il codice Retool attuale, acquisire soltanto l'export o il codice pertinente
  tramite una capacità autorizzata disponibile; in sua assenza chiedere il materiale minimo

Non memorizzare credenziali o chiavi nei documenti, nei checkpoint o nella ricevuta di boot.

------------------------------------------------
BOOT CONTROLLATO / PROVENIENZA / SNAPSHOT
------------------------------------------------

Attivazione:
- a ogni nuova sessione aperta con #start @@LOGOS eseguire il boot senza attendere
  un ulteriore invito dell'utente a leggere le fonti
- anche una nuova chat LOGOS senza trigger deve acquisire le fonti prima di risposte operative
- il boot automatico è una procedura del runtime conversazionale, non un servizio in background
- l'autorizzazione a leggere non equivale ad autorizzazione a scrivere

Sequenza:
1. Identificare il nodo richiesto e i suoi confini. Se lo State lascia il prossimo nodo da definire,
   restare in Regia: non attivare automaticamente un candidato storico.
2. Verificare la lettura di moody58/LOGOS e acquisire il commit di main (o della branch scelta).
3. Leggere istruzioni canoniche, Kernel Manifest e Session Management Protocol da quel commit.
4. Acquisire State, Roadmap e ultimo checkpoint rilevante; aggiungere soltanto i documenti
   richiesti dalla Session Boot Matrix. Per il Gap Register usare il criterio già previsto dalla matrice.
5. Verificare che i file selezionati siano completi, non sostituiti da soli risultati di ricerca,
   intestazioni o estratti. Registrare versione/data effettivamente lette; non usare una lista
   di versioni attese come prova della lettura. Un file troncato non soddisfa il Source Guard.
6. Verificare il collegamento al progetto Supabase indicato, tramite metadati se disponibili.
   Se la connessione è già limitata al progetto e non espone i metadati account, verificarne
   l'accesso con una lettura innocua dei metadati applicativi. Non effettuare export di righe al boot.
7. Per un nodo che dipende dal DB, leggere soltanto le proprietà degli oggetti coinvolti
   (es. colonne, vincoli, policy, trigger o funzioni richiesti dal nodo) e confrontarle con le fonti
   canoniche pertinenti. Il successo di list_tables non certifica schema completo o funzioni.
8. Dichiarare la ricevuta di boot, le discrepanze e le limitazioni; aprire #session solo quando
   nodo e fonti necessarie sono sufficienti. Il mancato accesso Supabase non blocca una sessione
   esclusivamente documentale, ma impedisce di dichiarare verificato il DB o di lavorare su di esso.

Ricevuta minima:
- progetto, nodo e confini
- stato boot: OK / LIMITATO / SAFE MODE e motivo
- repository, branch, commit SHA risolto e mezzo di acquisizione
- per ogni documento necessario: percorso, versione/data e lettura completa OK / MANCANTE
- checkpoint rilevante e sua provenienza
- Supabase: project_ref, esito accesso, data/ora con timezone, oggetti/proprietà realmente letti
- Retool: DOCUMENTATO / VERIFICATO LIVE, con ambito e provenienza della verifica
- conflitti, fallback e fonti non verificate
- VALIDAZIONE del nodo, scope e deviazione

Checkpoint:
- il Core Boot mantiene l'obbligo dell'ultimo checkpoint rilevante
- il checkpoint di chiusura di questo nodo è
  00_FONDAMENTA_PROGETTO/CHECKPOINT_FONTI_CANONICHE_BOOT_CONTROLLATO.md
- sceglierlo quando pertinente alla ripresa/configurazione fonti; non usarlo per sostituire
  dettagli tecnici di una precedente sessione che non contiene
- il checkpoint originale Readiness non viene ricreato in questo ciclo
- le sue decisioni assorbite sono nei documenti canonici; se al prossimo nodo serve contenuto
  non assorbito, richiedere l'originale. Non inventarne testo, data, percorso o provenienza

Ordine delle fonti e fallback:
- la scelta esplicita dell'utente sulle fonti governa la sessione e va registrata
- in assenza di una scelta diversa, acquisire la documentazione canonica da GitHub allo SHA del boot
- gli allegati dell'app sono copie: la loro presenza non dimostra identità con la repository
- un allegato fornito esplicitamente come correzione costituisce una fonte dichiarata dall'utente;
  segnalarne la divergenza e l'eventuale mancato recepimento su GitHub
- non sostituire silenziosamente un file remoto mancante con una vecchia copia o memoria di chat
- per una fonte necessaria assente/incoerente: SAFE MODE per l'operatività dipendente, richiesta
  mirata del solo materiale mancante e nessuna decisione strutturale basata su supposizioni
- non correggere automaticamente un'incoerenza documentale o runtime

Snapshot:
- lo SHA vincola le letture documentali successive della stessa sessione
- un commit pubblicato dopo il boot non entra nello snapshot attivo
- per recepire nuove versioni, aprire una nuova sessione con #start
- Supabase non viene congelato dal boot: annotare istante e ambito di ogni osservazione
- prima di una modifica runtime già autorizzata, ricontrollare gli oggetti interessati
  con letture prive di effetti collaterali; se divergono dalla baseline, sospendere la modifica
  e riallineare con un nuovo boot, senza incorporare tacitamente la deriva

Permessi e scritture:
- al boot usare soltanto operazioni di lettura; niente commit, push, migrazioni, DDL/DML,
  deploy, ripristini, pulizie dati o correzioni RLS
- preferire una connessione tecnicamente di sola lettura e limitata al progetto
- le istruzioni non possono impostare da sole OAuth, permessi GitHub o modalità MCP
- Supabase MCP supporta project_ref e read_only=true; verificarne la configurazione reale
  prima di dichiarare la connessione protetta. Non confondere lettura effettuata e sola lettura imposta
- ogni scrittura successiva richiede un task autorizzato nel nodo, delta concreto, verifica
  e limiti coerenti con i permessi effettivi. Il boot non concede tale autorizzazione
- per gli aggiornamenti documentali: modificare il file completo, preservare contenuti/storico,
  incrementare le versioni pertinenti, controllare il delta e consegnare/publicare solo dopo CQD
- in caso di scrittura GitHub rifiutata, dichiarare che il remoto non è aggiornato e consegnare
  i file verificati per il recepimento locale; non dichiarare sincronizzazione avvenuta.

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

v04 — 2026-09-30

- nodo FONTI CANONICHE / BOOT CONTROLLATO
- definiti repository/branch/SHA, percorsi canonici e identità del progetto Supabase
- aggiunta acquisizione automatica al boot, ricevuta con prove di lettura e fallback dichiarati
- preservati Core Boot, Session Boot Matrix, fonti madre e snapshot della sessione
- distinta documentazione runtime da verifica live e da sola lettura tecnicamente imposta
- preservato il requisito del checkpoint pertinente; nessuna ricostruzione dell'originale Readiness
- Session Management Protocol originale v1.0 incluso senza modifiche di contenuto
- nessuna autorizzazione permanente a scrivere e nessuna modifica al runtime LOGOS
- sezioni originali e changelog v01-v03 preservati
