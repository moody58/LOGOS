# 00_PROJECT_State_v13

DATA: 2026-05-01

------------------------------------------------
NODO ATTIVO:
------------------------------------------------

ENGINE BASE — TYPE CLASSIFICATION BASE — COMPLETATO

------------------------------------------------
FASE:
------------------------------------------------

STEP 4 — EVENT EDITING (COMPLETATO)

STEP 4.1 — INPUT SYSTEM STABILIZATION (COMPLETATO)

STEP 6.1 — ENGINE BASE / NORMALIZATION LAYER BASE (COMPLETATO)

PREVIEW ALIGNMENT BASE (COMPLETATO)

STEP 6.2 — ENGINE BASE / DURATION NORMALIZATION (COMPLETATO)

STEP 6.3 — ENGINE BASE / TYPE CLASSIFICATION BASE (COMPLETATO)

TRANSIZIONE → STEP 6.4 — MATCH ENGINE UNIFICATION

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- coperti tutti i layer sistema  
- parsing + matching completamente documentati  
- label layer integrato  
- normalizzazione base documentata  
- insert/update flow aggiornato  
- preview alignment documentato  
- duration normalization documentata  
- type classification base documentata  
- type persistito in events.type documentato  
- limiti matching/output esplicitati    

Q (Qualità): 9.5/10  
- stato coerente con sistema reale  
- distinzione chiara parsing / matching / label / normalization / preview / type  
- UX migliorata senza regressioni  
- sintesi allineata ai dati normalizzati  
- durate certe rese confrontabili tramite minuti canonici  
- type classification base prudente e controllata  
- controllo manuale utente preservato  
- debiti residui esplicitati  

D (Deployabilità): 10/10  
- pronto per Regia  
- stato completamente ricostruibile  
- nessuna dipendenza mancante  
- codice runtime principale documentato nei checkpoint  
- nodo Preview Alignment Base completato e validato runtime  
- nodo Duration Normalization completato e validato runtime  
- nodo Type Classification Base completato e validato runtime             

------------------------------------------------
IDENTIFICAZIONE PROGETTO
------------------------------------------------

Nome: LOGOS  
Tipo: Event Operating System  

Stack:

Frontend: Retool  
Backend: Supabase  
Logica: Client-side (JavaScript)  
Modello dati: Event Ledger (append-only controllato)  

------------------------------------------------
STATO GENERALE SISTEMA
------------------------------------------------

Sistema funzionante end-to-end:

INPUT  
→ PARSING  
→ NORMALIZATION BASE  
→ MATCHING  
→ PREVIEW (LABEL)  
→ INSERT / UPDATE  
→ PROCESSING  
→ FEEDBACK  

✔ sistema funzionante  
✔ utilizzabile in produzione reale  
✔ comportamento quasi deterministico  
✔ parsing base stabilizzato  
✔ normalizzazione amount/unit base implementata  
✔ duration normalization base implementata  
✔ durate certe ore/minuti normalizzate in minuti  
✔ preview allineata visivamente a ui_state.parsed  
✔ insert/update verificati su DB reale  
✔ refresh lista eventi corretto dopo save/update  
✔ type classification base implementata  
✔ select1 allineato a ui_state.parsed  
✔ type salvato in events.type  
✔ Spesa / Incasso / Tempo / Evento persistiti in DB  
✔ override manuale utente validato  

⚠ accoppiamento input / processing / UI ancora presente  
⚠ preview ancora layer ibrido, non view pura  
⚠ matching non unificato  
⚠ hint non completamente state-driven  
⚠ type classification base completata ma non ancora sufficiente per KPI avanzati    
⚠ giorni/settimane non convertiti automaticamente     

------------------------------------------------
AGGIORNAMENTO CRITICO (COMPLETATO)
------------------------------------------------

Il sistema è stabilizzato su sette layer fondamentali:

1. INPUT RELIABILITY — PARSING  
2. MATCHING BASE  
3. LABEL QUALITY  
4. ENGINE BASE — NORMALIZATION LAYER BASE  
5. PREVIEW ALIGNMENT BASE  
6. ENGINE BASE — DURATION NORMALIZATION  
7. ENGINE BASE — TYPE CLASSIFICATION BASE           

---

RISULTATO:

✔ insert e update usano ui_state.parsed come fonte unica  
✔ aggiornata lista eventi dopo save completato  
✔ preview visualmente allineata ai dati normalizzati  
✔ amount mostrato in formato italiano  
✔ unit visualizzate in modo coerente  
✔ label cleaning migliorato sui casi normalizzati  
✔ date separate correttamente nella sintesi  
✔ highlight preview non interferisce più con unità tecniche 
✔ durate certe ore/minuti normalizzate in minuti  
✔ 1 ora e 15 minuti supportato  
✔ 2h30 supportato  
✔ 2 ore 30 supportato  
✔ 1,5 ore convertito in minuti  
✔ preview durata mostra forma umana + valore normalizzato  
✔ giorni/settimane segnalati come durata ambigua 
✔ select1 usa ui_state.parsed.unit come fonte primaria per il tempo  
✔ parsed.unit = "minuti" imposta Tempo  
✔ parsed.unit = "euro" con keyword controllate distingue Spesa / Incasso  
✔ euro senza direzione chiara resta Evento  
✔ scelta manuale utente preservata  
✔ type inserito nel payload di salvataggio  
✔ insert_event salva events.type  
✔ update_event aggiorna events.type    

⚠ matching basato su stringhe (no fuzzy)  
⚠ hint limitati a logica base  
⚠ preview contiene ancora logiche proprie  
⚠ preview non è ancora view pura  
⚠ giorni/settimane non convertiti automaticamente  
⚠ forme colloquiali durata non implementate    

✔ introduzione EVENT EDITING

- edit_mode per distinzione INSERT / UPDATE
- update_event implementato
- riuso completo pipeline input per modifica

✔ introduzione updated_at

- tracciamento modifiche evento
- base per ordinamento dinamico lista

✔ introduzione NORMALIZATION BASE

- amount numerico coerente
- unit base standardizzate
- formato italiano numerico gestito
- numeri senza unità non interpretati come amount

✔ completamento PREVIEW ALIGNMENT BASE

