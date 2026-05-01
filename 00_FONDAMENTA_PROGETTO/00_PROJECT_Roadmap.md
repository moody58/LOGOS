# 00_PROJECT_Roadmap_v07

DATA: 2026-05-01

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

---

FASE ATTIVA CONSIGLIATA:

STEP 6.4 — MATCH ENGINE UNIFICATION

---

FASE SUCCESSIVA CANDIDATA:

STEP 6.5 — HINT / PREVIEW STATE ALIGNMENT

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

⚠ matching non unificato  
⚠ presenza logiche parallele  
⚠ priority match non implementato  

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
✔ stabilizzazione UI flow (no flash)  
✔ separazione input → parsing → preview  

---

Output raggiunto:

✔ sistema deterministico reale  
✔ parsing stabile  
✔ UX fluida  
✔ nessun trigger circolare critico  
✔ base pronta per engine  

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

- creazione guidata project/entity
- relazioni entity-project
- gestione duplicati
- eventuale gerarchia entity/project

---

Output atteso:

- dati coerenti
- struttura stabile
- riduzione ambiguità strutturale

---

Stato:

⚠ non attivo  
⚠ opzionale prima di engine avanzato  
⚠ fortemente consigliato prima di deduplicazione / relazioni evolute  

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
⚠ matching non unificato     

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
⚠ matching non unificato  
⚠ preview non ancora view pura     

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
⚠ matching non unificato  
⚠ linting Retool residuo non bloccante  

---

Anomalie residue:

- edit_mode: 'value' is not defined
- editing_event: 'value' is not defined

Stato:

non bloccanti, fuori scope.

Nodo candidato:

LINTING / STATE HELPER CLEANUP 

------------------------------------------------

STEP 6.4 — MATCH ENGINE UNIFICATION (FASE ATTIVA CONSIGLIATA)

Obiettivo:

Eliminare logiche parallele di matching.

---

Problema reale:

Il sistema ha ora una catena type più coerente:

ui_state.parsed.unit
→ select1
→ payload.type
→ events.type

Ma il matching project/entity resta distribuito tra più logiche:

1. input_raw / ranking
2. select_project / select_entity deterministico
3. preview / detected locale

Conseguenze:

- incoerenza architetturale
- duplicazione logica
- possibili divergenze tra select e preview
- hint non sempre perfettamente allineati
- ambiguità project/entity difficili da governare
- priority match non implementato

---

Interventi candidati:

- analisi comportamento attuale project_state / entity_state
- analisi select_project / select_entity
- analisi detection locale preview
- definizione fonte unica per matching base
- allineamento hint/select/preview
- riduzione duplicazione logica
- eventuale priority match minimo
- nessuna deduplicazione strutturale
- nessuna gerarchia entity/project fuori scope

---

Stato:

→ fase attiva consigliata  
⚠ nodo dedicato necessario  
⚠ non anticipare data structure  
⚠ non introdurre dashboard/KPI  
⚠ non modificare schema DB  
⚠ non automatizzare creazione project/entity   

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
- matching non è stabilizzato nei punti critici
- incoerenze select / preview / state non sono ridotte
- dati non sono sufficientemente coerenti per aggregazioni affidabili
- eventuale direzione economica avanzata non è stata ancora valutata

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
finché matching e qualità dati non saranno ulteriormente stabilizzati.

------------------------------------------------
NODO ATTIVO CONSIGLIATO
------------------------------------------------

MATCH ENGINE UNIFICATION

------------------------------------------------
SCOPO NODO ATTIVO CONSIGLIATO
------------------------------------------------

Definire e implementare, se coerente, il primo livello controllato
di unificazione del matching.

Obiettivo:

ridurre incoerenze tra:

- input_raw / ranking
- select_project / select_entity
- preview / detected locale
- hint ambiguità

---

Ammesso:

✔ analisi comportamento attuale project_state  
✔ analisi comportamento attuale entity_state  
✔ analisi select_project / select_entity  
✔ analisi detected locale preview  
✔ confronto select / preview / hint  
✔ definizione fonte unica minima per matching base  
✔ eventuale priority match minimo  
✔ mantenimento auto-select solo se match univoco  
✔ mantenimento controllo utente  
✔ test runtime su project/entity ambigui  

---

Vietato:

❌ dashboard/KPI  
❌ data structure avanzata  
❌ deduplicazione entity/project  
❌ gerarchie entity/project  
❌ creazione automatica project/entity  
❌ modifica schema DB  
❌ refactor globale preview  
❌ refactor globale parser  
❌ classificazione type  
❌ retro-normalizzazione storico  
❌ automazioni decisionali definitive        

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
finché non vengono completati almeno:

1. Match Engine Unification o almeno stabilizzazione delle incoerenze critiche
2. riduzione delle incoerenze tra parsed data, select, preview e hint
3. valutazione della sufficienza di Type Classification Base per report iniziali
4. eventuale decisione su direzione economica avanzata / amount firmato / direction field

Nota:

Duration Normalization Base è completata.
Le durate certe ore/minuti sono ora normalizzate in minuti.

Nota:

Preview Alignment Base è completato.

Nota:

Type Classification Base è completata.
Il campo events.type viene ora valorizzato dal frontend,
ma non abilita ancora automaticamente KPI/reportistica.

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