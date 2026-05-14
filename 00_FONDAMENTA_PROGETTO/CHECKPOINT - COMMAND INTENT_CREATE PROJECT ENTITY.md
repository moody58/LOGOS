# CHECKPOINT — COMMAND INTENT / CREATE PROJECT ENTITY

DATA: 2026-05-13  
PROGETTO: LOGOS  
STACK: Retool + Supabase  
NODO: COMMAND INTENT — CREATE PROJECT / ENTITY  
STATO: COMPLETATO / VALIDATO

------------------------------------------------
1. SCOPO DEL NODO
------------------------------------------------

Introdurre un primo livello controllato di Command Intent dentro l’input libero LOGOS, per distinguere:

- input evento
- comando strutturale puro

Esempi gestiti:

- crea progetto Aspri
- aggiungi progetto Villa Nuova
- inserisci progetto Villa Nuova
- nuovo progetto Villa Nuova

- crea entità Patrizio
- aggiungi entità Referente Kappa
- inserisci entità Marco Parisi
- nuova entità Marco Parisi

- crea
- modifica evento

Obiettivo raggiunto:

Un comando puro non viene più trattato come evento ordinario.

------------------------------------------------
2. VINCOLI RISPETTATI
------------------------------------------------

Durante il nodo sono stati rispettati i vincoli iniziali:

✔ nessuna modifica DB  
✔ nessuna modifica schema Supabase  
✔ nessuna modifica parser amount/unit/date  
✔ nessuna modifica duration normalization  
✔ nessuna modifica type classification  
✔ nessuna modifica matching engine project/entity  
✔ nessuna creazione automatica silenziosa  
✔ nessun evento salvato da comando puro  
✔ project/entity creati solo dopo conferma utente  
✔ insert_project / insert_entity mantenuti come azioni controllate  
✔ select_project / select_entity restano decisione finale per gli eventi  
✔ nessuna dashboard  
✔ nessun KPI  
✔ nessuna data structure avanzata  
✔ nessuna gerarchia / alias / deduplicazione avanzata  

Il nodo resta coerente con il principio già consolidato:

- le suggestion project/entity non salvano automaticamente eventi
- la creazione di project/entity richiede conferma utente
- select_project / select_entity restano fonte finale salvabile per gli eventi

------------------------------------------------
3. NUOVA QUERY INTRODOTTA
------------------------------------------------

È stata introdotta una query Retool page-level:

command_intent_state

Tipo:

Run JS Code

Ruolo:

riconoscere comandi puri e distinguere input evento da intent strutturale.

La query:

- non salva dati
- non modifica DB
- non sostituisce parser
- non sostituisce matching
- non apre flow paralleli di modifica evento

------------------------------------------------
4. OUTPUT LOGICO DI command_intent_state
------------------------------------------------

La query restituisce uno stato strutturato con campi principali:

{
  isCommand,
  isPureCommand,
  commandFamily,
  commandType,
  targetType,
  candidateName,
  existingId,
  needsCompletion,
  canExecute,
  guideMessage,
  rawInput
}

Significato operativo:

isCommand
→ true se l’input è un comando riconosciuto

isPureCommand
→ true se non deve essere salvato come evento

commandFamily
→ create / exists / guide

commandType
→ create_project / create_entity / project_exists / entity_exists / create_target_missing / edit_event_help

targetType
→ project / entity / event / null

candidateName
→ nome candidato estratto dal comando

existingId
→ id di project/entity già esistente, se rilevato

needsCompletion
→ true se manca il nome

canExecute
→ true solo se la creazione è consentita

guideMessage
→ messaggio di guida quando non è prevista esecuzione

rawInput
→ input sorgente

------------------------------------------------
5. COMANDI IMPLEMENTATI
------------------------------------------------

5.1 CREATE PROJECT

Gestiti:

- crea progetto
- crea progetto Villa Nuova
- aggiungi progetto Villa Nuova
- inserisci progetto Villa Nuova
- nuovo progetto Villa Nuova
- nuova progetto Villa Nuova

Comportamento:

crea progetto
→ comando incompleto
→ mostra campo nome progetto
→ bottone disabilitato finché il nome è vuoto
→ nessun evento salvato

crea progetto Villa Nuova
→ comando completo
→ mostra riepilogo progetto
→ consente creazione previa conferma
→ nessun evento salvato

------------------------------------------------

5.2 CREATE ENTITY

Gestiti:

- crea entità
- crea entità Patrizio
- aggiungi entità Patrizio
- inserisci entità Patrizio
- nuova entità Patrizio
- nuovo entità Patrizio

Comportamento:

crea entità
→ comando incompleto
→ mostra campo nome entità
→ bottone disabilitato finché il nome è vuoto
→ nessun evento salvato