- amount formattato in stile italiano nella sintesi
- euro mostrato con due decimali
- migliaia visualizzate correttamente
- ore/minuti mostrati con virgola italiana
- singolare/plurale unit gestito
- label ripulita da amount/unit già rappresentati
- bug "minuti" → "uti" risolto
- date separate dalla descrizione anche senza amount
- token tecnici esclusi dall'highlight locale
- nessuna modifica a parser, DB, matching o save flow

✔ completamento ENGINE BASE — DURATION NORMALIZATION

- durata canonica interna definita in minuti
- amount tempo salvato come totale minuti
- unit tempo salvata come "minuti"
- raw_input preservato come testo originario
- conversione ore → minuti implementata
- conversione ore + minuti implementata
- conversione h compatte implementata
- conversione ore decimali implementata
- giorni/settimane riconosciuti come ambigui ma non convertiti
- hint preview per valore normalizzato
- hint preview per durata ambigua
- nessuna modifica DB
- nessuna modifica save flow
- nessuna modifica matching
- nessuna type classification

✔ completamento ENGINE BASE — TYPE CLASSIFICATION BASE

- select1 allineato a ui_state.parsed
- parsed.unit = "minuti" → Tempo
- euro + keyword controllate di uscita → Spesa
- euro + keyword controllate di entrata → Incasso
- euro senza direzione chiara → Evento
- segnali economici contrastanti → Evento
- scelta manuale utente preservata
- type aggiunto al payload di button_input_confirm
- type salvato da insert_event
- type aggiornato da update_event
- events.type ora valorizzato nel DB
- override manuale validato su Spesa / Incasso
- reset/stale value verificato
- nessuna modifica schema DB
- nessuna modifica parser
- nessuna modifica matching
- nessun refactor preview
- nessun output/KPI anticipato

------------------------------------------------
AGGIORNAMENTO CRITICO — INPUT FLOW
------------------------------------------------

Refactor completo del sistema di parsing:

✔ introduzione parse_input_controlled (parser unico)
✔ eliminazione parse_input come source di verità
✔ introduzione debounce parsing
✔ eliminazione trigger per-lettera
✔ separazione input → parsing → UI
✔ stabilizzazione ui_state.parsed
✔ eliminazione parsing legacy nel bottone confirm

---

ARCHITETTURA ATTUALE:

input_home
→ input_raw
→ trigger_parse_debounced
→ parse_input_controlled
→ ui_state.parsed
→ preview / save / edit

---

SAVE FLOW ATTUALE:

ui_state.parsed
→ button_input_confirm payload
→ insert_event / update_event
→ Supabase
→ events_new refresh

---

RISULTATI:

✔ eliminato loop reattivo critico
✔ parsing stabile
✔ UX fluida (desktop + mobile)
✔ riduzione chiamate inutili
✔ base pronta per input vocale
✔ salvataggio coerente con parser controllato
✔ update coerente con parser controllato
✔ lista eventi aggiornata dopo save concluso

---

PRINCIPIO INTRODOTTO:

→ SINGLE SOURCE OF TRUTH = ui_state.parsed

- preview usa ui_state.parsed
- salvataggio usa ui_state.parsed
- edit usa ui_state.parsed
- insert/update non ricalcolano parsing

✔ eliminata duplicazione parsing
✔ eliminata divergenza save / DB
✔ ridotto rischio drift tra create/edit

------------------------------------------------
AGGIORNAMENTO CRITICO — NORMALIZATION LAYER BASE
------------------------------------------------

È stato implementato il primo blocco minimo di Engine Base:

ENGINE BASE — NORMALIZATION LAYER BASE

Obiettivo:

- rendere più coerenti i dati già parsati
- normalizzare amount e unit
- evitare interpretazioni errate di numeri non quantitativi
- mantenere il database invariato
- non introdurre semantica avanzata

---

AMBITO IMPLEMENTATO:

✔ amount normalization  
✔ unit normalization base  
✔ numeri senza unità ignorati come amount  
✔ formato numerico italiano supportato  
✔ insert/update verificati  
✔ refresh lista corretto dopo update  

---

AMBITO ORA EVOLUTO NEL NODO SUCCESSIVO:

✔ conversione ore/minuti implementata in Duration Normalization  
✔ 1 ora e 15 minuti → 75 minuti  
✔ 2h30 → 150 minuti  
✔ 2 ore 30 → 150 minuti  
✔ 1,5 ore → 90 minuti  

AMBITO ANCORA NON IMPLEMENTATO:

✘ conversione automatica giorni / settimane  
✘ giornata lavorativa  
✘ mezza giornata  
✘ parole numeriche tipo “due ore”  
✘ forme colloquiali tipo “un paio d’ore”  
✘ spesa / incasso  

------------------------------------------------
NORMALIZATION RULES — BASE
------------------------------------------------

## UNIT NORMALIZATION

Unità supportate:

EURO:

- €
- euro
- eur

Output normalizzato:

- euro

TEMPO:

- ora
- ore
- h
- min
- minuto
- minuti

Output normalizzato dopo Duration Normalization:

- minuti

Regola:

tutte le durate certe espresse in ore/minuti vengono convertite in minuti.

Formati supportati:

- 1 ora
- 1ora
- 2 ore
- 2ore
- 2h
- h2
- 18 min
- 18min
- 30 minuti
- 30minuti
- min30
- 1,5 ore
- 1.5 ore
- 1,5h
- 1.5h

Conversione canonica:

1 ora → 60 minuti  
1ora → 60 minuti  
2 ore → 120 minuti  
2h → 120 minuti  
h2 → 120 minuti  
18 min → 18 minuti  
18min → 18 minuti  
30 minuti → 30 minuti  
min30 → 30 minuti  
1,5 ore → 90 minuti  
1.5 ore → 90 minuti  
1 ora e 15 minuti → 75 minuti  
2h30 → 150 minuti  
2 ore 30 → 150 minuti  
2 ore e 30 minuti → 150 minuti  

---

## AMOUNT NORMALIZATION

Amount viene salvato come numero, non come stringa localizzata.

Regole:

458,78 → 458.78  
1,5 → 1.5  
1.5 → 1.5  
1.500 → 1500  
1.500,50 → 1500.5  
1500 → 1500  

---

