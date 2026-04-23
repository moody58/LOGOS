04_LOGOS_Retool_Architecture_v05

DATA: 2026-04-23

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- struttura UI completa  
- flow input → insert documentato  
- query e componenti allineati al runtime  
- label layer integrato  

Q (Qualità): 8.5/10  
- allineato ma non completamente aderente al runtime attuale  
- presenza logiche accoppiate (preview / parsing / state)  
- alcune parti non riflettono update flow reale   

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
  view: "home" | "feedback" | "events"
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
⚠ gestione centralizzata tramite handle_event_success  
⚠ rischio conflitti in presenza di trigger multipli  

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

- event_date + amount + unit + label  

---

HINT:

- basati su stato matching  

  - entity_matches > 1 → "Seleziona entità"  
  - project_matches > 1 → "Seleziona progetto"  

---

Caratteristiche:

✔ preview = rappresentazione dati reali  
✔ coerente con payload DB  
⚠ contiene logiche di derivazione (label + hint)
⚠ non è una view completamente pura    

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
⚠ possibile re-trigger parsing (loop reattivo)

---

Principio:

input_home = source of truth  

✔ input_raw utilizzato come fonte per parsing in preview e confirm  
✔ coerenza tra valore mostrato e valore persistito  

------------------------------------------------
MATCHING FLOW (AGGIORNATO STEP 2 + STEP 3)
------------------------------------------------

Eseguito tramite query:

- project_state
- entity_state

---

OUTPUT:

- project_state.data?.matches  
- entity_state.data?.matches  

---

LOGICA:

match = 1  
→ auto-select  

match > 1  
→ ambiguità  
→ nessuna selezione  

match = 0  
→ nessun suggerimento  

---

Caratteristiche:

✔ nessuna logica token esplicita  
✔ nessuna pipeline interna documentabile  
✔ matching gestito come stato osservabile   
⚠ presenza di più logiche di matching non unificate
⚠ possibili incoerenze tra preview e select 

------------------------------------------------
TYPE DETECTION (AGGIORNATO)
------------------------------------------------

Componente:

select1

---

Logica:

- Tempo → presenza unità parse_input (ore, minuti)
- Evento → default

---

Nota:

- rimosso fallback aggressivo su "h"
- evitati falsi positivi (es. "macchina")

------------------------------------------------
PARSING FLOW (RETROFIT v2)
------------------------------------------------

Eseguito in:

- parse_input (query)

Utilizzato da:

- preview
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

⚠ accoppiato alla UI tramite trigger reattivi
⚠ non isolato come layer indipendente

---

Nota:

preview = parsing reale  

------------------------------------------------
LABEL (RUNTIME)
------------------------------------------------

Eseguito in:

- sintesi (preview)

---

Caratteristiche:

✔ generata runtime  
✔ non persistita  
✔ non esiste come layer separato  

---

Operazioni:

- rimozione amount + unit (best-effort)
- rimozione date già parse
- normalizzazione spazi
- preservazione numeri semantici (es: "villa 2")

---

Nota:

✔ non riutilizzabile come modulo  
✔ parte della logica preview 
⚠ logica accoppiata alla preview
⚠ non riutilizzabile e non isolata 

------------------------------------------------
CONFIRM FLOW
------------------------------------------------

Sequenza:

1. insert_event / update_event  
2. gestione UI tramite handle_event_success  
3. feedback  
4. reset input e select  
5. ritorno automatico a home  

EDIT MODE:

- edit_mode = true → update_event  
- edit_mode = false → insert_event  

✔ distinzione runtime tra insert e update   

---

Obiettivo:

- evitare flicker
- mantenere fluidità  

✔ parsing eseguito in fase di confirm  
✔ allineamento completo con preview  
✔ eliminata divergenza tra preview e insert  
✔ payload coerente ai dati visualizzati 

VINCOLI:

✔ insert bloccato se:

- entity_matches > 1  
- project_matches > 1  

✔ nessuna ambiguità consentita in insert  

------------------------------------------------
QUERY ATTIVE
------------------------------------------------

GLOBAL:

- projects_list  
- entities_list  

---

PAGE1:

DATA / MATCHING:

- project_state  
- entity_state  
- parse_input  

---

EVENTI:

- insert_event  
- events_new  
- update_written  
- update_error  
- update_event  

---

STATE / UI:

- ui_state  
- typing_state  
- focus_input_home  

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
✔ Append-only controllato (editing su NEW)  

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

⚠ ARCHITETTURA:

- loop reattivo input ↔ parsing ↔ UI  
- accoppiamento layer  
- preview non completamente read-only  
- matching non unificato  

⚠ UI:

- gestione stato fragile (multi-trigger)  

------------------------------------------------
STATO ARCHITETTURA
------------------------------------------------

✔ funzionante  
✔ coerente  
⚠ non completamente stabile (reattività)    

---

✔ parsing affidabile  
⚠ matching funzionale ma non unificato 
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

v05 — 2026-04-23  

- introduzione update_event  
- introduzione edit_mode  
- aggiornamento confirm flow  
- centralizzazione UI state (handle_event_success)  
- aggiornamento append-only (controllato)  
- identificazione loop reattivo  
- allineamento architettura con runtime reale  