# 00_PROJECT_Roadmap_v14

DATA: 2026-05-18

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire la sequenza operativa vincolante
per lo sviluppo del sistema LOGOS.

La roadmap:

- guida lo sviluppo
- stabilisce priorità
- previene deriva
- definisce ordine corretto delle fasi

---

La roadmap è:

✔ operativa  
✔ aggiornata nel tempo  
✔ dipendente dallo stato reale  

---

NON è:

❌ strategica (ruolo della Regia)  
❌ descrittiva (ruolo dello State)  

------------------------------------------------
PRINCIPIO FONDANTE
------------------------------------------------

SVILUPPO SEQUENZIALE VINCOLATO

---

Ogni fase:

- deve essere completata
- deve essere validata
- non può essere saltata

---

Divieto:

- lavorare su più fasi contemporaneamente
- anticipare output prima di dati coerenti
- introdurre engine avanzato senza base stabile
- anticipare istanze verticali prima del Core Event System stabile
- trasformare LOGOS in gestionale monolitico o verticale prima del consolidamento core

------------------------------------------------
PRINCIPIO STRATEGICO OPERATIVO
------------------------------------------------

LOGOS evolve come Core Event System modulare.

Il cuore operativo resta:

INPUT
→ interpretazione controllata
→ project / entity / type / amount / date
→ evento normalizzato
→ ledger eventi
→ viste / moduli / dashboard futuri

Le istanze ASPRI / ADEXIMA / MaurizioLab sono derivate future del core,
non nodi da anticipare ora.

La Roadmap deve quindi preservare questa sequenza:

1. consolidare cuore eventi
2. consolidare project/entity
3. rifinire UX mobile base
4. introdurre command intent guidato
5. consolidare UI readiness / visibility del flow input
6. consolidare preview / hint / input analysis
7. consolidare data structure / relazioni / qualità dati
8. solo dopo aprire viste, dashboard operative, istanze o moduli verticali

Nota post UI Readiness:

Il consolidamento UI Readiness / Visibility Aggregator è stato completato a primo livello controllato.

Questo NON equivale a Input Analysis Model completo.

La direzione futura resta:

- UI Readiness / Visibility Aggregator → completato a primo livello
- Input Analysis Model / Single Interpretation Layer → futuro, non attivo
- Event Interpretation Engine / Multi-source Input → futuro avanzato, non attivo

Divieto operativo:

- non aprire dashboard ASPRI
- non aprire CRM ADEXIMA
- non aprire gestione MaurizioLab
- non aprire moduli animali / allevamento
- non aprire moduli fatture / preventivi
- non aprire moduli clienti avanzati

prima che il Core Event System sia sufficientemente stabile.

------------------------------------------------
STATO ATTUALE
------------------------------------------------

FASE COMPLETATA:

✔ STEP 1 — INPUT RELIABILITY (STABILIZZATO)  
✔ STEP 2 — MATCHING BASE (STABILE)  
✔ STEP 3 — LABEL QUALITY (COMPLETATO)  
✔ STEP 3.5 — STRUCTURE STABILIZATION (COMPLETATO)  
✔ STEP 4 — EVENT EDITING (COMPLETATO)  
✔ STEP 6.1 — ENGINE BASE / NORMALIZATION LAYER BASE (COMPLETATO)  
✔ PREVIEW ALIGNMENT BASE (COMPLETATO)  
✔ STEP 6.2 — ENGINE BASE / DURATION NORMALIZATION (COMPLETATO)  
✔ STEP 6.3 — ENGINE BASE / TYPE CLASSIFICATION BASE (COMPLETATO)
✔ STEP 6.4 — MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL (COMPLETATO)  
✔ UX / CLEANUP MICRO-BATCH POST MATCH ENGINE (COMPLETATO) 
✔ LINTING / STATE HELPER CLEANUP (COMPLETATO) 
✔ PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL (COMPLETATO)
✔ UX MOBILE COHERENCE PASS (COMPLETATO)
✔ COMMAND INTENT — CREATE PROJECT / ENTITY (COMPLETATO)
✔ UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL (COMPLETATO)

---

FASE ATTIVA CONSIGLIATA:

AGGIORNAMENTO DOCUMENTALE POST UI READINESS / VISIBILITY AGGREGATOR

---

FASE SUCCESSIVA CANDIDATA:

NEXT NODE POST COMMAND INTENT DA DEFINIRE

Candidati principali residui:

- PREVIEW MODEL / HINT STATE CONSOLIDATION
- INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER
- DATA STRUCTURE / ENTITY HIERARCHY
- ECONOMIC DIRECTION ADVANCED
- DURATION ADVANCED — GIORNI / SETTIMANE
- SUGGESTION CREATE VS EDIT CONSISTENCY
- PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE
- COMMAND INTENT — EDIT GUIDE GENERIC ALIAS
- FEEDBACK MICRO-FLASH CLEANUP
- LINTING / MINOR CLEANUP
- CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION
- AZIONI RAPIDE OPERATIVE

Candidati non immediati:

- DASHBOARD BASE
- ICON SYSTEM / MOBILE POLISH FINALE
- ISTANZE / MODULI VERTICALI ASPRI / ADEXIMA / MAURIZIOLAB

------------------------------------------------
ROADMAP MASTER
------------------------------------------------

STEP 1 — INPUT RELIABILITY (COMPLETATO)

Obiettivo:

Rendere l’input sufficientemente affidabile.

---

Interventi:

- parsing unità (€, minuti, ore)
- estrazione amount stabile
- label cleaning
- type detection base

---

Output raggiunto:

✔ preview coerente nei dati principali  
✔ riduzione ambiguità  
✔ input utilizzabile  
✔ base per parsing controllato  

------------------------------------------------

STEP 2 — MATCHING BASE (COMPLETATO / STABILE)

Obiettivo:

Ridurre ambiguità project/entity.

---

Interventi:

- project matching stabile
- entity matching multi-livello
- suggerimenti coerenti
- auto-select solo se match univoco

---

Output raggiunto:

✔ riduzione errori selezione  
✔ suggerimenti utilizzabili  
✔ matching non bloccante  
✔ controllo utente preservato  

---

Limiti residui:

✔ Match Engine Unification First Controlled Level completato nello STEP 6.4  
✔ project_state / entity_state ora fonte minima matching  
✔ select / preview / hint / confirm guard allineati al match state  
✔ priority match minimo implementato  

⚠ match engine avanzato separato non implementato  
⚠ fuzzy matching non implementato  
⚠ alias / gerarchie / deduplicazione non implementati  

------------------------------------------------

STEP 3 — LABEL QUALITY / INPUT COMPLETENESS (COMPLETATO)

Obiettivo:

Gestione casi complessi e miglioramento leggibilità della preview.

---

Interventi:

- edge case parsing
- gestione input sporco
- stabilizzazione preview
- label cleaning
- numeric safe
- compound token

---

Output raggiunto:

✔ copertura casi reali  
✔ robustezza input  
✔ label più leggibile  
✔ riduzione variabilità descrizioni  

---

Limiti residui:

⚠ label ancora embedded nella preview  
⚠ preview non ancora view pura  
✔ formattazione visuale base allineata ai dati normalizzati    

------------------------------------------------

STEP 3.5 — STRUCTURE STABILIZATION (COMPLETATO)

Obiettivo:

Stabilizzare il sistema eliminando accoppiamenti critici tra input, parsing e UI.

---

Interventi eseguiti:

✔ introduzione parser controllato (parse_input_controlled)  
✔ introduzione debounce parsing  
✔ eliminazione parsing per-lettera  
✔ eliminazione loop reattivo  
✔ centralizzazione parsing in ui_state  
✔ eliminazione duplicazione parsing  
✔ allineamento create/edit  
✔ stabilizzazione UI flow base  
✔ separazione input → parsing → preview  

---

Output raggiunto:

✔ sistema deterministico reale  
✔ parsing stabile  
✔ UX fluida  
✔ nessun trigger circolare critico  
✔ base pronta per engine  

Evoluzione successiva:

✔ UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL completato
✔ rendering progressivo input flow ridotto
✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto
✔ flow event / command stabilizzato a primo livello

Limiti residui:

⚠ micro-flash feedback project/entity ancora presente
⚠ 5 linting Retool residui ancora presenti
⚠ Input Analysis Model completo non implementato

------------------------------------------------

STEP 4 — EVENT EDITING (COMPLETATO)

Obiettivo:

Consentire correzione eventi NEW senza duplicazione.

---

Interventi:

- editing eventi NEW
- riuso UI input
- update_event
- correzione dati
- updated_at

---

Output raggiunto:

✔ editing eventi NEW operativo  
✔ update_event implementato  
✔ riuso completo pipeline input  
✔ miglioramento qualità dati  
✔ completamente allineato con input system stabilizzato  
✔ update visibile in lista dopo refresh controllato  

------------------------------------------------

STEP 5 — DATA STRUCTURE (NON ATTIVO)

Obiettivo:

Strutturare dati e relazioni.

---

Interventi previsti:

- relazioni entity-project
- gestione duplicati avanzata
- eventuale gerarchia entity/project
- alias project/entity
- filtro select su match ambigui

---

Output atteso:

