PROJECT — Runtime System
Versione: v1.4



Data: 2026-10-17



Scopo del documento



Questo documento definisce il runtime conversazionale

dei progetti basati sul sistema AIOS.



Il runtime governa il comportamento delle chat operative

e la relazione tra conversazione e sistema documentale.





Relazione con AIOS



Il progetto opera all'interno del metasistema AIOS.



AIOS fornisce il metodo e coordina i progetti.



Relazione architetturale:



AIOS

↓

PROJECT

↓

REGIA

↓

MACROAREE OPERATIVE

↓

SESSIONI





Command Layer



Il runtime utilizza trigger conversazionali

per controllare le sessioni operative.



Trigger principali:



\#start

avvio Boot Sequence progetto



\#session

apertura nuova sessione operativa



\#state

snapshot stato progetto



\#switch

trasferimento sessione tra chat



\#log

generazione Incident Report



\#help

richiamo guida operativa



\#quick

modalità operativa veloce



\#deep

modalità analisi approfondita



I trigger non sostituiscono il linguaggio naturale

ma permettono di attivare rapidamente

le funzioni del sistema.





Boot Sequence



La Boot Sequence viene attivata tramite:



\#start



Sequenza di avvio:



1 identificazione contesto sessione

2 identificazione progetto attivo

3 recupero stato progetto

4 verifica documenti fondamentali

5 individuazione nodo operativo

6 avvio sessione operativa



Documenti fondamentali verificati:



00\_PROJECT\_Regia

00\_PROJECT\_State

00\_PROJECT\_System\_Map



Se i documenti non sono disponibili

il sistema tenta prima il recupero dalle fonti accessibili secondo il Kernel;

solo se mancano ancora richiede il materiale necessario.





State Guard



Il runtime verifica continuamente

la disponibilità dello stato del progetto.



Documento di riferimento:



00\_PROJECT\_State





Safe Mode



Safe Mode viene attivata quando:



• stato progetto non disponibile

• documenti mancanti

• contesto ambiguo



In Safe Mode il sistema sospende

decisioni strutturali

e richiede i documenti necessari.





Meta-Observation



Il runtime include un sistema di osservazione

della conversazione.



Il Meta-Observation monitora:



• coerenza del tema

• uso degli anchor

• saturazione della sessione

• decisioni implicite

• cambi di nodo operativo



Quando necessario può suggerire:



\#state

\#session

\#switch

\#log

oppure l’uso di anchor strutturali.





Procedura documentale LOGOS — P5 (storico)

Questa procedura collega la conversazione ai documenti locali di LOGOS,
riducendo copie manuali, confronti e controlli ripetitivi.
Le decisioni e la review del contenuto restano responsabilità dell'utente
e di Work; Codex esegue le operazioni locali descritte nel relativo handoff.

Fonti e ruoli

Il Kernel Manifest e UNIVERSAL_PROJECT_RUNTIME_INSTRUCTIONS.md governano
fonti, boot e scelta del documento madre. Questa integrazione riguarda
il trasferimento controllato del contenuto nel documento scelto.
CQD, Sistema Fonti e Session Management mantengono il proprio ambito.
Il nodo documentale non autorizza operazioni su Retool, Supabase o altri servizi.

Work legge la versione locale completa, prepara il contenuto, i range,
le metriche CQD e gli input con hash. Codex legge l'handoff ed esegue
i comandi esatti; non deve riprogettare il motore o completare contenuti mancanti.

Sequenza operativa

1. Preparare il delta sul file completo, con provenienza delle fonti,
   preimage locale e baseline esplicita dello stato da preservare.
2. Eseguire Check: produce postimage prevista, diff, metriche e contesto
   delle evidenze, senza applicare il delta al documento nella repository.
3. Revisionare in Work il contenuto completo, il diff e le evidenze del Check.
4. Approvare separatamente il contenuto e il comando Apply concreto,
   vincolati agli hash e allo stato revisionati. Check da solo non autorizza Apply.
5. Eseguire Apply attraverso il wrapper approvato, poi controllarne
   le evidenze ed eseguire Verify in un processo indipendente.
6. Revisionare l'esito finale e l'eventuale baseline successiva candidata;
   recepirla richiede una decisione esplicita. Commit e push restano manuali,
   dopo Verify e review; un nuovo HEAD richiede un nuovo snapshot coerente.

I passaggi consecutivi possono essere accorpati in un handoff quando i controlli
intermedi sono deterministici e l'autorizzazione copre esplicitamente la sequenza.
La review del contenuto precede sempre Apply.

Preservazione e limiti

Conservare modifiche locali preesistenti, file non tracciati, indice Git,
BOM, terminatori di riga e byte esterni ai range approvati.
La baseline fotografa lo stato ammesso; non pulisce la repository.
Alla prima divergenza o a un esito ignoto fermarsi e conservare gli artefatti,
senza retry, ripristino o cleanup automatici.

