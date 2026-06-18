# 00_PROJECT_Gap_Register_v20

DATA: 2026-06-15

------------------------------------------------
SCOPO
------------------------------------------------

Tracciare i gap strutturali, funzionali, UX e documentali emersi durante audit,
sviluppo reale e sessioni operative LOGOS.

Il Gap Register serve a:

- conservare debiti e nodi futuri
- distinguere gap integrati da gap aperti
- impedire perdita di elementi strategici
- evitare apertura di nodi non prioritari
- mantenere ordine tra backlog, roadmap e stato reale
- supportare la Roadmap senza duplicarla

Il documento NON deve diventare:

- diario operativo completo
- duplicato dello State
- duplicato della Roadmap
- duplicato dei documenti tecnici canonici
- raccolta completa dei test già consolidati altrove

Regola:

il Gap Register registra il gap, lo stato, la priorità e l’azione futura.

Il dettaglio tecnico completo resta nei documenti canonici:

- 01_LOGOS_Input_System per input / parser / command / input_analysis_result
- 02_LOGOS_Match_Engine per matching project/entity
- 03_LOGOS_Event_Lifecycle per lifecycle evento
- 04_LOGOS_Retool_Architecture per componenti/query/Hidden/wiring Retool
- 05_LOGOS_Database_Schema per schema DB
- 06_LOGOS_View_Preview_System per Sintesi / preview / hint / warning
- LOGOS_RETOOL_RUNTIME_REAL per runtime Retool reale as-is
- LOGOS_SUPABASE_RUNTIME_REAL per runtime Supabase as-is

------------------------------------------------
STATO GAP
------------------------------------------------

Ogni gap può essere:

- IDENTIFICATO
- IN OSSERVAZIONE
- VALIDATO
- INTEGRATO PARZIALE
- INTEGRATO
- INTEGRATO BASE
- SCARTATO
- NON PRIORITARIO

------------------------------------------------
GAP REGISTER — SINTESI CONTROLLATA
------------------------------------------------

Il dettaglio storico/implementativo dei gap integrati non viene duplicato qui.

Questo registro mantiene:

- ID gap
- stato
- significato operativo
- azione futura
- fonte canonica per il dettaglio completo

------------------------------------------------
GAP ATTIVO DEL NODO CORRENTE
------------------------------------------------

Nessun gap attivo del nodo corrente.

Il nodo INPUT CONTEXT CONSISTENCY — EDIT / SUGGESTION / COMMAND BOUNDARY è stato completato.

Gap trattati:

- G21 — Suggestion Create vs Edit Consistency
- G30 — Command Intent — Edit Guide Generic Alias

Classificazione finale:

G21:
INTEGRATO PARZIALE — CONFINE EDIT / COMMAND / SUGGESTION STABILIZZATO A PRIMO LIVELLO

G30:
INTEGRATO BASE — ALIAS GENERICI MODIFICA / CORREGGI / CAMBIA GESTITI COME GUIDE NON OPERATIVE

Esito:

- create flow protetto da eventi impropri su alias generici
- edit flow protetto da update_event impropri su command riconosciuti
- command create project/entity bloccati funzionalmente durante edit mode
- command_intent_state aggiornato con edit_generic_help
- txt_command_intent_description aggiornato con micro-copy dedicata
- button_input_confirm aggiornato con EDIT MODE COMMAND GUARD locale
- text_edit_mode_notice aggiornato con micro-copy contestuale
- input_analysis_result rollbackato alla base stabile dopo test su approccio più invasivo

Comportamento consolidato:

Create flow:

modifica / correggi / cambia
→ command rilevato
→ guida non operativa visibile
→ nessuna Sintesi evento
→ nessun Dati evento
→ nessuna Conferma evento
→ nessun evento creato

Edit flow:

modifica / correggi / cambia
→ edit mode resta attivo
→ notice contestuale visibile
→ Conferma bloccata da guard
→ nessun update_event

crea progetto test / crea entità test durante edit mode
→ nessun project/entity creato
→ nessun update_event
→ warning mostrato
→ edit mode resta attivo

Test validati:

- create flow modifica → nessun evento creato
- create flow correggi → nessun evento creato
- create flow cambia → nessun evento creato
- create flow crea progetto test → command funzionante
- create flow crea entità test → command funzionante
- edit flow modifica → nessun update_event
- edit flow correggi → nessun update_event
- edit flow cambia → nessun update_event
- edit flow crea progetto test → nessun project creato, nessun update_event
- edit flow crea entità test → nessuna entity creata, nessun update_event
- edit flow con input evento valido → update_event corretto
- Annulla modifica → funzionante
- G22 20 euro villa sierri → non regressivo
- linting Retool 0

Non modificati:

- DB
- Supabase
- payload
- insert_event / update_event
- button_input_confirm.Disabled
- Match Engine
- G22
- parser
- save flow
- input_analysis_result nel risultato finale del nodo

Residuo UX accettato:

in edit mode, quando viene rilevato un command:

- Sintesi può restare visibile
- Suggerimenti associazione possono restare visibili
- Dati evento possono restare visibili

Decisione:

il residuo è accettato perché update_event e creazioni improprie sono bloccati funzionalmente.

Non correggere ora tramite input_analysis_result o Hidden multipli.

Classificazione:

- G30 chiuso come integrato base
- G21 chiuso per la parte command/edit/suggestion trattata nel nodo
- residui avanzati di G21 restano solo se emergeranno casi reali non coperti
- non aprire Input Analysis Model completo per questo residuo UX
- non riaprire G22
- non aprire G10A
- non introdurre alias system globale
- non introdurre fuzzy/typo command recognition

Fonte canonica:
- 01_LOGOS_Input_System
- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

------------------------------------------------
GAP RESIDUI PRIORITARI
------------------------------------------------

ID: G29

NOME:
Feedback / Input Flow Micro-flash Cleanup

STATO:
IN OSSERVAZIONE — RESIDUO UX MINORE ACCETTABILE

DESCRIZIONE:

Il nodo INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION ha analizzato il flash/riga container_input durante transizioni input / command / empty.

Il comportamento è risultato:

- riproducibile
- visivo
- non bloccante
- privo di errori console
- non collegato a parser
- non collegato a matching
- non collegato a DB
- non collegato a payload
- non collegato a save flow

Sono stati testati senza soluzione stabile definitiva:

- Hidden di container_input
- Hidden dei figli principali
- layout/stile di container_input
- container_home
- wrapper
- micro-latch input_shell_visible

Esito:

- nessuna modifica runtime definitiva mantenuta
- rollback effettuato alla base stabile
- residuo classificato come accettabile e da mantenere in osservazione

Azione:

non riaprire come micro-fix ordinario.

Riaprire solo se:

- il flash peggiora sensibilmente
- diventa bloccante
- genera regressioni UX reali
- viene aperto un nodo dedicato/refactor sulla visibility/rendering del flow input

Vincoli:

- non inseguire ulteriormente micro-flash non bloccanti
- non modificare parser
- non modificare matching
- non modificare DB
- non modificare insert/update
- non modificare payload
- non modificare save flow
- non introdurre latch paralleli senza nodo dedicato
- non eliminare ui_visibility_state fuori cleanup dedicato

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

ID: G33

NOME:
Button Confirm Readiness Alignment

STATO:
INTEGRATO

DESCRIZIONE:

button_input_confirm.Hidden era già migrato a input_analysis_result.readiness.canShowConfirm.

Nel nodo BUTTON CONFIRM READINESS ALIGNMENT è stato verificato e aggiornato button_input_confirm.Disabled.

Esito:

- Hidden resta governato da input_analysis_result.readiness.canShowConfirm
- canShowConfirm resta visibility-only
- canConfirm resta readiness funzionale distinta
- Disabled resta guard funzionale separata
- Disabled ora legge solo project_state.data?.isAmbiguous e entity_state.data?.isAmbiguous
- rimosso fallback grezzo matches.length > 1
- payload invariato
- insert_event / update_event invariati
- parser invariato
- matching invariato nella logica funzionale
- input_analysis_result invariato
- DB invariato

Decisione:

G33 è chiuso.
Non resta nodo operativo aperto su button_input_confirm.Disabled.

Residui collegati ma fuori G33:

- save readiness completa non centralizzata
- button_input_confirm.Disabled non migrato dentro input_analysis_result
- match generico salvabile / auto-select confidence da assorbire in G22

Regola:

Non riaprire G33 salvo regressione reale del bottone Conferma.
Eventuali evoluzioni future della save readiness devono essere nodo separato.

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

ID: G17

NOME:
Preview Model / Hint State Consolidation

STATO:
IN OSSERVAZIONE — CANDIDATO POST INPUT ANALYSIS RESULT

