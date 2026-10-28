# LOGOS — Contratto Funzionale del Core Universale
Versione: v1.1

**Documento:** `00_PROJECT_Functional_Contract.md`
**Data:** 28 ottobre 2026
**Progetto:** LOGOS — Event Operating System
**Repository:** `moody58/LOGOS`
**Percorso:** `00_FONDAMENTA_PROGETTO/00_PROJECT_Functional_Contract.md`
**Stato:** v1.0 pubblicata su `main` al commit `afc0c26a92aaf2a1256c55605eb2f9b776e5da41`; presente v1.1: raccordo editoriale, subordinato a review, applicazione e pubblicazione proprie.

## 1. Scopo e responsabilità

Questo documento stabilisce la visione funzionale di LOGOS, le finalità del Core universale, le capacità richieste, i requisiti minimi dei dati e i criteri per valutarne il completamento.

È la fonte madre dei **requisiti funzionali stabili del prodotto**.

Non sostituisce:

- `00_PROJECT_System.md`: identità e architettura alta.
- `00_PROJECT_Core_Architectural_Baseline.md`: decisioni e invarianti architetturali approvate.
- `00_PROJECT_Roadmap.md`: sequenza, dipendenze e priorità operative.
- `00_PROJECT_State.md`: stato effettivo e avanzamento.
- `00_PROJECT_Gap_Register.md`: gap e debiti aperti.
- Documenti tecnici e Runtime Real: specifiche, implementazione ed evidenze del sistema.

Il presente contratto non attribuisce lo stato IMPLEMENTATO a una funzione soltanto perché descritta come requisito.

## 2. Visione del prodotto

LOGOS è un Event Operating System universale destinato a trasformare informazioni operative quotidiane in dati strutturati, correlabili, verificabili e utilizzabili per analisi.

L'utente deve poter registrare rapidamente ciò che accade senza conoscere preventivamente l'organizzazione interna del database.

LOGOS deve progressivamente riconoscere intenzione, natura e contesto dell'informazione, aiutando a completare i dati mancanti e mantenendo il controllo umano dove necessario.

La finalità non è soltanto memorizzare eventi. È consentire di conoscere, per un determinato progetto, soggetto o periodo:

- che cosa è accaduto;
- quali attività sono state svolte;
- quali importi e tempi sono coinvolti;
- quali informazioni sono collegate;
- quali obbligazioni, scadenze o attività restano aperte;
- quali risultati economici e operativi sono ricavabili.

LOGOS deve essere affidabile, comprensibile, utilizzabile principalmente da dispositivi mobili e sostenibile per un numero limitato di utenti.

## 3. Architettura di prodotto

Il prodotto è costituito da un **unico Core universale mantenuto e versionato**, destinato a installazioni indipendenti.

Le prime destinazioni sono:

- **ASPRI**, prioritaria per il primo impiego operativo;
- **ADEXIMA**, seconda destinazione applicativa.

Il contratto architetturale C1/C2 approvato prevede installazioni Retool indipendenti, database Supabase indipendenti, credenziali e configurazioni proprie e assenza di multi-tenancy condivisa obbligatoria.

Le installazioni devono derivare dalla stessa fonte del Core. Le funzionalità comuni non devono diventare implementazioni differenti mantenute separatamente.

Il Core può offrire capacità non utilizzate da una determinata istanza. L'istanza può presentare interfacce e workflow specializzati, ma non deve compensare carenze delle capacità universali duplicando il motore.

L'implementazione delle configurazioni, della replica e degli aggiornamenti rimane soggetta ai rispettivi gate della Roadmap.

## 4. Esperienza di interazione

### 4.1 Punto di ingresso unico

LOGOS adotta un punto di ingresso intelligente, prevalentemente testuale.

L'utente descrive l'operazione. Il sistema riconosce, nei limiti delle capacità disponibili, l'intenzione e attiva il percorso appropriato.