La prima corsia storica P5 ammetteva solo il file tracciato esistente
98_SISTEMA_TECNICO/98_PROJECT_RUNTIME.md, con modify_ranges e un file
per transazione. Altri documenti e altri repository richiedono un profilo
e un perimetro revisionati, riusando i componenti già qualificati quando compatibili.

Il setup verificato attesta i componenti installati nel proprio perimetro;
non attesta da solo i permessi effettivi della GUI, il primo ciclo documentale
reale, una baseline adottata o la disponibilità per la produzione.
I permessi della sessione vanno verificati prima dei comandi.

## Ingresso stabile della procedura documentale

Questo Runtime è il documento madre della procedura documentale LOGOS.
AGENTS.md, le istruzioni del progetto e AIOS_REFERENCE.md lo richiamano.
La procedura recepisce il metodo AIOS_CORE con binding e fonti LOGOS;
non trasferisce implicitamente permessi, target o ricevute di un'altra root.

### Attivazione in Work

Richiesta ordinaria:

```text
Avvia la procedura documentale LOGOS.
```

La richiesta attiva preparazione e Check, non autorizza Apply. Se LOGOS è
già il progetto della sessione basta «Avvia la procedura documentale».
È una convenzione conversazionale documentata, non una slash command,
un trigger installato o un servizio automatico in background.

In una nuova chat acquisire il commit della repository e leggere questo
Runtime, le istruzioni canoniche, Kernel e checkpoint pertinente secondo
il boot LOGOS. Se il Runtime manca, chiedere questo file per nome oppure
recuperarlo allo SHA scelto; non richiedere all'utente di ricostruire ruoli,
archivi o comandi dalla memoria della conversazione. Le nuove pubblicazioni
non entrano silenziosamente nello snapshot di una sessione già aperta.

Richiesta esplicita di documento e ZIP:

```text
Avvia la procedura documentale LOGOS usando
98_SISTEMA_TECNICO/98_PROJECT_RUNTIME.md.
Integra le decisioni e gli esiti verificati di questa sessione nei documenti
canonici interessati. Prepara in Work le postimage complete, i diff e il
pacchetto Check con HANDOFF_GUI.txt. Riusa il motore e le prove pertinenti.
Segnala soltanto gli input locali completi e i binding realmente mancanti.
```

Il riferimento canonico nella repository è:
https://github.com/moody58/LOGOS/blob/main/98_SISTEMA_TECNICO/98_PROJECT_RUNTIME.md
Main è soltanto il punto di scoperta: dopo il boot usare il commit risolto.
L'accesso ai percorsi locali va osservato nella sessione effettiva: quando
disponibile si acquisiscono i byte locali; altrimenti Codex esegue il task
di lettura predisposto. Non presumere accesso o indisponibilita.

### Ruoli permanenti e luogo delle elaborazioni

| Attività | Responsabile / ambiente |
| --- | --- |
| Analisi, sviluppo logico, decisioni, contenuti e review | Utente e ChatGPT Work |
| Codice candidato, adattamenti, script e controlli complessi | Work |
| Assemblaggio di pacchetti, manifest, ZIP e verifiche degli archivi | Work |
| Letture della working copy e acquisizioni locali necessarie | Codex in VSCode, tramite task predisposto |
| Check, Apply approvato, gate, Verify indipendente e raccolta locale | Esecutori predisposti e pinned sul PC, invocati da Codex |
| Review del delta e decisione di applicazione | Utente con Work |
| Staging selettivo, commit e push | Utente, manualmente in VSCode |

Questa divisione non va ripetuta in ogni messaggio. Non dipende dal modello
selezionato: un modello locale leggero deve ricevere istruzioni esecutive
complete, senza dover riprogettare controlli, indovinare campi JSON,
costruire archivi o scegliere alternative dopo uno STOP. Le preferenze di
modello e ragionamento possono cambiare senza cambiare i ruoli.

### Fonti e preimage

Kernel e UNIVERSAL_PROJECT_RUNTIME_INSTRUCTIONS.md governano boot, gerarchia
e scelta del documento canonico. La procedura tecnica trasferisce il delta
nel documento scelto, senza sostituire CQD, STP, Sistema Fonti o Session
Management. tools/compare/old.md e new.md non sono fonti canoniche.

Per una modifica usare il contenuto completo della working copy locale,
anche dirty, con hash dei byte reali, BOM, EOL e newline finale. GitHub e
HEAD servono per provenienza, confronto e snapshot; non sostituiscono una
preimage locale non committata. Riutilizzare copie e letture complete solo
con hash ancora corrispondenti. Acquisire soltanto i contenuti necessari.
Un nuovo delta locale va integrato nella proposta, non cancellato per far
coincidere vecchi pin. Versioni nel contenuto e pathname canonici stabili.

