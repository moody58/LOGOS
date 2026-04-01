# 04_LOGOS_Retool_Architecture_v01

DATA: 2026-04-01

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Documentare l’architettura reale dell’interfaccia LOGOS
sviluppata in Retool.

Il documento descrive:

- struttura componenti
- organizzazione UI
- query e logica
- flussi operativi

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
- accesso processing

---

Contenuti:

INPUT:

campo libero

---

ESEMPI:

- 50 euro benzina
- vaccinazione Alfie
- crea progetto Villa

---

SUGGERIMENTI:

bottoni:

- registra spesa
- registra incasso
- registra tempo
- registra evento

---

ATTIVITÀ:

- contatore eventi NEW
- bottone "Gestisci eventi"

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

Comportamento:

visibile solo se input attivo

---

Preview:

MAIN:

- amount + unit + label

META:

- project
- entity

---

Select:

- type (evento default)
- project
- entity

------------------------------------------------
CONTAINER FEEDBACK
------------------------------------------------

Componenti:

- feedback_title
- feedback_resume

---

Funzione:

- conferma inserimento evento

---

Caratteristiche:

- non bloccante
- visibile ~3 secondi
- ritorno automatico a home

------------------------------------------------
CONTAINER EVENTS LIST
------------------------------------------------

Componenti:

- btn_back_home
- events_title
- list_events

---

Funzione:

- gestione eventi NEW

---

LIST VIEW:

per ogni evento:

- text_raw (input originale)
- text_meta (project/entity)
- text_date

---

AZIONI:

✔ WRITTEN  
✖ ERROR  

---

Comportamento:

- refresh immediato
- ordine: created_at DESC

------------------------------------------------
INPUT FLOW (RETOOL)
------------------------------------------------

input_home.onChange:

→ input_raw.setValue(input_home.value)

---

Principio:

input_home = source of truth

------------------------------------------------
CONFIRM FLOW
------------------------------------------------

Sequenza:

1. input_home.setValue("")
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

- projects_list (GET Supabase)
- entities_list (GET Supabase)

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

Esempio:

GET:

/rest/v1/projects

Parametri:

- select=id,name
- order=name

---

Utilizzo:

- popolamento select
- mapping frontend

------------------------------------------------
PATTERN ARCHITETTURALI
------------------------------------------------

✔ Adapter Pattern (input_raw)

✔ State-driven UI

✔ Progressive enhancement

✔ Frontend mapping

✔ Append-only interaction

------------------------------------------------
LIMITI TECNICI
------------------------------------------------

- ListView con scroll interno
- assenza repeater avanzato
- nessun controllo overflow fine

---

Decisione:

accettare limiti Retool

------------------------------------------------
PROBLEMI NOTI
------------------------------------------------

- parsing non affidabile
- matching non stabile
- preview migliorabile
- nessun editing eventi

------------------------------------------------
STATO ARCHITETTURA
------------------------------------------------

✔ stabile  
✔ coerente  
✔ funzionante  

---

⚠ incompleta nei layer logici

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01

- Documentazione completa architettura Retool
- Allineamento con implementazione reale
- Formalizzazione UI state e flow
- Consolidamento query e componenti