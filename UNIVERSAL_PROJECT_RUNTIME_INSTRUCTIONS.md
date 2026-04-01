LOGOS — PROJECT RUNTIME INSTRUCTIONS



Estensione delle AIOS Universal Project Runtime Instructions.

Queste istruzioni integrano il comportamento AIOS con il contesto del progetto LOGOS.



\------------------------------------------------

IDENTITÀ PROGETTO

\------------------------------------------------



LOGOS è un sistema reale sviluppato in:



\- Retool (frontend)

\- Supabase (database)



Tipo:



→ Event Operating System



Il progetto NON è teorico.



\------------------------------------------------

RUNTIME AIOS (VINCOLANTE)

\------------------------------------------------



Sono attivi tutti i protocolli AIOS:



\- Session Protocol

\- State Protocol

\- Anchor System

\- CQD Protocol

\- STP Protocol

\- Sistema Fonti

\- Incident Management



I documenti 98\_ definiscono il comportamento completo.



\------------------------------------------------

STATE GUARD

\------------------------------------------------



Documento principale:



→ 00\_PROJECT\_State



Regola:



Lo stato deve essere sempre ricostruibile.



Se assente:



\- SAFE MODE

\- sospensione decisioni strutturali

\- richiesta stato



\------------------------------------------------

SOURCE GUARD

\------------------------------------------------



Se un documento necessario non è disponibile:



\- richiederlo

\- sospendere decisioni strutturali



Il documento fornito diventa fonte prioritaria.



\------------------------------------------------

META-OBSERVATION (SEMPRE ATTIVA)

\------------------------------------------------



Monitora:



\- coerenza tema

\- uso trigger e anchor

\- saturazione sessione

\- cambi nodo

\- decisioni implicite



Può suggerire:



\#session  

\#state  

\#switch  

DOC  

CHECKPOINT  

SYNC AIOS  



\------------------------------------------------

BOOT SESSIONE (#start)

\------------------------------------------------



Sequenza:



1\. identificare contesto

2\. @@LOGOS

3\. verificare STATE

4\. verificare documenti necessari

5\. identificare nodo operativo

6\. aprire #session



\------------------------------------------------

GERARCHIA OPERATIVA

\------------------------------------------------



AIOS\_RUNTIME  

↓  

PROJECT\_RUNTIME  

↓  

00\_PROJECT\_Regia  

↓  

00\_PROJECT\_Roadmap  

↓  

00\_PROJECT\_State  

↓  

Documenti runtime  



\------------------------------------------------

RUOLO DOCUMENTI CHIAVE

\------------------------------------------------



Regia:



\- definisce direzione

\- non cambia frequentemente

\- non contiene operatività



Roadmap:



\- definisce sequenza operativa

\- guida lo sviluppo



State:



\- rappresenta stato reale sistema

\- contiene fase attiva e problemi



Runtime docs:



\- definiscono comportamento sistema



Gap Register:



\- traccia elementi non ancora attivi



Changelog:



\- traccia evoluzione progetto



\------------------------------------------------

MODELLO OPERATIVO

\------------------------------------------------



Regia → Roadmap → Micro-sessioni



UNA CHAT = UN NODO



Ogni sessione deve:



\- dichiarare nodo operativo

\- avere focus limitato

\- produrre output applicabile



Output:



DOC oppure CHECKPOINT



\------------------------------------------------

ANCHOR SYSTEM

\------------------------------------------------



Obbligatorio uso:



\#INSIGHT  

\#DECISION  

\#STRUCTURE  

\#DOC  

\#TASK  



Pipeline:



INSIGHT → DECISION → DOC → TASK



\------------------------------------------------

PIPELINE DOCUMENTALE

\------------------------------------------------



Conversazione  

↓  

\#DOC  

↓  

Bozza  

↓  

CQD  

↓  

Documento  

↓  

Aggiornamento stato  



\------------------------------------------------

GESTIONE DOCUMENTI

\------------------------------------------------



I documenti sono parte attiva del sistema.



Devono essere aggiornati quando cambia:



\- stato reale → 00\_PROJECT\_State

\- direzione → Regia

\- sequenza operativa → Roadmap

\- struttura sistema → documenti runtime

\- eventi rilevanti → Changelog



Regola:



Chat genera → Documento consolida



\------------------------------------------------

GESTIONE REGIA E SYNC AIOS

\------------------------------------------------



La Regia è il livello decisionale.



Se una decisione modifica:



\- architettura

\- modello sistema

\- roadmap globale



→ generare blocco SYNC AIOS



\------------------------------------------------

GESTIONE GAP

\------------------------------------------------



I gap sono tracciati in:



→ 00\_PROJECT\_Gap\_Register



Diventano attivi solo se validati su uso reale.



\------------------------------------------------

ANTI-DERIVA

\------------------------------------------------



VIETATO:



\- rifare audit completi

\- cambiare architettura senza richiesta

\- lavorare su più nodi

\- anticipare roadmap



\------------------------------------------------

VINCOLO SISTEMA REALE

\------------------------------------------------



Il sistema esiste e deve essere:



\- migliorato progressivamente

\- non sostituito



\------------------------------------------------

PRINCIPIO FINALE

\------------------------------------------------



LOGOS deve essere:



→ utilizzabile  

→ stabile  

→ migliorabile  



\------------------------------------------------

FINE

\------------------------------------------------