DESCRIZIONE:

La Sintesi resta layer ibrido:

- rendering
- label cleaning
- highlight
- micro-copy
- hint/warning/status
- blocco “Da verificare”

preview_analysis_state ha ridotto parte della logica embedded,
ma non ha trasformato la Sintesi in view pura.

Azione:

valutare nodo dedicato solo dopo chiusura audit documentale o se emerge problema UX prioritario.

Fonte canonica:
- 06_LOGOS_View_Preview_System

---

ID: G35

NOME:
Status Semantics Alignment

STATO:
IDENTIFICATO — RESIDUO UX/SEMANTICO POST G22

DESCRIZIONE:

In alcuni casi la Sintesi può mostrare status OK insieme a card “Da verificare”.

Il nodo G22 ha reso più evidente il residuo:

- la card Da verificare può mostrare un warning decisionale non bloccante
- il badge OK può restare semanticamente debole se l’utente legge dall’alto verso il basso
- il problema è visuale/semantico, non funzionale

Esempio:

Da verificare:
Associazione progetto da controllare
Villa selezionato · testo letto: Villa Sierri

ma status Sintesi ancora OK.

Azione:

valutare nodo dedicato STATUS SEMANTICS ALIGNMENT.

Obiettivo:

- riallineare OK / Verifica / Attenzione alla presenza reale di warning significativi
- migliorare comprensione mobile
- non modificare save flow
- non modificare button_input_confirm.Disabled
- non trasformare warning non bloccanti in blocchi

Vincoli:

- non modificare payload
- non modificare DB
- non modificare Supabase
- non modificare matching
- non riaprire G22 salvo regressione reale
- non anticipare Input Analysis Model completo

Fonte canonica:
- 06_LOGOS_View_Preview_System
- 04_LOGOS_Retool_Architecture

---

ID: G38

NOME:
Preview / Missing Association Notice Cleanup

STATO:
IDENTIFICATO — RESIDUO UX/SEMANTICO POST G22

DESCRIZIONE:

Il balloon blu “Manca progetto / Manca entità” può risultare ridondante rispetto al container Suggerimenti associazione in alcuni casi.

Durante G22 è emerso che l’utente legge la UI dall’alto verso il basso:

- Sintesi
- Da verificare
- notice associazioni mancanti
- Suggerimenti associazione
- Dati evento

Il notice resta utile perché informa che manca un’associazione anche quando non esiste una suggestion operativa.

Tuttavia può creare rumore se nella stessa schermata sono già presenti suggerimenti operativi chiari.

Azione:

valutare nodo dedicato Preview/UX.

Obiettivo:

- decidere se mantenere il notice nella Sintesi
- decidere se spostarlo, ridurlo o renderlo più contestuale
- mantenere distinta la notice informativa dalla suggestion operativa
- migliorare leggibilità mobile

Vincoli:

- nessuna modifica DB
- nessuna modifica payload
- nessuna modifica save flow
- nessuna modifica button_input_confirm.Disabled
- nessuna modifica create_suggestion_state salvo necessità esplicita
- nessuna modifica G22 salvo regressione reale

Fonte canonica:
- 06_LOGOS_View_Preview_System
- 04_LOGOS_Retool_Architecture
- 01_LOGOS_Input_System

---

ID: G39

NOME:
Edit Mode Command-like Visual Residue

STATO:
IN OSSERVAZIONE — RESIDUO UX ACCETTABILE

DESCRIZIONE:

Dopo il nodo INPUT CONTEXT CONSISTENCY,
i command riconosciuti durante edit mode vengono bloccati funzionalmente.

Tuttavia, quando l’utente scrive un command durante edit mode, possono restare visibili:

- Sintesi
- Suggerimenti associazione
- Dati evento

Il comportamento è visivamente ambiguo,
ma non genera rischi funzionali perché:

- update_event viene bloccato da button_input_confirm
- project/entity non vengono creati
- edit mode resta attivo
- Annulla modifica resta disponibile
- text_edit_mode_notice mostra guidance contestuale

Esempi:

- edit mode + modifica
- edit mode + correggi
- edit mode + cambia
- edit mode + crea progetto test
- edit mode + crea entità test

Azione:

non aprire come nodo immediato.

Rivalutare solo se:

- il residuo confonde realmente l’utente in uso continuativo
- si apre un nodo dedicato su edit mode UI / command visibility
- si decide consapevolmente di intervenire sugli Hidden senza destabilizzare input_analysis_result

Vincoli:

- non modificare input_analysis_result fuori nodo dedicato
- non rendere container_command_intent operativo in edit mode
- non modificare save flow
- non modificare payload
- non modificare button_input_confirm.Disabled
- non riaprire G21 o G30 salvo regressione reale
- non introdurre Input Analysis Model completo per un residuo visuale

Fonte canonica:
- 01_LOGOS_Input_System
- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

ID: G30

NOME:
Command Intent — Edit Guide Generic Alias

STATO:
INTEGRATO BASE

DESCRIZIONE:

Il nodo INPUT CONTEXT CONSISTENCY — EDIT / SUGGESTION / COMMAND BOUNDARY ha integrato a primo livello controllato gli alias generici:

- modifica
- correggi
- cambia

Comportamento:

- riconosciuti da command_intent_state
- commandType = edit_generic_help
- commandFamily = guide
- canExecute = false
- trattati come guide non operative
- non salvano eventi
- non aprono edit flow automatico
- non modificano record

Create flow:

- mostra guida generica non operativa
- nasconde Sintesi evento
- nasconde Dati evento
- nasconde Conferma evento
- nessun insert_event

Edit flow:

- edit mode resta prevalente
- text_edit_mode_notice mostra guidance contestuale
- button_input_confirm blocca update_event se il command è fresco
- nessun update_event
- nessun insert_project / insert_entity

Residui fuori G30:

- alias system globale non implementato
- fuzzy / typo command recognition non implementati
- “modifica progetto” non gestito come command strutturale
- guidance UI più pulita in edit mode possibile solo in nodo futuro dedicato

Regola:

G30 non deve essere riaperto come nodo base.
Riaprire solo se:

- modifica / correggi / cambia tornano a essere salvabili come eventi
- modifica / correggi / cambia tornano a produrre update_event
- emergono regressioni command_intent_state su edit_generic_help

Fonte canonica:
- 01_LOGOS_Input_System
- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

ID: G21

NOME:
Suggestion Create vs Edit Consistency

STATO:
INTEGRATO PARZIALE — COMMAND / EDIT BOUNDARY STABILIZZATO

DESCRIZIONE:

Il nodo INPUT CONTEXT CONSISTENCY — EDIT / SUGGESTION / COMMAND BOUNDARY ha stabilizzato la parte più rischiosa del gap:

- input command-like durante edit mode
- command create project/entity durante edit mode
- alias generici modifica / correggi / cambia
- rischio update_event improprio
- rischio creazione strutturale impropria durante edit mode

Esito:

- command riconosciuti durante edit mode non diventano update_event
- crea progetto / crea entità durante edit mode non creano record strutturali
- modifica / correggi / cambia non creano eventi in create flow
- modifica / correggi / cambia non aggiornano eventi in edit flow
- button_input_confirm contiene guard locale contro command freschi in edit mode
- input_analysis_result resta alla base stabile

Residuo UX accettato:

in edit mode, quando viene rilevato un command, possono restare visibili:

- Sintesi
- Suggerimenti associazione
- Dati evento

Classificazione residuo:

UX non bloccante.

Motivo:

- update_event è bloccato
- project/entity non vengono creati
- edit mode resta attivo
- Annulla modifica resta disponibile
- save flow resta sicuro

Azione futura:

non aprire nodo immediato.

Riaprire G21 solo se emergeranno casi reali in cui:

- suggestion create/edit divergono in modo funzionalmente rischioso
- in edit mode una suggestion produce creazione impropria
- una suggestion altera select_project/select_entity in modo inatteso
- un command riconosciuto aggira la guard e arriva a update_event

Vincoli:

- non modificare DB
- non modificare parser
- non introdurre creazioni automatiche
- non trasformare edit mode in command flow operativo
- non modificare input_analysis_result fuori nodo dedicato
- preservare select_project / select_entity come decisione utente
- non riaprire G22 salvo regressione reale

Fonte canonica:
- 01_LOGOS_Input_System
- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

ID: G32

NOME:
Cleanup Obsolete UI Guards / Query Reduction

STATO:
IDENTIFICATO — CLEANUP FUTURO

DESCRIZIONE:

Dopo input_analysis_result e Visibility Migration Completion,
alcune guardie/query legacy possono essere obsolete.

Azione:

valutare solo dopo stabilità documentata e cleanup dedicato.

Vincoli:

- procedere uno alla volta
- test dopo ogni micro-rimozione
- non modificare parser/matching/save flow/DB
- non eliminare ui_visibility_state fuori nodo dedicato

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

---

ID: G34

NOME:
UI Visibility State Decommission / Wrapper Reduction

STATO:
IDENTIFICATO — RESIDUO TECNICO POST VISIBILITY MIGRATION

DESCRIZIONE:

ui_visibility_state non è più letto da input_analysis_result
e non governa più gli Hidden principali migrati,
ma resta fisicamente presente come residuo tecnico / rollback.

Azione:

decommission solo in nodo dedicato.

Possibili esiti futuri:

1. eliminazione
2. archiviazione come riferimento storico
3. mantenimento temporaneo come rollback tecnico

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

------------------------------------------------
GAP STRUTTURALI FUTURI
------------------------------------------------

ID: G11

NOME:
Data Structure / Entity Hierarchy

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Strutturazione futura di:

- relazioni entity-project
- parent_project_id / parent_entity_id
- alias
- deduplicazione
- gerarchie project/entity
- relazioni persona/azienda/fornitore/cliente/animale/progetto

Azione:

da valutare prima di output/KPI avanzati e prima di istanze verticali.

Fonte canonica:
- 02_LOGOS_Match_Engine
- 05_LOGOS_Database_Schema
- 00_PROJECT_Roadmap

---

ID: G13

NOME:
Economic Direction Advanced

STATO:
IDENTIFICATO

DESCRIZIONE:

Gestione avanzata della direzione economica.

Attualmente:

- type Spesa / Incasso è persistito
- amount resta positivo
- nessun direction field
- nessun amount firmato
- nessun report economico attivo

Azione:

da valutare dopo data quality/matching/data structure e prima di KPI economici.

Fonte canonica:
- 01_LOGOS_Input_System
- 05_LOGOS_Database_Schema
- 00_PROJECT_Roadmap

---

ID: G08A

NOME:
Duration Advanced — giorni / settimane

STATO:
IDENTIFICATO COME SOTTO-GAP FUTURO

DESCRIZIONE:

Ore/minuti sono normalizzati in minuti.
Giorni/settimane restano ambigui e non convertiti automaticamente.

Azione:

valutare solo in nodo dedicato.

Vincoli:

- evitare conversioni automatiche ambigue
- preservare duration normalization ore/minuti già stabile

Fonte canonica:
- 01_LOGOS_Input_System
- 06_LOGOS_View_Preview_System

---

ID: G10A

NOME:
Match Engine Evolution Advanced / Partial Ambiguity

STATO:
IDENTIFICATO COME SOTTO-GAP FUTURO

DESCRIZIONE:

Evoluzione futura del matching:

- alias
- fuzzy leggero
- ranking avanzato
- ambiguità parziale
- confidence
- filtering select su ambiguità

Azione:

non introdurre senza nodo dedicato.

Nota post G22:

il tema match presente + suggestion extension emerso durante G33 è stato risolto in G22 a primo livello controllato.

G10A resta macro-gap futuro solo per evoluzioni più ampie del Match Engine:

- ranking globale
- fuzzy matching
- alias
- confidence score strutturale
- gerarchie
- deduplicazione
- partial ambiguity avanzata
- filtering contestuale delle select

Non riaprire G22 dentro G10A salvo regressione reale.

Il caso “20 euro villa sierri” non richiede G10A.

Fonte canonica:
- 02_LOGOS_Match_Engine

---

ID: G04

NOME:
Logging System / Versioning

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Sistema futuro di log, revisioni, errori, audit trail e rollback.

Azione:

non prioritario ora.
Da rivalutare se emerge bisogno reale di audit modifiche o rollback.

Fonte canonica:
- 03_LOGOS_Event_Lifecycle
- 05_LOGOS_Database_Schema
- LOGOS_SUPABASE_RUNTIME_REAL

---

ID: G05

NOME:
Input Modes — Libero vs Guidato

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Possibile doppia modalità futura:

- input libero
- form guidato

Azione:

non prioritario.
Da rivalutare dopo Command Intent, Input Analysis, Data Structure e Azioni Rapide.

Fonte canonica:
- 01_LOGOS_Input_System
- 04_LOGOS_Retool_Architecture

---

ID: G06

NOME:
Multi-source Input

STATO:
NON PRIORITARIO

DESCRIZIONE:

Input da API, voice, Siri, import o automazioni esterne.

Azione:

non lavorare ora.
Da rivalutare solo dopo input system maturo, engine più completo e sicurezza API valutata.

Fonte canonica:
- 01_LOGOS_Input_System
- 00_PROJECT_Roadmap

------------------------------------------------
GAP UX / MODULI FUTURI
------------------------------------------------

ID: G23

NOME:
Azioni Rapide Operative

STATO:
VALIDATO — NODO FUTURO

DESCRIZIONE:

La Home contiene azioni rapide predisposte ma non operative:

- Registra spesa
- Registra incasso
- Registra tempo
- Registra evento

Azione:

renderle operative solo in nodo dedicato,
senza bypassare input_analysis_result, parser, matching o conferma utente.

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- 01_LOGOS_Input_System

---

ID: G24

NOME:
Dashboard Base

STATO:
VALIDATO — NODO FUTURO NON IMMEDIATO

DESCRIZIONE:

Dashboard presente in Navigation dock ma disabilitata.

Azione:

attivare solo dopo consolidamento Core Event System e qualità dati sufficiente.

Fonte canonica:
- 00_PROJECT_Roadmap
- 05_LOGOS_Database_Schema

---

ID: G25

NOME:
Icon System / Mobile Polish Finale

STATO:
IN OSSERVAZIONE

DESCRIZIONE:

Sistema icone misto:

- Icon add-ons Retool nei componenti reali
- emoji/HTML in Sintesi e Feedback

Nota post G22:

durante G22 sono emersi piccoli residui grafici/mobile polish legati a gerarchia visiva, hint/warning e leggibilità.

Questi residui sono puramente visuali e non bloccanti.
Vanno trattati più avanti o in sessioni brevi, senza riaprire logiche funzionali già consolidate.

Azione:

rivalutare solo in polish finale.

Fonte canonica:
- 04_LOGOS_Retool_Architecture
- 06_LOGOS_View_Preview_System

---

ID: G20

NOME:
Core Event System / Modular Instances

STATO:
VALIDATO — VINCOLO STRATEGICO

DESCRIZIONE:

LOGOS resta Core Event System modulare.
ASPRI / ADEXIMA / MaurizioLab sono istanze future,
non nodi operativi da anticipare.

Azione:

mantenere vincolo anti-deriva.

Divieto:

non aprire dashboard ASPRI, CRM ADEXIMA, gestione MaurizioLab o moduli verticali
prima del consolidamento Core Event System.

Fonte canonica:
- 00_PROJECT_Roadmap
- 00_PROJECT_State

---

ID: G26

NOME:
Mobile Safari Font Baseline

STATO:
INTEGRATO COME REGOLA TECNICA

DESCRIZIONE:

Input/select mobile Safari devono mantenere font-size minimo 16px per evitare zoom automatico iOS.

Azione:

non riaprire salvo regressioni reali.
Da ricordare nel polish finale.

Fonte canonica:
- 04_LOGOS_Retool_Architecture

------------------------------------------------
GAP INTEGRATI / ARCHIVIO COMPATTO
------------------------------------------------

I gap seguenti sono integrati o integrati a livello base.

Non devono essere riaperti come nodo base.
Eventuali evoluzioni devono diventare sotto-gap o nodi dedicati.

G22 — Project Create Suggestion — Match Present / User Override / Auto-select Confidence
STATO: INTEGRATO BASE

Fonte canonica:
- 02_LOGOS_Match_Engine per policy match presente + suggestion extension
- 01_LOGOS_Input_System per create_suggestion_state / preview_analysis_state nel contesto input
- 04_LOGOS_Retool_Architecture per wiring Retool
- 06_LOGOS_View_Preview_System per warning Da verificare e micro-copy preview
- LOGOS_RETOOL_RUNTIME_REAL per runtime reale as-is

Esito:

- caso guida “20 euro villa sierri” risolto
- match presente + suggestion extension classificato
- create_suggestion_state espone requiresUserOverride
- requiresUserOverride segnala che esiste una select già valorizzata ma l’input suggerisce una candidate più specifica
- preview_analysis_state consuma requiresUserOverride
- card Da verificare mostra warning mirato:
  - Associazione progetto da controllare
  - Associazione entità da controllare
- micro-copy consolidata:
  - [baseName] selezionato · testo letto: [candidateName]
  - [baseName] selezionata · testo letto: [candidateName]