- dati coerenti
- struttura stabile
- riduzione ambiguità strutturale

---

Stato:

⚠ non attivo  
✔ creazione guidata project/entity completata a primo livello controllato  
✔ Command Intent create project/entity completato a primo livello controllato
✔ UI Readiness / Visibility Aggregator completato a primo livello controllato
⚠ deduplicazione avanzata non implementata  
⚠ gerarchie / alias / relazioni evolute non implementate  
⚠ fortemente consigliato prima di moduli verticali e output avanzati 
⚠ Command Intent non introduce gerarchie, alias o deduplicazione avanzata
⚠ UI Readiness non introduce gerarchie, alias, deduplicazione o nuove strutture dati
⚠ elementi già esistenti vengono bloccati a livello UI, ma non esiste ancora deduplicazione strutturale avanzata

------------------------------------------------

STEP 6 — ENGINE

Obiettivo:

Normalizzazione e logica dati.

---

Principio:

ENGINE deve evolvere per blocchi minimi,
senza sostituire il sistema esistente
e senza introdurre semantica non controllata.

---

STEP 6.1 — ENGINE BASE / NORMALIZATION LAYER BASE (COMPLETATO)

Obiettivo:

Implementare il primo layer minimo di normalizzazione dati base.

---

Interventi eseguiti:

✔ stabilizzazione ui_state.parsed  
✔ normalizzazione amount base  
✔ normalizzazione unit base  
✔ supporto formato numerico italiano  
✔ supporto unità compatte testuali  
✔ rimozione amount per numeri senza unità  
✔ rimozione parsing legacy da button_input_confirm  
✔ insert verificato con dati normalizzati  
✔ update verificato con dati normalizzati  
✔ fix refresh lista dopo update  

---

Output raggiunto:

✔ amount coerente  
✔ unit coerente  
✔ dati salvati tramite fonte unica  
✔ insert/update allineati  
✔ normalizzazione base reale implementata  
✔ primo blocco engine completato  

---

Regole consolidate:

- amount viene salvato come numero
- unit viene salvata come testo normalizzato
- raw_input resta preservato
- numeri senza unità non diventano amount
- formattazione italiana base implementata nella preview
- output/analytics futuri dovranno mantenere la stessa coerenza visuale
- nessuna modifica schema DB

---

Limiti espliciti dopo evoluzione successiva:

✔ duration normalization base implementata nello STEP 6.2  
✔ ore/minuti ora normalizzati in minuti  
✔ 1 ora e 15 minuti supportato  
✔ 2h30 supportato  
✔ 2 ore 30 supportato  

Limiti ancora aperti:

⚠ giorni/settimane non convertiti automaticamente  
⚠ giornata / mezza giornata non normalizzate  
⚠ parole numeriche tipo “due ore” non supportate  
✔ type classification base implementata nello STEP 6.3  
✔ Spesa / Incasso base implementati tramite keyword controllate e scelta manuale  
✔ Match Engine Unification First Controlled Level completato nello STEP 6.4  
⚠ match engine avanzato separato non implementato      

------------------------------------------------

PREVIEW ALIGNMENT BASE (COMPLETATO)

Obiettivo:

Allineare la visualizzazione della sintesi ai dati già normalizzati in ui_state.parsed,
senza introdurre nuova logica semantica e senza modificare parser, DB, matching o save flow.

---

Interventi eseguiti:

✔ formattazione italiana amount in preview  
✔ euro visualizzato con due decimali  
✔ grouping migliaia visuale  
✔ ore/minuti visualizzati coerentemente  
✔ gestione singolare/plurale unit  
✔ label cleaning preview aggiornato  
✔ rimozione amount/unit già rappresentati dal value  
✔ risolto bug "minuti" → "uti"  
✔ separatore data/descrizione uniformato  
✔ highlight locale reso unit-safe  
✔ nessuna modifica a parse_input_controlled  
✔ nessuna modifica a insert_event / update_event  
✔ nessuna modifica DB  
✔ nessuna modifica matching  

---

Output raggiunto:

✔ preview coerente con ui_state.parsed  
✔ maggiore leggibilità sintesi  
✔ ridotta divergenza visuale parser / preview  
✔ dati interni invariati  
✔ save flow invariato  
✔ DB invariato  

---

Esempi validati:

1.500,50 euro materiale  
→ 1.500,50 € • materiale  

1500 euro materiale  
→ 1.500,00 € • materiale  

18 minuti test  
→ 18 minuti • test  

18min test  
→ 18 minuti • test  

1ora lavoro  
→ 1 ora • lavoro  

6/4/26 inseminazione alfie  
→ 6 apr • inseminazione alfie  

4 aprile benzina 50 euro alfie allevamento aspri  
→ 4 apr • 50,00 € • benzina alfie allevamento aspri  

villa 2 mario  
→ villa 2 mario  

2 ore sopralluogo villa 2  
→ 2 ore • sopralluogo villa 2  

---

Regole consolidate:

- la preview legge ui_state.parsed
- amount resta numerico nel dato interno
- la formattazione italiana è solo visuale
- la label resta derivata runtime e non persistita
- la preview resta un layer ibrido, non ancora view pura
- matching, parser e DB non sono stati modificati

---

Limiti espliciti dopo evoluzione successiva:

✔ duration normalization base implementata nello STEP 6.2  
✔ 1 ora e 15 minuti supportato  
✔ 2h30 supportato  
✔ 2 ore 30 supportato  
✔ preview durata aggiornata con forma umana + hint normalizzato  

Limiti ancora aperti:

⚠ giorni/settimane non convertiti automaticamente  
✔ type classification base implementata nello STEP 6.3  
✔ Spesa / Incasso base implementati tramite keyword controllate e scelta manuale  
✔ matching project/entity allineato a project_state/entity_state nello STEP 6.4  
✔ hint ambiguità e highlight preview alimentati da match state  
⚠ preview non ancora view pura  
⚠ hint/duration/type restano embedded nella preview     

------------------------------------------------

STEP 6.2 — ENGINE BASE / DURATION NORMALIZATION (COMPLETATO)

Obiettivo:

Normalizzare durate certe espresse in ore/minuti
rendendole confrontabili tramite unità canonica.

---

Decisione consolidata:

- unità canonica tempo = minuti
- amount = totale minuti
- unit = "minuti"
- raw_input resta preservato
- DB invariato
- nessun payload duration
- nessun nuovo campo duration_minutes

---

Interventi eseguiti:

✔ parse_input_controlled aggiornato  
✔ ore semplici convertite in minuti  
✔ minuti semplici preservati come minuti  
✔ ore decimali convertite in minuti  
✔ durate composte ore + minuti convertite in minuti  
✔ formati compatti tipo 2h30 convertiti in minuti  
✔ giorni/settimane riconosciuti come ambigui ma non convertiti  
✔ preview aggiornata con forma umana della durata  
✔ hint “Normalizzato: X minuti” introdotto  
✔ hint durata ambigua introdotto  
✔ insert verificato con durata normalizzata  
✔ update verificato con durata normalizzata  
✔ regressioni euro / date / numeri semantici verificate  

---

Esempi validati:

1 ora  
→ amount 60  
→ unit minuti  

1,5 ore  
→ amount 90  
→ unit minuti  

1 ora e 15 minuti  
→ amount 75  
→ unit minuti  

2h30  
→ amount 150  
→ unit minuti  

2 ore 30  
→ amount 150  
→ unit minuti  

18min  
→ amount 18  
→ unit minuti  

90 minuti  
→ amount 90  
→ unit minuti  

2 giorni rendering  
→ amount null  
→ unit null  
→ hint durata ambigua  

---

Output raggiunto:

✔ durate certe confrontabili  
✔ tempo normalizzato in minuti  
✔ raw_input preservato  
✔ DB invariato  
✔ save flow invariato  
✔ preview più leggibile  
✔ nessuna type classification introdotta  
✔ nessun matching modificato  
✔ nessuna dashboard/KPI anticipata  

---

Limiti espliciti:

⚠ giorni/settimane non convertiti automaticamente  
⚠ giornata / mezza giornata non normalizzate  
⚠ parole numeriche tipo “due ore” non supportate  
⚠ forme colloquiali tipo “un paio d’ore” non supportate  
⚠ 2h e mezza non supportato  
⚠ dati storici non retro-normalizzati  
✔ type classification base implementata nello STEP 6.3  
✔ select1 allineato a parsed.unit = minuti  
⚠ flash preview durante debounce non corretto        

------------------------------------------------

STEP 6.3 — ENGINE BASE / TYPE CLASSIFICATION BASE (COMPLETATO)

Obiettivo:

Classificare in modo controllato il tipo evento.

---

Categorie reali implementate:

- Evento
- Tempo
- Spesa
- Incasso

---

Decisione:

La categoria logica "economico" non è stata introdotta come opzione separata,
perché nel sistema reale select1 distingue già:

- Spesa
- Incasso

Quando è presente euro ma manca direzione chiara,
il sistema resta su Evento per preservare controllo utente.

---

Segnali implementati:

- parsed.unit = minuti → Tempo
- euro + keyword controllate di uscita → Spesa
- euro + keyword controllate di entrata → Incasso
- euro senza direzione chiara → Evento
- segnali economici contrastanti → Evento
- nessuna unit significativa → Evento
- selezione manuale utente sempre preservata