## NUMERI SENZA UNITÀ

Regola:

Se non esiste unità riconosciuta, amount = null.

Esempi:

villa 2 → amount null  
villa 2 mario → amount null  
cliente 2026 → amount null  

Motivo:

- evitare che numeri semantici diventino quantità
- preservare casi come “villa 2”
- ridurre errori permanenti nel DB

---

## DATE

event_date continua a essere gestito dal parser controllato.

Supporto attuale:

- 6/4/26
- 06/04/2026
- 4 aprile

Non implementato:

- oggi
- domani
- ieri
- prossima settimana
- date relative

------------------------------------------------
PREVIEW ALIGNMENT — BASE
------------------------------------------------

È stato completato il nodo:

PREVIEW ALIGNMENT BASE

Obiettivo:

- allineare la sintesi ai dati già normalizzati in ui_state.parsed
- migliorare la leggibilità del dato parsato
- formattare amount/unit in stile italiano
- correggere label cleaning nei casi già normalizzati
- evitare interferenze visuali dell'highlight sulle unità tecniche
- mantenere invariati parser, DB, matching e save flow

---

AMBITO IMPLEMENTATO:

✔ formatAmountIT  
✔ formatUnitIT  
✔ grouping migliaia  
✔ euro con due decimali  
✔ ore/minuti con decimali italiani  
✔ singolare/plurale unit  
✔ label cleaning amount/unit  
✔ rimozione residuo "uti"  
✔ separatore data/descrizione  
✔ previewStopTokens per highlight locale  

---

ESEMPI VALIDATI:

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

2,7 ore sviluppo sistema aspri  
→ 2,7 ore • sviluppo sistema aspri  

---

REGOLA CRITICA:

La formattazione italiana è solo visuale.

Il dato interno resta numerico.

Esempio:

input:
1.500,50 euro

ui_state.parsed.amount:
1500.5

ui_state.parsed.unit:
euro

preview:
1.500,50 €

DB:
amount 1500.5
unit euro

---

AMBITO NON IMPLEMENTATO:

✔ duration normalization implementata nel nodo successivo  
✔ 1 ora e 15 minuti supportato  
✔ 2h30 supportato  
✔ 2 ore 30 supportato  
✘ giorni / settimane non convertiti automaticamente   
✘ type classification  
✘ spesa / incasso  
✘ matching unificato  
✘ preview come view pura completa  

------------------------------------------------
TYPE CLASSIFICATION — BASE
------------------------------------------------

È stato completato il nodo:

ENGINE BASE — TYPE CLASSIFICATION BASE

Obiettivo:

- distinguere in modo controllato Evento / Tempo / Spesa / Incasso
- allineare select1 alla nuova Duration Normalization
- usare ui_state.parsed.unit come segnale primario
- rendere persistente il type nel DB
- mantenere controllo manuale utente
- evitare classificazioni economiche aggressive

---

AMBITO IMPLEMENTATO:

✔ select1 allineato a ui_state.parsed.unit  
✔ parsed.unit = "minuti" → Tempo  
✔ euro + keyword controllate di uscita → Spesa  
✔ euro + keyword controllate di entrata → Incasso  
✔ euro senza direzione chiara → Evento  
✔ segnali contrastanti → Evento  
✔ type aggiunto al payload di button_input_confirm  
✔ insert_event salva events.type  
✔ update_event aggiorna events.type  
✔ override manuale utente validato  
✔ reset/stale value verificato  
✔ DB schema invariato  
✔ parser invariato  
✔ matching invariato  
✔ preview globale invariata  

---

VALORI TYPE ATTUALI:

- Evento
- Tempo
- Spesa
- Incasso

---

REGOLE CONSOLIDATE:

Tempo:

parsed.unit = "minuti"
→ select1 = Tempo

Esempi:

2h30 rendering  
→ type Tempo  
→ amount 150  
→ unit minuti  

1 ora e 45 minuti lavoro  
→ type Tempo  
→ amount 105  
→ unit minuti  

---

Spesa:

euro + keyword controllate di uscita

Esempi:

20 euro spesa materiale  
→ type Spesa  

20 euro acquisto materiale  
→ type Spesa  

20 euro pagato materiale  
→ type Spesa  

20 euro acconto dato  
→ type Spesa  

20 euro saldo pagato  
→ type Spesa  

---

Incasso:

euro + keyword controllate di entrata

Esempi:

20 euro incasso cliente  
→ type Incasso  

20 euro vendita cucciolo  
→ type Incasso  

20 euro acconto ricevuto  
→ type Incasso  

20 euro pagamento ricevuto  
→ type Incasso  

---

Evento / fallback prudente:

euro senza direzione chiara
→ Evento

segnali economici contrastanti
→ Evento

nessuna unit significativa
→ Evento

Esempi:

20 euro materiale  
→ type Evento  

20 euro acconto  
→ type Evento  

20 euro spesa incasso  
→ type Evento  

villa 2 mario  
→ type Evento  

2 giorni rendering  
→ type Evento  

4 aprile benzina 50 euro alfie allevamento aspri  
→ type Evento  

---

REGOLA CRITICA:

La classificazione automatica è prudente.

Il sistema suggerisce una classificazione base,
ma l’utente può sempre modificare select1 manualmente.

La scelta manuale viene salvata in events.type.

---

TEST VALIDATI:

2h30 rendering  
→ type Tempo  
→ amount 150  
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

Update evento precedente:

1 ora e 45 minuti lavoro  
→ type Tempo  
→ amount 105  
→ unit minuti  
→ updated_at aggiornato  

Override manuale:

20 euro materiale + select1 manuale Spesa  
→ type Spesa  

20 euro materiale + select1 manuale Incasso  
→ type Incasso  

---

AMBITO NON IMPLEMENTATO:

✘ classificazione economica avanzata  
✘ dizionario esteso keyword  
✘ classificazione automatica da parole di dominio  
✘ benzina/materiale/mangime → Spesa automatica  
✘ valori negativi automatici per Spesa  
✘ valori positivi automatici per Incasso  
✘ amount firmato  
✘ direction field  
✘ KPI / dashboard / reportistica  
✘ retro-normalizzazione eventi storici  
✘ bonifica type eventi precedenti  
✘ match engine unification  