crea entità Patrizio
→ comando completo
→ mostra riepilogo entità
→ consente creazione previa conferma
→ nessun evento salvato

------------------------------------------------

5.3 CREATE GENERICO

Gestiti:

- crea
- aggiungi
- inserisci
- nuovo
- nuova

Comportamento:

crea
→ comando generico incompleto
→ nessuna sintesi evento
→ nessun dato evento
→ nessun salvataggio
→ guida con esempi:

  crea progetto Villa Nuova
  crea entità Patrizio

------------------------------------------------

5.4 ELEMENTO GIÀ ESISTENTE

Gestito:

crea progetto villa

se Villa esiste già.

Comportamento:

→ mostra Elemento già presente  
→ nessun pulsante di creazione  
→ nessuna duplicazione  
→ nessun evento salvato  
→ suggerisce di selezionare il dato evento o usare un nome più specifico  

------------------------------------------------

5.5 GUIDA MODIFICA EVENTO

Gestiti:

- modifica evento
- correggi evento
- cambia evento
- come modifico evento
- devo modificare evento

Comportamento:

→ non apre un edit flow alternativo  
→ non modifica eventi  
→ non seleziona eventi automaticamente  
→ guida l’utente verso la lista eventi  
→ mostra pulsante “Vai agli eventi”  

Questa scelta evita logiche parallele rispetto all’edit flow già esistente.

------------------------------------------------
6. COMPONENTI UI INTRODOTTI / MODIFICATI
------------------------------------------------

Dentro container_input è stato introdotto:

container_command_intent

Componenti collegati:

- txt_command_intent_loading
- txt_command_intent_title
- txt_command_intent_description
- txt_command_edit_steps
- divider_command_intent_main
- txt_command_intent_summary
- input_command_project_name
- input_command_entity_name
- btn_command_create_project
- btn_command_create_entity
- btn_command_go_events
- txt_command_intent_notice
- txt_command_intent_guide_notice

------------------------------------------------
7. COMPORTAMENTO UI COMMAND INTENT
------------------------------------------------

7.1 COMANDO GENERICO

Input:

crea

UI:

- card neutra
- titolo: Comando rilevato
- testo guida
- esempi separati su righe leggibili
- nessun pulsante crea
- Torna alla home

------------------------------------------------

7.2 CREA PROGETTO INCOMPLETO

Input:

crea progetto

UI:

- card ambra
- titolo: Comando rilevato
- testo: Inserisci il nome del progetto per continuare.
- input placeholder: Es. Villa Nuova
- bottone Crea progetto disabilitato finché il campo è vuoto
- nota: Crea solo il progetto. L’evento non verrà salvato.

------------------------------------------------

7.3 CREA PROGETTO COMPLETO

Input:

crea progetto Command Final Project 2

UI:

- card verde
- riepilogo: Progetto: Command Final Project 2
- bottone Crea progetto
- nota: Crea solo il progetto. L’evento non verrà salvato.

------------------------------------------------

7.4 CREA ENTITÀ INCOMPLETA

Input:

crea entità

UI:

- card viola
- titolo: Comando rilevato
- testo: Inserisci il nome dell’entità per continuare.
- input placeholder: Es. Marco Parisi
- bottone Crea entità disabilitato finché il campo è vuoto
- nota: Crea solo l’entità. L’evento non verrà salvato.

------------------------------------------------

7.5 CREA ENTITÀ COMPLETA

Input:

crea entità Command Final Entity 2

UI:

- card viola
- riepilogo: Entità: Command Final Entity 2
- bottone Crea entità
- nota: Crea solo l’entità. L’evento non verrà salvato.

------------------------------------------------

7.6 ELEMENTO GIÀ PRESENTE

Input:

crea progetto villa

UI:

- card warning leggero
- titolo: Elemento già presente
- messaggio: Questo progetto esiste già.
- guida: Puoi selezionarlo nei dati evento oppure usare un nome più specifico.
- riepilogo: Progetto: Villa
- nessun bottone crea

------------------------------------------------

7.7 GUIDA MODIFICA EVENTO

Input:

modifica evento

UI:

- card guida viola
- titolo: Guida disponibile
- step:
  - Apri la lista eventi
  - Cerca l’evento da modificare
  - Usa il pulsante Modifica
- CTA: Vai agli eventi
- nota di sicurezza sotto CTA:
  - Nessuna modifica verrà eseguita qui.

------------------------------------------------
8. GUARDIE UI / HIDDEN AGGIORNATI
------------------------------------------------

Sono state aggiornate le guardie per evitare flash e interferenze tra command intent e flow evento.

Componenti coinvolti:

- container_command_intent
- sintesi
- container_association_suggestions
- select1
- text_event_data_title
- select_project
- select_entity
- button_input_confirm
- btn_cancel_input_home
- txt_command_intent_loading
- txt_command_intent_notice
- input_command_project_name
- input_command_entity_name
- btn_command_create_project
- btn_command_create_entity
- btn_command_go_events