---

Interventi eseguiti:

✔ select1 allineato a ui_state.parsed.unit  
✔ parsed.unit = "minuti" → Tempo  
✔ keyword controllate per Spesa  
✔ keyword controllate per Incasso  
✔ fallback prudente a Evento  
✔ type aggiunto al payload di button_input_confirm  
✔ insert_event salva events.type  
✔ update_event aggiorna events.type  
✔ override manuale utente validato  
✔ reset/stale value verificato  
✔ nessuna modifica schema DB  
✔ nessuna modifica parser  
✔ nessuna modifica matching  
✔ nessun refactor preview  
✔ nessun output/KPI anticipato  

---

Esempi validati:

2h30 rendering  
→ type Tempo  
→ amount 150  
→ unit minuti  

1 ora e 45 minuti lavoro  
→ type Tempo  
→ amount 105  
→ unit minuti  

20 euro spesa materiale  
→ type Spesa  
→ amount 20  
→ unit euro  

20 euro incasso cliente  
→ type Incasso  
→ amount 20  
→ unit euro  

20 euro materiale  
→ type Evento  
→ amount 20  
→ unit euro  

villa 2 mario  
→ type Evento  
→ amount null  
→ unit null  

---

Override manuale validato:

20 euro materiale + select1 manuale Spesa  
→ type Spesa  

20 euro materiale + select1 manuale Incasso  
→ type Incasso  

---

Output raggiunto:

✔ type classification base funzionante  
✔ type persistito in events.type  
✔ Tempo coerente con Duration Normalization  
✔ Spesa / Incasso distinguibili a livello base  
✔ Evento resta default prudente  
✔ utente mantiene controllo finale  
✔ dati più utili per futuri report  
✔ nessuna automazione decisionale aggressiva  

---

Limiti espliciti:

⚠ classificazione economica avanzata non implementata  
⚠ dizionario keyword esteso non implementato  
⚠ parole di dominio come benzina/materiale/mangime non classificano automaticamente Spesa  
⚠ amount resta positivo  
⚠ nessun amount firmato  
⚠ nessun direction field  
⚠ type base non ancora sufficiente da solo per KPI avanzati  
⚠ eventi storici non retro-normalizzati  
✔ Match Engine Unification First Controlled Level completato nello STEP 6.4  
⚠ match engine avanzato separato non implementato  

------------------------------------------------

STEP 6.4 — MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL (COMPLETATO)

Obiettivo:

Eliminare il primo livello di logiche parallele di matching project/entity,
rendendo coerenti:

- project_state / entity_state
- select_project / select_entity
- preview hint
- preview highlight
- button_input_confirm disabled
- create flow
- edit flow

---

Problema reale affrontato:

Il sistema aveva una catena type coerente:

ui_state.parsed.unit
→ select1
→ payload.type
→ events.type

ma il matching project/entity restava distribuito tra più logiche:

1. project_state / entity_state
2. select_project / select_entity
3. preview / detected locale
4. hint locali
5. confirm guard

Conseguenze:

- incoerenza architetturale
- duplicazione logica
- possibili divergenze tra select e preview
- hint non sempre allineati
- ambiguità project/entity difficili da governare
- priority match non implementato

---

Interventi eseguiti:

✔ project_state aggiornato come fonte minima matching project  
✔ entity_state aggiornato come fonte minima matching entity  
✔ output matching arricchito con:
  - matches
  - count
  - hasMatch
  - isAmbiguous
  - singleMatch
  - moreSpecificMatches
  - hasMoreSpecificMatches  
✔ select_project allineato a project_state.data.singleMatch  
✔ select_entity allineato a entity_state.data.singleMatch  
✔ trigger_parse_debounced aggiorna:
  - parse_input_controlled
  - project_state
  - entity_state  
✔ btn_edit aggiorna:
  - parse_input_controlled
  - project_state
  - entity_state  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ preview hint ambiguità allineati a isAmbiguous  
✔ preview highlight alimentato da matches  
✔ detection locale preview rimossa come fonte decisionale matching  
✔ confirm guard basata su ambiguità non risolta  
✔ ambiguità risolta manualmente non blocca salvataggio  
✔ nessun match non blocca salvataggio  
✔ priority match minimo implementato  
✔ hint informativo match più specifici introdotto  
✔ bug €500 nella label preview risolto  
✔ linting project_state/entity_state ripuliti  

---

Regole consolidate:

- project_state / entity_state sono la fonte minima osservabile del matching
- select_project / select_entity leggono singleMatch
- preview legge matches / count / isAmbiguous / moreSpecificMatches
- button_input_confirm blocca solo ambiguità non risolte
- nessun match project/entity non blocca il salvataggio
- match esatto breve resta valido
- match esatto con varianti più specifiche mostra hint informativo non bloccante
- scelta manuale utente prevale sul blocco ambiguità

---

Esempi validati:

villa 2 mario  
→ project Villa 2  
→ entity Mario  
→ Conferma abilitata  

4 aprile benzina 50 euro alfie allevamento aspri  
→ project ASPRI  
→ entity ambigua  
→ Più entità trovate  
→ Conferma disabilitata finché non viene scelta entità  

stesso input + scelta manuale Alfie  
→ Conferma abilitata  

18 min ristrutturazione bagno  
→ project Ristrutturazione Bagno  
→ type Tempo  
→ Conferma abilitata  

acquisto 50 euro materiale nuovo  
→ nessun project/entity  
→ type Spesa  
→ Conferma abilitata  

mario  
→ entity Mario  
→ hint Esistono entità più specifiche  
→ Conferma abilitata  

mario rossi  
→ entity Mario Rossi  
→ hint Esistono entità più specifiche  
→ Conferma abilitata  

mario rossi alfredo  
→ entity Mario Rossi Alfredo  
→ Conferma abilitata  

villa  
→ project Villa  
→ hint Esistono progetti più specifici  
→ Conferma abilitata  

villa 2  
→ project Villa 2  
→ Conferma abilitata  

alfie mario rossi  
→ ambiguità reale entity  
→ Conferma disabilitata  

---

Output raggiunto:

✔ matching project/entity più coerente  
✔ duplicazione logica ridotta  
✔ select / preview / hint / confirm allineati  
✔ create flow validato  
✔ edit flow validato  
✔ controllo utente preservato  
✔ DB invariato  
✔ parser invariato  
✔ duration normalization invariata  
✔ type classification invariata  
✔ nessun output/KPI anticipato  

---

Limiti residui:

⚠ non è stato creato un match engine avanzato separato  
⚠ fuzzy matching non implementato  
⚠ alias non implementati  
⚠ gerarchie project/entity non implementate  
⚠ deduplicazione non implementata  
✔ creazione guidata project/entity implementata nel nodo PROJECT / ENTITY CREATE SUGGESTION
✔ command intent create project/entity implementato nel nodo COMMAND INTENT — CREATE PROJECT / ENTITY  
⚠ preview resta layer ibrido  
✔ linting Retool residui su edit_mode / editing_event risolti nel nodo LINTING / STATE HELPER CLEANUP 

---

Stato:

COMPLETATO — FIRST CONTROLLED LEVEL

Non riaprire come Match Engine Unification base.
Eventuali evoluzioni future devono essere nodi dedicati:
- alias
- gerarchie
- deduplicazione
- fuzzy matching
- creazione guidata project/entity   

------------------------------------------------

UX / CLEANUP MICRO-BATCH POST MATCH ENGINE (COMPLETATO)

Obiettivo:

Chiudere micro-problemi UX e cleanup emersi dopo Match Engine Unification,
senza modificare engine, parser, database o architettura.

---

Interventi eseguiti:

✔ aggiunto pulsante Annulla in edit mode  
✔ Annulla visibile solo durante modifica evento  
✔ Annulla torna alla lista eventi senza update_event  
✔ reset controllato edit_mode / editing_event  
✔ reset controllato input_home / input_raw  
✔ reset controllato select_project / select_entity / select1  
✔ reset ui_state.parsed  
✔ rafforzato btn_edit per evitare doppia visibilità input/lista  
✔ aggiunta barra ricerca nella lista eventi  
✔ filtro client-side su eventi NEW  
✔ ricerca su raw_input / type / status / project / entity  
✔ corretta label creato/modificato nella lista eventi  
✔ normalizzazione robusta created_at / updated_at  
✔ confronto UTC → Europe/Rome  
✔ marcatore leggero per eventi modificati  
✔ aggiunto no-op edit guard in button_input_confirm  
✔ edit senza modifiche reali non esegue update_event  
✔ updated_at non cambia se non cambiano campi utente  
✔ amount / unit / event_date esclusi dal confronto no-op perché derivati dal parser  
✔ fix UI state per nuovo input partendo dalla lista eventi  

---

Output raggiunto:

✔ create flow validato  
✔ edit flow validato  
✔ annulla modifica validato  
✔ search/filter lista validato  
✔ WRITTEN / ERROR validati  
✔ regressione match/type/duration validata  
✔ lista eventi più usabile da mobile  
✔ edit flow più sicuro  
✔ label lista eventi meno fuorviante  
✔ nessuna regressione DB  
✔ nessuna regressione parser  
✔ nessuna regressione Match Engine  
✔ nessuna regressione Type Classification  
✔ nessuna regressione Duration Normalization  