- container Suggerimenti associazione mostra solo l’azione disponibile:
  - Possibile nuovo progetto
  - Possibile nuova entità
- rimossa duplicazione della selezione corrente dal container Suggerimenti associazione
- warning generici “Esistono progetti più specifici” / “Esistono entità più specifiche” non usati più come segnale principale nei casi G22
- Conferma resta attiva
- suggestion ignorata non blocca salvataggio
- select_project / select_entity restano decisione finale salvabile
- button_input_confirm.Disabled invariato
- payload invariato
- save flow invariato
- DB invariato
- Supabase invariato
- G10A non necessario per questo caso

Regola:

G22 non deve essere riaperto come nodo base.

Riaprire solo se:

- compare regressione reale nel caso match presente + suggestion extension
- requiresUserOverride non viene generato quando necessario
- la UI torna a permettere salvataggio inconsapevole senza warning mirato
- si decide esplicitamente di aprire G10A per ranking/fuzzy/alias/confidence avanzata

Residui collegati ma fuori G22:

- G35 Status Semantics Alignment
- G38 Preview / Missing Association Notice Cleanup
- G25 Icon System / Mobile Polish Finale
- G10A Match Engine Evolution Advanced solo per casi realmente avanzati

---

G36 — Preview / Event Data Label Semantic Alignment
STATO: INTEGRATO

Fonte canonica:
- 06_LOGOS_View_Preview_System per comportamento visuale della Sintesi, label valore e micro-copy.
- LOGOS_RETOOL_RUNTIME_REAL per runtime reale Retool as-is.

Esito:

- risolto residuo semantico label “Importo” su valori durata
- riga valore della Sintesi allineata semanticamente:
  - euro → Importo
  - ore / minuti → Durata
  - fallback non riconosciuto → Valore
- modifica limitata a micro-copy visuale
- parser invariato
- duration normalization invariata
- type classification invariata
- matching invariato
- input_analysis_result invariato
- preview_analysis_state invariato
- button_input_confirm invariato
- payload invariato
- save flow invariato
- DB invariato

Regola:

G36 non deve essere riaperto come nodo base.
Eventuali evoluzioni future della Sintesi devono confluire in G17 Preview Model / Hint State Consolidation o in gap specifici.

G37 — Documentation Architecture Audit / Redundancy Reduction
STATO: COMPLETATO / INTEGRATO COME REGOLA DOCUMENTALE
Fonte canonica:
- 00_PROJECT_KERNEL_MANIFEST per Principio Fonti Canoniche e Session Boot Matrix
- CHECKPOINT — DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION per esito finale del nodo
- 00_PROJECT_State per stato post-audit
- 00_PROJECT_Roadmap per sequenza post-audit

Esito:

- fonti canoniche definite
- documenti core alleggeriti
- documenti tecnici canonici preservati
- runtime manifest normalizzati
- Kernel Manifest aggiornato
- Session Boot Matrix consolidata
- regola aggiornamenti futuri consolidata
- stress test documentale finale completato
- checkpoint finale prodotto

Regola:

G37 non deve essere riaperto come nodo documentale generico.
Eventuali futuri interventi documentali devono essere aperti solo se emerge un problema reale di ridondanza, perdita ricostruibilità o incoerenza tra fonti canoniche.

G33 — Button Confirm Readiness Alignment

STATO: INTEGRATO

Fonte canonica:
- 01_LOGOS_Input_System per relazione input flow / button_input_confirm / readiness
- 04_LOGOS_Retool_Architecture per wiring Retool
- LOGOS_RETOOL_RUNTIME_REAL per runtime reale as-is

Esito:

- button_input_confirm.Disabled aggiornato
- Disabled ora legge solo project_state.data?.isAmbiguous e entity_state.data?.isAmbiguous
- rimosso fallback grezzo matches.length > 1
- button_input_confirm.Hidden invariato
- canShowConfirm resta visibility-only
- canConfirm resta readiness funzionale distinta
- button_input_confirm.Disabled resta guard funzionale separata
- button_input_confirm.Disabled non migrato dentro input_analysis_result
- payload invariato
- insert_event / update_event invariati
- save flow invariato
- parser invariato
- matching invariato nella logica funzionale
- input_analysis_result invariato
- DB invariato
- Supabase invariato

Regola:

G33 non deve essere riaperto come nodo base.
Eventuali evoluzioni future della save readiness o della centralizzazione canConfirm devono essere nodo separato.

Nota post G22:

Il rischio match generico / auto-select confidence osservato durante G33 è stato assorbito e risolto in G22 a primo livello controllato.

G33 non deve essere riaperto per questo tema.

G30 — Command Intent — Edit Guide Generic Alias
STATO: INTEGRATO BASE

Fonte canonica:
- 01_LOGOS_Input_System per command_intent_state ed edit_generic_help
- 03_LOGOS_Event_Lifecycle per esclusione dal lifecycle evento
- 04_LOGOS_Retool_Architecture per wiring Retool
- LOGOS_RETOOL_RUNTIME_REAL per runtime reale as-is

Esito:

- modifica / correggi / cambia riconosciuti come guide generiche non operative
- commandType edit_generic_help introdotto
- create flow protetto da eventi impropri su alias generici
- edit flow protetto da update_event impropri tramite EDIT MODE COMMAND GUARD
- nessun edit flow automatico
- nessun evento salvato
- nessun record modificato automaticamente

Regola:

G30 non deve essere riaperto come nodo base.
Eventuali alias avanzati, typo/fuzzy recognition o command strutturali tipo “modifica progetto”
devono essere nodo futuro distinto.

G21 — Suggestion Create vs Edit Consistency
STATO: INTEGRATO PARZIALE

Fonte canonica:
- 01_LOGOS_Input_System
- 03_LOGOS_Event_Lifecycle
- 04_LOGOS_Retool_Architecture
- LOGOS_RETOOL_RUNTIME_REAL

Esito:

- stabilizzato il rischio command/edit più immediato
- command riconosciuti durante edit mode non diventano update_event
- command create project/entity non creano project/entity durante edit mode
- alias generici modifica / correggi / cambia non salvano eventi
- input_analysis_result preservato stabile
- save flow preservato

Residuo:

resta possibile un residuo visuale in edit mode:
Sintesi / Suggerimenti / Dati evento possono restare visibili con command riconosciuto.

Classificazione:

residuo UX accettato e tracciato in G39.

Regola:

G21 non deve essere riaperto come nodo base salvo regressione reale o nuovo caso funzionale concreto.

G01 — Normalization Model
STATO: INTEGRATO PARZIALE
Fonte canonica: 01_LOGOS_Input_System

G02 — Processor / Engine Flow
STATO: VALIDATO / PARZIALMENTE AVVIATO
Fonte canonica: 01_LOGOS_Input_System, 04_LOGOS_Retool_Architecture, LOGOS_RETOOL_RUNTIME_REAL

G03 — Project / Entity Create Suggestion
STATO: INTEGRATO BASE
Fonte canonica: 01_LOGOS_Input_System, 02_LOGOS_Match_Engine, 04_LOGOS_Retool_Architecture, 05_LOGOS_Database_Schema

Nota:
il comportamento base di creazione project/entity resta in G03.
La policy match presente + suggestion extension è stata completata in G22.

G07 — Preview Alignment
STATO: INTEGRATO
Fonte canonica: 06_LOGOS_View_Preview_System

G08 — Duration Normalization Base
STATO: INTEGRATO BASE
Fonte canonica: 01_LOGOS_Input_System

G09 — Type Classification Base
STATO: INTEGRATO BASE
Fonte canonica: 01_LOGOS_Input_System, 05_LOGOS_Database_Schema

G10 — Match Engine Unification
STATO: INTEGRATO BASE
Fonte canonica: 02_LOGOS_Match_Engine

G12 — Events List Label / Updated At Display
STATO: INTEGRATO
Fonte canonica: 03_LOGOS_Event_Lifecycle, 04_LOGOS_Retool_Architecture

G14 — Linting / State Helper Cleanup
STATO: INTEGRATO
Fonte canonica: 04_LOGOS_Retool_Architecture, LOGOS_RETOOL_RUNTIME_REAL

G15 — Edit Mode Cancel / Return to Events List
STATO: INTEGRATO
Fonte canonica: 03_LOGOS_Event_Lifecycle, 04_LOGOS_Retool_Architecture

G16 — Events List Search / Filter Bar
STATO: INTEGRATO
Fonte canonica: 04_LOGOS_Retool_Architecture

G18 — UX Mobile Coherence Pass
STATO: INTEGRATO BASE
Fonte canonica: 04_LOGOS_Retool_Architecture, 06_LOGOS_View_Preview_System

