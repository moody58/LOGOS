# 02_LOGOS_Match_Engine_v15
Versione: v15
DATA: 2026-11-20

Rettifica editoriale STEP 4 del 20 novembre 2026, PREPARE della medesima versione non pubblicata: aggiornati i soli raccordi Q2 e i confini degli snapshot storici. Nessuna modifica applicativa, copia o pubblicazione attestata.

## Contratto finale Q2 — riconoscimento e associazione

Il riconoscimento canonico N21 opera sul repertorio completo indipendentemente da Stato; le funzioni interne restano quelle esistenti dentro adapter request-scoped. Q2 aggiunge correlazione della richiesta e consuma i risultati tramite analysis_snapshot: non introduce fuzzy, ranking, lookup manuale INACTIVE o matcher paralleli.

| Caso per singolo livello | Associazione finale |
| --- | --- |
| Selezione ACTIVE valida | Selezione ordinaria prevalente, nessuna domanda di Stato |
| Stessa FK storica in edit | Preservata anche INACTIVE/NULL; nessuna nuova autorizzazione implicita |
| Nessuna selezione valida prevalente, unico candidato canonico INACTIVE | IAR richiede Collega/Non collegare con token contestuale; solo Collega propone candidateId |
| Candidato NULL o Stato inatteso | Nessuna nuova associazione eccezionale |
| Ambiguità canonica non risolta | Blocco esistente conservato; non selezionare arbitrariamente un INACTIVE |
| Nessun candidato riconosciuto | Associazione facoltativa e suggerimenti pertinenti; nessuna ricerca manuale INACTIVE aggiunta |

