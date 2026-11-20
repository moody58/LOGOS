# 01_LOGOS_Input_System_v25
Versione: v25

DATA: 2026-11-20

Rettifica editoriale STEP 4 del 20 novembre 2026, PREPARE della medesima versione non pubblicata: aggiornati i soli raccordi Q2 e i confini degli snapshot storici. Nessuna modifica applicativa, copia o pubblicazione attestata.

## Contratto finale Q2 — analisi correlata

`input_home` è il testo UX; `input_raw` è l’adapter tecnico. La validità funzionale richiede testi esattamente concordi, revisione/epoch, ID richiesta, contesto view/edit/evento originale e cataloghi coerenti. `trigger_parse_debounced` congela questi ingressi, invoca parser, Project, Entity e Command Intent canonici con `analysis_request`, verifica ogni `__logosRequestId`, poi calcola la suggestion con i risultati della stessa esecuzione. Pubblica un solo bundle completo `ui_state.analysis` e il compatibile `ui_state.parsed`. Il vecchio Success publisher di `parse_input_controlled` è assente (`events=[]`).

`analysis_snapshot` rifiuta bundle scaduti; Tipo, default Select, preview, IAR e conferma consumano il medesimo snapshot. `ui_state.parsed` resta una proiezione compatibile, non la prova autonoma di freschezza. Il debounce 350 ms e il throttle nativo non sono barriere; `__logos_visibility_run_id` non attesta completamento. Le risposte fuori ordine o fallite non devono autorizzare nuove associazioni; il coordinatore ricontrolla anche gli identificatori correnti prima della persistenza.