Esempi:

- registrare un'attività;
- inserire una spesa o un incasso;
- registrare una durata;
- creare un progetto;
- creare un'entità;
- richiedere la modifica o consultazione di informazioni.

### 4.2 Assistenza e completamento

L'interpretazione non deve confondere un suggerimento con una decisione già accettata.

Il sistema deve mostrare dati interpretati, ambiguità e informazioni mancanti in modo comprensibile, consentendo il completamento o la correzione nei limiti del lifecycle.

Input libero assistito e modalità guidata rimangono modalità distinte; devono però condividere, dove pertinente, contratti, validazioni e logiche comuni.

Non è richiesto sviluppare immediatamente una modalità guidata universale completa.

### 4.3 Canali futuri

Siri, API e altre interfacce costituiscono evoluzioni previste. Il Core deve preservare la possibilità di acquisire input da canali differenti, senza considerare le integrazioni già implementate.

L'attuale presenza di logiche nel frontend Retool non dimostra automaticamente che esse siano riutilizzabili da canali esterni.

## 5. Capacità universali richieste

Il Core deve raggiungere un livello verificabile di completezza nelle seguenti aree.

### CF-01 — Acquisizione e interpretazione

Conservare l'input originale, riconoscere le informazioni supportate, normalizzare valori e distinguere i principali comandi dalle registrazioni ordinarie.

### CF-02 — Progetti ed entità

Gestire identificativi stabili, nomi, tipologie, stati pertinenti e protezioni contro associazioni errate o duplicazioni non controllate.

Project rappresenta un contenitore operativo. Entity rappresenta un soggetto. La tipologia descrive la natura dell'oggetto, non il suo ruolo occasionale.

### CF-03 — Gerarchie e correlazioni

Rappresentare gerarchie stabili e collegamenti tra registrazioni e oggetti con semantica esplicita.

Una relazione padre/figlio non deve essere usata per simulare indiscriminatamente genealogie, prenotazioni, ruoli temporanei o duplicati.

Le cardinalità e i tipi di correlazione necessari saranno definiti mediante il contratto dati competente, con interventi proporzionati ai casi d'uso approvati.

### CF-04 — Eventi, economia, tempi e scadenze

Registrare eventi classificati, importi, unità, date, durate, relazioni e informazioni sufficienti per distinguere attività, movimenti economici, obbligazioni e scadenze quando richiesto.

La distinzione economica tra spese e incassi deve consentire aggregazioni affidabili.

Un evento eseguito e una scadenza futura devono essere distinguibili.

### CF-05 — Lifecycle, affidabilità e rettifiche

Gestire stati di validazione, integrità dei riferimenti, transizioni ammesse e rettifiche in modo coerente con il contratto del ledger.

Conservare le prove già valide del lifecycle e dell'hardening senza confondere il loro completamento con una certificazione generale del prodotto.

Idempotenza, concorrenza e atomicità devono essere qualificate per i flussi che effettivamente le richiedono.

### CF-06 — Consultazione e gestione

Consentire di recuperare informazioni e comprenderne lo stato, le associazioni e i dati strutturati rilevanti.

La revisione dei NEW deve permettere di valutare ciò che è realmente destinato alla persistenza e alla successiva analisi, non soltanto il testo originale.

La possibile semplificazione futura della conferma manuale resta subordinata a prove sufficienti di affidabilità.

### CF-07 — Proiezione e analisi minima

Fornire dati e aggregazioni attendibili su eventi validi, progetti, entità, periodi e correlazioni supportate.

Il contratto analitico deve esistere prima di dipendere da esso per i report delle istanze.

Le dashboard grafiche complete possono essere sviluppate successivamente; la correttezza dei dati per esse non può essere rinviata.

### CF-08 — Distribuzione e continuità

Consentire una release qualificata del Core, la replica coerente nelle installazioni indipendenti, la gestione dei binding, degli aggiornamenti compatibili e del ripristino.

