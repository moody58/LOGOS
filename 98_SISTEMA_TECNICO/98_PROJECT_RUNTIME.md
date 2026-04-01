PROJECT — Runtime System



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





Principio operativo



Il runtime non interrompe la conversazione.



Suggerisce azioni quando rileva eventi

rilevanti per la stabilità del sistema.



Il suo obiettivo è mantenere:



• coerenza metodologica

• stabilità operativa

• continuità tra conversazione e documentazione.



