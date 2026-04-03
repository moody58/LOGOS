\#DOC



LOGOS\_RETOOL\_RUNTIME\_REAL\_v02



DATA: 2026-04-03



\------------------------------------------------

CQD — VALIDAZIONE DOCUMENTO

\------------------------------------------------



C (Completezza): 10/10  

\- copertura completa runtime reale  

\- input → parsing → matching → insert → processing  

\- script allineati al sistema attuale  



Q (Qualità): 9.5/10  

\- eliminati comportamenti obsoleti  

\- parsing e matching coerenti  

\- nessuna ambiguità runtime  



D (Deployabilità): 10/10  

\- utilizzabile come riferimento tecnico reale  

\- perfettamente allineato a Retool  



\------------------------------------------------

STATO

\------------------------------------------------



→ SISTEMA REALE DOCUMENTATO (AS-IS)



\------------------------------------------------

DESCRIZIONE OPERATIVA DEL SISTEMA

\------------------------------------------------



Il sistema LOGOS è un Event Operating System client-side

in cui tutta la logica è gestita in Retool (JavaScript).



Flusso:



INPUT  

→ PARSING  

→ MATCHING  

→ PREVIEW  

→ INSERT  

→ PROCESSING  



\------------------------------------------------

1\. INPUT UTENTE

\------------------------------------------------



Componente: input\_home



\- input libero

\- source of truth



Sync:



input\_home.setValue → input\_raw.setValue



Trigger:



typing\_state.trigger()



\------------------------------------------------

2\. PRE-PROCESSING

\------------------------------------------------



Normalizzazione:



\- lowercase

\- trim

\- compressione spazi



cleanText = normalize(text)



\------------------------------------------------

3\. MATCHING (AGGIORNATO STEP 2)

\------------------------------------------------



Eseguito in:



\- input\_raw

\- select\_project

\- select\_entity

\- sintesi



\---



PROJECT MATCH:



\- split parole nome

\- filtro parole (>2 char, non numeriche)

\- match su parole

\- disambiguazione numerica



\---



ENTITY MATCH (RETROFIT):



STRONG:



cleanText.includes(nome)



\---



FULL:



\- parole ≥4 caratteri

\- match completo



\---



PARTIAL:



\- confronto token significativi

\- almeno una parola ≥4 caratteri in comune

\- eliminato includes aggressivo



\---



AUTO-SELECT:



\- solo match univoco

\- nessuna forzatura



\------------------------------------------------

4\. TYPE DETECTION (AGGIORNATO)

\------------------------------------------------



Componente: select1



Logica:



const hasTime = /\\b(ora|ore|min|minuti|h)\\b/.test(text)



if (hasTime) → "Tempo"



else → "Evento"



\---



Nota:



\- rimosso includes("h")

\- evitati falsi positivi ("macchina")



\------------------------------------------------

5\. PREVIEW (SINTESI)

\------------------------------------------------



Costruita da:



\- input\_raw

\- select\_project

\- select\_entity



\---



Output:



MAIN:



amount + unit + note



META:



project + entity



HINT:



\- suggerimenti matching

\- suggerimenti tipo



\---



Caratteristiche:



✔ preview = parsing reale  

✔ non modifica input  

✔ non blocca  



\------------------------------------------------

6\. PARSING (RETROFIT v2)

\------------------------------------------------



Normalizzazione:



\- separazione simboli (€)

\- separazione unit compatte (2h → 2 h)

\- pulizia spazi



\---



UNIT:



euro:



€, euro, eur



tempo:



ora, ore, h  

min, minuti  



\---



AMOUNT:



\- matchAll numeri

\- selezione per prossimità alla unità



\---



GESTIONE ORARI:



\- HH:MM ignorato



\---



FIX IMPORTANTE:



Se:



\- nessuna unità

\- un solo numero

\- numero in fondo



→ NON interpretare come amount



(es: "villa 2")



\---



DECIMALI:



\- supportati (.,)



\------------------------------------------------

7\. INSERT EVENT

\------------------------------------------------



Trigger: insert\_event



Payload:



\- raw\_input

\- amount

\- unit

\- project\_id

\- entity\_id

\- status: NEW

\- payload: {}



\---



Caratteristiche:



✔ insert sempre consentito  

✔ nessuna validazione bloccante  



\------------------------------------------------

8\. RESET \& FEEDBACK

\------------------------------------------------



Sequenza:



1\. reset input\_home  

2\. ui\_state → feedback  

3\. insert\_event  

4\. refresh eventi  

5\. clear select  

6\. ritorno home (\~3.5s)  



\------------------------------------------------

9\. PROCESSING EVENTI

\------------------------------------------------



Lista: events\_new



Azioni:



✔ WRITTEN  

✖ ERROR  



\---



Trigger:



update\_event\_status



\------------------------------------------------

10\. QUERY

\------------------------------------------------



GET:



projects\_list  

entities\_list  

events\_new  



\---



POST:



insert\_event  



\---



RPC:



update\_written  

update\_error  



\------------------------------------------------

11\. LIMITI ATTUALI

\------------------------------------------------



INPUT:



\- nessun multi-unit (2h30 → 2h)

\- nessun parsing semantico



\---



MATCHING:



\- nessuna gerarchia entity

\- nessuna disambiguazione automatica



\---



TYPE:



\- nessuna distinzione spesa/incasso



\---



UI:



\- input non multilinea

\- preview migliorabile



\------------------------------------------------

12\. PRINCIPI RUNTIME

\------------------------------------------------



✔ client-side logic  

✔ database passivo  

✔ append-only  

✔ suggerire ≠ decidere  



\------------------------------------------------

CHANGELOG

\------------------------------------------------



v01 — 2026-04-01  

\- runtime iniziale  



v02 — 2026-04-03  

\- parsing retrofit completo  

\- fix type detection  

\- entity matching migliorato  

\- fix numero finale (villa 2)  

\- allineamento completo runtime  