Le condizioni specifiche sono quelle del contratto C1/C2 e dei gate di release della Roadmap.

## 6. Requisiti di qualità del modello dati

Le capacità funzionali devono essere sostenute da dati persistiti e interrogabili.

Prima di considerare completa una funzionalità occorre verificare:

1. quali informazioni devono essere rappresentate;
2. il significato dei dati e la loro cardinalità;
3. quali campi o relazioni esistono realmente;
4. quali dati vengono effettivamente scritti;
5. quali vincoli ne preservano la coerenza;
6. come possono essere letti e aggregati;
7. quali lacune richiedono una decisione o modifica di schema.

Un campo presente ma inutilizzato non equivale a una funzione completata.

Un'informazione presente soltanto nel testo libero non equivale automaticamente a un dato strutturato affidabile.

Nuove colonne, tabelle o relazioni non sono autorizzate da questo documento; devono derivare da requisiti e contratti qualificati.

Le evidenze dello schema reale appartengono a `05_LOGOS_Database_Schema.md` e `LOGOS_SUPABASE_RUNTIME_REAL.md`.

## 7. ASPRI — Requisiti essenziali di verifica del Core

ASPRI costituisce il primo scenario operativo rappresentativo.

### 7.1 Animali e genealogia

Devono essere rappresentabili animali identificati, accoppiamenti o coppie genitoriali, cucciolate e cuccioli.

Per ogni cucciolata deve essere possibile conoscere entrambi i genitori e il numero dei cuccioli.

Deve essere possibile rispondere a domande quali: quante cucciolate e quanti cuccioli hanno prodotto insieme Alfie e Amanda?

Il singolo `parent_entity_id` non rappresenta da solo due genitori biologici. La soluzione specifica non viene stabilita da questo contratto.

### 7.2 Prenotazioni

Deve essere possibile collegare una prenotazione a un cucciolo e a un cliente identificati.

La prenotazione deve essere rappresentabile anche in assenza di acconto.

Devono essere distinguibili prenotazioni attive, annullate e concluse, secondo il futuro contratto operativo.

La variazione del cliente associato a un cucciolo non deve cancellare o attribuire erroneamente gli importi precedenti.

### 7.3 Economia

Per ciascun cucciolo/prenotazione devono essere ricostruibili:

- prezzo concordato;
- versamenti effettuati;
- saldo residuo;
- cliente cui sono attribuiti i movimenti;
- stato della prenotazione.

Devono essere disponibili aggregazioni per cucciolo, cliente, cucciolata e periodo.

Le spese comuni della cucciolata devono essere distinguibili dai movimenti specifici dei singoli cuccioli.

### 7.4 Attività e scadenze

L'istanza deve poter rappresentare attività, vaccinazioni, trattamenti, date e richiami futuri, con collegamenti affidabili ai soggetti pertinenti.

### 7.5 Confine Core/istanza

LOGOS deve garantire identificazione, eventi, correlazioni, importi, tempi, scadenze e letture affidabili.

ASPRI definisce e presenta la semantica specifica di cucciolate, genealogie, prenotazioni e attività veterinarie.

Non è richiesto inserire campi verticali dell'allevamento indiscriminatamente nelle tabelle universali.

## 8. ADEXIMA — Requisiti essenziali di verifica del Core

ADEXIMA costituisce il secondo scenario rappresentativo.

Deve poter gestire soggetti, clienti, referenti, progetti, cantieri e interventi, utilizzando le capacità universali pertinenti.

Deve essere possibile:

- registrare tempi di attività;
- associare spese e incassi a un progetto;
- collegare soggetti e registrazioni;
- distinguere attività svolte e previste;
- interrogare dati per cliente, intervento e periodo;
- ricavare costi, ricavi, tempo impiegato e marginalità.

Le regole operative verticali di ADEXIMA non devono essere codificate nel Core condiviso.

