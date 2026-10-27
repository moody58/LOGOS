PROJECT — SESSION MANAGEMENT PROTOCOL
Versione: v1.3

Documento: 98_PROJECT_Session_Management_Protocol  

------------------------------------------------
SCOPO
------------------------------------------------

Definire la gestione sicura delle:

- micro-sessioni operative
- Regia (control room)

Obiettivo:

evitare deriva, incoerenza e saturazione.

------------------------------------------------
PRINCIPIO FONDANTE
------------------------------------------------

Regia coordina  
Sessioni eseguono  

---

La Regia analizza, valuta, sceglie e coordina i mandati. Non esegue coding, debug o scritture operative.

Le sessioni NON decidono direzione.

------------------------------------------------
MICRO-SESSIONI
------------------------------------------------

Per ogni nodo confermato la Regia prepara un BLOCCO D'APERTURA copiabile:
@@LOGOS, tipo di sessione, nodo/mandato, obiettivo, scope ed esclusioni,
output e criteri di chiusura, decisioni/prove valide, fonti/checkpoint,
provenienza e SHA, dipendenze, autorizzazioni e primo passo.
Il blocco non avvia la chat e non attesta letture.

In ogni nuova chat LOGOS eseguire il Core Boot obbligatorio secondo il Kernel:
State, Roadmap e ultimo checkpoint pertinente; seguire la Session Boot Matrix.
Dichiarare fonti, completezza, provenienza e limiti. Non presumere letture
ereditate dal blocco d'apertura o da una conversazione precedente.

Nello stesso nodo e con contesto adeguato mantenere la continuità.
Per nuove pubblicazioni dichiarare nuovo boot/rebind; non ripetere
acquisizioni o test validi a fonti immutate.

Regole:

✔ UNA sessione = UN nodo  
✔ durata breve  
✔ output obbligatorio  

Output ammessi:

- CHECKPOINT  
- DOC  

---

Una sessione termina quando:

- obiettivo della sessione raggiunto;  
- impedimento che richiede restituzione del controllo;  
- saturazione, perdita di contesto o cambio nodo che richiedono #switch.  

Produrre DOC o CHECKPOINT e dichiarare l'esito della sessione: PASS, BLOCCATA o FALLITA, con prove e limiti. La sessione conclusa non implica il nodo completato. Distinguere conclusione tecnica, consolidamento documentale, pubblicazione e passaggio conversazionale pendente.

---

Divieto:

- cambiare nodo
- espandere scope
- introdurre nuove direzioni

I cambi di nodo, Roadmap o architettura richiedono mandato esplicito; non possono essere introdotti implicitamente durante l'esecuzione. Fermare soltanto l'azione incompatibile. Le decisioni strategiche esterne al mandato tornano in Regia con proposta circoscritta.

------------------------------------------------
CONTROLLO DI AVANZAMENTO E GESTIONE DELLO STALLO
------------------------------------------------

Prima di intraprendere un nuovo ciclo sul medesimo problema, confrontare
il passo proposto con il mandato, i risultati ottenuti, le prove ancora
valide e i criteri di chiusura.

Costituiscono avanzamento effettivo una nuova prova pertinente, un
risultato richiesto, la risoluzione di una dipendenza oppure una
decisione necessaria e autorizzata. La sola ripetizione di analisi,
letture, verifiche o formulazioni non costituisce avanzamento.

Se due passaggi consecutivi equivalenti non producono avanzamento,
a condizioni sostanzialmente immutate, attivare una diagnosi mirata
dello stallo. La soglia e' un segnale diagnostico, non uno STOP
automatico della microsessione.

Identificare cio' che e' gia' dimostrato, la causa dell'assenza di
progresso e l'eventuale nuova condizione necessaria. Non ripetere
il passaggio senza un requisito nuovo o una variazione materiale.
Proseguire le altre attivita' lecite e indipendenti, senza aggirare
STOP, gate tecnici o consensi.

Quando i criteri di chiusura risultano soddisfatti, concludere
secondo il presente protocollo, senza introdurre ulteriori
controlli, nodi o attivita' non richiesti. Se una dipendenza
indispensabile impedisce la conclusione, produrre un checkpoint
d'impedimento riutilizzabile, distinguendo la sessione dal nodo
complessivo e indicando il prossimo passo eseguibile e la condizione
necessaria per la ripresa.