---

ANOMALIE RESIDUE:

1. Linting Retool non bloccante:

- edit_mode: 'value' is not defined
- editing_event: 'value' is not defined

Stato:

non bloccante, fuori scope.

Azione futura:

micro-nodo LINTING / STATE HELPER CLEANUP.

---

2. Matching non unificato:

restano logiche separate:

- input_raw / ranking
- select_project / select_entity deterministico
- preview / detected locale

Stato:

fuori scope.

Azione futura:

STEP 6.4 — MATCH ENGINE UNIFICATION.

---

3. Eventi storici senza type:

eventi creati prima della patch possono avere type null.

Stato:

fuori scope.

Azione futura:

eventuale bonifica solo con nodo dedicato.

------------------------------------------------
AGGIORNAMENTO UX
------------------------------------------------

Il sistema è stato aggiornato nel layer preview/hint:

✔ introduzione hint multipli  
✔ introduzione gerarchia visiva  
✔ eliminazione hint prematuri  
✔ attivazione controllata  
✔ separazione semantica colori  
✔ allineamento visuale amount/unit  
✔ formattazione italiana amount  
✔ separazione data/descrizione  
✔ label cleaning migliorato  
✔ highlight unit-safe  

RISULTATO:

✔ UX più chiara  
✔ nessuna ambiguità nascosta  
✔ miglior supporto decisionale utente  
✔ sintesi più leggibile  
✔ dato visuale coerente con dato normalizzato  
✔ ridotta divergenza parser / preview  
✔ durata visualizzata in forma umana quando internamente normalizzata  
✔ hint “Normalizzato: X minuti” introdotto  
✔ hint durata ambigua per giorni/settimane introdotto  

⚠ hint ancora scollegati da state unificato  
⚠ duplicazione logica detection  
⚠ preview ancora layer ibrido  
⚠ preview non ancora view pura  

------------------------------------------------
COMPONENTI ATTIVI
------------------------------------------------

INPUT LAYER

- input_home (input utente)
- input_raw (adapter tecnico)
- trigger_parse_debounced
- parse_input_controlled

---

NORMALIZATION BASE

- incorporata attualmente in parse_input_controlled
- normalizza amount
- normalizza unit
- normalizza durate certe in minuti
- preserva event_date
- non modifica raw_input
- non modifica DB schema
- non converte automaticamente giorni/settimane

---

TYPE CLASSIFICATION BASE

- select1
- usa ui_state.parsed.unit come segnale primario
- classifica Tempo se unit = minuti
- classifica Spesa / Incasso tramite keyword controllate
- mantiene Evento come default prudente
- mantiene scelta manuale utente
- type salvato in events.type
- non modifica parser
- non modifica matching
- non modifica schema DB

---

MATCHING LAYER

- select_project
- select_entity
- project_state
- entity_state
- logiche di matching distribuite

---

LABEL LOGIC (EMBEDDED)

- generazione label dentro preview
- pipeline non distruttiva
- cleaning amount/unit aggiornato
- gestione unità compatte migliorata
- preservazione numeri semantici
- NON separata come layer runtime
- NON persistita

---

PROCESSING LAYER

- lista eventi NEW
- gestione WRITTEN / ERROR
- supporto edit su eventi NEW

---

UI STATE

ui_state:

{
  view: "home" | "feedback" | "events",
  parsed: {
    amount,
    unit,
    event_date
  },
  status,
  feedback_text,
  feedback_project
}

✔ state centralizzato
✔ parsed sempre strutturato
✔ parsing condiviso tra layer
✔ UI completamente state-driven

---

FEEDBACK SYSTEM

✔ attivazione immediata
✔ gestione view tramite ui_state
✔ eliminato doppio trigger UI
✔ nessun flash feedback rilevato

FLOW:

submit →
ui_state.view = feedback →
reset input →
insert/update async →
await save →
events_new refresh

---

✔ UX immediata
✔ nessun flicker
✔ feedback consistente
✔ resume basato su ui_state
✔ lista eventi aggiornata dopo save reale

------------------------------------------------
PARSING SYSTEM (STABILIZZATO)
------------------------------------------------

TIPO:

✔ deterministico  
✔ proximity-based  
✔ multi-formato  
✔ normalizzato base  

---

UNITÀ SUPPORTATE

EURO:

€, euro, eur  
€20 / 20€ / € 20  

---

TEMPO:

ore: ora, ore, h  
minuti: min, minuto, minuti  

formati:

2h, h2, 2 h  
1ora, 2ore  
30min, min30, 30 minuti, 30minuti  
0.5h, 1.5 ore, 1,5 ore  

✔ supporto unit compatte senza spazi
✔ supporto forme testuali compatte
✔ conversione canonica ore/minuti in minuti
✔ supporto durate composte
✔ supporto 1 ora e 15 minuti
✔ supporto 2h30
✔ supporto 2 ore 30
✔ supporto ore decimali convertite in minuti

---

ESTRAZIONE AMOUNT

- matchAll numeri
- selezione per prossimità alla unità
- gestione corretta multi-numero
- numero selezionato in base alla unit più rilevante
- nessun amount se manca unità

---

DECIMALI E MIGLIAIA

✔ virgola decimale italiana  
✔ punto decimale compatibile  
✔ punto migliaia italiano  
✔ migliaia + decimali  

Esempi:

1,5 → 1.5  
1.5 → 1.5  
1.500 → 1500  
1.500,50 → 1500.5  

---

GESTIONE ORARI

✔ HH:MM ignorato come amount  

Esempio:

15:30 test → amount null

---

FIX CRITICI INTRODOTTI

✔ eliminato fallback su "h"  
→ evitati falsi positivi ("macchina")

✔ numero finale senza unità ignorato  
→ "villa 2" NON genera amount

✔ gestione corretta unit compatte  
→ "2h", "18min", "0.5h", "1ora", "2ore"

✔ selezione amount corretta su input complessi  
→ "villa 2 mario rossi 3h" → 3

✔ gestione separatore italiano  
→ "1.500,50 euro" → 1500.5

---

LABEL CLEANING

- rimozione amount + unit
- rimozione preposizioni base
- mantenimento significato

⚠ NON utilizzato per persistenza
⚠ NON utilizzato come fonte dati strutturata
⚠ resta logica embedded nella preview