---

Limiti residui:

✔ linting edit_mode / editing_event risolti nel nodo successivo LINTING / STATE HELPER CLEANUP  
✔ runtime edit/create/annulla/no-op edit rivalidato dopo cleanup helper 

---

Stato:

COMPLETATO.

Non riaprire come UX Cleanup base.
Eventuali evoluzioni grafiche future devono essere nodo dedicato,
solo dopo sistema stabile.

------------------------------------------------

LINTING / STATE HELPER CLEANUP (COMPLETATO)

Obiettivo:

Eliminare i linting Retool residui sugli helper state edit_mode / editing_event,
senza modificare parser, matching, DB, preview, lista eventi o architettura.

---

Problema reale affrontato:

Gli helper edit_mode e editing_event usavano:

return value;

con valore passato tramite:

additionalScope: { value: ... }

Il runtime era corretto, ma Retool segnalava:

- edit_mode: 'value' is not defined
- editing_event: 'value' is not defined

Conseguenza:

- rumore tecnico nel debug
- rischio di confusione futura durante manutenzione
- residuo non bloccante ma documentale/operativo

---

Interventi eseguiti:

✔ rimosso additionalScope { value } da edit_mode / editing_event  
✔ introdotto passaggio controllato tramite window.__logos_edit_mode_value  
✔ introdotto passaggio controllato tramite window.__logos_editing_event_value  
✔ edit_mode legge window.__logos_edit_mode_value  
✔ editing_event legge window.__logos_editing_event_value  
✔ gli helper cancellano la chiave window dopo la lettura  
✔ aggiornato btn_edit  
✔ aggiornato btn_cancel_edit  
✔ aggiornato button_input_confirm:
  - ramo no-op edit guard
  - reset finale dopo salvataggio reale  
✔ editing_event azzerato anche dopo update reale completato  

---

Output raggiunto:

✔ linting edit_mode risolto  
✔ linting editing_event risolto  
✔ create flow validato  
✔ edit flow validato  
✔ annulla modifica validato  
✔ edit senza modifiche reali validato  
✔ edit con modifica reale validato  
✔ updated_at / label creato-modificato validati  
✔ WRITTEN / ERROR validati  
✔ nessuna regressione DB  
✔ nessuna regressione parser  
✔ nessuna regressione Match Engine  
✔ nessuna regressione Type Classification  
✔ nessuna regressione Duration Normalization  
✔ nessuna regressione preview  
✔ nessuna regressione lista eventi  

---

Stato:

COMPLETATO.

Non riaprire come linting cleanup base.
Eventuali ulteriori warning Retool dovranno essere trattati solo se reali, riproducibili e collegati a regressioni runtime.

------------------------------------------------

PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL (COMPLETATO)

Obiettivo:

Consentire la creazione guidata e controllata di project/entity quando l’input utente
non produce un match sufficiente o contiene un’estensione specifica non ancora presente.

---

Principi:

- nessuna creazione automatica silenziosa
- creazione solo previa conferma utente
- evento non salvato automaticamente dopo creazione project/entity
- select_project / select_entity restano decisione utente finale
- raw_input resta testo sorgente
- project/entity mancanti non bloccano il salvataggio
- project/entity ambigui bloccano il salvataggio finché non risolti manualmente
- una sola creazione guidata aperta alla volta

---

Interventi eseguiti:

✔ introdotto create_suggestion_state  
✔ introdotte variabili:
  - project_create_inline_open
  - project_create_suggestion_dismissed
  - entity_create_inline_open
  - entity_create_suggestion_dismissed  
✔ introdotto insert_project  
✔ introdotto insert_entity  
✔ introdotto container suggestion inline  
✔ introdotto micro-editor project  
✔ introdotto micro-editor entity  
✔ introdotto bottone Ignora globale  
✔ introdotti Annulla contestuali nei micro-editor  
✔ creazione project inline validata  
✔ creazione entity inline validata  
✔ entity autofill controlled minimal implementato  
✔ flow combinato project + entity validato  
✔ no-match generico salvabile validato  
✔ ambiguità entity bloccante validata  
✔ edit/no-op non regressivo validato  

---

Output raggiunto:

✔ project/entity possono essere creati inline  
✔ project_id può essere valorizzato dopo creazione project  
✔ entity_id può essere valorizzato dopo creazione entity  
✔ evento salvabile con project/entity appena creati  
✔ evento salvabile anche senza project/entity  
✔ dati più completi senza obbligo di configurazione preventiva  
✔ migliore usabilità mobile  
✔ Core Event System rafforzato  

---

Esempi validati:

villa sierri 15 sopralluogo referente kappa  
→ crea project Villa Sierri 15  
→ crea entity Referente Kappa  
→ evento salvato con project_id + entity_id corretti  

acquisto 50 euro materiale nuovo  
→ Ignora suggestion  
→ evento salvato con project_id null / entity_id null  
→ type Spesa  
→ amount 50  
→ unit euro  

alfie mario rossi  
→ ambiguità entity  
→ Crea entità non visibile  
→ Conferma disabilitata finché non risolta manualmente  

---

Limiti residui:

✔ UI container suggestion rifinita a livello mobile base durante UX Mobile Coherence Pass
✔ command intent create project/entity implementato a primo livello controllato

⚠ filtro select su match ambigui non implementato
⚠ gerarchie / alias / deduplicazione avanzata non implementate
⚠ suggestion create vs edit consistency ancora da verificare
⚠ project creation override con match generico non implementato
⚠ nessuna istanza verticale attiva 

---

Stato:

COMPLETATO — FIRST CONTROLLED LEVEL

Non riaprire come create suggestion base.
Eventuali evoluzioni future devono essere nodi dedicati:

- UX CLEANUP — SUGGESTION CONTAINER / MOBILE
- COMMAND INTENT — CREATE PROJECT / ENTITY
- DATA STRUCTURE / ENTITY HIERARCHY
- SELECT OPTIONS FILTERING — AMBIGUITY UX

------------------------------------------------

UX MOBILE COHERENCE PASS (COMPLETATO)

Obiettivo:

Portare la UX mobile di LOGOS a uno stato coerente, stabile e utilizzabile,
estendendo il lavoro sul suggestion container a:

- Home
- Input / Sintesi
- Dati evento
- Events list
- Feedback
- Navigation dock
- Cancel create/edit
- Routing post-save

---

Interventi eseguiti:

✔ Home mobile rifinita  
✔ card Esempi resa coerente  
✔ Azioni rapide rifinite e predisposte  
✔ Events list mobile rifinita  
✔ Feedback mobile stabilizzato  
✔ feedback_summary introdotto in ui_state  
✔ handle_event_success disabilitato come gestore UI post-save  
✔ success handler UI rimossi da insert_event / update_event  
✔ button_input_confirm centralizza feedback e routing post-save  
✔ insert reale → feedback 1800 ms → Home  
✔ update reale → feedback 1800 ms → Lista eventi  
✔ no-op edit → Lista eventi immediata senza update_event  
✔ cancel create/input → Home  
✔ cancel edit → Lista eventi  
✔ Navigation dock Home / Eventi / Dashboard introdotta  
✔ Dashboard presente ma disabilitata  
✔ Dati evento compattati con label inline nelle select  
✔ Icon add-ons Retool introdotti nei pulsanti reali  
✔ font-size input/select portato a 16px per Safari iOS  
✔ zoom automatico iOS Safari risolto  
✔ select mobile validate sia in digitazione sia in dropdown  
✔ validazione reale su iPhone 13 Safari completata  

---

Output raggiunto:

✔ UX mobile più coerente  
✔ sistema più vicino a una mobile app reale  
✔ feedback breve e non bloccante  
✔ routing post-save coerente con contesto utente  
✔ navigazione predisposta alla futura Dashboard senza implementarla  
✔ input/select più stabili su Safari iOS  
✔ nessuna regressione parser  
✔ nessuna regressione matching  
✔ nessuna regressione DB  
✔ nessun output/KPI anticipato  

---

Decisioni consolidate:

- UX mobile base completata
- Dashboard predisposta ma non attiva
- Azioni rapide predisposte ma non operative
- Feedback = toast-card temporanea
- Navigation dock = contestuale, non fixed/sticky
- font-size minimo input/select mobile Safari = 16px

---

Limiti residui:

⚠ Cambia / Scegli nella Sintesi ancora non cliccabili  
⚠ Azioni rapide non operative  
⚠ Dashboard non implementata  
⚠ suggestion create vs edit consistency da verificare  
⚠ project creation override con match generico non implementato  
⚠ polish finale font/spaziature rimandato  
⚠ standardizzazione Icon System non completa
⚠ dopo Command Intent resta da valutare stabilità rendering input evento normale
⚠ “Da verificare” resta dentro Sintesi perché non è blocco autonomo  

---

Stato:

COMPLETATO.

Non riaprire come UX Mobile base.
Eventuali evoluzioni future devono essere nodi dedicati:

- AZIONI RAPIDE OPERATIVE
- DASHBOARD BASE
- MOBILE POLISH FINALE
- ICON SYSTEM
- CAMBIA / SCEGLI ACTIONS
- HINT / AMBIGUITÀ ADVANCED

------------------------------------------------

COMMAND INTENT — CREATE PROJECT / ENTITY (COMPLETATO)

Obiettivo:

Introdurre un primo riconoscimento controllato di comandi espliciti
dentro input libero, distinguendo comando strutturale puro da evento ordinario.

---

Principi:

- command intent suggerisce e guida, non decide automaticamente
- comando puro non salva eventi
- project/entity vengono creati solo previa conferma utente
- insert_project / insert_entity restano le query operative di creazione
- select_project / select_entity restano decisione finale per gli eventi
- nessun DB schema modificato
- nessun parser amount/unit/date modificato
- nessun matching engine modificato
- nessun edit flow alternativo introdotto
- nessuna dashboard/KPI anticipata

---

Interventi eseguiti:

✔ introdotto command_intent_state come query Retool page-level  
✔ command_intent_state riconosce comandi puri  
✔ gestito comando generico “crea”  
✔ gestito create project incompleto  
✔ gestito create project completo  
✔ gestito create entity incompleto  
✔ gestito create entity completo  
✔ gestiti sinonimi base: crea, aggiungi, inserisci, nuovo, nuova  
✔ comandi puri esclusi dal salvataggio evento  
✔ container_command_intent introdotto dentro container_input  
✔ UI mobile Command Intent rifinita  
✔ elementi già presenti riconosciuti e non duplicati  
✔ “crea progetto villa” validato come elemento già presente  
✔ btn_command_create_project collegato a insert_project esistente  
✔ btn_command_create_entity collegato a insert_entity esistente  
✔ btn_command_go_events collegato alla lista eventi  
✔ “modifica evento” gestito come guida non operativa  
✔ nessun edit flow parallelo introdotto  
✔ feedback_mode introdotto in ui_state  
✔ feedback project_created implementato  
✔ feedback entity_created implementato  
✔ feedback evento ordinario preservato  
✔ feedback_resume adattato a Evento / Progetto / Entità  
✔ ritorno Home automatico dopo feedback project/entity validato  
✔ evento normale non regressivo validato  
✔ edit evento reale non regressivo validato  
✔ edit no-op / annulla modifica non regressivi validati  

---

Output raggiunto:

✔ input “crea progetto...” non viene salvato come evento  
✔ input “crea entità...” non viene salvato come evento  
✔ utente guidato se scrive solo “crea”  
✔ utente guidato se scrive “modifica evento”  
✔ creazione project/entity da comando esplicito funziona  
✔ nessun evento viene creato da comandi puri  
✔ nessuna duplicazione project/entity già esistenti  
✔ UX mobile command intent coerente con sistema esistente  
✔ DB invariato  
✔ parser invariato  
✔ matching invariato  
✔ create_suggestion_state invariato  
✔ type classification invariata  
✔ duration normalization invariata  
✔ nessun output/KPI anticipato  

---

Esempi validati:

crea  
→ comando generico  
→ guida con esempi  
→ nessun evento salvato  

crea progetto  
→ comando project incompleto  
→ campo nome progetto  
→ conferma richiesta  

crea progetto Command Final Project 2  
→ project creato  
→ feedback Progetto creato  
→ ritorno Home  
→ nessun evento salvato  

crea entità  
→ comando entity incompleto  
→ campo nome entità  
→ conferma richiesta  

crea entità Command Final Entity 2  
→ entity creata  
→ feedback Entità creata  
→ ritorno Home  
→ nessun evento salvato  

crea progetto villa  
→ elemento già presente  
→ nessuna duplicazione  
→ nessun evento salvato  

modifica evento  
→ guida con step  
→ Vai agli eventi  
→ nessuna modifica automatica  

30 euro spesa villa citrignano  
→ flow evento ordinario  
→ Spesa / 30 euro  
→ Conferma evento funzionante  

---

Limiti residui:

⚠ Command Intent è implementato solo a primo livello controllato  
⚠ non è un intent engine globale  
⚠ non gestisce dashboard/report  
⚠ non gestisce modifica project/entity da command  
⚠ non apre edit flow evento automatico  
⚠ non sostituisce parser, matching o suggestion  
⚠ non unifica ancora tutte le fonti di interpretazione  
⚠ rendering progressivo input evento normale ancora migliorabile  
⚠ “Da verificare” resta dentro Sintesi perché non è blocco autonomo  

---

Stato:

COMPLETATO — FIRST CONTROLLED LEVEL

Non riaprire come Command Intent base.
Eventuali evoluzioni future devono essere nodi dedicati:

- INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER
- AZIONI RAPIDE OPERATIVE
- DASHBOARD COMMAND / REPORT INTENT
- PROJECT / ENTITY EDIT COMMAND
- ADVANCED COMMAND INTENT

------------------------------------------------

UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL (COMPLETATO)

Obiettivo:

Introdurre un primo livello controllato di readiness / visibility UI
per stabilizzare il flow input, distinguere evento ordinario / command intent
e ridurre Hidden duplicate e rendering progressivo.

---

Principi:

- aggregare la visibilità UI senza modificare dati salvabili
- non sostituire parser, matching, suggestion o command intent
- non introdurre Input Analysis Model completo
- non introdurre Event Interpretation Engine
- non modificare DB
- non modificare save flow
- procedere tramite micro-step testati

---

Interventi eseguiti:

✔ introdotto ui_visibility_state come Transformer read-only
✔ introdotto ui_visibility_mode come Variable Retool
✔ ui_visibility_mode supporta:
  - empty
  - event
  - command
✔ trigger_parse_debounced aggiorna ui_visibility_mode
✔ introdotto window.__logos_visibility_run_id per evitare update stale da debounce precedenti
✔ classificazione locale event/command usata solo per visibilità UI
✔ ui_visibility_state legge ui_visibility_mode e stati runtime esistenti
✔ Hidden principali centralizzati:
  - container_command_intent
  - sintesi
  - container_association_suggestions
  - text_event_data_title
  - select1
  - select_project
  - select_entity
  - button_input_confirm
  - btn_cancel_edit
  - btn_cancel_input_home
  - container_input
✔ container_input stabilizzato tramite ui_visibility_state.isInputFlow
✔ container vuoto durante digitazione risolto
✔ flash input flow ridotto
✔ container_app_nav corretto usando input_home.value al posto di input_raw.value
✔ bottom bar flash risolto
✔ text_input_analysis_loading introdotto vicino all’input principale
✔ text_edit_mode_notice introdotto per chiarire edit mode
✔ edit mode prevale su command intent
✔ durante edit mode scrivere “crea” non apre Command Intent
✔ btn_command_create_project / btn_command_create_entity allineati nel timing del feedback
✔ test obbligatori 1–16 superati

---

Output raggiunto:

✔ flow event / command più stabile
✔ input flow più leggibile
✔ rendering progressivo ridotto
✔ container vuoto eliminato
✔ bottom bar stabile
✔ edit mode più chiaro per l’utente
✔ Command Intent preservato
✔ save flow preservato
✔ DB invariato
✔ parser invariato
✔ matching invariato
✔ create_suggestion_state invariato
✔ command_intent_state invariato
✔ preview content invariato
✔ button_input_confirm payload invariato
✔ insert_event / update_event invariati
✔ insert_project / insert_entity invariati
✔ nessun output/KPI anticipato

---

Limiti residui:

⚠ micro-flash feedback project/entity ancora presente
⚠ 5 linting Retool residui ancora presenti
⚠ “modifica” generico non ancora riconosciuto come guida edit
⚠ Input Analysis Model completo non implementato
⚠ ui_visibility_mode è latch UI, non fonte interpretativa completa

---

Stato:

COMPLETATO — FIRST CONTROLLED LEVEL

Non riaprire come UI Readiness base.
Eventuali evoluzioni future devono essere nodi dedicati:

- INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER
- FEEDBACK MICRO-FLASH CLEANUP
- LINTING / MINOR CLEANUP
- CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION
- COMMAND INTENT — EDIT GUIDE GENERIC ALIAS

------------------------------------------------

STEP 7 — OUTPUT (NON ATTIVO)

Obiettivo:

Visualizzazione e analisi.

---

Interventi:

- dashboard
- KPI
- analytics
- reportistica

---

Output atteso:

- sistema decisionale completo

---

Stato:

❌ non attivo  

Motivazione:

Il sistema NON può avanzare allo STEP 7 finché:

- type classification base è completata ma non ancora sufficiente per KPI avanzati
- matching è stato stabilizzato a primo livello, ma non è ancora un engine avanzato
- UX cleanup post matching e linting helper cleanup sono completati, ma data structure / entity relations non sono ancora consolidate
- data structure / entity relations non sono ancora consolidate
- project/entity create suggestion è completato a primo livello, ma gerarchie/deduplicazione non sono ancora consolidate
- command intent è implementato solo a primo livello controllato e non abilita ancora dashboard/report
- UI readiness è implementata solo a primo livello controllato e non abilita ancora dashboard/report
- istanze verticali non sono ancora attive
- direzione economica avanzata non è stata ancora valutata
- dati storici non sono retro-normalizzati
- eventuali output economici rischierebbero interpretazioni premature