La verifica di completezza riguarda l'intero documento: nessuna sintesi
sostitutiva, omissione di sezioni o ricostruzione da estratti. Gli anchor
conversazionali restano in metadati e discussione, secondo l'Anchor System;
non inserirli come nuovi marcatori nei documenti canonici.

### Due passaggi utente ordinari

1. Preparazione/Check: Work prepara il delta e gli input; Codex esegue il
   task pronto e restituisce le evidenze. Work revisiona postimage completa,
   diff, metriche, stato e provenienza. Check non scrive documenti.
2. Dopo approvazione sul delta e sul comando esatti: un handoff accorpa
   Prepare esterno, Apply singola, gate, Verify in processo indipendente e
   raccolta, con controlli intermedi deterministici. Work revisiona il
   risultato; commit/push rimangono manuali.

Le fasi interne non richiedono una nuova chat o un nuovo ZIP per ogni
controllo. Più documenti possono avere proposte coordinate e transazioni
singole sequenziali, legate allo stato dopo i delta precedenti. Non si
presume atomicità multi-documento. Una proposta senza aggiornamenti utili
ha esito «nessun pacchetto necessario», senza un ciclo artificiale.

### Contratto degli archivi

| Tipo | Contenuto / scopo |
| --- | --- |
| Candidato di review | Contenuti completi, preimage, diff, fonti e review; nessuna capacità esecutiva implicita |
| Pacchetto Check | Handoff dichiarativo, policy/profilo, baseline d'azione, binding, pre/postimage, task e comando Check pronti |
| Pacchetto Apply/Verify | Input Check già revisionati, richiesta, decisione immutabile, piano di comando e task/ordine approvati |
| Pacchetto provisioning | Elenco distinto e preciso di CREATE/REPLACE/KEEP, preimage, piano, guardie, journal e Verify |
| Evidenze | Originali locali necessari, log, receipt, journal, diff e relativo inventario; non un installer |
| Ripartenza | Release, sorgenti, istruzioni, profili, prove pertinenti e mappa delle dipendenze esterne |

Convenzione ordinaria: ZIP senza cartella esterna omonima; estrarre in
`C:\AIOS_MIGRAZIONE\<nome-pacchetto>`. HANDOFF_GUI.txt deve essere al primo
livello. Una struttura diversa richiede una destinazione esplicita nel
relativo handoff. Evitare il secondo livello omonimo, percorsi ambigui e
mescolanza delle due convenzioni. La destinazione deve essere nuova, salvo
una ripresa specificamente predisposta e autorizzata sui parziali esistenti.

Ogni membro ha pathname relativo normalizzato, dimensione in byte e
SHA-256. Il manifest dichiara l'elenco e le esclusioni necessarie a evitare
hash circolari. Usare il nome di proprietà previsto dal formato concreto
(`files`, `members`, `excluded_files`); non inferire cardinalità da una
proprietà simile e non interpretare i record come nomi di file semplici.
I file esclusi dal manifest non sono esclusi dalla fiducia: i pin del
task/runner e i pin esterni del pacchetto ne completano il binding.

Controlli di assemblaggio in Work: inventario esatto, unicità anche su
Windows, nomi/percorso sicuri, dimensioni, SHA-256, dipendenze del task,
comandi da file, assenza di placeholder nei comandi eseguibili, JSON
canonico senza duplicati, integrità ZIP/CRC e round-trip dei membri.
Le esclusioni sono dichiarate, non una tolleranza per file extra.

Il pin ZIP e il pin manifest vengono consegnati esternamente da Work.
Non pretendere che un ZIP contenga il proprio digest o che il manifest
autocertifichi il proprio pin. Gli eventuali template con placeholder sono
materiali di preparazione: Work deve compilare i comandi prima della
consegna esecutiva. Nessun contenuto documentale contiene callback o comandi
da eseguire. I pacchetti non contengono TOML globale, credenziali o segreti.

Un documento successivo riusa il motore installato e verificato. Non
reinstallare il runtime o ripetere qualificazioni immutate per ogni delta.
Un pacchetto di lavoro e un archivio storico non sono release equivalenti.
La creazione di un ZIP di review non autorizza installazione o Apply.

### Messaggio rapido per Codex

Work compila il messaggio seguente con percorso e digest reali. L'utente
incolla il messaggio senza ripetere le istruzioni contenute nei file:

```text
Leggi integralmente C:\AIOS_MIGRAZIONE\<nome-pacchetto>\HANDOFF_GUI.txt
e svolgi soltanto la sequenza autorizzata lì descritta.
ZIP SHA-256: <digest consegnato da Work>
Manifest SHA-256: <digest consegnato da Work>
Handoff SHA-256: <digest consegnato da Work>
Riporta l'esito originale e fermati per la review in Work.
```