---

LIMITI CONSAPEVOLI

- giorni/settimane non convertiti automaticamente
- giornata/mezza giornata non normalizzate
- parole numeriche tipo “due ore” non supportate
- forme colloquiali tipo “un paio d’ore” non supportate
- parsing non semantico
- type classification non consolidata

---

ARCHITETTURA PARSING (AGGIORNATA)

✔ parsing NON più inline nel save
✔ parsing NON duplicato nel bottone confirm
✔ parsing NON dipendente dal bottone
✔ parsing consumato tramite ui_state.parsed

---

TRIGGER:

✔ debounce
✔ trigger controllato

---

CONSUMO:

✔ preview → ui_state.parsed
✔ save → ui_state.parsed
✔ edit → trigger parse manuale

---

✔ sistema consistente in create/edit
✔ insert verificato
✔ update verificato

------------------------------------------------
LABEL SYSTEM (STABILIZZATO)
------------------------------------------------

TIPO:

✔ deterministico  
✔ non distruttivo  
✔ derivato  
✔ non persistito  

---

PIPELINE:

- normalizzazione testo
- rimozione amount + unit
- gestione unit compatte
- rimozione stopwords base
- numeric safe
- compound token
- sorting alfabetico stabile

---

PRINCIPI:

✔ nessuna perdita informazione
✔ nessuna interpretazione semantica
✔ nessuna modifica DB

---

OUTPUT:

- label coerenti
- variabilità ridotta
- maggiore leggibilità

✔ formattazione italiana amount allineata nella preview  
✔ rimozione amount/unit dalla label migliorata  
✔ bug residuo "uti" risolto  
✔ numeri semantici preservati  

⚠ preview/label non sono ancora view pure  
⚠ logica ancora embedded nella sintesi  
⚠ cleaning non ancora separato come modulo runtime  

------------------------------------------------
MATCHING SYSTEM (STABILIZZATO MA NON UNIFICATO)
------------------------------------------------

PRINCIPI:

✔ suggerire ≠ decidere  
✔ no inferenze automatiche definitive  
✔ utente in controllo  

---

PROJECT MATCH

- split parole nome
- filtro parole
- match per parole
- disambiguazione numerica

---

ENTITY MATCH

STRONG:

- match nome completo

FULL:

- tutte parole presenti
- parole ≥4 caratteri

PARTIAL:

- match su token significativi
- almeno una parola ≥4 caratteri in comune

---

AUTO-SELECT

✔ solo match univoco
✔ nessuna forzatura

---

AGGIUNTE UX MATCHING

- soglia attivazione hint
- gestione ambiguità input corto
- riduzione suggerimenti ridondanti

---

RISULTATI

✔ riduzione falsi positivi

⚠ ambiguità non sempre correttamente segnalata
⚠ riconoscimento entity non sempre consistente
⚠ affidabilità suggerimenti variabile su input complessi

---

PROBLEMA STRUTTURALE APERTO

Presenza di più sistemi di matching:

1. input_raw / ranking
2. select deterministico
3. preview / detected

Conseguenze:

- incoerenza architetturale
- duplicazione logica
- difficoltà evoluzione engine

⚠ PRIORITY MATCH NON IMPLEMENTATO

------------------------------------------------
PREVIEW SYSTEM
------------------------------------------------

✔ preview = parsing reale + label  
✔ rappresentazione coerente lato utente  
✔ allineata ai dati salvati nei valori principali  
✔ allineata visualmente a ui_state.parsed per amount/unit/date  
✔ amount formattato in stile italiano  
✔ euro con due decimali  
✔ migliaia visualizzate correttamente  
✔ unit tempo coerenti  
✔ singolare/plurale gestito  
✔ date separate correttamente dalla descrizione  
✔ label cleaning migliorato sui casi normalizzati  
✔ highlight unit-safe  

⚠ contiene ancora logiche di trasformazione  
⚠ non è una view pura  
⚠ hint non completamente state-driven  
⚠ presenza duplicazione detected vs state  
⚠ matching locale preview non unificato  

STRUTTURA:

MAIN:

event_date + amount + unit + label  

META:

project + entity  

HINT:

- suggerimenti matching
- suggerimenti tipo
- hint durata ambigua

✔ supporto multi-hint
✔ hint NON bloccanti

Gerarchia visiva:

- rosso → ambiguità
- arancione → azione richiesta
- grigio → suggerimento soft

---

Esempi validati:

1.500,50 euro materiale
→ 1.500,50 € • materiale

18 minuti test
→ 18 minuti • test

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

2 ore sopralluogo villa 2
→ 2 ore • sopralluogo villa 2
→ Normalizzato: 120 minuti

1 ora e 15 minuti sopralluogo
→ 1 ora 15 minuti • sopralluogo
→ Normalizzato: 75 minuti

2h30 rendering
→ 2 ore 30 minuti • rendering
→ Normalizzato: 150 minuti

2 giorni rendering
→ 2 giorni rendering
→ Durata ambigua: specifica ore/minuti per salvarla come tempo analizzabile

---

NOTA:

La preview rappresenta meglio i dati normalizzati,
ma resta ancora embedded con:

- label cleaning
- hint logic
- highlight locale
- detection locale project/entity

La separazione in view pura non è stata implementata.

------------------------------------------------
INSERT
------------------------------------------------

insert_event attivo

Scrittura:

- raw_input
- type
- amount
- unit
- event_date
- project_id
- entity_id
- status = NEW
- updated_at
- payload = {}

✔ amount coerente con ui_state.parsed
✔ unit coerente con ui_state.parsed
✔ type coerente con select1.value
✔ raw_input sempre valorizzato
✔ dati salvati correttamente
✔ nessun blocco runtime attuale
✔ label NON persistita
✔ nessuna validazione bloccante
✔ parser duplicato nel bottone rimosso

Test validato:

1.500,50 euro test engine
→ amount 1500.5
→ unit euro
→ status NEW

------------------------------------------------
UPDATE
------------------------------------------------

update_event attivo

Scrittura:

- raw_input
- type
- amount
- unit
- project_id
- entity_id
- event_date
- updated_at