G19 — Command Intent — Create Project / Entity
STATO: INTEGRATO BASE
Fonte canonica: 01_LOGOS_Input_System, 03_LOGOS_Event_Lifecycle, 04_LOGOS_Retool_Architecture

Nota post Input Context Consistency:

G19 resta integrato base.
Il nodo Input Context Consistency ha esteso il comportamento command con:

- edit_generic_help
- alias modifica / correggi / cambia
- blocco command riconosciuti durante edit mode tramite button_input_confirm

Questa estensione è documentata specificamente in G30 e G21.

G27 — Input Rendering Stability / Container Structure
STATO: INTEGRATO BASE / EVOLUTO IN INPUT ANALYSIS RESULT
Fonte canonica: 01_LOGOS_Input_System, 04_LOGOS_Retool_Architecture

G28 — Input Analysis Result / Single Interpretation Layer
STATO: INTEGRATO PARZIALE — VISIBILITY MIGRATION COMPLETION
Fonte canonica: 01_LOGOS_Input_System, 04_LOGOS_Retool_Architecture

G31 — Linting / Retool Query Safety Pass
STATO: INTEGRATO
Fonte canonica: 04_LOGOS_Retool_Architecture, LOGOS_RETOOL_RUNTIME_REAL

------------------------------------------------
ORDINE CONSIGLIATO GAP / NODI
------------------------------------------------

Ordine attuale consigliato post Input Context Consistency:

1. G35 — Status Semantics Alignment
2. G38 — Preview / Missing Association Notice Cleanup
3. G17 — Preview Model / Hint State Consolidation
4. G39 — Edit Mode Command-like Visual Residue — solo se il residuo UX diventa realmente problematico
5. G10A — Match Engine Evolution Advanced / Partial Ambiguity — solo per ranking/fuzzy/alias/confidence avanzata reale
6. G11 — Data Structure / Entity Hierarchy
7. G13 — Economic Direction Advanced
8. G08A — Duration Advanced / Giorni-Settimane
9. G32 / G34 — Cleanup Obsolete UI Guards / ui_visibility_state Decommission
10. G23 — Azioni Rapide Operative
11. G24 — Dashboard Base
12. G04 — Logging / Versioning
13. G05 — Input Modes
14. G06 — Multi-source Input

Nota sequenza post Input Context Consistency:

G22 è completato e non è più nodo operativo immediato.
G30 è completato a livello base e non è più nodo operativo immediato.
G21 è integrato parziale per la parte command/edit/suggestion trattata.

I residui immediati più coerenti restano prevalentemente Preview/UX:

- status OK / Verifica / Attenzione da riallineare semanticamente
- balloon blu “Manca progetto / Manca entità” da rivalutare
- preview model / hint state consolidation
- residuo visuale edit command-like solo se davvero problematico

G10A resta futuro e non va anticipato per casi già risolti a primo livello.

La sequenza deve evitare loop:

- non riaprire G22 salvo regressione reale
- non riaprire G30 salvo regressione reale
- non usare G10A per rifinire micro-copy o status preview
- non anticipare Input Analysis Model completo per residui visuali
- non modificare input_analysis_result per residui edit command-like fuori nodo dedicato
- non aprire select contextual filtering come gap autonomo se non emerge un problema reale

Vincoli strategici permanenti:

- G20 — Core Event System / Modular Instances
- G26 — Mobile Safari Font Baseline

Nota:

G29 — Feedback / Input Flow Micro-flash Cleanup è stato analizzato e resta in osservazione come residuo UX minore accettabile.

Non è più nodo operativo immediato.

Non deve essere riaperto salvo peggioramento UX evidente o nodo dedicato/refactor sulla visibility/rendering del flow input.

Nota:

G36 — Preview / Event Data Label Semantic Alignment è completato
e non resta nodo candidato attivo.

Il residuo label “Importo” su durata è stato risolto.
La Sintesi resta comunque layer ibrido: eventuali interventi più ampi restano nel perimetro di G17.

Nota:

G33 — Button Confirm Readiness Alignment è stato completato e integrato.

Non è più nodo operativo immediato.
Non deve essere riaperto salvo regressione reale del bottone Conferma.

Nota:

G22 — Project Create Suggestion / Match Present / User Override è stato completato e integrato base.

Non è più nodo operativo immediato.
Non deve essere riaperto salvo regressione reale del caso match presente + suggestion extension.

Nota:

Input Context Consistency ha confermato che G22 resta non regressivo.

Il caso 20 euro villa sierri è stato rivalidato.
Non riaprire G22 per residui command/edit.

------------------------------------------------
REGOLA GAP REGISTER
------------------------------------------------

Un gap diventa nodo operativo solo se:

✔ necessario nello sviluppo reale
✔ validato su uso concreto
✔ non sostituibile da soluzione più semplice
✔ utile al nodo operativo imminente
✔ coerente con State e Roadmap

Un gap NON diventa nodo operativo se:

- anticipa la roadmap
- richiede refactor globale
- introduce complessità non validata
- non è necessario al problema immediato
- crea rischio di regressione su runtime stabile

CHANGELOG

v01 — 2026-04-01

Creazione Gap Register
Consolidamento gap da audit + gap analysis
Introduzione sistema di validazione progressiva

v02 — 2026-04-30

aggiornato G01 Normalization Model a INTEGRATO PARZIALE
aggiornato G02 Processor / Engine Flow a VALIDATO / PARZIALMENTE AVVIATO
aggiunti gap G07 Preview Alignment
aggiunto gap G08 Duration Normalization
aggiunto gap G09 Type Classification Base
aggiunto gap G10 Match Engine Unification
aggiunto gap G11 Data Structure / Entity Hierarchy
classificato G06 Multi-source Input come NON PRIORITARIO
aggiornato ordine consigliato gap/nodi
allineamento con State v10 e Roadmap v04

v03 — 2026-04-30

aggiornato G07 Preview Alignment a INTEGRATO
aggiornato G08 Duration Normalization a INTEGRATO BASE
documentata unità canonica tempo = minuti
documentata normalizzazione durate certe ore/minuti
documentato raw_input preservato
documentato che giorni/settimane restano sotto-gap avanzato
aggiornato G01 Normalization Model dopo Duration Normalization
aggiornato G02 Processor / Engine Flow
aggiornato G09 Type Classification Base come prossimo nodo candidato
aggiunto G12 Events List Label / Updated At Display
aggiornato ordine consigliato gap/nodi
allineamento con State v12 e Roadmap v06

v05 — 2026-05-02

aggiornato G10 Match Engine Unification a INTEGRATO BASE
documentato completamento Match Engine Unification First Controlled Level
documentato project_state/entity_state come fonte minima matching
documentato singleMatch / isAmbiguous / moreSpecificMatches
documentato select_project/select_entity allineati al match state
documentato confirm guard su ambiguità non risolta
documentato match state live in create/edit flow
documentato priority match minimo
documentato hint match più specifici
documentato bug €500 preview risolto
aggiornato G03 come Project / Entity Create Suggestion
aggiunto G14 Linting / State Helper Cleanup
aggiunto G15 Edit Mode Cancel / Return to Events List
aggiunto G16 Events List Search / Filter Bar
aggiunto G17 Preview Model / Hint State Consolidation
aggiornato G07 Preview Alignment con nota post Match Engine
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G12 Events List Label / Updated At Display
aggiornato G13 Economic Direction Advanced
aggiornato G06 Multi-source Input
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
allineamento con State v14 e Roadmap v08

v06 — 2026-05-02

aggiornato Gap Register dopo UX / CLEANUP MICRO-BATCH POST MATCH ENGINE
aggiornato G12 Events List Label / Updated At Display a INTEGRATO
documentata correzione label creato/modificato
documentata normalizzazione robusta created_at / updated_at
documentato no-op edit guard
documentato che edit senza modifiche non aggiorna updated_at
aggiornato G15 Edit Mode Cancel / Return to Events List a INTEGRATO
documentato btn_cancel_edit
documentato reset edit_mode / editing_event / input / select / ui_state.parsed
documentato ritorno lista eventi senza update_event
documentato fix doppia visibilità input/lista
aggiornato G16 Events List Search / Filter Bar a INTEGRATO
documentato input_events_search
documentato filtro client-side su list_events
documentata ricerca su raw_input / type / status / project / entity
aggiornato G14 Linting / State Helper Cleanup come unico micro-nodo residuo
confermato linting edit_mode/editing_event come residuo non bloccante
aggiornato G02 Processor / Engine Flow
aggiornato G17 Preview Model / Hint State Consolidation con nota post UX cleanup
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
allineamento con State v15 e Roadmap v09

v07 — 2026-05-03