Questa è una forma da compilare, non un comando pronto con pathname o pin
mancanti. Il messaggio contiene una destinazione reale e i valori attesi;
l'handoff contiene root, fase, inventari, binding, comandi e condizioni
di STOP. Luna non deve ricostruire il preflight dalla prosa: esegue i
controlli deterministici già codificati e pinned da Work.
Il pin esterno dell'handoff protegge anche i comandi e i pin dei controlli
esclusi dal manifest per evitare riferimenti circolari. Il preflight GUI
si limita alle letture/hash esplicite dei file di ingresso; l'inventario
complesso e il confronto tecnico sono nel task nativo già predisposto.

### Permessi, processo e attese

Per gli script del motore: Windows PowerShell 5.1 Desktop, FullLanguage,
RemoteSigned nel processo operativo. Il flag RemoteSigned del comando
approvato riguarda quel processo; non cambiare le policy persistenti.
La shell della GUI può differire. In ConstrainedLanguage usare le letture
supportate; non improvvisare metodi .NET o avviare Python come prerequisito
non dichiarato. Il profilo LOGOS è logos_readonly; verificare la modalità
dichiarata della sessione. Il TOML non attesta enforcement effettivo.

Le approvazioni native sono puntuali e riferite al comando predisposto;
nessun prefix rule permanente, cambio di LanguageMode o aggiramento di un
rifiuto. Il gate Git nativo conserva l'ambiente e rifiuta GIT_* diversi da
GIT_PAGER e CODEX_HOME non vuoto. I binding GUI safe.directory storicamente
osservati non sono un'autorizzazione a modificare l'ambiente o la config.

Nelle letture preliminari un output troncato si completa leggendo i blocchi
mancanti; un pathname materiale erroneo può essere rettificato in sola
lettura prima dell'invio operativo, quando autorizzato dall'handoff.
Non alterare pacchetto, pin o comandi per proseguire. Dal primo invio di un
task operativo vale STOP su errore o divergenza, preservando parziali e log,
senza retry, correzione automatica, cleanup o rollback implicito.

Se un processo resta attivo, attendere lo stesso session_id/handle e
comunicarne lo stato. Non rilanciare. Output non recuperabile e assenza di
exit code significano UNKNOWN; file conformi non certificano il completamento
del processo originale. Una lettura successiva può qualificare lo stato
corrente per una nuova azione, conservando UNKNOWN nella cronologia.

### Evidenze, CQD e continuità

La raccolta ordinaria restituisce originali, percorsi, dimensioni e pin già
calcolati dal task. Quando gli originali bastano, caricarli direttamente in
Work. Se serve un archivio delle prove, assemblarlo in Work secondo il
manifest; non farlo costruire estemporaneamente da Luna. Non aggiungere
diagnostiche/hash dopo un PASS soltanto per formattare il riepilogo.

Work controlla contenuto completo e semantica, pre/postimage, diff reale,
byte esterni ai range, versioni, rimandi e metriche. Il metodo nativo è
AIOS-TEXT-METRICS/1.0: parole, caratteri UTF-16, paragrafi, heading ATX,
byte e SHA-256. Misure previste e reali devono coincidere. Non confondere
le verifiche Markdown con l'esportazione DOCX richiesta dalla relativa
pipeline CQD: quando richiesta, l'esportazione segue un proprio task e
le sue verifiche. Il ciclo P5 non qualifica quei formati.

HEAD e indice restano invarianti durante la transazione. Dopo commit si
acquisiscono nuovi HEAD, indice, fonti, status e byte locali per la nuova
azione. Una baseline candidata conserva uno stato precedente; la review
non la adotta automaticamente. Request e claim consumati non si riusano.
Se Verify o Collect falliscono dopo Apply, non eseguire una seconda Apply:
ricostruire lo stato dalle evidenze e predisporre la ripresa necessaria.

### Perimetro operativo P6 e stato verificato

Il 2026-10-14 il runtime P6 e' stato installato e verificato nella working
copy LOGOS. Cinque sostituzioni con backup, otto KEEP e Verify indipendente
hanno preservato HEAD, indice, documenti e configurazione globale. Il report
reale revisionato ha SHA-256
81993b5ce57fb2878a3b7cdce3c9ff35b674e4ad0c060934f667099abe0e656c.
Il setup non autorizza da solo un delta: ogni Apply conserva il proprio gate.

Le qualifiche del motore e della guardia si riusano finche' i componenti
restano identici. Non si ripetono per ogni documento o cartella. Gli ID e le
versioni ammessi possono ruotare solo nei formati e nelle relazioni gia'
qualificati; cambi di struttura, permessi o binding fissi richiedono review.