✔ modifica evento senza duplicazione
✔ riuso pipeline input
✔ update consentito solo su eventi NEW
✔ update usa ui_state.parsed
✔ update aggiorna events.type
✔ DB aggiornato correttamente
✔ lista eventi aggiornata subito dopo save

Problema risolto:

- events_new veniva refreshato prima del completamento update_event
- la lista mostrava temporaneamente dati vecchi
- corretto con await savePromise → await events_new.trigger()

------------------------------------------------
DATABASE
------------------------------------------------

Tabelle:

- events
- projects
- entities

---

CARATTERISTICHE:

✔ database passivo
✔ nessuna logica business
✔ nessuna validazione applicativa
✔ presenza campo updated_at
✔ amount numeric
✔ unit text
✔ raw_input preservato

---

LIMITI:

- entity senza gerarchia
- type utilizzato per classificazione base Evento / Tempo / Spesa / Incasso
- dati storici non normalizzati retroattivamente
- nessun versioning modifiche
- payload non utilizzato

---

NOTA:

Lo schema DB NON è stato modificato durante il nodo Normalization Layer Base.

------------------------------------------------
PROCESSING
------------------------------------------------

Lista eventi NEW

Azioni:

✔ WRITTEN  
✔ ERROR  

---

✔ decisione manuale
✔ nessuna automazione
✔ supporto EDIT

FLOW:

NEW → EDIT → NEW  
NEW → WRITTEN  
NEW → ERROR  

---

Aggiornamento:

- events_new ordinata su updated_at / created_at
- refresh dopo save completato
- update visibile senza refresh pagina

------------------------------------------------
UI ARCHITECTURE
------------------------------------------------

Single Page App (Retool)

Container:

- home
- input
- feedback
- events_list

---

✔ state-driven
✔ nessun routing
✔ logica client-side
✔ gestione stato centralizzata via ui_state
✔ eliminati trigger multipli UI critici
✔ save flow ripulito
✔ bottone confirm non contiene più parsing duplicato

------------------------------------------------
FUNZIONALITÀ IMPLEMENTATE
------------------------------------------------

✔ inserimento eventi rapido  
✔ parsing robusto reale  
✔ supporto varianti input  
✔ normalizzazione amount base  
✔ normalizzazione unit base  
✔ supporto formato numerico italiano  
✔ gestione numeri senza unità  
✔ matching project/entity stabile  
✔ suggerimenti non invasivi  
✔ preview coerente nei dati principali  
✔ allineamento save = DB  
✔ label cleaning non distruttivo  
✔ riduzione variabilità descrizioni  
✔ hint intelligenti  
✔ gestione eventi NEW  
✔ conferma manuale  
✔ UI stabile  
✔ feedback post-insert  
✔ gestione multi-hint  
✔ gerarchia visiva feedback  
✔ controllo attivazione hint  
✔ EVENT EDITING  
✔ UPDATE FLOW  
✔ tracciamento updated_at  
✔ ordinamento eventi per modifica  
✔ centralizzazione UI state  
✔ stabilizzazione feedback flow  
✔ parser duplicato nel bottone rimosso  
✔ refresh lista dopo save completato
✔ preview alignment base completato  
✔ formattazione italiana amount in preview  
✔ euro con due decimali visuali  
✔ grouping migliaia visuale  
✔ unità tempo visualizzate coerentemente  
✔ label cleaning preview aggiornato  
✔ bug "minuti" → "uti" risolto  
✔ date separate correttamente in sintesi  
✔ highlight unit-safe    
✔ duration normalization base completata  
✔ durate certe convertite in minuti  
✔ unità canonica tempo = minuti  
✔ 1 ora e 15 minuti supportato  
✔ 2h30 supportato  
✔ 2 ore 30 supportato  
✔ 1,5 ore convertito in 90 minuti  
✔ preview durata in forma umana  
✔ hint normalizzazione durata  
✔ hint durata ambigua per giorni/settimane 
✔ type classification base completata  
✔ select1 allineato a ui_state.parsed  
✔ parsed.unit = minuti → Tempo  
✔ euro + keyword controllate → Spesa / Incasso  
✔ euro senza direzione chiara → Evento  
✔ type salvato in events.type  
✔ update_event aggiorna type  
✔ override manuale utente validato  
✔ reset/stale value type verificato     

------------------------------------------------
FUNZIONALITÀ NON IMPLEMENTATE
------------------------------------------------

INPUT

- parsing semantico
- giorni / settimane come conversione automatica
- parole numeriche tipo “due ore”
- forme colloquiali tipo “un paio d’ore”
- date relative

---

NORMALIZATION

- conversione automatica giorni/settimane
- giornata lavorativa
- mezza giornata
- 2 giorni rendering come minuti automatici
- payload duration
- campo duration_minutes dedicato

---

TYPE

- classificazione economica avanzata
- dizionario esteso keyword
- classificazione automatica da parole di dominio
- amount firmato per Spesa/Incasso
- direction field
- retro-normalizzazione type eventi storici
- uso type per KPI avanzati

---

MATCHING

- gerarchia entity
- disambiguazione avanzata
- ranking
- priority match engine
- unificazione logiche

---

HINT SYSTEM

- integrazione completa con state unificato
- hint totalmente derivati da engine

---

DATA STRUCTURE

- relazioni entity
- deduplicazione
- normalizzazione relazioni

---

OUTPUT

- dashboard
- analytics
- KPI
- reportistica

------------------------------------------------
PROBLEMI REALI IDENTIFICATI
------------------------------------------------

1. DATA PARZIALMENTE NORMALIZZATI

- amount/unit base ora normalizzati
- durate certe ore/minuti ora normalizzate in minuti
- giorni/settimane non convertiti automaticamente
- dati storici non retro-normalizzati

---

2. ENTITY NON STRUTTURATE

- nessuna gerarchia
- ambiguità inevitabile

---

3. TYPE BASE IMPLEMENTATO MA NON AVANZATO

- type classification base completata
- Evento / Tempo / Spesa / Incasso salvati in events.type
- Spesa / Incasso distinguibili solo tramite keyword controllate o scelta manuale
- euro senza direzione chiara resta Evento
- amount resta positivo
- nessuna logica contabile avanzata
- type non ancora sufficiente da solo per KPI avanzati

---

