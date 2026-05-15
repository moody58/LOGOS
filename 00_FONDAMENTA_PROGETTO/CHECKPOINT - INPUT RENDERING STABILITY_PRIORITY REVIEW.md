# CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW

DATA: 2026-05-15  
PROGETTO: LOGOS  
STACK: Retool + Supabase  
NODO DI PARTENZA: INPUT RENDERING STABILITY / CONTAINER STRUCTURE  
STATO: SOSPESO / RIORIENTATO  
OUTPUT: DECISIONE PROPedeutica — APRIRE INPUT ANALYSIS READINESS CHECK

------------------------------------------------
1. CONTESTO
------------------------------------------------

La sessione è stata aperta sul nodo:

INPUT RENDERING STABILITY / CONTAINER STRUCTURE

Scopo iniziale:

ridurre il rendering progressivo / flash visivo su input evento normale,
stabilizzando la comparsa di:

- Sintesi
- suggestion container
- Dati evento
- Command Intent

senza modificare logiche dati.

Vincoli dichiarati:

- nessuna modifica DB
- nessuna modifica schema Supabase
- nessuna modifica parser amount/unit/date
- nessuna modifica normalization/duration/type
- nessuna modifica matching engine
- nessuna modifica create_suggestion_state salvo stretta necessità
- nessuna modifica command_intent_state salvo stretta necessità
- nessuna modifica insert_event/update_event
- nessuna modifica insert_project/insert_entity
- nessuna modifica feedback/routing salvo bug diretto
- nessuna introduzione input analysis model unico
- nessun refactor preview model
- nessuno spostamento “Da verificare” fuori dalla Sintesi nel nodo corrente
- nessuna dashboard/KPI
- procedura step by step con test intermedi

------------------------------------------------
2. OSSERVAZIONE EMERSA
------------------------------------------------

Durante l’analisi preliminare è emerso che il problema del rendering progressivo
non sembra dipendere soltanto dalle formule Hidden dei singoli componenti.

Il comportamento osservato sembra essere sintomo di un punto più strutturale:

l’input LOGOS oggi viene interpretato da più layer paralleli e non da un unico
stato interrogabile dalla UI.

Fonti/layer attualmente coinvolti:

- input_home
- input_raw
- trigger_parse_debounced
- command_intent_state
- parse_input_controlled
- ui_state.parsed
- project_state
- entity_state
- create_suggestion_state
- select1
- select_project
- select_entity
- preview logic / sintesi
- container_command_intent
- container_association_suggestions

Questi layer funzionano, ma aggiornandosi in tempi diversi possono produrre
rendering progressivo o comparsa a cascata dei blocchi UI.

------------------------------------------------
3. RISCHIO DEL NODO ORIGINALE
------------------------------------------------

Il nodo INPUT RENDERING STABILITY / CONTAINER STRUCTURE è stato riconosciuto
come coerente, ma potenzialmente tattico.

Rischio individuato:

intervenire solo su Hidden / container potrebbe produrre un miglioramento visivo
temporaneo, ma lasciare irrisolto il problema di fondo.

Possibile scenario negativo:

1. si correggono Hidden e container;
2. si riduce il flash nel breve termine;
3. nei nodi successivi emerge comunque la necessità di uno stato unico
   di readiness / interpretazione input;
4. si riapre il problema e si riscrivono di nuovo le regole UI.

Conclusione:

il nodo corrente rischia di diventare un cerotto se affrontato prima di verificare
la maturità del sistema rispetto a un possibile input analysis layer controllato.

------------------------------------------------
4. OSSERVAZIONE SULLO STATO LAYER
------------------------------------------------

Dalla fotografia dello stato layer sistema risultano percentuali indicative:

- Layer 1 — Input: ~99%
- Layer Command Intent: ~70%
- Layer 2 — Matching / Suggestion: ~92%
- Layer 3 — View / Preview: ~94%
- Layer HINT SYSTEM: ~93%
- Layer UX Mobile: ~95%
- Layer 4 — Data Structure: ~32%
- Layer 5 — Engine: ~48%
- Layer 6 — Output: 0%

Interpretazione:

i layer legati a input, matching, preview, hint e UX mobile sono molto maturi.

I layer Data Structure ed Engine sono ancora significativamente meno maturi.

Questo rende rischioso aprire direttamente un nodo strutturale pesante,
ma rende utile una verifica propedeutica per capire se un aggregatore UI/readiness
può essere introdotto senza invadere Engine o Data Structure.

------------------------------------------------
5. DECISIONE
------------------------------------------------

Decisione consolidata:

NON procedere subito con modifiche operative al nodo:

INPUT RENDERING STABILITY / CONTAINER STRUCTURE

NON aprire direttamente il nodo:

INPUT ANALYSIS MODEL — FIRST CONTROLLED LEVEL

Aprire prima un nodo propedeutico:

INPUT ANALYSIS READINESS CHECK

Scopo del nuovo nodo:

verificare se LOGOS è pronto per introdurre un eventuale input_analysis_state
senza creare duplicazioni, regressioni o nuove fonti decisionali.

Il nuovo nodo non implementa codice.

Il nuovo nodo produce una decisione:

- GO
- NO-GO
- GO LIMITATO

rispetto a un eventuale futuro:

INPUT ANALYSIS MODEL — FIRST CONTROLLED LEVEL

------------------------------------------------
6. PERIMETRO DEL NODO PROPedeutico
------------------------------------------------

Nome nodo consigliato:

INPUT ANALYSIS READINESS CHECK

Tipo:

analisi propedeutica / decisionale

Obiettivo:

mappare i layer attuali dell’input e stabilire se un aggregatore UI/readiness
può essere introdotto in modo sicuro.

Output atteso:

- mappa fonti input attuali
- responsabilità di ogni layer
- distinzione tra fonti dati, fonti salvabili e fonti UI
- individuazione delle duplicazioni
- identificazione del punto in cui nasce il rendering progressivo
- valutazione rischi di input_analysis_state
- confini di un eventuale aggregatore
- decisione GO / NO-GO / GO LIMITATO
- eventuale blocco di apertura del nodo successivo

------------------------------------------------
7. COSA IL READINESS CHECK NON DEVE FARE
------------------------------------------------

Il nodo INPUT ANALYSIS READINESS CHECK NON deve:

- modificare codice Retool
- modificare Hidden
- modificare container
- modificare parser
- modificare normalization
- modificare duration normalization
- modificare type classification
- modificare matching engine
- modificare create_suggestion_state
- modificare command_intent_state
- modificare preview model
- modificare insert_event/update_event
- modificare insert_project/insert_entity
- modificare DB
- modificare schema Supabase
- introdurre dashboard/KPI
- introdurre Data Structure
- introdurre Engine avanzato
- introdurre input_analysis_state operativo

------------------------------------------------
8. CONFINE TRA READINESS CHECK, ENGINE E DATA STRUCTURE
------------------------------------------------

Il nodo propedeutico è stato confermato come indipendente da Engine e Data Structure.

ENGINE:

il nodo non deve normalizzare meglio i dati,
non deve introdurre nuove regole semantiche,
non deve modificare amount/unit/date/type,
non deve introdurre economic direction,
non deve gestire giorni/settimane,
non deve generare KPI.

DATA STRUCTURE:

il nodo non deve introdurre gerarchie,
alias,
deduplicazione avanzata,
relazioni entity-project,
filtro select avanzato,
o nuove strutture dati.

Il nodo agisce sopra questi layer e verifica solo se la UI può leggere
in modo più ordinato lo stato già prodotto dai layer esistenti.

------------------------------------------------
9. POSSIBILE FUTURO INPUT_ANALYSIS_STATE
------------------------------------------------

Il futuro input_analysis_state, se validato, dovrà essere solo un aggregatore
UI/readiness.

Non dovrà essere un nuovo engine.

Non dovrà decidere dati salvabili.

Non dovrà sostituire parser, matching, command intent o suggestion.

Possibile forma concettuale futura:

{
  hasInput,
  isAnalyzing,
  isReady,
  isCommandFlow,
  isEventFlow,
  isPureCommand,
  showCommandContainer,
  showEventPreview,
  showAssociationSuggestions,
  showEventData,
  showConfirm,
  rawInput
}

Questa struttura è solo ipotesi di lavoro.

Non è approvata come implementazione.

------------------------------------------------
10. RISCHI INDIVIDUATI
------------------------------------------------

RISCHIO A — procedere con micro-fix Hidden/container

Possibile effetto:

- miglioramento rapido
- ma rischio di riaprire il problema dopo pochi nodi
- aumento del debito UI
- duplicazione di condizioni nei componenti

RISCHIO B — aprire subito Input Analysis Model

Possibile effetto:

- soluzione più strutturale
- ma rischio di creare un secondo sistema interpretativo
- duplicazione di parser/matching/command/suggestion
- aumento complessità
- rischio deriva architetturale

RISCHIO C — procedere con Readiness Check

Possibile effetto:

- rallenta leggermente l’operatività immediata
- ma riduce rischio di scegliere nodo sbagliato
- permette decisione più solida
- evita implementazioni premature

Decisione:

RISCHIO C accettato.

------------------------------------------------
11. STP — LIVELLO 1: COERENZA INTERNA
------------------------------------------------

La scelta è coerente con lo stato attuale perché:

- il rendering progressivo è già un residuo riconosciuto;
- l’input analysis non è ancora unificata;
- Command Intent è implementato solo a primo livello controllato;
- preview, suggestion, command e dati evento sono layer separati;
- il problema è probabilmente di coordinamento UI/readiness, non di parsing o DB.

Esito:

COERENTE

------------------------------------------------
12. STP — LIVELLO 2: DEVIAZIONE CONTROLLATA
------------------------------------------------

Ipotesi alternativa 1:

procedere subito con INPUT RENDERING STABILITY / CONTAINER STRUCTURE.

Valutazione:

utile ma tattico.
Rischio di dover riaprire il tema dopo introduzione di input_analysis_state.

Esito:

non prioritario immediato.

---

Ipotesi alternativa 2:

procedere subito con INPUT ANALYSIS MODEL — FIRST CONTROLLED LEVEL.

Valutazione:

potenzialmente corretto, ma troppo rischioso senza audit propedeutico.
Potrebbe trasformarsi in un nuovo engine parallelo.

Esito:

rimandato dopo Readiness Check.

---

Ipotesi alternativa 3:

aprire DATA STRUCTURE o ENGINE.

Valutazione:

Data Structure ed Engine sono più indietro,
ma non sembrano essere la causa diretta del rendering progressivo.
Aprirli ora potrebbe spostare il focus dal problema reale.

Esito:

non prioritari per questo specifico problema.

------------------------------------------------
13. STP — LIVELLO 3: SIMULAZIONE ESTERNA
------------------------------------------------

Dal punto di vista utente:

il problema percepito è instabilità visiva.

L’utente vede blocchi che appaiono progressivamente e può interpretare
il comportamento come incertezza del sistema.

Dal punto di vista sistema:

la causa probabile è la molteplicità dei layer di interpretazione/rendering.

Una soluzione solo visuale potrebbe migliorare l’esperienza a breve,
ma non ridurre la complessità futura.

Una verifica propedeutica consente di scegliere se introdurre un aggregatore
minimo senza compromettere la stabilità attuale.

Esito:

il Readiness Check è la scelta più prudente prima di nuove modifiche.

------------------------------------------------
14. DECISIONE FINALE
------------------------------------------------

Il nodo:

INPUT RENDERING STABILITY / CONTAINER STRUCTURE

viene sospeso come nodo operativo immediato.

Motivo:

coerente ma tattico; possibile sintomo di un problema più strutturale
di readiness / coordinamento input.

Prossimo nodo da aprire:

INPUT ANALYSIS READINESS CHECK

Obiettivo:

stabilire se LOGOS è pronto per un eventuale input_analysis_state
e definire il perimetro esatto del futuro nodo senza implementare codice.

Sequenza consigliata:

1. INPUT ANALYSIS READINESS CHECK
   → analisi e decisione GO / NO-GO

2. se GO:
   INPUT ANALYSIS MODEL — FIRST CONTROLLED LEVEL
   → solo aggregatore UI/readiness

3. dopo:
   INPUT RENDERING STABILITY / CONTAINER STRUCTURE
   → stabilizzazione Hidden/container usando stato più chiaro

4. successivamente:
   ritorno a Data Structure / Engine secondo Roadmap

------------------------------------------------
15. DOCUMENTI COINVOLTI
------------------------------------------------

Documenti core:

- 00_PROJECT_State
- 00_PROJECT_Roadmap
- 00_PROJECT_Gap_Register

Documenti tecnici:

- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- 06_LOGOS_View_Preview_System
- LOGOS_RETOOL_RUNTIME_REAL

Documenti di supporto:

- 02_LOGOS_Match_Engine
- 03_LOGOS_Event_Lifecycle
- 05_LOGOS_Database_Schema

Checkpoint di riferimento:

- CHECKPOINT — COMMAND INTENT / CREATE PROJECT ENTITY

------------------------------------------------
16. STATO FINALE CHECKPOINT
------------------------------------------------

INPUT RENDERING STABILITY / CONTAINER STRUCTURE

→ NON ANNULLATO  
→ SOSPESO  
→ DA RIPRENDERE DOPO READINESS CHECK  
→ NESSUNA MODIFICA OPERATIVA ESEGUITA  
→ NESSUNA MODIFICA DB  
→ NESSUNA MODIFICA RETOOL  
→ NESSUNA MODIFICA PARSER  
→ NESSUNA MODIFICA MATCHING  
→ NESSUNA MODIFICA PREVIEW  
→ NESSUNA MODIFICA SAVE FLOW  

Prossima azione:

aprire sessione / nodo:

INPUT ANALYSIS READINESS CHECK

------------------------------------------------
VALIDAZIONE
------------------------------------------------

- nodo: OK
- scope: OK
- deviazione: NO