Pathname esatti ammessi dal motore installato:

- `00_FONDAMENTA_PROGETTO/00_PROJECT_Gap_Register.md`
- `00_FONDAMENTA_PROGETTO/00_PROJECT_KERNEL_MANIFEST.md`
- `00_FONDAMENTA_PROGETTO/00_PROJECT_Regia.md`
- `00_FONDAMENTA_PROGETTO/00_PROJECT_Roadmap.md`
- `00_FONDAMENTA_PROGETTO/00_PROJECT_State.md`
- `00_FONDAMENTA_PROGETTO/00_PROJECT_System.md`
- `00_FONDAMENTA_PROGETTO/CHECKPOINT_FONTI_CANONICHE_BOOT_CONTROLLATO.md`
- `01_RUNTIME_LOGOS/01_LOGOS_Input_System.md`
- `01_RUNTIME_LOGOS/02_LOGOS_Match_Engine.md`
- `01_RUNTIME_LOGOS/03_LOGOS_Event_Lifecycle.md`
- `01_RUNTIME_LOGOS/04_LOGOS_Retool_Architecture.md`
- `01_RUNTIME_LOGOS/05_LOGOS_Database_Schema.md`
- `01_RUNTIME_LOGOS/06_LOGOS_View_Preview_System.md`
- `01_RUNTIME_LOGOS/LOGOS_RETOOL_RUNTIME_REAL.md`
- `01_RUNTIME_LOGOS/LOGOS_SUPABASE_RUNTIME_REAL.md`
- `98_SISTEMA_TECNICO/98_PROJECT_Anchor_System.md`
- `98_SISTEMA_TECNICO/98_PROJECT_CQD_Protocol.md`
- `98_SISTEMA_TECNICO/98_PROJECT_File_System_Guide.md`
- `98_SISTEMA_TECNICO/98_PROJECT_Incident_Management.md`
- `98_SISTEMA_TECNICO/98_PROJECT_PROTOCOL.md`
- `98_SISTEMA_TECNICO/98_PROJECT_RUNTIME.md`
- `98_SISTEMA_TECNICO/98_PROJECT_Radar.md`
- `98_SISTEMA_TECNICO/98_PROJECT_STP_Protocol.md`
- `98_SISTEMA_TECNICO/98_PROJECT_Session_Management_Protocol.md`
- `98_SISTEMA_TECNICO/98_PROJECT_Sistema_Fonti.md`
- `AIOS_REFERENCE.md`
- `PROJECT_CHANGELOG.md`
- `README.md`
- `RUNTIME_NOTE.md`
- `UNIVERSAL_PROJECT_RUNTIME_INSTRUCTIONS.md`

Per lavorare su questi documenti si usa il profilo specifico dell'azione;
non occorrono nuovi test per ognuno. Codice, AGENTS, configurazioni, nuovi
file o rinomine hanno il percorso pertinente e non sono modifiche documentali
implicitamente autorizzate. Le tre integrazioni di questo consolidamento
restano transazioni distinte: Runtime, istruzioni universali e AIOS_REFERENCE.
Ogni successiva azione lega fonti e baseline allo stato dopo la precedente.

### Capacità e dipendenze realmente disponibili

| Componente | Stato / riferimento |
| --- | --- |
| Motore e schema | Undici file installati in tools/codex, verificati nel setup LOGOS |
| Setup storico P5 | Receipt VERIFIED in C:\AIOS_MIGRAZIONE\LOGOS_R22_RELEASE_SETUP\ab98aacbb15647fa82537ab170e9fd23\setup_receipt.json |
| Pin setup storico P5 | eed49a18e67cca6185cde23cf8d151b506892b3d2b56948b0eb5bf0e77471b6a |
| Guardia configurazione | codex-operational-v4; pipe, ID CUA/CLI e coppia versione app/browser nei limiti strutturali qualificati; 26 binding restano exact-pin |
| Primo ciclo reale | Runtime P5: Check, Apply, Gate, Verify e review PASS; Prepare originale UNKNOWN conservato |
| Commit P5 riscontrato | 7451f13c4cfdf21bd770e9731d5b245e0afe4d5d, main; stato locale pulito al riscontro |
| Perimetro storico P5 | Solo 98_SISTEMA_TECNICO/98_PROJECT_RUNTIME.md, modify_ranges, un tracciato esistente |
| Setup attivo P6 | Receipt VERIFIED: C:\AIOS_MIGRAZIONE\LOGOS_R22_RELEASE_SETUP\7b537ded2a6e4622857adb63343229bc\setup_receipt.json |
| Pin setup attivo P6 | a2c54ad5dd318d6bbb2af66982ac4c61a3f0b9a276679908b95304c5a5b39a19 |
| Perimetro installato P6 | 30 pathname canonici esistenti in 00, 01, 98 e root; modify_ranges, un documento per transazione |
| Creazioni, rinomine e più root | Non abilitate implicitamente; percorso separato al bisogno |
| Baseline / readiness globale | Nessuna baseline adottata; production_ready=false |