## 9. Verifiche funzionali minime prima delle istanze

Il Core deve superare scenari di prova rappresentativi che dimostrino le capacità necessarie, senza implementare prematuramente tutte le interfacce verticali.

**VF-01 — Acquisizione:** un input viene interpretato, completato, validato e persistito correttamente.

**VF-02 — Anagrafiche:** progetti ed entità sono distinguibili, identificabili e gestibili senza collegamenti ambigui non risolti.

**VF-03 — Gerarchie:** un contenitore e i propri elementi figli sono recuperabili senza perdere identità o integrità.

**VF-04 — Correlazioni:** le registrazioni possono essere attribuite alle relazioni pertinenti, senza confondere contenimento, ruolo e collegamento occasionale.

**VF-05 — Economia:** più acconti riferiti alla stessa obbligazione possono essere sommati e confrontati con il relativo prezzo concordato.

**VF-06 — Genealogia rappresentativa:** una cucciolata può essere associata a due genitori e contribuire al conteggio per coppia, mediante il modello qualificato.

**VF-07 — Analisi:** spese, incassi e durate possono essere aggregate in modo coerente per progetto.

**VF-08 — Affidabilità:** stati, rettifiche e operazioni ripetute non producono risultati incompatibili con il contratto del ledger.

**VF-09 — Distribuzione:** la release qualificata mantiene identità e isolamento delle installazioni.

I test devono distinguere funzionalità comune da specificità verticale. Un test astratto o simulato non costituisce verifica live.

## 10. Criterio di completezza del Core

Il Core si considera completo rispetto al perimetro concordato quando:

- le capacità universali obbligatorie sono implementate e verificate;
- i requisiti dati corrispondenti sono soddisfatti;
- gli scenari di accettazione pertinenti superano i test;
- non rimangono impedimenti bloccanti sulle funzionalità richieste;
- il sistema può essere qualificato per la replica secondo C1/C2.

Il completamento del Core non coincide con quello delle installazioni ASPRI e ADEXIMA.

Non si richiede la realizzazione di tutte le automazioni teoricamente possibili, delle dashboard avanzate o delle integrazioni Siri/API definitive.

## 11. Misurazione dell'avanzamento globale

### 11.1 Indicatore ufficiale

È introdotto l'indicatore **LOGOS Core Global Completion**, riferito esclusivamente al completamento e alla qualificazione del Core comune.

Il 100% rappresenta il soddisfacimento verificato del perimetro funzionale approvato, incluse le condizioni di release e replica.

Non misura il numero di schermate create, il numero di commit o la semplice quantità di nodi conclusi.

### 11.2 Baseline di misurazione

Una baseline dedicata deve fissare:

- macro-capacità e milestone misurabili;
- criteri di accettazione;
- pesi complessivi pari al 100%;
- evidenze già valide e riutilizzabili;
- milestone soddisfatte e residue;
- dipendenze e impedimenti.

La percentuale globale si calcola come:

**Avanzamento = somma dei pesi delle milestone verificate PASS / somma dei pesi della baseline × 100.**

Una milestone non viene conteggiata come completata soltanto perché pianificata, documentata o parzialmente implementata.

La baseline deve evitare di penalizzare artificialmente prove precedenti ancora valide.

Eventuali cambi del perimetro o dei pesi devono essere approvati, tracciati e accompagnati da una nuova baseline comparabile; non si modificano retroattivamente le misurazioni precedenti.

### 11.3 Stato iniziale

Le percentuali storiche presenti in `00_PROJECT_State.md`, compreso il valore complessivo di circa 95%, non costituiscono automaticamente la nuova percentuale globale del Core.

**Valore iniziale del nuovo indicatore: DA BASELINARE.**

Non attribuire un numero finché non sono definiti denominatore, pesi ed evidenze.

### 11.4 Report a ogni chiusura di nodo

Ogni checkpoint conclusivo di sviluppo deve riportare:

- esito della sessione: PASS, BLOCCATA o FALLITA;
- stato globale del Core;
- avanzamento globale precedente e successivo;
- milestone completate e relative evidenze;
- milestone non completate o bloccate;
- variazione percentuale motivata;
- prossimo nodo o dipendenza necessaria;
- fonti, SHA e provenienza della misurazione.

Se il nodo non chiude una milestone della baseline, la percentuale può rimanere invariata anche con un PASS tecnico.

Un nodo concluso non implica necessariamente un incremento del progresso globale.

### 11.5 Responsabilità documentale

Questo documento governa **metodo, perimetro e criteri della misurazione**.

`00_PROJECT_State.md` conserva il valore corrente, la versione della baseline e l'istante della misurazione.

`00_PROJECT_Roadmap.md` conserva milestone, dipendenze e lavoro residuo.

I checkpoint conservano le prove dei singoli cambiamenti.

Non si duplicano tabelle di avanzamento divergenti in documenti diversi.

## 12. Limiti e decisioni da qualificare

Il contratto non autorizza automaticamente:

- nuove tabelle o colonne;
- un modello generale illimitato di relazioni;
- un motore di automazione;
- un sistema completo di dashboard;
- modifiche a protocolli già approvati;
- apertura automatica di nodi storici;
- distribuzione o pubblicazione delle istanze.

Restano da qualificare nei rispettivi nodi:

- modello minimo di correlazione;
- cardinalità, ruoli e vincoli;
- struttura delle obbligazioni economiche;
- rappresentazione universale di attività e scadenze;
- eventuali estensioni PostgreSQL;
- milestone e pesi della baseline globale;
- criteri definitivi di release.

## 13. Governo delle modifiche

Il presente documento viene aggiornato soltanto quando cambia un requisito funzionale stabile, un criterio di accettazione o il perimetro del Core.

Non viene modificato per ogni correzione tecnica o aggiornamento dello stato.

Una modifica richiede provenienza, decisione pertinente, revisione e pubblicazione tracciata.

Le implementazioni restano governate dai rispettivi documenti tecnici canonici e dalla Roadmap.

## 14. Provenienza e validità

**Fonti documentali:** `moody58/LOGOS`, branch `main`, SHA `ef377a38f77c995af29e16be06741b9eb3cd0073`.

Documenti principali: Project System v08, Core Architectural Baseline v1.0, State v35, Roadmap v26, Gap Register v23, Kernel Manifest v06, Database Schema v12, Retool Runtime v22, Supabase Runtime v7 e Session Management Protocol v1.3.

**Evidenza live del 28 ottobre 2026:** lettura di schema, colonne, vincoli e aggregati delle quattro tabelle `public` nel progetto `logos_template`, ref `utvwefciuxtwoqvvcwel`. Nessuna scrittura eseguita.

**Fonte dei requisiti funzionali:** discussione del 28 ottobre 2026, nodo `CP-LOGOS-DEV-NEXT-NODE-EVAL-20261028-11`.

La presente versione non sostituisce le prove live né certifica la readiness produttiva.

## 15. Storico revisioni

**v1.1 — 28 ottobre 2026**

Correzione editoriale dello stato di pubblicazione della v1.0 e dei relativi riferimenti; versione in seconda riga e rimozione dei soli spazi finali dell’intestazione. Requisiti, decisioni, criteri e metodo di misurazione invariati. La presente voce non attesta applicazione o pubblicazione della v1.1.

**v1.0 — 28 ottobre 2026**

Prima versione del contratto funzionale: visione, modello di interazione, confini Core/istanze, requisiti dati, scenari ASPRI/ADEXIMA, criteri di completamento e metodo per misurare l'avanzamento globale.

Pubblicazione canonica v1.0 attestata su `moody58/LOGOS`, branch `main`, commit `afc0c26a92aaf2a1256c55605eb2f9b776e5da41`.