Il controllo e' interno e contestuale: non richiede report rituali
a ogni messaggio e non implica un monitor autonomo.

------------------------------------------------
CICLO OPERATIVO
------------------------------------------------

Regia:

→ definisce nodo  
→ definisce confini  

↓

Micro-sessione:

→ analizza  
→ decide  
→ implementa  
→ testa  

↓

Output:

→ CHECKPOINT  
oppure DOC

Preparare un unico recap per la Regia LOGOS: nodo/scope, esito della sessione, decisioni, risultati, fonti, prove, anomalie, attività residue e prossimo passo. Non dichiarare la Regia aggiornata senza trasferimento reale.

↓

Aggiornamento:

→ STATE  
→ documenti  

#switch richiede un BLOCCO DI RIPRESA: nodo e scope, prove e consensi ancora validi, fonti/SHA/checkpoint, decisioni, risultati, rischi e prossimo comando o passo. La nuova chat verifica le fonti necessarie e svolge il Core Boot iniziale. La ripresa sullo stesso nodo non implica un nuovo mandato.

------------------------------------------------
GESTIONE REGIA
------------------------------------------------

La Regia è:

✔ stabile  
✔ leggera  
✔ non operativa  

---

La Regia NON accumula:

- analisi lunghe  
- codice  
- debug  

------------------------------------------------
SATURAZIONE REGIA
------------------------------------------------

Trigger di saturazione:

- incoerenza risposte
- perdita focus
- ripetizioni
- conflitti tra decisioni

---

Quando avviene:

→ RESET REGIA

------------------------------------------------
RESET REGIA (OBBLIGATORIO)
------------------------------------------------

Procedura:

1. nuova chat
2. Boot Sequence (#start)
3. acquisire dalla repository allo SHA del boot secondo il Kernel:

- 00_PROJECT_State
- Roadmap
- ultimo checkpoint pertinente, da repo oppure allegato con provenienza dichiarata

4. dichiarare nodo attivo

---

Divieto:

- riutilizzare vecchia Regia
- portare storico conversazione

------------------------------------------------
GESTIONE FONTI
------------------------------------------------

Le fonti:

✔ supportano il sistema  
✔ NON aggiornano la chat attiva  

---

Regola:

Ogni nuova sessione:

→ usa fonti aggiornate  

La Regia:

→ NON si aggiorna automaticamente  

---

Conseguenza:

Le fonti NON causano deriva  

La saturazione puo' causare deriva; fonti incoerenti o stale vanno rilevate
secondo il Kernel, senza attribuire tutto alla lunghezza della chat.  

------------------------------------------------
PRINCIPIO FINALE
------------------------------------------------

Stabilità > Continuità conversazionale  

---

Meglio:

✔ nuova Regia pulita  

Peggio:

❌ Regia lunga e incoerente  
VERSION HISTORY

v1.3 — 2026-10-27: nodo CP-LOGOS-EFFICACIA-PROTOCOLLI-20261027-01;
recepito da AIOS Session Protocol v1.5 il controllo contestuale
dell'avanzamento e dello stallo improduttivo. Riuso delle prove valide,
nessuna ripetizione a condizioni immutate e chiusura secondo i criteri
esistenti. Invariati gate, consensi, protezioni, ruoli e poteri operativi;
nessun monitor autonomo.

v1.2 — 2026-10-18: apertura e Core Boot, continuità e blocco di ripresa, esiti PASS/BLOCCATA/FALLITA distinti dal completamento del nodo e recap conclusivo per la Regia; nessun trasferimento o aggiornamento implicito.

v1.1 — 2026-10-15: acquisizione tramite integrazioni e checkpoint pertinenti.
Per fonti, allegati persistenti, nuovo boot e fallimenti di accesso applicare
00_FONDAMENTA_PROGETTO/00_PROJECT_KERNEL_MANIFEST.md.
Un re-boot esplicito nello stesso nodo non richiede una nuova chat se il
contesto resta adeguato; cambio nodo o saturazione conservano #switch/nuova chat.