Nota:

Duration Normalization Base è stata completata.
Le durate certe ore/minuti sono ora confrontabili tramite minuti canonici.

Nota:

Preview Alignment Base è stato completato.

Nota:

Type Classification Base è stata completata.
events.type viene ora valorizzato con:

- Evento
- Tempo
- Spesa
- Incasso

Tuttavia l’uso per KPI/report resta non attivo
finché matching, struttura dati, direzione economica e qualità dati
non saranno ulteriormente consolidati.

Project / Entity Create Suggestion First Controlled Level è completato.
projects/entities possono ora essere creati inline in modo controllato.
Tuttavia questo non abilita ancora automaticamente output/KPI o istanze verticali.

UX Mobile Coherence Pass è completato.
La Navigation dock prevede la voce Dashboard, ma la Dashboard resta disabilitata.
La presenza della voce Dashboard in nav NON abilita STEP 7 e NON anticipa KPI/reportistica.

Command Intent — Create Project / Entity è completato.
Questo consente di distinguere comandi puri da eventi ordinari,
ma NON abilita ancora STEP 7, dashboard, KPI o reportistica.

UI Readiness / Visibility Aggregator — First Controlled Level è completato.
Questo consente di stabilizzare il flow input e ridurre rendering progressivo,
ma NON abilita ancora STEP 7, dashboard, KPI o reportistica.

------------------------------------------------
NODO ATTIVO CONSIGLIATO
------------------------------------------------

NEXT NODE POST COMMAND INTENT DA DEFINIRE

------------------------------------------------
NODI CANDIDATI POST UI READINESS
------------------------------------------------

1. PREVIEW MODEL / HINT STATE CONSOLIDATION

Scopo:

- consolidare gli hint ancora embedded nella preview
- valutare separazione preview come view più pura
- distinguere hint bloccanti, warning informativi e suggestion create
- valutare se “Da verificare” debba diventare blocco autonomo
- mantenere preview non decisionale

Motivo:

Dopo UI Readiness il rendering input è stato stabilizzato a primo livello,
ma la Sintesi resta un layer ibrido che contiene ancora preview, hint,
highlight, warning e supporto decisionale.

---

2. INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER

Scopo:

- valutare direzione verso un solo layer di analisi interrogabile
- coordinare parse_input_controlled, project_state, entity_state, create_suggestion_state, command_intent_state e ui_visibility_state
- ridurre rami ibridi e fonti parallele
- non introdurre refactor senza nodo dedicato

Motivo:

Il checkpoint INPUT RENDERING STABILITY / PRIORITY REVIEW ha confermato che LOGOS può tendere
a un Input Analysis Result completo, ma non come estensione immediata del nodo UI Readiness.

Il nodo UI Readiness ha introdotto solo un aggregatore/latch UI.
Resta futuro il passaggio a un vero Single Interpretation Layer.

---

3. DATA STRUCTURE / ENTITY HIERARCHY

Scopo:

- valutare gerarchie
- valutare alias
- valutare deduplicazione avanzata
- valutare relazioni entity-project
- valutare filtro select su match ambigui
- non introdurre prima di nodo dedicato

Motivo:

Project/entity creation e Command Intent sono completati a primo livello,
ma la struttura dati resta ancora piatta.

---

4. SUGGESTION CREATE VS EDIT CONSISTENCY

Scopo:

- verificare differenze suggestion tra create flow e edit flow
- capire perché in alcuni edit flow compare solo suggestion entity
- mantenere invariati matching e DB finché non serve
- non introdurre override aggressivi

Motivo:

Durante UX Mobile Coherence Pass è stata osservata una possibile divergenza
tra suggestion in create flow e suggestion in edit flow.

---

5. PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE

Scopo:

- valutare creazione progetto anche quando esiste un match generico
- esempio: input “villa” con match Villa e progetti più specifici
- permettere eventuale scelta esplicita utente
- evitare creazioni automatiche silenziose

Motivo:

Il sistema oggi segnala match più specifici, ma non propone creazione progetto
quando esiste già un match generico.

---

6. ECONOMIC DIRECTION ADVANCED

Scopo:

- valutare amount firmato
- valutare direction field
- valutare regole contabili per Spesa/Incasso
- non attivo finché matching/data quality/report readiness non saranno stabilizzati

---

7. DURATION ADVANCED — GIORNI / SETTIMANE

Scopo:

- decidere conversione giorni/settimane
- valutare giornata lavorativa
- valutare mezza giornata
- evitare conversioni automatiche ambigue

---

8. AZIONI RAPIDE OPERATIVE

Scopo:

- rendere operative le Azioni rapide presenti in Home
- definire comportamento guidato per Spesa / Incasso / Tempo / Evento
- evitare automatismi silenziosi
- non bypassare input libero e select finali
- coordinarsi con Command Intent senza duplicare logiche

Stato:

candidato rilevante dopo consolidamento rendering / preview oppure come nodo UX guidato autonomo.

---

9. COMMAND INTENT — EDIT GUIDE GENERIC ALIAS

Scopo:

- valutare riconoscimento di comandi guida generici:
  - modifica
  - correggi
  - cambia
- evitare che “modifica” da solo venga trattato come evento ordinario
- non confondere frasi operative reali come “modifica preventivo villa”
- non aprire edit flow automatici

Motivo:

“modifica evento” viene riconosciuto correttamente come guida edit.
“modifica” da solo è ancora trattato come evento ordinario e mostra la Sintesi.

Stato:

micro-nodo futuro, non bloccante.

---

10. FEEDBACK MICRO-FLASH CLEANUP

Scopo:

- analizzare micro-flash residuo su feedback project/entity
- non modificare save flow
- non modificare insert_project / insert_entity
- intervenire solo se il flash risulta identificabile e fastidioso

Motivo:

Dopo UI Readiness il feedback project/entity funziona correttamente,
ma resta un micro-flash visivo non bloccante.

Stato:

residuo minore, non immediato.

---

11. LINTING / MINOR CLEANUP

Scopo:

- risolvere 5 linting Retool residui
- non modificare logiche runtime
- non aprire refactor

Stato:

nodo tecnico minore, da aprire solo se utile.

---

12. CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION

Scopo:

- rimuovere regex duplicate ormai sostituite da ui_visibility_state
- eliminare componenti/query obsolete solo dopo stabilità documentata
- semplificare manutenzione
- non modificare parser/matching/save flow

Stato:

cleanup futuro, non immediato.

---

13. DASHBOARD BASE

Scopo:

- attivare la voce Dashboard già presente nella navigation dock
- introdurre solo una dashboard base coerente con dati reali
- non anticipare KPI avanzati non fondati

Stato:

non immediato.
La voce Dashboard è predisposta ma disabilitata.

---

14. ICON SYSTEM / MOBILE POLISH FINALE

Scopo:

- standardizzare icone Retool add-on / emoji / eventuali SVG
- rifinire font e spaziature mobile
- preservare baseline 16px su input/select Safari iOS
- non toccare logiche runtime

Stato:

polish futuro, non nodo funzionale prioritario.

---

15. ISTANZE / MODULI VERTICALI ASPRI / ADEXIMA / MAURIZIOLAB

Scopo futuro:

- usare LOGOS Core per istanze verticali
- costruire viste/moduli sopra il Core Event System
- non sostituire il core
- non anticipare verticalizzazioni prima della stabilità core

Stato:

NON ATTIVO.

------------------------------------------------
REGOLE OPERATIVE
------------------------------------------------

VIETATO:

- anticipare step successivi
- lavorare su più layer
- introdurre automazioni premature
- modificare architettura senza necessità
- modificare schema DB fuori nodo
- trasformare preview alignment in engine semantico
- introdurre dashboard/KPI prima dell’engine sufficiente

---

CONSENTITO:

- miglioramenti incrementali
- test reali
- iterazioni rapide
- micro-patch controllate
- aggiornamenti documentali dopo checkpoint
- verifica runtime reale prima delle modifiche

------------------------------------------------
CRITERIO DI PASSAGGIO STEP
------------------------------------------------

Uno step è considerato completato solo se:

✔ utilizzabile in modo reale  
✔ stabile anche reattivamente  
✔ senza blocchi evidenti  
✔ validato su uso concreto  
✔ documentato in checkpoint  
✔ riflesso in State/Roadmap se cambia lo stato reale  

---

Se non soddisfa questi criteri:

→ lo step NON è chiuso

------------------------------------------------
GESTIONE EVOLUZIONE ROADMAP
------------------------------------------------

La roadmap può essere aggiornata SOLO se:

- cambia lo stato reale del sistema
- emerge un blocco strutturale
- audit evidenzia errore critico
- un checkpoint operativo è stato completato

---

Aggiornamento tramite:

versione progressiva

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il sistema NON deve evolvere per:

- completezza teorica
- feature non validate
- complessità non necessaria
- anticipazione di output non fondati

---

Il sistema deve evolvere per:

- uso reale
- qualità dati
- affidabilità
- progressiva normalizzazione
- stabilità runtime

---

Principio attuale:

Prima rendere i dati coerenti,
poi renderli leggibili,
poi renderli analizzabili.

---

Principio strategico confermato:

Prima consolidare il Core Event System,
poi aprire viste, moduli o istanze verticali.

LOGOS non deve diventare un gestionale verticale prematuro.
ASPRI, ADEXIMA e MaurizioLab sono istanze future del core,
non direzioni operative da anticipare ora.

------------------------------------------------
BLOCCO ATTUALE / VINCOLO DI AVANZAMENTO
------------------------------------------------

Il blocco strutturale input/parsing è stato risolto:

✔ eliminato loop reattivo  
✔ separata pipeline input → parsing → UI  
✔ eliminata duplicazione parsing nel save  
✔ stabilizzato comportamento reattivo  
✔ introdotta normalizzazione base  

---

Il sistema è ora entrato nello STEP 6 in modo reale.

---

⚠ BLOCCO ATTUALE:

Il sistema NON può avanzare allo STEP 7 (OUTPUT)
finché non vengono completati o valutati almeno:

1. valutazione Data Structure / Entity Hierarchy
2. valutazione Economic Direction Advanced
3. eventuale decisione su amount firmato / direction field
4. valutazione Duration Advanced — giorni / settimane
5. valutazione sufficienza dati reali per report iniziali
6. eventuale consolidamento Preview / Input Analysis se necessario per evitare output fuorvianti

Nota:

Duration Normalization Base è completata.
Le durate certe ore/minuti sono ora normalizzate in minuti.

Nota:

Preview Alignment Base è completato.

Nota:

Type Classification Base è completata.
Il campo events.type viene ora valorizzato dal frontend.
Match Engine Unification First Controlled Level è completato.
project_id/entity_id sono ora più coerenti grazie al match state minimo.
UX / Cleanup Micro-Batch Post Match Engine è completato.
Linting / State Helper Cleanup è completato.
edit_mode / editing_event non presentano più linting residui.
create/edit/annulla/no-op edit/edit reale sono stati rivalidati dopo il cleanup helper.
create/edit/lista/annulla/ricerca/WRITTEN/ERROR sono validati.
Project / Entity Create Suggestion First Controlled Level è completato.
Creazione inline project/entity validata.
Flow combinato project + entity validato.
Command Intent — Create Project / Entity è completato a primo livello controllato.
UI Readiness / Visibility Aggregator — First Controlled Level è completato.
Il flow input è stato stabilizzato a livello visivo tramite ui_visibility_mode e ui_visibility_state.
Il rendering progressivo input è stato ridotto, il container vuoto durante la digitazione è stato risolto
e la bottom bar è stata stabilizzata.
Istanze verticali non attive.
UX Mobile Coherence Pass è completato.
Home, Events list, Feedback e Navigation dock sono stati rifiniti e validati.
La validazione reale su iPhone 13 Safari ha consolidato il vincolo tecnico:
input/select mobile devono mantenere font-size minimo 16px per evitare zoom iOS.

Il nodo UI Readiness ha risolto a primo livello il residuo rendering progressivo input evento normale.

Restano residui non bloccanti:

- micro-flash feedback project/entity
- 5 linting Retool residui
- “modifica” generico non ancora riconosciuto come guida edit
- “Da verificare” ancora interno alla Sintesi
- Input Analysis Model completo non implementato

Questi residui non bloccano il sistema, ma possono orientare i prossimi nodi UX/Preview/Command.

Tuttavia type + matching base non abilitano ancora automaticamente KPI/reportistica.

---

Motivazione:

senza questi passaggi:

- dati parzialmente confrontabili
- visualizzazione non completamente coerente
- tipo evento non affidabile
- aggregazioni potenzialmente fuorvianti
- KPI non fondati

---

STEP 5 (DATA STRUCTURE) resta:

⚠ opzionale ma fortemente consigliato prima di engine avanzato
⚠ necessario prima di relazioni evolute / deduplicazione strutturale

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-02

- Creazione roadmap separata dalla Regia
- Definizione sequenza operativa vincolante
- Allineamento con audit e stato reale sistema

v03 — 2026-04-24

- completamento STEP 3.5 (Structure Stabilization)
- eliminazione loop reattivo
- introduzione parsing controllato
- unificazione parsing (single source of truth)
- stabilizzazione UX input
- chiusura dipendenza STEP 4 da stabilizzazione
- apertura transizione verso ENGINE BASE

v04 — 2026-04-30

- completamento STEP 6.1 — ENGINE BASE / NORMALIZATION LAYER BASE
- introduzione normalizzazione amount base
- introduzione normalizzazione unit base
- supporto formato numerico italiano
- gestione numeri senza unità
- rimozione parsing legacy da button_input_confirm
- validazione insert/update con ui_state.parsed
- fix refresh lista eventi dopo update
- apertura nodo consigliato PREVIEW ALIGNMENT BASE
- definizione candidati futuri: Duration Normalization, Type Classification Base, Match Engine Unification
- confermato blocco verso OUTPUT fino a dati più coerenti

v05 — 2026-04-30

- completamento PREVIEW ALIGNMENT BASE
- formattazione italiana amount in preview
- euro visualizzato con due decimali
- grouping migliaia visuale
- unità tempo visualizzate coerentemente
- label cleaning preview aggiornato
- risolto bug "minuti" → "uti"
- separatore data/descrizione uniformato
- highlight locale reso unit-safe
- nessuna modifica a parser, DB, matching o save flow
- aggiornamento fase attiva consigliata a STEP 6.2 — DURATION NORMALIZATION
- mantenuto blocco verso OUTPUT fino a duration/type/matching

v06 — 2026-04-30

- completamento STEP 6.2 — ENGINE BASE / DURATION NORMALIZATION
- definita unità canonica durata in minuti
- amount tempo salvato come totale minuti
- unit tempo salvata come "minuti"
- raw_input preservato
- 1 ora → 60 minuti
- 1,5 ore → 90 minuti
- 1 ora e 15 minuti → 75 minuti
- 2h30 → 150 minuti
- 2 ore 30 → 150 minuti
- 90 minuti → 90 minuti
- giorni/settimane riconosciuti come ambigui ma non convertiti
- preview aggiornata con forma umana della durata
- introdotto hint “Normalizzato: X minuti”
- introdotto hint durata ambigua
- insert/update validati runtime
- regressioni euro/date/numeri semantici superate
- nessuna modifica DB
- nessuna modifica matching
- nessuna type classification
- aggiornamento fase attiva consigliata a STEP 6.3 — TYPE CLASSIFICATION BASE
- mantenuto blocco verso OUTPUT fino a type/matching/data quality

v07 — 2026-05-01

- completamento STEP 6.3 — ENGINE BASE / TYPE CLASSIFICATION BASE
- select1 allineato a ui_state.parsed.unit
- parsed.unit = minuti → Tempo
- euro + keyword controllate di uscita → Spesa
- euro + keyword controllate di entrata → Incasso
- euro senza direzione chiara → Evento
- segnali economici contrastanti → Evento
- scelta manuale utente preservata
- type aggiunto al payload di button_input_confirm
- insert_event salva events.type
- update_event aggiorna events.type
- override manuale validato su Spesa / Incasso
- reset/stale value verificato
- type persistito in DB
- nessuna modifica schema DB
- nessuna modifica parser
- nessuna modifica matching
- nessun refactor preview
- nessun output/KPI anticipato
- linting Retool residuo registrato come anomalia non bloccante
- aggiornamento fase attiva consigliata a STEP 6.4 — MATCH ENGINE UNIFICATION
- mantenuto blocco verso OUTPUT fino a matching/data quality/report readiness

v08 — 2026-05-02

- completamento STEP 6.4 — MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL
- project_state aggiornato come fonte minima matching project
- entity_state aggiornato come fonte minima matching entity
- aggiunti output matching:
  - matches
  - count
  - hasMatch
  - isAmbiguous
  - singleMatch
  - moreSpecificMatches
  - hasMoreSpecificMatches
- select_project allineato a project_state.data.singleMatch
- select_entity allineato a entity_state.data.singleMatch
- trigger_parse_debounced aggiorna parse_input_controlled + project_state + entity_state
- btn_edit aggiorna parse_input_controlled + project_state + entity_state
- match state live in create flow
- match state live in edit flow
- preview hint ambiguità allineati a isAmbiguous
- preview highlight alimentato da matches
- detection locale preview rimossa come fonte decisionale matching
- confirm guard basata su ambiguità non risolta
- ambiguità risolta manualmente non blocca salvataggio
- nessun match non blocca salvataggio
- priority match minimo implementato
- ristrutturazione bagno → Ristrutturazione Bagno
- casa mare → Casa Mare
- villa 2 → Villa 2
- hint informativo match più specifici introdotto
- bug €500 nella label preview risolto
- linting project_state/entity_state ripuliti
- linting residui edit_mode/editing_event mantenuti come nodo futuro
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica type classification
- nessuna modifica duration normalization
- nessun output/KPI anticipato
- aggiornamento fase attiva consigliata a NEXT NODE da definire dopo aggiornamento documentale
- mantenuto blocco verso OUTPUT fino a data structure / economic direction / report readiness

v09 — 2026-05-02

