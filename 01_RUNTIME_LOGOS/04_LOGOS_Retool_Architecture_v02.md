04_LOGOS_Retool_Architecture_v04

DATA: 2026-04-04

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- struttura UI completa  
- flow input → insert documentato  
- query e componenti allineati al runtime  
- label layer integrato  

Q (Qualità): 9.5/10  
- allineato a comportamento reale aggiornato  
- distinzione chiara tra layer  
- eliminati elementi obsoleti  
- UX migliorata senza regressioni  

D (Deployabilità): 10/10  
- utilizzabile come riferimento tecnico reale  
- coerente con implementazione Retool  

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Documentare l’architettura reale dell’interfaccia LOGOS
sviluppata in Retool.

Il documento descrive:

- struttura componenti
- organizzazione UI
- logica runtime
- flussi operativi reali

------------------------------------------------
STRUTTURA GENERALE
------------------------------------------------

Applicazione:

- Single Page
- Nessun routing
- Navigazione tramite stato UI

---

Gerarchia:

page1  
└── Main  
    └── wrapper  
        ├── container_home  
        ├── container_input  
        ├── container_feedback  
        └── container_events_list  

------------------------------------------------
GESTIONE STATO UI
------------------------------------------------

Query:

ui_state  

Struttura:

{
  view: "home" | "feedback"
}

---

Binding:

container_home:  
Hidden = view === "feedback"

container_feedback:  
Hidden = view !== "feedback"

container_input:  
Hidden = !input_home.value

---

Principio:

UI = funzione dello stato

------------------------------------------------
CONTAINER HOME
------------------------------------------------

Componenti:

- input_home
- container_esempi
- container_suggerimenti
- container_attivita

---

Funzione:

- punto ingresso sistema
- input principale

---

INPUT:

campo libero

---

SUGGERIMENTI:

- registra spesa
- registra incasso
- registra tempo
- registra evento

------------------------------------------------
CONTAINER INPUT
------------------------------------------------

Componenti:

- input_raw (hidden)
- sintesi (preview)
- select1 (type)
- select_project
- select_entity
- button_input_confirm

---

Funzione:

- preview dati
- validazione manuale
- conferma inserimento

---

Preview:

MAIN:

- amount + unit + label

META:

- project
- entity

HINT:

- suggerimenti matching  
- suggerimenti tipo  
- hint durata ambigua  

---

Nota:

La label è:

✔ generata in tempo reale  
✔ non persistita  
✔ derivata da raw_input  

------------------------------------------------
INPUT FLOW (AGGIORNATO)
------------------------------------------------

input_home.onChange:

→ input_raw.setValue(input_home.value)  
→ typing_state.trigger()

---

Principio:

input_home = source of truth  

✔ input_raw utilizzato come fonte per parsing in preview e confirm  
✔ coerenza tra valore mostrato e valore persistito  

------------------------------------------------
MATCHING FLOW (AGGIORNATO STEP 2 + STEP 3)
------------------------------------------------

Eseguito in:

- input_raw (auto-select project)
- select_project (default value)
- select_entity (default value)
- sintesi (preview)

---

Caratteristiche:

✔ normalizzazione testo  
✔ tokenizzazione input  
✔ filtro parole significative  
✔ riduzione partial match aggressivo  

✔ gestione ambiguità controllata  
✔ attivazione hint condizionata  

---

PROJECT:

- match basato su parole
- disambiguazione numerica

---

ENTITY:

- match multi-livello (strong/full/partial)
- partial match basato su token ≥4 caratteri

---

AUTO-SELECT:

- solo match univoco
- nessuna forzatura

---

UX MATCHING (STEP 3):

- hint attivi solo se:
  - input ≥ 5 caratteri
  - oppure input corto ma ambiguo (prefisso)
- eliminazione suggerimenti duplicati  
- riduzione rumore UI  

------------------------------------------------
TYPE DETECTION (AGGIORNATO)
------------------------------------------------

Componente:

select1

---

Logica:

- Tempo → match su parola intera (ora, ore, min, minuti, h)
- Evento → default

---

Nota:

- rimosso fallback aggressivo su "h"
- evitati falsi positivi (es. "macchina")

------------------------------------------------
PARSING FLOW (RETROFIT v2)
------------------------------------------------

Eseguito in:

- sintesi (preview)
- button_input_confirm

---

Caratteristiche:

✔ normalizzazione input  
✔ riconoscimento unità  
✔ selezione amount per prossimità  
✔ gestione decimali  
✔ esclusione formato HH:MM  

✔ supporto unit compatte (2h, 18min, 0.5h)  
✔ riconoscimento unit anche senza spazi  
✔ gestione input multi-numero  
→ selezione amount basata sulla unit più rilevante (ultima occorrenza)  

---

Nota:

preview = parsing reale  

------------------------------------------------
LABEL FLOW (STEP 3 — NUOVO)
------------------------------------------------

Eseguito in:

- sintesi (preview)

---

Caratteristiche:

✔ non distruttivo  
✔ deterministico  
✔ separato dal parsing  

---

Pipeline:

1. normalizzazione testo  
2. rimozione amount + unit  
3. gestione unit compatte (3h, 30min)  
4. rimozione stopwords base  
5. numeric safe (numeri preservati)  
6. compound token (es: "villa 2")  
7. sorting alfabetico (locale: it, sensitivity base)  

---

Output:

- label coerente  
- leggibile  
- stabile  

---

Nota:

label NON salvata nel DB  

------------------------------------------------
CONFIRM FLOW
------------------------------------------------

Sequenza:

1. reset input_home  
2. ui_state → feedback  
3. insert_event.trigger()  
4. events_new.trigger()  
5. clear select  
6. timeout → home  

---

Obiettivo:

- evitare flicker
- mantenere fluidità  

✔ parsing eseguito in fase di confirm  
✔ allineamento completo con preview  
✔ eliminata divergenza tra preview e insert  
✔ payload coerente ai dati visualizzati  

------------------------------------------------
QUERY ATTIVE
------------------------------------------------

DATA:

- projects_list
- entities_list

---

EVENTI:

- insert_event
- events_new
- update_written
- update_error

---

STATE:

- ui_state
- typing_state

------------------------------------------------
SUPABASE INTEGRAZIONE
------------------------------------------------

Connessione:

REST API

---

Uso:

- fetch liste
- insert eventi
- update status

---

Nota:

database passivo (nessuna logica)

------------------------------------------------
PATTERN ARCHITETTURALI
------------------------------------------------

✔ Adapter Pattern (input_raw)  
✔ State-driven UI  
✔ Client-side logic  
✔ Append-only interaction  

------------------------------------------------
PROBLEMI NOTI (AGGIORNATI)
------------------------------------------------

✔ parsing → RISOLTO  
✔ matching → STABILIZZATO  
✔ perdita unit → RISOLTA  
✔ mismatch amount → RISOLTO  
✔ divergenza preview / DB → RISOLTA  

✔ label variabili → RIDOTTE  
✔ rumore suggerimenti → RIDOTTO  

---

⚠ UI:

- input non multilinea  
- preview migliorabile  

---

⚠ DATA:

- nessuna gerarchia entity  
- nessuna normalizzazione  

---

⚠ TYPE:

- nessuna distinzione spesa/incasso  

------------------------------------------------
STATO ARCHITETTURA
------------------------------------------------

✔ stabile  
✔ coerente  
✔ funzionante  

---

✔ parsing affidabile  
✔ matching affidabile  
✔ label pipeline stabile  
✔ UX migliorata  

---

⚠ incompleta nei layer evolutivi

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01  
- documentazione architettura base  

v02 — 2026-04-03  
- integrazione parsing retrofit  
- integrazione matching step 2  

v03 — 2026-04-03  
- fix pipeline insert  
- supporto unit compatte  

v04 — 2026-04-04  
- introduzione label layer  
- integrazione label pipeline  
- miglioramento UX hint  
- gestione ambiguità input corto  