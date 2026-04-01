# 01_LOGOS_Event_Lifecycle_v01

DATA: 2026-04-01

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il ciclo di vita completo degli eventi
all’interno del sistema LOGOS.

Il documento stabilisce:

- stati evento
- transizioni
- responsabilità utente
- evoluzione futura del dato

------------------------------------------------
PRINCIPI FONDANTI
------------------------------------------------

1. EVENTO = UNITÀ BASE

Ogni informazione è registrata come evento.

---

2. APPEND-ONLY

Gli eventi:

- non vengono modificati
- non vengono sovrascritti
- mantengono storico completo

---

3. EVOLUZIONE PER STATO

Un evento evolve cambiando stato,
non modificando il contenuto.

---

4. DECISIONE UMANA

La validazione è sempre manuale.

------------------------------------------------
STATI EVENTO (ATTUALI)
------------------------------------------------

NEW

- stato iniziale
- evento appena inserito
- non validato

---

WRITTEN

- evento confermato
- considerato valido
- utilizzabile

---

ERROR

- evento annullato
- non valido
- escluso

------------------------------------------------
FLUSSO ATTUALE
------------------------------------------------

INPUT
↓
INSERT
↓
NEW
↓
DECISIONE UTENTE

→ WRITTEN  
→ ERROR

------------------------------------------------
TRANSIZIONI CONSENTITE
------------------------------------------------

NEW → WRITTEN

- azione: conferma
- eseguita da utente

---

NEW → ERROR

- azione: annullamento
- eseguita da utente

---

Transizioni NON consentite:

- WRITTEN → NEW
- ERROR → NEW

------------------------------------------------
RESPONSABILITÀ UTENTE
------------------------------------------------

L’utente deve:

- validare eventi
- scartare errori
- garantire qualità finale dato

---

Il sistema NON:

- valida automaticamente
- corregge automaticamente

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- nessun editing evento
- nessuna correzione dati
- nessun stato intermedio
- nessun tracciamento modifiche

------------------------------------------------
PROBLEMA STRUTTURALE
------------------------------------------------

Lo stato NEW contiene eventi:

- incompleti
- ambigui
- non normalizzati

---

WRITTEN assume:

- validità implicita
- anche se dato non perfetto

------------------------------------------------
ESTENSIONE FUTURA (NON ATTIVA)
------------------------------------------------

STATI AGGIUNTIVI PREVISTI:

DRAFT

- evento salvato ma incompleto

---

TO_REVIEW

- evento ambiguo
- richiede verifica

---

NORMALIZED

- evento pulito e coerente

---

LINKED

- evento associato correttamente
  a project/entity

---

ARCHIVED

- evento consolidato

------------------------------------------------
LIFECYCLE FUTURO (MODELLO)
------------------------------------------------

INPUT
↓
DRAFT
↓
TO_REVIEW
↓
WRITTEN
↓
NORMALIZED
↓
ARCHIVED

---

Nota:

Questo flusso NON è implementato attualmente.

------------------------------------------------
PRINCIPIO DI QUALITÀ DEL DATO
------------------------------------------------

Dato in NEW:

- non affidabile

Dato in WRITTEN:

- validato
- ma non necessariamente normalizzato

Dato normalizzato (futuro):

- coerente
- utilizzabile per analisi

------------------------------------------------
INTERAZIONE CON ALTRI LAYER
------------------------------------------------

INPUT SYSTEM

→ genera eventi NEW

---

MATCH ENGINE

→ aiuta a ridurre ambiguità

---

ENGINE (futuro)

→ normalizza dati

---

OUTPUT (futuro)

→ usa solo dati affidabili

------------------------------------------------
OBIETTIVO LIFECYCLE
------------------------------------------------

Trasformare eventi:

da:

→ input grezzo

a:

→ dato affidabile e analizzabile

------------------------------------------------
VINCOLI OPERATIVI
------------------------------------------------

- non modificare struttura attuale
- non introdurre stati senza necessità
- mantenere semplicità

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il lifecycle attuale è:

✔ semplice  
✔ stabile  

---

Ma:

⚠ limitato  
⚠ non scalabile  

---

Evoluzione necessaria:

solo dopo stabilizzazione input

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01

- Definizione lifecycle eventi attuale
- Identificazione limiti strutturali
- Definizione modello evolutivo futuro
- Allineamento con architettura append-only