aggiornato Gap Register dopo LINTING / STATE HELPER CLEANUP
aggiornato G14 Linting / State Helper Cleanup a INTEGRATO
documentata risoluzione linting edit_mode: 'value' is not defined
documentata risoluzione linting editing_event: 'value' is not defined
documentata rimozione additionalScope { value } da edit_mode / editing_event
documentato passaggio controllato tramite window.__logos_edit_mode_value
documentato passaggio controllato tramite window.__logos_editing_event_value
documentato reset chiavi window dopo lettura helper
documentato aggiornamento btn_edit
documentato aggiornamento btn_cancel_edit
documentato aggiornamento button_input_confirm nel ramo no-op edit guard
documentato aggiornamento button_input_confirm nel reset finale dopo salvataggio reale
documentato azzeramento editing_event dopo update reale completato
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
aggiornato G02 Processor / Engine Flow rimuovendo Linting Cleanup dai nodi residui
aggiornato G11 Data Structure / Entity Hierarchy dopo chiusura micro-nodi helper
aggiornato G13 Economic Direction Advanced con Linting Cleanup completato
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
allineamento con State v16 e Roadmap v10

v08 — 2026-05-07

aggiornato Gap Register dopo PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
aggiornato G03 Project / Entity Create Suggestion a INTEGRATO BASE
documentato create_suggestion_state
documentate variabili project/entity inline open e dismissed
documentate query insert_project / insert_entity
documentato container suggestion inline
documentati micro-editor project/entity
documentato bottone Ignora globale
documentati bottoni Annulla contestuali
documentata creazione project inline validata su DB reale
documentata creazione entity inline validata su DB reale
documentato select_project valorizzato dopo creazione project
documentato select_entity valorizzato dopo creazione entity
documentato evento non salvato automaticamente dopo creazione project/entity
documentato evento salvato manualmente con project_id/entity_id corretti
documentato blocco solo su ambiguità project/entity attiva
documentato salvataggio consentito senza project/entity
documentato entity autofill controlled minimal
documentato flow combinato project + entity
aggiunto G18 UX Cleanup — Suggestion Container / Mobile
aggiunto G19 Command Intent — Create Project / Entity
aggiunto G20 Core Event System / Modular Instances
aggiornato G02 Processor / Engine Flow
aggiornato G06 Multi-source Input
aggiornato G10 Match Engine Unification
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G13 Economic Direction Advanced
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
confermata direzione LOGOS Core modulare
confermate istanze ASPRI / ADEXIMA / MaurizioLab come derivate future del core
allineamento con State v17 e Roadmap v11

v09 — 2026-05-09

aggiornato Gap Register dopo UX MOBILE COHERENCE PASS
aggiornato G18 da UX Cleanup — Suggestion Container / Mobile a UX Mobile Coherence Pass
aggiornato G18 a INTEGRATO BASE
documentata Home mobile rifinita
documentata Events list mobile rifinita
documentato Feedback mobile stabilizzato
documentato feedback_summary in ui_state
documentato routing post-save contestuale
documentato insert → feedback → Home
documentato update → feedback → Lista eventi
documentato no-op edit → Lista eventi senza update_event
documentato cancel create/input → Home
documentato cancel edit → Lista eventi
documentata Navigation dock Home / Eventi / Dashboard
documentata Dashboard predisposta ma disabilitata
documentate Azioni rapide predisposte ma non operative
documentato font-size 16px input/select come fix iOS Safari
documentato zoom automatico Safari iOS risolto
documentata select mobile funzionante in digitazione/dropdown
aggiunto G21 Suggestion Create vs Edit Consistency
aggiunto G22 Project Create Suggestion — Match Present / User Override
aggiunto G23 Azioni Rapide Operative
aggiunto G24 Dashboard Base
aggiunto G25 Icon System / Mobile Polish Finale
aggiunto G26 Mobile Safari Font Baseline
aggiornato G02 Processor / Engine Flow
aggiornato G03 Project / Entity Create Suggestion
aggiornato G05 Input Modes
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G15 Edit Mode Cancel / Return to Events List
aggiornato G16 Events List Search / Filter Bar
aggiornato G19 Command Intent — Create Project / Entity
aggiornato G20 Core Event System / Modular Instances
aggiornato ordine consigliato gap/nodi
confermato output/KPI non attivi
confermata direzione LOGOS Core modulare
allineamento con State v18 e Roadmap v12

v10 — 2026-05-13

aggiornato Gap Register dopo COMMAND INTENT — CREATE PROJECT / ENTITY
aggiornato G19 Command Intent — Create Project / Entity a INTEGRATO BASE
documentato command_intent_state
documentato riconoscimento comando generico “crea”
documentato create project incompleto
documentato create project completo
documentato create entity incompleto
documentato create entity completo
documentati sinonimi base crea / aggiungi / inserisci / nuovo / nuova
documentato blocco duplicati project/entity già esistenti
documentato “crea progetto villa” come elemento già presente
documentata guida non operativa “modifica evento”
documentato container_command_intent
documentati btn_command_create_project / btn_command_create_entity / btn_command_go_events
documentato riuso insert_project / insert_entity
documentato feedback_mode in ui_state
documentato feedback project_created
documentato feedback entity_created
documentato feedback evento ordinario preservato
documentato che comandi puri non salvano eventi
documentato che project/entity da command richiedono conferma utente
documentato che Command Intent non modifica DB/parser/matching/create_suggestion_state
aggiornato G02 Processor / Engine Flow
aggiornato G03 Project / Entity Create Suggestion
aggiornato G05 Input Modes
aggiornato G06 Multi-source Input
aggiornato G07 Preview Alignment
aggiornato G10 Match Engine Unification
aggiornato G11 Data Structure / Entity Hierarchy
aggiornato G13 Economic Direction Advanced
aggiornato G17 Preview Model / Hint State Consolidation
aggiornato G18 UX Mobile Coherence Pass
aggiornato G20 Core Event System / Modular Instances
aggiornato G23 Azioni Rapide Operative
aggiornato G24 Dashboard Base
aggiunto G27 Input Rendering Stability / Container Structure
aggiunto G28 Input Analysis Model / Single Interpretation Layer
aggiornato ordine consigliato gap/nodi post Command Intent
confermato output/KPI non attivi
confermata direzione LOGOS Core modulare
allineamento con State v19 e Roadmap v13

v11 — 2026-05-18

aggiornato Gap Register dopo UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
integrato esito CHECKPOINT — INPUT RENDERING STABILITY / PRIORITY REVIEW
integrato esito CHECKPOINT — UI READINESS / VISIBILITY AGGREGATOR — FIRST CONTROLLED LEVEL
aggiornato G02 Processor / Engine Flow con UI Readiness / Visibility Aggregator
aggiornato G05 Input Modes con distinzione visiva empty/event/command
aggiornato G07 Preview Alignment con nota post UI Readiness
aggiornato G10 Match Engine Unification con nota su ui_visibility_state non sostitutivo
aggiornato G11 Data Structure / Entity Hierarchy con nota su UI Readiness non strutturale
aggiornato G14 Linting / State Helper Cleanup con nota sui nuovi linting residui non trattati
aggiornato G17 Preview Model / Hint State Consolidation a candidato principale post UI Readiness
aggiornato G18 UX Mobile Coherence Pass con residui post UI Readiness
aggiornato G19 Command Intent — Create Project / Entity con residuo “modifica” generico
aggiornato G20 Core Event System / Modular Instances con UI Readiness
aggiornato G23 Azioni Rapide Operative con coordinamento futuro ui_visibility_state
aggiornato G24 Dashboard Base con UI Readiness completata
aggiornato G27 Input Rendering Stability / Container Structure a INTEGRATO BASE
documentato ui_visibility_state
documentato ui_visibility_mode
documentato trigger_parse_debounced aggiornato per ui_visibility_mode
documentato window.__logos_visibility_run_id
documentata centralizzazione Hidden principali
documentato container_input stabilizzato
documentato container vuoto durante digitazione risolto
documentato flash input flow ridotto
documentato bottom bar flash risolto
documentato text_input_analysis_loading
documentato text_edit_mode_notice
documentato edit mode prevalente su command intent
aggiornato G28 Input Analysis Model / Single Interpretation Layer con ui_visibility_state / ui_visibility_mode
aggiunto G29 Feedback Micro-flash Cleanup
aggiunto G30 Command Intent — Edit Guide Generic Alias
aggiunto G31 Linting / Minor Cleanup
aggiunto G32 Cleanup Obsolete UI Guards / Query Reduction
aggiornato ordine consigliato gap/nodi post UI Readiness
confermato output/KPI non attivi
confermata direzione LOGOS Core modulare

v12 — 2026-05-20

