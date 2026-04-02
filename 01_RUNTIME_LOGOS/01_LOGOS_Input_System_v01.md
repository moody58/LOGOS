# 01_LOGOS_Input_System_v02

DATA: 2026-04-02

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il comportamento operativo completo
del sistema di input LOGOS.

Il documento è utilizzato per:

- implementazione Retool
- sviluppo parsing
- gestione preview
- controllo qualità input

------------------------------------------------
PRINCIPI FONDANTI
------------------------------------------------

1. INPUT NON BLOCCANTE

L’utente deve sempre poter inserire un evento.

---

2. SALVARE > CORREGGERE

È preferibile salvare un dato imperfetto
piuttosto che bloccare l’inserimento.

---

3. MIGLIORAMENTO PROGRESSIVO

La qualità del dato viene migliorata nel tempo,
non imposta all’ingresso.

---

4. UTENTE NON TECNICO

Il sistema deve essere comprensibile senza formazione.

---

5. SUGGERIRE ≠ DECIDERE

Il sistema suggerisce, l’utente decide.

------------------------------------------------
ARCHITETTURA INPUT
------------------------------------------------

COMPONENTI:

input_home
→ input utente (source of truth)

input_raw
→ derivato tecnico per parsing

---

FLOW:

input_home
→ sync
→ input_raw
→ parsing
→ preview
→ conferma
→ insert_event

------------------------------------------------
INPUT_HOME
------------------------------------------------

Ruolo:

- campo principale di input
- visibile all’utente

Caratteristiche:

- libero
- senza vincoli formali
- accetta qualsiasi testo

---

Regole:

✔ sempre modificabile  
✔ sempre attivo  
✔ non validato  

------------------------------------------------
INPUT_RAW
------------------------------------------------

Ruolo:

- adapter tecnico
- base per parsing

---

Caratteristiche:

- hidden
- derivato da input_home
- non modificato direttamente

---

Sync:

input_home → input_raw

------------------------------------------------
PARSING SYSTEM
------------------------------------------------

FUNZIONE:

estrarre informazioni utili dall’input

---

TIPO:

best-effort

---

OUTPUT:

- amount
- unit
- label

---

REGOLE:

✔ parsing non blocca  
✔ parsing può fallire  
✔ parsing può essere parziale  

---

CASI:

✔ parsing corretto  
✔ parsing incompleto  
✔ parsing errato  

Tutti validi

------------------------------------------------
PARSING UNITÀ (CRITICO)
------------------------------------------------

Unità supportate:

- euro
- minuti
- ore

---

RICONOSCIMENTO UNITÀ (UPDATED)

euro:

- €
- euro
- eur
- €20 / 20€ / € 20

---

tempo:

ore:
- ora
- ore
- h
- 2h / h2 / 2 h

minuti:
- min
- minuti
- 30min / min30 / 30 min

---

NORMALIZZAZIONE INPUT (RUNTIME)

Applicata solo nel layer parsing.

Operazioni:

- separazione simboli (€)
- separazione unit compatte (2h → 2 h)
- pulizia spazi

---

ESEMPI:

2h30 → 2 h 30  
€20 → € 20  

---

IMPORTANTE:

✔ non modifica input utente  
✔ usata solo per parsing interno  

GESTIONE ORARI

Formati:

HH:MM

---

COMPORTAMENTO:

✔ NON considerati amount  
✔ NON considerati unit  
✔ mantenuti come testo  

---

ESEMPIO:

"15:30 test" → label = "15:30 test"

------------------------------------------------
ESTRAZIONE AMOUNT (UPDATED — RETROFIT v2)
------------------------------------------------

Regola:

estrarre il numero più rilevante rispetto alla unità rilevata

---

STRATEGIA:

- identificazione di tutti i numeri presenti
- identificazione della posizione della unità
- selezione del numero con distanza minima dalla unità

---

ESEMPI:

"pizza 20 euro" → 20  
"2 ore lavoro" → 2  
"2 ore 30" → 2  

---

FORMATI SUPPORTATI:

- interi
- decimali (.,)

---

NOTE:

✔ supporto multi-numero (selezione per prossimità)  
✔ parsing deterministico  
✔ no interpretazione semantica  

---

LIMITI:

- multi-unit NON supportato
- numeri secondari trattati come label

------------------------------------------------
LABEL CLEANING
------------------------------------------------

Funzione:

ottenere descrizione pulita

---

Operazioni:

- rimozione numero
- rimozione unità
- rimozione preposizioni comuni

---

Preposizioni rimosse:

- di
- del
- della
- dei
- degli
- delle
- per
- e

---

Output:

label sintetica

------------------------------------------------
TYPE DETECTION (BASE)
------------------------------------------------

Tipi:

- tempo
- economico
- evento

---

Regole:

tempo:

→ presenza unità tempo

economico:

→ presenza euro

evento:

→ default

---

IMPORTANTE:

economico NON distingue:

- spesa
- incasso

→ decisione utente

------------------------------------------------
PREVIEW SYSTEM
------------------------------------------------

FUNZIONE:

mostrare interpretazione sistema

---

STRUTTURA:

MAIN:

amount + unit + label

---

META:

project  
entity  

---

HINT:

suggerimenti matching

---

REGOLE:

✔ preview non blocca  
✔ preview può essere errata  
✔ preview non modifica input  

------------------------------------------------
MATCHING BASE
------------------------------------------------

Oggetti:

- projects
- entities

---

STRATEGIA:

- includes
- normalizzazione base

---

OUTPUT:

✔ suggerimento  
✔ auto-select solo se univoco  

---

REGOLE:

✔ mai forzare selezione  
✔ mai creare automaticamente  

------------------------------------------------
CONFIRMA EVENTO
------------------------------------------------

AZIONE:

utente conferma inserimento

---

SEQUENZA:

1. reset input_home  
2. switch UI feedback  
3. insert_event  
4. refresh eventi  
5. reset select  
6. ritorno home  

---

REGOLE:

✔ insert sempre consentito  
✔ nessun blocco  

------------------------------------------------
GESTIONE ERRORI
------------------------------------------------

TIPI:

- parsing error
- match error
- input ambiguo

---

COMPORTAMENTO:

✔ NON bloccare  
✔ NON interrompere  
✔ mostrare feedback implicito  

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- parsing incompleto
- unità limitate
- matching debole
- nessun comando input
- nessuna normalizzazione avanzata

------------------------------------------------
OBIETTIVO INPUT SYSTEM
------------------------------------------------

Rendere l’input:

- veloce
- comprensibile
- sufficientemente affidabile

---

NON:

- perfetto
- completamente automatico

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01

- Definizione completa sistema input
- Consolidamento parsing, preview, matching
- Allineamento con implementazione Retool
- Definizione regole operative vincolanti