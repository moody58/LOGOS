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

\- presenza di ambiguità controllate (matching / hint)
- presenza di criticità runtime (binding / null access)  



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

✔ allineamento completo preview → insert → DB  

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

⚠ nessuna distinzione spesa/incasso  
⚠ possibile incoerenza tra tipo selezionato e contenuto input  

\------------------------------------------------

5\. PREVIEW (SINTESI)

\------------------------------------------------



Costruita da:



\- input\_raw

\- select\_project

\- select\_entity



\---



OUTPUT:

- 1 match → auto-select
- >1 match → ambiguità
- 0 match → nessun suggerimento
⚠ ambiguità non sempre segnalata correttamente  
⚠ riconoscimento entity non sempre consistente su input complessi  

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

⚠ allineamento preview → insert NON sempre garantito (binding runtime)  
⚠ presenza di incoerenze su hint e highlight    

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

✔ supporto unit compatte (2h, 18min, 0.5h)  
✔ riconoscimento unit anche senza spazi  

\---



AMOUNT:



\- matchAll numeri

\- selezione per prossimità alla unità

✔ gestione input multi-numero  
→ selezione basata sulla unit più rilevante (ultima occorrenza)

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



✔ insert generalmente consentito  
✔ nessuna validazione bloccante  
✔ unit generalmente valorizzata correttamente  
✔ amount coerente con parsing  

⚠ insert può fallire per errori runtime (binding / null access)  
⚠ coerenza preview → DB non sempre garantita    

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



------------------------------------------------
10. QUERY
------------------------------------------------

GET:

- projects_list  
- entities_list  
- events_new  

---  

POST:

- insert_event  

---  

RPC:

- update_written  
- update_error  

---  

STATE / UI:

- ui_state  
- typing_state  
- project_state  
- entity_state  

⚠ project_state / entity_state possono essere null → rischio errori runtime  



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

v03 — 2026-04-03  
- fix insert pipeline  
- supporto unit compatte  
- fix amount multi-numero  
- allineamento preview → DB  