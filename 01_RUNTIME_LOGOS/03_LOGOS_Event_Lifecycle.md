# 03_LOGOS_Event_Lifecycle_v04

DATA: 2026-04-30

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- lifecycle attuale completo  
- stati, transizioni e responsabilità coperti  
- integrazione con input, normalization base, matching e processing esplicitata  
- update flow reale documentato  
- refresh lista dopo update documentato  

Q (Qualità): 9/10  
- lifecycle coerente con sistema reale  
- append-only controllato chiarito  
- limiti storicizzazione / versioning esplicitati  
- distinzione tra correzione NEW e validazione WRITTEN mantenuta  

D (Deployabilità): 10/10  
- documento stabile  
- utilizzabile come riferimento operativo  
- allineato al runtime Retool/Supabase attuale  

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
- correzione pre-validazione
- rapporto tra input, normalization base e processing
- evoluzione futura

------------------------------------------------
PRINCIPI FONDANTI
------------------------------------------------

1. EVENTO = UNITÀ BASE

Ogni informazione è registrata come evento.

---

2. APPEND-ONLY CONTROLLATO

Gli eventi:

- sono append-only dopo validazione
- possono essere modificati in stato NEW
- mantengono raw_input come memoria dell’input utente
- non mantengono ancora storico revisioni

---

3. EVOLUZIONE PER STATO + CORREZIONE PRE-VALIDAZIONE

Un evento:

- nasce in stato NEW
- può essere corretto mentre è NEW
- viene validato manualmente
- evolve verso WRITTEN o ERROR

---

4. DECISIONE UMANA

La validazione è sempre manuale.

Il sistema:

- suggerisce
- struttura
- normalizza dati base
- non decide definitivamente

---

5. INPUT NON BLOCCANTE

Eventi imperfetti possono essere salvati.

La qualità viene migliorata progressivamente tramite:

- preview
- selezione manuale
- editing NEW
- normalization base
- processing manuale

------------------------------------------------
STATI EVENTO ATTUALI
------------------------------------------------

NEW

- stato iniziale
- evento appena inserito
- non validato
- può contenere errori o ambiguità
- modificabile
- può essere normalizzato base in insert/update
- resta sotto controllo utente

---

WRITTEN

- evento confermato
- considerato valido dall’utente
- utilizzabile
- non modificabile nel lifecycle attuale
- non necessariamente perfetto dal punto di vista semantico

---

ERROR

- evento annullato
- non valido
- escluso dal flusso operativo
- non modificabile nel lifecycle attuale

------------------------------------------------
FLUSSO ATTUALE
------------------------------------------------

INPUT  
↓  
PARSE CONTROLLED  
↓  
NORMALIZATION BASE  
↓  
MATCH  
↓  
PREVIEW  
↓  
INSERT  
↓  
NEW  
↓  
EDIT opzionale  
↓  
UPDATE  
↓  
NEW  
↓  
DECISIONE UTENTE  

→ WRITTEN  
→ ERROR  

---

EDIT:

- modifica evento esistente
- disponibile solo per eventi NEW
- riuso pipeline input
- usa parse_input_controlled
- usa ui_state.parsed
- usa update_event
- mantiene status NEW
- aggiorna updated_at
- aggiorna lista eventi dopo save completato

---

Nota:

Il matching migliora la qualità,
ma NON modifica il lifecycle.

La normalization base migliora la qualità strutturale,
ma NON valida l’evento.

------------------------------------------------
TRANSIZIONI CONSENTITE
------------------------------------------------

NEW → NEW (EDIT)

- azione: modifica evento
- eseguita da utente
- runtime: update_event
- status invariato
- aggiorna raw_input
- aggiorna amount
- aggiorna unit
- aggiorna event_date
- aggiorna project_id
- aggiorna entity_id
- aggiorna updated_at

---

NEW → WRITTEN

- azione: conferma / scrittura
- eseguita da utente
- evento considerato valido

---

NEW → ERROR

- azione: annullamento / scarto
- eseguita da utente
- evento escluso

---

Transizioni NON consentite:

- WRITTEN → NEW
- ERROR → NEW
- WRITTEN → ERROR
- ERROR → WRITTEN
- WRITTEN → EDIT
- ERROR → EDIT

------------------------------------------------
RESPONSABILITÀ UTENTE
------------------------------------------------

L’utente deve:

- validare eventi
- correggere tramite editing o selezione
- selezionare project/entity quando necessario
- scartare errori
- confermare solo eventi ritenuti utilizzabili

---

Il sistema NON:

- valida automaticamente
- corregge automaticamente in modo semantico
- modifica eventi validati WRITTEN / ERROR
- decide spesa/incasso
- decide qualità finale del dato

------------------------------------------------
QUALITÀ DEL DATO
------------------------------------------------

Dato in NEW:

- non affidabile in modo definitivo
- può essere ambiguo
- può essere incompleto
- può essere corretto
- può contenere dati normalizzati base
- non è ancora validato dall’utente

---

Dato in NEW dopo Normalization Layer Base:

- amount/unit più coerenti
- formato numerico gestito
- numeri senza unità non salvati come amount
- raw_input preservato
- project/entity ancora soggetti ad ambiguità
- type ancora non affidabile

---

Dato in WRITTEN:

- validato manualmente
- utilizzabile
- non necessariamente normalizzato semanticamente
- non necessariamente pronto per KPI evoluti

---

Dato normalizzato avanzato futuro:

- coerente
- standardizzato
- analizzabile
- eventualmente classificato
- eventualmente relazionato

------------------------------------------------
NORMALIZATION BASE NEL LIFECYCLE
------------------------------------------------

Il lifecycle attuale include ora un primo livello di normalizzazione base
prima dell’inserimento o modifica dell’evento.

Normalizzazione implementata:

- amount
- unit
- event_date preservato

---

Esempi:

1.500,50 euro  
→ amount 1500.5  
→ unit euro  

1ora lavoro  
→ amount 1  
→ unit ore  

villa 2 mario  
→ amount null  
→ unit null  

---

Regole:

- amount salvato come numero
- unit salvata come testo normalizzato
- raw_input preservato
- numeri senza unità non diventano amount
- nessuna modifica schema DB
- nessuna classificazione semantica

---

Non implementato:

- 1 ora e 15 minuti
- 2h30
- 2 giorni rendering
- spesa/incasso
- type classification base
- matching unificato

------------------------------------------------
INTEGRAZIONE CON INPUT SYSTEM
------------------------------------------------

INPUT SYSTEM:

- genera eventi NEW
- consente modifica eventi NEW
- usa input_home come input utente
- usa input_raw come adapter tecnico
- usa parse_input_controlled come parser runtime
- usa ui_state.parsed come fonte unica dei dati strutturati

---

Create flow:

input_home  
→ input_raw  
→ parse_input_controlled  
→ ui_state.parsed  
→ button_input_confirm  
→ insert_event  
→ NEW  

---

Edit flow:

evento NEW selezionato  
→ load raw_input  
→ input_home  
→ input_raw  
→ parse_input_controlled  
→ ui_state.parsed  
→ button_input_confirm  
→ update_event  
→ NEW  

------------------------------------------------
INTEGRAZIONE CON MATCHING
------------------------------------------------

Il Match Engine:

- riduce ambiguità in fase input
- migliora suggerimenti
- supporta selezione project/entity
- può bloccare conferma se ci sono match multipli

---

Importante:

matching ≠ validazione

---

Il matching NON:

- cambia stato evento
- valida evento
- normalizza evento
- decide type
- decide spesa/incasso

---

Limiti:

- matching non ancora unificato
- priority match non implementato
- entity hierarchy assente

------------------------------------------------
INTEGRAZIONE CON PREVIEW
------------------------------------------------

La preview:

- mostra dati parsati
- mostra dati normalizzati base
- mostra label runtime
- mostra project/entity
- mostra hint
- aiuta l’utente prima della conferma

---

La preview NON:

- modifica DB
- valida evento
- cambia stato
- è fonte del salvataggio

---

Fonte dati strutturata condivisa:

ui_state.parsed

---

Limite attuale:

La preview non è ancora pienamente allineata alla normalizzazione base
sul piano visuale.

Esempio:

dato interno:

1500.5 euro

visualizzazione desiderata futura:

1.500,50 €

------------------------------------------------
INTEGRAZIONE CON DATABASE
------------------------------------------------

Database:

Supabase

Tabelle principali:

- events
- projects
- entities

---

Ruolo DB:

- persistenza eventi
- persistenza stato
- fetch lista eventi
- update status
- update eventi NEW

---

Il database NON:

- interpreta input
- normalizza
- valida
- decide stato
- gestisce semantica
- mantiene storico revisioni

---

Campi evento principali:

- id
- created_at
- event_date
- project_id
- entity_id
- type
- amount
- unit
- raw_input
- payload
- status
- updated_at

------------------------------------------------
INTEGRAZIONE CON PROCESSING
------------------------------------------------

Lista eventi NEW:

events_new

---

Query:

events?select=*&status=eq.NEW&order=updated_at.desc.nullslast,created_at.desc

---

Azioni:

NEW → WRITTEN  
NEW → ERROR  
NEW → NEW (EDIT)  

---

Dopo insert/update:

button_input_confirm attende il completamento del salvataggio
e poi aggiorna events_new.

Ordine corretto:

savePromise  
→ await savePromise  
→ await events_new.trigger()  

---

Problema risolto:

Prima:

- update_event aggiornava correttamente il DB
- events_new veniva aggiornato troppo presto
- la lista mostrava temporaneamente il dato vecchio
- refresh pagina mostrava il dato corretto

Dopo:

- lista aggiornata subito dopo update
- nessun refresh pagina necessario

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- editing limitato a eventi NEW
- nessuna correzione post-WRITTEN
- nessuna correzione post-ERROR
- nessun tracking storico modifiche
- nessuna revisione batch
- assenza versioning modifiche
- update distruttivo su evento NEW
- dati storici non retro-normalizzati
- type non affidabile
- spesa/incasso non implementati
- duration normalization non implementata
- matching non unificato

------------------------------------------------
PROBLEMA STRUTTURALE
------------------------------------------------

La modifica eventi non è tracciata storicamente.

Conseguenze:

- update_event sovrascrive i valori precedenti
- updated_at mostra ultima modifica
- raw_input mostra ultima versione
- non esiste audit trail revisioni
- non esiste event_version
- non esiste history table

---

NEW contiene eventi:

- non validati
- non necessariamente completi
- potenzialmente ambigui
- parzialmente normalizzati

---

WRITTEN:

- assume validità umana
- non garantisce qualità dati assoluta
- non garantisce normalizzazione avanzata
- non garantisce classificazione corretta

------------------------------------------------
ESTENSIONE FUTURA NON ATTIVA
------------------------------------------------

STATI POSSIBILI:

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

---

REVISIONED

- evento con storico modifiche

------------------------------------------------
LIFECYCLE FUTURO MODELLO
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
LINKED  
↓  
ARCHIVED  

---

Con storico revisioni:

NEW  
↓  
EDIT  
↓  
REVISIONED  
↓  
WRITTEN  

---

Nota:

NON implementato attualmente.

------------------------------------------------
INTERAZIONE CON ALTRI LAYER
------------------------------------------------

INPUT SYSTEM

→ genera eventi NEW  
→ consente modifica eventi NEW  
→ produce ui_state.parsed  

---

NORMALIZATION BASE

→ normalizza amount/unit  
→ non valida evento  
→ non cambia lifecycle  

---

MATCH ENGINE

→ migliora suggerimenti  
→ non cambia stato  

---

PREVIEW

→ visualizza interpretazione  
→ non salva  
→ non valida  

---

DATABASE

→ memorizza eventi  
→ non interpreta  

---

ENGINE FUTURO

→ normalizza durate  
→ classifica tipi  
→ migliora confrontabilità dati  

---

OUTPUT FUTURO

→ utilizza dati affidabili  
→ richiede normalizzazione sufficiente  

------------------------------------------------
OBIETTIVO LIFECYCLE
------------------------------------------------

Trasformare eventi:

da input grezzo  
a dato affidabile  

---

Senza bloccare l’utente.

---

Strategia:

1. salvare velocemente
2. correggere in NEW
3. normalizzare progressivamente
4. validare manualmente
5. usare per output solo quando sufficientemente affidabile

------------------------------------------------
VINCOLI OPERATIVI
------------------------------------------------

- non modificare struttura stati senza nodo dedicato
- non introdurre stati inutili
- mantenere semplicità
- non modificare eventi WRITTEN/ERROR
- non introdurre versioning senza decisione architetturale
- non usare dati non affidabili per KPI evoluti
- non confondere normalization base con validazione

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il lifecycle attuale è:

✔ semplice  
✔ stabile  
✔ coerente con append-only controllato  
✔ compatibile con uso reale  
✔ migliorato da editing NEW  
✔ migliorato da normalization base  

---

Ma:

⚠ non scalabile su revisioni  
⚠ non controlla qualità dato in modo assoluto  
⚠ editing introduce violazione controllata del modello append-only  
⚠ accettata per migliorare qualità dati prima della validazione  
⚠ non gestisce storico modifiche  
⚠ non distingue ancora spesa/incasso  
⚠ non normalizza durate complesse  

---

Evoluzione necessaria:

solo dopo stabilizzazione:

1. input reliability ✔  
2. matching base ✔  
3. label quality ✔  
4. input stabilization ✔  
5. normalization layer base ✔  
6. preview alignment  
7. duration normalization  
8. type classification  
9. output  

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

v03 — 2026-04-23  

- introduzione editing eventi (NEW → NEW)
- aggiornamento modello append-only controllato
- introduzione update_event
- aggiornamento responsabilità utente
- allineamento lifecycle con sistema reale

v04 — 2026-04-30  

- integrazione Normalization Layer Base nel lifecycle
- chiarito che normalization base non equivale a validazione
- documentato uso di ui_state.parsed in create/edit
- aggiornato create flow con parse_input_controlled
- aggiornato edit flow con update_event e ui_state.parsed
- documentato refresh events_new dopo save completato
- documentata correzione race condition update → lista
- esplicitati limiti: no versioning, no duration normalization, no type classification