4. UI LIMITI

- input non multilinea
- preview ancora ibrida
- preview migliorabile come separazione architetturale
- formattazione amount localizzata in preview

---

5. ENGINE PARZIALE

- Normalization Layer Base completato
- engine semantico non implementato
- duration normalization base implementata
- duration avanzata giorni/settimane non implementata
- type classification base implementata
- type classification avanzata non implementata

---

6. DUPLICAZIONE MATCHING

- più logiche indipendenti
- incoerenza tra layer

---

7. HINT NON STATE-DRIVEN COMPLETO

- uso detected*
- non pienamente allineati a select / engine

---

8. PRIORITÀ MATCH ASSENTE

- impossibile distinguere match dominante

---

9. LOOP REATTIVO

RISOLTO per input/parsing principale

---

10. ACCOPPIAMENTO LAYER

- input non completamente separato da processing
- preview non read-only puro
- preview alignment migliorato ma non separato come view pura

---

11. MATCHING NON UNIFICATO

- 3 logiche separate
- incoerenza tra select / preview / ranking

------------------------------------------------
PROBLEMI RISOLTI
------------------------------------------------

✔ parsing fragile → RISOLTO  
✔ preview incoerente nei dati salvati → RISOLTO  
✔ falsi positivi matching → RIDOTTI  
✔ comportamento non deterministico → RISOLTO  
✔ perdita unit → RISOLTA  
✔ mismatch amount → RISOLTO  
✔ divergenza save / DB → RISOLTA  
✔ variabilità label → RIDOTTA  
✔ rumore UX → RIDOTTO  
✔ unit attaccate → RISOLTE  
✔ unit compatte testuali → RISOLTE  
✔ duplicazione suggerimenti → RISOLTA  
✔ hint incoerenti → RIDOTTI  
✔ hint prematuri → RISOLTI  
✔ perdita multi-anomalia → RISOLTA  
✔ UX hint migliorata → RISOLTA  
✔ loop reattivo input → RISOLTO  
✔ parsing per-lettera → RISOLTO  
✔ duplicazione parsing nel save → RISOLTA  
✔ desync edit/preview → RISOLTO  
✔ errore ui_state.setValue → RISOLTO  
✔ flash UI feedback → RISOLTO  
✔ blocco UX su save → RISOLTO  
✔ amount senza unità → RISOLTO  
✔ formato italiano numerico → RISOLTO  
✔ refresh lista dopo update → RISOLTO 
✔ formattazione amount preview → RISOLTA  
✔ visualizzazione euro italiana → RISOLTA  
✔ grouping migliaia preview → RISOLTO  
✔ bug "minuti" → "uti" → RISOLTO  
✔ duplicazione amount/unit nella label → RIDOTTA  
✔ separatore data/label → RISOLTO  
✔ highlight improprio su unità → RISOLTO  
✔ preview alignment base → COMPLETATO  
✔ duration normalization base → COMPLETATO  
✔ durate ore/minuti non confrontabili → RISOLTE  
✔ 1 ora e 15 minuti non normalizzato → RISOLTO  
✔ 2h30 non normalizzato → RISOLTO  
✔ 2 ore 30 non normalizzato → RISOLTO  
✔ ore decimali non convertite in minuti → RISOLTO  
✔ preview durata tecnica poco leggibile → RISOLTA  
✔ giorni/settimane silenziosi → RIDOTTI tramite hint ambiguità  
✔ select1 non allineato a Duration Normalization → RISOLTO  
✔ 2h30 mostrato come Evento → RISOLTO  
✔ type non persistito in DB → RISOLTO  
✔ insert_event senza type → RISOLTO  
✔ update_event senza type → RISOLTO  
✔ override manuale type non validato → RISOLTO   

------------------------------------------------
STATO LAYER SISTEMA
------------------------------------------------

Layer 1 — Input: ~96%  
Layer 2 — Matching: ~75%  
Layer 3 — View / Preview: ~88%  
Layer HINT SYSTEM: ~90%  
Layer 4 — Data Structure: ~20%  
Layer 5 — Engine: ~36%  
Layer 6 — Output: 0%  

---

STATO COMPLESSIVO:

~78%

------------------------------------------------
FASE ATTUALE
------------------------------------------------

✔ INPUT RELIABILITY — COMPLETATA  
✔ MATCHING BASE — COMPLETATO  
✔ LABEL QUALITY — COMPLETATO  
✔ EVENT EDITING — COMPLETATO  
✔ INPUT SYSTEM STABILIZATION — COMPLETATA  
✔ ENGINE BASE — NORMALIZATION LAYER BASE — COMPLETATO  
✔ PREVIEW ALIGNMENT BASE — COMPLETATO  
✔ ENGINE BASE — DURATION NORMALIZATION — COMPLETATO  
✔ ENGINE BASE — TYPE CLASSIFICATION BASE — COMPLETATO  

---

TRANSIZIONE:

→ STEP 6.4 — MATCH ENGINE UNIFICATION

------------------------------------------------
OBIETTIVO IMMEDIATO
------------------------------------------------

Stabilizzare il passaggio successivo dell'Engine Base senza introdurre nuova complessità.

Priorità immediata consigliata:

STEP 6.4 — MATCH ENGINE UNIFICATION

Obiettivo:

- eliminare incoerenze tra logiche parallele di matching
- allineare input_raw / ranking, select deterministico e preview detection
- ridurre duplicazione logica project/entity
- migliorare coerenza hint/select/preview
- mantenere controllo utente
- non introdurre dashboard/KPI
- non modificare schema DB
- non introdurre relazioni entity/project fuori nodo

------------------------------------------------
VINCOLI OPERATIVI
------------------------------------------------

✔ nessun refactor globale  
✔ nessuna modifica architettura non necessaria  
✔ nessuna AI  
✔ nessuna automazione decisionale  
✔ miglioramenti incrementali  
✔ una sessione = un nodo  
✔ ogni nodo deve produrre checkpoint  

------------------------------------------------
NOTE STRATEGICHE
------------------------------------------------

Il sistema:

✔ è funzionale  
✔ è utilizzabile  
✔ è estendibile  
✔ ha una prima base engine reale  
⚠ non è ancora stabile architetturalmente in tutti i layer  

