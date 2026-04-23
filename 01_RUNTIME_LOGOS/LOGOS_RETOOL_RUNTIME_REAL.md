\#DOC



LOGOS\_RETOOL\_RUNTIME\_REAL\_v04



DATA: 2026-04-23



\------------------------------------------------

CQD — VALIDAZIONE DOCUMENTO

\------------------------------------------------



C (Completezza): 10/10  

\- copertura completa runtime reale  

\- input → parsing → matching → insert → processing  

\- script allineati al sistema attuale  



Q (Qualità): 8/10  
- runtime reale documentato ma non aggiornato  
- assenza update flow  
- assenza gestione edit_mode  
- non rappresentato il comportamento UI attuale  
- non documentato il loop reattivo   



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

→ INSERT / UPDATE  
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

⚠ possibile re-trigger parsing (loop reattivo)

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

⚠ presenza di più sistemi di matching:

- input_raw (ranking)
- select (deterministico)
- preview (detection)

→ non unificati


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

⚠ contiene logiche di trasformazione  
⚠ utilizza fonti multiple non sincronizzate  
⚠ parte del flusso reattivo   

⚠ possibile incoerenza tra:

- parsing
- matching
- select
- hint

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

7. INSERT / UPDATE EVENT

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

UPDATE FLOW (NUOVO):

- update_event
- utilizzato in edit_mode
- modifica eventi esistenti
- status invariato (NEW)
- aggiornamento campo updated_at

\---



Caratteristiche:



✔ insert generalmente consentito  
✔ nessuna validazione bloccante  
✔ unit generalmente valorizzata correttamente  
✔ amount coerente con parsing  

⚠ insert può fallire per errori runtime (binding / null access)  
⚠ coerenza preview → DB non sempre garantita    

✔ distinzione runtime:

- edit_mode = false → insert_event  
- edit_mode = true → update_event  

\------------------------------------------------

8\. RESET \& FEEDBACK

\------------------------------------------------



Sequenza:


1. insert_event / update_event  
2. handle_event_success.trigger()  
3. ui_state → feedback  
4. reset input e select  
5. ritorno automatico a home (~4–5s)   

⚠ gestione UI centralizzata  
⚠ evitati multi-trigger su ui_state  

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

EDITING:

- disponibile solo per eventi NEW
- riuso pipeline input
- update_event

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
- update_event

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

ARCHITETTURA:

- loop reattivo input → parsing → UI  
- accoppiamento tra layer  
- preview non pura  
- matching non unificato  

UI:

- gestione stato fragile (multi-trigger)  

\------------------------------------------------

12\. PRINCIPI RUNTIME

\------------------------------------------------



✔ client-side logic  

✔ database passivo  

✔ append-only controllato (editing su NEW) 

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

v04 — 2026-04-23  

- introduzione update_event  
- introduzione edit_mode  
- refactor confirm flow  
- introduzione handle_event_success  
- aggiornamento UI state  
- identificazione loop reattivo  
- allineamento runtime con sistema reale  