Project ed Entity sono indipendenti. IAR costruisce la proiezione, renderer e controlli rappresentano, il [coordinatore](03_LOGOS_Event_Lifecycle.md#contratto-finale-q2--conferma-unica) ricontrolla snapshot e nuovi UUID. Nessuna modifica automatica dello Stato anagrafico. Le descrizioni N21 precedenti sono la base storica; l’esclusività ACTIVE sulle nuove FK ha ora la sola deroga Q2 esplicita.

**Provenienza e limiti:** comportamento VERIFICATO LIVE nei checkpoint Q2 del 18–20 novembre 2026; in questo STEP 4 soltanto DOCUMENTATO e riconciliato sui file, senza nuovi accessi Retool/Supabase. UAT Safari UX-R1 4/4 PASS dichiarati dall’utente. Inventario 171→162 riconciliato da prove native; nessun export completo post-Delete. L08: Click «Vai agli eventi» non verificato LIVE, né PASS né FAIL. Draft non pubblicata, manutenzione ancora attiva. Il presente contenuto è PREPARE documentale per review: non attesta propria copia, verifica locale o pubblicazione Git.

## Contratto corrente N21 — riconoscimento e associabilità

`project_state` e `entity_state` B1 lavorano sul repertorio completo, con normalizzazione degli accenti, parole intere, precedenza ai nomi completi e distinzione dei numeri identificativi da importi/durate. Le varianti testuali plausibili entrano nelle alternative B1 e possono richiedere scelta manuale. `create_suggestion_state` usa il match canonico o l'UUID selezionato come base e mantiene il controllo delle omonimie sull'intero repertorio. Il ramo di estensione evita la creazione prematura in caso di ambiguità.

N21/UX aggiunge solo al Project `prefixAlternatives`, informativa, in assenza di candidati B1. Usa prefissi comuni di almeno due parole intere, condivisi da almeno due record. Esempio: `Cucciolata Marzo` propone 2025 e 2026 nella Sintesi, senza attribuire un UUID o innescare una nuova creazione. Conservati i campi canonici `matches`, `count`, `hasMatch`, `isAmbiguous`, `singleMatch`, `moreSpecificMatches` e `plausibleAlternatives`. `entity_state` è rimasto invariato nella tranche UX. Un match INACTIVE o NULL identifica il record. L'ammissibilità delle nuove FK è una responsabilità delle Select e del [preflight Conferma](03_LOGOS_Event_Lifecycle.md).

**DOCUMENTATO** dai pacchetti B1 e N21/UX. **VERIFICATO LIVE** nel perimetro dei casi registrati in [Retool Runtime Real](LOGOS_RETOOL_RUNTIME_REAL.md). I blocchi e gli esempi precedenti a N21 descrivono le rispettive versioni storiche.

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO · snapshot storico v12 (4 giugno 2026)
------------------------------------------------

C (Completezza): 10/10  
- inclusa logica reale aggiornata post STEP 6.4  
- project_state / entity_state documentati come fonte minima matching  
- coperti project + entity + hint + auto-select + confirm guard  
- documentato singleMatch  
- documentato isAmbiguous  
- documentato moreSpecificMatches  
- documentato priority match minimo  
- documentato create flow con match state live  
- documentato edit flow con match state live  
- documentato rapporto con preview / highlight / hint  
- esplicitati limiti residui
- documentato rapporto tra match state e create_suggestion_state
- documentato Project / Entity Create Suggestion First Controlled Level
- documentato che la suggestion consuma il matching ma non lo sostituisce
- documentata creazione project/entity solo previa conferma utente
- documentata regola select = decisione utente finale
- documentato blocco solo su ambiguità attiva
- documentato entity autofill controlled minimal come supporto suggestion, non matching  
- documentato Command Intent — Create Project / Entity
- chiarito che command_intent_state non è parte del Match Engine
- chiarito che command_intent_state non sostituisce project_state / entity_state
- chiarito che command_intent_state non sostituisce create_suggestion_state
- documentato che i comandi puri non entrano nel save flow evento
- documentato blocco duplicati project/entity esistenti da command
- documentata separazione tra matching, suggestion e command intent
- documentato rapporto tra Match Engine e UI Readiness / Visibility Aggregator
- chiarito che ui_visibility_state può leggere project_state / entity_state solo per visibilità/hint
- chiarito che ui_visibility_state non sostituisce project_state / entity_state
- chiarito che ui_visibility_state non modifica matching, select o confirm guard
- chiarito che ui_visibility_mode non è parte del Match Engine
- documentato residuo Input Analysis Model / Single Interpretation Layer come futuro non attivo
- documentato rapporto tra Match Engine e preview_analysis_state
- documentato rapporto tra Match Engine e input_analysis_result
- chiarito che input_analysis_result legge project_state / entity_state ma non sostituisce il matching
- chiarito che input_analysis_result distingue raw match / selection / effective usability
- chiarito che input_analysis_result non modifica project_state / entity_state
- chiarito che input_analysis_result non modifica select_project / select_entity
- chiarito che input_analysis_result non modifica confirm guard funzionale o payload
- documentato che il Match Engine resta invariato dopo Controlled UI Consumption Pass
- documentato che il Match Engine resta invariato dopo Input Analysis Result — Visibility Migration Completion
- documentato che input_analysis_result ora governa gli Hidden principali del flow input senza modificare project_state / entity_state
- documentato che ui_visibility_state non è più letto da input_analysis_result
- documentato che ui_visibility_state resta residuo tecnico deprecabile e non fonte matching
- documentato che button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm
- documentato che button_input_confirm.Disabled resta guard funzionale separata
- documentato che button_input_confirm payload resta invariato
- documentato che Linting / Retool Query Safety Pass non ha modificato il Match Engine
- documentato linting Retool azzerato nel Retool Query Safety Pass (fotografia pre-N18). Il checkpoint N18 del 6 novembre 2026 registra 11 segnalazioni residue qualificate; il conteggio attuale non è stato verificato in N21
- documentato caso match più specifico come policy non bloccante invariata
- documentata responsabilità canonica del documento nel modello post Pacchetto B
- chiarito che State, Roadmap e Gap Register richiamano il Match Engine senza duplicarne il dettaglio tecnico completo
- aggiunti richiami canonici ai documenti tecnici collegati
- documentato completamento G22 Project Create Suggestion — Match Present / User Override / Auto-select Confidence
- documentata distinzione tra match sicuro, match generico, match presente + suggestion extension e ambiguità reale
- documentato requiresUserOverride come flag UI derivato da create_suggestion_state
- chiarito che match presente + suggestion extension non blocca Conferma
- chiarito che match presente + suggestion extension non svuota select_project / select_entity
- chiarito che il warning generico da moreSpecificMatches non viene più usato per il caso G22
- documentato che Da verificare segnala il rischio decisionale mentre Suggerimenti associazione propone l’azione
- confermato che G22 non richiede G10A Match Engine Evolution Advanced

Q (Qualità): 9.5/10  
- logica matching ora più coerente  
- ridotta duplicazione tra state / select / preview / confirm  
- preview non è più fonte decisionale matching  
- controllo manuale utente preservato  
- nessuna automazione decisionale aggressiva  
- nessuna anticipazione data structure / KPI / output  
- limiti futuri chiari  
- chiarita separazione tra match, suggestion e salvataggio
- mantenuto il match engine non decisionale
- ridotto rischio di confondere no-match con errore bloccante
- preservata coerenza con Core Event System incrementale
- Command Intent integrato come layer separato e non concorrente al matching
- evitata duplicazione tra match engine e command intent
- chiarito che la rilevazione “elemento già presente” da command è una guardia UI, non deduplicazione strutturale
- mantenuto il principio select = decisione finale per gli eventi ordinari
- mantenuta separazione tra matching e visibility/readiness UI
- evitata confusione tra aggregatore Hidden e Match Engine
- confermato che UI Readiness non modifica la logica matching
- confermato che il Match Engine resta fonte minima project/entity per eventi ordinari
- input_analysis_result documentato come layer compositivo, non come nuovo motore matching
- preservata separazione tra matching, selection, suggestion, command e UI readiness
- evitata confusione tra raw match e dato effettivamente usabile nel flow corrente
- mantenuto il principio select = decisione finale salvabile
- confermato che la Visibility Migration non ha alterato la responsabilità del Match Engine
- confermato che project_state / entity_state restano fonte minima matching
- confermato che input_analysis_result compone raw / selection / effective senza calcolare matches
- chiarita separazione tra visibility del flow input e matching project/entity
- chiarita separazione tra button_input_confirm.Hidden e confirm guard funzionale
- confermato che la policy match più specifici resta informativa e non bloccante
- confermato che il nodo linting ha ridotto rumore tecnico senza modificare logica matching
- rafforzato il ruolo del documento come fonte madre del matching
- ridotto rischio di ricalcolo futuro delle decisioni consolidate sul matching
- chiariti i confini tra Match Engine e documenti canonici collegati
- ridotto il rischio di salvataggio inconsapevole su match generico auto-selezionato
- migliorata la distinzione semantica tra warning, hint e suggestion operativa
- evitato ritorno a warning generici “Esistono progetti più specifici” / “Esistono entità più specifiche” nei casi non realmente richiesti dall’input
- mantenuto il principio non bloccante del sistema
- preservata la separazione tra Match Engine, create_suggestion_state e preview_analysis_state
- evitata apertura anticipata di G10A per un caso risolvibile localmente

D (Deployabilità): 10/10  
- direttamente utilizzabile come riferimento runtime  
- allineato a implementazione Retool reale  
- create flow validato  
- edit flow validato  
- DB invariato  
- parser invariato  
- type classification invariata  
- duration normalization invariata 
- Project / Entity Create Suggestion validato runtime
- flow combinato project + entity validato
- no-match generico salvabile validato
- edit/no-op non regressivo validato dopo create suggestion
- Command Intent — Create Project / Entity validato runtime
- evento ordinario non regressivo dopo Command Intent validato
- edit flow non regressivo dopo Command Intent validato
- comandi puri create project/entity esclusi dal save flow evento
- command_intent_state validato come helper separato dal matching
- UI Readiness / Visibility Aggregator validato come layer separato dal matching
- test obbligatori 1–16 post UI Readiness superati senza regressione matching
- create flow non regressivo dopo UI Readiness validato
- edit flow non regressivo dopo UI Readiness validato
- suggestion project/entity non regressiva dopo UI Readiness validata
- DB invariato
- matching invariato
- Preview Analysis State validato senza regressione matching
- Input Analysis Result Read-only Diagnostic validato senza regressione matching
- Controlled UI Consumption Pass validato senza regressione matching
- project_state / entity_state invariati
- select_project / select_entity invariati
- create_suggestion_state invariato
- command_intent_state invariato
- button_input_confirm payload invariato
- Visibility Migration Completion validata senza regressione matching
- project_state invariato
- entity_state invariato
- select_project invariato
- select_entity invariato
- create_suggestion_state invariato nella logica funzionale
- command_intent_state invariato nella logica funzionale
- button_input_confirm.Hidden migrato senza modificare Disabled / payload
- Linting / Retool Query Safety Pass validato senza regressione matching
- linting Retool azzerati
- typing_state eliminato senza impatto matching
- handle_event_success eliminato senza impatto matching
- documento coerente con la Documentation Architecture Audit / Redundancy Reduction
- pronto come fonte canonica per future sessioni su matching project/entity
- G22 validato su runtime Retool reale
- test 20 euro villa validato senza warning project non necessario
- test 20 euro villa sierri validato con warning mirato “Associazione progetto da controllare”
- test 20 euro villa sierri 6 validato con selezione specifica diretta
- test 20 euro tecnico mario validato senza warning entity non necessario
- test crea progetto test validato senza regressione Command Intent
- test 20 euro mario rossi validato con match specifico diretto
- test 20 euro mario giordano validato con warning mirato “Associazione entità da controllare”
- button_input_confirm.Disabled invariato
- button_input_confirm.Hidden invariato
- payload invariato
- insert_event / update_event invariati
- DB invariato
- Supabase invariato
- G10A non necessario per il caso G22

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il comportamento reale del sistema di matching
tra input utente e dati esistenti.

Il documento guida:

- suggerimenti automatici
- selezione project/entity
- gestione ambiguità
- comportamento runtime coerente
- identificazione debiti strutturali del matching
- rapporto tra matching e create suggestion
- distinzione tra match, suggestion, select e insert
- distinzione tra match engine, create suggestion e command intent
- rapporto tra project_state/entity_state e command_intent_state
- limiti del command intent rispetto al matching
- rapporto tra Match Engine e UI Readiness / Visibility Aggregator
- distinzione tra project_state/entity_state e ui_visibility_state
- chiarimento che ui_visibility_state non è fonte matching
- chiarimento che ui_visibility_mode non è Match Engine
- rapporto tra Match Engine e preview_analysis_state
- rapporto tra Match Engine e input_analysis_result
- chiarimento che input_analysis_result non è Match Engine
- chiarimento che input_analysis_result compone raw / selection / effective state ma non calcola matches
- chiarimento che il Controlled UI Consumption Pass non ha modificato il matching
- chiarimento che Input Analysis Result — Visibility Migration Completion non ha modificato il matching
- chiarimento che la migrazione degli Hidden principali a input_analysis_result non modifica project_state / entity_state
- chiarimento che button_input_confirm.Hidden migrato non modifica confirm guard funzionale
- chiarimento che Linting / Retool Query Safety Pass non modifica il Match Engine
- chiarimento che la policy match più specifici resta invariata
- chiarimento della policy G22 su match presente + suggestion extension
- distinzione tra auto-select sicuro e auto-select da controllare
- rapporto tra warning mirato Da verificare e suggestion operativa
- conferma che requiresUserOverride è policy UI derivata e non modifica il Match Engine

------------------------------------------------
RESPONSABILITÀ CANONICA DEL DOCUMENTO
------------------------------------------------

Questo documento è fonte canonica per:

- Match Engine project/entity
- project_state
- entity_state
- matches / count / hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches
- priority match minimo
- auto-select tramite singleMatch
- gestione ambiguità project/entity
- confirm guard collegata ad ambiguità non risolta
- policy match più specifici
- rapporto tra matching e select_project / select_entity
- rapporto tra matching e create_suggestion_state
- rapporto tra matching e Command Intent
- rapporto tra matching e input_analysis_result
- limiti futuri del Match Engine
- policy Match Present / User Override / Auto-select Confidence
- distinzione tra moreSpecificMatches informativo e suggestion extension contestuale
- confine tra auto-select del Match Engine e warning G22 derivato da create_suggestion_state

Questo documento NON è fonte canonica completa per:

- input flow / parser / normalization
- Command Intent nel dettaglio runtime completo
- create_suggestion_state nel dettaglio input completo
- componenti / query / Hidden Retool completi
- Sintesi / preview / hint / warning completi
- lifecycle evento completo
- schema DB completo
- runtime Retool as-is completo
- runtime Supabase as-is completo

Fonti canoniche collegate:

- 01_LOGOS_Input_System per input flow, parser, normalization, Command Intent nel contesto input, create_suggestion_state e input_analysis_result.
- 03_LOGOS_Event_Lifecycle per lifecycle evento, edit, no-op, cancel, NEW / WRITTEN / ERROR e processing.
- 04_LOGOS_Retool_Architecture per componenti, query, Hidden, select e wiring Retool.
- 05_LOGOS_Database_Schema per schema DB, tabelle, campi e vincoli.
- 06_LOGOS_View_Preview_System per Sintesi, preview, hint, warning, highlight e label visuali.
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is.
- LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase / storage passivo.

Nota post Pacchetto B:

State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo del Match Engine.
Il dettaglio completo resta in questo documento e nei documenti canonici collegati.

------------------------------------------------
PRINCIPI FONDANTI
------------------------------------------------

1. SUGGERIRE ≠ DECIDERE

Il sistema suggerisce, non impone.

---

2. MATCH SOLO SE AFFIDABILE

Auto-selezione solo con certezza reale.

---

3. NO ASSUNZIONI

Nessuna inferenza implicita.

---

4. UTENTE IN CONTROLLO

La selezione finale è sempre manuale.

---

5. RIDUZIONE RUMORE

Il matching deve evitare falsi positivi.

---

6. MATCHING ≠ NORMALIZATION

Il matching non normalizza amount/unit/date.

La normalizzazione base è gestita dal layer input/parser:

parse_input_controlled
→ risultato del parser correlato nel bundle → analysis_snapshot.parsed (mirror compatibile ui_state.parsed nello stesso publish)

Il matching resta dedicato a:

- project
- entity
- ambiguità
- suggerimenti

---

7. MATCHING ≠ CREAZIONE

Il matching non crea project/entity.

La creazione guidata è gestita dal layer successivo:

create_suggestion_state
→ container suggestion
→ conferma utente
→ insert_project / insert_entity

Il matching alimenta la suggestion,
ma non scrive dati nel DB.

---

8. SELECT = DECISIONE UTENTE

La select resta la decisione finale salvabile.

select_project.value → events.project_id
select_entity.value → events.entity_id

La selezione manuale è valida anche se il valore selezionato
non è presente nel raw_input.

---

9. AUTO-SELECT ≠ CERTEZZA ASSOLUTA

La presenza di singleMatch consente l’auto-valorizzazione della select,
ma non significa sempre che l’associazione sia semanticamente definitiva.

Caso G22:

input:
20 euro villa sierri

project_state:
singleMatch = Villa

create_suggestion_state:
candidateName = Villa Sierri
reason = extension
requiresUserOverride = true

Interpretazione:

- Villa è un match reale
- Villa Sierri è una possibile nuova associazione più specifica
- la select resta valorizzata su Villa
- Conferma resta attiva
- il sistema segnala il controllo nella card Da verificare
- il container Suggerimenti associazione propone l’azione di creazione

Regole:

- non svuotare select_project / select_entity
- non trasformare il caso in ambiguità bloccante
- non modificare button_input_confirm.Disabled
- non modificare payload
- non modificare save flow
- non modificare DB
- non aprire G10A se il caso è risolvibile con policy locale G22

Il Match Engine continua a suggerire.
La UI esplicita il rischio decisionale.
L’utente decide.

---

10. MATCHING ≠ COMMAND INTENT

Il Match Engine riconosce project/entity dentro input evento ordinario.

Il Command Intent riconosce comandi strutturali puri.

Esempi command intent:

- crea
- crea progetto
- crea progetto Villa Nuova
- crea entità Patrizio
- modifica evento

Regole:

- command_intent_state NON è il Match Engine
- command_intent_state NON sostituisce project_state / entity_state
- command_intent_state NON sostituisce create_suggestion_state
- command_intent_state NON salva eventi
- command_intent_state NON decide project_id/entity_id negli eventi ordinari
- command_intent_state può verificare se un project/entity esiste già
- la verifica “elemento già presente” è una guardia UI, non deduplicazione strutturale DB
- i comandi puri vengono esclusi dal save flow evento
- select_project / select_entity restano la decisione finale salvabile per eventi ordinari

11. MATCHING ≠ UI READINESS / VISIBILITY

Il Match Engine calcola project/entity matching per eventi ordinari.

UI Readiness / Visibility Aggregator governa solo la visibilità del flow input.

Componenti UI Readiness:

- ui_visibility_mode
- input_analysis_result
- ui_visibility_state residuo tecnico deprecabile

Regole:

- input_analysis_result può leggere project_state / entity_state
- input_analysis_result può leggere select_project / select_entity
- input_analysis_result può usare isAmbiguous / select valorizzate per calcolare readiness/effective usability
- input_analysis_result NON calcola matches
- input_analysis_result NON calcola count
- input_analysis_result NON calcola singleMatch
- input_analysis_result NON calcola moreSpecificMatches
- input_analysis_result NON sostituisce project_state
- input_analysis_result NON sostituisce entity_state
- input_analysis_result NON modifica select_project / select_entity
- input_analysis_result NON modifica button_input_confirm payload
- input_analysis_result NON modifica confirm guard funzionale
- input_analysis_result NON salva dati
- input_analysis_result NON scrive DB
- ui_visibility_state non è più fonte degli Hidden principali del flow input
- ui_visibility_state non è più letto da input_analysis_result
- ui_visibility_state resta residuo tecnico deprecabile

ui_visibility_mode distingue solo:

- empty
- event
- command

Non riconosce project/entity.
Non è Match Engine.
Non è Input Analysis Model completo.

12. MATCHING ≠ INPUT_ANALYSIS_RESULT

input_analysis_result non è il Match Engine.

Il Match Engine resta composto da:

- project_state
- entity_state

input_analysis_result legge i risultati correlati analysis_snapshot.project/entity/command/suggestion/parsed, i controlli e i cataloghi correnti e preview_analysis_state. project_state/entity_state restano le origini canoniche del riconoscimento; non si consumano i loro .data indipendenti come autorità di questo bundle.

ma non calcola:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

input_analysis_result distingue:

- raw match:
  risultato tecnico di project_state / entity_state

- selection:
  valore attuale delle select

- effective usability:
  se quel match/valore è realmente utilizzabile nel flow corrente

Esempi:

- in event flow, project/entity raw possono diventare usable se coerenti
- in command flow, project/entity raw possono esistere ma vengono ignorati come dati evento
- in edit mode, command raw può essere true ma command effective viene soppresso

Regole:

- input_analysis_result NON modifica project_state
- input_analysis_result NON modifica entity_state
- input_analysis_result NON modifica select_project / select_entity
- input_analysis_result NON crea project/entity
- input_analysis_result NON modifica create_suggestion_state
- input_analysis_result NON modifica command_intent_state
- input_analysis_result NON modifica button_input_confirm payload
- input_analysis_result NON salva dati
- input_analysis_result NON scrive DB

Il suo ruolo è compositivo/readiness UI,
non matching.

Nota post Visibility Migration Completion:

input_analysis_result governa ora anche gli Hidden principali del flow input.

Questo non cambia il suo rapporto con il Match Engine.

input_analysis_result continua a:

- leggere project_state / entity_state
- leggere select_project / select_entity
- comporre raw / selection / effective usability
- distinguere event / command / edit flow
- governare visibility/readiness UI

ma continua a NON:

- calcolare matches
- selezionare project/entity
- modificare project_state / entity_state
- modificare select_project / select_entity
- cambiare confirm guard funzionale
- costruire payload
- salvare dati

button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm.

button_input_confirm.Disabled resta una proprietà del componente: usa readiness.canConfirm, confirm_event.isFetching e validità dei choiceValues correnti, con guardie finali nel coordinatore.

------------------------------------------------
ENTITÀ COINVOLTE
------------------------------------------------

PROJECT:

- projects_list
- struttura: {id, name}

---

ENTITY:

- entities_list
- struttura: {id, name}

------------------------------------------------
POSIZIONE NEL RUNTIME ATTUALE
------------------------------------------------

Il matching opera dentro il seguente flow:

input_home → input_raw e invalidazione della revisione/consenso
→ trigger_parse_debounced: richiesta identificata per revisione, testo e contesto
→ parser, project_state, entity_state e Command Intent canonici sulla stessa richiesta
→ suggestion canonica correlata → unico publish di ui_state.analysis e mirror ui_state.parsed
→ analysis_snapshot validato → IAR, Select ordinarie, Tipo e preview
→ decisioni INACTIVE contestuali nelle Select inline, se richieste
→ button_input_confirm delega confirm_event(begin)
→ guardie/lock, no-op e command guard → preflight e verifica fingerprint/consume-once
→ un solo ramo insert_event oppure update_event
→ dopo successo: reset, refresh e feedback/routing contestuale.
La creazione Project/Entity resta un’azione separata già esistente, non un secondo salvataggio evento.

---

Dopo lo STEP 6.4 — MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL:

- amount / unit / event_date provengono da analysis_snapshot.parsed validato; ui_state.parsed è mirror compatibile
- type resta gestito da select1.value
- project/entity matching è calcolato da project_state / entity_state
- select_project / select_entity leggono singleMatch
- preview hint legge count / isAmbiguous
- preview highlight legge matches
- confirm guard legge ambiguità non risolta

Nota:

Il matching lavora sul testo input_raw,
non sui valori numerici normalizzati.

ui_state.parsed NON è stato esteso a project/entity.
Il matching resta un layer separato.

Dopo PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL:

- create_suggestion_state consuma project_state / entity_state
- no-match project/entity può generare suggestion controllata
- project/entity possono essere creati inline solo previa conferma utente
- insert_project / insert_entity non sono parte del matching
- evento non viene salvato automaticamente dopo creazione project/entity
- select_project / select_entity restano fonte finale salvabile

Dopo COMMAND INTENT — CREATE PROJECT / ENTITY:

- command_intent_state riconosce comandi puri
- command_intent_state resta separato dal Match Engine
- command_intent_state non calcola il match primario project/entity per gli eventi
- command_intent_state può rilevare project/entity già esistenti per evitare duplicazioni da command
- container_command_intent sostituisce Sintesi evento / Dati evento quando l’input è comando puro
- i comandi puri non vengono salvati come eventi
- insert_project / insert_entity vengono usati solo dopo conferma utente
- button_input_confirm resta dedicato agli eventi ordinari

Dopo UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL:

- ui_visibility_mode distingue empty / event / command a livello UI
- ui_visibility_state aggrega la visibilità del flow input
- ui_visibility_state può leggere project_state / entity_state per capire se esistono ambiguità non risolte
- ui_visibility_state governa la visibilità di suggestion, Dati evento, Conferma e container command
- ui_visibility_state non modifica project_state / entity_state
- ui_visibility_state non modifica create_suggestion_state
- ui_visibility_state non modifica select_project / select_entity
- ui_visibility_state non modifica il Match Engine
- il Match Engine resta fonte minima project/entity per eventi ordinari

Dopo PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER:

- preview_analysis_state raccoglie hint/status/warning/Da verificare/associazioni mancanti della Sintesi
- preview_analysis_state può leggere stati derivati da project_state / entity_state
- preview_analysis_state non modifica project_state / entity_state
- preview_analysis_state non calcola matching
- preview_analysis_state non seleziona project/entity
- preview_analysis_state non modifica confirm guard o payload

Dopo INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS:

- input_analysis_result legge project_state / entity_state come raw match source
- input_analysis_result legge select_project / select_entity come selection source
- input_analysis_result calcola project/entity effective usability
- input_analysis_result distingue event / command / edit flow
- input_analysis_result può ignorare project/entity raw in command flow
- input_analysis_result può sopprimere command effective in edit mode
- input_analysis_result governa parte della UI/readiness
- input_analysis_result non modifica il Match Engine
- input_analysis_result non modifica project_state / entity_state
- input_analysis_result non modifica select_project / select_entity
- input_analysis_result non modifica create_suggestion_state
- input_analysis_result non modifica command_intent_state
- input_analysis_result non modifica button_input_confirm payload
- input_analysis_result non salva dati

Dopo INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION:

- input_analysis_result governa gli Hidden principali del flow input
- container_input.Hidden legge input_analysis_result
- text_input_analysis_loading.Hidden legge input_analysis_result
- btn_cancel_edit.Hidden legge input_analysis_result
- btn_cancel_input_home.Hidden legge input_analysis_result
- button_input_confirm.Hidden legge input_analysis_result.readiness.canShowConfirm
- canShowConfirm governa solo la visibilità del bottone Conferma
- button_input_confirm.Disabled resta guard funzionale separata
- button_input_confirm payload resta invariato
- input_analysis_result non legge più ui_visibility_state
- ui_visibility_state resta residuo tecnico deprecabile
- Match Engine invariato
- project_state / entity_state invariati
- select_project / select_entity invariati
- create_suggestion_state invariato nella logica funzionale
- command_intent_state invariato nella logica funzionale

Dopo LINTING / RETOOL QUERY SAFETY PASS:

- linting Retool azzerati
- typing_state eliminato come query legacy unused
- handle_event_success eliminato come query legacy unused
- nessuna modifica a project_state / entity_state
- nessuna modifica a select_project / select_entity
- nessuna modifica al Match Engine

------------------------------------------------
PIPELINE MATCH
------------------------------------------------

Pipeline match attuale post INPUT ANALYSIS RESULT VISIBILITY MIGRATION COMPLETION:

input_raw  
→ project_state / entity_state  
→ matches / count / isAmbiguous / singleMatch  
→ create_suggestion_state  
→ select_project / select_entity  
→ preview_analysis_state legge stato matching per hint/status preview  
→ input_analysis_result legge raw match + selection + effective usability  
→ preview hint / highlight / suggestion container / Dati evento / Confirm Hidden  
→ button_input_confirm guard funzionale separata  
→ project_id / entity_id salvati solo se selezionati      

Pipeline command separata:

input_raw  
→ command_intent_state  
→ container_command_intent  
→ btn_command_create_project / btn_command_create_entity / btn_command_go_events  
→ insert_project / insert_entity oppure Lista eventi  

Nota:

questa pipeline NON è Match Engine.

Serve a intercettare comandi puri prima che vengano trattati come eventi.

---

Fonte minima osservabile:

project_state  
entity_state  

---

Output standard di project_state / entity_state:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

---

Principio:

project_state / entity_state calcolano il matching.

create_suggestion_state legge il risultato del matching
e genera eventuali suggestion controllate.

create_suggestion_state NON calcola il match primario.
create_suggestion_state NON salva dati.
create_suggestion_state NON decide project/entity al posto dell’utente.

select_project / select_entity NON ricalcolano più il matching.
Leggono singleMatch.

preview NON usa più detection locale come fonte decisionale.
Legge matches / count / isAmbiguous.

button_input_confirm NON valuta più direttamente array matches in modo fragile.
Legge ambiguità non risolta.

command_intent_state NON modifica questa regola.

ui_visibility_state NON modifica questa regola ed è ora residuo tecnico deprecabile.

preview_analysis_state NON modifica questa regola.

input_analysis_result NON modifica questa regola.

Visibility Migration Completion NON modifica questa regola.

Il fatto che input_analysis_result governi più Hidden UI non lo rende Match Engine.

input_analysis_result può comporre lo stato effettivo del flow,
ma non cambia la fonte minima matching:

- project_state
- entity_state

e non cambia le fonti salvabili:

- select_project.value
- select_entity.value

UI Readiness può decidere se mostrare o nascondere componenti,
ma non cambia la fonte matching e non decide project/entity.

Per gli eventi ordinari:

- project_state resta fonte minima matching project
- entity_state resta fonte minima matching entity
- select_project / select_entity restano fonti salvabili
- button_input_confirm resta il punto di conferma evento

Per i comandi puri:

- il flow evento viene escluso
- container_command_intent usa azioni command dedicate
- nessun project_id/entity_id viene salvato in events

------------------------------------------------
NORMALIZZAZIONE MATCHING
------------------------------------------------

La normalizzazione comune delle query B1 usa minuscole, NFD con rimozione dei caratteri combinanti nell’intervallo U+0300–U+036F, compressione degli spazi e trim. Mantiene i nomi originali per rappresentazione. Sotto tre caratteri di input normalizzato restituisce insiemi vuoti. I token sono estratti con `[a-z0-9]+`. Il nome completo è cercato come frase a confini di parola, con parti regex-escaped e spazi flessibili.

Per nomi senza token interamente numerici, vale una frase completa oppure la presenza di tutte le parole significative (lunghezza maggiore di due, esclusi i numeri) come token interi. Il fallback richiede almeno una parola significativa; non contiene ranking fuzzy e può accettare parole significative in ordine diverso. Se tra i match-base sono presenti nomi completi, si conservano soltanto quelli. Tra i candidati residui, un nome generico coperto da un nome specifico più lungo esce dall’insieme, mentre due omonimi con UUID distinti rimangono distinti.

Un token numerico nel nome impone la frase completa. Il match-base viene escluso se segue immediatamente un’unità elencata dalla regola (euro, eur, simbolo €, ora, ore, h, min, minuto o minuti). Così il 20 di `Spesa 20 euro Villa` non identifica `Villa 20`, né `Mario` identifica con certezza `Mario 2`. Il ramo successivo delle alternative plausibili verifica il suffisso numerico per uguaglianza; un’alternativa può richiedere scelta manuale, separata dalla preselezione.

---

Distinzione importante:

NORMALIZATION LAYER BASE:

- amount
- unit
- event_date
- duration normalization

Fonte:
parse_input_controlled sulla richiesta canonica → trigger_parse_debounced verifica la correlazione → unico publish di ui_state.analysis con mirror parsed → analysis_snapshot.parsed validato

MATCH NORMALIZATION:

- testi project/entity
- nomi
- token
- ambiguità
- singleMatch
- moreSpecificMatches

Fonte:
testo e repertori congelati in analysis_request → project_state / entity_state canonici → risultati correlati nel bundle

---

Regola:

il matching può leggere input_raw perché project/entity sono contenuti nel testo libero.

input_raw NON torna fonte di verità per amount/unit/event_date.

analysis_snapshot.parsed è il risultato parsato validato per i consumer Q2; ui_state.parsed resta la proiezione compatibile dello stesso publish.

------------------------------------------------
PROJECT MATCH ATTUALE
------------------------------------------------

### MATCH CON VARIANTI E PREFISSI

I corpi canonici di project_state/entity_state ricevono testo e cataloghi della richiesta analysis_request. Lo Stato non restringe i repertori. matches contiene candidati per UUID, count il loro numero, hasMatch vale sopra zero, isAmbiguous sopra uno e singleMatch esiste soltanto con un candidato. I consumer Q2 leggono i risultati correlati analysis_snapshot.project/entity, non output indipendenti di esecuzioni diverse.

Il primo token immediatamente dopo la base individuata nel testo rende plausibile una variante se coincide con il primo token numerico del suffisso o, per testo di almeno tre caratteri, ne è prefisso. `plausibleAlternatives` entra nei candidati canonici per UUID senza sostituire la base. Perciò Casa Mar con Casa e Casa Mare porta a scelta manuale, mentre Casa esatta resta riconosciuta quando la sola esistenza di Casa Mare non rende plausibile un suffisso digitato. I flag `hasMoreSpecificMatches` e `hasPlausibleAlternatives` espongono separatamente la presenza delle due liste.

Solo Project aggiunge `prefixAlternatives`. Quando i candidati B1 sono zero, per ogni record si cerca il più lungo prefisso proprio di almeno due token interi presente come sequenza contigua nell’input. Si espongono i gruppi condivisi da almeno due record, deduplicati per UUID. Cucciolata Marzo può così mostrare 2025 e 2026 lasciando `count=0` e `singleMatch=null`. Questo ramo non seleziona, non altera gli output B1 e non rende ambiguo un campo che prima non lo era.

Le Select ordinarie usano i singleMatch di analysis_snapshot: nuove preselezioni soltanto ACTIVE, oppure FK storiche in edit. IAR risolve association.selectedId e l’eventuale candidato canonico unico INACTIVE senza selezione valida prevalente. Il coordinatore usa finalAssociationId: selectedId se non serve decisione; candidateId con Collega; null con Non collegare. Le due decisioni sono indipendenti. NULL non abilita nuove eccezioni, le FK storiche restano preservate. Non esiste ricerca manuale INACTIVE aggiuntiva. Il matcher Entity non acquisisce la regola del prefisso informativo Project. La creazione da comando rimane separata.

RELAZIONE CON CREATE SUGGESTION:

Nel contratto N21 l’estensione richiede una base già risolta via UUID o `singleMatch`, senza ambiguità, alternative plausibili o prefisso informativo Project. La disponibilità di nomi sul repertorio intero serve al controllo dei duplicati. Il caso G22 seguente è un esempio storico di estensione, antecedente alla qualificazione N21 di Villa Sierri con varianti numerate.

Se project_state rileva un match base valido e create_suggestion_state
individua una possibile estensione non ancora presente,
il sistema può proporre la creazione di un nuovo project.

Esempio:

input:
villa sierri 15 sopralluogo

project_state:
singleMatch = Villa

create_suggestion_state:
candidateName = Villa Sierri 15

Azione utente:
Crea progetto → insert_project → select_project = Villa Sierri 15

Nota:

questo non modifica la regola del matching.
Villa resta match base reale.
Villa Sierri 15 è una suggestion di creazione controllata.

------------------------------------------------
AUTO-SELECT LOGIC
------------------------------------------------

Auto-select SOLO tramite:

analysis_snapshot.value?.project?.singleMatch  
analysis_snapshot.value?.entity?.singleMatch  

Nota post UI Readiness:

ui_visibility_state non partecipa all’auto-select.
input_analysis_result non partecipa all’auto-select.

Non può valorizzare:

- select_project
- select_entity

La selezione automatica resta limitata a singleMatch.

Nota post Input Analysis Result:

input_analysis_result non partecipa all’auto-select.

Non può valorizzare:

- select_project
- select_entity

Non può sostituire:

- analysis_snapshot.value?.project?.singleMatch
- analysis_snapshot.value?.entity?.singleMatch

La selezione automatica resta limitata a singleMatch prodotto da project_state / entity_state.

Nota post Visibility Migration Completion:

La migrazione storica degli Hidden non modificava i default; i binding finali Q2 usano lo snapshot con le guardie ordinarie N21 mantenute.

In un nuovo evento i default restituiscono il singleMatch dello snapshot soltanto se ACTIVE. In edit restituiscono la FK persistita o null. Le opzioni non ACTIVE restano disabilitate salvo l’UUID storico invariato. Questa regola delle Select ordinarie è distinta dall’eccezione INACTIVE esplicita risolta dal coordinatore.

NON auto-select se:

- isAmbiguous = true
- count > 1
- nessun match
- valore manuale già scelto dall’utente in caso di ambiguità risolta

---

Regola:

il match engine suggerisce.
La Select ordinaria fornisce la selezione; la FK finale dell’evento è risolta da confirm_event sulla proiezione IAR e sulle eventuali decisioni inline.
L’utente mantiene controllo.

------------------------------------------------
GESTIONE AMBIGUITÀ
------------------------------------------------

Ambiguità calcolata da:

analysis_snapshot.value?.project?.isAmbiguous
analysis_snapshot.value?.entity?.isAmbiguous

---

CASO 1 — Ambiguità non risolta

Condizione:

project_state.isAmbiguous = true
e select_project vuoto

oppure:

entity_state.isAmbiguous = true
e select_entity vuoto

Comportamento:

- mostra hint rosso
- non auto-seleziona
- button_input_confirm disabilitato

---

CASO 2 — Ambiguità risolta manualmente

Condizione:

project_state.isAmbiguous = true
ma select_project valorizzato manualmente

oppure:

entity_state.isAmbiguous = true
ma select_entity valorizzato manualmente

Comportamento:

- hint rosso rimosso
- button_input_confirm abilitato
- valore scelto dall’utente viene salvato

---

CASO 3 — Nessun match

Condizione:

count = 0

Comportamento:

- nessun hint ambiguità
- select vuota
- confirm non bloccato

Motivo:

LOGOS deve restare non bloccante.

Dopo Project / Entity Create Suggestion First Controlled Level,
il nessun match può generare una suggestion controllata,
ma non blocca il salvataggio.

L’utente può:

- creare project/entity inline
- ignorare la suggestion
- salvare evento con project_id/entity_id null

---

Confirm guard finale:

Conferma disabilitata se:

- input vuoto
- project ambiguo e select_project vuoto
- entity ambigua e select_entity vuoto

Conferma abilitata se:

- match univoco
- nessun match
- ambiguità risolta manualmente

---

Regola post create suggestion:

project/entity mancanti ≠ blocco.

project/entity ambigui = blocco finché non risolti manualmente.

La suggestion non cambia il confirm guard:
lo arricchisce solo con un percorso guidato opzionale.

Il command intent non cambia il confirm guard degli eventi ordinari.

Nota post UI Readiness:

input_analysis_result può leggere lo stato di ambiguità per decidere readiness/visibility di:

- suggestion container
- Dati evento
- Conferma Hidden

ma non modifica la regola di ambiguità.

Il blocco funzionale resta:

- project ambiguo + select_project vuoto
- entity ambigua + select_entity vuoto

input_analysis_result non risolve ambiguità.
input_analysis_result non seleziona project/entity.
input_analysis_result non cambia il confirm guard logico.

ui_visibility_state resta residuo tecnico deprecabile e non è fonte matching.

Nota post Input Analysis Result:

input_analysis_result può leggere ambiguità e selection per calcolare readiness/effective usability,
ma non risolve ambiguità.

input_analysis_result non seleziona project/entity.
input_analysis_result non cambia il confirm guard funzionale.
input_analysis_result non modifica button_input_confirm payload.

Dopo Visibility Migration Completion:

button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm.

Questo non modifica la guard funzionale Disabled.

La regola di blocco resta:

- project ambiguo + select_project vuoto
- entity ambigua + select_entity vuoto

Il blocco funzionale resta:

- project ambiguo + select_project vuoto
- entity ambigua + select_entity vuoto

In command flow, eventuali raw match project/entity possono essere presenti,
ma non vengono considerati dati evento usabili.

In edit flow, la regola matching resta quella degli eventi ordinari,
mentre command intent viene soppresso a livello effective.

Se l’input è comando puro:

- il confirm guard evento non viene usato
- button_input_confirm non deve essere mostrato
- container_command_intent gestisce la guida o l’azione controllata

------------------------------------------------
HINT SYSTEM
------------------------------------------------

Per il matching project/entity,
gli hint sono ora alimentati da project_state / entity_state.

---

HINT AMBIGUITÀ:

entity_state.isAmbiguous = true
e select_entity vuoto
→ "Più entità trovate"

project_state.isAmbiguous = true
e select_project vuoto
→ "Più progetti trovati"

---

HINT MATCH PIÙ SPECIFICI — STATO AGGIORNATO POST G22:

entity_state.hasMoreSpecificMatches / project_state.hasMoreSpecificMatches
restano segnali disponibili nel Match Engine.

Tuttavia, dopo G22, il warning generico:

- "Esistono entità più specifiche"
- "Esistono progetti più specifici"

non deve essere usato come warning principale nella card Da verificare
quando il problema reale è una suggestion extension.

Motivo:

hasMoreSpecificMatches indica che nel DB esistono record più specifici
rispetto al singleMatch selezionato.

Non indica necessariamente che l’input corrente stia chiedendo proprio
quella associazione più specifica.

Per i casi G22 il warning corretto deriva da create_suggestion_state:

- project.requiresUserOverride = true
- entity.requiresUserOverride = true

Output preview consolidato:

- "Associazione progetto da controllare"
- "Associazione entità da controllare"

con action testuale:

- "[baseName] selezionato · testo letto: [candidateName]"
- "[baseName] selezionata · testo letto: [candidateName]"

Questo warning è non bloccante.

---

Caratteristiche:

- hint ambiguità = bloccante finché non risolto
- hint match più specifici = informativo non bloccante
- nessuna inferenza automatica definitiva
- controllo utente preservato

---

Nota:

gli hint matching sono ora più state-driven.

Restano embedded nella preview altri hint:

- type / Spesa / Incasso
- durata normalizzata
- durata ambigua

Questi non sono stati separati in un hint engine globale.

Nota post UI Readiness:

input_analysis_result governa la visibilità del container che ospita hint/suggestion,
ma non è un hint engine.

Non separa:

- hint matching
- hint duration/type
- warning
- “Da verificare”
- suggestion create

Dopo Preview Analysis State:

preview_analysis_state raccoglie a primo livello hint/status/warning/Da verificare/associazioni mancanti della Sintesi.

Questo riduce la logica hint embedded nella Sintesi,
ma non rende ancora la preview una view pura.

input_analysis_result legge preview_analysis_state e lo compone nella propria readiness/UI state.

Restano comunque demandati a nodi futuri:

- PREVIEW MODEL / HINT STATE CONSOLIDATION
- STATUS SEMANTICS ALIGNMENT

Nota post Visibility Migration Completion:

il caso “mario sopralluogo villa 2” conferma la policy corrente:

- match specifico/auto-selezione valida se singleMatch esiste
- warning “entità/progetti più specifici” resta informativo
- Conferma può restare attiva se esiste selezione effettiva
- il warning non è bloccante nella policy attuale

Riferimento storico alla policy pre-N21. Il comportamento effettivo su varianti pertinenti è nella sezione MATCH CON VARIANTI E PREFISSI. Il warning G22 di estensione resta distinto dagli avvisi UX sulle varianti già esistenti.

---

HINT / SUGGESTION DISTINCTION:

Hint informativo:

- segnala stato del match
- non apre insert
- non scrive DB

Suggestion create:

- propone azione guidata
- richiede conferma utente
- può eseguire insert_project / insert_entity
- non salva evento automaticamente

Esempio:

“Esistono progetti più specifici”
→ hint informativo

“Possibile nuovo progetto: Villa Sierri 15”
→ suggestion create

Command intent:

- riconosce comando strutturale puro
- non è un hint matching
- non è suggestion create dentro evento
- non salva evento
- può proporre creazione project/entity solo come azione command dedicata

Esempio:

“crea progetto Villa Nuova”
→ command intent
→ container_command_intent
→ btn_command_create_project
→ insert_project
→ nessun evento salvato

------------------------------------------------
RELAZIONE CON PREVIEW
------------------------------------------------

Nota canonica:

La fonte completa per Sintesi, preview, hint, warning,
highlight, label visuali e micro-copy è:

- 06_LOGOS_View_Preview_System

Questo documento conserva solo il rapporto tra Match Engine e preview:

- hint project/entity
- highlight project/entity
- ambiguità matching
- match più specifici
- separazione tra preview visuale e matching decisionale

La preview utilizza project_state / entity_state per:

- mostrare hint ambiguità
- mostrare hint match più specifici
- evidenziare project/entity
- supportare la scelta utente

---

Dopo STEP 6.4:

la preview NON usa più detection locale project/entity
come fonte decisionale matching.

Prima:

preview calcolava detectedProjects / detectedEntities
con logica token-based locale.

Dopo:

preview legge:

- analysis_snapshot.value?.project?.matches
- analysis_snapshot.value?.entity?.matches
- analysis_snapshot.value?.project?.count
- analysis_snapshot.value?.entity?.count
- analysis_snapshot.value?.project?.isAmbiguous
- analysis_snapshot.value?.entity?.isAmbiguous
- analysis_snapshot.value?.project?.hasMoreSpecificMatches
- analysis_snapshot.value?.entity?.hasMoreSpecificMatches

---

Highlight:

- project evidenziati da project_state.matches
- entity evidenziate da entity_state.matches
- nome completo evidenziato quando presente

Esempio:

villa 2 mario
→ villa 2 evidenziato come project
→ mario evidenziato come entity

---

Nota:

La preview resta layer ibrido:

- rendering
- label cleaning
- hint logic
- highlight
- formattazione visuale

Ma non è più fonte autonoma decisionale per il matching.

Dopo Command Intent:

la preview non deve rappresentare comandi puri come eventi.

Esempi:

crea progetto Villa Nuova
→ non deve mostrare Sintesi evento
→ deve mostrare container_command_intent

crea entità Patrizio
→ non deve mostrare Sintesi evento
→ deve mostrare container_command_intent

modifica evento
→ non deve mostrare Sintesi evento
→ deve mostrare guida command

Il command intent quindi riduce un caso di falsa preview evento,
ma non rende la preview un layer puro.

Dopo Input Analysis Result Controlled UI Consumption:

- la visibilità della preview è governata da input_analysis_result.readiness.canShowEventPreview
- container_command_intent è governato da input_analysis_result.readiness.canShowCommandContainer
- container_association_suggestions è governato da input_analysis_result.readiness.canShowAssociationSuggestions
- Dati evento sono governati da input_analysis_result.readiness.canShowEventData
- button_input_confirm.Hidden è migrato a input_analysis_result.readiness.canShowConfirm
- button_input_confirm.Disabled resta guard funzionale separata
- ui_visibility_state resta residuo tecnico deprecabile

Nota:

questo non modifica il matching.

La preview continua a leggere project_state / entity_state per hint e highlight.
input_analysis_result decide ora parte della visibility/readiness UI.

ui_visibility_state non governa più gli Hidden principali migrati.

Nessuno dei due modifica il matching.

La Visibility Migration Completion non modifica il contenuto della preview,
ma stabilizza quando i blocchi del flow input vengono mostrati.

Residuo osservato ma fuori Match Engine:

- label “Importo” ancora usata per valori durata

Nodo futuro:

PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT

------------------------------------------------
RELAZIONE CON CREATE SUGGESTION
------------------------------------------------

create_suggestion_state è un layer successivo al matching.

Nel flow Q2 l’adapter di create_suggestion_state riceve dalla medesima analysis_request il testo e i cataloghi congelati, i risultati canonici Project/Entity correlati e gli UUID delle selezioni catturate. Il corpo canonico continua a usare i propri parametri locali, non un matcher alternativo. Il trigger verifica __logosRequestId e pubblica suggestion nello stesso bundle.

Produce:

- project.noMatch
- project.shouldShowNoMatchHint
- project.shouldSuggestCreate
- project.candidateName
- project.draftName
- entity.noMatch
- entity.shouldShowNoMatchHint
- entity.shouldSuggestCreate
- entity.candidateName
- entity.draftName

Non produce:

- project_id salvabile direttamente
- entity_id salvabile direttamente
- amount
- unit
- event_date
- type

Regole:

- suggestion ≠ match
- suggestion ≠ decisione
- suggestion ≠ salvataggio evento
- suggestion ignorata non blocca conferma
- creazione project/entity richiede conferma utente
- evento resta non salvato dopo creazione project/entity

---

G22 — MATCH PRESENT / USER OVERRIDE / AUTO-SELECT CONFIDENCE

create_suggestion_state può individuare una candidate più specifica anche quando project_state / entity_state hanno già prodotto un singleMatch.

Questo caso non è no-match e non è ambiguità reale.

È classificato come:

MATCH PRESENT + SUGGESTION EXTENSION

Esempio project:

input:
20 euro villa sierri

project_state:
singleMatch = Villa

create_suggestion_state:
candidateName = Villa Sierri
baseName = Villa
reason = extension
requiresUserOverride = true

Comportamento consolidato:

- select_project resta valorizzata su Villa
- Conferma evento resta attiva
- button_input_confirm.Disabled non cambia
- payload non cambia
- insert_event / update_event non cambiano
- DB non cambia
- Da verificare mostra:
  Associazione progetto da controllare
  Villa selezionato · testo letto: Villa Sierri
- Suggerimenti associazione mostra:
  Possibile nuovo progetto: Villa Sierri
  pulsante Crea progetto

Esempio entity:

input:
20 euro mario giordano

entity_state:
singleMatch = Mario

create_suggestion_state:
candidateName = Mario Giordano
baseName = Mario
reason = extension
requiresUserOverride = true

Comportamento consolidato:

- select_entity resta valorizzata su Mario
- Conferma evento resta attiva
- Da verificare mostra:
  Associazione entità da controllare
  Mario selezionata · testo letto: Mario Giordano
- Suggerimenti associazione mostra:
  Possibile nuova entità: Mario Giordano
  pulsante Crea entità

Regola semantica:

Da verificare segnala il rischio decisionale.
Suggerimenti associazione propone l’azione disponibile.

Non duplicare nella suggestion container il dato già mostrato in Da verificare.

---

moreSpecificMatches resta segnale interno/informativo del Match Engine.

Non deve più produrre da solo warning generico nei casi G22.

Motivo:

“esistono record più specifici nel DB”
non equivale a
“l’input corrente richiede una nuova associazione più specifica”.

I warning G22 devono derivare da create_suggestion_state.requiresUserOverride,
non da hasMoreSpecificMatches.

---

PROJECT CREATE SUGGESTION

Attiva quando:

- esiste una candidate controllata
- non c’è ambiguità project
- la candidate non esiste già
- l’utente conferma la creazione

Esempio:

villa sierri 15 sopralluogo
→ candidate project: Villa Sierri 15

---

ENTITY CREATE SUGGESTION

Attiva quando:

- entity no-match reale
- entity non ambigua
- nessuna entity già selezionata
- l’utente conferma la creazione

Entity autofill controlled minimal:

- solo su prefissi forti
- non crea entity automaticamente
- non seleziona entity automaticamente
- precompila solo input_new_entity_name

Esempio:

referente kappa
→ draft entity: Referente Kappa

---

AMBIGUITÀ E CREATE SUGGESTION

La query consuma i campi canonici e un eventuale UUID scelto. Verifica il candidato normalizzato sulle anagrafiche complete (ACTIVE, INACTIVE e NULL), dopo pulizia dei token evento, e scarta estensioni che inglobano un nome già riconosciuto nell’altro repertorio. Evita un suggerimento Project prematuro in presenza di `prefixAlternatives`. Il confronto omonimie qui orienta la UI, mentre il preflight che precede l’INSERT anagrafico resta in N18.

Se project/entity è ambiguo:

- create suggestion non viene mostrata per quel layer
- Conferma resta disabilitata finché l’utente non sceglie manualmente

Dopo Input Analysis Result Controlled UI Consumption:

container_association_suggestions è ora visibile/nascosto tramite:

input_analysis_result.readiness.canShowAssociationSuggestions.

Dopo Visibility Migration Completion:

questa relazione resta invariata.

input_analysis_result governa la visibility del container,
ma create_suggestion_state resta fonte del contenuto operativo.

La migrazione visibility non modifica le regole suggestion.

Questo non modifica create_suggestion_state.

create_suggestion_state resta il layer che consuma il matching
e propone eventuale creazione controllata.

Regola consolidata:

missing association notice
≠
suggestion operativa

input_analysis_result può governare la visibilità del container,
ma non deve inventare contenuti se create_suggestion_state non li produce.

Il container non deve apparire vuoto.
------------------------------------------------
RELAZIONE CON COMMAND INTENT
------------------------------------------------

command_intent_state è un layer separato dal Match Engine
e da create_suggestion_state.

Consuma:

- input_raw.value / input_home.value
- projects_list.data
- entities_list.data

Produce:

- isCommand
- isPureCommand
- commandFamily
- commandType
- targetType
- candidateName
- existingId
- needsCompletion
- canExecute
- guideMessage
- rawInput

Non produce:

- matches
- count
- isAmbiguous
- singleMatch
- moreSpecificMatches
- project_id salvabile per events
- entity_id salvabile per events
- amount
- unit
- event_date
- type

Regole:

- command intent ≠ match
- command intent ≠ suggestion create da evento
- command intent ≠ salvataggio evento
- command intent ≠ select decision
- command intent ≠ deduplicazione strutturale
- command intent intercetta comandi puri
- command intent può bloccare creazioni duplicate da command se riconosce elemento già esistente

Esempio evento ordinario con suggestion:

30 euro spesa villa nuova
→ project_state/entity_state
→ create_suggestion_state
→ suggestion create eventuale
→ Conferma evento manuale

Esempio comando puro:

crea progetto Villa Nuova
→ command_intent_state
→ container_command_intent
→ btn_command_create_project
→ insert_project
→ nessun evento salvato

Esempio elemento già presente:

crea progetto villa
→ command_intent_state
→ Elemento già presente
→ nessun bottone crea
→ nessuna duplicazione
→ nessun evento salvato

Nota:

command_intent_state può controllare l’esistenza di un project/entity,
ma questa verifica non sostituisce deduplicazione avanzata,
alias, fuzzy matching o vincoli DB.

------------------------------------------------
RELAZIONE CON UI READINESS / INPUT ANALYSIS RESULT
------------------------------------------------

Nota canonica:

La fonte completa per input_analysis_result nel contesto input è:

- 01_LOGOS_Input_System

La fonte completa per componenti, Hidden e wiring Retool è:

- 04_LOGOS_Retool_Architecture

Questo documento documenta solo il confine con il Match Engine:

- input_analysis_result può leggere project_state / entity_state
- input_analysis_result può comporre raw / selection / effective usability
- input_analysis_result non calcola matching
- input_analysis_result non modifica select_project / select_entity
- input_analysis_result non modifica button_input_confirm payload

UI Readiness / Input Analysis Result è una linea separata dal Match Engine.

Componenti:

- ui_visibility_mode
- preview_analysis_state
- input_analysis_result
- ui_visibility_state residuo tecnico deprecabile

---

ui_visibility_mode:

- distingue empty / event / command
- non legge project_state / entity_state come fonte matching
- non calcola project/entity
- non decide ambiguità
- non decide select
- non salva dati

---

ui_visibility_state:

- era aggregatore di visibilità del flow input
- dopo Visibility Migration Completion non è più letto da input_analysis_result
- non governa più gli Hidden principali migrati
- resta residuo tecnico deprecabile / rollback
- non è fonte matching
- non decide project/entity
- non salva dati

Non produce:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches
- project_id
- entity_id

Non modifica:

- project_state
- entity_state
- create_suggestion_state
- command_intent_state
- select_project
- select_entity
- button_input_confirm payload
- insert_event / update_event
- insert_project / insert_entity

Regola:

il Match Engine resta la fonte minima per project/entity matching.

preview_analysis_state:

- legge stati utili a costruire hint/status preview
- può leggere indirettamente informazioni derivate da project_state / entity_state
- non calcola matches
- non calcola singleMatch
- non seleziona project/entity
- non modifica il matching

input_analysis_result:

- legge analysis_snapshot.project/entity come risultati correlati dei matcher canonici
- legge select_project / select_entity come selection source
- calcola effective usability
- distingue event / command / edit flow
- non calcola matches
- non calcola singleMatch
- non seleziona project/entity
- non modifica il matching
- non costruisce il payload; espone association contestuale usata dal builder unico in confirm_event
- non salva dati
- governa gli Hidden principali del flow input
- espone canShowConfirm per la visibilità del bottone Conferma
- non governa Disabled come decisione funzionale finale

UI Readiness / Input Analysis Result è coordinamento visivo/compositivo,
non matching.

Visibility Migration Completion aumenta il consumo UI di input_analysis_result,
ma non cambia la responsabilità del Match Engine.

Risultato post UI Readiness:

✔ container vuoto durante digitazione risolto
✔ flow event / command più stabile
✔ suggestion container non compete più visivamente con command container
✔ Dati evento / Conferma evento più coerenti con flow event/command
✔ matching invariato

------------------------------------------------
RELAZIONE CON NORMALIZATION LAYER BASE
------------------------------------------------

Nota canonica:

La fonte completa per input flow, parser, normalization base,
duration normalization base e type classification nel contesto input è:

- 01_LOGOS_Input_System

Questo documento conserva solo il confine tra normalization e matching.

Regola:

il Match Engine non normalizza amount / unit / event_date
e non modifica ui_state.parsed.

Il Normalization Layer Base ha migliorato:

- amount
- unit
- event_date
- save flow
- insert/update
- qualità del payload DB

---

Non ha modificato:

- project matching
- entity matching
- hint matching
- auto-select
- preview detection
- priority match
- ranking

---

Effetto indiretto positivo:

poiché numeri senza unità non diventano più amount,
casi come:

villa 2 mario

mantengono meglio il valore semantico del numero nella label/preview.

Tuttavia:

- il matching resta testuale
- non usa ancora una normalizzazione unica
- non è stato rifattorizzato

------------------------------------------------
CASI NON SUPPORTATI
------------------------------------------------

- sinonimi
- errori ortografici
- abbreviazioni complesse
- fuzzy matching
- gerarchie project/entity
- relazioni entity-project
- match storico
- ranking basato su frequenza
- ranking avanzato
- disambiguazione automatica
- alias controllati
- command intent avanzato oltre create project/entity
- modifica project/entity da command
- dashboard/report intent
- Input Analysis Model completo
- decommission di ui_visibility_state
- button_input_confirm.Disabled/readiness migrato a input_analysis_result
- creazione automatica silenziosa project/entity

---

Motivo:

evitare inferenze errate
e mantenere controllo utente.

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- nessuna gerarchia entity/project
- nessun alias system
- nessun fuzzy matching
- nessun ranking avanzato
- nessuna deduplicazione entity/project
- nessuna relazione entity-project
- nessun match storico
- creazione guidata project/entity implementata solo a primo livello controllato
- command intent create project/entity implementato a primo livello controllato
- command intent avanzato non implementato
- input_analysis_result implementato come layer compositivo per Hidden principali del flow input
- Input Analysis Model completo non implementato
- ui_visibility_state ancora presente come residuo tecnico deprecabile
- ui_visibility_mode implementato solo come latch UI
- UI Readiness / Input Analysis Result non è Match Engine
- Linting / Retool Query Safety Pass completato senza modificare matching
- Full Visibility Migration degli Hidden principali completata
- button_input_confirm.Hidden migrato
- Disabled resta proprietà del pulsante con readiness, fetching e confronto dei token; guardie finali in confirm_event
- save readiness non centralizzata
- cleanup obsolete UI guards / query reduction non ancora eseguito
- nessuna creazione automatica silenziosa project/entity
- nessun audit trail dedicato per creazione project/entity
- nessuna deduplicazione strutturale avanzata per project/entity creati da command
- preview ancora layer ibrido
- hint duration/type ancora embedded nella preview
- match engine avanzato separato non implementato
- G35 / Status Semantics Alignment generale resta aperto; UX-R1 Q2 ha corretto badge e scelte richieste nel solo perimetro della conferma inline
- Missing Association Notice Cleanup generale resta distinto; UX-R1 filtra solo i suggerimenti dello stesso livello già risolto
- residui grafici/mobile polish da trattare in nodi UX dedicati o sessioni brevi

---

Risolto a primo livello:

✔ duplicazione state / select ridotta  
✔ preview detection non più fonte decisionale  
✔ hint ambiguità matching allineati a state  
✔ priority match minimo implementato  
✔ confirm guard coerente con ambiguità non risolta  
✔ create/edit flow allineati  
✔ create_suggestion_state introdotto
✔ creazione guidata project/entity implementata a primo livello controllato
✔ no-match project/entity assistito da suggestion controllata
✔ entity autofill controlled minimal implementato
✔ command intent create project/entity implementato a primo livello controllato
✔ comandi puri esclusi dal save flow evento
✔ “crea progetto villa” riconosciuto come elemento già presente
✔ project/entity da command creati solo previa conferma utente
✔ UI Readiness / Visibility Aggregator completato senza modificare matching
✔ ui_visibility_state introdotto come aggregatore visibilità separato dal Match Engine
✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto
✔ flow event / command stabilizzato a primo livello
✔ preview_analysis_state introdotto senza modificare matching
✔ input_analysis_result introdotto senza modificare matching
✔ raw / selection / effective state introdotti
✔ Controlled UI Consumption Pass completato senza regressione matching
✔ visibility preview/data/command/suggestion migrata parzialmente a input_analysis_result
✔ Visibility Migration degli Hidden principali completata
✔ container_input.Hidden migrato a input_analysis_result
✔ text_input_analysis_loading.Hidden migrato a input_analysis_result
✔ btn_cancel_edit.Hidden migrato a input_analysis_result
✔ btn_cancel_input_home.Hidden migrato a input_analysis_result
✔ button_input_confirm.Hidden migrato a input_analysis_result
✔ input_analysis_result non legge più ui_visibility_state
✔ linting Retool azzerati senza modificare matching
✔ G22 Project Create Suggestion — Match Present / User Override risolto a primo livello controllato
✔ match presente + suggestion extension gestito con warning mirato non bloccante
✔ requiresUserOverride introdotto come flag UI derivato da create_suggestion_state
✔ warning generici moreSpecificMatches rimossi dal caso G22
✔ Da verificare e Suggerimenti associazione separati semanticamente

------------------------------------------------
PROBLEMA STRUTTURALE CRITICO — STATO AGGIORNATO
------------------------------------------------

Prima dello STEP 6.4 esistevano 3 sistemi di matching indipendenti:

1. PROJECT_STATE / ENTITY_STATE

- calcolo matches
- non sempre live
- non pienamente usato da select / preview / confirm

2. SELECT MATCHING / DETERMINISTICO

- ricalcolava matching nel Default value
- poteva divergere da project_state/entity_state

3. PREVIEW DETECTION / TOKEN-BASED

- ricalcolava detection locale
- alimentava highlight e parte degli hint
- poteva divergere da select e state

---

Conseguenze precedenti:

- incoerenza risultati
- duplicazione logica
- difficoltà debugging
- hint non sempre coerenti
- rischio divergenza tra ciò che si vede e ciò che viene selezionato

---

STATO DOPO STEP 6.4:

✔ project_state / entity_state sono fonte minima matching  
✔ select_project / select_entity leggono singleMatch  
✔ preview hint legge isAmbiguous  
✔ preview highlight legge matches  
✔ confirm guard legge ambiguità non risolta  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ priority match minimo implementato  

---

STATO:

RISOLTO A PRIMO LIVELLO CONTROLLATO

---

Non ancora risolto:

- match engine avanzato separato
- fuzzy matching
- alias
- deduplicazione
- gerarchie
- relazioni entity-project
- input analysis model unico
- command intent avanzato oltre create project/entity
- filtro select su match ambigui
- deduplicazione avanzata project/entity

---

STATO DOPO PROJECT / ENTITY CREATE SUGGESTION:

✔ no-match project/entity può produrre suggestion controllata
✔ project/entity possono essere creati inline previa conferma
✔ select_project/select_entity vengono valorizzati dopo creazione controllata
✔ evento non viene salvato automaticamente dopo creazione project/entity
✔ salvataggio resta manuale
✔ project/entity mancanti non bloccano conferma
✔ project/entity ambigui bloccano conferma

STATO DOPO COMMAND INTENT — CREATE PROJECT / ENTITY:

✔ command_intent_state introdotto come helper separato
✔ comandi puri create project/entity intercettati
✔ comando generico “crea” guidato
✔ “modifica evento” gestito come guida non operativa
✔ comandi puri non salvano eventi
✔ project/entity da command richiedono conferma utente
✔ elemento già presente riconosciuto e non duplicato
✔ evento ordinario non regressivo validato
✔ edit flow non regressivo validato

Nota:

Command Intent non risolve il problema strutturale del match engine avanzato.
Aggiunge un layer separato per comandi puri.

STATO DOPO UI READINESS / VISIBILITY AGGREGATOR:

✔ ui_visibility_mode introdotto come latch UI empty / event / command
✔ ui_visibility_state introdotto come aggregatore read-only di visibilità
✔ ui_visibility_state può leggere project_state / entity_state
✔ ui_visibility_state non modifica il Match Engine
✔ project_state / entity_state restano fonte minima matching
✔ create_suggestion_state resta layer suggestion separato
✔ command_intent_state resta layer command separato
✔ select_project / select_entity restano fonti salvabili
✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto
✔ matching invariato

UI Readiness non risolve il problema strutturale del match engine avanzato.
Aggiunge un layer separato per visibilità/readiness UI.

STATO DOPO PREVIEW ANALYSIS STATE / INPUT ANALYSIS RESULT:

✔ preview_analysis_state introdotto come layer read-only preview/hint
✔ input_analysis_result introdotto come layer compositivo read-only
✔ raw / selection / effective state introdotti
✔ input_analysis_result legge project_state / entity_state ma non li sostituisce
✔ input_analysis_result legge select_project / select_entity ma non li valorizza
✔ input_analysis_result distingue raw match da effective usability
✔ in command flow project/entity raw non diventano dati evento usabili
✔ in edit flow command intent viene soppresso a livello effective
✔ Controlled UI Consumption Pass completato senza modificare il matching
✔ Match Engine invariato
✔ project_state / entity_state restano fonte minima matching

Nota:

Input Analysis Result non risolve il problema strutturale del Match Engine avanzato.
Aggiunge un layer compositivo sopra i moduli specializzati.

STATO DOPO VISIBILITY MIGRATION COMPLETION / LINTING SAFETY PASS:

✔ Hidden principali del flow input migrati a input_analysis_result
✔ button_input_confirm.Hidden migrato a canShowConfirm
✔ button_input_confirm.Disabled resta separato
✔ button_input_confirm payload invariato
✔ input_analysis_result non legge più ui_visibility_state
✔ ui_visibility_state residuo tecnico deprecabile
✔ linting Retool azzerati
✔ query legacy unused typing_state / handle_event_success eliminate
✔ Match Engine invariato
✔ project_state / entity_state invariati
✔ select_project / select_entity invariati
✔ create_suggestion_state invariato nella logica funzionale
✔ command_intent_state invariato nella logica funzionale

Nota:

Questo nodo non risolve il Match Engine avanzato.
Stabilizza solo il consumo UI/readiness intorno all’input flow.

------------------------------------------------
TARGET FUTURO — MATCH ENGINE EVOLUTION
------------------------------------------------

Lo STEP 6.4 ha completato:

MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL

Non riaprire come nodo base.

---

Evoluzioni future possibili solo come nodi dedicati:

1. ALIAS / SYNONYMS CONTROLLED MATCHING

- alias project/entity
- abbreviazioni controllate
- sinonimi validati
- nessun fuzzy aggressivo

2. DATA STRUCTURE / ENTITY HIERARCHY

- gerarchie entity/project
- parent_entity_id / parent_project_id
- relazioni entity-project
- deduplicazione

3. BUTTON CONFIRM READINESS ALIGNMENT

- button_input_confirm.Hidden già migrato
- valutare button_input_confirm.Disabled
- distinguere visibility / disabled / save readiness
- mantenere payload invariato
- non modificare project_state / entity_state
- non modificare insert_event / update_event

4. MATCH CONFIDENCE / RANKING ADVANCED

- ranking più evoluto
- confidence controllata
- audit ambiguità

Nota post G22:

Il caso match presente + suggestion extension non richiede da solo G10A.

G10A resta futuro solo per casi realmente avanzati:

- ranking globale
- fuzzy matching
- alias
- confidence score strutturale
- gerarchie
- deduplicazione
- relazioni project/entity

G22 è stato risolto con policy locale e warning mirato non bloccante.

---

Vincoli futuri:

- nessuna auto-decisione se ambiguo
- nessuna creazione automatica silenziosa
- nessun fuzzy aggressivo senza controllo
- utente sempre in controllo
- output/KPI non anticipati

5. SELECT OPTIONS FILTERING — AMBIGUITY UX

- filtrare opzioni select sui match ambigui
- migliorare risoluzione ambiguità
- non ridurre possibilità di selezione manuale libera senza nodo dedicato

6. ADVANCED COMMAND INTENT

- modifica project/entity da command
- dashboard/report intent
- eventuale routing avanzato
- nessun edit automatico senza conferma
- nessun output/KPI anticipato

7. MATCH ENGINE — MORE SPECIFIC MATCH POLICY

Fotografia del backlog pre-N21: B1 e UX hanno già implementato le alternative pertinenti nei casi descritti nella sezione MATCH CON VARIANTI E PREFISSI. Le opzioni qui elencate oltre quel perimetro restano ipotesi.

- valutare se warning “match più specifici” resta sempre non bloccante
- esempio: Mario selezionato automaticamente con warning entità più specifiche
- decidere se richiedere scelta manuale nei casi più delicati
- non modificare matching senza nodo dedicato

------------------------------------------------
EVOLUZIONE FUTURA NON ATTIVA
------------------------------------------------

- alias/sinonimi controllati
- fuzzy matching
- ranking per frequenza
- storico selezioni
- entity hierarchy
- project hierarchy
- relazioni entity-project
- deduplicazione
- command intent avanzato oltre create project/entity
- Input Analysis Model completo
- eventuale decommission di ui_visibility_state
- button_input_confirm Disabled / readiness alignment
- Ulteriori evoluzioni della policy More Specific Match oltre le alternative pertinenti documentate per N21
- creazione automatica silenziosa project/entity
- filtro select su match ambigui
- pending state avanzato per nuovi project/entity
- confidence score
- audit ambiguità

------------------------------------------------
OBIETTIVO MATCH ENGINE
------------------------------------------------

Ridurre ambiguità mantenendo controllo utente.

---

Deve:

- suggerire
- evidenziare
- bloccare ambiguità quando necessario
- mantenere coerenza tra select e preview
- ridurre falsi positivi

---

NON deve:

- automatizzare completamente
- interpretare intenzione utente in modo nascosto
- creare project/entity direttamente dal matching
- creare project/entity senza conferma utente
- forzare selezioni ambigue
- sostituire la validazione utente

---

Stato attuale:

Il primo livello controllato è stato implementato.
Il Match Engine ora riduce le divergenze tra state, select, preview e confirm.

Il successivo Project / Entity Create Suggestion First Controlled Level
ha aggiunto un layer di suggestion controllata che consuma il matching,
senza trasformare il match engine in un sistema decisionale o di scrittura DB.

Il successivo Command Intent — Create Project / Entity
ha aggiunto un layer separato per intercettare comandi puri,
senza trasformare il Match Engine in un sistema di command routing.

Il Match Engine resta dedicato a project/entity dentro eventi ordinari.

Il successivo UI Readiness / Visibility Aggregator
ha aggiunto un layer separato per coordinare la visibilità del flow input,
senza trasformare il Match Engine in un sistema di readiness UI.

Il successivo Preview Analysis State
ha aggiunto un layer separato per hint/status della Sintesi,
senza trasformare il Match Engine in un sistema preview.

Il successivo Input Analysis Result — Visibility Migration Completion
ha aumentato il consumo UI di input_analysis_result per gli Hidden principali del flow input,
senza modificare il Match Engine.

Il successivo Linting / Retool Query Safety Pass
ha azzerato i linting Retool e rimosso query legacy unused,
senza modificare il Match Engine.

Il Match Engine resta invariato.

project_state / entity_state restano la fonte minima matching.
Le Select ordinarie forniscono selezioni valide/storiche; la FK finale Q2 è risolta da confirm_event con la proiezione e le scelte inline.

Il prossimo livello non è “rifare il Match Engine”,
ma evolverlo tramite nodi dedicati.

------------------------------------------------
FOTOGRAFIA STORICA PRE-Q2 — ESITI DEI PASS PRECEDENTI

Le attestazioni seguenti appartengono ai pass nominati (G22, G33, Visibility Migration e Linting). Non rappresentano il binding Disabled, il payload o il conteggio lint correnti Q2; valgono il contratto finale iniziale e le configurazioni in Architecture. Conservare le prove storiche e i limiti ancora validi.
------------------------------------------------

✔ matching base funzionante  
✔ Match Engine Unification First Controlled Level completato  
✔ project_state / entity_state fonte minima matching  
✔ select_project / select_entity alimentati da singleMatch  
✔ auto-select limitato ai casi univoci  
✔ ambiguità bloccanti gestite tramite isAmbiguous  
✔ ambiguità risolta manualmente consente conferma  
✔ nessun match non blocca conferma  
✔ preview hint matching allineati a state  
✔ preview highlight alimentato da matches  
✔ priority match minimo implementato  
✔ match state live in create flow  
✔ match state live in edit flow  
✔ utente mantiene controllo  
✔ create_suggestion_state consuma il match state
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ creazione guidata project/entity implementata a primo livello controllato
✔ no-match project/entity può generare suggestion controllata
✔ project/entity mancanti non bloccano conferma
✔ project/entity ambigui bloccano conferma
✔ entity autofill controlled minimal implementato
✔ Command Intent — Create Project / Entity completato
✔ command_intent_state introdotto come helper separato
✔ command intent non sostituisce project_state / entity_state
✔ command intent non sostituisce create_suggestion_state
✔ comandi puri non salvano eventi
✔ project/entity da command creati solo previa conferma utente
✔ elemento già presente da command riconosciuto e non duplicato
✔ UI Readiness / Visibility Aggregator completato
✔ ui_visibility_mode introdotto come latch UI
✔ ui_visibility_state introdotto come aggregatore read-only
✔ ui_visibility_state separato dal Match Engine
✔ project_state / entity_state restano fonte minima matching
✔ matching invariato dopo UI Readiness
✔ test obbligatori 1–16 superati senza regressione matching
✔ Preview Analysis State — First Controlled Layer completato
✔ preview_analysis_state introdotto senza modificare matching
✔ Input Analysis Result / Single Interpretation Layer Base completato come diagnostico
✔ input_analysis_result introdotto senza modificare matching
✔ raw / selection / effective state introdotti
✔ Controlled UI Consumption Pass completato senza regressione matching
✔ input_analysis_result legge project_state / entity_state ma non li sostituisce
✔ input_analysis_result legge select_project / select_entity ma non li valorizza
✔ project_state / entity_state restano fonte minima matching
✔ select_project / select_entity restano fonti salvabili
✔ Visibility Migration Completion completata senza regressione matching
✔ input_analysis_result governa Hidden principali senza calcolare matching
✔ button_input_confirm.Hidden migrato senza modificare Disabled / payload
✔ ui_visibility_state residuo tecnico deprecabile
✔ linting Retool azzerati senza modificare matching
✔ G22 Project Create Suggestion — Match Present / User Override / Auto-select Confidence completato
✔ match presente + suggestion extension gestito senza bloccare Conferma
✔ warning mirato “Associazione progetto/entità da controllare” introdotto in Da verificare
✔ container Suggerimenti associazione mantenuto come area azione
✔ button_input_confirm.Disabled invariato
✔ payload e save flow invariati
✔ G10A non necessario per questo caso

---

⚠ match engine avanzato separato non implementato  
⚠ preview ancora ibrida  
⚠ hint duration/type ancora embedded nella preview  
⚠ nessuna gerarchia  
⚠ nessun alias system  
⚠ nessuna deduplicazione  
✔ creazione guidata project/entity implementata a primo livello controllato
⚠ command intent avanzato non implementato
✔ input_analysis_result implementato come layer compositivo per Hidden principali del flow input
⚠ Input Analysis Model completo non implementato
⚠ ui_visibility_state ancora presente fisicamente come residuo tecnico deprecabile
✔ Full Visibility Migration degli Hidden principali completata
✔ button_input_confirm.Hidden migrato
⚠ button_input_confirm.Disabled non migrato
⚠ save readiness non centralizzata
⚠ cleanup obsolete UI guards / query reduction non ancora eseguito
✔ linting Retool azzerati
⚠ filtro select su match ambigui non implementato
⚠ non ancora pronto per output/KPI affidabili senza ulteriori nodi data/economic/report readiness

------------------------------------------------
## Q2 — sorgenti finali di competenza

Trascrizioni integrali dai file effettivi, non candidate storiche o nuovo codice. Gli hash si riferiscono ai file sorgente UTF-8/LF nel pacchetto di review: per estrarli dal Markdown CRLF normalizzare soltanto EOL del contenitore. Non eliminare spazi iniziali/finali del codice. Provenienza dettagliata nel registro Runtime e nel manifest del lotto. Le descrizioni storiche precedenti non sostituiscono queste proprietà finali.

### q2-source-project-state-query

`project_state.template.query` — sorgente integrale. SHA-256 UTF-8/LF `02c3dca27b5c823d2da411a1f3c045ae9e8cb1b3b1b669e1139e6823bdbec446`, 6997 byte.

```js
// Q2: request-scoped adapter. Canonical body below is unchanged.
const req = typeof analysis_request === "undefined" ? null : analysis_request;
const values = req ? [
  {value:req.raw}, {value:req.raw}, {data:req.projects}, {data:req.entities},
  {data:req.project}, {data:req.entity}, {value:req.projectId}, {value:req.entityId}
] : [input_home,input_raw,projects_list,entities_list,project_state,entity_state,select_project,select_entity];
const result = ((input_home, input_raw, projects_list, entities_list, project_state, entity_state, select_project, select_entity) => {
const text = input_raw.value?.trim() || "";
const projects = projects_list.data || [];

const normalize = (str) =>
  String(str || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/\s+/g, " ")
    .trim();

const escapeRegex = (str) =>
  String(str || "").replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

const cleanText = normalize(text);

if (!cleanText || cleanText.length < 3) {
  return {
    matches: [],
    count: 0,
    hasMatch: false,
    isAmbiguous: false,
    singleMatch: null,
    moreSpecificMatches: [],
    hasMoreSpecificMatches: false,
    plausibleAlternatives: [],
    hasPlausibleAlternatives: false,
    prefixAlternatives: []
  };
}

// Token testuali a confine parola: un nome non deve coincidere con una sottostringa.
const inputWords = cleanText.match(/[a-z0-9]+/g) || [];

const hasFullNameInText = (name) => {
  const cleanName = normalize(name);
  if (!cleanName) return false;

  const parts = cleanName
    .split(" ")
    .map(p => p.trim())
    .filter(Boolean);

  if (!parts.length) return false;

  const pattern = parts.map(escapeRegex).join("\\s+");
  const regex = new RegExp(`\\b${pattern}\\b`, "i");

  return regex.test(cleanText);
};

const baseMatches = projects.filter((p) => {
  const name = normalize(p.name);
  if (!name) return false;

  const nameTokens = name.match(/[a-z0-9]+/g) || [];
  const meaningfulWords = nameTokens.filter((w) => w.length > 2 && !/^\d+$/.test(w));

  // Nome numerico: richiediamo la frase completa, non un numero ricavato
  // accidentalmente dall'importo/durata/data dell'evento.
  if (nameTokens.some((w) => /^\d+$/.test(w))) {
    if (!hasFullNameInText(p.name)) return false;

    // Se dopo il nome numerico compare subito un'unita' di misura,
    // il numero puo' appartenere al valore dell'evento: scelta manuale.
    const pattern = name.split(" ").map(escapeRegex).join("\\s+");
    const numericValueContext = new RegExp(
      `\\b${pattern}\\b\\s*(?:\\b(?:euro|eur|ora|ore|h|min|minuto|minuti)\\b|€)`, "i"
    ).test(cleanText);
    return !numericValueContext;
  }

  // Evita il match vacuo su nomi brevi (es. "A", "2").
  return hasFullNameInText(p.name) ||
    (meaningfulWords.length > 0 && meaningfulWords.every((w) => inputWords.includes(w)));
});

// Priorità ai nomi completi realmente presenti nel testo
const fullNameMatches = baseMatches.filter((p) =>
  hasFullNameInText(p.name)
);

let candidates = baseMatches;

if (fullNameMatches.length > 0) {
  candidates = fullNameMatches;
}

// Rimuove match generici coperti da match più specifici.
// Esempi:
// Casa + Casa Mare → Casa Mare
// Ristrutturazione + Ristrutturazione Bagno → Ristrutturazione Bagno
// Villa + Villa 2 → Villa 2
candidates = candidates.filter((p) => {
  const name = normalize(p.name);

  return !candidates.some((other) => {
    if (other.id === p.id) return false;

    const otherName = normalize(other.name);

    return (
      otherName.length > name.length &&
      (` ${otherName} `).includes(` ${name} `)
    );
  });
});

// Questa è la corrispondenza prima di valutare eventuali varianti
// digitate parzialmente. Le varianti plausibili richiedono scelta manuale.
const baseSingleMatch = candidates.length === 1 ? candidates[0] : null;
let moreSpecificMatches = [];

if (baseSingleMatch) {
  moreSpecificMatches = projects.filter((p) => {
    if (p.id === baseSingleMatch.id) {
      return false;
    }

    const baseName = normalize(baseSingleMatch.name);
    const otherName = normalize(p.name);

    if (!baseName || !otherName) {
      return false;
    }

    return otherName.startsWith(`${baseName} `);
  });
}

// Alternativa plausibile: il token immediatamente dopo il nome-base
// coincide con l'inizio della prima parola del suffisso di un nome esistente.
// La soglia 3 caratteri e' gia' usata dalla suggestion; numeri solo esatti.
const plausibleAlternatives = [];
if (baseSingleMatch && moreSpecificMatches.length > 0) {
  const baseName = normalize(baseSingleMatch.name);
  const parts = baseName.split(" ").filter(Boolean);
  const pattern = parts.map(escapeRegex).join("\\s+");
  const typedSuffix = cleanText.match(new RegExp(`\\b${pattern}\\b\\s+([a-z0-9]+)`, "i"))?.[1] || "";

  if (typedSuffix) {
    for (const candidate of moreSpecificMatches) {
      const suffix = normalize(candidate.name).slice(baseName.length).trim();
      const first = suffix.split(" ")[0] || "";
      const isNumber = /^\d+$/.test(typedSuffix);
      const plausible = isNumber
        ? first === typedSuffix
        : typedSuffix.length >= 3 && first.startsWith(typedSuffix);
      if (plausible) plausibleAlternatives.push(candidate);
    }
  }
}

// Non preselezionare la base se il testo suggerisce una variante diversa.
if (plausibleAlternatives.length > 0) {
  const seen = new Set(candidates.map((c) => c.id));
  for (const candidate of plausibleAlternatives) {
    if (!seen.has(candidate.id)) {
      candidates.push(candidate);
      seen.add(candidate.id);
    }
  }
}
const singleMatch = candidates.length === 1 ? candidates[0] : null;

// Prefissi di parole intere, solo a fini informativi quando B1 non ha match.
const prefixAlternatives = [];
if (candidates.length === 0) {
  const byPrefix = new Map();
  const wordsIn = (" " + inputWords.join(" ") + " ");
  for (const project of projects) {
    const words = normalize(project.name).match(/[a-z0-9]+/g) || [];
    for (let size = words.length - 1; size >= 2; size--) {
      const prefix = words.slice(0, size).join(" ");
      if (!wordsIn.includes(" " + prefix + " ")) continue;
      if (!byPrefix.has(prefix)) byPrefix.set(prefix, []);
      byPrefix.get(prefix).push(project);
      break;
    }
  }
  const seen = new Set();
  for (const group of byPrefix.values()) {
    if (group.length < 2) continue;
    for (const project of group) {
      if (seen.has(project.id)) continue;
      seen.add(project.id);
      prefixAlternatives.push(project);
    }
  }
}

return {
  matches: candidates,
  count: candidates.length,
  hasMatch: candidates.length > 0,
  isAmbiguous: candidates.length > 1,
  singleMatch: singleMatch,
  moreSpecificMatches: moreSpecificMatches,
  hasMoreSpecificMatches: moreSpecificMatches.length > 0,
  plausibleAlternatives,
  hasPlausibleAlternatives: plausibleAlternatives.length > 0,
  prefixAlternatives
};
})(...values);
return {...result, __logosRequestId:req?.id || null};
```

### q2-source-entity-state-query

`entity_state.template.query` — sorgente integrale. SHA-256 UTF-8/LF `2807fc720369ebbc38da0e39d47dbbd2201f71f726eee1d311fce0432c9a43a5`, 5845 byte.

```js
// Q2: request-scoped adapter. Canonical body below is unchanged.
const req = typeof analysis_request === "undefined" ? null : analysis_request;
const values = req ? [
  {value:req.raw}, {value:req.raw}, {data:req.projects}, {data:req.entities},
  {data:req.project}, {data:req.entity}, {value:req.projectId}, {value:req.entityId}
] : [input_home,input_raw,projects_list,entities_list,project_state,entity_state,select_project,select_entity];
const result = ((input_home, input_raw, projects_list, entities_list, project_state, entity_state, select_project, select_entity) => {
const text = input_raw.value?.trim() || "";
const entities = entities_list.data || [];

const normalize = (str) =>
  String(str || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/\s+/g, " ")
    .trim();

const escapeRegex = (str) =>
  String(str || "").replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

const cleanText = normalize(text);

if (!cleanText || cleanText.length < 3) {
  return {
    matches: [],
    count: 0,
    hasMatch: false,
    isAmbiguous: false,
    singleMatch: null,
    moreSpecificMatches: [],
    hasMoreSpecificMatches: false,
    plausibleAlternatives: [],
    hasPlausibleAlternatives: false
  };
}

const inputWords = cleanText.match(/[a-z0-9]+/g) || [];

const hasFullNameInText = (name) => {
  const cleanName = normalize(name);
  if (!cleanName) return false;

  const parts = cleanName
    .split(" ")
    .map(p => p.trim())
    .filter(Boolean);

  if (!parts.length) return false;

  const pattern = parts.map(escapeRegex).join("\\s+");
  const regex = new RegExp(`\\b${pattern}\\b`, "i");

  return regex.test(cleanText);
};

const baseMatches = entities.filter((e) => {
  const name = normalize(e.name);
  if (!name) return false;

  const nameTokens = name.match(/[a-z0-9]+/g) || [];
  const meaningfulWords = nameTokens.filter((w) => w.length > 2 && !/^\d+$/.test(w));

  // Un suffisso numerico dell'entità non può sparire dal riconoscimento.
  if (nameTokens.some((w) => /^\d+$/.test(w))) {
    if (!hasFullNameInText(e.name)) return false;

    // Se dopo il nome numerico compare subito un'unita' di misura,
    // il numero puo' appartenere al valore dell'evento: scelta manuale.
    const pattern = name.split(" ").map(escapeRegex).join("\\s+");
    const numericValueContext = new RegExp(
      `\\b${pattern}\\b\\s*(?:\\b(?:euro|eur|ora|ore|h|min|minuto|minuti)\\b|€)`, "i"
    ).test(cleanText);
    return !numericValueContext;
  }

  return hasFullNameInText(e.name) ||
    (meaningfulWords.length > 0 && meaningfulWords.every((w) => inputWords.includes(w)));
});

// Priorità ai nomi completi realmente presenti nel testo
const fullNameMatches = baseMatches.filter((e) =>
  hasFullNameInText(e.name)
);

let candidates = baseMatches;

if (fullNameMatches.length > 0) {
  candidates = fullNameMatches;
}

// Rimuove match generici coperti da match più specifici.
// Esempi:
// Marco + Marco Rossi → Marco Rossi
// Mario + Mario Rossi → Mario Rossi
// Cliente + Cliente Test → Cliente Test
candidates = candidates.filter((e) => {
  const name = normalize(e.name);

  return !candidates.some((other) => {
    if (other.id === e.id) return false;

    const otherName = normalize(other.name);

    return (
      otherName.length > name.length &&
      (` ${otherName} `).includes(` ${name} `)
    );
  });
});

// Questa è la corrispondenza prima di valutare eventuali varianti
// digitate parzialmente. Le varianti plausibili richiedono scelta manuale.
const baseSingleMatch = candidates.length === 1 ? candidates[0] : null;
let moreSpecificMatches = [];

if (baseSingleMatch) {
  moreSpecificMatches = entities.filter((e) => {
    if (e.id === baseSingleMatch.id) {
      return false;
    }

    const baseName = normalize(baseSingleMatch.name);
    const otherName = normalize(e.name);

    if (!baseName || !otherName) {
      return false;
    }

    return otherName.startsWith(`${baseName} `);
  });
}

// Alternativa plausibile: il token immediatamente dopo il nome-base
// coincide con l'inizio della prima parola del suffisso di un nome esistente.
// La soglia 3 caratteri e' gia' usata dalla suggestion; numeri solo esatti.
const plausibleAlternatives = [];
if (baseSingleMatch && moreSpecificMatches.length > 0) {
  const baseName = normalize(baseSingleMatch.name);
  const parts = baseName.split(" ").filter(Boolean);
  const pattern = parts.map(escapeRegex).join("\\s+");
  const typedSuffix = cleanText.match(new RegExp(`\\b${pattern}\\b\\s+([a-z0-9]+)`, "i"))?.[1] || "";

  if (typedSuffix) {
    for (const candidate of moreSpecificMatches) {
      const suffix = normalize(candidate.name).slice(baseName.length).trim();
      const first = suffix.split(" ")[0] || "";
      const isNumber = /^\d+$/.test(typedSuffix);
      const plausible = isNumber
        ? first === typedSuffix
        : typedSuffix.length >= 3 && first.startsWith(typedSuffix);
      if (plausible) plausibleAlternatives.push(candidate);
    }
  }
}

// Non preselezionare la base se il testo suggerisce una variante diversa.
if (plausibleAlternatives.length > 0) {
  const seen = new Set(candidates.map((c) => c.id));
  for (const candidate of plausibleAlternatives) {
    if (!seen.has(candidate.id)) {
      candidates.push(candidate);
      seen.add(candidate.id);
    }
  }
}
const singleMatch = candidates.length === 1 ? candidates[0] : null;

return {
  matches: candidates,
  count: candidates.length,
  hasMatch: candidates.length > 0,
  isAmbiguous: candidates.length > 1,
  singleMatch: singleMatch,
  moreSpecificMatches: moreSpecificMatches,
  hasMoreSpecificMatches: moreSpecificMatches.length > 0,
  plausibleAlternatives,
  hasPlausibleAlternatives: plausibleAlternatives.length > 0
};
})(...values);
return {...result, __logosRequestId:req?.id || null};
```

CHANGELOG
------------------------------------------------

v01 — 2026-04-01  
- definizione base matching

v02 — 2026-04-03  
- retrofit entity matching  
- introduzione token significativi  
- eliminazione partial match aggressivo  
- riduzione falsi positivi  
- allineamento con runtime reale

v03 — 2026-04-23  
- identificazione sistemi di matching multipli  
- documentazione incoerenza strutturale  
- introduzione problema unificazione matching  
- allineamento con stato reale sistema

v04 — 2026-04-30  
- chiarito che Normalization Layer Base non ha modificato il matching  
- aggiornato rapporto tra matching e ui_state.parsed  
- esplicitato che amount/unit normalization è separata dal match engine  
- confermato problema strutturale dei tre sistemi di matching paralleli  
- definito Match Engine Unification come nodo futuro dedicato  
- confermato che priority match resta non implementato
v05 — 2026-05-02  
- completamento MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL  
- project_state aggiornato come fonte minima matching project  
- entity_state aggiornato come fonte minima matching entity  
- aggiunti output matches / count / hasMatch / isAmbiguous / singleMatch / moreSpecificMatches / hasMoreSpecificMatches  
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
- mario → Mario + hint entità più specifiche  
- villa → Villa + hint progetti più specifici  
- bug €500 nella label preview risolto  
- linting project_state/entity_state ripuliti  
- linting residui edit_mode/editing_event mantenuti come nodo futuro  
- nessuna modifica DB  
- nessuna modifica parser  
- nessuna modifica type classification  
- nessuna modifica duration normalization  
- nessun output/KPI anticipato

v06 — 2026-05-07
- aggiornamento post PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
- documentato rapporto tra project_state/entity_state e create_suggestion_state
- chiarito che create_suggestion_state consuma il matching ma non lo sostituisce
- chiarito che matching ≠ creazione
- chiarito che suggestion ≠ decisione
- chiarito che suggestion ≠ salvataggio evento
- documentata creazione project/entity solo previa conferma utente
- documentata regola select_project/select_entity come decisione utente finale
- documentato no-match project/entity come non bloccante
- documentato blocco solo su ambiguità attiva non risolta
- documentata relatione tra hint informativi e suggestion create
- documentata Project Create Suggestion su estensioni controllate
- documentata Entity Create Suggestion
- documentato entity autofill controlled minimal
- documentato che entity autofill non è matching entity
- aggiornati casi non supportati rimuovendo create suggestion base
- aggiunti command intent e select filtering come evoluzioni future
- confermato DB schema invariato
- confermato parser invariato
- confermato type classification invariata
- confermato duration normalization invariata
- nessun output/KPI anticipato

v07 — 2026-05-13

- aggiornamento post COMMAND INTENT — CREATE PROJECT / ENTITY
- documentato command_intent_state come helper separato dal Match Engine
- chiarito che command_intent_state non sostituisce project_state / entity_state
- chiarito che command_intent_state non sostituisce create_suggestion_state
- chiarito che matching ≠ command intent
- chiarito che suggestion ≠ command intent
- chiarito che command intent ≠ salvataggio evento
- documentato comando generico “crea”
- documentato create project incompleto
- documentato create project completo
- documentato create entity incompleto
- documentato create entity completo
- documentata guida non operativa “modifica evento”
- documentato elemento già presente da command
- documentato “crea progetto villa” come no-duplicate guard
- documentato che comandi puri non salvano eventi
- documentato che project/entity da command richiedono conferma utente
- documentato riuso insert_project / insert_entity da command
- documentato che command intent non modifica project_state/entity_state
- documentato che command intent non modifica create_suggestion_state
- documentato evento ordinario non regressivo dopo Command Intent
- documentato edit flow non regressivo dopo Command Intent
- aggiornati casi non supportati
- aggiornati limiti attuali
- aggiornato Target Futuro sostituendo Command Intent base con Input Analysis Model / Single Interpretation Layer
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato

v08 — 2026-05-18

- micro-allineamento post UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
- integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- documentato rapporto tra Match Engine e UI Readiness / Visibility Aggregator
- documentato ui_visibility_mode come latch UI separato dal Match Engine
- documentato ui_visibility_state come aggregatore read-only di visibilità separato dal Match Engine
- chiarito che ui_visibility_state può leggere project_state / entity_state solo per visibilità/hint
- chiarito che ui_visibility_state non calcola matches / count / singleMatch / isAmbiguous
- chiarito che ui_visibility_state non sostituisce project_state / entity_state
- chiarito che ui_visibility_state non modifica create_suggestion_state
- chiarito che ui_visibility_state non modifica command_intent_state
- chiarito che ui_visibility_state non modifica select_project / select_entity
- chiarito che ui_visibility_state non modifica confirm guard funzionale
- chiarito che ui_visibility_state non modifica payload o DB
- aggiornata pipeline runtime con ui_visibility_mode e ui_visibility_state
- documentato che container_association_suggestions è governato da ui_visibility_state.showAssociationSuggestions
- documentato che preview / Dati evento / Conferma evento sono governati da ui_visibility_state
- confermato Match Engine invariato
- confermato DB invariato
- confermato parser invariato
- confermato create_suggestion_state invariato
- confermato command_intent_state invariato
- confermati test 1–16 post UI Readiness senza regressione matching
- Input Analysis Model completo non implementato
- Event Interpretation Engine non implementato

v09 — 2026-05-20

- aggiornamento post PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
- documentato preview_analysis_state come layer read-only preview/hint
- chiarito che preview_analysis_state può leggere stati derivati dal matching ma non calcola matching
- chiarito che preview_analysis_state non modifica project_state / entity_state
- chiarito che preview_analysis_state non seleziona project/entity

- aggiornamento post INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
- documentato input_analysis_result come layer compositivo read-only
- documentata distinzione raw / selection / effective
- chiarito che input_analysis_result legge project_state / entity_state ma non li sostituisce
- chiarito che input_analysis_result legge select_project / select_entity ma non li valorizza
- chiarito che input_analysis_result non calcola matches, count, singleMatch o ambiguità
- chiarito che input_analysis_result non è Match Engine

- aggiornamento post INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS
- documentato che input_analysis_result è fonte UI controllata parziale
- documentato che input_analysis_result governa visibility/readiness senza modificare matching
- documentato che in command flow i raw match project/entity possono esistere ma non sono usabili come dati evento
- documentato che in edit flow il command intent viene soppresso a livello effective
- documentato che container_association_suggestions.Hidden ora legge input_analysis_result.readiness.canShowAssociationSuggestions
- documentata distinzione missing association notice ≠ suggestion operativa
- documentato che create_suggestion_state resta fonte del contenuto operativo dei suggerimenti
- documentato che in quella fase ui_visibility_state restava ancora operativo; stato successivamente superato da Visibility Migration Completion, che lo ha riclassificato come residuo tecnico deprecabile / rollback
- documentato che button_input_confirm non è ancora migrato
- confermato Match Engine invariato
- confermato project_state / entity_state invariati
- confermato select_project / select_entity invariati
- confermato create_suggestion_state invariato
- confermato command_intent_state invariato
- confermato button_input_confirm payload invariato
- confermato DB invariato
- confermato parser invariato
- documentato aumento linting Retool a 19 come debito tecnico generale

v10 — 2026-05-23

- aggiornamento post INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
- confermato Match Engine invariato
- confermato project_state / entity_state invariati
- confermato select_project / select_entity invariati
- confermato create_suggestion_state invariato nella logica funzionale
- confermato command_intent_state invariato nella logica funzionale
- documentato input_analysis_result come fonte UI controllata per Hidden principali del flow input senza diventare Match Engine
- documentata migrazione container_input.Hidden a input_analysis_result
- documentata migrazione text_input_analysis_loading.Hidden a input_analysis_result
- documentata migrazione btn_cancel_edit.Hidden a input_analysis_result
- documentata migrazione btn_cancel_input_home.Hidden a input_analysis_result
- documentata migrazione button_input_confirm.Hidden a input_analysis_result.readiness.canShowConfirm
- documentato canShowConfirm come visibility-only
- documentato button_input_confirm.Disabled come guard funzionale separata
- documentato button_input_confirm payload invariato
- documentata rimozione dipendenza input_analysis_result → ui_visibility_state
- documentato ui_visibility_state come residuo tecnico deprecabile
- documentato che ui_visibility_state non è fonte matching
- aggiornata pipeline match post Visibility Migration Completion
- aggiornata relazione con UI Readiness / Input Analysis Result
- aggiornata relazione con preview
- aggiornata relazione con create_suggestion_state
- documentata policy match più specifici come invariata e non bloccante
- aggiunto nodo futuro MATCH ENGINE — MORE SPECIFIC MATCH POLICY
- aggiornati limiti attuali
- aggiornato target futuro Match Engine Evolution
- aggiornato stato attuale

- aggiornamento post LINTING / RETOOL QUERY SAFETY PASS
- documentato linting Retool azzerato
- documentato che i fix linting non hanno modificato matching
- documentata eliminazione typing_state senza impatto matching
- documentata eliminazione handle_event_success senza impatto matching
- confermato DB invariato
- confermato parser invariato
- confermato save flow invariato
- confermato payload invariato

v11 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicato Pacchetto C — Documenti tecnici canonici su 02_LOGOS_Match_Engine
- documento aggiornato da v10 a v11
- confermato 02_LOGOS_Match_Engine come fonte canonica per project_state, entity_state, matches, count, isAmbiguous, singleMatch, moreSpecificMatches, auto-select, ambiguità, confirm guard matching e policy match più specifici
- aggiunta sezione RESPONSABILITÀ CANONICA DEL DOCUMENTO
- chiarito che State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo del Match Engine
- chiarito che il dettaglio completo resta in questo documento e nei documenti canonici collegati
- aggiunti richiami canonici a:
  - 01_LOGOS_Input_System per input flow, parser, normalization, Command Intent nel contesto input, create_suggestion_state e input_analysis_result
  - 03_LOGOS_Event_Lifecycle per lifecycle evento
  - 04_LOGOS_Retool_Architecture per componenti/query/Hidden/select/wiring Retool
  - 05_LOGOS_Database_Schema per schema DB
  - 06_LOGOS_View_Preview_System per Sintesi, preview, hint, warning, highlight e label visuali
  - LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
  - LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase as-is
- corretto residuo storico nel changelog v09 su ui_visibility_state operativo/non deprecato
- aggiunte note canoniche nelle sezioni:
  - RELAZIONE CON NORMALIZATION LAYER BASE
  - RELAZIONE CON PREVIEW
  - RELAZIONE CON UI READINESS / INPUT ANALYSIS RESULT
- nessuna riduzione aggressiva applicata
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica payload

v12 — 2026-06-04

- aggiornamento post PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE / AUTO-SELECT CONFIDENCE
- G22 completato come micro-policy locale
- documentata distinzione tra match sicuro, match generico, match presente + suggestion extension e ambiguità reale
- introdotto requiresUserOverride come flag UI derivato da create_suggestion_state
- chiarito che requiresUserOverride non modifica project_state / entity_state
- chiarito che requiresUserOverride non modifica select_project / select_entity
- chiarito che requiresUserOverride non modifica button_input_confirm.Disabled
- chiarito che requiresUserOverride non modifica payload o save flow
- documentato comportamento project:
  - input 20 euro villa sierri
  - select_project = Villa
  - candidateName = Villa Sierri
  - warning Da verificare: Associazione progetto da controllare
  - suggestion: Possibile nuovo progetto Villa Sierri
- documentato comportamento entity:
  - input 20 euro mario giordano
  - select_entity = Mario
  - candidateName = Mario Giordano
  - warning Da verificare: Associazione entità da controllare
  - suggestion: Possibile nuova entità Mario Giordano
- chiarito che moreSpecificMatches resta segnale interno/informativo ma non genera warning generico nel caso G22
- confermata separazione semantica:
  - Da verificare = rischio decisionale
  - Suggerimenti associazione = azione disponibile
- confermato che la suggestion ignorata non blocca il salvataggio
- confermato che Conferma resta attiva
- confermato che G22 non richiede G10A Match Engine Evolution Advanced
- confermato DB invariato
- confermato Supabase invariato
- confermato parser invariato
- confermato save flow invariato
- confermato payload invariato

v13 — 2026-11-15 — N21, candidato PREPARE documentale. Contratto e prove nel raccordo N21 in apertura. Copia, verifica documentale assistita e pubblicazione Git pendenti.

v14 — 2026-11-16 — N21/DOC PREPARE R03: integrate regole B1 e varianti UX nelle sezioni di matching e suggestion.

v15 — 2026-11-20 — Q2/STEP 4 PREPARE documentale finale: contratti correnti inline, sorgenti/configurazioni di competenza e rinvii riconciliati; storia preservata. Nessuna propria copia/Apply o pubblicazione attestata.