Ingresso edit: usare i risultati specifici di `editing_event.trigger()`/`edit_mode.trigger()` e il contesto atteso `analysis_expected_context`; i mailbox window vengono consumati dai due helper e non sono un secondo stato autorevole. Il recovery EV01 ha corretto il confronto con mailbox già cancellati, senza modificare parser/matcher o salvare EV01. Input/cancel/navigazioni incrementano epoch prima degli await; owned input write protegge le scritture programmate; timer e continuazioni restano subordinati al proprietario. Codice finale degli eventi in [Architecture](04_LOGOS_Retool_Architecture.md#q2--configurazioni-native-finali).

IAR resta composizione unidirezionale: `association` contiene selectedId/candidateId/requiresDecision, `associationContext` e `choiceValues` legano le opzioni a richiesta/revisione/contesto/UUID/scelta. IAR non legge le Select inline, non persiste e non duplica matching. [Lifecycle](03_LOGOS_Event_Lifecycle.md#contratto-finale-q2--conferma-unica) governa il payload finale; [Preview](06_LOGOS_View_Preview_System.md#contratto-finale-q2--sintesi-e-decisioni) la rappresentazione.

**Provenienza e limiti:** comportamento VERIFICATO LIVE nei checkpoint Q2 del 18–20 novembre 2026; in questo STEP 4 soltanto DOCUMENTATO e riconciliato sui file, senza nuovi accessi Retool/Supabase. UAT Safari UX-R1 4/4 PASS dichiarati dall’utente. Inventario 171→162 riconciliato da prove native; nessun export completo post-Delete. L08: Click «Vai agli eventi» non verificato LIVE, né PASS né FAIL. Draft non pubblicata, manutenzione ancora attiva. Il presente contenuto è PREPARE documentale per review: non attesta propria copia, verifica locale o pubblicazione Git.

## Base N21 — matching e suggerimenti in input evento (15 novembre 2026)

I repertori `projects_list` e `entities_list` rimangono completi. L'input legacy `input_raw.change` resta fuori dal delta. Il [Match Engine](02_LOGOS_Match_Engine.md) definisce B1 e l'uscita informativa Project `prefixAlternatives`. Quando questa contiene alternative, `create_suggestion_state` sopprime il suggerimento Project prematuro e la scheda Sintesi presenta le varianti. Le estensioni ordinarie e il controllo omonimie sul repertorio completo mantengono il percorso B1.

Le Select usano UUID, con soli ACTIVE associabili ordinariamente e FK storiche invariate conservate in edit. Il flusso canonico N18 `create_anagrafica`, il Command Intent e la scelta UUID restano distinti. Vedere [Retool Architecture](04_LOGOS_Retool_Architecture.md) per wiring e [View Preview System](06_LOGOS_View_Preview_System.md) per gli avvisi.

## Contratto N18 — creazione da input inline e Command Intent

L'implementazione Retool Classic N18, collaudata il **6 novembre 2026**, unifica le quattro conferme Crea già presenti nell'input evento e nel Command Intent attraverso **`page1.create_anagrafica`**. Due percorsi inline (Project/Entity) e due Command Intent (Project/Entity) richiedono sempre **Nome** e **Tipologia**; i quattro Select di Tipologia sono distinti ma la procedura applicativa è una. `insert_project` e `insert_entity` rimangono gli unici due endpoint fisici di creazione, con `status: "ACTIVE"` esplicito.

Lato input, `create_suggestion_state` continua a proporre l'azione senza creare record; il pulsante Crea richiama la procedura condivisa che valida la scelta, verifica omonimie su snapshot completo, controlla la rappresentazione dell'unica riga restituita e ricarica l'elenco. **Project inline:** refresh della lista, `project_state.trigger()` e **poi** `select_project.setValue(nuovo UUID)` (ordine verificato in T1B), quindi aggiornamento dei suggerimenti. **Entity inline:** selezione della nuova Entity verificata in T2; l’handler non rilancia entity_state. Nei due inline, dopo una creazione verificata, chiusura del form, dismissal, reset Nome/Tipologia e ricalcolo suggerimenti avvengono anche con refresh fallito; soltanto la nuova selezione dipende dal refresh. Il toast è success con refresh ok, warning «elenco da ricaricare» altrimenti. **Command Intent:** Nome risolto con priorità candidateName, guard canExecute, quattro Tipologie e Select decisionali azzerati dopo successo; feedback `project_created`/`entity_created` applicato allo state prima della visualizzazione, micro-tick 0 e ritorno Home a 1800 ms. Anche con refresh fallito il cleanup/routing rimane e cambia feedback_summary.text. Le sequenze complete e i codici di esito sono nella madre Retool Architecture.

**Associazione vs evento:** la creazione aggiorna la disponibilità/selezione del Project/Entity ma **non conferma né salva l'evento**. Nelle cinque INSERT N18 verificate con SELECT indipendenti, `public.events` è rimasta a **268 → 268**. Comandi strutturali puri non diventano eventi. Resta possibile salvare l'evento solo con successiva conferma esplicita dell'utente nel normale flusso, soggetta alle guardie già documentate. L'app è ancora Draft; nessun Publish. I dettagli di query, componenti, cataloghi e preflight appartengono alle madri `04_LOGOS_Retool_Architecture.md` e `LOGOS_RETOOL_RUNTIME_REAL.md`.

**Confini della fotografia N18–N20:** T2 toast e T3 feedback transitori restano limiti delle prove N18. L'avviso «Villa selezionato» osservato dopo T1B è il caso storico R1, poi risolto nel perimetro N19 e consolidato su main a `e8bfd8f06a0072681bf29f7ce9c68f649b33fe16`. R2 resta la copia Chrome locale Dirty di `projects_list`. La creazione N18 usa ACTIVE esplicito; N20 ha esteso esclusivamente gli Editor in Anagrafiche per scelta volontaria dello Stato, senza modificare input, Crea o salvataggio eventi. Filtri INACTIVE/NULL, policy completa di matching e associazione UX-06 restano separati. Controlli omonimie senza garanzia atomica. Il linting 11 è la fotografia N18.

**Fonte:** checkpoint N18 Apply statico, Apply/collaudo T1–T4, T1B e linting 5–6 novembre 2026; provenienze N16/A4 e N17 separate. Nella revisione DOC-01 del 9 novembre sono stati riletti in sola lettura gli otto handler e create_anagrafica nella Draft salvata. Nessun nuovo collaudo, Run/Test/Save/Publish o lettura Supabase.

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
- normalizzazione base dei dati parsati
- duration normalization base
- type classification base
- allineamento preview ai dati parsati
- allineamento insert/update
- salvataggio type in events.type
- Match Engine Unification First Controlled Level
- allineamento matching project/entity
- gestione ambiguità project/entity
- allineamento create/edit flow con project_state/entity_state
- UX / Cleanup Micro-Batch Post Match Engine
- annulla modifica evento
- no-op edit guard
- Linting / State Helper Cleanup
- edit_mode / editing_event senza additionalScope { value }
- reset helper edit flow tramite window.__logos_edit_mode_value / window.__logos_editing_event_value
- Project / Entity Create Suggestion First Controlled Level
- gestione suggestion project/entity da input libero
- creazione inline controllata project/entity
- create_suggestion_state
- insert_project / insert_entity
- entity autofill controlled minimal
- separazione tra input evento e Command Intent base implementato; intent avanzati futuri
- UX Mobile Coherence Pass
- Home mobile rifinita
- Dati evento compatti con label inline
- Feedback mobile stabilizzato
- feedback_summary come riepilogo UI temporaneo
- routing post-save contestuale
- insert → feedback → Home
- update → feedback → Lista eventi
- no-op edit → Lista eventi senza feedback
- cancel create/input → Home
- cancel edit → Lista eventi
- Navigation dock Home / Eventi / Dashboard
- Dashboard predisposta ma disabilitata
- font-size 16px input/select come baseline mobile Safari
- Command Intent — Create Project / Entity
- distinzione tra input evento e comando strutturale puro
- command_intent_state
- container_command_intent
- creazione project/entity da command solo previa conferma utente
- esclusione dei comandi puri dal salvataggio evento
- guida non operativa per “modifica evento”
- feedback project_created / entity_created
- feedback_mode come indicatore UI temporaneo
- UI Readiness / Visibility Aggregator — First Controlled Level
- ui_visibility_mode come latch UI empty / event / command
- ui_visibility_state come aggregatore read-only di visibilità input flow
- centralizzazione Hidden principali del flow input
- Preview Analysis State — First Controlled Layer
- preview_analysis_state come Transformer read-only per hint/status della Sintesi
- Input Analysis Result / Single Interpretation Layer Base — Read-only Diagnostic
- input_analysis_result come layer compositivo raw / selection / effective
- Input Analysis Result — Controlled UI Consumption Pass
- prima migrazione controllata degli Hidden principali da ui_visibility_state a input_analysis_result
- Input Analysis Result — Visibility Migration Completion
- migrazione completata degli Hidden principali del flow input a input_analysis_result
- container_input.Hidden migrato a input_analysis_result
- text_input_analysis_loading.Hidden migrato a input_analysis_result
- btn_cancel_edit / btn_cancel_input_home Hidden migrati a input_analysis_result
- button_input_confirm.Hidden migrato a input_analysis_result.readiness.canShowConfirm
- canShowConfirm distinto da canConfirm
- button_input_confirm.Disabled preservato come guard funzionale separata e allineato localmente a isAmbiguous
- button_input_confirm payload invariato
- input_analysis_result non legge più ui_visibility_state
- ui_visibility_state residuo tecnico deprecabile, non cancellato
- ui_visibility_mode confermato come latch leggero empty / event / command
- routing principale app confermato su ui_state.view
- Linting / Retool Query Safety Pass
- linting Retool azzerati (risultato storico pre-N18; finale N18: 11 residui qualificati)
- typing_state eliminato come query legacy unused
- handle_event_success eliminato come query legacy unused
- container_input stabilizzato progressivamente e poi migrato a input_analysis_result per gli Hidden principali del flow input
- container vuoto durante digitazione risolto
- bottom bar flash risolto
- text_input_analysis_loading
- text_edit_mode_notice
- edit mode prevalente su Command Intent
- feedback project/entity timing alignment
- residui UI Readiness documentati
- Button Confirm Readiness Alignment
- button_input_confirm.Disabled aggiornato senza modificare parser, input_analysis_result, payload o save flow
- distinzione confermata tra canShowConfirm, canConfirm e Disabled
- Project Create Suggestion — Match Present / User Override / Auto-select Confidence
- gestione G22 di match presente + suggestion extension
- requiresUserOverride in create_suggestion_state
- warning mirato in preview_analysis_state per associazione project/entity da controllare
- separazione semantica tra Da verificare e Suggerimenti associazione
- conferma che G22 non modifica parser, matching primario, select, Disabled, payload, save flow o DB
- Input Context Consistency — Edit / Suggestion / Command Boundary
- gestione alias generici modifica / correggi / cambia come guida non operativa
- blocco locale dei command riconosciuti durante edit mode prima di update_event
- protezione da insert_event/update_event impropri causati da input command-like
- conferma che input_analysis_result resta rollbackato alla base stabile
- conferma che button_input_confirm.Disabled resta invariato
- conferma che payload / insert_event / update_event restano invariati

------------------------------------------------
RESPONSABILITÀ CANONICA DEL DOCUMENTO
------------------------------------------------

Questo documento è fonte canonica per:

- input flow LOGOS
- input_home / input_raw
- trigger_parse_debounced
- parse_input_controlled
- ui_state.parsed nel contesto input
- normalization base
- duration normalization base
- type classification base nel contesto input
- Command Intent nel contesto input
- Project / Entity Create Suggestion nel contesto input
- input_analysis_result nel contesto input
- relazione tra input_analysis_result, ui_visibility_mode e ui_visibility_state
- relazione tra input flow e button_input_confirm
- relazione tra canShowConfirm, canConfirm e button_input_confirm.Disabled
- fonti controllate usate dal payload evento
- create_suggestion_state.requiresUserOverride nel contesto input
- relazione tra create_suggestion_state e preview_analysis_state per G22
- comportamento input flow in caso di match presente + suggestion extension
- comportamento degli alias generici modifica / correggi / cambia nel contesto input
- relazione tra Command Intent e edit mode nel contesto input
- guard locale in button_input_confirm contro command freschi durante edit mode
- text_edit_mode_notice contestuale quando viene rilevato un command in edit mode

Questo documento NON è fonte canonica completa per:

- matching project/entity avanzato
- wiring completo dei componenti Retool
- preview/Sintesi/hint/warning completi
- lifecycle evento completo
- schema DB completo
- runtime Retool as-is completo
- runtime Supabase as-is completo

Fonti canoniche collegate:

- 02_LOGOS_Match_Engine per project_state / entity_state / singleMatch / isAmbiguous / moreSpecificMatches / confirm guard matching.
- 03_LOGOS_Event_Lifecycle per lifecycle evento, NEW / WRITTEN / ERROR, edit, no-op, cancel e processing.
- 04_LOGOS_Retool_Architecture per componenti, query, Hidden e wiring Retool.
- 05_LOGOS_Database_Schema per schema DB, tabelle, campi e vincoli.
- 06_LOGOS_View_Preview_System per Sintesi, preview, hint, warning, label visuali e micro-copy.
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is.
- LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase, persistenza e protezioni DB documentate.

Nota post Pacchetto B:

State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo dell’input system.
Il dettaglio completo resta qui e nei documenti canonici collegati.

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

---

6. FONTI CONTROLLATE PER IL SALVATAGGIO

I dati del payload sono costruiti soltanto da confirm_event:

- amount / unit / event_date → snapshot.parsed catturato e validato;
- type → select1.value; raw_input → input_raw.value, coerenti con snapshot/contesto;
- project_id / entity_id → finalAssociationId sulla proiezione IAR e sulle scelte contestuali.

Le Select ordinarie usano i singleMatch di analysis_snapshot: nuove preselezioni soltanto ACTIVE, oppure FK storiche in edit. IAR risolve association.selectedId e l’eventuale candidato canonico unico INACTIVE senza selezione valida prevalente. Il coordinatore usa finalAssociationId: selectedId se non serve decisione; candidateId con Collega; null con Non collegare. Le due decisioni sono indipendenti. NULL non abilita nuove eccezioni, le FK storiche restano preservate. Non esiste ricerca manuale INACTIVE aggiuntiva.

Il pulsante delega soltanto confirm_event(begin); né il Click né il coordinatore ricalcolano parser o matching.

---

7. MATCHING NON DECISIONALE

Il match engine suggerisce e segnala.

Non crea project/entity.
Non forza selezioni ambigue.
Non sostituisce la scelta utente.

Regole:

- match unico ACTIVE → default della Select ordinaria, salvo contesto storico/manuale;
- candidato unico INACTIVE senza selezione valida prevalente → decisione inline esplicita;
- ambiguità non risolta → blocco; assenza di match o suggestion ignorata non rende obbligatoria un’associazione;
- la risoluzione dell’ambiguità è necessaria ma non sufficiente: restano tutte le guardie canoniche e le decisioni richieste.

Disabled corrente UX-R1: `{{ !input_analysis_result.value?.readiness?.canConfirm || confirm_event.isFetching || ["project", "entity"].some(layer => { const entry = input_analysis_result.value?.association?.[layer]; const value = layer === "project" ? select_inline_inactive_project.value : select_inline_inactive_entity.value; return entry?.requiresDecision && ![entry.choiceValues?.link, entry.choiceValues?.skip].some(token => typeof token === "string" && token.length > 0 && token === value); }) }}`
Il risultato G33 rimosse il fallback grezzo matches.length; non descrive da solo la disponibilità finale Q2.

---

8. SUGGESTION ≠ SALVATAGGIO

Le suggestion project/entity aiutano l’utente a completare il dato,
ma non salvano automaticamente eventi.

La catena corretta è:

input libero
→ match state
→ create_suggestion_state
→ suggestion visibile
→ conferma utente con Nome e Tipologia validi
→ page1.create_anagrafica (preflight e verifica)
→ insert_project / insert_entity (riuso, `ACTIVE` esplicito)
→ select_project / select_entity valorizzata dopo refresh coerente
→ eventuale Conferma evento manuale

Regole:

- nessuna creazione project/entity automatica silenziosa
- nessun evento salvato automaticamente dopo creazione project/entity
- suggestion ignorata non blocca il salvataggio
- project/entity mancanti non bloccano il salvataggio
- project/entity ambigui bloccano il salvataggio finché non risolti manualmente

Nota post G22 — Match Present / User Override:

Una suggestion può esistere anche quando project_state / entity_state hanno già prodotto un singleMatch.

Esempio:

20 euro villa sierri
→ project_state.singleMatch = Villa
→ create_suggestion_state.candidateName = Villa Sierri
→ create_suggestion_state.requiresUserOverride = true

Questo non è no-match.
Questo non è ambiguità reale.
Questo non blocca Conferma.

Regole:

- la select resta valorizzata sul singleMatch esistente
- Conferma evento resta attiva
- la suggestion non salva automaticamente
- l’utente può creare il nuovo project/entity oppure confermare quello selezionato
- il rischio decisionale viene mostrato in Da verificare
- l’azione disponibile viene mostrata in Suggerimenti associazione

Separazione semantica:

Da verificare:
segnala il controllo decisionale.

Suggerimenti associazione:
propone l’azione di creazione.

Non duplicare nella suggestion container la stessa informazione già mostrata in Da verificare.

---

9. INPUT EVENTO ≠ COMMAND INTENT

Frasi come:

- crea
- crea progetto Aspri
- aggiungi progetto Villa Nuova
- inserisci progetto Villa Nuova
- crea entità Patrizio
- aggiungi entità Referente Kappa
- modifica evento
- modifica
- correggi
- cambia

sono ora gestite a primo livello controllato dal Command Intent quando riconosciute come comandi o guide non operative.

Il runtime distingue:

- input evento ordinario
- comando strutturale puro
- guida non operativa

Regole:

- un comando puro NON deve essere salvato come evento
- un comando puro NON deve mostrare Sintesi evento / Dati evento
- project/entity da command vengono creati solo previa conferma utente
- command_intent_state non salva dati
- command_intent_state non modifica DB
- command_intent_state non modifica parser
- command_intent_state non modifica matching
- command_intent_state non sostituisce create_suggestion_state
- insert_project / insert_entity restano le due query POST operative, richiamate da `page1.create_anagrafica` in N18
- `select_project.value` e `select_entity.value` rimangono le fonti finali salvabili per l’evento; i match state non le sostituiscono
- nei soli percorsi di creazione inline N18 la nuova assegnazione automatica dell’UUID è condizionata al refresh coerente; nessun auto-save evento
- “modifica evento” non apre un edit flow parallelo
- “modifica evento” guida l’utente alla lista eventi
- “modifica”, “correggi” e “cambia” sono guide non operative generiche
- questi alias generici non devono essere salvati come eventi
- questi alias generici non devono aprire edit flow automatico
- durante edit mode un command riconosciuto non deve diventare update_event
- durante edit mode i comandi strutturali devono essere bloccati funzionalmente prima del salvataggio

Nota:

Command Intent è implementato solo a primo livello controllato.
Non è ancora un intent engine globale.

Nota post Input Context Consistency:

Il nodo INPUT CONTEXT CONSISTENCY — EDIT / SUGGESTION / COMMAND BOUNDARY ha stabilizzato il confine tra:

- create flow
- edit flow
- command intent
- suggestion project/entity
- alias generici di modifica

Decisione consolidata:

- in create flow gli alias “modifica”, “correggi”, “cambia” vengono trattati come guida non operativa
- non creano eventi
- non mostrano Sintesi evento / Dati evento / Conferma evento
- in edit flow i command riconosciuti vengono bloccati localmente dal confirm handler prima di update_event
- input_analysis_result resta rollbackato alla base stabile
- non è stato introdotto un nuovo engine command/edit
- non è stato modificato il payload
- non è stato modificato button_input_confirm.Disabled

---

1.  UI READINESS / INPUT ANALYSIS RESULT ≠ MOTORE MONOLITICO

Il sistema ha introdotto prima un livello controllato di readiness/visibility UI:

- ui_visibility_mode
- ui_visibility_state

Successivamente ha introdotto:

- preview_analysis_state
- input_analysis_result

preview_analysis_state:

- raccoglie hint/status/warning/Da verificare/associazioni mancanti della Sintesi
- è read-only
- non salva dati
- non modifica parser
- non modifica matching
- non modifica command_intent_state
- non modifica create_suggestion_state
- non modifica save flow
- non modifica DB

input_analysis_result:

- compone lo stato dell’input flow
- distingue raw / selection / effective
- distingue event / command / edit flow
- legge parser, matching, select, suggestion, command e preview state
- non ricalcola parsing
- non ricalcola matching
- non alimenta select_project / select_entity
- non costruisce payload save
- non modifica DB

Regola architetturale:

LOGOS non evolve verso un mega-motore monolitico.

La direzione corretta è:

- moduli specializzati che calcolano
- input_analysis_result che compone
- UI che legge progressivamente una verità operativa coerente

Stato attuale:

input_analysis_result è fonte UI controllata per gli Hidden principali del flow input:

- sintesi.Hidden
- text_event_data_title.Hidden
- select1.Hidden
- select_project.Hidden
- select_entity.Hidden
- container_command_intent.Hidden
- container_association_suggestions.Hidden
- micro-copy notice associazioni mancanti
- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden

ui_visibility_state:

- non è più letto da input_analysis_result
- non governa più gli Hidden principali migrati
- resta presente come residuo tecnico deprecabile / rollback
- non va cancellato fuori da nodo cleanup dedicato

Regole:

- input_analysis_result non è ancora Input Analysis Model completo
- input_analysis_result non è Event Interpretation Engine
- ui_visibility_state è deprecabile ma non eliminato
- button_input_confirm.Hidden è migrato a input_analysis_result
- button_input_confirm.Disabled resta proprietà del componente ma dipende da readiness IAR, fetching e choiceValues correnti
- la guardia G33 solo isAmbiguous è un esito storico, non il binding finale
- il payload corrente è costruito soltanto in confirm_event
- save readiness completa non è ancora centralizzata
- non esiste più dipendenza input_analysis_result → ui_visibility_state
- resta vietato creare dipendenze inverse o loop tra visibility helper

---

11. EDIT FLOW CONTROLLATO

Il flow di modifica evento usa helper tecnici dedicati:

- edit_mode
- editing_event

Questi helper non sono fonte business.

Servono solo per:

- distinguere create flow da edit flow
- conservare l’evento NEW in modifica
- permettere Annulla
- permettere no-op edit guard
- chiudere correttamente il flow edit
- supportare il routing post-save contestuale
- permettere a button_input_confirm di decidere se tornare Home o Lista eventi dopo feedback

Dopo Linting / State Helper Cleanup,
edit_mode / editing_event non usano più:

additionalScope { value }

Il passaggio tecnico avviene tramite:

- window.__logos_edit_mode_value
- window.__logos_editing_event_value

Gli helper leggono la chiave window,
la cancellano dopo la lettura
e ritornano il valore controllato.

Nota UX Mobile Coherence Pass:

edit_mode viene usato anche per distinguere:

- insert reale → feedback → Home
- update reale → feedback → Lista eventi
- cancel create/input → Home
- cancel edit → Lista eventi

12.  FEEDBACK TEMPORANEO ≠ STATO EVENTO

Il feedback post-salvataggio è una conferma UI temporanea.

Non è:

- stato evento
- dato persistente
- validazione WRITTEN
- output analitico
- dato salvato nel DB

Il feedback usa:

- feedback_mode
- feedback_text
- feedback_project
- feedback_summary

Regole:

- feedback_summary viene creato prima del reset input/select
- feedback_summary viene usato solo dalla UI feedback
- feedback_summary viene azzerato dopo auto-return
- feedback_summary non viene salvato nel DB

feedback_mode distingue il tipo di feedback mostrato.

Valori usati:

- project_created
- entity_created
- null / event_created

Regole:

- feedback_mode è UI temporaneo
- non viene salvato nel DB
- viene azzerato dopo auto-return
- permette a feedback_title e feedback_resume di distinguere Evento / Progetto / Entità

Routing consolidato:

- insert reale → feedback 1800 ms → Home
- update reale → feedback 1800 ms → Lista eventi
- no-op edit → Lista eventi immediata senza feedback

13.  MOBILE SAFARI BASELINE

Su iPhone 13 Safari reale è stato rilevato che input/select con font troppo piccolo causavano:

- zoom automatico iOS
- troncamento laterale dell’app
- comportamento anomalo dropdown sulle select

Fix consolidato:

- font-size 16px su input/select principali

Regola:

I campi editabili e select principali devono mantenere font-size minimo 16px su mobile Safari.

Eventuali rifiniture future di font/spaziature non devono riattivare lo zoom automatico iOS.

------------------------------------------------
ARCHITETTURA INPUT
------------------------------------------------

COMPONENTI:

input_home
→ input utente (source of truth)

input_raw
→ derivato tecnico per parsing

trigger_parse_debounced
→ debounce del parsing

ui_visibility_mode
→ Variable Retool
→ latch UI leggero empty / event / command
→ aggiornata da trigger_parse_debounced
→ non salva dati
→ non sostituisce command_intent_state

command_intent_state
→ helper controllato per riconoscere comandi puri e guide non operative
→ distingue comando strutturale da evento ordinario
→ riconosce create project/entity
→ riconosce guida modifica evento
→ riconosce alias generici modifica / correggi / cambia come edit_generic_help
→ non salva dati
→ non modifica parser/matching/DB
→ non sostituisce edit_mode
→ non apre edit flow automatico

ui_visibility_state
→ Transformer Retool legacy/residuo
→ precedentemente aggregava flag di visibilità del flow input
→ non è più letto da input_analysis_result
→ non governa più gli Hidden principali migrati
→ resta presente come residuo tecnico / rollback fino a cleanup dedicato
→ non è fonte dati salvabile
→ è deprecabile ma non eliminato

preview_analysis_state
→ Transformer Retool read-only
→ raccoglie hint/status/warning/Da verificare/associazioni mancanti della Sintesi
→ fonte specializzata per preview/hint
→ non salva dati
→ non modifica parser/matching/save flow/DB

input_analysis_result
→ Transformer Retool compositivo read-only
→ aggrega input, parsed, type, project/entity, selection, suggestion, command, preview e readiness
→ espone raw / selection / effective
→ fonte UI controllata per gli Hidden principali del flow input
→ governa readiness/visibility per Sintesi, Dati evento, Command, Suggestion, Input container, Loading, Cancel e Conferma Hidden
→ espone canShowConfirm come flag visibility-only
→ mantiene distinta la readiness funzionale canConfirm
→ alimenta Disabled tramite readiness.canConfirm; il componente aggiunge fetching e controllo dei token
→ non alimenta select_project / select_entity
→ non costruisce payload save
→ non modifica DB

parse_input_controlled
→ parser controllato + normalization base + duration normalization base

analysis_snapshot.parsed
→ risultato parsato validato usato dai consumer Q2; ui_state.parsed è mirror compatibile pubblicato nello stesso bundle.

select1
→ fonte runtime per type classification base
→ valore salvato in events.type

project_state
→ fonte minima matching project
→ calcola matches / count / isAmbiguous / singleMatch

entity_state
→ fonte minima matching entity
→ calcola matches / count / isAmbiguous / singleMatch

create_suggestion_state
→ helper controllato per suggestion project/entity
→ legge input_raw, project_state, entity_state, projects_list, entities_list
→ non salva dati
→ non decide al posto dell’utente
→ alimenta container suggestion inline
→ espone requiresUserOverride quando esiste una selezione attiva ma l’input suggerisce una candidate più specifica non ancora presente
→ non blocca il salvataggio
→ non modifica select_project / select_entity
→ non modifica button_input_confirm.Disabled

select_project
→ legge analysis_snapshot.value?.project?.singleMatch per il default ordinario
→ fornisce la selezione Project ordinaria/storica alla proiezione IAR; la FK finale è risolta dal coordinatore

select_entity
→ legge analysis_snapshot.value?.entity?.singleMatch per il default ordinario
→ fornisce la selezione Entity ordinaria/storica alla proiezione IAR; la FK finale è risolta dal coordinatore

input_new_project_name
→ campo micro-editor per creazione project inline

input_new_entity_name
→ campo micro-editor per creazione entity inline

create_anagrafica (scope page1)
→ verifica Nome/Tipologia, preflight e rappresentazione POST per i quattro percorsi N18
→ chiama una delle due query fisiche esistenti

insert_project
→ crea project ACTIVE solo previa conferma utente, tramite query condivisa

insert_entity
→ crea entity ACTIVE solo previa conferma utente, tramite query condivisa

container_command_intent
→ UI dedicata ai comandi riconosciuti
→ visibile solo per command intent coerente con input corrente
→ nasconde Sintesi evento / Dati evento quando l’input è comando puro

text_input_analysis_loading
→ micro-messaggio “Analisi input…”
→ mostrato vicino all’input principale durante transizione input/readiness
→ non modifica dati

text_edit_mode_notice
→ notice compatta edit mode
→ visibile solo con edit_mode attivo
→ mostra testo breve standard:
  “Evento in modifica · Premi Annulla modifica per uscire.”
→ se viene rilevato un command fresco durante edit mode, mostra testo contestuale:
  “Comando rilevato · Premi Annulla modifica prima di usare comandi.”
→ chiarisce che in edit mode Command Intent non prende controllo del flow
→ riduce il rischio che l’utente provi a usare comandi strutturali durante modifica evento

input_command_project_name
→ campo command per completare il nome progetto quando l’utente scrive “crea progetto”

input_command_entity_name
→ campo command per completare il nome entità quando l’utente scrive “crea entità”

btn_command_create_project
→ crea project da command solo previa conferma
→ riusa create_anagrafica e indirettamente insert_project

btn_command_create_entity
→ crea entity da command solo previa conferma
→ riusa create_anagrafica e indirettamente insert_entity

btn_command_go_events
→ guida alla lista eventi dal command “modifica evento”
→ non modifica record

edit_mode
→ helper tecnico per distinguere create flow / edit flow
→ non usa più additionalScope { value }
→ legge window.__logos_edit_mode_value

editing_event
→ helper tecnico che conserva l’evento NEW in modifica
→ non usa più additionalScope { value }
→ legge window.__logos_editing_event_value

btn_cancel_edit / cancel contestuale
→ in create/input mode torna Home senza insert_event
→ in edit mode annulla modifica evento NEW senza update_event

input_events_search
→ filtro client-side lista eventi NEW

container_app_nav
→ navigation dock contestuale Home / Eventi / Dashboard
→ Hidden aggiornato post UI Readiness usando input_home.value
→ bottom bar flash risolto
→ visibile in Home vuota e Events list
→ nascosta durante input attivo e feedback

feedback_summary
→ oggetto UI temporaneo per riepilogo feedback
→ non persistito nel DB
→ azzerato dopo auto-return feedback

feedback_mode
→ valore UI temporaneo per distinguere feedback evento/progetto/entità
→ non persistito nel DB
→ azzerato dopo auto-return feedback

label / sintesi (preview)
→ derivato UI (non persistito)
→ allineato visualmente a analysis_snapshot.parsed per amount/unit/date
→ mostra durata normalizzata in forma umana + hint tecnico
→ mostra/supporta type tramite select1
→ legge project_state/entity_state per hint e highlight matching
→ non è fonte decisionale project/entity

---

FLOW ATTUALE:

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
→ feedback temporaneo
→ routing post-save contestuale

Nota post G22:

La nota storica G22 qui sotto riguarda la suggestion di estensione, distinta dalla nuova informazione su varianti e Stato in N21.

create_suggestion_state può produrre requiresUserOverride.

preview_analysis_state consuma questo flag per generare un warning mirato non bloccante:

- Associazione progetto da controllare
- Associazione entità da controllare

Questo warning non modifica:

- parser
- matching primario
- select
- confirm guard
- payload
- save flow
- DB

Nota UI Readiness / Input Analysis Result:

La visibility/readiness del flow input è coordinata da:

- ui_visibility_mode come latch leggero empty / event / command
- input_analysis_result come fonte UI controllata per gli Hidden principali del flow input
- ui_visibility_state come residuo tecnico deprecabile / rollback

Questi helper non modificano:

- amount
- unit
- event_date
- type
- project_id
- entity_id
- raw_input
- payload
- DB

Regola:

input_analysis_result governa visibility/readiness del flow input,
ma non diventa fonte payload e non sostituisce parser, matching, select o save flow.

Nota post Visibility Migration Completion:

input_analysis_result governa ora gli Hidden principali del flow input.

Migrati:

- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden

Non migrati intenzionalmente:

- insert_event / update_event
- container_home.Hidden
- container_feedback.Hidden
- container_events_list.Hidden
- button_input_confirm.Disabled, che resta guard funzionale separata anche dopo G33
- button_input_confirm payload

Nota post G33:

button_input_confirm.Disabled non è stato migrato dentro input_analysis_result.
È stato solo allineato localmente a project_state/entity_state isAmbiguous.

Regola:

ui_state.view = routing principale app
input_analysis_result = readiness / visibility flow input
ui_visibility_mode = latch empty / event / command

Routing post-save:

Nuovo evento:
→ insert_event
→ feedback 1800 ms
→ Home

Modifica reale:
→ update_event
→ feedback 1800 ms
→ Lista eventi

Edit senza modifiche:
→ nessun update_event
→ nessun feedback
→ Lista eventi immediata

Command create project:
→ btn_command_create_project: Nome da candidateName/input command e guardia canExecute
→ Tipologia da select_command_project_type
→ page1.create_anagrafica → insert_project ACTIVE verificata → tentativo refresh
→ solo a creazione confermata: cleanup di input/suggestion, quattro Tipologie e Select evento
→ feedback_mode = project_created, testo distinto se refresh fallito, stato prima del container
→ feedback 1800 ms → Home; nessuna selezione automatica inline né salvataggio evento

Command create entity:
→ btn_command_create_entity: Nome da candidateName/input command e guardia canExecute
→ Tipologia da select_command_entity_type
→ page1.create_anagrafica → insert_entity ACTIVE verificata → tentativo refresh
→ solo a creazione confermata: cleanup di input/suggestion, quattro Tipologie e Select evento
→ feedback_mode = entity_created, testo distinto se refresh fallito, stato prima del container
→ feedback 1800 ms → Home; nessuna selezione automatica inline né salvataggio evento

Command guida modifica evento:
→ btn_command_go_events
→ reset input command
→ events_new refresh
→ Lista eventi

Nota:

La creazione inline project/entity non sostituisce la conferma evento.

Nota post Input Analysis Result:

input_analysis_result agisce come layer compositivo read-only.

Legge:

- input_home/input_raw, ui_state e ui_visibility_mode per testo e contesto UI;
- analysis_snapshot.parsed, .project, .entity, .command e .suggestion per i risultati correlati;
- edit_mode/editing_event, cataloghi, select1, select_project/select_entity e preview_analysis_state.

Espone mode/input/parsed/type, project ed entity raw/selection/effective, suggestion, command, preview, readiness e diagnostics; inoltre analysis, association, associationContext e choiceValues contestuali. Le scelte inline non sono lette da IAR: nessuna dipendenza inversa o secondo matching. association è input di confirm_event, senza costruzione o persistenza del payload nel transformer.

Non modifica:

- parser
- matching
- command_intent_state
- create_suggestion_state
- select value/default
- payload save: non lo costruisce né lo scrive, ma association è consumata dal builder unico
- insert_event / update_event
- DB

Nota post Visibility Migration Completion:

input_analysis_result non legge più ui_visibility_state.

La precedente dipendenza raw diagnostica è stata rimossa.

Diagnostics consolidati:

- hasUiVisibilityDependency: false
- usesUiVisibilityOnlyAsRawDiagnostic: false
- effectiveReadinessComputedInternally: true
- isConsumptionReadyForUiVisibility: true

Regola anti-loop aggiornata:

ui_visibility_state non è più sorgente di input_analysis_result.
Non introdurre dipendenze inverse o circolari.

Dopo creazione verificata tramite page1.create_anagrafica:

- viene tentato il refresh della lista pertinente; il suo fallimento è distinto dall’esito della POST
- nei soli percorsi inline il nuovo UUID viene selezionato soltanto con refresh coerente; chiusura/reset del form non dipendono da tale condizione
- nei percorsi Command Intent sono invece azzerati i Select evento e avviati feedback strutturale e ritorno Home
- l’evento resta non salvato; un eventuale evento richiede una successiva conferma manuale nel relativo flusso
- per errori prima della POST, esito incerto e refresh fallito vale il contratto N18 di Architecture

---

EDIT FLOW:

Ingresso edit corrente Q2: btn_edit invalida analysis/consenso con epoch e revisione; inizializza l’evento e il modo edit tramite i risultati delle query canoniche, verificandoli dopo ogni await; carica testo visibile/tecnico e FK storiche; avvia il solo trigger correlato con analysis_revision_id e analysis_expected_context. Se setValue genera un nuovo proprietario della revisione, l’handler superato si ferma. Non usare await del solo debounce come attestazione di analisi completa.
Il sorgente integrale finale di btn_edit e gli handler di cancel/navigazione sono conservati in Architecture, nelle configurazioni e nei dodici handler Q2.
La notice edit e i consumer seguono il medesimo snapshot/contesto.

Percorsi possibili:

1. Modifica reale:
→ button_input_confirm delega confirm_event(begin)
→ guardie, payload unico e preflight → update_event
→ soltanto dopo successo: reset, events_new, feedback temporaneo 1800 ms
→ ritorno Lista eventi

1. Conferma senza modifiche reali:
→ button_input_confirm
→ no-op edit guard
→ nessun update_event
→ nessun feedback
→ reset edit_mode / editing_event
→ ritorno Lista eventi immediata

1. Annulla:
→ btn_cancel_edit / cancel contestuale
→ nessun update_event
→ reset edit_mode / editing_event
→ reset input/select/ui_state.parsed
→ azzera feedback_summary
→ ritorno Lista eventi

1. Cancel create/input:

input in creazione
→ Torna alla home
→ nessun insert_event
→ reset input/select/ui_state.parsed
→ azzera feedback_text / feedback_project / feedback_summary
→ ritorno Home

Nota:

in edit flow vengono rilanciati anche project_state/entity_state.
Questo mantiene coerenti suggerimenti, select, hint e confirm guard anche durante la modifica eventi.

Dopo Linting / State Helper Cleanup,
btn_edit non usa più additionalScope { value } per edit_mode / editing_event.

Usa invece:

- window.__logos_editing_event_value = item
- window.__logos_edit_mode_value = true

Regola post UI Readiness:

Durante edit mode, Command Intent non prende controllo del flow.

Se l’utente svuota l’input e scrive un comando, resta comunque in modalità modifica.

Dopo il nodo INPUT CONTEXT CONSISTENCY — EDIT / SUGGESTION / COMMAND BOUNDARY,
il comportamento è stato stabilizzato così:

- input_analysis_result resta rollbackato alla base stabile
- edit mode continua a prevalere sul Command Intent a livello effective
- il command container non diventa operativo in edit mode
- button_input_confirm intercetta i command freschi prima di update_event
- se l’input corrente corrisponde a un command riconosciuto, Conferma non salva e mostra warning
- text_edit_mode_notice mostra una micro-copy contestuale quando rileva un command in edit mode

Contenuto standard:

Evento in modifica · Premi Annulla modifica per uscire.

Contenuto quando viene rilevato un command in edit mode:

Comando rilevato · Premi Annulla modifica prima di usare comandi.

Per uscire dall’edit flow l’utente deve premere Annulla modifica.

Nota post Input Analysis Result:

input_analysis_result rende esplicita questa regola a livello effective.

In edit mode:

- raw command può essere true
- rawIsCommand può essere true
- rawIsPureCommand può essere true
- isSuppressedByEditMode = true
- effective command = false
- effectiveFlowType = edit
- effective event flow resta prevalente

Caso noto stabilizzato:

edit mode + input command-like

Esempi:

- modifica
- correggi
- cambia
- crea progetto test
- crea entità test

Comportamento attuale:

- Command Intent non prende controllo operativo del flow
- container_command_intent resta nascosto
- l’utente resta in modifica evento
- text_edit_mode_notice mostra guidance contestuale se il command è riconosciuto
- button_input_confirm blocca update_event improprio tramite guard locale
- nessun project/entity viene creato da command durante edit mode
- nessun evento viene aggiornato con input command-like riconosciuto

Residuo UX accettato:

Sintesi / Suggerimenti associazione / Dati evento possono restare visibili anche quando in edit mode viene rilevato un command.

Decisione:

il residuo è accettato perché il blocco funzionale impedisce update_event e creazioni improprie.
Non correggere ora tramite input_analysis_result o Hidden multipli per evitare instabilità.

------------------------------------------------
COMMAND INTENT FLOW
------------------------------------------------

Il Command Intent è un primo livello controllato per distinguere:

- input evento ordinario
- comando strutturale puro
- guida non operativa

Componenti principali:

- command_intent_state
- container_command_intent
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

Output logico command_intent_state:

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

Regole:

- isCommand = true se l’input è un comando riconosciuto
- isPureCommand = true se l’input non deve essere salvato come evento
- commandFamily può essere create / exists / guide
- commandType può essere create_project / create_entity / create_target_missing / project_exists / entity_exists / edit_event_help / edit_generic_help
- targetType può essere project / entity / event / null
- candidateName contiene il nome candidato estratto
- existingId contiene l’id di project/entity già esistente, se rilevato
- needsCompletion = true se manca il nome
- canExecute = true solo se la creazione è consentita
- guideMessage contiene la guida non operativa
- rawInput conserva l’input sorgente analizzato

------------------------------------------------
COMMAND INTENT — CASI GESTITI
------------------------------------------------

Comando generico:

crea
aggiungi
inserisci
nuovo
nuova

Comportamento:

- mostra guida con esempi
- non mostra Sintesi evento
- non mostra Dati evento
- non salva eventi

---

Create project incompleto:

crea progetto

Comportamento:

- mostra campo input_command_project_name
- bottone Crea progetto disabilitato finché il nome è vuoto
- non salva eventi

---

Create project completo:

crea progetto Villa Nuova
aggiungi progetto Villa Nuova
inserisci progetto Villa Nuova
nuovo progetto Villa Nuova

Comportamento:

- mostra riepilogo progetto
- mostra bottone Crea progetto
- crea project solo dopo click utente
- usa insert_project esistente
- non salva eventi

---

Create entity incompleto:

crea entità

Comportamento:

- mostra campo input_command_entity_name
- bottone Crea entità disabilitato finché il nome è vuoto
- non salva eventi

---

Create entity completo:

crea entità Patrizio
aggiungi entità Referente Kappa
inserisci entità Marco Parisi
nuova entità Marco Parisi

Comportamento:

- mostra riepilogo entità
- mostra bottone Crea entità
- crea entity solo dopo click utente
- usa insert_entity esistente
- non salva eventi

---

Elemento già presente:

crea progetto villa

se Villa esiste già.

Comportamento:

- mostra Elemento già presente
- nessun bottone crea
- nessuna duplicazione
- nessun evento salvato
- guida l’utente a usare il dato esistente o un nome più specifico

---

Guida modifica evento:

modifica evento
correggi evento
cambia evento
come modifico evento
devo modificare evento

Comportamento:

- mostra guida con step
- mostra CTA Vai agli eventi
- non modifica record
- non apre edit flow automatico
- non salva eventi

---

Guida generica modifica/correzione:

modifica
correggi
cambia

Comportamento in create flow:

- mostra command container
- mostra guida non operativa
- non mostra Sintesi evento
- non mostra Dati evento
- non mostra Conferma evento
- non crea eventi
- non apre edit flow automatico

Comportamento in edit flow:

- resta in edit mode
- non apre command container operativo
- text_edit_mode_notice mostra avviso contestuale
- button_input_confirm blocca update_event se l’input corrente corrisponde al command riconosciuto
- non crea project/entity
- non aggiorna evento
- l’utente può correggere l’input oppure premere Annulla modifica

Nota:

Questa gestione è locale e prudente.
Non introduce alias system globale.
Non introduce fuzzy matching.
Non introduce command engine avanzato.

------------------------------------------------
COMMAND INTENT — VINCOLI
------------------------------------------------

Command Intent NON è:

- parser amount/unit/date
- match engine
- create_suggestion_state
- save flow evento
- edit flow automatico
- dashboard command system
- intent engine globale
- form guidato completo

Command Intent NON deve:

- modificare DB schema
- creare project/entity automaticamente
- salvare eventi da comandi puri
- bypassare select_project / select_entity negli eventi ordinari
- aprire modifiche evento automatiche
- anticipare dashboard/KPI

------------------------------------------------
UI READINESS / INPUT ANALYSIS RESULT FLOW
------------------------------------------------

UI Readiness / Visibility Aggregator è stato implementato a primo livello controllato.

Obiettivo:

- distinguere visivamente empty / event / command
- ridurre Hidden duplicate
- stabilizzare container_input
- eliminare il container vuoto durante digitazione
- ridurre rendering progressivo
- risolvere flash bottom bar
- preservare parser / matching / command / suggestion / save flow
- introdurre progressivamente input_analysis_result come lettura UI coerente
- distinguere raw / selection / effective state
- ridurre letture sparse senza sostituire i moduli specializzati

Componenti:

- ui_visibility_mode
- ui_visibility_state residuo tecnico deprecabile
- preview_analysis_state
- input_analysis_result
- text_input_analysis_loading
- text_edit_mode_notice

---

UI_VISIBILITY_MODE

Tipo:

Variable Retool

Valori:

- empty
- event
- command

Aggiornata da:

trigger_parse_debounced

Significato:

empty:
input vuoto / nessun flow input attivo

event:
evento ordinario

command:
command intent / guida command

---

UI_VISIBILITY_STATE

Tipo:

Transformer Retool legacy/residuo.

Ruolo storico:

aggregatore read-only di visibilità UI.

Stato attuale post Visibility Migration Completion:

- non è più letto da input_analysis_result
- non governa più gli Hidden principali migrati
- non è fonte dati salvabile
- non modifica parser
- non modifica matching
- non modifica DB
- non costruisce payload
- è deprecabile ma non eliminato

Motivo della non eliminazione immediata:

- conservare rollback tecnico
- evitare cleanup fuori nodo
- rinviare eliminazione a CLEANUP OBSOLETE UI GUARDS / QUERY REDUCTION

Componenti ora governati da input_analysis_result:

- container_command_intent.Hidden
- sintesi.Hidden
- container_association_suggestions.Hidden
- text_event_data_title.Hidden
- select1.Hidden
- select_project.Hidden
- select_entity.Hidden
- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden

Componenti non governati da input_analysis_result perché routing principale app:

- container_home.Hidden
- container_feedback.Hidden
- container_events_list.Hidden

Regola:

ui_state.view = routing principale app
input_analysis_result = readiness / visibility flow input
ui_visibility_mode = latch empty / event / command

Risultati consolidati:

✔ container vuoto durante digitazione risolto
✔ flash input flow ridotto
✔ bottom bar flash risolto
✔ Hidden principali flow input migrati a input_analysis_result
✔ edit mode + input vuoto stabilizzato
✔ Home idle container nascosti durante edit mode
✔ Dati evento / Sintesi / Conferma nascosti con edit input vuoto
✔ Annulla modifica visibile con edit input vuoto
✔ button_input_confirm.Hidden migrato senza toccare Disabled
✔ save flow invariato

------------------------------------------------
INPUT_HOME
------------------------------------------------

Ruolo:

- campo principale di input
- visibile all’utente
- source of truth lato UX

Caratteristiche:

- libero
- senza vincoli formali
- accetta qualsiasi testo

---

Regole:

✔ sempre modificabile  
✔ sempre attivo  
✔ non validato  
✔ non bloccante  

------------------------------------------------
INPUT_RAW
------------------------------------------------

Ruolo:

- adapter tecnico
- base per parsing
- valore sincronizzato da input_home

---

Caratteristiche:

- hidden
- derivato da input_home
- non modificato direttamente dall’utente

---

Sync:

input_home → input_raw

---

Nota:

Il precedente rischio di loop reattivo è stato ridotto tramite:

- trigger_parse_debounced
- parse_input_controlled
- pubblicazione correlata unica e analysis_snapshot; ui_state.parsed resta mirror compatibile, non prova autonoma di completamento

------------------------------------------------
MOBILE SAFARI BASELINE
------------------------------------------------

Durante il test reale su iPhone 13 Safari sono stati rilevati problemi non emersi nella sola preview mobile Retool.

Problemi:

- tap su input causava zoom automatico iOS
- dopo lo zoom l’app veniva troncata lateralmente
- select Tipo / Progetto / Entità non mostravano correttamente il dropdown completo

Fix applicato:

- font-size portato a 16px sui campi editabili/select principali

Campi coinvolti:

- input_home
- input_events_search
- select1
- select_project
- select_entity
- input_new_project_name
- input_new_entity_name
- input_command_project_name
- input_command_entity_name

Esito:

- zoom automatico Safari iOS risolto
- layout non più troncato
- select funzionanti sia in digitazione sia in dropdown
- validazione reale su iPhone 13 Safari completata

Regola:

input e select principali su mobile Safari devono mantenere font-size minimo 16px.

Il polish finale può rivedere spaziature e gerarchia visiva,
ma non deve riattivare lo zoom automatico iOS.

------------------------------------------------
NAVIGATION DOCK
------------------------------------------------

Componente:

container_app_nav

Voci:

- Home
- Eventi
- Dashboard

Stato Dashboard:

- presente come voce prevista
- disabilitata
- nessuna dashboard implementata
- nessun KPI anticipato

Comportamento:

Home vuota:

- nav visibile in basso

Input/Sintesi attiva:

- nav nascosta

Events list:

- nav visibile in alto

Feedback:

- nav nascosta

Regola:

La navigation dock è UI di navigazione.
Non è parte del dato evento.
Non modifica parser, matching, salvataggio o lifecycle DB.

Decisione:

La nav è contestuale e non fixed/sticky,
per evitare sovrapposizioni e instabilità mobile in Retool.

------------------------------------------------
TRIGGER_PARSE_DEBOUNCED
------------------------------------------------

Orchestratore finale Q2, sorgente integrale nell’appendice di questo documento. Attesa cancellabile di 350 ms; ogni invocazione ha ID seriale distinto anche a revisione uguale. Il controllo current precede i motori e segue gli await. Parser/Project/Entity/Command vengono attesi con Promise.all; una risposta mancante/non correlata impedisce il bundle. La suggestion dipende dai risultati della stessa richiesta. Il catch corrente azzera analysis e la proiezione parsed, senza autorizzare un risultato parziale. Una richiesta superata termina senza diventare autorevole.

La vecchia classificazione parallela di Command Intent e il token di visibilità non sono il contratto funzionale attuale. La visibilità finale segue il Command Intent canonico restituito. Il valore restituito dal solo trigger non sostituisce i controlli dello snapshot e del coordinatore.


UI_STATE.PARSED

Proiezione compatibile con amount/unit/event_date, pubblicata dall’orchestratore insieme a ui_state.analysis. Non è una barriera autonoma. I consumer decisivi (Tipo, Sintesi, IAR e coordinatore) leggono il parsed del bundle correlato, attraverso analysis_snapshot o lo snapshot catturato e ricontrollato dal coordinatore.

ui_state.analysis contiene ID richiesta, revisione, raw, contesto, status complete, cataloghi e risultati parser/Project/Entity/Command/suggestion. analysis_revision e i controlli correnti ne qualificano l’uso; lo schema iniziale di ui_state è riportato esattamente nella configurazione Q2 in appendice. Analisi null o non corrente non consente una nuova associazione eccezionale.

parsed non incorpora type, matching o decisioni: Tipo rimane la scelta canonica corrente; IAR compone le associazioni e confirm_event risolve gli UUID finali. La creazione anagrafica canonica aggiorna cataloghi/selezione e riavvia il raccordo di analisi negli handler finali conservati in Architecture. Non modifica il corpo del parser per inventare risultati.



Nota feedback:

ui_state.feedback_summary NON contiene dati persistenti.

È un oggetto temporaneo usato solo per mostrare il riepilogo nel feedback mobile.

Contenuto atteso:

{
  type,
  date,
  amount,
  project,
  entity,
  text
}

Regole:

- creato prima del reset input/select
- letto solo dal container_feedback
- non modifica ui_state.parsed
- non modifica payload evento
- non viene salvato in Supabase
- viene azzerato dopo auto-return feedback

Nota feedback_mode:

ui_state.feedback_mode NON contiene dati persistenti.

È un valore temporaneo usato solo dalla UI feedback per distinguere:

- Evento salvato
- Progetto creato
- Entità creata

Valori usati:

- project_created
- entity_created
- null / event_created

Non modifica:

- ui_state.parsed
- payload evento
- Supabase
- lifecycle evento

------------------------------------------------
UI_VISIBILITY_MODE / UI_VISIBILITY_STATE / INPUT_ANALYSIS_RESULT
------------------------------------------------

Questi helper appartengono alla linea UI Readiness / Input Analysis.

Non fanno parte di ui_state.parsed.

Non sono dati salvabili.

---

ui_visibility_mode:

- Variable Retool
- valori:
  - empty
  - event
  - command
- aggiornata da trigger_parse_debounced
- usata da ui_visibility_state
- letta anche da input_analysis_result
- non salva dati
- non sostituisce command_intent_state

---

ui_visibility_state:

- Transformer Retool legacy/residuo
- precedentemente aggregava flag di visibilità
- non è più letto da input_analysis_result
- non governa più gli Hidden principali migrati
- non modifica dati
- non modifica parser
- non modifica matching
- non modifica DB
- non costruisce payload
- è deprecabile ma non eliminato
- resta solo come residuo tecnico / rollback fino a cleanup dedicato

Componenti non più governati da ui_visibility_state:

- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden

Componenti migrati a input_analysis_result:

- sintesi.Hidden
- text_event_data_title.Hidden
- select1.Hidden
- select_project.Hidden
- select_entity.Hidden
- container_command_intent.Hidden
- container_association_suggestions.Hidden
- container_input.Hidden
- text_input_analysis_loading.Hidden
- btn_cancel_edit.Hidden
- btn_cancel_input_home.Hidden
- button_input_confirm.Hidden

---

preview_analysis_state:

- Transformer Retool read-only
- fonte specializzata preview/hint
- raccoglie:
  - hints
  - hasHints
  - hasBlockingAmbiguity
  - hasWarning
  - statusLabel
  - statusColor
  - statusBg
  - dotColor
  - missingAssociationTitle
  - showMissingAssociationNotice

---

input_analysis_result:

- Transformer Retool compositivo read-only
- non legge più ui_visibility_state
- calcola readiness / visibility effettiva propria
- espone raw / selection / effective state
- fonte UI controllata per gli Hidden principali del flow input
- espone canShowConfirm come flag visibility-only
- mantiene canConfirm come readiness funzionale distinta
- alimenta Disabled tramite readiness.canConfirm; il componente aggiunge fetching e confronto reattivo dei choiceValues
- non centralizza la save readiness completa

Relazione con input system:

input_home / input_raw
→ trigger_parse_debounced
→ ui_visibility_mode
→ command_intent_state
→ parse_input_controlled
→ project_state / entity_state
→ create_suggestion_state
→ preview_analysis_state
→ input_analysis_result
→ Hidden principali del flow input

Relazione con futuro Input Analysis Model:

input_analysis_result è il primo layer compositivo concreto,
ma non è ancora Input Analysis Model completo.

Non è:

- Event Interpretation Engine
- motore monolitico
- sostituto del parser
- sostituto del matching
- sostituto delle select
- fonte payload save

Regola anti-loop:

input_analysis_result non legge più ui_visibility_state.
ui_visibility_state non deve leggere input_analysis_result.
Non introdurre dipendenze circolari tra helper visibility/readiness.

Nota post Button Confirm Readiness Alignment:

G33 non ha modificato input_analysis_result.

La visibilità del bottone Conferma resta governata da:

input_analysis_result.readiness.canShowConfirm

La proprietà Disabled resta nel componente e usa il binding UX-R1 riportato in «MATCHING NON DECISIONALE». IAR fornisce la readiness canonica; il componente verifica anche fetching/scelte, mentre confirm_event conserva le guardie finali.

**Fotografia G33:** il vecchio controllo era limitato a isAmbiguous e non modificò gli altri layer. Questa descrizione conserva l’esito storico, non il binding corrente Q2.
- payload
- insert_event / update_event
- DB

------------------------------------------------
HELPER EDIT STATE
------------------------------------------------

Il sistema usa due helper tecnici Retool per il flow edit:

- edit_mode
- editing_event

Questi helper NON sono fonte dati business.

---

EDIT_MODE

Ruolo:

- distingue create flow da edit flow
- abilita btn_cancel_edit
- permette a button_input_confirm di scegliere tra insert_event e update_event

Valori:

- true
- false

Codice runtime:

```js
const key = "__logos_edit_mode_value";

if (!Object.prototype.hasOwnProperty.call(window, key)) {
  return false;
}

const nextValue = window[key];

delete window[key];

return Boolean(nextValue);
```

EDITING_EVENT

Ruolo:

conserva l’evento NEW attualmente in modifica
permette il confronto no-op con i dati originali
viene azzerato al termine del flow edit

Valori:

item evento NEW
null

Codice runtime:

const key = "__logos_editing_event_value";

if (!Object.prototype.hasOwnProperty.call(window, key)) {
  return null;
}

const nextValue = window[key];

delete window[key];

return nextValue ?? null;

Motivo del pattern:

Prima gli helper usavano:

return value;

con valore passato tramite:

additionalScope: { value: ... }

Il runtime era corretto,
ma Retool segnalava:

edit_mode: 'value' is not defined
editing_event: 'value' is not defined

Il nuovo pattern elimina il linting
senza modificare parser, matching, preview, DB, type o duration.

Regola:

Le chiavi:

window.__logos_edit_mode_value
window.__logos_editing_event_value

sono temporanee.

Devono essere scritte solo dal chiamante immediato
e cancellate dagli helper dopo la lettura.

------------------------------------------------
CANCEL CONTESTUALE — CREATE / EDIT
------------------------------------------------

Componente:

btn_cancel_edit / pulsante cancel contestuale

Label dinamica:

- create/input mode → Torna alla home
- edit mode → Annulla modifica

CREATE / INPUT MODE:

Comportamento:

- cancella eventuale debounce pendente
- cancella eventuale timer feedback pendente
- non esegue insert_event
- resetta input_home
- resetta input_raw
- pulisce select_project
- pulisce select_entity
- pulisce select1
- resetta ui_state.parsed
- azzera feedback_text
- azzera feedback_project
- azzera feedback_summary
- imposta ui_state.view = "home"
- mostra Home
- nasconde Input / Feedback / Events list

Risultato:

- nessun evento creato
- nessuna modifica DB
- Home pulita

EDIT MODE:

Comportamento:

- cancella eventuale debounce pendente
- cancella eventuale timer feedback pendente
- scrive window.__logos_edit_mode_value = false
- rilancia edit_mode
- scrive window.__logos_editing_event_value = null
- rilancia editing_event
- non esegue update_event
- resetta input_home
- resetta input_raw
- pulisce select_project
- pulisce select_entity
- pulisce select1
- resetta ui_state.parsed
- azzera feedback_text
- azzera feedback_project
- azzera feedback_summary
- imposta ui_state.view = "events"
- mostra Lista eventi

Risultato:

- nessun update_event
- updated_at invariato
- ritorno Lista eventi

Notice edit mode:

Durante edit mode viene mostrato:

text_edit_mode_notice

Contenuto:

Evento in modifica · Premi Annulla modifica per uscire.

Scopo:

- chiarire che il sistema è ancora in modifica evento
- evitare confusione se l’utente cancella l’input e scrive “crea”
- preservare il comportamento corretto: edit mode prevale su Command Intent

PARSING SYSTEM

FUNZIONE:

estrarre informazioni strutturate dall’input.

TIPO:

best-effort deterministico

OUTPUT:

amount
unit
event_date

⚠ label NON è output del parsing

REGOLE:

✔ parsing non blocca
✔ parsing può fallire
✔ parsing può essere parziale
✔ parsing non interpreta semanticamente l’evento
✔ parsing non classifica direttamente spesa/incasso
✔ parsing fornisce però unit utili alla type classification base
✔ parsing non modifica raw_input

CASI:

✔ parsing corretto
✔ parsing incompleto
✔ parsing errato

Tutti validi.

L’utente mantiene il controllo finale.

PARSING + NORMALIZATION BASE

Il parser attuale non si limita più a estrarre dati,
ma applica anche una normalizzazione base controllata.

Questa normalizzazione riguarda:

amount
unit
event_date preservato
durate certe ore/minuti normalizzate in minuti

La Duration Normalization Base è parte del parsing controllato.

Regola:

tutte le durate certe espresse in ore/minuti vengono convertite in minuti.

Esempio:

1 ora e 15 minuti
→ amount 75
→ unit minuti

2h30
→ amount 150
→ unit minuti

raw_input resta sempre preservato.

Non riguarda direttamente:

label
project
entity
spesa/incasso
matching project/entity
hint
dashboard
KPI

Nota:

type classification base usa analysis_snapshot.parsed.unit come segnale,
ma resta gestita da select1, non dal parser.

Nota:

il matching project/entity è ora stabilizzato a primo livello tramite project_state/entity_state,
ma resta separato dal parser.

Il parser non decide project/entity.

Obiettivo:

rendere coerenti i dati strutturati minimi
prima di insert/update.

PARSING UNITÀ

Unità supportate:

euro
minuti
ore

RICONOSCIMENTO UNITÀ

EURO:

€
euro
eur
€20
20€
€ 20
20 euro
20 eur

TEMPO — ORE:

ora
ore
h
1 ora
1ora
2 ore
2ore
2h
h2
2 h
1,5 ore
1.5 ore
1,5h
1.5h

TEMPO — MINUTI:

min
minuto
minuti
30 min
30min
30 minuti
30minuti
min30

OUTPUT NORMALIZZATO UNIT:

€, euro, eur → euro

h, ora, ore, min, minuto, minuti → minuti

Regola durata:

le unità tempo riconosciute vengono convertite in unità canonica "minuti".

Esempi:

1 ora → amount 60, unit minuti
2 ore → amount 120, unit minuti
1,5 ore → amount 90, unit minuti
18 minuti → amount 18, unit minuti
2h30 → amount 150, unit minuti

NORMALIZZAZIONE INPUT RUNTIME

Applicata solo nel layer parsing.

Operazioni:

lowercase
trim
compressione spazi
riconoscimento simboli (€)
riconoscimento unit compatte
pulizia spazi
estrazione amount per prossimità alla unità

ESEMPI:

2h → amount 120, unit minuti
1ora → amount 60, unit minuti
18min → amount 18, unit minuti
1,5 ore → amount 90, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
2h30 → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti
€20 → amount 20, unit euro
1.500,50 euro → amount 1500.5, unit euro

IMPORTANTE:

✔ non modifica input utente
✔ non modifica raw_input
✔ usata solo per parsing interno
✔ produce dati strutturati per ui_state.parsed

GESTIONE ORARI

Formati:

HH:MM

COMPORTAMENTO:

✔ NON considerati amount
✔ NON considerati unit
✔ mantenuti come testo

ESEMPIO:

15:30 test
→ amount null
→ unit null
→ raw_input preservato

ESTRAZIONE AMOUNT

Regola:

estrarre il numero più rilevante rispetto alla unità rilevata.

STRATEGIA:

identificazione dei numeri presenti
identificazione della posizione della unità
selezione del numero con distanza minima dalla unità
conversione tramite normalizeNumberValue
se non esiste unità, amount = null

ESEMPI:

pizza 20 euro → 20 / euro
2 ore lavoro → 120 / minuti
2 ore 30 → 150 / minuti
1 ora e 15 minuti → 75 / minuti
2h30 rendering → 150 / minuti
villa 2 mario → null / null
villa 2 mario rossi 3h → 180 / minuti

FORMATI SUPPORTATI:

interi
decimali con virgola
decimali con punto
migliaia italiane con punto
migliaia italiane + decimali con virgola

ESEMPI AMOUNT NORMALIZATION:

458,78 → 458.78
1,5 → 1.5
1.5 → 1.5
1.500 → 1500
1.500,50 → 1500.5
1500 → 1500

REGOLA CRITICA:

I numeri senza unità NON vengono interpretati come amount.

Esempi:

villa 2 → amount null
cliente 2026 → amount null
casa mare 2 → amount null

Motivo:

preservare numeri semantici
evitare dati quantitativi errati
ridurre errori permanenti in DB

NORMALIZE_NUMBER_VALUE

Funzione runtime utilizzata dal parser:

function normalizeNumberValue(value) {
  if (value === null || value === undefined || value === "") {
    return null;
  }

  const raw = String(value).trim();

  // Formato italiano con migliaia + decimali:
  // 1.500,50 → 1500.50
  if (/^\d{1,3}(\.\d{3})+,\d+$/.test(raw)) {
    return Number(raw.replace(/\./g, "").replace(",", "."));
  }

  // Formato italiano con separatore migliaia:
  // 1.500 → 1500
  if (/^\d{1,3}(\.\d{3})+$/.test(raw)) {
    return Number(raw.replace(/\./g, ""));
  }

  // Formato con virgola decimale:
  // 458,78 → 458.78
  // 1,5 → 1.5
  if (/^\d+,\d+$/.test(raw)) {
    return Number(raw.replace(",", "."));
  }

  // Formato con punto decimale compatibile:
  // 1.5 → 1.5
  if (/^\d+\.\d+$/.test(raw)) {
    return Number(raw);
  }

  // Intero semplice:
  // 1500 → 1500
  if (/^\d+$/.test(raw)) {
    return Number(raw);
  }

  return null;
}

------------------------------------------------
DURATION NORMALIZATION BASE
------------------------------------------------

La Duration Normalization Base è stata implementata nel parser controllato.

Decisione:

- amount tempo = totale minuti
- unit tempo = minuti
- raw_input preservato
- nessuna modifica schema DB
- nessun payload duration
- nessun campo duration_minutes dedicato

------------------------------------------------
UNITÀ CANONICA TEMPO
------------------------------------------------

Unità canonica:

minuti

Motivo:

- rende i dati confrontabili
- evita mix tra ore e minuti
- facilita dashboard/report futuri
- permette somma diretta delle durate
- mantiene raw_input come fonte originaria

------------------------------------------------
CASI SUPPORTATI
------------------------------------------------

Minuti semplici:

18 minuti → amount 18, unit minuti
18min → amount 18, unit minuti
min30 → amount 30, unit minuti
90 minuti → amount 90, unit minuti

Ore semplici:

1 ora → amount 60, unit minuti
1ora → amount 60, unit minuti
2 ore → amount 120, unit minuti
2h → amount 120, unit minuti
h2 → amount 120, unit minuti

Ore decimali:

1,5 ore → amount 90, unit minuti
1.5 ore → amount 90, unit minuti
1,5h → amount 90, unit minuti
1.5h → amount 90, unit minuti

Durate composte:

1 ora e 15 minuti → amount 75, unit minuti
1 ora 15 minuti → amount 75, unit minuti
2 ore e 30 minuti → amount 150, unit minuti
2 ore 30 → amount 150, unit minuti
2h30 → amount 150, unit minuti
2 h 30 → amount 150, unit minuti

------------------------------------------------
CASI NON CONVERTITI AUTOMATICAMENTE
------------------------------------------------

Non vengono convertiti automaticamente:

- giorni
- settimane
- giornata
- giornate
- mezza giornata
- parole numeriche tipo “due ore”
- forme colloquiali tipo “un paio d’ore”
- 2h e mezza

Motivo:

questi casi introducono ambiguità operativa.

Esempio:

2 giorni

può significare:

- 48 ore
- due giornate lavorative
- due giornate evento
- due giorni di calendario
- due turni operativi

Decisione:

2 giorni rendering
→ amount null
→ unit null
→ raw_input preservato
→ preview mostra hint durata ambigua

SUCCESS HANDLER PARSER

Nella versione finale Q2 `parse_input_controlled.template.events=[]`: non pubblica indipendentemente ui_state.parsed. Restituisce il risultato canonico con `__logosRequestId`; l’unico publisher del bundle completo è trigger_parse_debounced. Non ripristinare il vecchio Success handler: potrebbe pubblicare un parsed di richiesta precedente fuori dal bundle. Configurazione effettiva e codice sono nell’appendice Q2.


DATE PARSING

Formati supportati:

6/4/26
06/04/2026
4 aprile

Output:

YYYY-MM-DD

Esempi:

6/4/26 → 2026-04-06
4 aprile → 2026-04-04

Non supportati:

oggi
domani
ieri
prossima settimana
date relative
intervalli date

LABEL / SINTESI (RUNTIME)

FUNZIONE:

generare una descrizione leggibile per la preview.

TIPO:

✔ derivato runtime
✔ non persistito
✔ non strutturato
✔ visuale

INPUT:

raw_input
analysis_snapshot.parsed.amount
analysis_snapshot.parsed.unit
analysis_snapshot.parsed.event_date

COMPORTAMENTO:

rimozione amount + unit già rappresentati dal value
rimozione date già parse
normalizzazione spazi
preservazione numeri semantici
gestione compound token
formattazione visuale amount/unit
visualizzazione umana della durata normalizzata
hint valore normalizzato
hint durata ambigua per giorni/settimane

AGGIORNAMENTO PREVIEW ALIGNMENT BASE:

✔ formattazione italiana amount implementata nella sintesi
✔ euro mostrato con due decimali
✔ grouping migliaia visuale
✔ ore/minuti visualizzati coerentemente
✔ singolare/plurale unit gestito
✔ label cleaning aggiornato
✔ bug "minuti" → "uti" risolto
✔ data separata correttamente dalla descrizione
✔ highlight locale reso unit-safe

AGGIORNAMENTO DURATION NORMALIZATION BASE:

✔ durata interna salvata in minuti
✔ preview durata mostrata in forma umana
✔ hint “Normalizzato: X minuti”
✔ hint durata ambigua per giorni/settimane
✔ rimozione dalla label della durata originale già normalizzata
✔ rimozione residui congiunzione “e/ed”

ESEMPI:

1.500,50 euro materiale
→ 1.500,50 € • materiale

1500 euro materiale
→ 1.500,00 € • materiale

18min test
→ 18 minuti • test

1ora lavoro
→ 1 ora
→ Normalizzato: 60 minuti

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

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

villa 2 mario
→ villa 2 mario

IMPORTANTE:

✔ NON esiste ancora un label system separato
✔ logica applicata direttamente nella preview
✔ NON riutilizzabile come modulo indipendente
✔ NON influisce su parsing
✔ NON modifica ui_state.parsed
✔ NON salvata nel DB

⚠ logica accoppiata alla preview
⚠ non isolata come layer indipendente
⚠ preview non ancora view pura
⚠ “Da verificare” resta interno alla Sintesi e non è blocco autonomo
⚠ hint bloccanti / warning informativi / suggestion visuali non sono ancora separati in container indipendenti

Nota post Preview Analysis State / Input Analysis Result:

La logica hint/status principale della Sintesi è ora raccolta in:

preview_analysis_state

La visibilità della Sintesi è ora governata da:

input_analysis_result.readiness.canShowEventPreview

La Sintesi viene nascosta durante command intent puro,
mentre container_command_intent viene mostrato tramite:

input_analysis_result.readiness.canShowCommandContainer

Il contenuto interno della Sintesi non è stato trasformato in view pura.
La Sintesi resta un layer ibrido perché conserva ancora:

- rendering HTML
- label cleaning
- highlight
- layout visuale
- micro-copy finale

Nota:

input_analysis_result non ricalcola gli hint.
Li legge da preview_analysis_state.

Nota post G22 — Match Present / User Override:

preview_analysis_state ora può mostrare un warning mirato quando create_suggestion_state rileva una suggestion extension con selezione già attiva.

Esempio project:

20 euro villa sierri
→ Progetto selezionato: Villa
→ Candidate suggerita: Villa Sierri

Output Da verificare:

Associazione progetto da controllare
Villa selezionato · testo letto: Villa Sierri

Esempio entity:

20 euro mario giordano
→ Entità selezionata: Mario
→ Candidate suggerita: Mario Giordano

Output Da verificare:

Associazione entità da controllare
Mario selezionata · testo letto: Mario Giordano

Regola:

Questo warning è informativo e non bloccante.
Non modifica status DB, payload o salvataggio.

Nota post Visibility Migration Completion:

Durante i test è stato osservato un residuo semantico non bloccante:

2h30 rendering lavoro
→ durata riconosciuta correttamente
→ type Tempo corretto
→ amount 150 / unit minuti corretti
→ Dati evento mostrano però ancora label “Importo” per il valore durata

Questo non è un problema di parser, normalization o save flow.
È un problema di label visuale.

Nodo futuro candidato:

PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT

Possibile regola futura:

- euro → Importo
- minuti / ore → Durata
- nessuna unità → riga assente o label neutra

AGGIORNAMENTO MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL:

✔ hint ambiguità project/entity alimentati da project_state/entity_state
✔ highlight project/entity alimentato da matches
✔ detection locale preview non più fonte decisionale matching
✔ hint match più specifici introdotto
✔ bug €500 nella label preview risolto
✔ preview resta visuale e non salva dati

Esempi:

villa 2 mario
→ villa 2 evidenziato come project
→ mario evidenziato come entity

mario
→ select_entity = Mario
→ hint: Esistono entità più specifiche

villa
→ select_project = Villa
→ hint: Esistono progetti più specifici

€500 acconto alfie mario rossi
→ 500,00 € • acconto alfie mario rossi

------------------------------------------------
TYPE CLASSIFICATION BASE
------------------------------------------------

La Type Classification Base è stata implementata.

Componente principale:

select1

Ruolo:

classificare l’evento in modo minimo, prudente e correggibile dall’utente.

Valori reali disponibili in select1:

- Evento
- Tempo
- Spesa
- Incasso

------------------------------------------------
REGOLE ATTUALI
------------------------------------------------

TEMPO:

parsed.unit = "minuti"
→ select1 = Tempo

Motivo:

dopo Duration Normalization,
tutte le durate certe ore/minuti vengono salvate come:

amount = totale minuti
unit = minuti

Esempi:

2h30 rendering
→ parsed.amount = 150
→ parsed.unit = minuti
→ select1 = Tempo

1 ora lavoro
→ parsed.amount = 60
→ parsed.unit = minuti
→ select1 = Tempo

18min test
→ parsed.amount = 18
→ parsed.unit = minuti
→ select1 = Tempo

------------------------------------------------
SPESA
------------------------------------------------

Regola:

euro + keyword controllate di uscita
→ select1 = Spesa

Keyword base:

- spesa
- acquisto
- acquistato
- comprato
- pagato
- pagamento
- costo
- costi
- uscita
- acconto dato
- acconto versato
- saldo pagato
- saldo versato

Esempi:

20 euro spesa materiale
→ select1 = Spesa

20 euro acquisto materiale
→ select1 = Spesa

20 euro pagato materiale
→ select1 = Spesa

20 euro acconto dato
→ select1 = Spesa

20 euro saldo pagato
→ select1 = Spesa

------------------------------------------------
INCASSO
------------------------------------------------

Regola:

euro + keyword controllate di entrata
→ select1 = Incasso

Keyword base:

- incasso
- incassato
- entrata
- vendita
- venduto
- pagamento ricevuto
- acconto ricevuto
- saldo ricevuto

Esempi:

20 euro incasso cliente
→ select1 = Incasso

20 euro vendita cucciolo
→ select1 = Incasso

20 euro acconto ricevuto
→ select1 = Incasso

20 euro pagamento ricevuto
→ select1 = Incasso

------------------------------------------------
EVENTO / FALLBACK PRUDENTE
------------------------------------------------

Regola:

euro senza direzione chiara
→ select1 = Evento

segnali economici contrastanti
→ select1 = Evento

nessuna unit significativa
→ select1 = Evento

Esempi:

20 euro materiale
→ select1 = Evento

20 euro acconto
→ select1 = Evento

20 euro spesa incasso
→ select1 = Evento

materiale ricevuto 20 euro
→ select1 = Evento

saldo 20 euro
→ select1 = Evento

villa 2 mario
→ select1 = Evento

2 giorni rendering
→ select1 = Evento

4 aprile benzina 50 euro alfie allevamento aspri
→ select1 = Evento

Nota:

"benzina" non viene classificata automaticamente come Spesa.
È una parola di dominio, non una direzione contabile esplicita.

------------------------------------------------
PRINCIPIO DI CONTROLLO UTENTE
------------------------------------------------

La classificazione automatica è solo base.

L’utente può sempre modificare manualmente select1.

La scelta manuale prevale sul default automatico
e viene salvata in events.type.

Esempi validati:

20 euro materiale
→ default Evento
→ utente seleziona Spesa
→ DB: type = Spesa

20 euro materiale
→ default Evento
→ utente seleziona Incasso
→ DB: type = Incasso

------------------------------------------------
PERSISTENZA TYPE
------------------------------------------------

Catena runtime:

select1.value
→ payload.type
→ insert_event / update_event
→ events.type

Il type viene salvato in DB.

Insert:

- salva type

Update:

- aggiorna type

Esempio:

2h30 rendering
→ select1 = Tempo
→ DB: type Tempo, amount 150, unit minuti

20 euro spesa materiale
→ select1 = Spesa
→ DB: type Spesa, amount 20, unit euro

20 euro incasso cliente
→ select1 = Incasso
→ DB: type Incasso, amount 20, unit euro

------------------------------------------------
CODICE LOGICO select1 — SNAPSHOT STORICO PRE-Q2

L’estratto seguente è superato e non va ricopiato come binding corrente. Il value effettivo legge analysis_snapshot.value?.parsed; la trascrizione integrale finale è in «q2-source-select1-value» più avanti. Un commento storico nei byte autentici cita ancora ui_state.parsed: non cambia la lettura effettiva e non ne altera l’hash.
------------------------------------------------

{{
(() => {
  const text = (input_raw.value || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");

  const parsed = ui_state.value?.parsed || {};
  const parsedUnit = String(parsed.unit || "").toLowerCase();

  if (parsedUnit === "minuti") {
    return "Tempo";
  }

  const hasEuro =
    parsedUnit === "euro" ||
    /€|\beuro\b|\beur\b/.test(text);

  const isIncasso =
    /\bincasso\b/.test(text) ||
    /\bincassato\b/.test(text) ||
    /\bentrata\b/.test(text) ||
    /\bvendita\b/.test(text) ||
    /\bvenduto\b/.test(text) ||
    /\bpagamento ricevuto\b/.test(text) ||
    /\bacconto ricevuto\b/.test(text) ||
    /\bsaldo ricevuto\b/.test(text);

  const isSpesa =
    /\bspesa\b/.test(text) ||
    /\bacquisto\b/.test(text) ||
    /\bacquistato\b/.test(text) ||
    /\bcomprato\b/.test(text) ||
    /\bpagato\b/.test(text) ||
    /\bpagamento\b/.test(text) ||
    /\bcosto\b/.test(text) ||
    /\bcosti\b/.test(text) ||
    /\buscita\b/.test(text) ||
    /\bacconto dato\b/.test(text) ||
    /\bacconto versato\b/.test(text) ||
    /\bsaldo pagato\b/.test(text) ||
    /\bsaldo versato\b/.test(text);

  if (isIncasso && isSpesa) {
    return "Evento";
  }

  if (isIncasso) {
    return "Incasso";
  }

  if (isSpesa) {
    return "Spesa";
  }

  if (hasEuro) {
    return "Evento";
  }

  return "Evento";
})()
}}

FINE SNAPSHOT STORICO select1 PRE-Q2

------------------------------------------------
LIMITI TYPE
------------------------------------------------

Non implementato:

- classificazione economica avanzata
- dizionario esteso keyword
- classificazione automatica da parole di dominio
- benzina → Spesa automatica
- materiale → Spesa automatica
- mangime → Spesa automatica
- amount firmato
- direction field
- KPI/reportistica
- retro-normalizzazione eventi storici

PREVIEW SYSTEM

Nota canonica:

Questa sezione documenta la preview nel contesto dell’input flow.

La fonte canonica completa per Sintesi, hint, warning, label visuali,
micro-copy e residui semantici della preview è:

- 06_LOGOS_View_Preview_System

Il presente documento mantiene solo il collegamento tra input parsed,
type, matching e preview.

FUNZIONE:

mostrare interpretazione sistema.

STRUTTURA:

MAIN:

event_date + amount + unit + label

META:

project
entity

HINT:

suggerimenti matching
suggerimenti tipo
hint durata ambigua

REGOLE:

✔ preview non blocca
✔ preview può essere parzialmente errata
✔ preview non modifica input
✔ preview non modifica DB
✔ preview legge dati parsati/normalizzati
✔ preview visualizza amount/unit/date in formato leggibile
✔ preview resta visuale

Preview = rendering di:

parsed (amount, unit, event_date)
select1.value / type
label runtime
stato matching project/entity
hint

Visibilità preview:

input_analysis_result.readiness.canShowEventPreview

Fonte hint/status:

preview_analysis_state

Fonte compositiva UI/readiness:

input_analysis_result

Regola:

La preview viene mostrata solo nel flow evento.
Non viene mostrata nel flow command.

AGGIORNAMENTO PREVIEW ALIGNMENT BASE:

✔ amount formattato in stile italiano
✔ euro visualizzato con simbolo €
✔ euro visualizzato con due decimali
✔ migliaia visualizzate correttamente
✔ ore/minuti visualizzati coerentemente
✔ singolare/plurale unit gestito
✔ label cleaning coerente con amount/unit già rappresentati
✔ date separate correttamente dalla descrizione
✔ highlight locale non interferisce più con unità tecniche

Esempio:

Dato interno:

amount: 1500.5
unit: euro

Preview:

1.500,50 €

DB:

amount: 1500.5
unit: euro

REGOLA CRITICA:

La formattazione italiana è solo visuale.

Non modifica:

- parse_input_controlled
- ui_state.parsed
- button_input_confirm
- insert_event
- update_event
- DB

✔ hint matching project/entity alimentati da project_state/entity_state
✔ highlight project/entity alimentato da matches
✔ detection locale preview non più fonte decisionale matching
✔ bug €500 label preview risolto

⚠ presenza logica interna
⚠ non pura view
⚠ dipendenza da più fonti
⚠ hint duration/type ancora embedded nella preview
⚠ preview non ancora view pura

Nota post Command Intent:

Durante il nodo Command Intent è stato confermato che “Da verificare” è ancora parte della Sintesi e non può essere spostato sotto la CTA senza intervenire sul modello preview.

Questo rafforza il possibile nodo futuro:

PREVIEW MODEL / HINT STATE CONSOLIDATION

Preview Alignment Base:

✔ COMPLETATO

AGGIORNAMENTO DURATION NORMALIZATION BASE:

✔ preview durata in forma umana
✔ valore tecnico normalizzato mostrato come hint
✔ giorni/settimane segnalati come durata ambigua
✔ label cleaning aggiornato per rimuovere durate composte già normalizzate

Esempio:

Dato interno:

amount: 150
unit: minuti

raw_input:

2h30 rendering

Preview:

2 ore 30 minuti • rendering
Normalizzato: 150 minuti

DB:

amount: 150
unit: minuti

AGGIORNAMENTO TYPE CLASSIFICATION BASE:

✔ select1 allineato a analysis_snapshot.parsed.unit
✔ parsed.unit = minuti → Tempo
✔ euro + keyword controllate → Spesa / Incasso
✔ euro senza direzione chiara → Evento
✔ scelta manuale utente preservata
✔ type persistito nel DB tramite confirm

Esempio:

2h30 rendering
→ preview durata: 2 ore 30 minuti
→ select1: Tempo
→ DB: type Tempo, amount 150, unit minuti

AGGIORNAMENTO MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL:

✔ preview legge project_state/entity_state per matching
✔ hint “Più entità trovate” deriva da entity_state.isAmbiguous
✔ hint “Più progetti trovati” deriva da project_state.isAmbiguous
✔ hint rossi spariscono se l’utente risolve manualmente l’ambiguità
✔ highlight legge matches
✔ hint match più specifici introdotti
✔ preview non decide project/entity

MATCHING BASE — FIRST CONTROLLED LEVEL


Il riconoscimento segue `project_state.query` e `entity_state.query`: leggono testo e repertori completi. Le query restituiscono `matches`, `count`, `hasMatch`, `isAmbiguous`, `singleMatch`, `moreSpecificMatches`, `hasMoreSpecificMatches`, `plausibleAlternatives` e `hasPlausibleAlternatives`. Project aggiunge `prefixAlternatives` da UX. Il [Match Engine](02_LOGOS_Match_Engine.md#match-con-varianti-e-prefissi) descrive precedenza dei nomi completi, diacritici, parole intere e nomi numerici.

- Nuovo evento: la Select ordinaria preseleziona il solo singleMatch ACTIVE dello snapshot, altrimenti null. INACTIVE/NULL non sono nuove selezioni manuali. Il candidato unico INACTIVE può richiedere la decisione inline separata; l’associazione resta facoltativa tramite Non collegare.
- Edit: il default è la FK persistita o null; quella storica resta disponibile anche INACTIVE/NULL. Le nuove scelte manuali ordinarie richiedono ACTIVE; la sola eccezione INACTIVE canonica passa dai token inline e dal coordinatore.
- Ambiguità canonica: senza UUID scelto, la Select è vuota nel nuovo evento e permane il blocco preesistente. Le varianti solo informative non estendono quel blocco.
- Le Select ordinarie forniscono UUID alla proiezione IAR; finalAssociationId risolve le FK nel coordinatore. L’etichetta Entity distingue gli omonimi senza alterare il value. Sintesi distingue match testuale, selezione valida e decisione inline.

Esempi N21: Casa Mare può essere proposta come match univoco; Casa Mar presenta Casa e Casa Mare senza scegliere al posto dell’utente. Mario con Stato NULL può essere riconosciuto e mostrare le varianti già presenti, con Select Entity vuota in un nuovo evento. Cucciolata Marzo mostra i due anni senza selezione o proposta di duplicazione. L’handler legacy `input_raw.change` resta fuori dal delta. `input_analysis_result` e la visibilità consumano i risultati senza sostituire i guard della Conferma.

Nota post G22:

Il vecchio warning generico “Esistono progetti più specifici” / “Esistono entità più specifiche” non deve più essere usato come segnale principale per il caso match presente + suggestion extension.

Il segnale corretto per G22 è:

create_suggestion_state.project.requiresUserOverride
create_suggestion_state.entity.requiresUserOverride

---

REGOLE:

✔ mai forzare selezione ambigua
✔ mai creare automaticamente project/entity dal matching
✔ eventuale creazione project/entity passa da create_suggestion_state e conferma utente
✔ utente in controllo
✔ selezione Project ordinaria/storica mantenuta; decisione INACTIVE separata e risolta in confirm_event
✔ selezione Entity ordinaria/storica mantenuta; decisione INACTIVE separata e risolta in confirm_event

---

RISOLTO A PRIMO LIVELLO:

✔ logiche select non ricalcolano matching
✔ preview non usa detection locale come fonte decisionale
✔ hint ambiguità da isAmbiguous
✔ confirm guard da ambiguità non risolta
✔ G33 allineò Disabled a isAmbiguous; Q2 conserva l’ambiguità canonica e aggiunge readiness/fetching/token correnti
✔ rimosso uso di matches.length > 1 come blocco grezzo
✔ match state live in create flow
✔ match state live in edit flow
✔ priority match minimo implementato

---

NON IMPLEMENTATO:

- fuzzy matching
- alias system
- entity hierarchy
- project hierarchy
- deduplicazione
- input analysis model unico
- ui_visibility_state non sostituisce matching
- command intent avanzato oltre create project/entity
- filtro select su match ambigui
- ranking avanzato
- auto-select confidence avanzata
- filtro/priorità contestuale delle options select_project/select_entity
- match engine separato come modulo autonomo

------------------------------------------------
PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
------------------------------------------------

La creazione guidata project/entity è stata implementata a primo livello controllato.

Ruolo:

aiutare l’utente a completare project/entity quando l’input libero
non produce un match sufficiente oppure contiene una estensione specifica
non ancora presente.

Componenti principali:

- create_suggestion_state
- container suggestion inline
- input_new_project_name
- input_new_entity_name
- btn_open_project_create
- btn_open_entity_create
- btn_create_project_inline
- btn_create_entity_inline
- bottone Ignora globale
- bottoni Annulla contestuali

Query:

- insert_project
- insert_entity

Regole:

- nessuna creazione automatica silenziosa
- creazione solo previa conferma utente
- evento non salvato automaticamente dopo creazione project/entity
- project/entity mancanti non bloccano salvataggio
- project/entity ambigui bloccano salvataggio
- match generici con suggerimenti più specifici restano warning non bloccanti
- suggestion ignorata non blocca salvataggio
- una sola creazione guidata aperta alla volta
- select_project / select_entity restano decisione utente finale

Regola post G22:

create_suggestion_state gestisce anche il caso:

match presente + possibile estensione più specifica

Questo accade quando:

- project_state / entity_state hanno già un singleMatch
- create_suggestion_state trova una candidate più specifica non ancora presente
- la candidate è una extension del nome selezionato
- non esiste ambiguità reale

Output aggiuntivo del layer suggestion:

- requiresUserOverride = true

Significato:

requiresUserOverride non blocca.
requiresUserOverride non salva.
requiresUserOverride non cambia la select.
requiresUserOverride non modifica il matching primario.

Serve solo a permettere alla UI di esplicitare il rischio decisionale.

---

PROJECT CREATE

Caso tipico:

villa sierri 15 sopralluogo

Comportamento:

- project_state riconosce Villa come match base
- create_suggestion_state propone Villa Sierri 15 come possibile nuovo project
- input_new_project_name viene precompilato
- utente conferma Nome e Tipologia nel form inline
- btn_create_project_inline chiama page1.create_anagrafica, con preflight e POST insert_project ACTIVE verificata
- a creazione confermata il form viene chiuso e Nome/Tipologia azzerati, anche con refresh fallito
- solo con refresh coerente viene selezionato il nuovo UUID, dopo project_state.trigger()
- create_suggestion_state viene ricalcolato; feedback differenziato sul refresh
- evento resta da confermare manualmente; non ripetere la POST a fronte del solo refresh fallito

Nota post G22:

Il caso osservato in G33 è stato risolto nel nodo:

PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE / AUTO-SELECT CONFIDENCE

### CREATE SUGGESTION NEL FLUSSO INPUT

`create_suggestion_state` legge repertori completi, risultato canonico e selezioni. Per l’estensione parte dall’UUID scelto se risolto, altrimenti da `singleMatch`, con testo significativo e nome base presente nel testo ripulito. Controlla estensioni normalizzate sul repertorio completo e scarta anche quelle che includono un nome riconosciuto nell’altro livello. Una suggestion non crea record. La creazione richiede conferma N18 con Nome e Tipologia tramite `page1.create_anagrafica`. In assenza di match Entity il ramo autofill controllato può proporre un nome per il form.

Ambiguità, alternative plausibili B1 e prefissi Project N21/UX precedono la suggestion di estensione. Il prefisso Project sopprime anche il messaggio di assenza associativa specifico della suggestion. Il valore diagnostico `noMatch` continua a descrivere l’assenza di match canonico. La [Preview](06_LOGOS_View_Preview_System.md#guida-associazione-n21) presenta nomi e disponibilità. `requiresUserOverride` resta il segnale G22 per una suggestion di estensione con match presente. La selezione effettiva viene risolta per UUID nel warning N19.

**Snapshot G22 pre-N21.** L’esempio seguente descrive il comportamento originario di Villa Sierri. Nel dataset collaudato N21, Villa Sierri presenta Villa e varianti numerate come ambiguità canonica.

Caso guida:

20 euro villa sierri
→ select_project = Villa
→ suggestion: possibile nuovo progetto Villa Sierri
→ Conferma attiva

Classificazione finale:

- non è problema di parser
- non è problema di input_analysis_result
- non è problema di button_input_confirm.Disabled
- non è bug del payload o del save flow
- è caso match presente + suggestion extension

Soluzione consolidata:

- create_suggestion_state espone requiresUserOverride
- preview_analysis_state mostra warning mirato in Da verificare
- container Suggerimenti associazione mostra solo l’azione disponibile
- select_project resta valorizzata
- Conferma resta attiva
- suggestion ignorata non blocca il salvataggio

Esempio UI finale:

Da verificare:
Associazione progetto da controllare
Villa selezionato · testo letto: Villa Sierri

Suggerimenti associazione:
Possibile nuovo progetto: Villa Sierri
Crea progetto

Il caso simmetrico entity è gestito allo stesso modo:

20 euro mario giordano
→ select_entity = Mario
→ suggestion: possibile nuova entità Mario Giordano

Da verificare:
Associazione entità da controllare
Mario selezionata · testo letto: Mario Giordano

Suggerimenti associazione:
Possibile nuova entità: Mario Giordano
Crea entità

Decisione:

G22 è chiuso a primo livello controllato.
Non serve G10A per questo caso.

---

ENTITY CREATE

Caso tipico:

villa sierri 15 sopralluogo referente kappa

Comportamento:

- entity_state non trova match
- create_suggestion_state propone creazione entity
- input_new_entity_name può essere precompilato se candidate sicura
- utente conferma Nome e Tipologia nel form inline
- btn_create_entity_inline chiama page1.create_anagrafica, con preflight e POST insert_entity ACTIVE verificata
- a creazione confermata il form viene chiuso e Nome/Tipologia azzerati, anche con refresh fallito
- solo con refresh coerente viene selezionato il nuovo UUID
- create_suggestion_state viene ricalcolato; feedback differenziato sul refresh
- evento resta da confermare manualmente; non ripetere la POST a fronte del solo refresh fallito

---

ENTITY AUTOFILL CONTROLLED MINIMAL

Autofill entity disponibile solo in casi controllati.

Non è:

- parsing
- matching entity
- salvataggio
- creazione automatica

È solo precompilazione del campo input_new_entity_name.

Condizioni:

- entity no-match reale
- entity non ambigua
- nessuna entity già selezionata
- testo residuo pulito
- presenza di prefisso entity forte

Prefissi ammessi:

- referente
- tecnico
- cliente
- fornitore
- operaio
- collaboratore
- contatto
- responsabile
- muratore
- idraulico
- elettricista
- geometra
- architetto

Esempio positivo:

villa sierri 15 sopralluogo referente kappa
→ input_new_entity_name = Referente Kappa

Esempio negativo:

acquisto 50 euro materiale nuovo
→ input_new_entity_name vuoto

---

IGNORA GLOBALE

Il bottone Ignora globale:

- nasconde suggestion project/entity
- chiude micro-editor aperti
- svuota input_new_project_name / input_new_entity_name
- non modifica input_raw
- non modifica select_project / select_entity
- non blocca conferma

Esempio validato:

acquisto 50 euro materiale nuovo
→ Ignora
→ evento salvabile con project_id null / entity_id null

---

AMBITO NON COPERTO

Non implementa:

- command intent avanzato oltre create project/entity
- input analysis model unico
- modifica project/entity da command
- dashboard/report intent da command
- gerarchie project/entity
- alias
- deduplicazione avanzata
- filtro select su match ambigui
- Cambia / Scegli nella Sintesi realmente cliccabili
- Azioni rapide operative
- Dashboard reale
- suggestion create vs edit consistency oltre la parte base command/edit trattata in Input Context Consistency
- evoluzioni avanzate dell’override; il caso base match presente + suggestion extension è già coperto da G22
- Icon System completamente standardizzato
- polish finale font/spaziature

Nota UX Mobile Coherence Pass:

La Dashboard è presente nella navigation dock solo come voce futura disabilitata.
Le Azioni rapide sono presenti solo come predisposizione UX.
Nessuna delle due abilita output, KPI o logiche guidate avanzate.

------------------------------------------------
COMMAND INTENT — CREATE PROJECT / ENTITY
------------------------------------------------

Il Command Intent è stato implementato a primo livello controllato.

Ruolo:

distinguere input evento ordinario da comando strutturale puro.

Componenti principali:

- command_intent_state
- container_command_intent
- input_command_project_name
- input_command_entity_name
- btn_command_create_project
- btn_command_create_entity
- btn_command_go_events

Regole:

- nessun evento salvato da comando puro
- nessuna creazione automatica silenziosa
- project/entity creati solo previa conferma utente
- insert_project / insert_entity restano le query operative
- command_intent_state non modifica parser
- command_intent_state non modifica matching
- command_intent_state non modifica DB
- command_intent_state non sostituisce create_suggestion_state
- “modifica evento” è guida non operativa

Nota post UI Readiness:

ui_visibility_mode può anticipare visivamente il flow command,
ma command_intent_state resta la fonte funzionale del comando.

Dopo Input Analysis Result Controlled UI Consumption,
input_analysis_result governa la visibilità di:

- container_command_intent
- sintesi
- Dati evento

Nella tranche Controlled UI Consumption button_input_confirm era ancora fuori dalla migrazione. La successiva Visibility Migration Completion ha migrato il suo Hidden a input_analysis_result.readiness.canShowConfirm; Disabled e payload restano separati, come descritto nelle sezioni dedicate.

I comandi puri restano esclusi dal salvataggio evento.

Flussi:

crea
→ guida con esempi
→ nessun salvataggio

crea progetto
→ input_command_project_name
→ Crea progetto disabilitato finché mancano Nome o Tipologia validi, oltre alle guardie del percorso N18

crea progetto [nome]
→ riepilogo progetto e scelta Tipologia
→ btn_command_create_project: canExecute e input validi
→ page1.create_anagrafica → insert_project ACTIVE verificata e tentativo refresh
→ se creazione confermata: cleanup e feedback project_created (testo diverso se refresh fallito)
→ Home; nessun evento creato

crea entità
→ input_command_entity_name
→ Crea entità disabilitato finché mancano Nome o Tipologia validi, oltre alle guardie del percorso N18

crea entità [nome]
→ riepilogo entità e scelta Tipologia
→ btn_command_create_entity: canExecute e input validi
→ page1.create_anagrafica → insert_entity ACTIVE verificata e tentativo refresh
→ se creazione confermata: cleanup e feedback entity_created (testo diverso se refresh fallito)
→ Home; nessun evento creato

crea progetto villa
→ elemento già presente
→ nessun bottone crea
→ nessuna duplicazione

modifica evento
→ guida con step
→ btn_command_go_events
→ Lista eventi

modifica / correggi / cambia
→ guida generica non operativa
→ nessun salvataggio evento
→ nessun edit automatico

command riconosciuto durante edit mode
→ edit mode resta attivo
→ command non viene eseguito
→ button_input_confirm blocca update_event improprio
→ text_edit_mode_notice mostra guidance contestuale
→ l’utente deve annullare la modifica prima di usare comandi strutturali

Limiti:

- non è un intent engine globale
- non gestisce dashboard/report
- non gestisce modifica project/entity
- non apre edit flow evento automatico
- non unifica tutte le fonti di interpretazione
- “modifica”, “correggi”, “cambia” riconosciuti solo come guida generica non operativa
- non esiste ancora un alias system globale
- non viene gestito “modifica progetto” come command strutturale
- typo come “cea progetto” non vengono riconosciuti

------------------------------------------------
DATI EVENTO — UX MOBILE COHERENCE PASS
------------------------------------------------

Durante UX Mobile Coherence Pass, la sezione Dati evento è stata compattata.

Prima:

- label sopra ogni select
- maggiore altezza verticale

Dopo:

- label inline / affiancate alle select
- layout più compatto
- maggiore leggibilità mobile

Campi:

- Tipo evento
- Progetto
- Entità

Regola:

Dati evento resta la zona di decisione finale utente.

La Sintesi rappresenta ciò che LOGOS ha interpretato.
Dati evento contiene le fonti salvabili:

- select1.value
- select_project.value
- select_entity.value

Le select non vengono spostate nella Sintesi.

Visibilità post Input Analysis Result Visibility Migration Completion:

La sezione Dati evento è governata da:

input_analysis_result.readiness.canShowEventData

Gli Hidden principali collegati al flow input leggono ora input_analysis_result.

Regola:

- visibile nel flow evento
- visibile nel flow edit con input valorizzato
- nascosta nel flow command
- nascosta quando edit mode ha input vuoto
- nascosta quando input flow non è pronto

CONFERMA EVENTO

Il normale pulsante delega il solo begin a confirm_event. Non costruisce il payload e non persiste. Hidden legge canShowConfirm; Disabled combina readiness canonica, isFetching e validità delle due scelte contestuali correnti, come nella configurazione integrale di Architecture.

confirm_event cattura lo snapshot completo corrente e il fingerprint, verifica le scelte necessarie, costruisce il solo payload e preserva command/no-op/preflight/lock. ACTIVE ordinario e FK storica identica prevalgono; un INACTIVE univoco ammesso richiede scelta esplicita. Non collegare restituisce null per quella nuova associazione; non cancella le altre FK valide. NULL e ambiguità non sono eccezioni ammesse.

L’invio precede reset e feedback. Fallimento o esito non verificato non autorizzano retry automatici. Dopo salvataggio risolto: reset input/Select, feedback, refresh events_new, reset helper edit e ritorno contestuale dopo 1800 ms sotto epoch. La fonte integrale unica di questa logica è il [Lifecycle](03_LOGOS_Event_Lifecycle.md#q2-source-confirm-event-query). Nessun Success handler UI duplicato sugli endpoint.

I seguenti estratti del vecchio Click rimangono soltanto come snapshot storico del flusso precedente a Q2; non rappresentano l’implementazione corrente e non vanno ricopiati sopra il coordinatore.



BUTTON_INPUT_CONFIRM — FLOW FINALE

Estratti logici storici del save flow, conservati dalla baseline precedente a N18. Non costituiscono una trascrizione completa e aggiornata di button_input_confirm: le integrazioni successive (EDIT MODE COMMAND GUARD, feedback_summary e routing) sono descritte nelle note e nelle sezioni dedicate. N18 non modifica il salvataggio evento.

```js
// --- INSERT / UPDATE SWITCH ---
const parsed = ui_state.value?.parsed || {};

const payload = {
  raw_input: input_raw.value,
  type: select1.value || "Evento",
  amount: parsed.amount,
  unit: parsed.unit,
  event_date: parsed.event_date,
  project_id: select_project.value || null,
  entity_id: select_entity.value || null
};

// --- NO-OP EDIT GUARD ---
// Se siamo in edit mode ma il payload non cambia nulla,
// non eseguiamo update_event e non aggiorniamo updated_at.

const wasEditMode = edit_mode.data;
const originalEvent = editing_event.data;
```

Nota post Input Context Consistency:

Prima del no-op edit guard è stata introdotta una guard locale:

- EDIT MODE COMMAND GUARD

Scopo:

evitare che input command-like riconosciuti diventino update_event.

Esempi bloccati in edit mode:

- modifica
- correggi
- cambia
- crea progetto test
- crea entità test

La guard non modifica payload.
La guard non modifica button_input_confirm.Disabled.
La guard non modifica insert_event/update_event.
La guard impedisce solo l’esecuzione di update_event quando il command riconosciuto è fresco e coerente con l’input corrente.

```js
const normalizeComparable = (value) => {
  if (value === undefined || value === "") return null;
  return value;
};

const sameText =
  String(normalizeComparable(payload.raw_input) || "") ===
  String(normalizeComparable(originalEvent?.raw_input) || "");

const sameType =
  String(normalizeComparable(payload.type) || "Evento") ===
  String(normalizeComparable(originalEvent?.type) || "Evento");

const sameProject =
  String(normalizeComparable(payload.project_id) || "") ===
  String(normalizeComparable(originalEvent?.project_id) || "");

const sameEntity =
  String(normalizeComparable(payload.entity_id) || "") ===
  String(normalizeComparable(originalEvent?.entity_id) || "");

const isSamePayload =
  wasEditMode &&
  originalEvent &&
  sameText &&
  sameType &&
  sameProject &&
  sameEntity;

if (isSamePayload) {
  if (window.__parseTimer) {
    clearTimeout(window.__parseTimer);
    window.__parseTimer = null;
  }

  trigger_parse_debounced.cancel?.();

  window.__logos_edit_mode_value = false;
  await edit_mode.trigger();

  window.__logos_editing_event_value = null;
  await editing_event.trigger();

  await input_home.setValue("");
  await input_raw.setValue("");

  select_project.clearValue();
  select_entity.clearValue();
  select1.clearValue?.();

  ui_state.setValue({
    ...ui_state.value,
    view: "events",
    parsed: {
      amount: null,
      unit: null,
      event_date: null
    },
    status: "idle",
    feedback_text: null,
    feedback_project: null
  });

  container_input.setHidden(true);
  container_home.setHidden(true);
  container_feedback.setHidden(true);
  container_events_list.setHidden(false);

  return;
}

const feedbackText = input_raw.value;
const feedbackProject = select_project.selectedItem?.name;

ui_state.setValue({
  ...ui_state.value,
  parsed: {
    amount: null,
    unit: null,
    event_date: null
  },
  status: "idle",
  view: "feedback",
  feedback_text: feedbackText,
  feedback_project: feedbackProject
});

input_home.setValue("");
input_raw.setValue("");

select_project.clearValue();
select_entity.clearValue();

trigger_parse_debounced.cancel?.();

const savePromise = wasEditMode
  ? update_event.trigger({ additionalScope: payload })
  : insert_event.trigger({ additionalScope: payload });

await savePromise;

await events_new.trigger();

if (wasEditMode) {
  window.__logos_edit_mode_value = false;
  await edit_mode.trigger();

  window.__logos_editing_event_value = null;
  await editing_event.trigger();
}

```

Aggiornamento UX Mobile Coherence Pass:

Il codice runtime effettivo di button_input_confirm è stato aggiornato per:

- creare feedbackSummary prima del reset input/select
- mostrare il feedback come ultimo stato UI visibile
- centralizzare feedback e routing post-save
- evitare conflitti con handle_event_success
- gestire insert reale → feedback → Home
- gestire update reale → feedback → Lista eventi
- gestire no-op edit → Lista eventi senza feedback
- azzerare feedback_summary dopo auto-return

Regola:

Gli estratti precedenti descrivono la fase storica pre-Q2 e non sono script da copiare. Le invarianti tuttora valide restano tali; fonti, builder e wiring correnti sono il contratto Q2 e i sorgenti integrali finali nelle rispettive madri.
Il feedback_summary è solo UI temporanea e non viene salvato nel DB.

Risultato:

✔ parsing duplicato rimosso
✔ insert/update correnti ricevono i dati parsati da snapshot.parsed nel coordinatore unico
✔ insert/update salvano type da select1.value
✔ feedback immediato
✔ lista eventi aggiornata dopo save reale
✔ update visibile senza refresh pagina
✔ no-op edit guard attivo
✔ edit senza modifiche reali non esegue update_event
✔ updated_at non cambia su edit no-op
✔ edit_mode reset senza additionalScope { value }
✔ editing_event reset senza additionalScope { value }
✔ editing_event azzerato anche dopo update reale completato
✔ linting edit_mode / editing_event risolti

Nota Match Engine:

confirm_event costruisce il payload da fonti controllate: snapshot.parsed; select1 e input_raw vincolati al contesto; finalAssociationId per le due FK. Il normale pulsante delega soltanto begin.

Non ricalcola parsing.
Non ricalcola matching.
Non legge la preview come fonte dati.

------------------------------------------------
FEEDBACK SYSTEM — UX MOBILE COHERENCE PASS
------------------------------------------------

Il feedback post-salvataggio è stato stabilizzato.

Struttura:

- container_feedback
- feedback_mode
- feedback_text
- feedback_project
- feedback_summary

feedback_summary contiene:

- type
- date
- amount
- project
- entity
- text

Regole:

- creato prima del reset input/select
- visibile solo nel feedback mobile
- non salvato nel DB
- non modifica payload
- azzerato dopo auto-return

Comportamento:

INSERT reale:

button_input_confirm
→ feedback_summary
→ insert_event
→ events_new refresh
→ feedback 1800 ms
→ Home

UPDATE reale:

button_input_confirm
→ feedback_summary
→ update_event
→ events_new refresh
→ feedback 1800 ms
→ Lista eventi

NO-OP EDIT:

button_input_confirm
→ no-op edit guard
→ nessun update_event
→ nessun feedback
→ Lista eventi immediata

Decisione:

Il feedback è una toast-card temporanea,
non una pagina finale bloccante.

COMMAND CREATE PROJECT:

btn_command_create_project
→ page1.create_anagrafica con Nome/Tipologia e guardie Command Intent
→ POST insert_project ACTIVE verificata e tentativo refresh
→ creazione confermata: cleanup input/Select e feedback_mode = project_created
→ feedback_summary strutturale, con testo di ricarica se refresh fallito
→ stato feedback prima del container, micro-tick 0, feedback 1800 ms → Home

COMMAND CREATE ENTITY:

btn_command_create_entity
→ page1.create_anagrafica con Nome/Tipologia e guardie Command Intent
→ POST insert_entity ACTIVE verificata e tentativo refresh
→ creazione confermata: cleanup input/Select e feedback_mode = entity_created
→ feedback_summary strutturale, con testo di ricarica se refresh fallito
→ stato feedback prima del container, micro-tick 0, feedback 1800 ms → Home

Feedback strutturale:

Evento salvato:
- titolo Evento salvato
- riepilogo evento

Progetto creato:
- titolo Progetto creato
- riepilogo progetto

Entità creata:
- titolo Entità creata
- riepilogo entità

FEEDBACK PROJECT / ENTITY — TIMING ALIGNMENT POST UI READINESS

Nel nodo UI Readiness sono stati allineati:

- btn_command_create_project
- btn_command_create_entity

Pattern:

1. preparare nextFeedbackState
2. await ui_state.setValue(nextFeedbackState)
3. micro-tick setTimeout 0
4. mostrare container_feedback

Scopo:

- allineare project/entity
- preparare feedback_mode e feedback_summary prima della visibilità feedback
- ridurre differenze di timing

Esito:

✔ feedback project/entity funzionante
✔ ritorno Home automatico confermato
⚠ micro-flash feedback project/entity ancora presente come residuo minore

Nota post Linting / Retool Query Safety Pass:

handle_event_success è stato eliminato perché Retool lo segnalava come query unused
e la gestione feedback/routing del salvataggio evento è centralizzata in confirm_event, invocato dal normale pulsante.

Test post-rimozione superati.

INSERT FLOW

Trigger:

insert_event

Payload:

raw_input
type
amount
unit
event_date
project_id
entity_id
status: NEW
updated_at
payload: {}

Caratteristiche:

✔ insert ammesso soltanto con snapshot/readiness, decisioni richieste e controlli finali conformi; nessuna associazione è obbligatoria in sé
✔ le protezioni DB lifecycle/accesso documentate nelle madri hanno un ruolo distinto dalle guardie UI
✔ nessuna label persistita
✔ amount coerente con snapshot.parsed catturato e validato
✔ unit coerente con snapshot.parsed catturato e validato
✔ raw_input preservato
✔ type salvato in events.type
✔ project_id risolto da finalAssociationId("project") nel coordinatore
✔ entity_id risolto da finalAssociationId("entity") nel coordinatore
✔ project/entity creati inline salvabili solo dopo selezione confermata
✔ evento salvabile con project_id/entity_id null se l’utente ignora suggestion

Test validati:

2h30 rendering
→ type Tempo
→ amount 150
→ unit minuti
→ status NEW

20 euro spesa materiale
→ type Spesa
→ amount 20
→ unit euro
→ status NEW

20 euro incasso cliente
→ type Incasso
→ amount 20
→ unit euro
→ status NEW

20 euro materiale
→ type Evento
→ amount 20
→ unit euro
→ status NEW

villa 2 mario
→ type Evento
→ amount null
→ unit null
→ status NEW

Project / Entity Create Suggestion — insert evento validato:

villa sierri 15 sopralluogo referente kappa
→ project creato inline: Villa Sierri 15
→ entity creata inline: Referente Kappa
→ evento confermato manualmente
→ project_id valorizzato
→ entity_id valorizzato
→ status NEW

acquisto 50 euro materiale nuovo
→ suggestion ignorata
→ project_id null
→ entity_id null
→ type Spesa
→ amount 50
→ unit euro
→ status NEW

UPDATE FLOW

Trigger:

update_event

Utilizzato quando:

edit_mode = true

Payload:

raw_input
type
amount
unit
event_date
project_id
entity_id
updated_at

Caratteristiche:

✔ modifica eventi NEW
✔ status invariato
✔ dati aggiornati correttamente in DB
✔ type aggiornato correttamente in DB
✔ lista eventi aggiornata dopo salvataggio completato
✔ no-op edit guard evita update_event se non cambia nulla
✔ updated_at non cambia su edit senza modifiche reali
✔ edit_mode / editing_event vengono azzerati al termine del flow edit
✔ reset helper edit flow senza additionalScope { value }

Test validato:

Evento precedente senza type valorizzato
modificato in:

1 ora e 45 minuti lavoro

DB:

type Tempo
amount 105
unit minuti
raw_input aggiornato
updated_at aggiornato
status NEW

Problema risolto:

Prima:

events_new veniva aggiornato prima del completamento update_event.

Risultato:

DB corretto
lista momentaneamente vecchia
fix visibile solo dopo refresh pagina

Dopo:

await savePromise
→ await events_new.trigger()

Risultato:

✔ lista aggiornata subito
✔ nessun refresh pagina necessario

------------------------------------------------
ANNULLA MODIFICA
------------------------------------------------

Componente:

btn_cancel_edit

Ruolo:

uscire dalla modifica evento NEW senza salvare.

Disponibile solo se:

edit_mode.data = true

Comportamento:

- cancella eventuale debounce pendente
- imposta window.__logos_edit_mode_value = false
- rilancia edit_mode
- imposta window.__logos_editing_event_value = null
- rilancia editing_event
- resetta input_home
- resetta input_raw
- pulisce select_project
- pulisce select_entity
- pulisce select1
- resetta ui_state.parsed
- imposta ui_state.view = "events"
- torna alla lista eventi
- non esegue update_event
- non aggiorna updated_at

Codice helper:

```js
window.__logos_edit_mode_value = false;
await edit_mode.trigger();

window.__logos_editing_event_value = null;
await editing_event.trigger();
```

Risultato:

✔ annulla modifica senza salvare
✔ nessun update_event
✔ updated_at invariato
✔ edit_mode false
✔ editing_event null
✔ ritorno lista eventi
✔ linting helper non reintrodotto

LISTA EVENTI — SEARCH / FILTER / LABEL

Componenti:

input_events_search
list_events

Ruolo:

migliorare la gestione degli eventi NEW in processing.

Filtro:

input_events_search filtra client-side la lista eventi.

Campi ricercati:

raw_input
type
status
nome progetto
nome entità

Label lista eventi:

La lista distingue:

creato
modificato

Regole:

created_at / updated_at normalizzati in modo robusto
date DB trattate coerentemente come UTC
updated_at vicino a created_at non viene considerato modifica reale
evento mai modificato → creato
evento modificato realmente → modificato
edit annullato → label invariata
edit no-op → label invariata
edit reale → label modificato

Nota:

search/filter e label lista sono processing UX.

Non modificano:

parser
matching
type
duration
DB schema
lifecycle evento

GESTIONE ERRORI

✔ errori UI gestiti tramite feedback state
✔ nessun blocco runtime
✔ parsing non blocca
✔ input resta modificabile

TIPI:

parsing error
match error
input ambiguo
save error
update error
insert_project error
insert_entity error
duplicato project/entity
duplicato project/entity da command intent
comando generico incompleto
command intent non eseguibile
micro-flash feedback project/entity
eventuali linting Retool futuri
alias edit generico riconosciuto come guida non operativa
command riconosciuto durante edit mode
candidate suggestion non sicura

COMPORTAMENTO:

✔ NON bloccare input
✔ NON interrompere UX inutilmente
✔ mostrare feedback implicito o toaster Retool
✔ preservare possibilità di correzione
✔ bloccare insert_project / insert_entity se nome mancante
✔ bloccare insert_project / insert_entity se duplicato frontend rilevato
✔ mostrare warning duplicato senza scrivere DB
✔ lasciare evento non salvato finché l’utente non conferma
✔ non mostrare bottone crea se l’elemento esiste già
✔ guidare l’utente se il comando è incompleto
✔ non salvare eventi se l’input è comando puro
✔ non aggiornare eventi se in edit mode l’input è un command riconosciuto
✔ mostrare warning e lasciare l’utente in edit mode
✔ non trattare ui_visibility_state come fonte dati salvabile
✔ non trattare input_analysis_result come fonte payload save
✔ correggere linting solo in nodi tecnici dedicati
✔ non inseguire micro-flash dentro nodi non dedicati

TEST VALIDATI

UX MOBILE COHERENCE PASS:

1. Nuovo evento → Conferma evento

Esito:

- insert_event eseguito
- feedback visibile
- feedback_summary mostrato
- events_new aggiornato
- dopo 1800 ms ritorno Home

RISULTATO:
OK

---

2. Lista eventi → Modifica → modifica reale → Conferma evento

Esito:

- update_event eseguito
- feedback visibile
- events_new aggiornato
- dopo 1800 ms ritorno Lista eventi

RISULTATO:
OK

---

3. Lista eventi → Modifica → nessuna modifica → Conferma evento

Esito:

- update_event non eseguito
- feedback non mostrato
- ritorno immediato Lista eventi
- updated_at invariato

RISULTATO:
OK

---

4. Home → scrivi input → Torna alla home

Esito:

- nessun insert_event
- input_home svuotato
- input_raw svuotato
- select resettate
- ui_state.parsed resettato
- feedback_summary azzerato
- ritorno Home

RISULTATO:
OK

---

5. Lista eventi → Modifica → Annulla modifica

Esito:

- nessun update_event
- edit_mode false
- editing_event null
- input/select resettati
- feedback_summary azzerato
- ritorno Lista eventi

RISULTATO:
OK

---

6. iPhone 13 Safari reale

Problemi iniziali:

- zoom automatico su tap input
- troncamento laterale interfaccia
- select non pienamente utilizzabili come dropdown

Fix:

- font-size 16px su input/select principali

Esito:

- nessuno zoom automatico
- layout mobile stabile
- select Tipo / Progetto / Entità funzionanti sia in digitazione sia in dropdown

RISULTATO:
OK

COMMAND INTENT — TEST VALIDATI:

1. Comando generico

crea

Esito:

- Comando rilevato
- esempi leggibili
- nessuna Sintesi evento
- nessun Dati evento
- nessun evento salvato

RISULTATO:
OK

---

2. Create project incompleto

crea progetto

Esito:

- card command visibile
- input nome progetto visibile
- bottone Crea progetto disabilitato a campo vuoto
- nessun evento salvato

RISULTATO:
OK

---

3. Create project completo

crea progetto Command Final Project 2

Esito:

- project creato tramite insert_project
- feedback Progetto creato
- ritorno Home automatico
- nessun evento salvato

RISULTATO:
OK

---

4. Create entity incompleto

crea entità

Esito:

- card command visibile
- input nome entità visibile
- bottone Crea entità disabilitato a campo vuoto
- nessun evento salvato

RISULTATO:
OK

---

5. Create entity completo

crea entità Command Final Entity 2

Esito:

- entity creata tramite insert_entity
- feedback Entità creata
- ritorno Home automatico
- nessun evento salvato

RISULTATO:
OK

---

6. Elemento già presente

crea progetto villa

Esito:

- elemento già presente riconosciuto
- nessun bottone crea
- nessuna duplicazione
- nessun evento salvato

RISULTATO:
OK

---

7. Guida modifica evento

modifica evento

Esito:

- guida mostrata
- CTA Vai agli eventi funzionante
- lista eventi aperta
- nessuna modifica automatica
- nessun evento salvato

RISULTATO:
OK

---

8. Evento normale non regressivo

30 euro spesa villa citrignano

Esito:

- command intent non interferisce
- flow evento ordinario mostrato
- Conferma evento salva evento NEW
- feedback evento corretto
- ritorno Home automatico

RISULTATO:
OK

---

9. Edit evento reale non regressivo

Esito:

- update_event eseguito
- feedback evento corretto
- ritorno Lista eventi
- evento marcato come modificato

RISULTATO:
OK

---

10. Edit no-op / annulla modifica non regressivo

Esito:

- nessun update_event se non ci sono modifiche reali
- updated_at non alterato
- ritorno Lista eventi

RISULTATO:
OK

UI READINESS / VISIBILITY AGGREGATOR — TEST VALIDATI:

1. Evento normale

30 euro spesa villa citrignano

Risultato:

- flow evento ordinario mostrato
- Sintesi visibile
- Dati evento visibili
- Conferma evento disponibile

RISULTATO:
OK

---

2. Comando generico

crea

Risultato:

- container_command_intent visibile
- Sintesi nascosta
- Dati evento nascosti
- Conferma evento nascosta

RISULTATO:
OK

---

3. Create project incompleto

crea progetto

RISULTATO:
OK

---

4. Create project completo

crea progetto Nome Test

RISULTATO:
OK

---

5. Create entity incompleto

crea entità

RISULTATO:
OK

---

6. Create entity completo

crea entità Nome Test

RISULTATO:
OK

---

7. Elemento già presente

crea progetto villa

RISULTATO:
OK

---

8. Guida edit

modifica evento

RISULTATO:
OK

---

9. Suggestion project/entity da evento normale

RISULTATO:
OK

---

10. Edit evento reale

RISULTATO:
OK

---

11. Edit no-op

RISULTATO:
OK

---

12. Annulla edit

RISULTATO:
OK

---

13. Feedback evento

RISULTATO:
OK

---

14. Feedback project/entity

RISULTATO:
OK con micro-flash residuo non bloccante

---

15. Events list

RISULTATO:
OK

---

16. Home vuota + navigation dock

RISULTATO:
OK

---

Validazioni finali:

✔ container vuoto durante digitazione risolto
✔ bottom bar flash risolto
✔ edit mode chiarito
✔ Command Intent preservato
✔ create/edit/feedback/lista non regressivi
✔ DB invariato
✔ parser invariato
✔ matching invariato
✔ save flow invariato

INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS — TEST VALIDATI:

1. Evento normale

30 euro spesa materiale

Esito:

- Sintesi visibile
- Dati evento visibili
- select visibili
- command container nascosto

RISULTATO:
OK

---

2. Euro senza direzione

30 euro materiale

Esito:

- warning “Definisci spesa o incasso”
- Dati evento visibili
- salvataggio ancora consentito se non ci sono blocchi matching

RISULTATO:
OK

---

3. Durata normalizzata

1 ora e 15 minuti lavoro

Esito:

- amount 75
- unit minuti
- type Tempo
- hint Normalizzato: 75 minuti
- input_analysis_result readiness coerente

RISULTATO:
OK

---

4. Ambiguità entity

30 euro cliente test

Esito:

- entity ambigua
- hint “Più entità trovate”
- canConfirm false
- Sintesi e Dati evento visibili

RISULTATO:
OK

---

5. Command puro

crea progetto Nome Test

Esito:

- effectiveFlowType command
- container_command_intent visibile
- Sintesi nascosta
- Dati evento nascosti
- project/entity raw ignorati come dati evento

RISULTATO:
OK

---

6. Edit mode + input crea

Esito:

- raw command true
- command effective false
- edit mode prevale
- container_command_intent nascosto
- event flow preservato
- residuo UX guidance tracciato

RISULTATO:
OK

---

7. Edit mode + input vuoto

Esito:

- Sintesi nascosta
- Dati evento nascosti
- Conferma nascosta
- Home idle container nascosti
- Annulla modifica visibile

RISULTATO:
OK

---

8. Suggestion container

Esito:

- container_association_suggestions governato da input_analysis_result
- non appare vuoto
- la notice associazioni mancanti non promette suggerimenti se non sono visibili

RISULTATO:
OK

---

Validazioni finali:

✔ preview_analysis_state operativo
✔ input_analysis_result operativo come fonte UI parziale
✔ in quella fase ui_visibility_state era ancora operativo e non deprecato; stato successivamente superato da Visibility Migration Completion, che lo ha riclassificato come residuo tecnico deprecabile / rollback
✔ parser invariato
✔ matching invariato
✔ create_suggestion_state invariato
✔ command_intent_state invariato
✔ save flow invariato
✔ DB invariato

INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION — TEST VALIDATI:

Micro-batch 1:

- Home vuota
- 20 euro villa
- 2h30 rendering lavoro
- acquisto 120 euro aspri allevamento aspri
- mario sopralluogo villa 2
- selezione manuale Mario Rossi
- 20 euro villa borghese
- Ignora suggerimenti
- crea
- crea progetto Nome Test
- edit input pieno
- edit input vuoto

Esito:

✔ container_input.Hidden migrato
✔ text_input_analysis_loading.Hidden migrato
✔ btn_cancel_edit.Hidden migrato
✔ btn_cancel_input_home.Hidden migrato
✔ edit input vuoto stabile
✔ Annulla modifica resta visibile
✔ command flow preservato
✔ event flow preservato
✔ suggestion flow preservato

Micro-batch 2:

- Home vuota
- 20 euro villa
- 2h30 rendering lavoro
- crea
- crea progetto Nome Test
- mario sopralluogo villa 2
- edit input pieno
- edit input vuoto

Esito:

✔ button_input_confirm.Hidden migrato
✔ canShowConfirm introdotto come visibility-only
✔ button_input_confirm.Disabled invariato
✔ button_input_confirm payload invariato
✔ command flow non mostra Conferma
✔ edit input vuoto non mostra Conferma
✔ evento/edit input pieno mostrano Conferma

Smoke test finale post rimozione dipendenza ui_visibility_state:

- Home vuota
- 20 euro villa
- crea
- edit input vuoto

Esito:

✔ input_analysis_result non dipende più da ui_visibility_state
✔ graph Retool confermato
✔ nessuna regressione osservata

Note:

- label “Importo” su durata rilevata come bug semantico preesistente
- policy match più specifici confermata non bloccante
- nav nascosta in edit mode confermata coerente

LINTING / RETOOL QUERY SAFETY PASS — TEST VALIDATI:

Interventi:

- risolti linting “Misleading line break before ?”
- sostituiti ternari multilinea ambigui con if / else equivalenti
- corretti:
  - input_analysis_result
  - preview_analysis_state
  - create_suggestion_state
  - command_intent_state
- eliminata query legacy typing_state
- eliminata query legacy handle_event_success

Esito:

✔ linting Retool azzerati
✔ Performance unused query risolta
✔ evento normale validato
✔ command flow validato
✔ edit flow validato
✔ feedback/routing post-save validato
✔ no regressione visibility
✔ no regressione confirm
✔ no regressione command intent
✔ DB invariato
✔ parser invariato
✔ matching invariato
✔ save flow invariato
✔ payload invariato

------------------------------------------------

PARSER / PREVIEW:

18min test
→ parsed: amount 18, unit minuti
→ preview: 18 minuti • test

18 minuti test
→ parsed: amount 18, unit minuti
→ preview: 18 minuti • test

1ora lavoro
→ parsed: amount 60, unit minuti
→ preview: 1 ora
→ hint: Normalizzato: 60 minuti

1 ora lavoro
→ parsed: amount 60, unit minuti
→ preview: 1 ora • lavoro
→ hint: Normalizzato: 60 minuti

2 ore sopralluogo villa 2
→ parsed: amount 120, unit minuti
→ preview: 2 ore • sopralluogo villa 2
→ hint: Normalizzato: 120 minuti

1,5 ore sopralluogo
→ parsed: amount 90, unit minuti
→ preview: 1 ora 30 minuti • sopralluogo
→ hint: Normalizzato: 90 minuti

1.5 ore sopralluogo
→ parsed: amount 90, unit minuti
→ preview: 1 ora 30 minuti • sopralluogo
→ hint: Normalizzato: 90 minuti

1 ora e 15 minuti sopralluogo
→ parsed: amount 75, unit minuti
→ preview: 1 ora 15 minuti • sopralluogo
→ hint: Normalizzato: 75 minuti

2h30 rendering
→ parsed: amount 150, unit minuti
→ preview: 2 ore 30 minuti • rendering
→ hint: Normalizzato: 150 minuti

2 h 30 rendering
→ parsed: amount 150, unit minuti
→ preview: 2 ore 30 minuti • rendering
→ hint: Normalizzato: 150 minuti

2 ore 30 rendering
→ parsed: amount 150, unit minuti
→ preview: 2 ore 30 minuti • rendering
→ hint: Normalizzato: 150 minuti

90 minuti rendering
→ parsed: amount 90, unit minuti
→ preview: 90 minuti • rendering

20€ materiale
→ parsed: amount 20, unit euro

villa 2 mario
→ parsed: amount null, unit null
→ preview: villa 2 mario

458,78 euro mangime
→ parsed: amount 458.78, unit euro

1.500 euro materiale
→ parsed: amount 1500, unit euro

1.500,50 euro materiale
→ parsed: amount 1500.5, unit euro

2 giorni rendering
→ parsed: amount null, unit null
→ preview: 2 giorni rendering
→ hint: Durata ambigua

1 settimana lavoro
→ parsed: amount null, unit null
→ preview: 1 settimana lavoro
→ hint: Durata ambigua

INSERT:

1.500,50 euro test engine
→ amount 1500.5
→ unit euro
→ status NEW

INSERT DOPO RIMOZIONE PARSING LEGACY:

1.500,50 euro test engine 2
→ amount 1500.5
→ unit euro
→ status NEW

UPDATE:

1,5 ore test engine update
→ amount 1.5
→ unit ore
→ status NEW

UPDATE LISTA:

update_event
→ await save
→ events_new refresh
→ lista aggiornata subito

DURATION NORMALIZATION — INSERT:

1 ora e 15 minuti test duration
→ amount 75
→ unit minuti
→ raw_input preservato
→ status NEW

2h30 test duration
→ amount 150
→ unit minuti
→ raw_input preservato
→ status NEW

1,5 ore test duration
→ amount 90
→ unit minuti
→ raw_input preservato
→ status NEW

2 giorni test duration
→ amount null
→ unit null
→ raw_input preservato
→ status NEW

DURATION NORMALIZATION — UPDATE:

2 ore e 30 minuti test duration update
→ amount 150
→ unit minuti
→ raw_input aggiornato
→ status NEW

1 ora e 45 minuti regressione finale update
→ amount 105
→ unit minuti
→ raw_input aggiornato
→ status NEW

DURATION NORMALIZATION — REGRESSIONI:

30 euro regressione finale
→ amount 30
→ unit euro
→ status NEW

villa 2 test duration
→ amount null
→ unit null
→ raw_input preservato
→ status NEW

TYPE CLASSIFICATION BASE — ANTEPRIMA:

2h30 rendering
→ select1 Tempo

1 ora lavoro
→ select1 Tempo

18min test
→ select1 Tempo

20 euro spesa materiale
→ select1 Spesa

20 euro acquisto materiale
→ select1 Spesa

20 euro pagato materiale
→ select1 Spesa

20 euro incasso cliente
→ select1 Incasso

20 euro vendita cucciolo
→ select1 Incasso

20 euro acconto ricevuto
→ select1 Incasso

20 euro acconto dato
→ select1 Spesa

20 euro acconto
→ select1 Evento

20 euro materiale
→ select1 Evento

20 euro spesa incasso
→ select1 Evento

villa 2 mario
→ select1 Evento

2 giorni rendering
→ select1 Evento

4 aprile benzina 50 euro alfie allevamento aspri
→ select1 Evento

TYPE CLASSIFICATION BASE — INSERT DB:

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

TYPE CLASSIFICATION BASE — UPDATE DB:

1 ora e 45 minuti lavoro
→ type Tempo
→ amount 105
→ unit minuti
→ updated_at aggiornato

TYPE CLASSIFICATION BASE — OVERRIDE MANUALE:

20 euro materiale + select1 manuale Spesa
→ DB type Spesa

20 euro materiale + select1 manuale Incasso
→ DB type Incasso

TYPE CLASSIFICATION BASE — RESET / STALE VALUE:

20 euro materiale
→ select1 manuale Spesa
→ conferma
→ nuovo input villa 2 mario
→ select1 Evento

Esito:

nessuna modifica necessaria al reset select1.

PREVIEW ALIGNMENT BASE:

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

Nota:

il vecchio hint "Verifica durata" è stato superato
dal nodo Duration Normalization Base.

Ora la preview mostra:

- forma umana della durata
- hint "Normalizzato: X minuti"
- hint durata ambigua per giorni/settimane

MATCH ENGINE UNIFICATION — TEST VALIDATI:

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

€500 acconto alfie mario rossi
→ 500,00 € • acconto alfie mario rossi
→ entity ambigua

UX / CLEANUP MICRO-BATCH — TEST VALIDATI:

Create nuovo evento
→ OK

Edit evento
→ OK

Annulla modifica
→ nessun update_event
→ updated_at invariato
→ ritorno lista eventi
→ edit_mode false
→ editing_event null
→ OK

Edit senza modifiche reali
→ no-op edit guard attivo
→ nessun update_event
→ updated_at invariato
→ label creato/modificato invariata
→ ritorno lista eventi
→ OK

Edit con modifica reale
→ update_event eseguito
→ updated_at aggiornato
→ events_new refresh dopo save
→ label modificato coerente
→ edit_mode reset
→ editing_event reset
→ OK

Lista eventi search/filter
→ campo vuoto mostra lista completa
→ filtro raw_input funzionante
→ filtro type/status funzionante
→ filtro project/entity funzionante
→ edit da lista filtrata funzionante
→ WRITTEN / ERROR invariati
→ OK

LINTING / STATE HELPER CLEANUP — TEST VALIDATI:

Linting edit_mode
→ edit_mode: 'value' is not defined non più presente
→ OK

Linting editing_event
→ editing_event: 'value' is not defined non più presente
→ OK

Create flow
→ OK

Edit flow
→ OK

Annulla modifica
→ OK

Edit senza modifiche reali
→ OK

Edit con modifica reale
→ OK

updated_at / label creato-modificato
→ OK

WRITTEN / ERROR
→ OK

Regressioni:
- DB invariato
- parser invariato
- Match Engine invariato
- Type Classification invariata
- Duration Normalization invariata
- preview invariata
- lista eventi invariata

Esito:
OK

PROJECT / ENTITY CREATE SUGGESTION — TEST VALIDATI:

Project create:

villa sierri 6 sopralluogo
→ suggestion project Villa Sierri 6
→ insert_project eseguito previa conferma
→ select_project valorizzata
→ evento non salvato automaticamente

villa sierri 7 sopralluogo
→ suggestion project Villa Sierri 7
→ project creato
→ select_project valorizzata
→ evento salvato manualmente con project_id corretto

Entity create:

villa sierri 7 sopralluogo
→ project Villa Sierri 7 riconosciuto
→ nessuna entità associata
→ Crea entità visibile
→ Tecnico Sierri 4 creato inline
→ select_entity valorizzata
→ evento salvato manualmente con entity_id corretto

Flow combinato:

villa sierri 15 sopralluogo referente kappa
→ project Villa Sierri 15 creato inline
→ entity Referente Kappa creata inline
→ evento confermato manualmente
→ DB con project_id + entity_id corretti

No-match generico:

acquisto 50 euro materiale nuovo
→ type Spesa
→ amount 50
→ unit euro
→ suggestion project/entity visibile
→ Ignora
→ evento salvato con project_id null / entity_id null

Ambiguità entity:

alfie mario rossi
→ più entità trovate
→ Crea entità non visibile
→ Conferma disabilitata
→ dopo selezione manuale entity, Conferma abilitata

Entity autofill:

villa sierri 15 sopralluogo referente kappa
→ Crea entità
→ input_new_entity_name precompilato Referente Kappa

acquisto 50 euro materiale nuovo
→ Crea entità
→ input_new_entity_name vuoto

Edit/no-op regression:

edit evento esistente senza modifiche
→ no update_event
→ updated_at invariato
→ suggestion non regressiva

BUTTON CONFIRM READINESS ALIGNMENT — TEST VALIDATI:

Obiettivo:

verificare e allineare la readiness funzionale del bottone Conferma,
distinguendo:

- visibilità del bottone
- abilitazione / disabilitazione
- blocchi reali
- warning non bloccanti
- command intent esclusi dal save flow evento

Modifica applicata:

button_input_confirm.Disabled è stato aggiornato per leggere solo:

- project_state.data?.isAmbiguous
- entity_state.data?.isAmbiguous

È stato rimosso il fallback grezzo:

- matches.length > 1

Test AS-IS pre-fix:

20 euro materiale
→ Conferma attiva

20 euro spesa materiale
→ Conferma attiva

2h30 rendering lavoro
→ Conferma attiva

20 euro attività generica
→ Conferma attiva
→ rilevato possibile falso positivo matching GENERIC fuori nodo

20 euro villa
→ Conferma attiva
→ hint progetti più specifici non bloccante

20 euro mario
→ Conferma attiva
→ hint entità più specifiche non bloccante

crea
→ Conferma evento nascosta

crea progetto test
→ Conferma evento nascosta

crea entità test
→ Conferma evento nascosta

edit evento NEW con input pieno
→ Conferma attiva

edit evento NEW con input vuoto
→ Conferma non mostrata

edit no-op
→ nessun update_event
→ comportamento invariato

Test mirati su dati reali:

20 euro villa sierri
→ select_project valorizzata su Villa
→ suggestion: possibile nuovo progetto Villa Sierri
→ Conferma attiva

20 euro cucciolata marzo
→ nessun blocco
→ Conferma attiva

20 euro tecnico
→ nessun blocco
→ Conferma attiva

20 euro cliente
→ nessun blocco
→ Conferma attiva

Test post-fix:

20 euro materiale
→ Conferma visibile e attiva

20 euro villa
→ Conferma attiva con warning non bloccante

20 euro villa sierri
→ Conferma attiva
→ rischio match generico osservato fuori nodo

crea progetto test
→ container command visibile
→ Conferma evento non mostrata

Esito:

- nessuna regressione evento ordinario
- nessuna regressione warning non bloccanti
- nessuna regressione match più specifici
- nessuna regressione command intent
- nessuna regressione edit flow osservata
- payload invariato
- insert_event invariato
- update_event invariato
- DB invariato
- Supabase invariato

Classificazione:

G33 completato.

Nota fuori nodo:

Il rischio match generico / auto-select confidence non appartiene a G33.
Va assorbito in G22 Project Create Suggestion — Match Present / User Override.

PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE — TEST VALIDATI:

Obiettivo:

validare G22 senza riaprire G33, senza modificare Disabled,
senza modificare payload e senza anticipare G10A.

Modifiche applicate:

- create_suggestion_state espone requiresUserOverride
- preview_analysis_state legge create_suggestion_state
- Da verificare mostra warning mirato solo quando c’è match presente + suggestion extension
- create_suggestion_hint mantiene la suggestion operativa senza duplicare la selezione corrente
- warning generici moreSpecificMatches rimossi dal caso G22

Test:

1. 20 euro villa

Esito:

- Progetto = Villa
- nessun warning progetto da controllare
- nessuna suggestion project
- Conferma attiva

RISULTATO:
OK

2. 20 euro villa sierri

Esito:

- Progetto = Villa
- Da verificare mostra:
  Associazione progetto da controllare
  Villa selezionato · testo letto: Villa Sierri
- Suggerimenti associazione mostra:
  Possibile nuovo progetto: Villa Sierri
- Conferma attiva

RISULTATO:
OK

3. 20 euro villa sierri 6

Esito:

- Progetto = Villa Sierri 6
- nessun warning progetto da controllare
- nessuna suggestion project
- Conferma attiva

RISULTATO:
OK

4. 20 euro tecnico mario

Esito:

- Entità = Mario
- nessun warning entità da controllare
- nessuna suggestion entity
- Conferma attiva

RISULTATO:
OK

5. crea progetto test

Esito:

- command container visibile
- Sintesi evento nascosta
- Dati evento nascosti
- Conferma evento non mostrata
- nessun evento salvato

RISULTATO:
OK

6. 20 euro mario rossi

Esito:

- Entità = Mario Rossi
- nessun warning entità da controllare
- nessuna suggestion entity
- Conferma attiva

RISULTATO:
OK

7. 20 euro mario giordano

Esito:

- Entità = Mario
- Da verificare mostra:
  Associazione entità da controllare
  Mario selezionata · testo letto: Mario Giordano
- Suggerimenti associazione mostra:
  Possibile nuova entità: Mario Giordano
- Conferma attiva

RISULTATO:
OK

Regressioni escluse:

- parser invariato
- matching primario invariato
- select_project/select_entity invariati
- button_input_confirm.Disabled invariato
- button_input_confirm.Hidden invariato
- payload invariato
- insert_event/update_event invariati
- DB invariato
- Supabase invariato
- Command Intent non regressivo

INPUT CONTEXT CONSISTENCY — EDIT / SUGGESTION / COMMAND BOUNDARY — TEST VALIDATI:

Create flow:

modifica
→ command rilevato
→ guida non operativa visibile
→ nessuna Sintesi evento
→ nessun Dati evento
→ nessuna Conferma evento
→ nessun evento creato

correggi
→ stesso comportamento
→ nessun evento creato

cambia
→ stesso comportamento
→ nessun evento creato

crea progetto test
→ command create project funzionante
→ nessun evento salvato

crea entità test
→ command create entity funzionante
→ nessun evento salvato

modifica progetto
→ resta input evento ordinario
→ non gestito come command
→ fuori scope del nodo

cea progetto test
→ typo non riconosciuto
→ resta input evento ordinario
→ fuzzy/typo fuori scope

Edit flow:

modifica
→ edit mode resta attivo
→ notice contestuale “Comando rilevato”
→ Conferma evento non esegue update_event
→ warning mostrato
→ Annulla modifica funzionante

correggi
→ stesso comportamento
→ nessun update_event

cambia
→ stesso comportamento
→ nessun update_event

crea progetto test
→ edit mode resta attivo
→ command strutturale non eseguito
→ nessun project creato
→ nessun update_event
→ warning mostrato

crea entità test
→ edit mode resta attivo
→ command strutturale non eseguito
→ nessuna entity creata
→ nessun update_event
→ warning mostrato

edit flow con input evento valido:

30 euro villa
→ Sintesi evento visibile
→ Conferma evento aggiorna correttamente
→ update_event eseguito

Annulla modifica:
→ nessun update_event
→ ritorno Lista eventi
→ comportamento invariato

Regressioni:

20 euro villa sierri
→ G22 invariato
→ warning associazione progetto da controllare
→ suggestion Villa Sierri
→ Conferma attiva

Linting:
→ 0

Performance:
→ tornata accettabile dopo rollback input_analysis_result

Impatto:

- input_analysis_result rollbackato alla base stabile
- nessuna modifica DB
- nessuna modifica Supabase
- nessuna modifica payload
- nessuna modifica insert_event/update_event
- nessuna modifica button_input_confirm.Disabled
- nessuna modifica Match Engine
- nessuna riapertura G22
- nessuna apertura G10A

LIMITI ATTUALI

INPUT / PARSING:

giorni non convertiti automaticamente
settimane non convertite automaticamente
giornata / mezza giornata non normalizzate
parole numeriche tipo “due ore” non supportate
forme colloquiali tipo “un paio d’ore” non supportate
2h e mezza non supportato
date relative non supportate
parsing semantico non implementato

NORMALIZATION:

amount/unit base implementati
unità canonica tempo = minuti
conversione ore/minuti implementata
giorni/settimane non convertiti automaticamente
nessuna retro-normalizzazione dati storici
nessun payload duration
nessun campo duration_minutes dedicato

TYPE:

type classification base implementata
Tempo / Spesa / Incasso / Evento persistiti in events.type
spesa/incasso riconosciuti solo tramite keyword controllate o scelta manuale
euro senza direzione chiara resta Evento
amount firmato non implementato
direction field non implementato
classificazione economica avanzata non implementata
parole di dominio non usate come classificazione automatica
type non ancora sufficiente da solo per KPI avanzati
eventi storici non retro-normalizzati

MATCHING:

Match Engine Unification First Controlled Level completato
project_state/entity_state fonte minima matching
select/hint/highlight/confirm allineati a match state
priority match minimo implementato
no fuzzy matching
no alias system
no gerarchia entity/project
no deduplicazione
creazione guidata project/entity implementata a primo livello controllato
command intent base implementato
no filtro select su match ambigui
no ranking avanzato
auto-select confidence avanzata non implementata
select_project/select_entity non filtrano né prioritizzano ancora i candidati contestuali
match presente + suggestion extension risolto in G22 a primo livello controllato

PREVIEW:

non completamente read-only
formattazione italiana base allineata nella sintesi
contiene ancora logica label/hint
non è una view pura
label cleaning ancora embedded
hint matching project/entity allineati a state
hint duration/type ancora embedded
“Da verificare” ancora interno alla Sintesi
visibilità Sintesi governata da input_analysis_result.readiness.canShowEventPreview
ui_visibility_state resta residuo tecnico deprecabile / rollback e non governa più gli Hidden principali migrati.
contenuto interno Sintesi ancora non separato
warning informativi non separati in blocchi autonomi
G22 ha introdotto warning mirato in Da verificare per associazioni project/entity da controllare
Da verificare segnala il rischio decisionale
Suggerimenti associazione propone l’azione
balloon blu “Manca progetto / Manca entità” ancora da rivalutare in nodo Preview/UX futuro
badge OK / status Sintesi ancora da rivalutare in Status Semantics Alignment

ARCHITETTURA:

alcuni layer ancora accoppiati
matching project/entity allineato a primo livello
preview ancora ibrida
input system stabilizzato ma non completamente separato da tutti i layer
command intent implementato a primo livello controllato
container suggestion UI rifinito a livello mobile base
create_suggestion_state ancora helper Retool, non modulo engine separato
command_intent_state ancora helper Retool, non modulo engine separato
input_analysis_result implementato come layer compositivo per Hidden principali del flow input
Input Analysis Model completo non implementato
ui_visibility_state non sostituisce match engine
ui_visibility_state non è più letto da input_analysis_result
ui_visibility_state resta residuo tecnico deprecabile
Full Visibility Migration degli Hidden principali completata
button_input_confirm.Hidden migrato
button_input_confirm.Disabled usa readiness.canConfirm, confirm_event.isFetching e choiceValues correnti
Disabled resta proprietà del componente; le guardie finali restano nel coordinatore
confirm_event contiene il solo payload builder e il solo switch INSERT/UPDATE
save readiness completa non centralizzata
rendering progressivo input evento normale ridotto tramite UI Readiness e input_analysis_result
micro-flash feedback project/entity ancora presente
flash residui digitazione/cambio schermata ancora presenti
linting Retool azzerati (risultato storico pre-N18; finale N18: 11 residui qualificati)
typing_state eliminato
handle_event_success eliminato
“modifica”, “correggi”, “cambia” riconosciuti come guida generica non operativa
command riconosciuti in edit mode bloccati funzionalmente prima di update_event
text_edit_mode_notice mostra guidance contestuale quando rileva un command in edit mode
residuo UX: in edit mode Sintesi / Suggerimenti associazione / Dati evento restano visibili anche quando l’input è un command riconosciuto
questo residuo è accettato perché update_event e creazioni improprie sono bloccati
non correggere ora tramite input_analysis_result o Hidden multipli fuori nodo dedicato
cleanup obsolete UI guards / query reduction non ancora eseguito
requiresUserOverride introdotto in create_suggestion_state senza creare motore monolitico
preview_analysis_state consuma requiresUserOverride per warning mirato
separazione tra warning e azione migliorata
residui grafici/mobile polish da trattare in nodi UX dedicati o sessioni brevi

COMMAND INTENT:

implementato a primo livello controllato

Gestito:

- crea
- crea progetto
- crea progetto [nome]
- aggiungi progetto [nome]
- inserisci progetto [nome]
- nuovo progetto [nome]
- crea entità
- crea entità [nome]
- aggiungi entità [nome]
- inserisci entità [nome]
- nuova entità [nome]
- modifica evento

Non implementato:

- intent engine globale
- dashboard/report intent
- modifica project/entity da command
- edit flow evento automatico da command
- input analysis model unico
- alias / deduplicazione / gerarchie da command
- alias system globale
- fuzzy / typo command recognition
- gestione “modifica progetto” come command strutturale

Implementato a primo livello controllato:

- alias guida edit generici:
  - modifica
  - correggi
  - cambia

Questi alias sono solo guida non operativa.
Non aprono edit flow automatico.
Non salvano eventi.
Non aggiornano eventi.

OBIETTIVO INPUT SYSTEM

Rendere l’input:

veloce
comprensibile
sufficientemente affidabile
non bloccante
coerente nel salvataggio
progressivamente normalizzato
capace di assistere la creazione project/entity senza automatismi nascosti
capace di distinguere comandi strutturali puri da eventi ordinari a primo livello controllato
capace di coordinare la visibilità del flow input tramite input_analysis_result e ui_visibility_mode
capace di comporre raw / selection / effective state tramite input_analysis_result
capace di mantenere separata la visibilità del bottone Conferma dalla sua readiness funzionale
capace di bloccare solo ambiguità reali non risolte senza trasformare warning informativi in blocchi
capace di alimentare gli Hidden principali del flow input senza diventare un motore monolitico
capace di segnalare match presente + suggestion extension senza bloccare l’utente
capace di distinguere rischio decisionale da azione suggerita
capace di impedire che alias generici di modifica vengano salvati come eventi
capace di impedire che command riconosciuti durante edit mode diventino update_event
capace di mantenere stabile input_analysis_result senza usarlo per correggere ogni caso UX locale

NON:

perfetto
completamente automatico
semantico avanzato
decisionale
orientato a KPI prima della qualità dati
intent engine globale o assistente conversazionale avanzato
Input Analysis Model completo già concluso
Event Interpretation Engine
fonte unica interpretativa completa già implementata
mega-motore monolitico che sostituisce i moduli specializzati

STATO DOCUMENTALE / REGOLE DI AGGIORNAMENTO

01_LOGOS_Input_System è documento tecnico canonico.

Questo documento non governa:

- nodo attivo
- roadmap
- priorità operative
- ordine dei prossimi nodi

Nodo attivo, priorità e sequenza sono governati da:

- 00_PROJECT_State
- 00_PROJECT_Roadmap
- 00_PROJECT_Gap_Register

Questo documento va aggiornato solo quando cambia una logica dell’area input oppure quando serve registrare un impatto documentale diretto su:

- input flow
- parser
- normalization
- duration normalization
- type classification nel contesto input
- Command Intent nel contesto input
- create_suggestion_state nel contesto input
- input_analysis_result
- fonti controllate usate dal payload evento

Regola:

non usare questo documento come Roadmap.
Non inserire qui “nodo corrente”, “prossimo nodo” o pacchetti documentali in corso.

Le evoluzioni future collegate all’input devono restare in:

- 00_PROJECT_Roadmap per sequenza e priorità
- 00_PROJECT_Gap_Register per gap e debiti
- checkpoint operativo solo durante il nodo attivo

## Q2 — sorgenti finali di competenza

Trascrizioni integrali dai file effettivi, non candidate storiche o nuovo codice. Gli hash si riferiscono ai file sorgente UTF-8/LF nel pacchetto di review: per estrarli dal Markdown CRLF normalizzare soltanto EOL del contenitore. Non eliminare spazi iniziali/finali del codice. Provenienza dettagliata nel registro Runtime e nel manifest del lotto. Le descrizioni storiche precedenti non sostituiscono queste proprietà finali.

### q2-source-parse-input-controlled-query

`parse_input_controlled.template.query` — sorgente integrale. SHA-256 UTF-8/LF `0a721e653597e802b6a160671c6530606750c5eb125378ff83bc46e20d6a3b7c`, 7738 byte.

```js
// Q2: request-scoped adapter. Canonical body below is unchanged.
const req = typeof analysis_request === "undefined" ? null : analysis_request;
const values = req ? [
  {value:req.raw}, {value:req.raw}, {data:req.projects}, {data:req.entities},
  {data:req.project}, {data:req.entity}, {value:req.projectId}, {value:req.entityId}
] : [input_home,input_raw,projects_list,entities_list,project_state,entity_state,select_project,select_entity];
const result = ((input_home, input_raw, projects_list, entities_list, project_state, entity_state, select_project, select_entity) => {
const text = input_raw.value || "";

if (!text || text.trim() === "") {
  return {
    amount: null,
    unit: null,
    event_date: null
  };
}

// normalizzazione base testo
const clean = text.toLowerCase().replace(/\s+/g, " ").trim();

function normalizeNumberValue(value) {
  if (value === null || value === undefined || value === "") {
    return null;
  }

  const raw = String(value).trim();

  // Formato italiano con migliaia + decimali:
  // 1.500,50 → 1500.50
  if (/^\d{1,3}(\.\d{3})+,\d+$/.test(raw)) {
    return Number(raw.replace(/\./g, "").replace(",", "."));
  }

  // Formato italiano con separatore migliaia:
  // 1.500 → 1500
  if (/^\d{1,3}(\.\d{3})+$/.test(raw)) {
    return Number(raw.replace(/\./g, ""));
  }

  // Formato con virgola decimale:
  // 458,78 → 458.78
  // 1,5 → 1.5
  if (/^\d+,\d+$/.test(raw)) {
    return Number(raw.replace(",", "."));
  }

  // Formato con punto decimale compatibile:
  // 1.5 → 1.5
  if (/^\d+\.\d+$/.test(raw)) {
    return Number(raw);
  }

  // Intero semplice:
  // 1500 → 1500
  if (/^\d+$/.test(raw)) {
    return Number(raw);
  }

  return null;
}

// ------------------
// DATE
// ------------------

let event_date = null;

const dateSlashMatch = clean.match(/\b(\d{1,2})\/(\d{1,2})\/(\d{2,4})\b/);

if (dateSlashMatch) {
  let [, d, m, y] = dateSlashMatch;
  if (y.length === 2) y = "20" + y;
  event_date = `${y}-${m.padStart(2, "0")}-${d.padStart(2, "0")}`;
}

const mesiMap = {
  gennaio: "01",
  febbraio: "02",
  marzo: "03",
  aprile: "04",
  maggio: "05",
  giugno: "06",
  luglio: "07",
  agosto: "08",
  settembre: "09",
  ottobre: "10",
  novembre: "11",
  dicembre: "12"
};

if (!event_date) {
  const words = clean.split(" ");
  for (let i = 0; i < words.length; i++) {
    if (/^\d{1,2}$/.test(words[i]) && mesiMap[words[i + 1]]) {
      const year = new Date().getFullYear();
      event_date = `${year}-${mesiMap[words[i + 1]]}-${words[i].padStart(2, "0")}`;
      break;
    }
  }
}

// ------------------
// DURATION NORMALIZATION BASE
// ------------------
//
// Decisione:
// - tutte le durate certe ore/minuti vengono salvate in minuti
// - amount = totale minuti
// - unit = "minuti"
// - raw_input resta preservato nel save flow
//
// Gestito:
// - 18 minuti
// - 18min
// - min18
// - 1 ora
// - 1ora
// - 2h
// - h2
// - 1,5 ore
// - 1.5h
// - 1 ora e 15 minuti
// - 1 ora 15 minuti
// - 2h30
// - 2 h 30
// - 2 ore 30
//
// Non gestito automaticamente:
// - giorni
// - settimane
// - giornata
// - mezza giornata

let amount = null;
let unit = null;

const isTimeFormat = /\d{1,2}:\d{2}/.test(clean);

// rimuove date dal testo usato per amount/unit
const cleanForParsing = clean
  .replace(/\b\d{1,2}\/\d{1,2}(?:\/\d{2,4})?\b/g, "")
  .replace(/\b\d{1,2}\s+(gennaio|febbraio|marzo|aprile|maggio|giugno|luglio|agosto|settembre|ottobre|novembre|dicembre)\b/g, "")
  .replace(/\s+/g, " ")
  .trim();

const hasAmbiguousLongDuration =
  /\b\d+(?:[.,]\d+)?\s*(giorno|giorni|settimana|settimane|giornata|giornate)\b/.test(cleanForParsing) ||
  /\b(giorno|giorni|settimana|settimane|giornata|giornate)\s*\d+(?:[.,]\d+)?\b/.test(cleanForParsing) ||
  /\bmezza giornata\b/.test(cleanForParsing);

if (!isTimeFormat && !hasAmbiguousLongDuration) {
  let totalMinutes = null;

  // 1) Formato compatto ore+minuti:
  // 2h30, 2h 30
  const compactHourMinuteMatch = cleanForParsing.match(
    /\b(\d+(?:[.,]\d+)?)\s*h\s*(\d{1,2})\b/
  );

  if (compactHourMinuteMatch) {
    const hours = normalizeNumberValue(compactHourMinuteMatch[1]);
    const minutes = normalizeNumberValue(compactHourMinuteMatch[2]);

    if (hours !== null && minutes !== null) {
      totalMinutes = Math.round(hours * 60 + minutes);
    }
  }

  // 2) Formato ore + minuti testuale:
  // 1 ora e 15 minuti
  // 1 ora 15 minuti
  // 2 ore 30 minuti
  if (totalMinutes === null) {
    const hourMinuteTextMatch = cleanForParsing.match(
      /\b(\d+(?:[.,]\d+)?)\s*(h|ora|ore)\s*(?:e\s*)?(\d{1,2})\s*(min|minuto|minuti)?\b/
    );

    if (hourMinuteTextMatch) {
      const hours = normalizeNumberValue(hourMinuteTextMatch[1]);
      const minutes = normalizeNumberValue(hourMinuteTextMatch[3]);

      if (hours !== null && minutes !== null) {
        totalMinutes = Math.round(hours * 60 + minutes);
      }
    }
  }

  // 3) Formato h + numero:
  // h2
  if (totalMinutes === null) {
    const hBeforeMatch = cleanForParsing.match(/\bh\s*(\d+(?:[.,]\d+)?)\b/);

    if (hBeforeMatch) {
      const hours = normalizeNumberValue(hBeforeMatch[1]);

      if (hours !== null) {
        totalMinutes = Math.round(hours * 60);
      }
    }
  }

  // 4) Formato ore semplice:
  // 1 ora
  // 1ora
  // 2 ore
  // 2h
  // 1,5 ore
  // 1.5h
  if (totalMinutes === null) {
    const simpleHourMatch = cleanForParsing.match(
      /\b(\d+(?:[.,]\d+)?)\s*(h|ora|ore)\b/
    );

    if (simpleHourMatch) {
      const hours = normalizeNumberValue(simpleHourMatch[1]);

      if (hours !== null) {
        totalMinutes = Math.round(hours * 60);
      }
    }
  }

  // 5) Formato minuti semplice:
  // 18 minuti
  // 18min
  // 30 min
  if (totalMinutes === null) {
    const simpleMinuteMatch = cleanForParsing.match(
      /\b(\d+(?:[.,]\d+)?)\s*(min|minuto|minuti)\b/
    );

    if (simpleMinuteMatch) {
      const minutes = normalizeNumberValue(simpleMinuteMatch[1]);

      if (minutes !== null) {
        totalMinutes = Math.round(minutes);
      }
    }
  }

  // 6) Formato minuti con unità prima:
  // min30
  // min 30
  if (totalMinutes === null) {
    const minuteBeforeMatch = cleanForParsing.match(
      /\b(min|minuto|minuti)\s*(\d+(?:[.,]\d+)?)\b/
    );

    if (minuteBeforeMatch) {
      const minutes = normalizeNumberValue(minuteBeforeMatch[2]);

      if (minutes !== null) {
        totalMinutes = Math.round(minutes);
      }
    }
  }

  if (totalMinutes !== null) {
    amount = totalMinutes;
    unit = "minuti";
  }
}

// ------------------
// EURO / ECONOMICO BASE
// ------------------
//
// Manteniamo compatibilità con la normalizzazione base economica.
// Se non è stata rilevata una durata tempo, gestiamo euro come prima.

if (amount === null && unit === null && !isTimeFormat) {
  const hasEuro = /€|euro|eur/.test(cleanForParsing);

  if (hasEuro) {
    unit = "euro";

    const euroUnitMatches = [
      ...cleanForParsing.matchAll(/€|euro|eur/g)
    ];

    const numbers = cleanForParsing.match(
      /\d{1,3}(?:\.\d{3})+(?:,\d+)?|\d+(?:[.,]\d+)?/g
    );

    let unitIndex = -1;

    if (euroUnitMatches.length > 0) {
      unitIndex = euroUnitMatches[euroUnitMatches.length - 1].index;
    }

    let best = null;
    let bestDist = Infinity;

    if (numbers && unitIndex >= 0) {
      numbers.forEach(n => {
        const idx = cleanForParsing.indexOf(n);
        const dist = Math.abs(idx - unitIndex);

        if (dist < bestDist) {
          bestDist = dist;
          best = n;
        }
      });
    }

    amount = best ? normalizeNumberValue(best) : null;
  }
}

// ------------------
// RETURN
// ------------------

return {
  amount,
  unit,
  event_date
};
})(...values);
return {...result, __logosRequestId:req?.id || null};
```

### q2-source-trigger-parse-debounced-query

`trigger_parse_debounced.template.query` — sorgente integrale. SHA-256 UTF-8/LF `64f0a243e12eb408e034cf93ff3a16aa0927d27b54badc105f637f403cd82eb0`, 3697 byte.

```js
// One completion boundary; no independent parser publisher.
const revision = typeof analysis_revision_id === "undefined"
  ? String(window.__logosAnalysisEpoch || 0) : String(analysis_revision_id);
const raw = String(input_home.value || "");
const observedContext = JSON.stringify([String(ui_state.value?.view || "home"),edit_mode.data === true,
  edit_mode.data === true ? editing_event.data || null : null]);
// Edit entry supplies the context returned by its canonical initialization.
const context = typeof analysis_expected_context === "string"
  ? analysis_expected_context : observedContext;
const req = JSON.parse(JSON.stringify({
  id:revision+":"+String((window.__logosAnalysisRequestSerial || 0)+1),revision,raw,context,
  projects:projects_list.data || [],entities:entities_list.data || [],
  projectId:select_project.value || null,entityId:select_entity.value || null
}));
window.__logosAnalysisRequestSerial = (window.__logosAnalysisRequestSerial || 0)+1;
window.__logosAnalysisCurrentRequest = req.id;
const current = () => String(window.__logosAnalysisEpoch || 0) === revision &&
  window.__logosAnalysisCurrentRequest === req.id &&
  analysis_revision.value === revision && input_home.value === raw && input_raw.value === raw &&
  JSON.stringify([String(ui_state.value?.view || "home"),edit_mode.data === true,
    edit_mode.data === true ? editing_event.data || null : null]) === context &&
  JSON.stringify([projects_list.data || [],entities_list.data || []]) === JSON.stringify([req.projects,req.entities]);
if (!current()) return null;
if (window.__parseTimer) clearTimeout(window.__parseTimer);
if (window.__logosAnalysisDelayResolve) window.__logosAnalysisDelayResolve(false);
project_create_inline_open.setValue(false);
project_create_suggestion_dismissed.setValue(false);
input_new_project_name.setValue("");
entity_create_inline_open.setValue(false);
entity_create_suggestion_dismissed.setValue(false);
input_new_entity_name.setValue("");
await ui_visibility_mode.setValue("empty");
if (!current() || !raw.trim()) return null;
const elapsed = await new Promise(resolve => {
  window.__logosAnalysisDelayResolve = resolve;
  window.__parseTimer = setTimeout(() => resolve(true),350);
});
if (!elapsed || !current()) return null;
try {
  const scope = {additionalScope:{analysis_request:req}};
  const [parsed,project,entity,command] = await Promise.all([
    parse_input_controlled.trigger(scope),project_state.trigger(scope),
    entity_state.trigger(scope),command_intent_state.trigger(scope)
  ]);
  if (!current()) return null;
  if ([parsed,project,entity,command].some(result => !result || result.__logosRequestId !== req.id)) {
    throw new Error("Risultati non correlati alla richiesta");
  }
  const suggestion = await create_suggestion_state.trigger({additionalScope:{analysis_request:{...req,project,entity}}});
  if (!current()) return null;
  if (suggestion?.__logosRequestId !== req.id) throw new Error("Suggestion non correlata");
  const snapshot = {id:req.id,revision,raw,context,status:"complete",
    catalogue:JSON.stringify([req.projects,req.entities]),parsed,project,entity,command,suggestion};
  await ui_state.setValue({...ui_state.value,analysis:snapshot,parsed:{
    amount:parsed.amount ?? null,unit:parsed.unit ?? null,event_date:parsed.event_date ?? null
  }});
  if (!current()) return null;
  await ui_visibility_mode.setValue(command.isCommand ? "command" : "event");
  return current() ? snapshot : null;
} catch (error) {
  if (current()) {
    await ui_state.setValue({...ui_state.value,analysis:null,parsed:{amount:null,unit:null,event_date:null}});
    if (current()) await ui_visibility_mode.setValue("empty");
  }
  return null;
}

```

### q2-source-analysis-snapshot-funcbody

`analysis_snapshot.template.funcBody` — sorgente integrale. SHA-256 UTF-8/LF `6404d26273b80b12cb8d13ae5948f39c7463d59f0fe3351ad199900642701c91`, 832 byte.

```js
const snapshot = {{ ui_state.value?.analysis || null }};
const revision = String({{ analysis_revision.value || "" }});
const home = String({{ input_home.value || "" }});
const raw = String({{ input_raw.value || "" }});
const view = String({{ ui_state.value?.view || "home" }});
const isEdit = {{ edit_mode.data === true }};
const original = {{ editing_event.data || null }};
const projects = {{ projects_list.data || [] }};
const entities = {{ entities_list.data || [] }};
const context = JSON.stringify([view,isEdit,isEdit ? original : null]);
if (!snapshot || snapshot.status !== "complete" ||
    snapshot.revision !== revision || !raw.trim() ||
    snapshot.raw !== home || snapshot.raw !== raw ||
    snapshot.context !== context ||
    snapshot.catalogue !== JSON.stringify([projects,entities])) return null;
return snapshot;

```

### q2-source-input-analysis-result-funcbody

`input_analysis_result.template.funcBody` — sorgente integrale. SHA-256 UTF-8/LF `c3ae149722b45ce64325f18af44a22d6ec2ebfb6d850623f00f87f1507920532`, 15093 byte.

```js
const rawInput = String({{ input_home.value || input_raw.value || "" }} || "").trim();

const normalizedText = rawInput
  .toLowerCase()
  .normalize("NFD")
  .replace(/[\u0300-\u036f]/g, "")
  .replace(/\s+/g, " ")
  .trim();

const uiState = {{ ui_state.value || {} }};
const parsed = {{ analysis_snapshot.value?.parsed || {} }};

const visibilityMode = String({{ ui_visibility_mode.value || "empty" }});

const preview = {{ preview_analysis_state.value || {} }};

const command = {{ analysis_snapshot.value?.command || {} }};
const suggestion = {{ analysis_snapshot.value?.suggestion || {} }};

const projectMatch = {{ analysis_snapshot.value?.project || {} }};
const entityMatch = {{ analysis_snapshot.value?.entity || {} }};

const projects = {{ projects_list.data || [] }};
const entities = {{ entities_list.data || [] }};

const selectedProjectId = {{ select_project.value || null }};
const selectedEntityId = {{ select_entity.value || null }};

const selectedProject =
  projects.find(p => p.id === selectedProjectId) || null;

const selectedEntity =
  entities.find(e => e.id === selectedEntityId) || null;

const selectedProjectName = selectedProject?.name || null;
const selectedEntityName = selectedEntity?.name || null;

const typeValue = String({{ select1.value || "Evento" }});

const amount = parsed.amount ?? null;
const unit = parsed.unit ?? null;
const eventDate = parsed.event_date ?? null;

const hasInput = rawInput.length > 0;

const hasAmount =
  amount !== null &&
  amount !== undefined &&
  amount !== "" &&
  Number.isFinite(Number(amount));

const hasUnit =
  unit !== null &&
  unit !== undefined &&
  String(unit).trim() !== "";

const hasDate =
  eventDate !== null &&
  eventDate !== undefined &&
  String(eventDate).trim() !== "";

const isEconomic = unit === "euro";
const isTime = unit === "minuti" || unit === "ore";

const isMissingEconomicDirection =
  isEconomic && typeValue === "Evento";

const projectMatchCount =
  Number(projectMatch.count ?? projectMatch.matches?.length ?? 0);

const entityMatchCount =
  Number(entityMatch.count ?? entityMatch.matches?.length ?? 0);

const projectIsAmbiguous =
  Boolean(projectMatch.isAmbiguous) || projectMatchCount > 1;

const entityIsAmbiguous =
  Boolean(entityMatch.isAmbiguous) || entityMatchCount > 1;

const projectSingleMatch = projectMatch.singleMatch || null;
const entitySingleMatch = entityMatch.singleMatch || null;

const hasProjectSuggestion =
  Boolean(suggestion.project) &&
  {{ !project_create_suggestion_dismissed.value }} &&
  (
    suggestion.project.shouldShowNoMatchHint === true ||
    suggestion.project.shouldSuggestCreate === true
  );

const hasEntitySuggestion =
  Boolean(suggestion.entity) &&
  {{ !entity_create_suggestion_dismissed.value }} &&
  (
    suggestion.entity.shouldShowNoMatchHint === true ||
    suggestion.entity.shouldSuggestCreate === true
  );

const rawHasAssociationSuggestion =
  hasProjectSuggestion === true ||
  hasEntitySuggestion === true;

const isEditMode = {{ edit_mode.data === true }};

// Command raw = stato tecnico prodotto da command_intent_state.
// In edit mode può risultare true, ma NON deve governare il flow.
const rawIsCommand = command.isCommand === true;
const rawIsPureCommand = command.isPureCommand === true;

// Command effettivo = command valido per il flow corrente.
// Regola consolidata: edit mode prevale su Command Intent.
const isCommand = !isEditMode && rawIsCommand;
const isPureCommand = !isEditMode && rawIsPureCommand;

// -----------------------------
// EFFECTIVE FLOW — CONTROLLED BASE
// -----------------------------

const view = String(uiState.view || "home");
const isHomeView = view === "home";

const effectiveIsInputFlow =
  isHomeView &&
  (
    (
      hasInput &&
      visibilityMode !== "empty"
    ) ||
    isEditMode
  );

let effectiveFlowType = "none";

if (effectiveIsInputFlow) {
  if (isEditMode) {
    effectiveFlowType = "edit";
  } else if (isPureCommand) {
    effectiveFlowType = "command";
  } else {
    effectiveFlowType = "event";
  }
}

const effectiveIsCommandFlow =
  effectiveFlowType === "command";

const effectiveIsEventFlow =
  effectiveFlowType === "event" ||
  effectiveFlowType === "edit";

const effectiveCanUseEventFields =
  effectiveIsEventFlow === true;

const effectiveCanUseCommandFields =
  effectiveIsCommandFlow === true;

// -----------------------------
// EFFECTIVE VISIBILITY — INTERNAL BASE
// -----------------------------

const isInputFlow = effectiveIsInputFlow;
const isEventFlow = effectiveIsEventFlow;

const showEventPreview =
  effectiveIsEventFlow === true &&
  hasInput;

const showCommandContainer =
  {{ Boolean(analysis_snapshot.value) }} &&
  effectiveIsCommandFlow === true;

const showEventData =
  {{ Boolean(analysis_snapshot.value) }} &&
  effectiveIsEventFlow === true &&
  hasInput;

const showConfirm =
  effectiveIsEventFlow === true &&
  hasInput;

  const showAssociationSuggestions =
  showEventData === true &&
  rawHasAssociationSuggestion === true;

const hasBlockingAmbiguity =
  preview.hasBlockingAmbiguity === true ||
  (
    projectIsAmbiguous &&
    !selectedProjectId
  ) ||
  (
    entityIsAmbiguous &&
    !selectedEntityId
  );

const hasPreviewWarnings =
  preview.hasWarning === true ||
  preview.hasHints === true;

const hasBlockingIssue =
  hasBlockingAmbiguity === true;

const hasNonBlockingWarnings =
  hasPreviewWarnings === true &&
  hasBlockingIssue === false;

const historical = {{ edit_mode.data === true ? editing_event.data : null }};
const projectSelection = selectedProject && (selectedProject.status === "ACTIVE" || historical?.project_id === selectedProject.id) ? selectedProject : null;
const entitySelection = selectedEntity && (selectedEntity.status === "ACTIVE" || historical?.entity_id === selectedEntity.id) ? selectedEntity : null;
const projectHistorical = Boolean(selectedProjectId && historical?.project_id === selectedProjectId);
const entityHistorical = Boolean(selectedEntityId && historical?.entity_id === selectedEntityId);
const invalidSelection = Boolean((selectedProjectId && !projectSelection && !projectHistorical) ||
  (selectedEntityId && !entitySelection && !entityHistorical));
const projectCandidate = !projectSelection && !projectHistorical && !projectIsAmbiguous && projectSingleMatch?.status === "INACTIVE" ? projectSingleMatch : null;
const entityCandidate = !entitySelection && !entityHistorical && !entityIsAmbiguous && entitySingleMatch?.status === "INACTIVE" ? entitySingleMatch : null;
const association = {
  project:{selectedId:projectHistorical ? selectedProjectId : projectSelection?.id || null,candidateId:projectCandidate?.id || null,
    candidateName:projectCandidate?.name || null,requiresDecision:Boolean(projectCandidate),
    message:projectCandidate ? `Il progetto “${projectCandidate.name}” è inattivo. Vuoi collegarlo a questo evento?` : null,
    information:"Il progetto resterà inattivo. L’evento sarà comunque consultabile."},
  entity:{selectedId:entityHistorical ? selectedEntityId : entitySelection?.id || null,candidateId:entityCandidate?.id || null,
    candidateName:entityCandidate?.name || null,requiresDecision:Boolean(entityCandidate),
    message:entityCandidate ? `L’entità “${entityCandidate.name}” è inattiva. Vuoi collegarla a questo evento?` : null,
    information:"L’entità resterà inattiva. L’evento sarà comunque consultabile."}
};

const associationContext = JSON.stringify([{{ analysis_snapshot.value?.id || null }},selectedProjectId,selectedEntityId,typeValue,isEditMode,historical]);
const associationSnapshot = {{ analysis_snapshot.value || null }};
// Correlate UI options only; do not read exception controls or consent here.
for (const layer of ["project", "entity"]) {
  const entry = association[layer];
  entry.choiceValues = associationSnapshot && entry.requiresDecision
    ? Object.fromEntries(["link", "skip"].map(choice => [choice, JSON.stringify([
        associationSnapshot.id, associationSnapshot.revision, associationSnapshot.context,
        associationContext, layer, entry.candidateId, choice
      ])]))
    : null;
}

const canConfirm =
  !invalidSelection &&
  {{ Boolean(analysis_snapshot.value) }} &&
  showConfirm === true &&
  hasBlockingIssue === false &&
  isPureCommand === false;

// -----------------------------
// EFFECTIVE PROJECT / ENTITY — READ ONLY
// -----------------------------

const projectHasSelectedValue = Boolean(selectedProjectId);
const entityHasSelectedValue = Boolean(selectedEntityId);

const projectHasRawMatch =
  projectMatchCount > 0 ||
  Boolean(projectSingleMatch?.id);

const entityHasRawMatch =
  entityMatchCount > 0 ||
  Boolean(entitySingleMatch?.id);

const projectIsBlocking =
  effectiveCanUseEventFields &&
  projectIsAmbiguous &&
  !projectHasSelectedValue;

const entityIsBlocking =
  effectiveCanUseEventFields &&
  entityIsAmbiguous &&
  !entityHasSelectedValue;

const projectIsUsableForEvent =
  effectiveCanUseEventFields &&
  projectHasSelectedValue &&
  !projectIsBlocking;

const entityIsUsableForEvent =
  effectiveCanUseEventFields &&
  entityHasSelectedValue &&
  !entityIsBlocking;

const projectHasNonBlockingWarning =
  effectiveCanUseEventFields &&
  !projectIsBlocking &&
  Boolean(projectMatch.hasMoreSpecificMatches);

const entityHasNonBlockingWarning =
  effectiveCanUseEventFields &&
  !entityIsBlocking &&
  Boolean(entityMatch.hasMoreSpecificMatches);

return {
  association,
  associationContext,
  analysis: {{ analysis_snapshot.value || null }},
mode: {
  view: String(uiState.view || "home"),
  visibilityMode,
  isInputFlow,
  isEditMode,
  isCommand,
  isPureCommand,
  isEventFlow,
  effectiveFlowType,
  effectiveIsInputFlow,
  effectiveIsEventFlow,
  effectiveIsCommandFlow,
  effectiveCanUseEventFields,
  effectiveCanUseCommandFields
},

  input: {
    raw: rawInput,
    normalizedText,
    hasInput
  },

  parsed: {
    amount,
    unit,
    event_date: eventDate,
    hasAmount,
    hasUnit,
    hasDate,
    isEconomic,
    isTime
  },

  type: {
    value: typeValue,
    isMissingEconomicDirection
  },

project: {
  selectedId: selectedProjectId,
  selectedName: selectedProjectName,
  matchCount: projectMatchCount,
  isAmbiguous: projectIsAmbiguous,
  hasSingleMatch: Boolean(projectSingleMatch?.id),
  singleMatchId: projectSingleMatch?.id || null,
  singleMatchName: projectSingleMatch?.name || null,
  hasMoreSpecificMatches: Boolean(projectMatch.hasMoreSpecificMatches),
  isMissing: !selectedProjectId,

  raw: {
    matchCount: projectMatchCount,
    isAmbiguous: projectIsAmbiguous,
    hasSingleMatch: Boolean(projectSingleMatch?.id),
    singleMatchId: projectSingleMatch?.id || null,
    singleMatchName: projectSingleMatch?.name || null,
    hasMoreSpecificMatches: Boolean(projectMatch.hasMoreSpecificMatches),
    hasRawMatch: projectHasRawMatch
  },

  selection: {
    selectedId: selectedProjectId,
    selectedName: selectedProjectName,
    hasSelectedValue: projectHasSelectedValue,
    isMissing: !selectedProjectId
  },

  effective: {
    isUsableForEvent: projectIsUsableForEvent,
    isBlocking: projectIsBlocking,
    hasNonBlockingWarning: projectHasNonBlockingWarning,
    isIgnoredByCommandFlow: effectiveIsCommandFlow
  }
},

entity: {
  selectedId: selectedEntityId,
  selectedName: selectedEntityName,
  matchCount: entityMatchCount,
  isAmbiguous: entityIsAmbiguous,
  hasSingleMatch: Boolean(entitySingleMatch?.id),
  singleMatchId: entitySingleMatch?.id || null,
  singleMatchName: entitySingleMatch?.name || null,
  hasMoreSpecificMatches: Boolean(entityMatch.hasMoreSpecificMatches),
  isMissing: !selectedEntityId,

  raw: {
    matchCount: entityMatchCount,
    isAmbiguous: entityIsAmbiguous,
    hasSingleMatch: Boolean(entitySingleMatch?.id),
    singleMatchId: entitySingleMatch?.id || null,
    singleMatchName: entitySingleMatch?.name || null,
    hasMoreSpecificMatches: Boolean(entityMatch.hasMoreSpecificMatches),
    hasRawMatch: entityHasRawMatch
  },

  selection: {
    selectedId: selectedEntityId,
    selectedName: selectedEntityName,
    hasSelectedValue: entityHasSelectedValue,
    isMissing: !selectedEntityId
  },

  effective: {
    isUsableForEvent: entityIsUsableForEvent,
    isBlocking: entityIsBlocking,
    hasNonBlockingWarning: entityHasNonBlockingWarning,
    isIgnoredByCommandFlow: effectiveIsCommandFlow
  }
},

  suggestion: {
  hasProjectSuggestion,
  hasEntitySuggestion,
  hasAnySuggestion: rawHasAssociationSuggestion,

  effectiveHasProjectSuggestion:
    showAssociationSuggestions === true &&
    hasProjectSuggestion === true,

  effectiveHasEntitySuggestion:
    showAssociationSuggestions === true &&
    hasEntitySuggestion === true,

  effectiveHasAnySuggestion:
    showAssociationSuggestions === true,

  project: suggestion.project || null,
  entity: suggestion.entity || null
},

  command: {
  isCommand,
  isPureCommand,

  rawIsCommand,
  rawIsPureCommand,

  isSuppressedByEditMode:
    isEditMode && rawIsCommand,

  commandFamily: isCommand ? (command.commandFamily || null) : null,
  commandType: isCommand ? (command.commandType || null) : null,
  targetType: isCommand ? (command.targetType || null) : null,
  candidateName: isCommand ? (command.candidateName || null) : null,
  existingId: isCommand ? (command.existingId || null) : null,
  canExecute: isCommand && command.canExecute === true,
  needsCompletion: isCommand && command.needsCompletion === true,
  guideMessage: isCommand ? (command.guideMessage || null) : null
},

  preview: {
    hasHints: preview.hasHints === true,
    hints: Array.isArray(preview.hints) ? preview.hints : [],
    hasBlockingAmbiguity: preview.hasBlockingAmbiguity === true,
    hasWarning: preview.hasWarning === true,
    statusLabel: preview.statusLabel || "OK",
    missingAssociationTitle: preview.missingAssociationTitle || null,
    showMissingAssociationNotice: preview.showMissingAssociationNotice === true
  },

  readiness: {
  canShowEventPreview: showEventPreview,
  canShowCommandContainer: showCommandContainer,
  canShowEventData: showEventData,
  canShowAssociationSuggestions: showAssociationSuggestions,

  // Visibility-only flag.
  // Dice se il bottone Conferma deve essere mostrato nel flow evento/edit.
  // NON include blocchi funzionali come ambiguità o disabled state.
  canShowConfirm: showConfirm,

  // Functional readiness flag.
  // Dice se l'evento può essere confermato.
  // NON usarlo per Hidden del bottone.
  canConfirm,
  hasBlockingIssue,
  hasNonBlockingWarnings
},

diagnostics: {
  source: "input_analysis_result",
  layer: "single_interpretation_base_read_only",
  writesData: false,
  modifiesParser: false,
  modifiesMatching: false,
  modifiesVisibility: false,
  modifiesSaveFlow: false,
  modifiesDb: false,
  hasUiVisibilityDependency: false,
usesUiVisibilityOnlyAsRawDiagnostic: false,
effectiveReadinessComputedInternally: true,
isConsumptionReadyForUiVisibility: true,
antiLoopRule: "ui_visibility_state is no longer read by input_analysis_result; no reverse dependency is allowed"
}
};
```

### q2-source-command-intent-state-query

`command_intent_state.template.query` — sorgente integrale. SHA-256 UTF-8/LF `eee8a740ca33f60b15c339ff8995ff2019cf4bed91bbf6698d389fb6e248b489`, 7995 byte.

```js
// Q2: request-scoped adapter. Canonical body below is unchanged.
const req = typeof analysis_request === "undefined" ? null : analysis_request;
const values = req ? [
  {value:req.raw}, {value:req.raw}, {data:req.projects}, {data:req.entities},
  {data:req.project}, {data:req.entity}, {value:req.projectId}, {value:req.entityId}
] : [input_home,input_raw,projects_list,entities_list,project_state,entity_state,select_project,select_entity];
const result = ((input_home, input_raw, projects_list, entities_list, project_state, entity_state, select_project, select_entity) => {
const raw = String(input_home.value || input_raw.value || "").trim();

function normalizeText(value) {
  return String(value || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/\s+/g, " ")
    .trim();
}

function titleCase(value) {
  return String(value || "")
    .trim()
    .replace(/\s+/g, " ")
    .split(" ")
    .filter(Boolean)
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(" ");
}

/*
  Duplicate guard minimale.

  Scopo:
  - evitare che un comando puro proponga di creare un project/entity già esistente
  - NON sostituire project_state / entity_state
  - NON fare fuzzy matching
  - NON fare deduplicazione avanzata
  - NON decidere associazioni evento

  La verifica è solo su nome esatto normalizzato.
*/
function normalizeName(value) {
  return String(value || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/\s+/g, " ")
    .trim();
}

function findExistingByExactName(list, candidateName) {
  const normalizedCandidate = normalizeName(candidateName);

  if (!normalizedCandidate) {
    return null;
  }

  return (Array.isArray(list) ? list : []).find(item => {
    return normalizeName(item?.name) === normalizedCandidate;
  }) || null;
}

const clean = normalizeText(raw);

const emptyResult = {
  isCommand: false,
  isPureCommand: false,
  commandFamily: null,
  commandType: null,
  targetType: null,
  candidateName: null,
  existingId: null,
  needsCompletion: false,
  canExecute: false,
  guideMessage: null,
  rawInput: raw
};

if (!clean) {
  return emptyResult;
}

/*
  COMMAND INTENT GENERICO — CREATE TARGET MANCANTE

  Gestisce input troppo generici:
  - crea
  - aggiungi
  - inserisci
  - nuovo
  - nuova

  Non esegue nulla.
  Serve solo a guidare l’utente.
*/

const genericCreateCommands = /^(crea|aggiungi|inserisci|nuovo|nuova)$/;

if (genericCreateCommands.test(clean)) {
  return {
    isCommand: true,
    isPureCommand: true,
    commandFamily: "guide",
    commandType: "create_target_missing",
    targetType: null,
    candidateName: null,
    existingId: null,
    needsCompletion: true,
    canExecute: false,
    guideMessage: "Vuoi creare qualcosa? Specifica se vuoi creare un progetto o un’entità.",
    rawInput: raw
  };
}

/*
  COMMAND INTENT GENERICO — EDIT / CORRECTION ALIAS

  Gestisce input troppo generici:
  - modifica
  - correggi
  - cambia

  Non esegue nulla.
  Non apre edit flow automatico.
  Non salva eventi.
  Serve solo a evitare che alias generici vengano trattati come eventi ordinari.
*/

const genericEditGuideCommands = /^(modifica|correggi|cambia)$/;

if (genericEditGuideCommands.test(clean)) {
  return {
    isCommand: true,
    isPureCommand: true,
    commandFamily: "guide",
    commandType: "edit_generic_help",
    targetType: "event",
    candidateName: null,
    existingId: null,
    needsCompletion: false,
    canExecute: false,
    guideMessage: "Vuoi modificare un evento? Apri la lista Eventi e usa Modifica. Se sei già in modifica, usa i campi dell’evento oppure Annulla modifica.",
    rawInput: raw
  };
}

/*
  COMMAND INTENT — CREATE PROJECT / ENTITY

  Gestisce solo comandi puri espliciti:
  - crea progetto
  - crea progetto Villa Nuova
  - aggiungi progetto Villa Nuova
  - inserisci progetto Villa Nuova
  - nuovo progetto Villa Nuova

  - crea entità
  - crea entità Patrizio
  - aggiungi entità Patrizio
  - inserisci entità Patrizio
  - nuova entità Patrizio

  Non salva.
  Non crea.
  Non modifica parser.
  Non modifica matching.
  Non modifica DB.
*/

const createPatterns = [
  {
    commandType: "create_project",
    targetType: "project",
    regex: /^(crea|aggiungi|inserisci|nuovo|nuova)\s+(nuovo\s+|nuova\s+)?progetto(?:\s+(.+))?$/
  },
  {
    commandType: "create_entity",
    targetType: "entity",
    regex: /^(crea|aggiungi|inserisci|nuovo|nuova)\s+(nuovo\s+|nuova\s+)?(entita|entità)(?:\s+(.+))?$/
  }
];

for (const pattern of createPatterns) {
  const match = clean.match(pattern.regex);

  if (match) {
    let rawCandidate = match[4];

if (pattern.targetType === "project") {
  rawCandidate = match[3];
}

const candidateName = rawCandidate ? titleCase(rawCandidate) : null;

    /*
      Comando incompleto:
      - crea progetto
      - crea entità

      In questo caso NON possiamo verificare duplicati
      perché manca il nome.
    */
    if (!candidateName) {
      return {
        isCommand: true,
        isPureCommand: true,
        commandFamily: "create",
        commandType: pattern.commandType,
        targetType: pattern.targetType,
        candidateName: null,
        existingId: null,
        needsCompletion: true,
        canExecute: true,
        guideMessage: null,
        rawInput: raw
      };
    }

    /*
      Comando completo:
      prima di proporre creazione, verifica solo se esiste già
      un nome identico normalizzato in projects_list / entities_list.
    */
    let existingSource = entities_list.data;

if (pattern.targetType === "project") {
  existingSource = projects_list.data;
}

const existingItem = findExistingByExactName(
  existingSource,
  candidateName
);

    if (existingItem) {
  let existingCommandType = "entity_exists";

  if (pattern.targetType === "project") {
    existingCommandType = "project_exists";
  }

  let existingGuideMessage =
    `L’entità "${existingItem.name}" esiste già. Puoi selezionarla nei dati evento o usare un nome più specifico.`;

  if (pattern.targetType === "project") {
    existingGuideMessage =
      `Il progetto "${existingItem.name}" esiste già. Puoi selezionarlo nei dati evento o usare un nome più specifico.`;
  }

  return {
    isCommand: true,
    isPureCommand: true,
    commandFamily: "exists",
    commandType: existingCommandType,
    targetType: pattern.targetType,
    candidateName: existingItem.name,
    existingId: existingItem.id ?? null,
    needsCompletion: false,
    canExecute: false,
    guideMessage: existingGuideMessage,
    rawInput: raw
  };
}

    return {
      isCommand: true,
      isPureCommand: true,
      commandFamily: "create",
      commandType: pattern.commandType,
      targetType: pattern.targetType,
      candidateName,
      existingId: null,
      needsCompletion: false,
      canExecute: true,
      guideMessage: null,
      rawInput: raw
    };
  }
}

/*
  INTENT GUIDA — NON OPERATIVO

  Non modifica eventi.
  Non apre edit flow alternativo.
  Non seleziona automaticamente eventi.
  Non crea funzioni parallele.
  Serve solo a guidare l’utente verso funzioni già presenti.
*/

const editEventPatterns = [
  /^(modifica|correggi|cambia)\s+(un\s+|uno\s+|l'|lo\s+|il\s+)?evento$/,
  /^(come\s+)?(modifico|correggo|cambio)\s+(un\s+|uno\s+|l'|lo\s+|il\s+)?evento$/,
  /^(devo\s+)?(modificare|correggere|cambiare)\s+(un\s+|uno\s+|l'|lo\s+|il\s+)?evento$/
];

if (editEventPatterns.some(regex => regex.test(clean))) {
  return {
    isCommand: true,
    isPureCommand: true,
    commandFamily: "guide",
    commandType: "edit_event_help",
    targetType: "event",
    candidateName: null,
    existingId: null,
    needsCompletion: false,
    canExecute: false,
    guideMessage: "Per modificare un evento già creato, apri la lista eventi e usa il pulsante Modifica.",
    rawInput: raw
  };
}

return emptyResult;
})(...values);
return {...result, __logosRequestId:req?.id || null};
```

### q2-source-create-suggestion-state-query

`create_suggestion_state.template.query` — sorgente integrale. SHA-256 UTF-8/LF `fc581c669262a9ccf4a050cb2edbef9e26cd605b2a80a0492775e150fd32db63`, 14983 byte.

```js
// Q2: request-scoped adapter. Canonical body below is unchanged.
const req = typeof analysis_request === "undefined" ? null : analysis_request;
const values = req ? [
  {value:req.raw}, {value:req.raw}, {data:req.projects}, {data:req.entities},
  {data:req.project}, {data:req.entity}, {value:req.projectId}, {value:req.entityId}
] : [input_home,input_raw,projects_list,entities_list,project_state,entity_state,select_project,select_entity];
const result = ((input_home, input_raw, projects_list, entities_list, project_state, entity_state, select_project, select_entity) => {
const text = input_raw.value?.trim() || "";

const normalize = (str) =>
  String(str || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/\s+/g, " ")
    .trim();

const toTitleCase = (str) =>
  String(str || "")
    .trim()
    .replace(/\s+/g, " ")
    .split(" ")
    .map((part) => {
      if (/^\d+$/.test(part)) return part;
      return part.charAt(0).toUpperCase() + part.slice(1).toLowerCase();
    })
    .join(" ");

const cleanText = normalize(text);

const projects = projects_list.data || [];
const entities = entities_list.data || [];

const projectData = project_state.data || {};
const entityData = entity_state.data || {};

const projectCount = Number(projectData.count ?? projectData.matches?.length ?? 0);
const entityCount = Number(entityData.count ?? entityData.matches?.length ?? 0);

const projectIsAmbiguous =
  Boolean(projectData.isAmbiguous) || projectCount > 1;

const entityIsAmbiguous =
  Boolean(entityData.isAmbiguous) || entityCount > 1;

const projectHasSingle =
  Boolean(projectData.singleMatch?.id) || Boolean(select_project.value);

const entityHasSingle =
  Boolean(entityData.singleMatch?.id) || Boolean(select_entity.value);

const isMeaningful = cleanText.length >= 3;

const escapeRegex = (str) =>
  String(str || "").replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

const STOPWORDS_BASE = [
  "il", "lo", "la", "i", "gli", "le",
  "un", "uno", "una",
  "di", "del", "dello", "della", "dei", "degli", "delle",
  "a", "al", "allo", "alla", "ai", "agli", "alle",
  "da", "dal", "dallo", "dalla", "dai", "dagli", "dalle",
  "in", "nel", "nello", "nella", "nei", "negli", "nelle",
  "con", "su", "per", "tra", "fra",
  "e", "ed", "o"
];

const UNIT_KEYWORDS = [
  "euro", "eur", "ora", "ore", "h",
  "min", "minuto", "minuti",
  "giorno", "giorni", "settimana", "settimane",
  "giornata", "giornate"
];

const ECONOMIC_KEYWORDS = [
  "spesa", "acquisto", "acquistato", "comprato",
  "pagato", "pagamento", "costo", "costi",
  "uscita", "incasso", "incassato", "entrata",
  "vendita", "venduto",
  "acconto", "saldo",
  "dato", "dati",
  "versato", "versati",
  "ricevuto", "ricevuti",
  "fattura", "fatture",
  "preventivo", "preventivi",
  "ordine", "ordini",
  "cliente", "clienti",
  "fornitore", "fornitori"
];

const OPERATIONAL_CAUSAL_WORDS = [
  "sopralluogo", "sopralluoghi",
  "urgente", "urgenza",
  "lavoro", "lavori",
  "materiale", "materiali",
  "nuovo", "nuova", "nuovi", "nuove",
  "benzina",
  "mangime",
  "vaccino", "vaccini", "vaccinazione",
  "test", "prova", "prove", "regressione",
  "rendering", "render",
  "visita", "visite",
  "controllo", "controlli",
  "verifica", "verifiche",
  "manutenzione",
  "riparazione",
  "consegna", "consegnato",
  "ritiro", "ritirato"
];

const MONTH_WORDS = [
  "gennaio", "febbraio", "marzo", "aprile", "maggio", "giugno",
  "luglio", "agosto", "settembre", "ottobre", "novembre", "dicembre"
];

const stopWords = new Set([
  ...STOPWORDS_BASE,
  ...UNIT_KEYWORDS,
  ...ECONOMIC_KEYWORDS,
  ...OPERATIONAL_CAUSAL_WORDS,
  ...MONTH_WORDS
]);

const isStopWord = (word) => stopWords.has(normalize(word));

const stripKnownTokens = (input) => {
  let s = ` ${normalize(input)} `;

  // date numeriche
  s = s.replace(/\b\d{1,2}\/\d{1,2}(?:\/\d{2,4})?\b/g, " ");

  // date testuali
  for (const m of MONTH_WORDS) {
    s = s.replace(new RegExp(`\\b\\d{1,2}\\s+${m}\\b`, "g"), " ");
  }

  // importi euro
  s = s
    .replace(/€\s*\d{1,3}(?:\.\d{3})*(?:[,.]\d+)?/g, " ")
    .replace(/€\s*\d+(?:[,.]\d+)?/g, " ")
    .replace(/\b\d{1,3}(?:\.\d{3})*(?:[,.]\d+)?\s*(€|euro|eur)\b/g, " ")
    .replace(/\b\d+(?:[,.]\d+)?\s*(€|euro|eur)\b/g, " ")
    .replace(/\b(euro|eur)\s*\d{1,3}(?:\.\d{3})*(?:[,.]\d+)?\b/g, " ")
    .replace(/\b(euro|eur)\s*\d+(?:[,.]\d+)?\b/g, " ");

  // durate ore/minuti semplici e composte
  s = s
    .replace(/\b\d+(?:[,.]\d+)?\s*(h|ora|ore)\s*(?:e\s*)?\d{1,2}\s*(minuti|minuto|min)?\b/g, " ")
    .replace(/\b\d+(?:[,.]\d+)?\s*h\s*\d{1,2}\b/g, " ")
    .replace(/\b\d+(?:[,.]\d+)?\s*(h|ora|ore|minuti|minuto|min)\b/g, " ")
    .replace(/\b(h|minuti|minuto|min)\s*\d+(?:[,.]\d+)?\b/g, " ");

  return s.replace(/\s+/g, " ").trim();
};

const hasPhraseInText = (phrase, sourceText) => {
  const cleanPhrase = normalize(phrase);
  if (!cleanPhrase) return false;

  const parts = cleanPhrase.split(" ").filter(Boolean);
  if (!parts.length) return false;

  const pattern = parts.map(escapeRegex).join("\\s+");
  const regex = new RegExp(`\\b${pattern}\\b`, "i");

  return regex.test(sourceText);
};

const existsNormalized = (name, records) => {
  const n = normalize(name);
  return records.some((r) => normalize(r?.name) === n);
};

// Solo il record-base gia' identificato dallo state o scelto per UUID
// puo' originare un'estensione. L'esistenza del nome si controlla sul totale.
const findExtensionCandidate = (baseRecords, allRecords, excludedPhrases = []) => {
  const stripped = stripKnownTokens(cleanText);

  const normalizedExcluded = excludedPhrases
    .map((p) => normalize(p))
    .filter(Boolean);

  const containsExcludedPhrase = (candidate) => {
    const normalizedCandidate = normalize(candidate);

    return normalizedExcluded.some((phrase) => {
      if (!phrase) return false;

      const parts = phrase.split(" ").filter(Boolean);
      if (!parts.length) return false;

      const pattern = parts.map(escapeRegex).join("\\s+");
      const regex = new RegExp(`\\b${pattern}\\b`, "i");

      return regex.test(normalizedCandidate);
    });
  };

  const sorted = [...baseRecords]
    .filter((r) => r?.name)
    .sort((a, b) => normalize(b.name).length - normalize(a.name).length);

  for (const record of sorted) {
    const baseName = normalize(record.name);

    if (!baseName || !hasPhraseInText(baseName, stripped)) {
      continue;
    }

    const baseParts = baseName.split(" ").filter(Boolean);
    const pattern = baseParts.map(escapeRegex).join("\\s+");

    const regex = new RegExp(`\\b${pattern}\\b\\s*([a-z0-9\\s]*)`, "i");
    const match = stripped.match(regex);

    if (!match || !match[1]) {
      continue;
    }

    const trailingWords = match[1]
      .split(" ")
      .map((w) => w.trim())
      .filter(Boolean);

    const usefulExtra = [];

    for (const word of trailingWords) {
      const cleanWord = normalize(word);

      if (!cleanWord) continue;

      if (isStopWord(cleanWord)) {
        break;
      }

      if (cleanWord.length >= 3 || /^\d+$/.test(cleanWord)) {
        usefulExtra.push(cleanWord);
      }

      if (usefulExtra.length >= 3) {
        break;
      }
    }

    if (!usefulExtra.length) {
      continue;
    }

    const candidateNormalized = `${baseName} ${usefulExtra.join(" ")}`
      .replace(/\s+/g, " ")
      .trim();

    if (candidateNormalized === baseName) {
      continue;
    }

    if (existsNormalized(candidateNormalized, allRecords)) {
      continue;
    }

    // Protezione cross-layer:
    // se la candidate contiene un project/entity già riconosciuto nell'altro layer,
    // non va proposta.
    if (containsExcludedPhrase(candidateNormalized)) {
      continue;
    }

    return {
      candidateName: toTitleCase(candidateNormalized),
      baseName: record.name,
      reason: "extension"
    };
  }

  return null;
};

const findNameById = (records, id) =>
  records.find((r) => r.id === id)?.name || null;

const projectSelectedName =
  findNameById(projects, select_project.value) ||
  projectData.singleMatch?.name ||
  null;

const entitySelectedName =
  findNameById(entities, select_entity.value) ||
  entityData.singleMatch?.name ||
  null;

const projectDetectedNames = [
  projectSelectedName,
  ...(Array.isArray(projectData.matches) ? projectData.matches.map((p) => p.name) : [])
].filter(Boolean);

const entityDetectedNames = [
  entitySelectedName,
  ...(Array.isArray(entityData.matches) ? entityData.matches.map((e) => e.name) : [])
].filter(Boolean);

const buildLayerSuggestion = ({
  layer,
  count,
  isAmbiguous,
  hasSingle,
  records,
  label
}) => {
  const noMatch = isMeaningful && count === 0 && !isAmbiguous && !hasSingle;

  // Il matching resta autorita' dello state. Non ripercorrere il repertorio
  // per individuare autonomamente un record-base alternativo.
  const stateData = layer === "project" ? projectData : entityData;
  const chosenId = layer === "project" ? select_project.value : select_entity.value;
  const selectedRecord = chosenId ? records.find((r) => r.id === chosenId) : null;
  const canonicalBase = selectedRecord || stateData.singleMatch || null;
  const baseRecords = canonicalBase ? [canonicalBase] : [];
  const hasPlausibleAlternatives =
    Array.isArray(stateData.plausibleAlternatives) &&
    stateData.plausibleAlternatives.length > 0;

  const hasPrefixAlternatives =
    layer === "project" && (stateData.prefixAlternatives?.length ?? 0) > 0;

  const canLookForCandidate =
    isMeaningful &&
    !isAmbiguous &&
    hasSingle &&
    Boolean(canonicalBase) &&
    !hasPlausibleAlternatives &&
    !hasPrefixAlternatives;

  const excludedPhrases = layer === "project" ? entityDetectedNames : projectDetectedNames;
  const extension = canLookForCandidate
    ? findExtensionCandidate(baseRecords, records, excludedPhrases)
    : null;

  const candidateName = extension?.candidateName || null;

  const hasStrongCandidate =
    Boolean(candidateName) &&
    !existsNormalized(candidateName, records);

  const shouldShowNoMatchHint = noMatch && !hasPrefixAlternatives;

  // In caso di estensione con singleMatch, possiamo suggerire creazione
  // anche se il layer ha già un valore selezionato.
  const shouldSuggestCreate =
    hasStrongCandidate &&
    !isAmbiguous &&
    (
      noMatch ||
      hasSingle
    );

  let message = null;

  if (shouldSuggestCreate) {
    message = `Crea ${label} “${candidateName}”`;
  } else if (shouldShowNoMatchHint) {
    message = `Nessun ${label} associato`;
  }

return {
  layer,
  noMatch,
  isAmbiguous,
  hasSingle,
  shouldShowNoMatchHint,
  shouldSuggestCreate,
  candidateName,
  draftName: candidateName || "",
  reason: hasStrongCandidate ? extension.reason : null,
  baseName: extension?.baseName || null,

  // G22 — match presente + possibile estensione più specifica.
  // Non blocca il salvataggio.
  // Serve alla UI per segnalare che esiste già una selezione attiva
  // diversa dalla candidate suggerita.
  requiresUserOverride:
    Boolean(hasSingle) &&
    Boolean(hasStrongCandidate) &&
    extension?.reason === "extension",

  message
};
};

const project = buildLayerSuggestion({
  layer: "project",
  count: projectCount,
  isAmbiguous: projectIsAmbiguous,
  hasSingle: projectHasSingle,
  records: projects,
  label: "progetto"
});

const entity = buildLayerSuggestion({
  layer: "entity",
  count: entityCount,
  isAmbiguous: entityIsAmbiguous,
  hasSingle: entityHasSingle,
  records: entities,
  label: "entità"
});

// -----------------------------
// ENTITY AUTOFILL CANDIDATE — CONTROLLED MINIMAL
// -----------------------------
// Serve solo a precompilare input_new_entity_name.
// Non crea entità, non seleziona entità, non modifica match.

// Candidate consentita solo in caso di no-match entity reale,
// senza ambiguità e senza entity già selezionata.
const canBuildEntityAutofillCandidate =
  isMeaningful &&
  entity.noMatch &&
  !entity.isAmbiguous &&
  !entity.hasSingle;

// Parole che possono indicare una entità/persona/contatto.
// Manteniamo lista corta per evitare falsi positivi tipo "materiale nuovo".
const ENTITY_PREFIX_WORDS = [
  "referente",
  "tecnico",
  "cliente",
  "fornitore",
  "operaio",
  "collaboratore",
  "contatto",
  "responsabile",
  "muratore",
  "idraulico",
  "elettricista",
  "geometra",
  "architetto"
];

const findEntityAutofillCandidate = () => {
  if (!canBuildEntityAutofillCandidate) {
    return null;
  }

  let stripped = stripKnownTokens(cleanText);

  // Rimuove nomi progetto già rilevati/selezionati.
  let projectMatchNames = [];

if (Array.isArray(projectData.matches)) {
  projectMatchNames = projectData.matches.map((p) => p.name);
}

const projectNamesToRemove = [
  projectSelectedName,
  ...projectMatchNames
].filter(Boolean);

  for (const name of projectNamesToRemove) {
    const cleanName = normalize(name);
    if (!cleanName) continue;

    const parts = cleanName.split(" ").filter(Boolean);
    const pattern = parts.map(escapeRegex).join("\\s+");
    stripped = stripped.replace(new RegExp(`\\b${pattern}\\b`, "gi"), " ");
  }

  // Rimuove parole operative residue.
  for (const word of OPERATIONAL_CAUSAL_WORDS) {
    stripped = stripped.replace(new RegExp(`\\b${escapeRegex(word)}\\b`, "gi"), " ");
  }

  stripped = stripped
    .replace(/\s+/g, " ")
    .trim();

  if (!stripped) {
    return null;
  }

  const words = stripped
    .split(" ")
    .map((w) => normalize(w))
    .filter(Boolean)
    .filter((w) => !isStopWord(w));

  if (!words.length) {
    return null;
  }

  // Cerca pattern con prefisso entity forte:
  // referente kappa
  // tecnico alfa
  // cliente rossi
  const prefixIndex = words.findIndex((w) =>
    ENTITY_PREFIX_WORDS.includes(w)
  );

  if (prefixIndex < 0) {
    return null;
  }

  const candidateWords = [];

  for (let i = prefixIndex; i < words.length; i++) {
    const word = words[i];

    if (!word) break;
    if (isStopWord(word) && !ENTITY_PREFIX_WORDS.includes(word)) break;

    if (word.length >= 3 || /^\d+$/.test(word)) {
      candidateWords.push(word);
    }

    if (candidateWords.length >= 3) {
      break;
    }
  }

  // Richiediamo almeno:
  // - prefisso + un secondo token
  // così evitiamo candidate troppo deboli tipo solo "tecnico".
  if (candidateWords.length < 2) {
    return null;
  }

  const candidateNormalized = candidateWords.join(" ").trim();

  if (!candidateNormalized) {
    return null;
  }

  if (existsNormalized(candidateNormalized, entities)) {
    return null;
  }

  return toTitleCase(candidateNormalized);
};

const entityAutofillCandidate = findEntityAutofillCandidate();

if (
  entityAutofillCandidate &&
  !entity.candidateName &&
  !entity.draftName
) {
  entity.candidateName = entityAutofillCandidate;
  entity.draftName = entityAutofillCandidate;
}

return {
  input: text,
  cleanText,
  project,
  entity
};
})(...values);
return {...result, __logosRequestId:req?.id || null};
```

### q2-source-focus-input-home-query

`focus_input_home.template.query` — sorgente integrale. SHA-256 UTF-8/LF `8e73ff23f3310b4ad8b38aee270c71330a4bef7bac5aace49ad1395489c896fc`, 241 byte.

```js
const epoch = window.__logosAnalysisEpoch;
await ui_state.setValue({...ui_state.value,view:"home"});
if (window.__logosAnalysisEpoch !== epoch) return;
setTimeout(() => { if (window.__logosAnalysisEpoch === epoch) input_home.focus(); },200);
```

### q2-source-select1-value

`select1.template.value` — sorgente integrale. SHA-256 UTF-8/LF `321f51a11f027fee961ec3cba6f2a61c2e141a539e8b3fe6d84f12b4dea79289`, 3153 byte.

```js
{{
(() => {
  const text = (input_raw.value || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");

  const parsed = analysis_snapshot.value?.parsed || {};
  const parsedUnit = String(parsed.unit || "").toLowerCase();

  // ------------------------------------------------
  // 1. TEMPO — fonte primaria: ui_state.parsed
  // ------------------------------------------------
  // Dopo Duration Normalization tutte le durate certe
  // sono salvate come:
  // amount = totale minuti
  // unit = "minuti"
  //
  // Questo risolve casi come:
  // 2h30 rendering → Tempo
  // 1 ora lavoro → Tempo
  // 18min test → Tempo

  if (parsedUnit === "minuti") {
    return "Tempo";
  }

  // ------------------------------------------------
  // 2. ECONOMICO — solo se c'è segnale economico
  // ------------------------------------------------

  const hasEuro =
    parsedUnit === "euro" ||
    /€|\beuro\b|\beur\b/.test(text);

  // ------------------------------------------------
  // 3. INCASSO — keyword controllate
  // ------------------------------------------------
  // Regola:
  // classificare Incasso solo se il testo contiene
  // segnali abbastanza espliciti di entrata.

  const isIncasso =
    /\bincasso\b/.test(text) ||
    /\bincassato\b/.test(text) ||
    /\bentrata\b/.test(text) ||
    /\bvendita\b/.test(text) ||
    /\bvenduto\b/.test(text) ||
    /\bpagamento ricevuto\b/.test(text) ||
    /\bacconto ricevuto\b/.test(text) ||
    /\bsaldo ricevuto\b/.test(text);

  // ------------------------------------------------
  // 4. SPESA — keyword controllate
  // ------------------------------------------------
  // Regola:
  // classificare Spesa solo se il testo contiene
  // segnali abbastanza espliciti di uscita.

  const isSpesa =
    /\bspesa\b/.test(text) ||
    /\bacquisto\b/.test(text) ||
    /\bacquistato\b/.test(text) ||
    /\bcomprato\b/.test(text) ||
    /\bpagato\b/.test(text) ||
    /\bpagamento\b/.test(text) ||
    /\bcosto\b/.test(text) ||
    /\bcosti\b/.test(text) ||
    /\buscita\b/.test(text) ||
    /\bacconto dato\b/.test(text) ||
    /\bacconto versato\b/.test(text) ||
    /\bsaldo pagato\b/.test(text) ||
    /\bsaldo versato\b/.test(text);

  // ------------------------------------------------
  // 5. AMBIGUITÀ ECONOMICA
  // ------------------------------------------------
  // Se emergono segnali contrastanti, non decidere.
  // Lascia Evento per forzare scelta/hint utente.

  if (isIncasso && isSpesa) {
    return "Evento";
  }

  if (isIncasso) {
    return "Incasso";
  }

  if (isSpesa) {
    return "Spesa";
  }

  // ------------------------------------------------
  // 6. EURO SENZA DIREZIONE
  // ------------------------------------------------
  // Esempio:
  // 20 euro materiale
  // 50 euro benzina
  //
  // Non decidiamo automaticamente Spesa/Incasso.
  // Restiamo su Evento così l'utente viene guidato
  // a scegliere manualmente.

  if (hasEuro) {
    return "Evento";
  }

  // ------------------------------------------------
  // 7. DEFAULT
  // ------------------------------------------------

  return "Evento";
})()
}}
```

### Q2 — configurazione di esecuzione e stati analisi

Valori effettivi nel modello pre-Delete (nessun delta di queste query nel Delete). Scope e publisher sono proprietà operative, non prove di freschezza autonome.

```json
{
  "parse_input_controlled": {
    "id": "parse_input_controlled",
    "type": "datasource",
    "subtype": "JavascriptQuery",
    "template": {
      "queryDisabled": "",
      "runWhenModelUpdates": false,
      "_additionalScope": [
        "analysis_request"
      ],
      "runWhenPageLoads": false,
      "events": [],
      "enableCaching": false,
      "queryThrottleTime": "750",
      "updateSetValueDynamically": false
    }
  },
  "trigger_parse_debounced": {
    "id": "trigger_parse_debounced",
    "type": "datasource",
    "subtype": "JavascriptQuery",
    "template": {
      "queryDisabled": "",
      "runWhenModelUpdates": false,
      "_additionalScope": [
        "analysis_revision_id",
        "analysis_expected_context"
      ],
      "runWhenPageLoads": false,
      "events": [],
      "enableCaching": false,
      "queryThrottleTime": "750",
      "updateSetValueDynamically": true
    }
  },
  "project_state": {
    "id": "project_state",
    "type": "datasource",
    "subtype": "JavascriptQuery",
    "template": {
      "queryDisabled": "{{ false }}",
      "runWhenModelUpdates": false,
      "_additionalScope": [
        "analysis_request"
      ],
      "runWhenPageLoads": false,
      "events": [],
      "enableCaching": false,
      "queryThrottleTime": "750",
      "updateSetValueDynamically": false
    }
  },
  "entity_state": {
    "id": "entity_state",
    "type": "datasource",
    "subtype": "JavascriptQuery",
    "template": {
      "queryDisabled": "{{ false }}",
      "runWhenModelUpdates": false,
      "_additionalScope": [
        "analysis_request"
      ],
      "runWhenPageLoads": false,
      "events": [],
      "enableCaching": false,
      "queryThrottleTime": "750",
      "updateSetValueDynamically": false
    }
  },
  "command_intent_state": {
    "id": "command_intent_state",
    "type": "datasource",
    "subtype": "JavascriptQuery",
    "template": {
      "queryDisabled": "",
      "runWhenModelUpdates": false,
      "_additionalScope": [
        "analysis_request"
      ],
      "runWhenPageLoads": false,
      "events": [],
      "enableCaching": false,
      "queryThrottleTime": "750",
      "updateSetValueDynamically": false
    }
  },
  "create_suggestion_state": {
    "id": "create_suggestion_state",
    "type": "datasource",
    "subtype": "JavascriptQuery",
    "template": {
      "queryDisabled": "",
      "runWhenModelUpdates": false,
      "_additionalScope": [
        "analysis_request"
      ],
      "runWhenPageLoads": false,
      "events": [],
      "enableCaching": false,
      "queryThrottleTime": "750",
      "updateSetValueDynamically": false
    }
  },
  "focus_input_home": {
    "id": "focus_input_home",
    "type": "datasource",
    "subtype": "JavascriptQuery",
    "template": {
      "queryDisabled": "",
      "runWhenModelUpdates": false,
      "_additionalScope": [],
      "runWhenPageLoads": true,
      "events": [],
      "enableCaching": false,
      "queryThrottleTime": "750",
      "updateSetValueDynamically": true
    }
  },
  "analysis_revision": {
    "id": "analysis_revision",
    "type": "state",
    "subtype": "State",
    "template": {
      "value": "\"\""
    }
  },
  "ui_state": {
    "id": "ui_state",
    "type": "state",
    "subtype": "State",
    "template": {
      "value": "{\n  \"view\": \"home\",\n  \"parsed\": {\n    \"amount\": null,\n    \"unit\": null,\n    \"event_date\": null\n  },\n  \"status\": null,\n  \"feedback_text\": null,\n  \"feedback_project\": null\n}"
    }
  }
}
```

CHANGELOG

v01 — 2026-04-01

Definizione completa sistema input

v02 — 2026-04-02

Consolidamento parsing, preview, matching
Allineamento con implementazione Retool

v03 — 2026-04-04

introduzione separazione parsing / label
introduzione label system (non persistito)
aggiornamento preview (label + hint)
miglioramento UX suggerimenti

v04 — 2026-04-23

introduzione update_event
introduzione edit_mode
supporto editing eventi
refactor confirm flow (insert/update)
centralizzazione UI feedback
identificazione loop reattivo
allineamento comportamento reale sistema

v05 — 2026-04-30

completamento Normalization Layer Base
stabilizzazione ui_state.parsed
introduzione normalization amount formato italiano
introduzione normalization unit base
supporto unità compatte testuali
rimozione amount per numeri senza unità
eliminazione parsing legacy da button_input_confirm
allineamento insert/update a ui_state.parsed
validazione insert con dati normalizzati
validazione update con dati normalizzati
fix refresh lista dopo update
esplicitazione limiti: multi-unit, duration normalization, type classification

v06 — 2026-04-30

completamento PREVIEW ALIGNMENT BASE
documentato allineamento preview a ui_state.parsed
documentata formattazione italiana amount solo visuale
documentata visualizzazione euro con due decimali
documentato grouping migliaia visuale
documentata visualizzazione coerente ore/minuti
documentato singolare/plurale unit
documentato label cleaning preview aggiornato
documentata correzione bug "minuti" → "uti"
documentato separatore data/descrizione
documentato highlight unit-safe
confermato che parse_input_controlled non è stato modificato
confermato che ui_state.parsed non è stato modificato
confermato che save flow e DB restano invariati
aggiornamento prossimo nodo consigliato: ENGINE BASE — DURATION NORMALIZATION

v07 — 2026-04-30

completamento ENGINE BASE — DURATION NORMALIZATION
definita unità canonica tempo in minuti
durate certe ore/minuti convertite in minuti
1 ora → 60 minuti
1,5 ore → 90 minuti
1 ora e 15 minuti → 75 minuti
2h30 → 150 minuti
2 ore 30 → 150 minuti
90 minuti → 90 minuti
giorni/settimane riconosciuti come ambigui ma non convertiti
aggiornato parse_input_controlled
preview durata aggiornata con forma umana
introdotto hint “Normalizzato: X minuti”
introdotto hint durata ambigua
label cleaning aggiornato per rimuovere durate composte
insert/update validati runtime
regressioni euro/date/numeri semantici superate
nessuna modifica DB
nessuna modifica button_input_confirm
nessuna modifica insert_event/update_event
nessuna modifica matching
nessuna type classification
aggiornamento prossimo nodo consigliato: ENGINE BASE — TYPE CLASSIFICATION BASE

v08 — 2026-05-01

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
aggiornamento prossimo nodo consigliato: MATCH ENGINE UNIFICATION

v09 — 2026-05-02

completamento MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL
project_state aggiornato come fonte minima matching project
entity_state aggiornato come fonte minima matching entity
aggiunti output matching:
- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches
select_project allineato a project_state.data.singleMatch
select_entity allineato a entity_state.data.singleMatch
trigger_parse_debounced aggiorna parse_input_controlled + project_state + entity_state
btn_edit aggiorna parse_input_controlled + project_state + entity_state
match state live in create flow
match state live in edit flow
preview hint ambiguità allineati a isAmbiguous
preview highlight alimentato da matches
detection locale preview rimossa come fonte decisionale matching
confirm guard basata su ambiguità non risolta
ambiguità risolta manualmente non blocca salvataggio
nessun match non blocca salvataggio
priority match minimo implementato
ristrutturazione bagno → Ristrutturazione Bagno
casa mare → Casa Mare
villa 2 → Villa 2
hint informativo match più specifici introdotto
mario → Mario + hint entità più specifiche
villa → Villa + hint progetti più specifici
bug €500 nella label preview risolto
linting project_state/entity_state ripuliti
linting residui edit_mode/editing_event mantenuti come nodo futuro
nessuna modifica DB
nessuna modifica parser
nessuna modifica type classification
nessuna modifica duration normalization
nessun output/KPI anticipato

v10 — 2026-05-03

completamento UX / CLEANUP MICRO-BATCH POST MATCH ENGINE
documentato btn_cancel_edit
documentato annulla modifica senza update_event
documentato no-op edit guard
documentato edit senza modifiche reali senza update_event
documentato input_events_search
documentato filtro client-side lista eventi
documentata label creato/modificato
documentato fix doppia visibilità input/lista dopo Annulla
completamento LINTING / STATE HELPER CLEANUP
documentata risoluzione linting edit_mode: 'value' is not defined
documentata risoluzione linting editing_event: 'value' is not defined
rimossa dipendenza da additionalScope { value } per edit_mode / editing_event
introdotto passaggio controllato tramite window.__logos_edit_mode_value
introdotto passaggio controllato tramite window.__logos_editing_event_value
documentato edit_mode come helper tecnico window-backed
documentato editing_event come helper tecnico window-backed
documentato reset chiavi window dopo lettura helper
aggiornato btn_edit
aggiornato btn_cancel_edit
aggiornato button_input_confirm nel ramo no-op edit guard
aggiornato button_input_confirm nel reset finale dopo salvataggio reale
editing_event azzerato anche dopo update reale completato
create flow validato
edit flow validato
annulla modifica validato
edit senza modifiche reali validato
edit con modifica reale validato
updated_at / label creato-modificato validati
WRITTEN / ERROR validati
DB invariato
parser invariato
Match Engine invariato
Type Classification invariata
Duration Normalization invariata
preview invariata
lista eventi invariata
nessun output/KPI anticipato
aggiornamento next step consigliati post linting cleanup

v11 — 2026-05-07

completamento PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
documentato create_suggestion_state
documentata creazione inline project/entity
documentato insert_project
documentato insert_entity
documentato container suggestion inline
documentati input_new_project_name / input_new_entity_name
documentato bottone Ignora globale
documentati bottoni Annulla contestuali
documentato entity autofill controlled minimal
documentato reset suggestion stale in trigger_parse_debounced
documentato che suggestion ≠ salvataggio
documentato che input evento ≠ command intent
documentato che evento non viene salvato automaticamente dopo creazione project/entity
documentato che project/entity mancanti non bloccano salvataggio
documentato che project/entity ambigui bloccano salvataggio
documentato flow combinato project + entity validato
documentato no-match generico salvabile
documentato ambiguità entity bloccante
documentato entity autofill positivo e negativo
documentato edit/no-op non regressivo dopo create suggestion
DB schema invariato
parser invariato
type classification invariata
duration normalization invariata
nessun output/KPI anticipato
aggiornati next step consigliati post create suggestion

v12 — 2026-05-09

- integrazione UX MOBILE COHERENCE PASS
- documentata Home mobile rifinita
- documentati Dati evento compatti con label inline
- documentato feedback_summary in ui_state
- documentato Feedback System mobile
- documentato feedback temporaneo non persistente
- documentato routing post-save contestuale
- documentato insert reale → feedback 1800 ms → Home
- documentato update reale → feedback 1800 ms → Lista eventi
- documentato no-op edit → Lista eventi immediata senza update_event
- documentato cancel create/input → Home
- documentato cancel edit → Lista eventi
- documentato cancel contestuale create/edit
- documentata Navigation dock Home / Eventi / Dashboard
- documentata Dashboard predisposta ma disabilitata
- documentata nav nascosta durante input attivo e feedback
- documentato handle_event_success non più gestore UI post-save
- documentata centralizzazione feedback/routing in button_input_confirm
- documentati Icon add-ons Retool nei componenti reali
- documentato font-size 16px input/select per Safari iOS
- documentato fix zoom automatico iOS Safari
- documentate select mobile funzionanti sia in digitazione sia in dropdown
- documentata validazione reale iPhone 13 Safari
- confermato DB invariato
- confermato parser invariato
- confermato matching invariato
- confermato create_suggestion_state invariato
- confermata type classification invariata
- confermata duration normalization invariata
- nessun output/KPI anticipato

v13 — 2026-05-13

- integrazione COMMAND INTENT — CREATE PROJECT / ENTITY
- documentato command_intent_state
- documentato container_command_intent
- documentati input_command_project_name / input_command_entity_name
- documentati btn_command_create_project / btn_command_create_entity / btn_command_go_events
- aggiornato principio INPUT EVENTO ≠ COMMAND INTENT
- documentato comando generico “crea”
- documentato create project incompleto
- documentato create project completo
- documentato create entity incompleto
- documentato create entity completo
- documentati sinonimi base crea / aggiungi / inserisci / nuovo / nuova
- documentato elemento già presente
- documentata guida non operativa “modifica evento”
- documentato che comandi puri non salvano eventi
- documentato che project/entity da command richiedono conferma utente
- documentato riuso insert_project / insert_entity
- documentato feedback_mode in ui_state
- documentato feedback project_created
- documentato feedback entity_created
- documentato feedback evento ordinario preservato
- documentato feedback_summary strutturale per progetto/entità
- documentato Command Intent Flow
- aggiornato trigger_parse_debounced con command_intent_state
- aggiornato Mobile Safari Baseline includendo input command
- aggiornati limiti attuali
- aggiunti test Command Intent validati
- aggiornati next step consigliati post Command Intent
- documentati residui:
  - rendering progressivo input evento normale
  - “Da verificare” interno alla Sintesi
  - input analysis model unico non implementato
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- type classification invariata
- duration normalization invariata
- nessun output/KPI anticipato

v14 — 2026-05-18

- integrazione UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
- integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
- documentato principio UI READINESS ≠ INPUT ANALYSIS MODEL COMPLETO
- documentato ui_visibility_mode come Variable Retool
- documentato ui_visibility_state come Transformer read-only
- ui_visibility_mode supporta empty / event / command
- trigger_parse_debounced aggiorna ui_visibility_mode
- documentato window.__logos_visibility_run_id
- documentata classificazione locale event/command solo per visibilità UI
- documentato che ui_visibility_state non sostituisce parser, matching, command_intent_state o create_suggestion_state
- aggiornata architettura input con ui_visibility_mode e ui_visibility_state
- aggiornata pipeline input:
  input_home → input_raw → trigger_parse_debounced → ui_visibility_mode → command_intent_state / parser / matching / suggestion → ui_visibility_state
- documentata centralizzazione Hidden principali:
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
- text_input_analysis_loading documentato
- text_edit_mode_notice documentato
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
- cleanup obsolete UI guards / query reduction rimandato
- aggiornati next step consigliati post UI Readiness

v15 — 2026-05-20

- integrazione PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
- documentato preview_analysis_state come Transformer read-only
- documentato preview_analysis_state come fonte hint/status/warning/Da verificare/associazioni mancanti della Sintesi
- documentato che preview_analysis_state non modifica parser, matching, command_intent_state, create_suggestion_state, save flow o DB

- integrazione INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
- documentato input_analysis_result come Transformer compositivo read-only
- documentata distinzione raw / selection / effective
- documentato event / command / edit effective flow
- documentato command raw vs command effective
- documentato edit mode prevalente su command intent
- documentato project/entity raw match vs effective usability
- documentato che input_analysis_result non alimenta select_project / select_entity
- documentato che input_analysis_result non costruisce payload save
- documentato che input_analysis_result non sostituisce parser o matching

- integrazione INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS
- documentato input_analysis_result come fonte UI controllata parziale
- documentata migrazione di sintesi.Hidden a input_analysis_result
- documentata migrazione di text_event_data_title / select1 / select_project / select_entity Hidden a input_analysis_result
- documentata migrazione di container_command_intent.Hidden a input_analysis_result
- documentata migrazione di container_association_suggestions.Hidden a input_analysis_result
- documentata micro-copy notice associazioni mancanti coerente con presenza reale suggerimenti
- documentato edit mode + input vuoto stabilizzato
- documentato Home idle container nascosti durante edit mode
- documentato Dati evento / Sintesi / Conferma nascosti con edit input vuoto
- documentato che solo Annulla modifica resta visibile in edit input vuoto
- documentato che in quella fase ui_visibility_state restava operativo e non deprecato; stato successivamente superato da Visibility Migration Completion, che lo ha riclassificato come residuo tecnico deprecabile / rollback
- documentato che container_input / loading / cancel / confirm restano fuori dalla migrazione corrente
- documentato che button_input_confirm non è ancora migrato
- documentato che button_input_confirm payload resta invariato
- documentato che save readiness non è centralizzata
- documentato aumento linting Retool a 19
- aggiornati limiti attuali
- aggiornati test validati
- aggiornati next step consigliati
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- command_intent_state invariato
- insert_event / update_event invariati
- insert_project / insert_entity invariati
- nessun output/KPI anticipato

v16 — 2026-05-23

- integrazione INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
- documentata migrazione container_input.Hidden a input_analysis_result
- documentata migrazione text_input_analysis_loading.Hidden a input_analysis_result
- documentata migrazione btn_cancel_edit.Hidden a input_analysis_result
- documentata migrazione btn_cancel_input_home.Hidden a input_analysis_result
- documentato canShowConfirm come flag visibility-only
- documentata migrazione button_input_confirm.Hidden a input_analysis_result.readiness.canShowConfirm
- documentato canShowConfirm distinto da canConfirm
- documentato button_input_confirm.Disabled invariato
- documentato button_input_confirm payload invariato
- documentata rimozione dipendenza input_analysis_result → ui_visibility_state
- documentato che input_analysis_result non legge più ui_visibility_state
- documentato ui_visibility_state come residuo tecnico deprecabile
- documentato ui_visibility_mode come latch leggero empty / event / command
- documentato routing principale app su ui_state.view
- documentati test Visibility Migration Completion
- documentato residuo label “Importo” su durata

- integrazione LINTING / RETOOL QUERY SAFETY PASS
- documentato linting Retool azzerato
- documentata sostituzione ternari multilinea ambigui con if / else equivalenti
- documentate correzioni in input_analysis_result
- documentate correzioni in preview_analysis_state
- documentate correzioni in create_suggestion_state
- documentate correzioni in command_intent_state
- documentata eliminazione query legacy typing_state
- documentata eliminazione query legacy handle_event_success
- documentata Performance unused query risolta
- documentati test post-rimozione query legacy
- confermato DB invariato
- confermato parser invariato
- confermato matching invariato
- confermato command intent invariato nella logica funzionale
- confermato suggestion invariata nella logica funzionale
- confermato save flow invariato
- confermato payload invariato
- aggiornati limiti attuali
- aggiornati next step consigliati

v17 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicato Pacchetto C — Documenti tecnici canonici su 01_LOGOS_Input_System
- documento aggiornato da v16 a v17
- confermato 01_LOGOS_Input_System come fonte canonica per input flow, parser, normalization, duration normalization, type classification base nel contesto input, Command Intent, create_suggestion_state e input_analysis_result
- aggiunta sezione RESPONSABILITÀ CANONICA DEL DOCUMENTO
- aggiunti richiami canonici a:
  - 02_LOGOS_Match_Engine per matching project/entity completo
  - 03_LOGOS_Event_Lifecycle per lifecycle evento
  - 04_LOGOS_Retool_Architecture per componenti/query/Hidden/wiring Retool
  - 05_LOGOS_Database_Schema per schema DB
  - 06_LOGOS_View_Preview_System per Sintesi, preview, hint, warning e label visuali
  - LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
  - LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase as-is
- chiarito che State, Roadmap e Gap Register non duplicano più il dettaglio tecnico lungo dell’input system
- chiarito che il dettaglio completo resta in questo documento e nei documenti canonici collegati
- corretto residuo documentale su container_input stabilizzato tramite ui_visibility_state
- chiarito che input_analysis_result governa gli Hidden principali del flow input
- ribadito che ui_visibility_state resta residuo tecnico deprecabile / rollback
- aggiornato riferimento alla visibilità Sintesi da ui_visibility_state.showEventPreview a input_analysis_result.readiness.canShowEventPreview
- aggiunta nota canonica nella sezione Matching Base
- aggiunta nota canonica nella sezione Preview System
- aggiornata sezione NEXT STEP / STATO DOCUMENTALE
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

v18 — 2026-06-01

- aggiornamento post BUTTON CONFIRM READINESS ALIGNMENT
- documento aggiornato da v17 a v18
- documentato aggiornamento button_input_confirm.Disabled nel contesto input
- Disabled ora legge solo project_state.data?.isAmbiguous e entity_state.data?.isAmbiguous
- rimosso fallback grezzo matches.length > 1 dalla guard Disabled
- confermato button_input_confirm.Hidden invariato
- confermato canShowConfirm come visibility-only
- confermato canConfirm come readiness funzionale distinta
- confermato button_input_confirm.Disabled come guard funzionale separata
- confermato button_input_confirm.Disabled non migrato dentro input_analysis_result
- confermato input_analysis_result invariato
- confermato button_input_confirm payload invariato
- confermati insert_event / update_event invariati
- confermato save flow invariato
- confermato parser invariato
- confermata normalization invariata
- confermata duration normalization invariata
- confermata type classification invariata
- confermato matching invariato nella logica funzionale
- confermati project_state/entity_state come fonti matching
- confermati select_project/select_entity come fonti salvabili finali
- confermato command_intent_state invariato
- confermato create_suggestion_state invariato
- confermato preview_analysis_state invariato
- confermato DB invariato
- confermato Supabase invariato
- test AS-IS eseguiti su evento normale, spesa, durata, no-match, match univoco, warning più specifici, command intent, edit flow
- test mirati eseguiti su dati reali projects/entities
- test post-fix superati:
  - 20 euro materiale
  - 20 euro villa
  - 20 euro villa sierri
  - crea progetto test
- confermato che warning “progetti più specifici” e “entità più specifiche” restano non bloccanti
- rilevato fuori nodo rischio match generico / auto-select confidence
- caso osservato: 20 euro villa sierri → select_project = Villa + suggerimento nuovo progetto Villa Sierri
- deciso di assorbire il tema nel gap G22 Project Create Suggestion — Match Present / User Override
- nessun nuovo gap autonomo creato per evitare ridondanza e loop documentali
- nessuna anticipazione Match Engine Advanced
- nessuna modifica select options / candidate filtering
- nessuna modifica save readiness centralizzata
- nessuna anticipazione dashboard / KPI / output

v19 — 2026-06-04

- aggiornamento post PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE / AUTO-SELECT CONFIDENCE
- G22 completato a primo livello controllato
- documentato requiresUserOverride in create_suggestion_state
- chiarito che requiresUserOverride segnala match presente + suggestion extension
- chiarito che requiresUserOverride non modifica parser
- chiarito che requiresUserOverride non modifica project_state / entity_state
- chiarito che requiresUserOverride non modifica select_project / select_entity
- chiarito che requiresUserOverride non modifica button_input_confirm.Disabled
- chiarito che requiresUserOverride non modifica payload o save flow
- preview_analysis_state aggiornato per mostrare warning mirato:
  - Associazione progetto da controllare
  - Associazione entità da controllare
- create_suggestion_hint mantenuto come area di azione:
  - Possibile nuovo progetto
  - Possibile nuova entità
- rimossa duplicazione semantica tra Da verificare e Suggerimenti associazione
- documentato comportamento project:
  - 20 euro villa
  - 20 euro villa sierri
  - 20 euro villa sierri 6
- documentato comportamento entity:
  - 20 euro tecnico mario
  - 20 euro mario rossi
  - 20 euro mario giordano
- confermato che G22 non blocca Conferma
- confermato che suggestion ignorata non blocca salvataggio
- confermato che G22 non richiede G10A
- confermato Command Intent non regressivo
- confermato parser invariato
- confermato matching primario invariato
- confermato payload invariato
- confermato save flow invariato
- confermato DB invariato
- confermato Supabase invariato
- registrati residui fuori nodo:
  - balloon blu “Manca progetto / Manca entità” da rivalutare in nodo Preview/UX futuro
  - badge OK / status Sintesi da rivalutare in Status Semantics Alignment
  - residui grafici/mobile polish da trattare in nodi UX dedicati o sessioni brevi

  v20 — 2026-06-15

- aggiornamento post INPUT CONTEXT CONSISTENCY — EDIT / SUGGESTION / COMMAND BOUNDARY
- documentato micro-nodo tecnico-funzionale su coerenza contesto input/edit/command/suggestion
- documentata gestione alias generici:
  - modifica
  - correggi
  - cambia
- command_intent_state aggiornato con commandType edit_generic_help
- alias generici trattati come guida non operativa
- create flow protetto:
  - modifica / correggi / cambia non creano eventi
  - non mostrano Sintesi evento
  - non mostrano Dati evento
  - non mostrano Conferma evento
- txt_command_intent_description aggiornato con micro-copy per edit_generic_help
- input_analysis_result rollbackato alla base stabile dopo test su approccio più invasivo
- confermato che input_analysis_result non viene modificato nel risultato finale del nodo
- confermata regola edit mode prevale su Command Intent a livello effective
- button_input_confirm aggiornato con EDIT MODE COMMAND GUARD locale
- guard locale blocca command freschi durante edit mode prima di update_event
- esempi bloccati in edit mode:
  - modifica
  - correggi
  - cambia
  - crea progetto test
  - crea entità test
- la guard mostra notifica warning
- la guard non chiude edit mode
- la guard non modifica payload
- la guard non modifica button_input_confirm.Disabled
- la guard non modifica insert_event / update_event
- text_edit_mode_notice aggiornato con micro-copy contestuale
- notice standard:
  Evento in modifica · Premi Annulla modifica per uscire.
- notice con command rilevato:
  Comando rilevato · Premi Annulla modifica prima di usare comandi.
- command create project/entity durante edit mode non crea project/entity
- command create project/entity durante edit mode non aggiorna eventi
- edit flow con input evento valido resta funzionante
- Annulla modifica non regressivo
- G22 non regressivo
- 20 euro villa sierri validato invariato
- linting Retool 0
- performance tornata accettabile dopo rollback input_analysis_result
- residuo UX accettato:
  in edit mode Sintesi / Suggerimenti associazione / Dati evento restano visibili anche quando l’input è command riconosciuto
- residuo classificato come accettabile perché update_event e creazioni improprie sono bloccati
- nessuna modifica DB
- nessuna modifica Supabase
- nessuna modifica payload
- nessuna modifica save flow
- nessuna modifica button_input_confirm.Disabled
- nessuna modifica Match Engine
- nessuna riapertura G22
- nessuna anticipazione G10A
- nessun fuzzy matching
- nessun alias system globale
- nessun Input Analysis Model completo

v21 — 2026-11-09 — Preparazione documentale N18/DOC-01, non ancora copiata o pubblicata. Revisione R04: riconciliazione integrale delle sezioni preesistenti e dei rinvii, con matrice dedicata; copertura tecnica N18 e Source Coverage R03 preservate.

- Allineati input suggestion e Command Intent alla procedura condivisa N18 e al default ACTIVE sui quattro percorsi.
- Documentati ordine della selezione T1B, invarianti evento, residui R1/R2 e limiti N17 non implementati.

v22 — 2026-11-12 — N20/DOC-01, candidato PREPARE. Riconciliati input, creazione N18, R1 N19 ed Editor Stato N20 senza attribuire modifiche al flow input.

v23 — 2026-11-15 — N21, candidato PREPARE documentale. Contratto e prove nel raccordo N21 in apertura. Copia, verifica documentale assistita e pubblicazione Git pendenti.

v24 — 2026-11-16 — N21/DOC PREPARE R03: integrati matching, suggestion, Select e confine con il flusso N18 nelle sezioni operative.

v25 — 2026-11-20 — Q2/STEP 4 PREPARE documentale finale: contratti correnti inline, sorgenti/configurazioni di competenza e rinvii riconciliati; storia preservata. Nessuna propria copia/Apply o pubblicazione attestata.