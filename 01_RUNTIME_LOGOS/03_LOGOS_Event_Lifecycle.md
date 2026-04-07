03_LOGOS_Event_Lifecycle_v02

DATA: 2026-04-03

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- lifecycle attuale completo  
- stati, transizioni e responsabilità coperti  
- integrazione con altri layer esplicitata  

Q (Qualità): 9.5/10  
- terminologia coerente  
- distinzione chiara tra stato attuale e futuro  
- allineamento con runtime reale  

D (Deployabilità): 10/10  
- documento stabile  
- utilizzabile come riferimento operativo  

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il ciclo di vita completo degli eventi
all’interno del sistema LOGOS.

Il documento stabilisce:

- stati evento
- transizioni
- responsabilità utente
- qualità del dato
- evoluzione futura

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

---

5. INPUT NON BLOCCANTE

Eventi imperfetti possono essere salvati.

------------------------------------------------
STATI EVENTO (ATTUALI)
------------------------------------------------

NEW

- stato iniziale
- evento appena inserito
- non validato
- può contenere errori o ambiguità

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
PARSE + MATCH  
↓  
PREVIEW  
↓  
INSERT  
↓  
NEW  
↓  
DECISIONE UTENTE  

→ WRITTEN  
→ ERROR  

---

Nota:

Il matching migliora la qualità,
ma NON modifica il lifecycle.

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
- WRITTEN → ERROR (attualmente non previsto)

------------------------------------------------
RESPONSABILITÀ UTENTE
------------------------------------------------

L’utente deve:

- validare eventi
- correggere tramite scelta (non editing)
- scartare errori

---

Il sistema NON:

- valida automaticamente
- corregge automaticamente
- modifica dati salvati

------------------------------------------------
QUALITÀ DEL DATO
------------------------------------------------

Dato in NEW:

- non affidabile
- può essere ambiguo
- può essere incompleto

---

Dato in WRITTEN:

- validato manualmente
- utilizzabile
- NON necessariamente normalizzato

---

Dato normalizzato (futuro):

- coerente
- standardizzato
- analizzabile

------------------------------------------------
INTEGRAZIONE CON MATCHING
------------------------------------------------

Il Match Engine:

- riduce ambiguità in fase input
- migliora suggerimenti
- NON cambia stato evento

---

Importante:

matching ≠ validazione

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- nessun editing evento
- nessuna correzione post-insert
- nessun stato intermedio
- nessun tracking modifiche
- nessuna revisione batch

------------------------------------------------
PROBLEMA STRUTTURALE
------------------------------------------------

NEW contiene eventi:

- non normalizzati
- non verificati
- potenzialmente incoerenti

---

WRITTEN:

- assume validità
- ma non garantisce qualità dati

------------------------------------------------
ESTENSIONE FUTURA (NON ATTIVA)
------------------------------------------------

STATI PREVISTI:

DRAFT

- evento incompleto

---

TO_REVIEW

- evento ambiguo

---

NORMALIZED

- evento pulito

---

LINKED

- relazioni corrette

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

NON implementato attualmente

------------------------------------------------
INTERAZIONE CON ALTRI LAYER
------------------------------------------------

INPUT SYSTEM

→ genera eventi NEW

---

MATCH ENGINE

→ migliora suggerimenti

---

DATABASE

→ memorizza eventi

---

ENGINE (futuro)

→ normalizza dati

---

OUTPUT (futuro)

→ utilizza dati affidabili

------------------------------------------------
OBIETTIVO LIFECYCLE
------------------------------------------------

Trasformare eventi:

da input grezzo  
a dato affidabile  

---

senza bloccare l’utente

------------------------------------------------
VINCOLI OPERATIVI
------------------------------------------------

- non modificare struttura attuale
- non introdurre stati inutili
- mantenere semplicità

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il lifecycle attuale è:

✔ semplice  
✔ stabile  
✔ coerente con append-only  

---

Ma:

⚠ non scalabile  
⚠ non controlla qualità dato  

---

Evoluzione necessaria:

solo dopo stabilizzazione:

1. input  
2. matching  
3. label quality  

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01  
- definizione lifecycle base  

v02 — 2026-04-03  
- integrazione matching layer  
- chiarita separazione matching / lifecycle  
- esplicitata qualità dato  
- allineamento con stato reale sistema