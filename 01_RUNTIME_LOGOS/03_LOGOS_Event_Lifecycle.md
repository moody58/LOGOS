# 03_LOGOS_Event_Lifecycle_v06

DATA: 2026-05-02

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- lifecycle attuale completo  
- stati, transizioni e responsabilità coperti  
- integrazione con input, normalization base, duration normalization, type classification, matching e processing esplicitata  
- update flow reale documentato  
- edit flow aggiornato con match state live  
- annulla modifica documentato
- no-op edit guard documentato
- distinzione edit reale / edit senza modifiche documentata
- lista eventi search/filter e label creato/modificato documentate come processing UX
- refresh lista dopo update documentato  
- fonti runtime di salvataggio chiarite  

Q (Qualità): 9.5/10  
- lifecycle coerente con sistema reale  
- append-only controllato chiarito  
- limiti storicizzazione / versioning esplicitati  
- distinzione tra correzione NEW e validazione WRITTEN mantenuta  
- chiarito che matching/type/duration migliorano qualità dati ma non validano l’evento  
- chiarito che Annulla non modifica evento e non aggiorna updated_at
- chiarito che edit senza modifiche reali non produce update_event
- nessuna anticipazione output/KPI  

D (Deployabilità): 10/10  
- documento stabile  
- utilizzabile come riferimento operativo  
- allineato al runtime Retool/Supabase attuale  
- create flow validato  
- edit flow validato  
- annulla modifica validato
- edit senza modifiche validato
- search/filter lista eventi validato
- WRITTEN / ERROR rivalidati dopo cleanup UX
- DB invariato

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
- annullamento modifica pre-validazione
- distinzione tra modifica reale e conferma senza variazioni
- rapporto tra input, normalization base, duration normalization, type classification, matching e processing
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
- possono uscire dall’edit mode senza modifiche tramite Annulla
- non vengono aggiornati se l’edit viene confermato senza cambiamenti reali
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
- normalizza durate certe ore/minuti
- classifica type a livello base
- propone matching project/entity
- blocca ambiguità project/entity non risolte
- non decide definitivamente

---

5. INPUT NON BLOCCANTE

Eventi imperfetti possono essere salvati.

La qualità viene migliorata progressivamente tramite:

- preview
- selezione manuale
- editing NEW
- normalization base
- duration normalization base
- type classification base
- match state project/entity
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
- può contenere durate certe normalizzate in minuti
- può contenere type base valorizzato
- può contenere project_id/entity_id derivati da select_project/select_entity
- può essere corretto tramite edit flow con match state live
- può uscire dall’edit flow tramite Annulla senza update_event
- può essere confermato in edit senza modifiche reali senza aggiornare updated_at
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
DURATION NORMALIZATION BASE  
↓  
TYPE CLASSIFICATION BASE  
↓  
MATCH STATE PROJECT/ENTITY  
↓  
SELECT PROJECT / ENTITY  
↓  
PREVIEW  
↓  
INSERT  
↓  
NEW  
↓  
EDIT opzionale  
↓  
UPDATE se modifica reale  
oppure  
ANNULLA senza update_event  
oppure  
CONFERMA senza modifiche → no-op  
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
- rilancia project_state / entity_state
- riallinea select_project / select_entity
- preserva project_id/entity_id salvati se presenti
- usa update_event solo se c’è una modifica reale
- mantiene status NEW
- aggiorna updated_at solo se c’è update_event
- può essere annullato senza update_event
- può essere confermato senza modifiche reali come no-op
- aggiorna lista eventi dopo save completato quando avviene update_event

---

Nota:

Il matching migliora la qualità,
ma NON modifica il lifecycle.

La normalization base, la duration normalization, la type classification base
e il match state migliorano la qualità strutturale dell’evento,
ma NON validano l’evento.

La validazione resta manuale.

---

ANNULLA MODIFICA:

- disponibile solo in edit mode
- usa btn_cancel_edit
- non esegue update_event
- non aggiorna updated_at
- resetta edit_mode
- resetta editing_event
- resetta input_home / input_raw
- resetta select_project / select_entity / select1
- resetta ui_state.parsed
- torna alla lista eventi NEW

---

NO-OP EDIT GUARD:

Se l’utente entra in edit mode e conferma senza modificare campi utente,
button_input_confirm non esegue update_event.

Campi confrontati:

- raw_input
- type
- project_id
- entity_id

Campi esclusi dal confronto:

- amount
- unit
- event_date

Motivo:

amount / unit / event_date sono derivati dal parser.
Una rielaborazione del parser non deve essere trattata come modifica utente.

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
- aggiorna type
- aggiorna project_id
- aggiorna entity_id
- project_id/entity_id derivano da select_project/select_entity
- select_project/select_entity sono alimentati da project_state/entity_state
- aggiorna updated_at

---

NEW → NEW (ANNULLA EDIT)

- azione: annulla modifica
- eseguita da utente
- runtime: btn_cancel_edit
- status invariato
- nessun update_event
- raw_input invariato
- amount invariato
- unit invariata
- event_date invariata
- type invariato
- project_id invariato
- entity_id invariato
- updated_at invariato
- ritorno alla lista eventi

---

NEW → NEW (EDIT NO-OP)

- azione: conferma edit senza modifiche reali
- eseguita da utente
- runtime: button_input_confirm con no-op edit guard
- status invariato
- nessun update_event
- raw_input invariato
- amount invariato
- unit invariata
- event_date invariata
- type invariato
- project_id invariato
- entity_id invariato
- updated_at invariato
- ritorno alla lista eventi

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
- annullare l’edit se non vuole salvare modifiche
- selezionare project/entity quando necessario
- risolvere ambiguità project/entity prima della conferma
- correggere manualmente type se la classificazione base non è sufficiente
- scartare errori
- confermare solo eventi ritenuti utilizzabili

---

Il sistema NON:

- valida automaticamente
- corregge automaticamente in modo semantico
- modifica eventi validati WRITTEN / ERROR
- decide definitivamente spesa/incasso
- decide definitivamente project/entity in caso di ambiguità
- decide qualità finale del dato

------------------------------------------------
QUALITÀ DEL DATO
------------------------------------------------

Dato in NEW dopo Normalization / Duration / Type / Match Base:

- amount/unit più coerenti
- formato numerico gestito
- numeri senza unità non salvati come amount
- durate certe ore/minuti salvate in minuti
- raw_input preservato
- type valorizzato a livello base
- project/entity più coerenti se match univoco o scelti manualmente
- ambiguità project/entity non risolta bloccata lato frontend
- nessun match project/entity consente salvataggio con project_id/entity_id null
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
- type/matching base aiutano ma non sostituiscono validazione e qualità dati avanzata

---

Dato normalizzato avanzato futuro:

- coerente
- standardizzato
- analizzabile
- eventualmente classificato
- eventualmente relazionato

------------------------------------------------
NORMALIZATION / DURATION / TYPE BASE NEL LIFECYCLE
------------------------------------------------

Il lifecycle attuale include ora più livelli di miglioramento dati
prima dell’inserimento o modifica dell’evento.

Normalizzazione implementata:

- amount
- unit
- event_date
- durate certe ore/minuti
- type base

---

Esempi:

1.500,50 euro  
→ amount 1500.5  
→ unit euro  

1ora lavoro  
→ amount 60  
→ unit minuti  
→ type Tempo  

1 ora e 15 minuti sopralluogo  
→ amount 75  
→ unit minuti  
→ type Tempo  

2h30 rendering  
→ amount 150  
→ unit minuti  
→ type Tempo  

20 euro spesa materiale  
→ amount 20  
→ unit euro  
→ type Spesa  

20 euro incasso cliente  
→ amount 20  
→ unit euro  
→ type Incasso  

villa 2 mario  
→ amount null  
→ unit null  
→ type Evento  

---

Regole:

- amount salvato come numero
- unit salvata come testo normalizzato
- raw_input preservato
- numeri senza unità non diventano amount
- durate certe ore/minuti salvate come minuti
- type salvato da select1.value
- nessuna modifica schema DB
- nessuna validazione automatica evento

---

Non implementato:

- giorni/settimane convertiti automaticamente
- giornata / mezza giornata
- parole numeriche tipo “due ore”
- forme colloquiali tipo “un paio d’ore”
- amount firmato
- direction field
- type classification avanzata
- retro-normalizzazione storico

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
- usa select1.value come fonte type
- usa project_state/entity_state come fonte minima matching
- usa select_project/select_entity come fonte project_id/entity_id

---

Create flow:

input_home  
→ input_raw  
→ trigger_parse_debounced  
→ parse_input_controlled  
→ ui_state.parsed  
→ project_state / entity_state  
→ select_project / select_entity  
→ select1  
→ button_input_confirm  
→ insert_event  
→ NEW   

---

Edit flow:

evento NEW selezionato  
→ editing_event  
→ edit_mode = true  
→ load raw_input  
→ input_home  
→ input_raw  
→ parse_input_controlled  
→ project_state / entity_state  
→ ui_state.parsed  
→ select_project / select_entity  
→ select1  
→ scelta utente  

Percorsi possibili:

1. Conferma con modifica reale:
button_input_confirm  
→ update_event  
→ events_new refresh  
→ NEW

2. Conferma senza modifiche reali:
button_input_confirm  
→ no-op edit guard  
→ nessun update_event  
→ NEW

3. Annulla:
btn_cancel_edit  
→ nessun update_event  
→ NEW  

Nota edit flow:

btn_edit rilancia anche project_state/entity_state.
Questo mantiene coerenti suggerimenti, select, hint e confirm guard
anche in modalità modifica evento.

Nota no-op:

Il sistema distingue edit reale da semplice apertura/conferma.
Questo evita aggiornamenti impropri di updated_at
e false label “modificato” nella lista eventi.

------------------------------------------------
INTEGRAZIONE CON MATCHING
------------------------------------------------

Il Match Engine First Controlled Level:

- riduce ambiguità in fase input
- migliora suggerimenti
- supporta selezione project/entity
- alimenta select_project/select_entity tramite singleMatch
- alimenta hint ambiguità tramite isAmbiguous
- alimenta highlight preview tramite matches
- può bloccare conferma se ci sono ambiguità project/entity non risolte

---

Fonte minima matching:

project_state  
entity_state  

Output:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

Regole:

match univoco  
→ select valorizzata  
→ conferma consentita  

match ambiguo non risolto  
→ select vuota  
→ hint rosso  
→ conferma bloccata  

match ambiguo risolto manualmente  
→ select valorizzata  
→ conferma consentita  

nessun match  
→ select vuota  
→ project_id/entity_id null  
→ conferma consentita  

---

Importante:

matching ≠ validazione

---

Il matching NON:

- cambia stato evento
- valida evento
- normalizza amount/unit/event_date
- decide type
- decide spesa/incasso
- crea project/entity automaticamente
- risolve ambiguità in modo silenzioso

---

Limiti:

- match engine avanzato separato non implementato
- fuzzy matching non implementato
- alias system non implementato
- entity/project hierarchy assente
- deduplicazione assente
- creazione guidata project/entity non implementata

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

Stato attuale:

- preview allineata visualmente a amount/unit/date
- preview allineata alla duration normalization base
- preview mostra type tramite select1
- preview legge project_state/entity_state per hint/highlight matching
- preview non è fonte del salvataggio
- preview resta layer ibrido

Limite attuale:

la preview non è ancora una view pura.

Restano embedded:

- label cleaning
- hint duration/type
- hint matching
- highlight
- formattazioni locali

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
- decide type
- decide project/entity
- risolve ambiguità
- crea project/entity automaticamente

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

Fonti runtime dei campi:

- amount / unit / event_date → ui_state.parsed
- type → select1.value
- project_id → select_project.value
- entity_id → select_entity.value
- raw_input → input_raw.value

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
NEW → NEW (EDIT con modifica reale)  
NEW → NEW (ANNULLA EDIT)  
NEW → NEW (EDIT NO-OP)  

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

---

Lista eventi dopo UX Cleanup:

La lista eventi NEW supporta ora:

- ricerca/filtro client-side
- label creato/modificato
- marcatore leggero per eventi modificati

La ricerca non modifica il lifecycle.

La label creato/modificato è UX di processing:

- non viene persistita
- non cambia status
- non valida evento
- non modifica DB

Regole label:

- evento mai modificato → creato
- evento modificato realmente → modificato
- edit annullato → resta creato/modificato come prima
- edit senza modifiche reali → resta creato/modificato come prima

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- editing limitato a eventi NEW
- nessuna correzione post-WRITTEN
- nessuna correzione post-ERROR
- nessun tracking storico modifiche
- no-op edit guard evita update non necessari ma non crea storico revisioni
- nessuna revisione batch
- assenza versioning modifiche
- update distruttivo su evento NEW solo quando avviene modifica reale
- dati storici non retro-normalizzati
- giorni/settimane non convertiti automaticamente
- type classification avanzata non implementata
- amount firmato non implementato
- direction field non implementato
- match engine avanzato separato non implementato
- alias system non implementato
- fuzzy matching non implementato
- project/entity hierarchy non implementata
- deduplicazione project/entity non implementata
- creazione guidata project/entity non implementata
- preview ancora layer ibrido
- output/KPI non attivi

------------------------------------------------
PROBLEMA STRUTTURALE
------------------------------------------------