aggiornato Gap Register dopo PREVIEW ANALYSIS STATE — FIRST CONTROLLED LAYER
aggiornato Gap Register dopo INPUT ANALYSIS RESULT / SINGLE INTERPRETATION LAYER BASE — READ-ONLY DIAGNOSTIC
aggiornato Gap Register dopo INPUT ANALYSIS RESULT — CONTROLLED UI CONSUMPTION PASS

aggiornato G02 Processor / Engine Flow con:
- preview_analysis_state
- input_analysis_result
- controlled partial UI consumption
- ui_visibility_state ancora operativo

aggiornato G03 Project / Entity Create Suggestion con distinzione:
- missing association notice
- suggestion operativa

aggiornato G05 Input Modes con nota post input_analysis_result
aggiornato G07 Preview Alignment con preview_analysis_state e status residuale
aggiornato G10 Match Engine Unification con input_analysis_result come compositore non sostitutivo
aggiornato G14 Linting / State Helper Cleanup con 19 linting Retool attuali
aggiornato G17 Preview Model / Hint State Consolidation con nota post preview_analysis_state
aggiornato G19 Command Intent con command suppression in edit mode
aggiornato G20 Core Event System / Modular Instances con principio architettura modulare coordinata
aggiornato G21 Suggestion Create vs Edit Consistency con distinzione notice/suggestion
aggiornato G27 Input Rendering Stability / Container Structure con evoluzione input_analysis_result
aggiornato G28 da Input Analysis Model futuro a Input Analysis Result integrato parziale
aggiornato G31 da Linting / Minor Cleanup a Linting / Retool Query Safety Pass
aggiornato G32 Cleanup Obsolete UI Guards / Query Reduction dopo partial migration

aggiunti nuovi gap:
- G33 Button Confirm Readiness Alignment
- G34 UI Visibility State Decommission / Wrapper Reduction
- G35 Status Semantics Alignment

aggiornato ordine consigliato gap/nodi post Input Analysis Result
confermato prossimo nodo candidato:
- Input Analysis Result — Visibility Migration Completion

confermato nodo tecnico candidato:
- Linting / Retool Query Safety Pass

confermato blocco verso Output / Dashboard / KPI
confermata direzione LOGOS Core modulare e non monolitica

v13 — 2026-05-23

aggiornato Gap Register dopo INPUT ANALYSIS RESULT — VISIBILITY MIGRATION COMPLETION
aggiornato Gap Register dopo LINTING / RETOOL QUERY SAFETY PASS

aggiornato G02 Processor / Engine Flow con:
- Visibility Migration Completion
- Linting / Retool Query Safety Pass
- input_analysis_result come fonte UI controllata per Hidden principali
- ui_visibility_state residuo tecnico deprecabile

aggiornato G03 Project / Entity Create Suggestion con visibility suggestion governata da input_analysis_result senza modificare create_suggestion_state
aggiornato G05 Input Modes dopo Visibility Migration Completion
aggiornato G07 Preview Alignment con residuo label “Importo” su durata
aggiornato G10 Match Engine Unification con policy match più specifici non bloccante
aggiornato G14 Linting / State Helper Cleanup con linting Retool azzerati
aggiornato G17 Preview Model / Hint State Consolidation dopo chiusura Visibility Migration
aggiornato G20 Core Event System / Modular Instances con nodo documentale futuro
aggiornato G27 Input Rendering Stability / Container Structure dopo Full Visibility Migration Hidden principali
aggiornato G28 Input Analysis Result / Single Interpretation Layer a INTEGRATO PARZIALE — VISIBILITY MIGRATION COMPLETION
aggiornato G29 Feedback Micro-flash Cleanup con flash residui digitazione/cambio schermata
aggiornato G31 Linting / Retool Query Safety Pass a INTEGRATO
aggiornato G32 Cleanup Obsolete UI Guards / Query Reduction dopo completion visibility/linting
aggiornato G33 Button Confirm Readiness Alignment a INTEGRATO PARZIALE — HIDDEN MIGRATO / DISABLED NON MIGRATO
aggiornato G34 UI Visibility State Decommission come residuo tecnico post migration

aggiunti nuovi gap:
- G36 Preview / Event Data Label Semantic Alignment
- G37 Documentation Architecture Audit / Redundancy Reduction

aggiornato ordine consigliato gap/nodi post Visibility Migration + Linting Safety Pass

prossimo nodo candidato prioritario:
- Documentation Architecture Audit / Redundancy Reduction

confermato:
- output/KPI non attivi
- Dashboard non attiva
- istanze verticali non attive
- LOGOS resta Core Event System modulare
- input_analysis_result non deve diventare motore monolitico

v14 — 2026-05-25

- aggiornamento documentale nel nodo DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- applicato Pacchetto B — Core Governance su 00_PROJECT_Gap_Register
- Gap Register aggiornato da v13 a v14
- ridotta duplicazione tecnica lunga nel Gap Register
- riportato il documento alla funzione di registro gap / debiti / futuri
- sostituito GAP REGISTER esteso con GAP REGISTER — SINTESI CONTROLLATA
- mantenuti tutti gli ID gap principali
- mantenuti gap attivi, prioritari, strutturali, UX, strategici e integrati
- spostati i dettagli tecnici completi verso documenti canonici
- aggiunti richiami canonici a:
  - 01_LOGOS_Input_System
  - 02_LOGOS_Match_Engine
  - 03_LOGOS_Event_Lifecycle
  - 04_LOGOS_Retool_Architecture
  - 05_LOGOS_Database_Schema
  - 06_LOGOS_View_Preview_System
  - LOGOS_RETOOL_RUNTIME_REAL
  - LOGOS_SUPABASE_RUNTIME_REAL
- aggiornato G37 Documentation Architecture Audit / Redundancy Reduction a IN CORSO
- documentato Pacchetto A come allineato, non ridotto
- documentato Pacchetto B come in corso / quasi completato
- aggiornato ordine consigliato gap/nodi post Pacchetto B
- confermato blocco verso output / dashboard / KPI
- confermato divieto di anticipare istanze verticali
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica payload
- nessuna anticipazione output / KPI / dashboard

v15 — 2026-05-25

- aggiornamento finale post DOCUMENTATION ARCHITECTURE AUDIT / REDUNDANCY REDUCTION
- Gap Register aggiornato da v14 a v15
- G37 Documentation Architecture Audit / Redundancy Reduction aggiornato da IN CORSO a COMPLETATO / INTEGRATO COME REGOLA DOCUMENTALE
- rimosso G37 da GAP ATTIVO DEL NODO CORRENTE
- registrato che non ci sono gap documentali attivi
- registrato G36 Preview / Event Data Label Semantic Alignment come prossimo gap operativo consigliato
- spostato G37 in GAP INTEGRATI / ARCHIVIO COMPATTO
- registrato esito G37:
  - fonti canoniche definite
  - documenti core alleggeriti
  - documenti tecnici canonici preservati
  - runtime manifest normalizzati
  - Kernel Manifest aggiornato
  - Session Boot Matrix consolidata
  - regola aggiornamenti futuri consolidata
  - stress test documentale finale completato
  - checkpoint finale prodotto
- aggiornata sezione ORDINE CONSIGLIATO GAP / NODI post audit documentale
- chiarito che G37 non deve essere riaperto come nodo documentale generico
- chiarito che le regole documentali permanenti sono nel Kernel Manifest
- confermato che i checkpoint sono riferimenti storico-operativi e non unica fonte delle regole permanenti
- nessuna modifica runtime LOGOS
- nessuna modifica Retool
- nessuna modifica Supabase
- nessuna modifica DB
- nessuna modifica parser
- nessuna modifica matching
- nessuna modifica preview
- nessuna modifica save flow
- nessuna modifica payload
- nessuna anticipazione output / KPI / dashboard

v16 — 2026-05-26

- aggiornamento post PREVIEW / EVENT DATA LABEL SEMANTIC ALIGNMENT
- Gap Register aggiornato da v15 a v16
- G36 Preview / Event Data Label Semantic Alignment aggiornato da IDENTIFICATO a INTEGRATO
- G36 spostato da GAP RESIDUI PRIORITARI a GAP INTEGRATI / ARCHIVIO COMPATTO
- registrata risoluzione del residuo label “Importo” su durata
- registrata riga valore Sintesi semanticamente allineata:
  - euro → Importo
  - ore / minuti → Durata
  - fallback non riconosciuto → Valore