- completamento UX / CLEANUP MICRO-BATCH POST MATCH ENGINE
- aggiunto pulsante Annulla in edit mode
- Annulla modifica senza update_event
- reset edit_mode / editing_event / input / select / ui_state.parsed
- fix doppia visibilità input/lista dopo Annulla
- aggiunta barra ricerca lista eventi
- filtro client-side su eventi NEW
- ricerca su raw_input / type / status / project / entity
- corretta label creato/modificato nella lista eventi
- normalizzazione robusta created_at / updated_at
- marcatore leggero per eventi modificati
- aggiunto no-op edit guard in button_input_confirm
- edit senza modifiche reali non aggiorna updated_at
- fix UI state per nuovo input da lista eventi
- create flow validato
- edit flow validato
- annulla modifica validato
- search/filter lista validato
- WRITTEN / ERROR validati
- regressione match/type/duration validata
- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- linting edit_mode/editing_event ancora residui non bloccanti
- aggiornamento fase attiva consigliata a NEXT NODE da definire dopo chiusura aggiornamento documentale minimo
- mantenuto blocco verso OUTPUT fino a data structure / economic direction / report readiness

v10 — 2026-05-03

- completamento LINTING / STATE HELPER CLEANUP
- risolto linting Retool edit_mode: 'value' is not defined
- risolto linting Retool editing_event: 'value' is not defined
- rimossa dipendenza da additionalScope { value } per edit_mode / editing_event
- introdotto passaggio controllato tramite window.__logos_edit_mode_value
- introdotto passaggio controllato tramite window.__logos_editing_event_value
- edit_mode ora legge valore tecnico da window.__logos_edit_mode_value
- editing_event ora legge valore tecnico da window.__logos_editing_event_value
- gli helper cancellano la chiave window dopo la lettura
- aggiornato btn_edit
- aggiornato btn_cancel_edit
- aggiornato button_input_confirm nel ramo no-op edit guard
- aggiornato button_input_confirm nel reset finale dopo salvataggio reale
- editing_event azzerato anche dopo update reale completato
- create flow validato
- edit flow validato
- annulla modifica validato
- edit senza modifiche reali validato
- edit con modifica reale validato
- updated_at / label creato-modificato validati
- WRITTEN / ERROR validati
- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- preview invariata
- lista eventi invariata
- nessun output/KPI anticipato
- aggiornamento fase attiva consigliata a NEXT NODE POST LINTING CLEANUP DA DEFINIRE
- mantenuto blocco verso OUTPUT fino a project/entity create suggestion / data structure / economic direction / report readiness

v11 — 2026-05-07

- completamento PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
- introdotto create_suggestion_state
- introdotte variabili project_create_inline_open / project_create_suggestion_dismissed
- introdotte variabili entity_create_inline_open / entity_create_suggestion_dismissed
- introdotte query insert_project / insert_entity
- introdotto container suggestion inline
- introdotti micro-editor project/entity
- introdotto bottone Ignora globale
- introdotti bottoni Annulla contestuali
- creazione project inline validata su DB reale
- creazione entity inline validata su DB reale
- select_project valorizzata dopo creazione project
- select_entity valorizzata dopo creazione entity
- evento non salvato automaticamente dopo creazione project/entity
- evento salvato manualmente con project_id/entity_id corretti
- project/entity mancanti non bloccano salvataggio
- project/entity ambigui bloccano salvataggio finché non risolti manualmente
- entity autofill controlled minimal implementato
- flow combinato project + entity validato
- no-match generico salvabile validato
- edit/no-op non regressivo validato
- command intent registrato come nodo futuro
- UX cleanup suggestion container registrato come nodo futuro
- direzione LOGOS Core modulare riconfermata
- istanze ASPRI / ADEXIMA / MaurizioLab confermate come derivate future del core
- aggiornamento fase attiva consigliata a NEXT NODE POST PROJECT / ENTITY CREATE SUGGESTION DA DEFINIRE
- mantenuto blocco verso OUTPUT fino a data structure / economic direction / report readiness

v12 — 2026-05-09

- completamento UX MOBILE COHERENCE PASS
- Home mobile rifinita
- card Esempi resa coerente
- Azioni rapide rifinite e predisposte
- Events list mobile rifinita
- Feedback mobile stabilizzato
- feedback_summary introdotto in ui_state
- handle_event_success disabilitato come gestore UI post-save
- success handler UI rimossi da insert_event / update_event
- button_input_confirm centralizza feedback e routing post-save
- insert reale → feedback 1800 ms → Home
- update reale → feedback 1800 ms → Lista eventi
- no-op edit → Lista eventi immediata senza update_event
- cancel create/input → Home
- cancel edit → Lista eventi
- Navigation dock Home / Eventi / Dashboard introdotta
- Dashboard presente ma disabilitata
- nav contestuale visibile in Home vuota e Events list
- nav nascosta durante input attivo e feedback
- Dati evento compattati con label inline nelle select
- Icon add-ons Retool introdotti nei pulsanti reali
- font-size input/select portato a 16px per Safari iOS
- zoom automatico iOS Safari risolto
- select mobile validate sia in digitazione sia in dropdown
- validazione reale su iPhone 13 Safari completata
- UX cleanup suggestion container non è più candidato immediato
- Command Intent / Data Structure / Economic Direction restano candidati principali
- Dashboard resta non attiva nonostante predisposizione in nav
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato
- aggiornamento fase attiva consigliata a NEXT NODE POST UX MOBILE COHERENCE PASS DA DEFINIRE

v13 — 2026-05-13

- completamento COMMAND INTENT — CREATE PROJECT / ENTITY
- introdotto command_intent_state come query Retool page-level
- gestito comando generico “crea”
- gestito create project incompleto
- gestito create project completo
- gestito create entity incompleto
- gestito create entity completo
- gestiti sinonimi base crea / aggiungi / inserisci / nuovo / nuova
- comandi puri esclusi dal salvataggio evento
- container_command_intent introdotto dentro container_input
- UI mobile Command Intent rifinita
- btn_command_create_project collegato a insert_project esistente
- btn_command_create_entity collegato a insert_entity esistente
- btn_command_go_events collegato alla lista eventi
- elementi già presenti riconosciuti e non duplicati
- “crea progetto villa” validato come elemento già presente
- “modifica evento” gestito come guida non operativa
- nessun edit flow alternativo introdotto
- feedback_mode introdotto in ui_state
- feedback project_created implementato
- feedback entity_created implementato
- feedback evento ordinario preservato
- feedback_resume adattato a Evento / Progetto / Entità
- ritorno Home automatico dopo feedback project/entity validato
- evento normale non regressivo validato
- edit evento reale non regressivo validato
- edit no-op / annulla modifica non regressivi validati
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato
- roadmap aggiornata post Command Intent
- Command Intent rimosso dai candidati futuri immediati
- aggiunti candidati INPUT RENDERING STABILITY / CONTAINER STRUCTURE
- aggiunto candidato INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER
- PREVIEW MODEL / HINT STATE CONSOLIDATION promosso tra candidati principali
- confermato blocco verso OUTPUT fino a data structure / economic direction / report readiness

v14 — 2026-05-18

- completamento UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
- integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- introdotto ui_visibility_state come Transformer read-only
- introdotto ui_visibility_mode come Variable Retool
- ui_visibility_mode supporta empty / event / command
- trigger_parse_debounced aggiorna ui_visibility_mode
- introdotto window.__logos_visibility_run_id per evitare update stale da debounce
- classificazione locale event/command usata solo per visibilità UI
- ui_visibility_state non sostituisce parser, matching, command_intent_state o create_suggestion_state
- Hidden principali centralizzati:
  - container_command_intent
  - sintesi
  - container_association_suggestions
  - text_event_data_title
  - select1
  - select_project
  - select_entity
  - button_input_confirm
  - btn_cancel_edit
  - btn_cancel_input_home
  - container_input
- container_input stabilizzato tramite ui_visibility_state.isInputFlow
- container vuoto durante digitazione risolto
- flash input flow ridotto
- container_app_nav corretto usando input_home.value al posto di input_raw.value
- bottom bar flash risolto
- text_input_analysis_loading introdotto vicino all’input principale
- text_edit_mode_notice introdotto per chiarire edit mode
- edit mode prevale su command intent
- durante edit mode scrivere “crea” non apre Command Intent
- btn_command_create_project / btn_command_create_entity allineati nel timing del feedback
- feedback project/entity funzionante con micro-flash residuo
- test obbligatori 1–16 superati
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- command_intent_state invariato
- preview content invariato
- button_input_confirm payload invariato
- insert_event / update_event invariati
- insert_project / insert_entity invariati
- Input Analysis Model completo non implementato
- Event Interpretation Engine non implementato
- residuo “modifica” generico non riconosciuto come guida edit documentato
- residuo micro-flash feedback project/entity documentato
- 5 linting Retool residui documentati
- INPUT RENDERING STABILITY / CONTAINER STRUCTURE rimosso dai candidati principali perché completato a primo livello tramite UI Readiness
- aggiunti candidati:
  - COMMAND INTENT — EDIT GUIDE GENERIC ALIAS
  - FEEDBACK MICRO-FLASH CLEANUP
  - LINTING / MINOR CLEANUP
  - CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION
- Dashboard resta non attiva
- istanze verticali restano non attive
- blocco verso OUTPUT confermato