Obiettivo raggiunto:

crea / crea progetto / crea entità / modifica evento
→ non mostrano più Sintesi evento o Dati evento

30 euro spesa villa citrignano
→ continua a mostrare il flow evento normale

------------------------------------------------
9. COLLEGAMENTO OPERATIVO CREAZIONE PROJECT/ENTITY
------------------------------------------------

I pulsanti command non creano nuove query DB.

Sono stati collegati alle query esistenti:

- insert_project
- insert_entity

------------------------------------------------

9.1 btn_command_create_project

Comportamento:

- legge candidateName o input_command_project_name
- valorizza input_new_project_name
- trigger insert_project
- refresh projects_list
- reset input e stati temporanei
- mostra feedback project_created
- ritorno Home automatico

------------------------------------------------

9.2 btn_command_create_entity

Comportamento:

- legge candidateName o input_command_entity_name
- valorizza input_new_entity_name
- trigger insert_entity
- refresh entities_list
- reset input e stati temporanei
- mostra feedback entity_created
- ritorno Home automatico

------------------------------------------------

9.3 btn_command_go_events

Comportamento:

- reset input command
- refresh events_new
- apre container_events_list
- non modifica eventi
- non crea eventi
- non apre edit flow alternativo

------------------------------------------------
10. FEEDBACK STRUTTURALE
------------------------------------------------

Il feedback mobile è stato esteso per distinguere:

- Evento salvato
- Progetto creato
- Entità creata

È stato introdotto nel runtime UI:

ui_state.feedback_mode

Valori usati:

- project_created
- entity_created
- null / event_created

------------------------------------------------

Feedback project:

Titolo:

Progetto creato

Messaggio:

Il progetto è stato creato correttamente.

Riepilogo:

- Tipo: Progetto
- Nome
- Stato: Attivo

------------------------------------------------

Feedback entity:

Titolo:

Entità creata

Messaggio:

L’entità è stata creata correttamente.

Riepilogo:

- Tipo: Entità
- Nome

------------------------------------------------

Feedback evento ordinario:

Titolo:

Evento salvato

Messaggio:

L’evento è stato registrato correttamente.

Riepilogo evento invariato.

Il feedback resta temporaneo e non viene salvato nel DB.

------------------------------------------------
11. TEST VALIDATI
------------------------------------------------

11.1 COMMAND GENERICO

Input:

crea

Esito:

OK

Validato:

- comando riconosciuto
- nessuna sintesi evento
- nessun dato evento
- nessun salvataggio
- esempi leggibili

------------------------------------------------

11.2 CREATE PROJECT INCOMPLETO

Input:

crea progetto

Esito:

OK

Validato:

- input nome progetto visibile
- bottone disabilitato a campo vuoto
- nessun evento salvato

------------------------------------------------

11.3 CREATE PROJECT COMPLETO

Input:

crea progetto Command Final Project 2

Esito:

OK

Validato:

- progetto creato
- feedback corretto
- ritorno Home automatico
- nessun evento creato

------------------------------------------------

11.4 CREATE ENTITY INCOMPLETO

Input:

crea entità

Esito:

OK

Validato:

- input nome entità visibile
- bottone disabilitato a campo vuoto
- nessun evento salvato

------------------------------------------------

11.5 CREATE ENTITY COMPLETO

Input:

crea entità Command Final Entity 2

Esito:

OK

Validato:

- entità creata
- feedback corretto
- ritorno Home automatico
- nessun evento creato

------------------------------------------------

11.6 ELEMENTO GIÀ PRESENTE

Input:

crea progetto villa

Esito:

OK

Validato:

- progetto esistente riconosciuto
- nessun pulsante crea
- nessuna duplicazione
- nessun evento creato

------------------------------------------------

11.7 GUIDA MODIFICA EVENTO

Input:

modifica evento

Esito:

OK

Validato:

- guida mostrata
- CTA Vai agli eventi funzionante
- nessuna modifica automatica
- nessun evento creato

------------------------------------------------

11.8 EVENTO NORMALE

Input:

30 euro spesa villa citrignano

Esito:

OK

Validato:

- command intent non interferisce
- Sintesi evento normale
- Tipo = Spesa
- Importo = 30,00 €
- Progetto = Villa
- suggestion normale visibile se prevista
- Conferma evento salva evento NEW
- feedback evento corretto
- ritorno Home automatico

------------------------------------------------

11.9 EDIT EVENTO REALE

Esito:

OK

Validato:

- update_event eseguito
- feedback evento corretto
- ritorno Lista eventi
- evento marcato come modificato

------------------------------------------------

11.10 EDIT NO-OP / ANNULLA MODIFICA

Esito:

OK