Le ricevute e i recovery esterni non vengono eliminati dal commit. Conservare
il setup attivo, approvazioni/claim, input e recovery della transazione
198b4fc29dcd473cb23bff7720ab5283, e gli archivi di qualifica pertinenti.
Il codice attuale dipende dal receipt di setup esterno: clonare soltanto la
repo non ricostruisce automaticamente l'attivazione su un nuovo PC.

Per ripartenza: questo Runtime completo, istruzioni/AGENTS della root,
checkpoint pertinente, codice/schema della release, sorgenti del
runner/task necessario, receipt VERIFIED e mappa dei percorsi esterni.
Le sorgenti dei task vanno conservate nel pacchetto/release di ripartenza;
un UUID consumato non è un comando da rieseguire. Se manca una dipendenza,
chiedere quel materiale, non rilanciare la vecchia installazione.

### Riferimenti AIOS_CORE verificabili — snapshot storico del 15 ottobre

Fonti lette integralmente allo SHA
23e9305f538554fa952d3dd2c65d46d7c38eb174 di moody58/AIOS_CORE:

- 05_WORKSPACE/05_AIOS_Codex_Procedura_Documentale_e_Piano_Operativo.md,
  v1.2: attivazione §6, pacchetti §7, flusso §5, snapshot §8,
  conservazione/ripartenza §13. SHA-256
  ec8dd5bcfa4212767fa34f58918a920c512607eb3e33a33e5e905271c6532723.
- 02_PROTOCOLS/02_AIOS_Codex_Safe_Document_Apply.md, v0.6:
  responsabilità, preimage, range, approvazioni, backup/journal, Verify e
  separazione del provisioning. SHA-256
  b2ffcd9a603f24eb77f1ad98ef6e7c245635b2d73b2d559cbd69c38bcee33c15.
- AGENTS.md: adattatore breve della root AIOS_CORE. SHA-256
  3e781f3986bbfeae7c833d53584e62da8b81eaeb3134e0eeb097a4021f6587f1.

Manuale:
https://github.com/moody58/AIOS_CORE/blob/23e9305f538554fa952d3dd2c65d46d7c38eb174/05_WORKSPACE/05_AIOS_Codex_Procedura_Documentale_e_Piano_Operativo.md
Contratto:
https://github.com/moody58/AIOS_CORE/blob/23e9305f538554fa952d3dd2c65d46d7c38eb174/02_PROTOCOLS/02_AIOS_Codex_Safe_Document_Apply.md

Le sezioni di stato del manuale AIOS conservano snapshot storici; i loro
gate aperti non riaprono P4 già concluso dalle prove successive. Il comando
conversazionale e il formato archivio erano già documentati in AIOS.
L'albero della repo AIOS letto a quello SHA non contiene un generatore
universale installabile né DOC-HANDOFF_FORMAT.md, pur richiamato dal
contratto: non presentare quei riferimenti come file recuperati. In LOGOS
il formato esecutivo è definito dallo schema effettivamente presente e
dalle implementazioni pinned. La preparazione dei pacchetti rimane di Work.

### Ripartenza senza ripetere la divisione dei ruoli

```text
Riprendi LOGOS dal checkpoint pertinente e dal Runtime canonico completo.
Nodo: procedura documentale. Acquisisci soltanto stato e input mancanti;
riusa fonti e prove immutate. Applica la divisione Work/Codex documentata
nel Runtime. Riporta stato, capacità effettive, prossimo passo e residuo.
```

La tab ChatGPT contiene il blocco BOOTSTRAP TAB CHATGPT delle istruzioni
canoniche; non si sincronizza da sola. Se quel blocco cambia, il suo
recepimento nella tab resta un passo esplicito. Il riferimento stabile
al Runtime evita di duplicare qui o nelle chat l'intero manuale.


## Release comune 0.6-R01 — stato del 17 ottobre 2026

### Ingresso, regole LOGOS e percorsi disponibili

L'ingresso resta la chiusura del nodo di lavoro: decisioni ed esiti verificati
individuano i documenti canonici da rettificare. Le preimage complete della
working copy, anche dirty, sono la base. Si preparano proposte coordinate,
diff completi e metriche; seguono Check, review e consenso specifico,
Apply nel percorso qualificato, Verify indipendente e review visiva in VS Code.
Commit e push restano manuali. Questo Runtime rimane il documento madre LOGOS.

