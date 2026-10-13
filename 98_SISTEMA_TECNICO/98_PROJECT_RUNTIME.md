PROJECT — Runtime System



Versione: v1.0
Data: 2026-10-13



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

il sistema deve richiederne il caricamento.





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





Procedura documentale LOGOS — P5

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

La prima corsia LOGOS ammette solo il file tracciato esistente
98_SISTEMA_TECNICO/98_PROJECT_RUNTIME.md, con modify_ranges e un file
per transazione. Altri documenti e altri repository richiedono un profilo
e un perimetro revisionati, riusando i componenti già qualificati quando compatibili.

Il setup verificato attesta i componenti installati nel proprio perimetro;
non attesta da solo i permessi effettivi della GUI, il primo ciclo documentale
reale, una baseline adottata o la disponibilità per la produzione.
I permessi della sessione vanno verificati prima dei comandi.

Storico revisioni

v1.0 — 2026-10-13: prima versione dichiarata di questo documento;
contenuto precedente senza versione esplicita preservato. Integrata la procedura
documentale LOGOS P5 e la divisione dei compiti tra Work e Codex.

Principio operativo



Il runtime non interrompe la conversazione.



Suggerisce azioni quando rileva eventi

rilevanti per la stabilità del sistema.



Il suo obiettivo è mantenere:



• coerenza metodologica

• stabilità operativa

• continuità tra conversazione e documentazione.