- confermato che la modifica è solo visuale / micro-copy
- confermato parser invariato
- confermata duration normalization invariata
- confermata type classification invariata
- confermato matching invariato
- confermato input_analysis_result invariato
- confermato preview_analysis_state invariato
- confermato button_input_confirm invariato
- confermato payload invariato
- confermato save flow invariato
- confermato DB invariato
- aggiornato prossimo gap operativo consigliato a G29 Feedback / Input Flow Micro-flash Cleanup
- confermato che G36 non va riaperto come nodo base
- confermato che eventuali evoluzioni più ampie della Sintesi restano in G17 Preview Model / Hint State Consolidation
- nessuna anticipazione Button Confirm Readiness Alignment
- nessuna anticipazione cleanup ui_visibility_state
- nessuna anticipazione output / KPI / dashboard

v17 — 2026-06-01

- aggiornamento post INPUT FLOW / TRANSITION MICRO-FLASH STABILIZATION
- Gap Register aggiornato da v16 a v17
- G29 Feedback / Input Flow Micro-flash Cleanup aggiornato da IDENTIFICATO — RESIDUO MINORE a IN OSSERVAZIONE — RESIDUO UX MINORE ACCETTABILE
- registrata analisi runtime Retool reale su flash/riga container_input
- confermato comportamento riproducibile ma non bloccante
- confermata console Retool senza errori
- testati Hidden di container_input
- testati Hidden dei figli principali:
  - text_input_analysis_loading
  - text_edit_mode_notice
  - btn_cancel_input_home
  - container_command_intent
- testati layout/stile di container_input
- verificati container_home e wrapper come possibili cause layout
- testata Strada B con micro-latch input_shell_visible
- micro-latch non risolutivo e non mantenuto
- rollback effettuato alla base stabile
- nessuna modifica runtime definitiva mantenuta
- confermato che G29 non impatta parser
- confermato che G29 non impatta matching
- confermato che G29 non impatta input_analysis_result in modo definitivo
- confermato che G29 non impatta command_intent_state in modo definitivo
- confermato che G29 non impatta preview_analysis_state
- confermato che G29 non impatta button_input_confirm.Disabled
- confermato che G29 non impatta payload
- confermato che G29 non impatta save flow
- confermato che G29 non impatta insert_event / update_event
- confermato che G29 non impatta DB
- confermato che G29 non impatta Supabase
- chiarito che G29 non va riaperto come micro-fix ordinario
- chiarito che G29 va riaperto solo in caso di peggioramento UX evidente o nodo dedicato/refactor visibility/rendering
- aggiornato prossimo gap operativo consigliato a G33 Button Confirm Readiness Alignment
- aggiornato ordine consigliato gap/nodi post G29
- nessuna anticipazione Preview Model / Hint State Consolidation
- nessuna anticipazione cleanup ui_visibility_state
- nessuna anticipazione output / KPI / dashboard

v18 — 2026-06-01

- aggiornamento post BUTTON CONFIRM READINESS ALIGNMENT
- Gap Register aggiornato da v17 a v18
- G33 Button Confirm Readiness Alignment aggiornato a INTEGRATO
- registrato completamento G33 su runtime Retool reale
- registrato aggiornamento button_input_confirm.Disabled
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
- deciso di assorbire il tema in G22 Project Create Suggestion — Match Present / User Override / Auto-select Confidence
- G22 aggiornato come candidato prossimo nodo
- G10A mantenuto come macro-gap futuro, senza duplicare G22
- nessun nuovo gap autonomo creato per evitare ridondanza e loop documentali
- aggiornato ordine consigliato gap/nodi post G33
- nessuna anticipazione Match Engine Advanced
- nessuna modifica select options / candidate filtering
- nessuna modifica save readiness centralizzata
- nessuna anticipazione dashboard / KPI / output

v19 — 2026-06-04

- aggiornamento post PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE / AUTO-SELECT CONFIDENCE
- Gap Register aggiornato da v18 a v19
- G22 Project Create Suggestion — Match Present / User Override aggiornato da IDENTIFICATO a INTEGRATO BASE
- caso guida 20 euro villa sierri risolto
- match presente + suggestion extension classificato
- create_suggestion_state aggiornato con requiresUserOverride
- requiresUserOverride registrato come flag UI derivato da create_suggestion_state
- preview_analysis_state aggiornato per warning mirato G22
- card Da verificare aggiornata con:
  - Associazione progetto da controllare
  - Associazione entità da controllare
- micro-copy consolidata:
  - [baseName] selezionato · testo letto: [candidateName]
  - [baseName] selezionata · testo letto: [candidateName]
- create_suggestion_hint rifinito come area azione
- rimossa duplicazione della selezione corrente dal container Suggerimenti associazione
- separazione semantica consolidata:
  - Da verificare = rischio decisionale
  - Suggerimenti associazione = azione disponibile
- confermato che G22 non blocca Conferma
- confermato che suggestion ignorata non blocca salvataggio
- confermato button_input_confirm.Disabled invariato
- confermato button_input_confirm.Hidden invariato
- confermato payload invariato
- confermati insert_event / update_event invariati
- confermato save flow invariato
- confermato parser invariato
- confermato matching primario invariato
- confermato input_analysis_result invariato
- confermato DB invariato
- confermato Supabase invariato
- confermato che G10A non è necessario per il caso G22
- G22 spostato in GAP INTEGRATI / ARCHIVIO COMPATTO
- G35 Status Semantics Alignment aggiornato come residuo UX/semantico post G22
- aggiunto G38 Preview / Missing Association Notice Cleanup
- aggiornato G10A per chiarire che non va usato per riaprire G22
- aggiornato G25 con nota sui residui grafici/mobile polish emersi durante G22
- aggiornato ordine consigliato gap/nodi post G22
- prossimo nodo operativo da decidere in Roadmap
- nessuna anticipazione Match Engine Advanced
- nessuna anticipazione Input Analysis Model completo
- nessuna anticipazione dashboard / KPI / output

v20 — 2026-06-15

- aggiornamento post INPUT CONTEXT CONSISTENCY — EDIT / SUGGESTION / COMMAND BOUNDARY
- Gap Register aggiornato da v19 a v20
- G21 Suggestion Create vs Edit Consistency aggiornato a INTEGRATO PARZIALE — COMMAND / EDIT BOUNDARY STABILIZZATO
- G30 Command Intent — Edit Guide Generic Alias aggiornato a INTEGRATO BASE
- registrato completamento nodo Input Context Consistency
- documentata analisi AS-IS:
  - modifica / correggi / cambia salvabili come eventi in create flow
  - modifica / correggi / cambia salvabili come update_event in edit flow
  - crea progetto test / crea entità test durante edit mode potevano diventare update_event
- documentato approccio scartato su input_analysis_result
- documentato rollback input_analysis_result alla base stabile
- command_intent_state aggiornato con edit_generic_help
- modifica / correggi / cambia riconosciuti come guide generiche non operative
- txt_command_intent_description aggiornato per edit_generic_help
- text_edit_mode_notice aggiornato con micro-copy contestuale
- button_input_confirm aggiornato con EDIT MODE COMMAND GUARD locale
- guard locale blocca command freschi durante edit mode prima di update_event
- guard locale non chiude edit mode
- guard locale non azzera editing_event
- guard locale non modifica payload
- guard locale non modifica button_input_confirm.Disabled
- guard locale non modifica insert_event / update_event
- command create project/entity durante edit mode non crea project/entity
- command create project/entity durante edit mode non aggiorna evento
- create flow modifica / correggi / cambia validato senza evento creato
- edit flow modifica / correggi / cambia validato senza update_event
- edit flow crea progetto test / crea entità test validato senza project/entity creati e senza update_event
- edit flow con input evento valido validato
- Annulla modifica validato
- G22 20 euro villa sierri non regressivo
- linting Retool 0
- aggiunto G39 Edit Mode Command-like Visual Residue
- G39 classificato come IN OSSERVAZIONE — RESIDUO UX ACCETTABILE
- G39 registra che in edit mode Sintesi / Suggerimenti associazione / Dati evento possono restare visibili con command riconosciuto
- residuo accettato perché update_event e creazioni improprie sono bloccati funzionalmente
- G30 spostato in GAP INTEGRATI / ARCHIVIO COMPATTO
- G21 spostato in GAP INTEGRATI / ARCHIVIO COMPATTO come integrato parziale
- aggiornato G10A per chiarire che non serve per residui command/edit visuali
- aggiornato G19 con nota post Input Context Consistency
- aggiornato ordine consigliato gap/nodi post Input Context Consistency
- prossimo nodo operativo da decidere in Roadmap
- nessuna modifica DB
- nessuna modifica Supabase
- nessuna modifica payload
- nessuna modifica save flow
- nessuna modifica insert_event / update_event
- nessuna modifica button_input_confirm.Disabled
- nessuna modifica Match Engine
- nessuna riapertura G22
- nessuna anticipazione G10A
- nessun fuzzy matching
- nessun alias system globale
- nessun Input Analysis Model completo