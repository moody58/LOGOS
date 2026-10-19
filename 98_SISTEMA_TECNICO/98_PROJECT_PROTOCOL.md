PROJECT — Protocollo Operativo
Versione: v1.1



Sistema: AIOS Project Framework

Data revisione: 2026-10-18





1 — SCOPO DEL DOCUMENTO



Questo documento definisce il protocollo operativo

standard dei progetti basati sul sistema AIOS.



Il protocollo stabilisce:



• il metodo di lavoro delle sessioni operative  

• la relazione tra conversazione e documentazione  

• la gerarchia delle fonti informative  

• il processo di consolidamento delle decisioni  





2 — PRINCIPIO OPERATIVO FONDAMENTALE



Chat genera contenuto  

Documenti consolidano il progetto  

File conservano la memoria  





3 — ARCHITETTURA OPERATIVA DEL PROGETTO



Il lavoro nel progetto è organizzato su tre livelli.



Regia del progetto  

↓  

Roadmap Area  

↓  

Micro-Sessioni operative  



Le micro-sessioni producono sempre uno dei seguenti output:



DOC  

documento riutilizzabile nel sistema



CHECKPOINT  

sintesi strutturata delle decisioni della sessione  





4 — STRUTTURA DEL REPOSITORY



La struttura del progetto utilizza macro-aree

numeriche per mantenere ordine e replicabilità.



00 fondamenta strategiche  

01–09 macro-aree operative  

90 collaborazione esterna  

97 sistemi dati  

98 sistema tecnico  

99 archivio strategico  





5 — SESSIONI OPERATIVE



Le sessioni operative utilizzano il trigger:



\#session



Formato standard:



\#session  

Macroarea:  

Nodo operativo:  

Documento di riferimento:  

Obiettivo:





6 — RUNTIME CONVERSAZIONALE



Il comportamento delle chat è definito dal documento:



98\_PROJECT\_RUNTIME



Il runtime governa:



• trigger operativi  

• Boot Sequence  

• Meta-Observation  

• State Guard  

• Safe Mode  





7 — ANCHOR CONVERSAZIONALI



Le conversazioni utilizzano anchor semantici

per identificare i nodi della discussione.



Tipologie principali:



\#INSIGHT  

\#QUESTION  

\#DECISION  

\#STRUCTURE  

\#DOC  

\#TASK  



Pipeline cognitiva:



INSIGHT → DECISION → STRUCTURE → DOC → TASK  





8 — CONSOLIDAMENTO DELLE DECISIONI



Le decisioni emerse nelle conversazioni

diventano ufficiali solo quando vengono

consolidate nei documenti del progetto.





9 — INTEGRAZIONE PROTOCOLLI TECNICI



Il progetto utilizza protocolli tecnici

per garantire stabilità del sistema.



CQD Protocol  

controllo qualità documenti



STP Protocol  

stress test delle decisioni



Sistema Fonti  

gestione fonti esterne



Incident Management  

gestione anomalie operative  





10 — NATURA EVOLUTIVA DEL SISTEMA



Il protocollo è progettato per essere stabile

ma evolutivo.



Eventuali modifiche devono mantenere

coerenza con il metodo AIOS e con

l’architettura del progetto.





11 — STORICO REVISIONI



Questo documento fa parte di un template

di progetto.



Lo storico revisioni sarà utilizzato nei

progetti derivati dal template per tracciare

le modifiche nel tempo.

------------------------------------------------
12 — GESTIONE MICRO-SESSIONI (ESTESO)
------------------------------------------------

Le micro-sessioni rappresentano il livello operativo del progetto.

La loro gestione deve essere deterministica e controllata.

---

12.1 — CREAZIONE MICRO-SESSIONE (DA REGIA)

La Regia definisce:

- nodo operativo
- obiettivo
- vincoli
- condizione di chiusura

La Regia NON esegue attività operative.

---

12.2 — DOCUMENTI OBBLIGATORI

Ogni micro-sessione deve dichiarare esplicitamente:

CORE:

- 00_PROJECT_State
- Roadmap

TECNICI (se rilevanti):

- Input System
- Match Engine
- Architecture

---

Se un documento necessario manca:

→ sospensione dell'operativita' dipendente
→ tentare il recupero secondo il Kernel; se non disponibile chiedere soltanto la fonte mancante

---

12.3 — VERIFICA VERSIONI (META-OBSERVATION)

La Meta-Observation verifica:

- presenza documenti
- coerenza con stato
- allineamento versione

Se incoerenza:

→ suggerire:
#state
DOC
SYNC

---

12.4 — RELAZIONE CON LE FONTI

Le fonti NON aggiornano una sessione attiva.

---

Regola:

Ogni micro-sessione è isolata.

Usa:

→ snapshot documentale al momento del boot

---

Conseguenza:

Aggiornare le fonti NON modifica:

- Regia attiva
- sessioni attive

---

12.5 — CICLO OPERATIVO COMPLETO

Regia:

→ definisce nodo  

↓

Micro-sessione:

→ analisi  
→ decisione  
→ operatività  
→ test  

↓

Output:

→ CHECKPOINT o DOC  

↓

Aggiornamento:

→ STATE  
→ documenti  

---

12.6 — VINCOLI OPERATIVI

La micro-sessione:

✔ può decidere  
✔ può implementare  
✔ può testare  

MA:

❌ non può cambiare nodo implicitamente  
❌ non può modificare la Roadmap senza mandato esplicito  
❌ non può introdurre modifiche architetturali senza mandato esplicito  

Un mandato confermato non può essere ampliato implicitamente. I passaggi già autorizzati non richiedono nuovi consensi organizzativi.

---

12.7 — CHIUSURA SESSIONE

Una sessione è chiusa solo se:

- DOC o CHECKPOINT prodotto;
- esito della sessione PASS/BLOCCATA/FALLITA, con prove e limiti;
- recap predisposto per la Regia: nodo/scope, decisioni, risultati, fonti, prove, anomalie, prossimo passo.

La sessione conclusa non implica il nodo completato. Distinguere conclusione tecnica, consolidamento documentale, pubblicazione e passaggio conversazionale ancora pendente. Il nodo è completato soltanto quando i risultati richiesti sono verificati. Non dichiarare aggiornamenti documentali o trasferimenti alla Regia che non sono stati effettivamente eseguiti.

---

12.8 — DERIVA OPERATIVA

Se durante la sessione:

- cambia focus
- emergono nuovi problemi
- si esce dal nodo

→ verificare la compatibilità dell'azione con nodo e scope autorizzati

→ STOP della sola azione incompatibile, dichiarando causa e deviazione

→ conservare prove valide; analisi, chiarimenti e alternative non esecutive restano possibili

→ riportare in Regia le decisioni strategiche esterne al mandato con proposta circoscritta

---

12.9 — RESET REGIA

La Regia NON è persistente.

Se:

- incoerenza
- lentezza
- confusione

→ nuova chat

→ Boot Sequence

→ acquisizione documenti core dalla repository allo SHA del boot
STORICO REVISIONI

v1.1 — 2026-10-18: precisati i vincoli del mandato, lo STOP della sola azione incompatibile e la distinzione tra esito della sessione e completamento del nodo.

v1.0 — 2026-10-15: prima versione esplicita, testo precedente preservato.
Per acquisizione, copie, checkpoint e re-boot vale il Kernel Manifest.
Nessun obbligo di duplicare nelle fonti allegate i documenti gia' su GitHub.