Il motore comune separa codice condiviso e regole per repository. LOGOS usa
root C:\AIOS_GITHUB\LOGOS, origin moody58/LOGOS, branch main e preset
logos_readonly. Naming, struttura, fonti e archiviazione restano quelli LOGOS;
non si importano automaticamente le personalizzazioni AIOS o di altri progetti.
I filename canonici restano stabili. La versione corrente e sempre in seconda
riga, dopo il titolo; lo storico compatto completo rimane alla fine.
La migrazione riguarda progressivamente i soli documenti aggiornati.

Il P6 precedente conserva trenta target, modify_ranges e un documento per
transazione. La corsia comune assistita aggiunge il profilo LOGOS per trentadue
Markdown tracciati esistenti, inclusi i due documenti Brand Identity esclusi
dal P6. L'ammissibilita dipende dal profilo e dall'azione vincolati alla release;
non estende il codice P6 e non equivale a una Apply gia eseguita su ogni target.

Il motore comune gestisce proposte coordinate per piu documenti: ogni file
conserva preimage, backup, postimage ed esito. Nessuna atomicita globale del
batch e nessun passaggio automatico a un altro esecutore dopo un blocco.
Nuovi documenti, nuove root, rinomine e operazioni mancanti richiedono un task
assistito specifico e revisionato. Dichiarare una root non esistente non la crea.
Il percorso alternativo conserva gli stessi vincoli di contenuto e consenso.

### Installazione effettiva e dipendenza esterna

Dopo la chiusura AIOS sul commit ea8afe897505a4166b3144e54bb608e266160b8a,
osservato anche su GitHub main, il 17 ottobre e stato eseguito una sola volta
il piano LOGOS approvato, sul main 3b908fb7ea521cf3f4bf6992c6ea451e3d7232f7.
Exit code 0, Verify indipendente VERIFIED_CREATE_ONLY_PROJECT_LINK e controllo
nativo PROJECT_LINK_BYTES_VERIFIED; pin stabili dopo l'esecuzione.
Sono stati creati soltanto:

- tools/codex/Invoke-DocumentWorkflow.ps1
- tools/codex/document-workflow/project.json
- tools/codex/document-workflow/profile.json
- tools/codex/document-workflow/admission.json
- tools/codex/document-workflow/README.md

Il Verify registra cinque file nuovi, byte preesistenti e indice preservati.
Runtime P6, AGENTS, configurazioni e file AIOS sono stati conservati.
Il catalogo condiviso e stato KEEP: nessuna reinstallazione del motore comune.
Le qualificazioni gia PASS, 24 casi del motore e 8 dell'installatore, sono
state riutilizzate con pin corrispondenti, senza ripeterle per LOGOS.
La presente proposta v1.4 non attesta la propria Apply o il proprio Verify.

Il codice e le prove comuni devono restare nel percorso qualificato
C:\AIOS_MIGRAZIONE\DWF06_Q01. Il catalogo e
C:\AIOS_MIGRAZIONE\DWF06_Q01\RELEASE_COMMON_0_6_R01.json,
SHA-256 635c299f86cddaf7e3e5dcbccc6000c7a402066b151ac841e0d1f938905427d2.
Il clone della sola repository non ricrea questa dipendenza esterna.
Il pacchetto di release ne conserva sorgenti, pin, prove e mappa dei percorsi;
un nuovo PC o percorso richiede bootstrap e binding propri, senza riutilizzare
automaticamente qualificazioni riferite a un'altra collocazione.

Per un progetto successivo si riutilizzano il codice invariato e le prove
pertinenti, predisponendo identita, regole, permessi e binding locali, quindi
controlli e primo uso nel relativo scope. Adexima non e stata configurata o
qualificata. La semplice dichiarazione della root non sostituisce questi passi.

### Processo effettivo, approvazioni e raccolta

Distinguere shell GUI, processo operativo e sessione Work da Codex VS Code.
I nomi dei preset e i TOML non attestano enforcement o origine umana.
Osservare il contesto effettivo: on-request, reviewer user e read-only nel
percorso VS Code previsto; UNKNOWN resta UNKNOWN. Info legge i collegamenti
e non aggiorna documenti. Restano baseline_adopted=false e production_ready=false.

Per i task nativi gia predisposti usare exec_command tramite functions.exec,
con Windows PowerShell 5.1 Desktop FullLanguage RemoteSigned osservati nel
processo operativo. Quando il task richiede il contesto operativo esterno,
require_escalated deve essere esplicito e puntuale: il solo avvio di 5.1 puo
restare nel processo ristretto. Nessun prefisso permanente o modifica di policy,
LanguageMode o profili. Un rifiuto non si aggira cambiando esecutore.
Le letture di file e metadati non richiedono controlli GUI o kernel JavaScript.