La modifica eventi non è tracciata storicamente.

Conseguenze:

- update_event sovrascrive i valori precedenti
- updated_at mostra ultima modifica
- updated_at non cambia su Annulla
- updated_at non cambia su edit confermato senza modifiche reali
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
→ consente annulla modifica senza update_event
→ impedisce update_event su edit senza modifiche reali 
→ produce ui_state.parsed  

---

NORMALIZATION BASE

→ normalizza amount/unit  
→ non valida evento  
→ non cambia lifecycle  

---

MATCH ENGINE

→ migliora suggerimenti  
→ alimenta select_project/select_entity  
→ blocca conferma in caso di ambiguità non risolta  
→ non cambia stato  
→ non valida evento   

---

PREVIEW

→ visualizza interpretazione  
→ non salva  
→ non valida  

---

DATABASE

→ memorizza eventi  
→ viene aggiornato solo se l’edit produce una modifica reale
→ non interpreta  

---

ENGINE FUTURO

→ match engine avanzato  
→ alias / fuzzy / ranking controllato  
→ economic direction advanced  
→ data structure / entity relations  
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
2A. evitare aggiornamenti inutili se l’edit non cambia il dato
2B. permettere uscita sicura dall’edit senza salvare
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
✔ migliorato da duration normalization base  
✔ migliorato da type classification base  
✔ migliorato da match engine unification first controlled level  
✔ migliorato da UX / Cleanup Micro-Batch Post Match Engine
✔ edit mode ora supporta Annulla
✔ edit senza modifiche reali non aggiorna updated_at
✔ lista eventi distingue creato/modificato in modo più coerente

---

Ma:

⚠ non scalabile su revisioni  
⚠ non controlla qualità dato in modo assoluto  
⚠ editing introduce violazione controllata del modello append-only  
⚠ accettata per migliorare qualità dati prima della validazione  
⚠ non gestisce storico modifiche  
✔ distingue Spesa/Incasso/Tempo/Evento a livello base  
✔ normalizza durate certe ore/minuti  
⚠ non gestisce direzione economica avanzata  
⚠ non normalizza giorni/settimane  

---

Evoluzione necessaria:

solo dopo stabilizzazione:

1. input reliability ✔  
2. matching base ✔  
3. label quality ✔  
4. input stabilization ✔  
5. normalization layer base ✔  
6. preview alignment ✔  
7. duration normalization ✔  
8. type classification ✔  
9. match engine unification first controlled level ✔  
10. UX / cleanup post match engine ✔  
11. linting / state helper cleanup oppure accettazione residuo non bloccante  
12. data structure / project-entity evolution  
13. economic direction advanced  
14. output

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

v05 — 2026-05-02  

- integrazione Duration Normalization Base nel lifecycle
- integrazione Type Classification Base nel lifecycle
- integrazione Match Engine Unification First Controlled Level nel lifecycle
- aggiornato flow: input → parsing → normalization → duration → type → match state → select → preview → insert/update
- documentato type da select1.value
- documentato project_id da select_project.value
- documentato entity_id da select_entity.value
- documentato match state live in create/edit flow
- documentato btn_edit con rilancio project_state/entity_state
- documentato confirm guard su ambiguità project/entity non risolta
- chiarito che matching migliora qualità ma non valida evento
- chiarito che nessun match non blocca salvataggio
- chiarito che ambiguità risolta manualmente consente salvataggio
- aggiornati limiti: no alias, no fuzzy, no gerarchie, no deduplicazione, no creazione guidata project/entity
- confermato DB passivo
- confermato lifecycle invariato negli stati NEW / WRITTEN / ERROR
- nessun output/KPI anticipato

v06 — 2026-05-02  

- integrazione UX / Cleanup Micro-Batch Post Match Engine nel lifecycle
- documentato btn_cancel_edit
- documentato Annulla modifica come NEW → NEW senza update_event
- documentato reset edit_mode / editing_event / input / select / ui_state.parsed
- documentato no-op edit guard
- documentato edit senza modifiche reali come NEW → NEW senza update_event
- chiarito che updated_at non cambia su Annulla
- chiarito che updated_at non cambia su edit confermato senza modifiche reali
- documentata distinzione tra edit reale e conferma senza variazioni
- documentata label lista eventi creato/modificato
- documentato search/filter client-side lista eventi come processing UX
- chiarito che ricerca e label lista non modificano lifecycle
- WRITTEN / ERROR rivalidati dopo cleanup UX
- create/edit/lista/annulla/search validati
- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- nessun output/KPI anticipato