---

La label è:

→ layer derivato  
→ non persistito  
→ base utile per evoluzione preview / engine  
→ ancora embedded nella preview  

---

Priorità aggiornata:

1. input reliability ✔  
2. label quality ✔  
3. normalization layer base ✔  
4. preview alignment ✔  
5. duration normalization ✔  
6. type classification base ✔  
7. match engine unification  
8. output          

---

Il sistema attuale è:

✔ UX-driven  
✔ safe  
✔ non decisionale  
✔ progressivamente normalizzato  

---

PRIORITÀ FUTURE:

1. matching unification  
2. hint state-driven  
3. data structure / entity relations  
4. semantic engine avanzato  
5. dashboard / KPI        

------------------------------------------------
NEXT NODES CANDIDATI
------------------------------------------------

1. MATCH ENGINE UNIFICATION

Scopo:

- eliminare logiche parallele
- costruire priority match
- rendere hint/select/preview coerenti
- ridurre ambiguità project/entity
- mantenere controllo utente

---

2. LINTING / STATE HELPER CLEANUP

Scopo:

- risolvere linting residui Retool:
  - edit_mode: 'value' is not defined
  - editing_event: 'value' is not defined
- verificare binding/helper state
- evitare rumore tecnico futuro

---

3. EVENTS LIST LABEL / UPDATED_AT DISPLAY FIX

Scopo:

- correggere dicitura "modificato oggi" su eventi appena inseriti
- distinguere visivamente created_at / updated_at
- evitare falso messaggio di modifica su primo inserimento
- intervento UX/lista eventi, non engine

---

4. DURATION ADVANCED — GIORNI / SETTIMANE

Scopo:

- decidere conversione giorni/settimane
- valutare giornata lavorativa
- valutare mezza giornata
- evitare conversioni automatiche ambigue
- nodo non prioritario rispetto a matching

---

5. ECONOMIC DIRECTION ADVANCED

Scopo:

- valutare amount firmato
- valutare direction field
- valutare regole contabili per Spesa/Incasso
- non attivo finché type base e matching non sono stabili

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01  
documento iniziale  

v02 — 2026-04-02  
parsing retrofit  

v03 — 2026-04-03  
matching retrofit  

v04 — 2026-04-03  
fix insert pipeline  

v05 — 2026-04-04  
introduzione label layer  
implementazione label pipeline  
miglioramento UX hint  
riduzione variabilità descrizioni  

v06 — 2026-04-09  
refinement UX hint  
introduzione multi-hint  
introduzione gerarchia visiva  
emersione criticità matching duplicato  

v07 — 2026-04-22  
introduzione event editing  
implementazione update_event  
introduzione updated_at  

v08 — 2026-04-23  
stabilizzazione UI state  
fix feedback flow  
ordinamento eventi per updated_at  
identificazione loop reattivo  
allineamento stato sistema reale  

v09 — 2026-04-24  
introduzione parse_input_controlled  
introduzione debounce parsing  
eliminazione loop reattivo  
unificazione parsing (single source of truth)  
fix edit mode (trigger parse)  
stabilizzazione UI state  
eliminazione flash feedback  
ottimizzazione UX async save  

v10 — 2026-04-30  
completamento ENGINE BASE — NORMALIZATION LAYER BASE  
stabilizzazione ui_state.parsed  
normalizzazione amount formato italiano  
normalizzazione unit base  
supporto unità compatte testuali  
rimozione amount senza unità  
rimozione parsing legacy da button_input_confirm  
validazione insert con dati normalizzati  
validazione update con dati normalizzati  
fix refresh lista eventi dopo update  
aggiornamento stato Engine da 0% a 15%  
apertura transizione verso Preview Alignment Base  

v11 — 2026-04-30  
completamento PREVIEW ALIGNMENT BASE  
formattazione italiana amount in preview  
introduzione formatAmountIT  
introduzione formatUnitIT  
euro visualizzato con due decimali  
grouping migliaia visuale  
ore/minuti visualizzati coerentemente  
singolare/plurale unit gestito  
label cleaning preview aggiornato  
rimozione amount/unit dalla label migliorata  
risolto bug "minuti" → "uti"  
separatore data/label uniformato  
introduzione previewStopTokens  
highlight unit-safe  
nessuna modifica a parser, DB, matching o save flow  
transizione verso STEP 6.2 — DURATION NORMALIZATION 

v12 — 2026-04-30  
completamento ENGINE BASE — DURATION NORMALIZATION  
definita unità canonica durata in minuti  
durate certe ore/minuti convertite in minuti  
1 ora → 60 minuti  
1,5 ore → 90 minuti  
1 ora e 15 minuti → 75 minuti  
2h30 → 150 minuti  
2 ore 30 → 150 minuti  
aggiornato parse_input_controlled  
aggiornata preview durata con forma umana  
aggiunto hint “Normalizzato: X minuti”  
aggiunto hint durata ambigua per giorni/settimane  
giorni/settimane non convertiti automaticamente  
raw_input preservato  
nessuna modifica DB  
nessuna modifica button_input_confirm  
nessuna modifica insert_event/update_event  
nessuna modifica matching  
nessuna type classification  
insert/update validati runtime con amount/unit normalizzati  
transizione verso STEP 6.3 — TYPE CLASSIFICATION BASE  

v13 — 2026-05-01  
completamento ENGINE BASE — TYPE CLASSIFICATION BASE  
select1 allineato a ui_state.parsed.unit  
parsed.unit = minuti → Tempo  
euro + keyword controllate di uscita → Spesa  
euro + keyword controllate di entrata → Incasso  
euro senza direzione chiara → Evento  
segnali economici contrastanti → Evento  
scelta manuale utente preservata  
type aggiunto al payload di button_input_confirm  
insert_event salva events.type  
update_event aggiorna events.type  
override manuale validato su Spesa / Incasso  
reset/stale value verificato  
type persistito in DB  
nessuna modifica schema DB  
nessuna modifica parser  
nessuna modifica matching  
nessun refactor preview  
nessun output/KPI anticipato  
linting Retool residuo registrato come anomalia non bloccante  
matching non unificato confermato come prossimo nodo logico  
transizione verso STEP 6.4 — MATCH ENGINE UNIFICATION  