04_LOGOS_Retool_Architecture_v02

DATA: 2026-04-03

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- struttura UI completa  
- flow input → insert documentato  
- query e componenti allineati al runtime  

Q (Qualità): 9.5/10  
- allineato a comportamento reale aggiornato  
- distinzione chiara tra layer  
- eliminati elementi obsoleti  

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

------------------------------------------------
INPUT FLOW (AGGIORNATO)
------------------------------------------------

input_home.onChange:

→ input_raw.setValue(input_home.value)  
→ typing_state.trigger()

---

Principio:

input_home = source of truth

------------------------------------------------
MATCHING FLOW (AGGIORNATO STEP 2)
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

---

Nota:

preview = parsing reale

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

---

⚠ UI:

- input non multilinea  
- preview verbosa  

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
- aggiornamento type detection  
- allineamento completo con runtime reale  