Conservare il percorso completo restituito dal launcher e leggere le ricevute
esistenti nel contesto di accesso necessario. Un pathname troncato non dimostra
che le prove siano assenti. Se Collect fallisce dopo Apply, non ripetere Apply:
preservare lo stato e predisporre una ripresa distinta della sola raccolta.
Su qualsiasi errore o esito ignoto: STOP, niente retry, cleanup o rollback
automatici. Request, claim, backup e fallimenti storici restano conservati.

### Prove e riferimenti correnti

Base delle prove Work:
C:\Users\moody\.codex\.chatgpt-projects\g-p-69a8b7113e2c8191be15ccfb6234d471\artifacts\common_release_0_6_R01_20261017.
Sottocartella LOGOS: prepared_LOGOS_after_AIOS_ea8afe_20261017.

- Piano consumato: PLAN.json, SHA-256
  a75cbb071f90df83967a0dec86783da7d2bcec7f941cde7e3c78c126baa65d29.
- Ricevuta nativa: native_install_c68fcde5dc6b45baab0018a1e91b4c66/launch_receipt.json.
- Verify indipendente: installation_24d89bf888eb4c34b7f34599fe85b145/receipt.json.
- Qualifica motore: C:\AIOS_MIGRAZIONE\DWF06_Q01\document_activation_v0_5_20261016\TEST_REPORT_4a47b76736ff4690aac04be8c3044023.json,
  SHA-256 b85ee350ebe9955fec817a8bd59beb5e3a96ce13e372b6c4004948b4d3410fd4.
- Qualifica installatore: PROVISION_TEST_REPORT_552b79e069c948a5b7ac8325d4496686.json,
  SHA-256 f3e8f265ec2685f2e311d78c304781b344fdff6ff48bd56d589fc1901e49126a.
- Archivio comune: AIOS_LOGOS_COMMON_RELEASE_0_6_R01_20261017.zip,
  SHA-256 bd4a5d9b8a03f2653eb752713d278e7e9bf884874de2d6369b62055f2af17c70.
  La mappa distingue sorgenti incluse e percorsi esterni; non e un backup del PC.

Il manuale AIOS corrente acquisito integralmente e la v1.4 al commit
ea8afe897505a4166b3144e54bb608e266160b8a, SHA-256
db9bdbcea0e699e22c56b4d30bf2af3614b1706332e4672d5eaf866df89eaeec,
percorso 05_WORKSPACE/05_AIOS_Codex_Procedura_Documentale_e_Piano_Operativo.md.
I riferimenti precedenti alla v1.2 restano snapshot storici, non il binding
di una nuova azione. Per ripartire leggere Runtime LOGOS e checkpoint corrente,
riusando soltanto fonti e prove ancora corrispondenti. Non riaprire backlog
applicativi o modificare Regia, State e Roadmap per questa chiusura documentale.

Principio operativo



Il runtime non interrompe la conversazione.



Suggerisce azioni quando rileva eventi

rilevanti per la stabilità del sistema.



Il suo obiettivo è mantenere:



• coerenza metodologica

• stabilità operativa

• continuità tra conversazione e documentazione.




## Storico revisioni

Versione corrente, poi revisioni precedenti in ordine cronologico.

v1.4 — 2026-10-17: release comune 0.6-R01 installata in LOGOS con Verify
indipendente e catalogo KEEP; flusso coordinato, regole locali, dipendenze
e limiti espliciti. Versione in seconda riga; tutte le voci precedenti
riunite alla fine senza modificarne il testo. Proposta subordinata al
proprio Check, consenso e Apply/Verify.

v1.0 — 2026-10-13: prima versione dichiarata di questo documento;
contenuto precedente senza versione esplicita preservato. Integrata la procedura
documentale LOGOS P5 e la divisione dei compiti tra Work e Codex.

v1.1 — 2026-10-13: consolidamento proposto dell’ingresso documentale LOGOS;
attivazione, ruoli permanenti, formato archivi, messaggi rapidi, fonti AIOS
e dipendenze di ripartenza. Estensione del motore separata e subordinata
alla propria qualifica e installazione verificata.

v1.2 — 2026-10-14: consolidamento operativo sul setup P6 installato e
verificato, ricevuta effettiva, guardia v4 e trenta target esatti. Conservati
P5 e la storia della proposta v1.1; ruoli, archivi e messaggi rapidi restano
documentati qui. Nessuna adozione automatica di baseline o readiness globale.

v1.3 — 2026-10-15: acquisizione da fonti accessibili prima dell'upload,
contratto del bootstrap tab e rinvio al Kernel per fonti e sessioni.
Il limite del marker iniziale di modify_ranges resta invariato: intestazioni
versionate sulla prima riga richiedono un percorso distinto o una qualifica dedicata.
Nessuna qualifica o installazione del motore e' eseguita da questa revisione.