Validato:

- nessun update_event se non ci sono modifiche reali
- updated_at non alterato
- ritorno Lista eventi

------------------------------------------------
12. RESIDUI DOCUMENTATI
------------------------------------------------

12.1 “DA VERIFICARE” RESTA DENTRO SINTESI

Durante il polish è emerso che la card:

Da verificare

non è un blocco autonomo spostabile, ma fa parte della sintesi.

Decisione:

non spostarla nel nodo corrente

Motivo:

spostarla richiederebbe lavorare sulla struttura interna della preview.

Da documentare come possibile nodo futuro:

PREVIEW MODEL / HINT STATE CONSOLIDATION

La preview resta un layer ancora ibrido che contiene hint, label logic e trasformazioni visuali proprie.

------------------------------------------------

12.2 RENDERING PROGRESSIVO / FLASH EVENTO NORMALE

Durante il nodo è stato osservato un comportamento residuo:

input evento normale
→ Sintesi / hint / suggestion possono comparire progressivamente

Impatto:

- UX visiva migliorabile
- nessuna regressione dati
- nessuna regressione salvataggio
- nessuna regressione parser/matching

Decisione:

non trattato nel nodo corrente

Da documentare come nodo futuro:

INPUT RENDERING STABILITY / CONTAINER STRUCTURE

Possibili direzioni future:

- stato unico input_analysis_ready
- skeleton / placeholder durante analisi
- separazione container preview / hint / dati evento
- consolidamento rendering progressivo

------------------------------------------------

12.3 LAYER UNICO DI INTERPRETAZIONE

Durante il nodo è stata confermata una direzione futura desiderabile:

a regime, un solo layer di analisi dovrebbe produrre uno stato interrogabile dalle UI.

Oggi esistono ancora fonti multiple:

- parse_input_controlled
- ui_state.parsed
- project_state
- entity_state
- create_suggestion_state
- command_intent_state
- preview logic
- select values

Decisione:

non unificare ora

Da documentare come direzione futura:

INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER

Questa direzione è coerente con i gap già esistenti su Processor / Engine Flow e Preview Model, ma non deve essere anticipata prima di un nodo dedicato.

------------------------------------------------

12.4 COMMAND INTENT NON È ENGINE GLOBALE

Il Command Intent implementato è:

primo livello controllato

Non è ancora:

- engine intent completo
- assistente conversazionale
- routing universale
- dashboard command system
- azioni rapide operative complete

Resta limitato a:

- create project
- create entity
- create target missing
- edit event help
- exists guard

------------------------------------------------
13. STATO FINALE NODO
------------------------------------------------

COMMAND INTENT — CREATE PROJECT / ENTITY

→ COMPLETATO  
→ VALIDATO RUNTIME  
→ DB INVARIATO  
→ PARSER INVARIATO  
→ MATCHING INVARIATO  
→ EVENT FLOW NON REGRESSIVO  
→ EDIT FLOW NON REGRESSIVO  
→ UI MOBILE RIFINITA  

------------------------------------------------
14. DOCUMENTI DA AGGIORNARE
------------------------------------------------

Aggiornamento consigliato:

1. 00_PROJECT_State
2. 00_PROJECT_Roadmap
3. 00_PROJECT_Gap_Register
4. 01_LOGOS_Input_System
5. 04_LOGOS_Retool_Architecture
6. 06_LOGOS_View_Preview_System
7. LOGOS_RETOOL_RUNTIME_REAL

Aggiornamento opzionale / solo se si vuole tracciare in dettaglio DB invariato:

8. 05_LOGOS_Database_Schema

Non necessario salvo annotazione:

nessuna modifica schema DB

------------------------------------------------
15. PROSSIMO NODO CANDIDATO
------------------------------------------------

Dopo questo checkpoint, i candidati logici sono:

1. INPUT RENDERING STABILITY / CONTAINER STRUCTURE
2. PREVIEW MODEL / HINT STATE CONSOLIDATION
3. SUGGESTION CREATE VS EDIT CONSISTENCY
4. AZIONI RAPIDE OPERATIVE
5. DATA STRUCTURE / ENTITY HIERARCHY

Consiglio operativo:

Non aprire subito Data Structure se prima si vuole consolidare la UX e ridurre i residui di rendering.

Nodo più coerente se si vuole stabilizzare l’esperienza utente:

INPUT RENDERING STABILITY / CONTAINER STRUCTURE

Nodo più coerente se si vuole ridurre fonti ibride e debito preview:

PREVIEW MODEL / HINT STATE CONSOLIDATION

Nodo più coerente se si vogliono rendere operative le scorciatoie Home:

AZIONI RAPIDE OPERATIVE

------------------------------------------------
VALIDAZIONE
------------------------------------------------

- nodo: OK
- scope: OK
- deviazione: NO