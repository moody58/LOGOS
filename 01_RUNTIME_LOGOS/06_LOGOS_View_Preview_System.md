# 06_LOGOS_View_Preview_System_v10

DATA: 2026-05-13

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il comportamento reale del sistema di preview (sintesi)
nel sistema LOGOS.

Il documento descrive:

- cosa fa realmente la preview oggi
- quali logiche contiene
- quali layer ingloba
- come si comporta a runtime
- quali fonti dati utilizza dopo l’introduzione di ui_state.parsed
- quali limiti restano aperti dopo il Normalization Layer Base
- quali allineamenti visuali sono stati completati con Preview Alignment Base
- come la preview rappresenta la Duration Normalization Base
- come vengono mostrati durata normalizzata e durata ambigua
- come la preview interagisce con select1 / Type Classification Base
- cosa la preview mostra ma non salva direttamente
- come la preview legge il match state project/entity
- come gli hint ambiguità matching derivano da isAmbiguous
- come l’highlight project/entity deriva da matches
- come vengono mostrati i match più specifici
- come la preview resta non decisionale per project/entity
- come la preview convive con create_suggestion_state
- come distinguere hint informativi e suggestion create
- come il container suggestion supporta la preview senza essere fonte di salvataggio
- come la preview resta separata da insert_project / insert_entity
- come entity autofill controlled minimal resta fuori dalla preview
- come la Sintesi è stata confermata dentro UX Mobile Coherence Pass
- come la card “Da verificare” resta separata dalla Sintesi
- come il notice associazioni mancanti resta collegato alla Sintesi
- come Dati evento resta la zona decisionale separata dalla Sintesi
- come “Cambia” / “Scegli” restano micro-azioni visive non cliccabili
- come Feedback mobile e Navigation dock restano esterni alla preview
- come la baseline 16px mobile Safari riguarda input/select, non la logica preview
- come la preview convive con Command Intent — Create Project / Entity
- come container_command_intent sostituisce Sintesi / Dati evento quando l’input è comando puro
- come command_intent_state resta separato dalla preview
- come i comandi puri non devono essere rappresentati come eventi
- come “crea progetto”, “crea entità” e “modifica evento” vengono gestiti fuori dalla Sintesi evento
- come “Da verificare” resta ancora interno alla Sintesi e non è blocco autonomo
- come il rendering progressivo dell’input evento normale resta un limite UX aperto

⚠ NON descrive un modello ideale
⚠ descrive lo stato reale attuale

------------------------------------------------
POSIZIONE NEL SISTEMA
------------------------------------------------

Layer:

→ sintesi (Retool)

Collocazione attuale:

input_raw
→ trigger_parse_debounced
→ command_intent_state
→ parse_input_controlled
→ ui_state.parsed
→ project_state / entity_state
→ create_suggestion_state
→ select_project / select_entity
→ select1 / type classification base
→ preview (sintesi) / card Da verificare / suggestion container
→ oppure container_command_intent
→ Dati evento oppure command action
→ confirm evento / insert_project / insert_entity / go events
→ feedback temporaneo
→ routing post-save

Nota post UX Mobile Coherence Pass:

Feedback temporaneo, routing post-save e Navigation dock NON fanno parte della preview.

Sono layer UI separati:

- preview / Sintesi = rappresentazione input evento interpretato
- Da verificare = controllo/hint operativo ancora interno alla Sintesi
- suggestion container = proposta azione project/entity da input evento
- container_command_intent = rappresentazione comando puro
- Dati evento = decisione salvabile per evento ordinario
- command action = azione controllata per comando puro
- feedback = conferma temporanea post-save / post-create
- navigation dock = navigazione UI

---

La preview si colloca dopo il parsing controllato
e legge i dati strutturati principalmente da:

ui_state.parsed

Per il type, la preview legge anche:

select1.value

Nota terminologica:

select1 è un componente UI Select di Retool,
non una query.

Per il matching project/entity, la preview legge anche:

project_state.data
entity_state.data

In particolare:

- matches
- count
- isAmbiguous
- singleMatch
- hasMoreSpecificMatches

Per le suggestion project/entity, il container suggestion legge anche:

create_suggestion_state.data

Nota:

create_suggestion_state non è preview pura.
È un helper controllato che alimenta suggestion create.

command_intent_state non è preview pura.

È un helper controllato che distingue:

- input evento ordinario
- comando strutturale puro
- guida non operativa

command_intent_state alimenta container_command_intent,
non la Sintesi evento.

Regola:

quando command_intent_state riconosce un comando puro,
la Sintesi evento e Dati evento devono essere nascosti.

La preview/sintesi, il suggestion container e il command container devono restare concettualmente distinti:

- preview = rappresentazione dell’input evento interpretato
- hint informativi = stato del match / durata / type
- suggestion create = proposta di azione guidata dentro flow evento
- command intent = comando puro separato dal flow evento
- command action = azione controllata fuori dal salvataggio evento

---

Nota:

Il save flow non dipende più da parsing interno alla preview
né da parsing duplicato nel bottone confirm.

Il save flow non dipende da create_suggestion_state.

create_suggestion_state può aiutare a creare project/entity,
ma l’evento viene salvato solo tramite:

select_project.value
select_entity.value

dentro button_input_confirm.

insert_project / insert_entity non salvano eventi.

Command Intent non salva eventi.

Quando l’input è un comando puro:

- button_input_confirm non deve essere usato
- insert_event / update_event non devono essere eseguiti
- Sintesi evento non deve rappresentare il comando come evento
- Dati evento non devono essere mostrati
- container_command_intent diventa il layer UI principale

Il save flow non dipende dalla preview per il type.

Il type viene salvato tramite:

select1.value
→ button_input_confirm payload.type
→ insert_event / update_event
→ events.type

Il save flow non dipende dalla preview per project/entity.

project_id viene salvato tramite:

select_project.value
→ button_input_confirm payload.project_id
→ insert_event / update_event
→ events.project_id

entity_id viene salvato tramite:

select_entity.value
→ button_input_confirm payload.entity_id
→ insert_event / update_event
→ events.entity_id

------------------------------------------------
RUOLO DELLA PREVIEW
------------------------------------------------

La preview è il punto di visualizzazione dello stato input.

Mostra:

✔ dati parsati  
✔ dati normalizzati base 
✔ durate normalizzate in minuti  
✔ durata in forma umana  
✔ hint normalizzazione durata  
✔ hint durata ambigua 
✔ type corrente tramite select1.value  
✔ supporto visivo alla Type Classification Base    
✔ label derivata  
✔ stato matching  
✔ match state project/entity  
✔ hint ambiguità da isAmbiguous  
✔ hint match più specifici  
✔ highlight project/entity da matches  
✔ hint utente  
✔ supporto visuale al container suggestion
✔ distinzione tra hint informativo e suggestion create
✔ Sintesi strutturata mobile confermata
✔ card “Da verificare” separata dalla Sintesi
✔ notice associazioni mancanti nella Sintesi
✔ micro-azioni visive “Cambia” / “Scegli”
✔ coerenza visuale con Dati evento compatti
✔ esclusione dei comandi puri dal rendering evento
✔ convivenza controllata con container_command_intent
✔ separazione tra input evento e command intent

---

ATTENZIONE:

La preview NON è ancora una view pura.

Attualmente è ancora:

👉 un layer ibrido (view + trasformazione)

Contiene:

- rendering dati
- label cleaning
- hint logic
- highlight
- formattazioni locali
- logiche di supporto UX

Nota post Command Intent:

La preview continua a rappresentare solo input evento ordinari.

Non deve rappresentare come evento:

- crea
- crea progetto
- crea progetto [nome]
- crea entità
- crea entità [nome]
- modifica evento

Questi casi appartengono a container_command_intent.

Nota post Project / Entity Create Suggestion:

Il container suggestion NON trasforma la preview in fonte di salvataggio.

La preview continua a mostrare lo stato interpretato dell’input.
La suggestion create è un’azione separata, controllata e confermata dall’utente.

Nota post UX Mobile Coherence Pass:

La Sintesi è stata resa più leggibile e coerente su mobile,
ma non è diventata una form.

La Sintesi non sostituisce:

- select1
- select_project
- select_entity
- button_input_confirm

La zona decisionale resta Dati evento.

Nota post Command Intent:

Per input evento ordinari, la zona decisionale resta Dati evento.

Per comandi puri, la zona decisionale diventa container_command_intent.

Esempi:

crea progetto Villa Nuova
→ container_command_intent
→ btn_command_create_project
→ insert_project

crea entità Patrizio
→ container_command_intent
→ btn_command_create_entity
→ insert_entity

modifica evento
→ container_command_intent
→ btn_command_go_events
→ Lista eventi

---

Rispetto allo stato precedente:

✔ il parsing strutturato non è più duplicato nel confirm  
✔ amount/unit/event_date arrivano da ui_state.parsed  
✔ save/DB sono più coerenti  
✔ amount/unit sono ora visualizzati in formato italiano coerente  
✔ label cleaning aggiornato sui casi già normalizzati  
✔ date separate correttamente dalla descrizione  
✔ highlight locale reso unit-safe  
✔ durata certa visualizzata in forma umana  
✔ valore tecnico normalizzato mostrato come hint  
✔ giorni/settimane segnalati come durata ambigua  
✔ select1 allineato a ui_state.parsed.unit  
✔ parsed.unit = minuti → type Tempo  
✔ Spesa / Incasso / Evento gestiti tramite select1  
✔ scelta manuale utente preservata  

Ma:

⚠ la preview contiene ancora trasformazioni proprie  
⚠ la preview non è ancora un layer read-only puro  
⚠ label cleaning, hint logic e highlight restano embedded nella sintesi  
⚠ type mostrato/supportato dalla preview, ma salvato dal confirm flow  
⚠ hint duration/type restano embedded nella preview  
⚠ preview model unico non implementato   
⚠ Cambia / Scegli sono ancora indicatori visivi, non azioni cliccabili
⚠ Feedback mobile non è preview
⚠ Navigation dock non è preview
⚠ Dati evento resta separato dalla Sintesi
⚠ “Da verificare” resta ancora interno alla Sintesi
⚠ hint bloccanti / warning informativi / suggestion visuali non sono ancora separati in stati autonomi
⚠ rendering progressivo dell’input evento normale ancora migliorabile
⚠ Command Intent è separato dalla preview ma non esiste ancora un input analysis model unico

------------------------------------------------
INPUT DELLA PREVIEW
------------------------------------------------

Fonti dati utilizzate:

- input_raw.value
- ui_state.parsed
- select_project.value
- select_entity.value
- projects_list.data
- entities_list.data
- project_state.data
- entity_state.data
- select1.value
- create_suggestion_state.data
- project_create_suggestion_dismissed.value
- entity_create_suggestion_dismissed.value

Nota Command Intent:

La preview NON deve usare command_intent_state come fonte di rappresentazione evento.

command_intent_state appartiene al container_command_intent.

La preview può essere nascosta quando:

command_intent_state.data?.isCommand === true

oppure quando l’input è riconosciuto come comando puro pendente.

Nota UX Mobile Coherence Pass:

La preview NON legge:

- feedback_summary
- feedback_mode
- container_app_nav
- stato Dashboard
- Navigation dock
- command_intent_state come fonte evento

Motivo:

feedback_summary / feedback_mode appartengono al feedback post-save o post-create.
container_app_nav appartiene alla navigazione UI.
command_intent_state appartiene al container_command_intent.
La preview resta limitata alla rappresentazione dell’input evento interpretato.

Nota:

select1.value è la fonte runtime del type per la preview.

La preview può usare select1.value per rappresentare il type,
ma non scrive direttamente events.type.

La persistenza avviene solo nel confirm flow.

Dopo Match Engine Unification First Controlled Level:

project_state.data / entity_state.data forniscono:

- matches
- count
- hasMatch
- isAmbiguous
- singleMatch
- moreSpecificMatches
- hasMoreSpecificMatches

Dopo Project / Entity Create Suggestion First Controlled Level:

create_suggestion_state.data fornisce:

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

---

Fonte dati strutturata principale:

```js
ui_state.parsed = {
  amount,
  unit,
  event_date
}

Fonti ancora multiple:

parsed data
raw input
match state project/entity
select values
select1.value
create_suggestion_state
command_intent_state
dismissed state project/entity
local label logic
local hint logic
command UI logic

Conseguenza:

✔ dati principali coerenti con save flow
⚠ preview ancora dipendente da più fonti
✔ matching project/entity più coerente con select/confirm
⚠ preview ancora dipendente da più fonti
⚠ possibile incoerenza visuale su hint non matching
⚠ possibile divergenza tra dato interno e formattazione mostrata
✔ command intent separato dal salvataggio evento
⚠ input analysis model unico non implementato
⚠ esistono ancora più helper interpretativi specializzati

OUTPUT DELLA PREVIEW

Output UI composto da:

- card Sintesi
- labelStyled
- stato OK / Verifica / Attenzione
- righe dati:
  - Tipo
  - Data
  - Importo
  - Progetto
  - Entità
- micro-azioni visive:
  - Cambia
  - Scegli
- card Da verificare, se necessaria
- notice associazioni mancanti, se necessario

Non include:

- container_command_intent
- txt_command_intent_title
- txt_command_intent_description
- txt_command_edit_steps
- input_command_project_name
- input_command_entity_name
- btn_command_create_project
- btn_command_create_entity
- btn_command_go_events

Nota:

Le micro-azioni “Cambia” / “Scegli” sono solo indicatori visivi.

Non sono ancora cliccabili.

Possibili comportamenti futuri:

- focus campo relativo
- scroll verso Dati evento
- highlight temporaneo select
- apertura dropdown solo se Retool lo consente stabilmente

Container suggestion separato:

create_suggestion_hint
azioni Crea progetto / Crea entità / Ignora
micro-editor project/entity

Dopo UX Mobile Coherence Pass:

Il container suggestion è stato rifinito graficamente,
ma resta separato dalla Sintesi.

La suggestion create continua a non essere dato preview persistito.

Nota:

questi elementi sono collegati alla preview UX,
ma non fanno parte della stringa `labelStyled`.

La suggestion create è UI di supporto,
non dato preview persistito.

Container command separato:

container_command_intent
azioni Crea progetto / Crea entità / Vai agli eventi
input_command_project_name
input_command_entity_name

Dopo Command Intent — Create Project / Entity:

Il container_command_intent è stato introdotto per evitare che
i comandi puri vengano trattati come eventi.

Il command container non fa parte della stringa labelStyled.

Regola:

container_command_intent sostituisce Sintesi evento e Dati evento
quando l’input è un comando puro.

La UI command è supporto operativo controllato,
non dato preview persistito.

Formato:

[labelStyled]
[typeBadge]
[hint]

Join:

.filter(Boolean).join("\n")

Output visivo attuale:

amount
unit
type / typeBadge
label
eventuale data
eventuale project/entity
eventuale hint

Nota:

Il dato interno resta numerico e non localizzato.

La visualizzazione viene formattata solo nella preview.

Esempio durata normalizzata:

Dato interno:

amount: 150
unit: minuti

raw_input:

2h30 rendering

Preview attuale:

2 ore 30 minuti • rendering
Normalizzato: 150 minuti

DB:

amount 150
unit minuti

Regola:

la durata viene salvata come minuti canonici.
La forma umana è solo visuale.
raw_input conserva la forma originaria inserita dall’utente.

Esempio type classification:

Dato interno parsing:

amount: 150
unit: minuti

raw_input:

2h30 rendering

select1:

Tempo

Preview:

2 ore 30 minuti • rendering
Normalizzato: 150 minuti
typeBadge / select1: Tempo

DB dopo confirm:

type Tempo
amount 150
unit minuti

Regola:

la preview rappresenta il type corrente,
ma non salva direttamente il dato.

Esempio command generico:

raw_input:

crea

Preview evento:

non mostrata

Command container:

guida con esempi di creazione progetto / entità

DB:

nessun evento salvato

---

Esempio create project:

raw_input:

crea progetto Villa Nuova

Preview evento:

non mostrata

Command container:

riepilogo progetto + CTA Crea progetto

Azione:

btn_command_create_project
→ insert_project

DB:

nuovo record in projects
nessun evento salvato

---

Esempio create entity:

raw_input:

crea entità Patrizio

Preview evento:

non mostrata

Command container:

riepilogo entità + CTA Crea entità

Azione:

btn_command_create_entity
→ insert_entity

DB:

nuovo record in entities
nessun evento salvato

---

Esempio elemento già presente:

raw_input:

crea progetto villa

Preview evento:

non mostrata

Command container:

Elemento già presente

Azione:

nessun bottone crea

DB:

nessuna duplicazione
nessun evento salvato

---

Esempio guida modifica evento:

raw_input:

modifica evento

Preview evento:

non mostrata

Command container:

guida operativa + CTA Vai agli eventi

Azione:

btn_command_go_events
→ Lista eventi

DB:

nessuna modifica
nessun evento salvato

------------------------------------------------
COMMAND INTENT E PREVIEW
------------------------------------------------

Il nodo Command Intent — Create Project / Entity ha introdotto
un layer UI separato dalla Sintesi.

Componenti coinvolti:

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

Regola principale:

la preview non deve competere con il command intent.

Se l’input è un evento ordinario:

- mostra Sintesi
- mostra eventuale Da verificare
- mostra suggestion container se necessario
- mostra Dati evento
- button_input_confirm salva evento dopo conferma

Se l’input è comando puro:

- nasconde Sintesi
- nasconde Dati evento
- nasconde suggestion container evento se necessario
- mostra container_command_intent
- usa azioni command dedicate
- non salva eventi

---

Casi gestiti:

crea
→ guida con esempi
→ nessuna preview evento

crea progetto
→ input_command_project_name
→ nessuna preview evento

crea progetto [nome]
→ riepilogo command
→ btn_command_create_project
→ nessuna preview evento

crea entità
→ input_command_entity_name
→ nessuna preview evento

crea entità [nome]
→ riepilogo command
→ btn_command_create_entity
→ nessuna preview evento

crea progetto villa
→ Elemento già presente
→ nessun bottone crea
→ nessuna preview evento

modifica evento
→ guida step
→ btn_command_go_events
→ nessuna preview evento

---

Nota:

Command Intent non rende la preview più pura.
La separa solo dal caso comando puro.

La preview resta ibrida per gli input evento ordinari.

COMPONENTI LOGICI INTERNI

La preview contiene attualmente:

Solo per input evento ordinari.

Per command intent, questi componenti devono essere bypassati
o nascosti lato UI.

VALUE BUILDER

costruzione amount + unit
lettura da ui_state.parsed
formattazione visuale italiana

Gestione formati:

euro
minuti
durate normalizzate

Funzioni introdotte:

- formatAmountIT
- formatUnitIT
- formatDurationHumanIT
- formatDurationMinutesIT

Comportamento:

- euro → simbolo €
- euro → due decimali
- amount euro con grouping migliaia
- ore/minuti → massimo due decimali
- virgola italiana nei decimali
- singolare/plurale unit gestito

Esempi:

1500 euro → 1.500,00 €
1.500,50 euro → 1.500,50 €
18min → 18 minuti
1ora → 1 ora + hint Normalizzato: 60 minuti
1 ora e 15 minuti → 1 ora 15 minuti + hint Normalizzato: 75 minuti
2h30 → 2 ore 30 minuti + hint Normalizzato: 150 minuti
2,7 ore → 2 ore 42 minuti + hint Normalizzato: 162 minuti

Nota:

il value builder non modifica ui_state.parsed
e non modifica il dato salvato.

Nel caso delle durate, il value builder mostra una forma umana
partendo dal valore interno già normalizzato in minuti.

Esempio:

ui_state.parsed.amount = 150
ui_state.parsed.unit = minuti

preview value:

2 ore 30 minuti

hint:

Normalizzato: 150 minuti

DATE FORMATTER
converte YYYY-MM-DD → formato breve leggibile
mesi localizzati

TYPE DISPLAY / SELECT1 SUPPORT

La preview utilizza select1.value come fonte runtime del type.

select1 è il componente UI Select dedicato alla classificazione base.

Valori attuali:

- Evento
- Tempo
- Spesa
- Incasso

Relazione con Type Classification Base:

parsed.unit = minuti
→ select1 = Tempo

euro + keyword controllate di uscita
→ select1 = Spesa

euro + keyword controllate di entrata
→ select1 = Incasso

euro senza direzione chiara
→ select1 = Evento

segnali contrastanti
→ select1 = Evento

nessuna unit significativa
→ select1 = Evento

Esempi:

2h30 rendering
→ preview durata: 2 ore 30 minuti
→ select1: Tempo

20 euro spesa materiale
→ preview amount: 20,00 €
→ select1: Spesa

20 euro incasso cliente
→ preview amount: 20,00 €
→ select1: Incasso

20 euro materiale
→ preview amount: 20,00 €
→ select1: Evento

Nota:

la preview non decide autonomamente il type.
La logica è nel Default value del componente select1.

La preview mostra/supporta lo stato risultante.

LABEL CLEANING (ATTIVO)

Operazioni:

- normalizzazione testo
- separazione simboli (€)
- gestione unit compatte
- rimozione amount + unit già rappresentati dal value
- rimozione date già parse
- compressione spazi
- preservazione numeri semantici
- ricomposizione parola + numero
- rimozione durate composte già normalizzate
- rimozione forme compatte tipo 2h30
- rimozione residui congiunzione e/ed

Aggiornamenti Preview Alignment Base:

✔ rimozione migliorata di euro separati e compatti  
✔ rimozione migliorata di ore separate e compatte  
✔ rimozione migliorata di minuti separati e compatti  
✔ corretto bug "minuti" → "uti"  
✔ preservato caso "villa 2"  
✔ label più coerente con ui_state.parsed 
✔ durate composte rimosse dopo Duration Normalization  
✔ forme compatte 2h30 / 2 h 30 rimosse dalla label  
✔ residui “e/ed” rimossi dopo cleaning durata  
✔ gestione € prima del numero corretta  
✔ bug duplicazione €500 risolto   

Esempi:

1.500,50 euro materiale
→ 1.500,50 € • materiale

18 minuti test
→ 18 minuti • test

18min test
→ 18 minuti • test

1 ora e 15 minuti sopralluogo
→ 1 ora 15 minuti • sopralluogo
→ Normalizzato: 75 minuti

2h30 rendering
→ 2 ore 30 minuti • rendering
→ Normalizzato: 150 minuti

2 ore e 30 minuti rendering
→ 2 ore 30 minuti • rendering
→ Normalizzato: 150 minuti

villa 2 mario
→ villa 2 mario

€500 acconto alfie mario rossi
→ 500,00 € • acconto alfie mario rossi

Nota:

il label cleaning resta visuale,
embedded nella sintesi e non persistito.

TOKEN LOGIC
split parole
recombine parola + numero
(es: "villa 2")
limitazione lunghezza label

LABEL BUILDING

Struttura:

MAIN:

[data] • [value] • [primary]

oppure, senza amount/unit:

[data] • [primary]

Output:

labelFull / labelStyled

Aggiornamento:

la data viene separata dalla descrizione anche quando non esiste amount/unit.

Esempio:

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

HIGHLIGHT ENGINE

evidenzia:

entity → verde (#059669)
project → blu (#2563eb)

Fonte dati dopo Match Engine Unification First Controlled Level:

project_state.data.matches
entity_state.data.matches

---

Comportamento:

- project evidenziati dai matches di project_state
- entity evidenziate dai matches di entity_state
- quando possibile viene evidenziato il nome completo
- la preview non calcola più detection locale come fonte decisionale matching

Esempio:

villa 2 mario
→ villa 2 evidenziato come project
→ mario evidenziato come entity

---

Protezione:

escape regex

---

Token tecnici esclusi:

- ora
- ore
- h
- min
- minuto
- minuti
- euro
- eur
- giorno
- giorni
- settimana
- settimane
- giornata
- giornate

Funzioni runtime ancora presenti:

previewStopTokens
getPreviewTokens

Nota:

questo filtro resta utile per evitare highlight impropri
su unità tecniche o parole non rilevanti.

Dopo Match Engine Unification,
l’highlight project/entity legge però i matches da:

- project_state.data.matches
- entity_state.data.matches

La preview non usa più detection locale come fonte decisionale matching.

HINT SYSTEM

Basato su:

- project_state.data
- entity_state.data
- parsed.unit
- select1.value
- contenuto testo
- condizioni locali preview

---

TIPI DI HINT:

AMBIGUITÀ MATCHING:

entity_state.isAmbiguous = true
e select_entity vuoto
→ "⚠️ Più entità trovate"

project_state.isAmbiguous = true
e select_project vuoto
→ "⚠️ Più progetti trovati"

------------------------------------------------
STRUTTURA UX MOBILE DELLA SINTESI
------------------------------------------------

Durante UX Mobile Coherence Pass, la Sintesi è stata confermata come card strutturata.

Struttura:

- intestazione Sintesi
- indicatore stato:
  - OK
  - Verifica
  - Attenzione
- frase interpretata
- righe dati:
  - Tipo
  - Data
  - Importo
  - Progetto
  - Entità
- micro-azioni visive:
  - Cambia
  - Scegli

Regola:

La Sintesi rappresenta ciò che LOGOS ha interpretato.

Non decide cosa salvare.

Le fonti salvabili restano:

- select1.value
- select_project.value
- select_entity.value
- ui_state.parsed

La Sintesi non è una form.

------------------------------------------------
CARD “DA VERIFICARE”
------------------------------------------------

Durante UX Mobile Coherence Pass, gli hint operativi sono stati confermati
come blocco separato dalla Sintesi.

Ruolo:

- mostrare controlli richiesti
- evidenziare ambiguità
- evidenziare warning non bloccanti
- guidare l’utente verso Dati evento

Esempi:

- Più entità trovate
- Più progetti trovati
- Definisci spesa o incasso
- Esistono progetti più specifici
- Normalizzato: X minuti
- Durata ambigua

Regola:

La Sintesi mostra cosa LOGOS ha interpretato.
La card Da verificare mostra cosa l’utente deve controllare.

Decisione:

Non è stata creata una tab Ambiguità.
La separazione resta una card visibile solo quando serve.

------------------------------------------------
NOTICE ASSOCIAZIONI MANCANTI
------------------------------------------------

Durante UX Mobile Coherence Pass è stato confermato il notice informativo
quando mancano progetto e/o entità ma non c’è ambiguità bloccante.

Esempi:

- Manca un progetto e un’entità
- Manca un progetto
- Manca un’entità

Testo:

“Puoi selezionare i dati nei campi sotto o usare i suggerimenti.”

Regola:

Il notice NON compare in presenza di ambiguità bloccante.

Motivo:

In presenza di ambiguità, la priorità comunicativa resta la card Da verificare.

Decisione:

Il notice resta nella Sintesi perché collega:

- interpretazione
- suggestion container
- Dati evento

---

SUGGESTION CREATE:

create_suggestion_state può produrre hint/azioni di creazione, ad esempio:

- Nessun progetto associato
- Nessuna entità associata
- Crea progetto “Villa Sierri 15”
- Crea entità “Referente Kappa”

Questi non sono semplici hint informativi.

Sono suggestion create, cioè azioni guidate.

Differenza:

HINT INFORMATIVO:

- segnala uno stato
- non apre insert
- non modifica DB
- non modifica select

Esempi:

- Esistono progetti più specifici
- Esistono entità più specifiche
- Normalizzato: 150 minuti

SUGGESTION CREATE:

- propone una possibile azione
- può aprire micro-editor
- può eseguire insert_project / insert_entity
- richiede conferma utente
- non salva evento automaticamente

Esempi:

- Crea progetto Villa Sierri 15
- Crea entità Referente Kappa

Distinzione da Command Intent:

create_suggestion_state opera dentro il flow evento ordinario.

Esempio:

30 euro spesa villa nuova
→ evento ordinario
→ possibile suggestion progetto
→ eventuale creazione inline
→ poi Conferma evento

command_intent_state opera fuori dal flow evento ordinario.

Esempio:

crea progetto Villa Nuova
→ comando puro
→ container_command_intent
→ insert_project
→ nessun evento salvato

Regola:

Le due UI non devono competere.

- suggestion container = supporto associazione evento
- command container = comando strutturale puro

---

MATCH PIÙ SPECIFICI:

entity_state.hasMoreSpecificMatches = true
e singleMatch selezionato
→ "ℹ️ Esistono entità più specifiche"

project_state.hasMoreSpecificMatches = true
e singleMatch selezionato
→ "ℹ️ Esistono progetti più specifici"

---

ECONOMICO / TYPE:

ℹ️ Definisci spesa o incasso

Usato quando:

- è presente euro
- manca una direzione economica chiara
- select1 resta Evento
- l’utente deve scegliere manualmente Spesa o Incasso

---

TEMPO:

ℹ️ Normalizzato: X minuti

⚠️ Durata ambigua: specifica ore/minuti per salvarla come tempo analizzabile

---

Caratteristiche:

✔ hint matching project/entity alimentati da state  
✔ hint ambiguità matching bloccanti finché non risolti  
✔ hint match più specifici informativi e non bloccanti  
✔ hint rossi spariscono se l’utente risolve manualmente l’ambiguità  
✔ hint duration/type ancora embedded nella preview  
✔ controllo utente preservato  

---

Aggiornamento Duration Normalization Base:

- il vecchio hint generico “Verifica durata” è stato superato
- le durate certe mostrano il valore tecnico normalizzato
- giorni/settimane mostrano hint ambiguità

---

Aggiornamento Type Classification Base:

- select1 è allineato a ui_state.parsed.unit
- le durate certe con unit = minuti impostano Tempo
- euro + keyword controllate imposta Spesa o Incasso
- euro senza direzione chiara resta Evento
- la preview può guidare l’utente alla scelta manuale
- il type viene poi salvato dal confirm flow

---

Aggiornamento Match Engine Unification First Controlled Level:

- hint matching project/entity derivano da project_state/entity_state
- hint ambiguità derivano da isAmbiguous
- hint più specifici derivano da hasMoreSpecificMatches
- preview non ricalcola matching decisionale
- confirm guard blocca solo ambiguità non risolte

Limite:

non esiste ancora un hint engine globale separato.

Aggiornamento Project / Entity Create Suggestion First Controlled Level:

- no-match project/entity può generare suggestion create
- suggestion create non è salvataggio evento
- suggestion ignorata non blocca conferma
- project/entity ambigui non mostrano create suggestion per quel layer
- project/entity mancanti non bloccano conferma
- entity autofill controlled minimal precompila input_new_entity_name, ma non è preview

COMPORTAMENTO MATCHING IN PREVIEW

La preview NON è fonte primaria di matching.

Dopo Match Engine Unification First Controlled Level:

✔ utilizza project_state/entity_state  
✔ evidenzia matches da match state  
✔ mostra ambiguità tramite isAmbiguous  
✔ mostra match più specifici tramite hasMoreSpecificMatches  
✔ non usa detection locale come fonte decisionale  
✔ resta supporto visuale alla scelta utente  

---

Regole generali:

count = 1
→ singleMatch
→ select_project/select_entity valorizzati
→ preview evidenzia match
→ conferma abilitata

count > 1
→ isAmbiguous
→ select vuota
→ hint rosso
→ conferma disabilitata finché l’utente non sceglie

count = 0
→ nessuna ambiguità
→ conferma non bloccata
→ possibile suggestion create tramite create_suggestion_state

hasMoreSpecificMatches = true
→ hint informativo non bloccante

---

Esempi:

villa 2 mario
→ project Villa 2
→ entity Mario
→ evidenza project/entity
→ conferma abilitata

mario
→ entity Mario
→ hint Esistono entità più specifiche
→ conferma abilitata

villa
→ project Villa
→ hint Esistono progetti più specifici
→ conferma abilitata

alfie mario rossi
→ ambiguità reale entity
→ hint Più entità trovate
→ conferma disabilitata

---

Nota:

la preview rappresenta il match state,
ma non salva direttamente project/entity.

Il salvataggio avviene tramite:

select_project.value
select_entity.value

Dopo Project / Entity Create Suggestion:

se l’utente crea project/entity inline,
la select relativa viene valorizzata.

La preview continua comunque a non salvare direttamente project/entity.

------------------------------------------------
RELAZIONE CON CREATE SUGGESTION
------------------------------------------------

La preview/sintesi convive con un container suggestion separato.

create_suggestion_state legge:

- input_raw
- project_state
- entity_state
- projects_list
- entities_list
- select_project
- select_entity

e produce suggestion controllate per project/entity.

---

PRINCIPIO:

Preview ≠ suggestion create.

La preview mostra ciò che il sistema ha interpretato.

La suggestion create propone un’azione possibile.

---

ESEMPI:

1. Match informativo più specifico

input:

villa

preview/hint:

Esistono progetti più specifici

Comportamento:

- hint informativo
- nessun insert
- Conferma abilitata

2. Suggestion create project

input:

villa sierri 15 sopralluogo

container suggestion:

Crea progetto “Villa Sierri 15”

Comportamento:

- azione guidata
- richiede click utente
- insert_project solo dopo conferma
- evento non salvato automaticamente

3. Suggestion create entity

input:

villa sierri 15 sopralluogo referente kappa

container suggestion:

Crea entità “Referente Kappa”

Comportamento:

- input_new_entity_name può essere precompilato
- insert_entity solo dopo conferma
- evento non salvato automaticamente

4. No-match generico ignorato

input:

acquisto 50 euro materiale nuovo

container suggestion:

Nessun progetto associato
Nessuna entità associata

utente clicca Ignora

Comportamento:

- container suggestion nascosto
- preview resta valida
- Conferma abilitata
- evento salvabile con project_id/entity_id null

---

ENTITY AUTOFILL CONTROLLED MINIMAL

L’autofill entity:

- non è preview
- non è matching
- non è salvataggio
- non crea entità
- precompila solo input_new_entity_name

Esempio:

referente kappa
→ input_new_entity_name = Referente Kappa

Non viene usato per labelStyled
e non modifica raw_input.

RELAZIONE CON PARSING

Parsing strutturato avviene ora in:

✔ parse_input_controlled

e viene trasferito in:

✔ ui_state.parsed

La preview legge:

ui_state.parsed.amount
ui_state.parsed.unit
ui_state.parsed.event_date

Per il type, la preview legge:

select1.value

select1.value può dipendere da ui_state.parsed.unit.

Esempio:

ui_state.parsed.unit = minuti
→ select1.value = Tempo

Dopo il Normalization Layer Base:

ui_state.parsed contiene:

amount numerico
unit normalizzata
event_date
numeri senza unità esclusi da amount
amount con formato italiano convertito a numero

Esempi dati interni:

1.500,50 euro → amount 1500.5, unit euro
1ora lavoro → amount 60, unit minuti
1 ora e 15 minuti → amount 75, unit minuti
2h30 rendering → amount 150, unit minuti
2 ore 30 rendering → amount 150, unit minuti
villa 2 mario → amount null, unit null
2 giorni rendering → amount null, unit null

Esempi type:

2h30 rendering
→ amount 150, unit minuti
→ select1 Tempo

20 euro spesa materiale
→ amount 20, unit euro
→ select1 Spesa

20 euro incasso cliente
→ amount 20, unit euro
→ select1 Incasso

20 euro materiale
→ amount 20, unit euro
→ select1 Evento

villa 2 mario
→ amount null, unit null
→ select1 Evento

Nota:

dopo Duration Normalization Base,
le durate certe ore/minuti vengono salvate sempre in minuti.

La preview può però mostrare una forma umana:

amount 150 / unit minuti
→ 2 ore 30 minuti
→ Normalizzato: 150 minuti

MA:

⚠ la preview applica ancora ulteriori trasformazioni:

cleaning
rimozione pattern
ricostruzione label
formattazione locale
hint logic

Quindi:

✔ la preview è più coerente nei dati principali
✘ ma non è ancora pura rappresentazione

RELAZIONE CON NORMALIZATION LAYER BASE / DURATION NORMALIZATION / TYPE CLASSIFICATION / MATCH ENGINE / CREATE SUGGESTION

Il Normalization Layer Base ha consolidato:

- amount normalization
- unit normalization
- numeri senza unità ignorati come amount
- formato numerico italiano convertito a numero
- insert/update basati su ui_state.parsed

Preview Alignment Base ha allineato la rappresentazione visuale
a questo stato.

Duration Normalization Base ha poi introdotto:

- unità canonica tempo = minuti
- conversione ore/minuti in minuti
- conversione durate composte
- conversione forme compatte tipo 2h30
- visualizzazione umana della durata in preview
- hint “Normalizzato: X minuti”
- hint durata ambigua per giorni/settimane

Type Classification Base ha poi introdotto:

- select1 allineato a ui_state.parsed.unit
- parsed.unit = minuti → Tempo
- euro + keyword controllate di uscita → Spesa
- euro + keyword controllate di entrata → Incasso
- euro senza direzione chiara → Evento
- scelta manuale utente preservata
- type salvato tramite confirm flow

Match Engine Unification First Controlled Level ha poi introdotto:

- project_state / entity_state come fonte minima matching
- select_project / select_entity alimentati da singleMatch
- hint ambiguità alimentati da isAmbiguous
- hint match più specifici alimentati da hasMoreSpecificMatches
- highlight alimentato da matches
- confirm guard basata su ambiguità non risolta
- match state live in create flow
- match state live in edit flow
- bug €500 label preview risolto

Project / Entity Create Suggestion First Controlled Level ha poi introdotto:

- create_suggestion_state
- suggestion create per project/entity
- container suggestion inline
- ignore globale suggestion
- micro-editor project/entity
- entity autofill controlled minimal
- distinzione tra hint informativo e suggestion create
- salvataggio evento separato dalla creazione project/entity

Implementato:

✔ 1500.5 → 1.500,50 €  
✔ 1500 → 1.500,00 €  
✔ 1.5 ore → 1,5 ore  
✔ 1 ora → 1 ora  
✔ 18 minuti → 18 minuti  
✔ 6/4/26 → 6 apr separato dalla descrizione  
✔ label cleaning coerente con amount/unit già rappresentati  
✔ unità tecniche escluse dall'highlight locale  
✔ 1 ora → 60 minuti  
✔ 1,5 ore → 90 minuti  
✔ 1 ora e 15 minuti → 75 minuti  
✔ 2h30 → 150 minuti  
✔ 2 ore 30 → 150 minuti  
✔ preview durata in forma umana  
✔ hint valore normalizzato  
✔ hint durata ambigua  
✔ select1 allineato a unit = minuti  
✔ 2h30 rendering → Tempo  
✔ Spesa / Incasso base tramite keyword controllate  
✔ euro senza direzione chiara → Evento  
✔ type rappresentato in preview tramite select1.value 
✔ villa 2 mario → project Villa 2 + entity Mario  
✔ ristrutturazione bagno → Ristrutturazione Bagno  
✔ mario → Mario + hint entità più specifiche  
✔ villa → Villa + hint progetti più specifici  
✔ alfie mario rossi → ambiguità reale entity  
✔ €500 → 500,00 € senza duplicazione in label  
✔ highlight project/entity alimentato da matches  
✔ hint matching alimentati da project_state/entity_state  
✔ suggestion create alimentate da create_suggestion_state
✔ container suggestion inline validato
✔ ignore globale suggestion validato
✔ entity autofill controlled minimal validato
✔ preview non diventa fonte di salvataggio 

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
→ Normalizzato: 60 minuti

6/4/26 inseminazione alfie
→ 6 apr • inseminazione alfie

4 aprile benzina 50 euro alfie allevamento aspri
→ 4 apr • 50,00 € • benzina alfie allevamento aspri

villa 2 mario
→ villa 2 mario

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

Type Classification Base — esempi validati:

2h30 rendering
→ preview: 2 ore 30 minuti • rendering
→ select1: Tempo
→ DB dopo confirm: type Tempo, amount 150, unit minuti

20 euro spesa materiale
→ preview: 20,00 € • spesa materiale
→ select1: Spesa
→ DB dopo confirm: type Spesa, amount 20, unit euro

20 euro incasso cliente
→ preview: 20,00 € • incasso cliente
→ select1: Incasso
→ DB dopo confirm: type Incasso, amount 20, unit euro

20 euro materiale
→ preview: 20,00 € • materiale
→ select1: Evento
→ DB dopo confirm: type Evento, amount 20, unit euro

villa 2 mario
→ preview: villa 2 mario
→ select1: Evento
→ DB dopo confirm: type Evento, amount null, unit null

Nessuna alterazione diretta del dato salvato da parte della preview.

La preview resta visuale.

Il type viene salvato dal confirm flow leggendo select1.value.

Match Engine Unification — esempi validati:

villa 2 mario
→ preview evidenzia Villa 2 e Mario
→ Conferma abilitata

4 aprile benzina 50 euro alfie allevamento aspri
→ project ASPRI
→ entity ambigua
→ hint Più entità trovate
→ Conferma disabilitata finché non viene scelta entità

18 min ristrutturazione bagno
→ project Ristrutturazione Bagno
→ type Tempo
→ Conferma abilitata

mario
→ entity Mario
→ hint Esistono entità più specifiche
→ Conferma abilitata

villa
→ project Villa
→ hint Esistono progetti più specifici
→ Conferma abilitata

€500 acconto alfie mario rossi
→ 500,00 € • acconto alfie mario rossi

Project / Entity Create Suggestion — esempi validati:

villa sierri 15 sopralluogo referente kappa
→ suggestion project Villa Sierri 15
→ suggestion entity Referente Kappa
→ project/entity creati inline previa conferma
→ evento salvato manualmente con project_id/entity_id corretti

acquisto 50 euro materiale nuovo
→ suggestion project/entity visibile
→ Ignora
→ Conferma abilitata
→ evento salvato con project_id null / entity_id null

alfie mario rossi
→ entity ambigua
→ Crea entità non visibile
→ Conferma disabilitata finché non viene scelta entity

RELAZIONE CON INSERT / UPDATE

Dati salvati:

raw_input
type
amount
unit
event_date
project_id
entity_id

Fonti dati salvate:

✔ ui_state.parsed per amount/unit/event_date  
✔ select1.value per type  
✔ select_project.value per project_id  
✔ select_entity.value per entity_id  

button_input_confirm:

✔ non ricalcola più parsing
✔ non contiene più parsing legacy
✔ costruisce payload da ui_state.parsed e select1.value
✔ usa insert_event/update_event
✔ aggiorna events_new dopo save completato

Relazione:

✔ preview e DB leggono lo stesso parsed data di base
✔ dati persistiti sono coerenti con parser controllato
✔ durate certe persistite come amount in minuti e unit = minuti
✔ type persistito in events.type
✔ project_id/entity_id persistiti solo tramite select_project/select_entity  
✔ preview non è fonte di salvataggio project/entity  
✔ match state influenza select/hint/confirm, non scrive direttamente DB  
✔ create_suggestion_state non è fonte di salvataggio evento
✔ insert_project / insert_entity non salvano eventi
✔ dopo creazione inline, l’evento richiede comunque Conferma manuale
✔ suggestion ignorata non blocca insert_event/update_event
✘ label NON persistita
✘ preview applica ancora trasformazioni visive aggiuntive

Esempio durata + type:

input:

2h30 rendering

ui_state.parsed:

amount: 150
unit: minuti

select1:

Tempo

DB:

type: Tempo
amount: 150
unit: minuti
raw_input: 2h30 rendering

preview:

2 ore 30 minuti
Normalizzato: 150 minuti

VINCOLI ATTUALI (REALI)

✔ preview non blocca input
✔ preview sempre attiva quando input presente
✔ preview può essere parzialmente errata
✔ preview non modifica DB
✔ preview non è fonte del salvataggio
✔ preview legge ui_state.parsed per amount/unit/event_date
✔ preview legge select1.value per type
✔ preview non salva direttamente type
✔ preview legge project_state/entity_state per matching  
✔ preview mostra hint ambiguità da isAmbiguous  
✔ preview mostra hint più specifici da hasMoreSpecificMatches  
✔ preview evidenzia project/entity da matches  
✔ preview non decide project/entity  
✔ preview non decide create project/entity
✔ preview non esegue insert_project / insert_entity
✔ create_suggestion_state non salva eventi
✔ suggestion create richiede conferma utente
✔ Sintesi strutturata confermata dentro UX Mobile Coherence Pass
✔ card Da verificare separata dalla Sintesi
✔ notice associazioni mancanti confermato
✔ Dati evento resta zona decisionale separata
✔ feedback mobile resta esterno alla preview
✔ navigation dock resta esterna alla preview



MA:

✘ contiene logica duplicata
✘ contiene cleaning
✘ contiene costruzione label
✘ contiene hint logic embedded
✘ contiene highlight logic embedded
✘ non è ancora view pura
✘ type display e hint sono ancora accoppiati alla preview/select
✘ Cambia / Scegli non sono ancora cliccabili
✘ feedback_summary non è fonte preview
✘ navigation dock non è fonte preview

⚠ dipende da aggiornamenti multipli
⚠ usa ancora fonti multiple
✔ allineata visualmente al Normalization Layer Base per amount/unit/date
✔ allineata visualmente alla Duration Normalization Base per ore/minuti
✔ mostra durata normalizzata senza modificare il dato salvato
✔ matching project/entity allineato a primo livello  
✔ hint matching project/entity state-driven  

⚠ non ancora separata come view pura
✔ container suggestion UI rifinito a livello mobile base
⚠ suggestion create vs edit consistency da verificare
⚠ project creation override con match generico non implementato
⚠ create_suggestion_state aggiunge una fonte UI ulteriore
⚠ command intent non implementato

------------------------------------------------
RELAZIONE CON DATI EVENTO
------------------------------------------------

Dati evento è la zona decisionale finale.

Contiene:

- Tipo evento
- Progetto
- Entità

Durante UX Mobile Coherence Pass, Dati evento è stato compattato
con label inline / affiancate alle select.

Regola:

La Sintesi rappresenta.
Dati evento decide.
button_input_confirm salva.

La preview non sostituisce:

- select1
- select_project
- select_entity

Le micro-azioni “Cambia” / “Scegli” nella Sintesi indicano dove intervenire,
ma non modificano ancora i campi.

------------------------------------------------
RELAZIONE CON FEEDBACK MOBILE
------------------------------------------------

Il feedback mobile introdotto durante UX Mobile Coherence Pass
NON è parte della preview.

feedback_summary appartiene al post-save.

La preview opera prima della conferma evento.
Il feedback opera dopo insert_event / update_event.

Differenza:

Preview / Sintesi:

- rappresenta input interpretato
- usa ui_state.parsed
- usa select1 / select_project / select_entity
- guida l’utente prima del salvataggio

Feedback:

- conferma salvataggio avvenuto
- usa feedback_summary
- è temporaneo
- non modifica DB
- non modifica preview
- viene azzerato dopo auto-return

Regola:

Non usare feedback_summary come fonte preview.

------------------------------------------------
RELAZIONE CON NAVIGATION DOCK
------------------------------------------------

La Navigation dock introdotta durante UX Mobile Coherence Pass
NON è parte della preview.

Componente:

container_app_nav

Voci:

- Home
- Eventi
- Dashboard

La voce Dashboard è presente ma disabilitata.

Regola:

La navigation dock non modifica:

- input_raw
- ui_state.parsed
- project_state
- entity_state
- create_suggestion_state
- select1
- select_project
- select_entity
- button_input_confirm

La navigation dock è solo UI di navigazione contestuale.

Non abilita output.
Non abilita KPI.
Non modifica il comportamento della Sintesi.

------------------------------------------------
RELAZIONE CON MOBILE SAFARI BASELINE
------------------------------------------------

Durante test reale su iPhone 13 Safari sono stati rilevati:

- zoom automatico su tap input
- troncamento laterale dell’interfaccia
- select non pienamente utilizzabili come dropdown

Fix applicato nel sistema UI:

- font-size 16px sui campi editabili/select principali

Campi coinvolti:

- input_home
- input_events_search
- select1
- select_project
- select_entity
- input_new_project_name
- input_new_entity_name

Impatto sulla preview:

- nessuna modifica alla logica preview
- nessuna modifica a label cleaning
- nessuna modifica a hint logic
- nessuna modifica a highlight
- nessuna modifica a save flow

Regola:

Il vincolo 16px riguarda campi editabili e select,
non il modello logico della preview.

Eventuali polish futuri non devono riattivare lo zoom automatico iOS.

LIMITI STRUTTURALI
DUPLICAZIONE LOGICA
label costruita qui
non esiste layer label dedicato runtime
CLEANING DISTRIBUITO
parsing controllato
preview
label cleaning
HINT NON CENTRALIZZATI
hint matching project/entity ora derivati da match state
hint durata normalizzata ancora locale alla preview
hint durata ambigua ancora locale alla preview
hint type/economico ancora locale alla preview/select1
NON È VIEW PURA
contiene trasformazioni dati
contiene label logic
contiene hint logic
DEBUG COMPLESSO
difficile isolare origine problemi visuali
MULTI-SOURCE STATE
parsed
raw_input
select_project/select_entity
select1.value
match state project/entity
project_state/entity_state
create_suggestion_state
dismissed state project/entity
liste project/entity
type select
Dati evento compatti
card Da verificare
notice associazioni mancanti
duration hint locale

→ assenza di preview model unico
→ assenza di suggestion model separato come layer documentale autonomo
→ Cambia / Scegli ancora non azionabili
→ feedback mobile separato ma non parte del preview model
→ navigation dock separata ma non parte del preview model

COMMAND INTENT / PREVIEW:

✔ command intent separato dalla Sintesi evento
✔ comandi puri non renderizzati come eventi
✔ container_command_intent introdotto
✔ feedback command separato dal feedback evento tramite feedback_mode

⚠ input analysis model unico non implementato
⚠ command_intent_state è ancora helper Retool separato
⚠ create_suggestion_state è ancora helper Retool separato
⚠ preview continua a contenere hint/label/highlight embedded
⚠ “Da verificare” resta interno alla Sintesi
⚠ rendering progressivo input evento normale ancora migliorabile

COMMAND INTENT — TEST VALIDATI:

1. Comando generico

Input:

crea

Esito:

- container_command_intent mostrato
- esempi leggibili
- Sintesi evento nascosta
- Dati evento nascosti
- nessun evento salvato

RISULTATO:
OK

---

2. Create project incompleto

Input:

crea progetto

Esito:

- input_command_project_name visibile
- CTA disabilitata a campo vuoto
- Sintesi evento nascosta
- nessun evento salvato

RISULTATO:
OK

---

3. Create project completo

Input:

crea progetto Command Final Project 2

Esito:

- riepilogo command mostrato
- project creato tramite insert_project
- feedback Progetto creato
- ritorno Home automatico
- nessun evento salvato

RISULTATO:
OK

---

4. Create entity incompleto

Input:

crea entità

Esito:

- input_command_entity_name visibile
- CTA disabilitata a campo vuoto
- Sintesi evento nascosta
- nessun evento salvato

RISULTATO:
OK

---

5. Create entity completo

Input:

crea entità Command Final Entity 2

Esito:

- riepilogo command mostrato
- entity creata tramite insert_entity
- feedback Entità creata
- ritorno Home automatico
- nessun evento salvato

RISULTATO:
OK

---

6. Elemento già presente

Input:

crea progetto villa

Esito:

- Elemento già presente riconosciuto
- nessun bottone crea
- nessuna duplicazione
- Sintesi evento nascosta
- nessun evento salvato

RISULTATO:
OK

---

7. Guida modifica evento

Input:

modifica evento

Esito:

- guida mostrata
- step leggibili
- CTA Vai agli eventi funzionante
- nessuna modifica automatica
- nessun evento salvato

RISULTATO:
OK

---

8. Evento ordinario non regressivo

Input:

30 euro spesa villa citrignano

Esito:

- flow evento ordinario preservato
- Sintesi evento mostrata
- Dati evento mostrati
- Conferma evento funzionante
- feedback evento corretto
- ritorno Home automatico

RISULTATO:
OK

---

9. Edit evento non regressivo

Esito:

- update_event eseguito se modifica reale
- no-op edit preservato se nessuna modifica
- ritorno Lista eventi coerente
- Sintesi evento ancora funzionante in edit flow

RISULTATO:
OK

FORMATO AMOUNT ALLINEATO IN PREVIEW

dato interno numerico corretto
visualizzazione localizzata in preview

Esempio:

dato interno:
1500.5

preview:
1.500,50 €

Nota:

questa localizzazione resta visuale
e non modifica il valore persistito.

------------------------------------------------
FORMATO DURATA ALLINEATO IN PREVIEW
------------------------------------------------

Dato interno:

amount = totale minuti
unit = minuti

Visualizzazione:

forma umana calcolata in preview

Esempio:

dato interno:
150 minuti

preview:
2 ore 30 minuti

hint:
Normalizzato: 150 minuti

raw_input:
2h30 rendering

Nota:

la visualizzazione umana non modifica il dato interno.
Il dato persistito resta amount = 150, unit = minuti.

PROPRIETÀ DEL SISTEMA

✔ deterministico localmente
✔ funzionante lato utente
✔ coerente con DB nei dati principali
✔ usa ui_state.parsed come fonte strutturata
✔ usa select1.value come fonte runtime type
✔ type persistito dal confirm flow
✔ non modifica DB
✔ usa project_state/entity_state come fonte matching project/entity  
✔ preview hint matching allineati a isAmbiguous  
✔ preview highlight alimentato da matches  
✔ confirm guard coerente con ambiguità non risolta
✔ suggestion create opzionale e non bloccante
✔ project/entity mancanti non bloccano conferma
✔ project/entity ambigui bloccano conferma
✔ evento non salvato automaticamente dopo creazione project/entity
✔ Sintesi strutturata confermata su mobile
✔ card Da verificare separata
✔ notice associazioni mancanti confermato
✔ Dati evento compatti separati dalla Sintesi
✔ feedback mobile temporaneo separato dalla preview
✔ navigation dock separata dalla preview

MA:

✔ allineato visualmente ai dati normalizzati principali

⚠ non allineato al modello ideale di view pura
⚠ accoppiamento alto
⚠ difficile evoluzione
⚠ ancora non completamente separato architetturalmente
⚠ non ancora pronto per output/KPI
⚠ type base non sufficiente da solo per report avanzati
✔ container suggestion rifinito a livello mobile base
⚠ Cambia / Scegli ancora non cliccabili
⚠ suggestion create vs edit consistency da verificare
⚠ project creation override con match generico non implementato
⚠ suggestion create non ancora separata in modello dedicato

STATO ATTUALE

✔ preview funzionante
✔ UX utilizzabile
✔ preview alimentata da ui_state.parsed
✔ save flow non dipende dalla preview
✔ DB coerente con dati normalizzati
✔ amount/unit/date visualizzati coerentemente
✔ formattazione italiana amount implementata
✔ label cleaning aggiornato
✔ date separate correttamente dalla descrizione
✔ highlight unit-safe
✔ duration normalization visualizzata correttamente
✔ durata certa mostrata in forma umana
✔ hint normalizzato introdotto
✔ hint durata ambigua introdotto
✔ Type Classification Base completata
✔ select1 allineato a ui_state.parsed.unit
✔ type rappresentato tramite select1.value
✔ type persistito da insert/update tramite confirm flow
✔ Match Engine Unification First Controlled Level completato  
✔ preview legge project_state/entity_state per matching  
✔ hint ambiguità matching allineati a isAmbiguous  
✔ hint match più specifici introdotti  
✔ highlight project/entity alimentato da matches  
✔ detection locale preview non più fonte decisionale matching  
✔ bug €500 label preview risolto  
✔ Project / Entity Create Suggestion First Controlled Level completato
✔ create_suggestion_state collegato alla UX preview/suggestion
✔ container suggestion inline implementato
✔ hint/suggestion no-match project/entity implementati
✔ ignore globale suggestion implementato
✔ entity autofill controlled minimal implementato
✔ flow combinato project + entity validato
✔ preview resta non fonte di salvataggio evento
✔ UX Mobile Coherence Pass completato
✔ Sintesi strutturata confermata
✔ card Da verificare separata
✔ notice associazioni mancanti confermato
✔ Dati evento compatti separati dalla Sintesi
✔ feedback mobile separato dalla preview
✔ navigation dock separata dalla preview
✔ font-size 16px mobile Safari validato per input/select

⚠ preview ancora ibrida
✔ hint matching project/entity state-driven  
✔ matching project/entity unificato a primo livello controllato  
⚠ hint duration/type ancora embedded nella preview  
⚠ match engine avanzato separato non implementato  
⚠ architettura non separata
⚠ preview non ancora view pura
✔ container suggestion UI rifinita a livello mobile base
⚠ Cambia / Scegli ancora non cliccabili
⚠ suggestion create vs edit consistency da verificare
⚠ project creation override con match generico non implementato
⚠ command intent non implementato

OBIETTIVO FUTURO IMMEDIATO

Nessun refactor preview attivo immediato.

Preview Alignment Base è completato.
Duration Normalization Base è completata.
Type Classification Base è completata.
Match Engine Unification First Controlled Level è completato.
Project / Entity Create Suggestion First Controlled Level è completato.
UX Mobile Coherence Pass è completato.
Command Intent — Create Project / Entity è completato.

La parte critica di allineamento preview/hint/highlight per project/entity
è stata risolta a primo livello.

La parte suggestion create funziona
e il container suggestion è stato rifinito a livello mobile base.

Il Command Intent è stato separato dalla Sintesi evento:

- i comandi puri non vengono renderizzati come eventi
- container_command_intent sostituisce Sintesi / Dati evento quando l’input è comando puro
- command_intent_state resta helper separato
- command_intent_state non è fonte preview
- command_intent_state non è fonte salvabile per events
- insert_project / insert_entity restano azioni controllate
- button_input_confirm resta dedicato agli eventi ordinari

La Sintesi è ora coerente con il sistema mobile,
ma resta un layer ibrido e non una view pura.

Durante il nodo Command Intent è emerso un residuo importante:

“Da verificare” resta interno alla Sintesi
e non è un blocco autonomo spostabile sotto la CTA.

Questo conferma che la preview contiene ancora:

- rappresentazione evento
- hint
- warning informativi
- label cleaning
- supporto UX
- logiche visuali embedded

Nodi futuri candidati:

1. INPUT RENDERING STABILITY / CONTAINER STRUCTURE

Obiettivo:

- ridurre rendering progressivo / flash su input evento normale
- stabilizzare comparsa di Sintesi / hint / suggestion / Dati evento
- valutare separazione container preview / hint / dati evento
- valutare eventuale stato unico input_analysis_ready

Vincoli:

- non modificare parser
- non modificare matching
- non modificare DB
- non rompere command intent
- non rompere suggestion container
- non rompere edit flow

---

2. PREVIEW MODEL / HINT STATE CONSOLIDATION

Obiettivo:

- consolidare hint/warning ancora embedded nella Sintesi
- valutare se “Da verificare” debba diventare blocco autonomo
- distinguere hint bloccanti, warning informativi e suggestion visuali
- rendere la preview più vicina a una view pura
- evitare divergenze tra ciò che l’utente legge e ciò che viene salvato

---

3. INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER

Obiettivo:

- valutare un layer unico di analisi interrogabile dalle UI
- coordinare parse_input_controlled, project_state, entity_state, create_suggestion_state, command_intent_state
- ridurre rami ibridi e fonti parallele
- evitare ricalcoli o logiche concorrenti

Vincolo:

non introdurre refactor globale senza nodo dedicato.

---

4. CAMBIA / SCEGLI ACTIONS

Obiettivo:

- trasformare le micro-azioni visive nella Sintesi in azioni reali
- eventuale focus / scroll / highlight sui campi Dati evento
- mantenere select_project / select_entity come decisione finale utente

---

5. HINT / AMBIGUITÀ ADVANCED

Obiettivo:

- migliorare gerarchia tra ambiguità, warning e suggerimenti
- evitare messaggi concorrenti
- mantenere il sistema leggibile su mobile

---

6. SUGGESTION CREATE VS EDIT CONSISTENCY

Obiettivo:

- verificare differenze suggestion tra create flow e edit flow
- evitare divergenze tra nuovo evento e modifica evento
- non modificare create_suggestion_state senza casi riproducibili

---

7. PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE

Obiettivo:

- valutare creazione progetto anche quando esiste un match generico
- esempio: input “villa” con match Villa e progetti più specifici
- permettere eventuale scelta esplicita utente
- evitare duplicati e creazioni aggressive

---

8. TYPE / ECONOMIC DIRECTION ADVANCED

Obiettivo:

- valutare direction field
- valutare amount firmato
- valutare logiche avanzate Spesa / Incasso
- non anticipare KPI o dashboard

---

9. MOBILE POLISH FINALE / ICON SYSTEM

Obiettivo:

- standardizzare icone
- rifinire spaziature e gerarchie visuali
- mantenere font-size 16px su input/select per stabilità Safari iOS

Priorità:

non aprire ulteriori nodi preview generici
se non emerge un problema reale.

I candidati più coerenti post Command Intent sono:

1. INPUT RENDERING STABILITY / CONTAINER STRUCTURE
2. PREVIEW MODEL / HINT STATE CONSOLIDATION
3. INPUT ANALYSIS MODEL / SINGLE INTERPRETATION LAYER

Vincolo:

non modificare logica, parser, matching, DB o save flow
senza nodo dedicato.

------------------------------------------------
OBIETTIVO FUTURO NON ATTIVO
------------------------------------------------

Separazione layer:

parsing
normalization
type classification
command intent
label
matching
suggestion
preview

Preview target:

👉 funzione pura di rendering

Input target:

parsed data
type già determinato
selected project/entity
hint state già calcolato
match state già calcolato
suggestion state già calcolato
command intent già calcolato fuori dalla preview

Output target:

rendering leggibile
nessuna logica decisionale
nessuna trasformazione strutturale
nessuna interpretazione command intent
nessuna azione diretta su DB

⚠ NON implementato attualmente

Nota:

questo obiettivo resta non attivo.
Preview Alignment Base ha migliorato la rappresentazione visuale,
ma non ha separato architetturalmente la preview.

Nota:

la preview target futura resta una funzione pura di rendering,
ma questo non è stato implementato.

Anche il suggestion container futuro potrebbe essere separato in un modello dedicato,
ma non è attivo ora.

Anche command_intent_state potrebbe in futuro confluire in un modello unico di input analysis,
ma non è attivo ora.

Il matching project/entity è stato però allineato
sufficientemente da non essere più un blocco preview immediato.

Il Command Intent è stato separato dalla Sintesi evento
sufficientemente da evitare che i comandi puri vengano salvati o rappresentati come eventi.

Restano invece aperti:

- rendering progressivo input evento normale
- “Da verificare” interno alla Sintesi
- preview ancora ibrida
- input analysis model unico non implementato

CHANGELOG

v01 — 2026-04-07

documento basato su runtime reale
descrizione completa preview system
evidenziate duplicazioni e limiti
allineamento con stato attuale sistema

v02 — 2026-04-23

identificazione loop reattivo
evidenziata dipendenza preview dal flusso reattivo
documentata incoerenza tra fonti dati
integrazione con stato reale sistema

v03 — 2026-04-30

aggiornamento fonte parsing da parse_input a parse_input_controlled
introduzione ui_state.parsed come fonte strutturata preview/save
integrazione Normalization Layer Base
documentata normalizzazione amount/unit
documentato che il save flow non dipende più dalla preview
aggiornati limiti preview dopo normalizzazione
apertura nodo consigliato PREVIEW ALIGNMENT BASE

v04 — 2026-04-30

completamento PREVIEW ALIGNMENT BASE
documentata formattazione italiana amount in preview
documentate funzioni formatAmountIT / formatUnitIT
documentato grouping migliaia visuale
documentato euro con due decimali
documentata gestione singolare/plurale unit
documentato label cleaning aggiornato
documentata correzione bug "minuti" → "uti"
documentato separatore data/descrizione
documentato filtro previewStopTokens
documentato highlight unit-safe
confermato che preview non modifica DB/save flow
confermato che preview resta layer ibrido non ancora view pura

v05 — 2026-04-30

completamento ENGINE BASE — DURATION NORMALIZATION
documentata visualizzazione durata normalizzata
documentate funzioni formatDurationHumanIT / formatDurationMinutesIT
documentato hint “Normalizzato: X minuti”
documentato hint durata ambigua
documentato cleaning durate composte
documentata rimozione forme compatte tipo 2h30 dalla label
documentata rimozione residui e/ed dopo cleaning durata
aggiornati previewStopTokens con giorni/settimane/giornata
confermato che preview non modifica DB/save flow
confermato che amount tempo resta salvato in minuti
confermato che raw_input preserva la forma originale
confermato che preview resta layer ibrido non ancora view pura
aggiornato prossimo nodo logico: TYPE CLASSIFICATION BASE

v06 — 2026-05-01

completamento ENGINE BASE — TYPE CLASSIFICATION BASE
documentata relazione preview / select1
chiarito che select1 è componente UI Retool, non query
documentato che select1.value alimenta type visuale
documentato che la preview non salva direttamente type
documentata catena select1.value → button_input_confirm payload.type → events.type
documentato parsed.unit = minuti → select1 Tempo
documentati esempi type: Tempo, Spesa, Incasso, Evento
documentato euro senza direzione chiara → Evento
documentato override manuale utente
documentato che type viene persistito da insert/update
confermato che preview resta layer ibrido non ancora view pura
confermato che preview non modifica DB/save flow
confermato che type base non abilita ancora KPI/output
aggiornato prossimo nodo logico: MATCH ENGINE UNIFICATION

v07 — 2026-05-02

completamento MATCH ENGINE UNIFICATION — FIRST CONTROLLED LEVEL
documentata relazione preview / project_state / entity_state
documentato che la preview legge matches da match state
documentato che hint ambiguità derivano da isAmbiguous
documentato che hint match più specifici derivano da hasMoreSpecificMatches
documentato che highlight project/entity deriva da matches
documentato che detection locale preview non è più fonte decisionale matching
documentato che preview non salva project/entity
documentato salvataggio project_id/entity_id tramite select_project/select_entity
documentato confirm guard da ambiguità non risolta
documentati esempi villa 2 mario, ristrutturazione bagno, mario, villa, alfie mario rossi
documentato fix bug €500 nella label preview
confermato che preview resta layer ibrido non ancora view pura
confermato che hint duration/type restano embedded nella preview
confermato che non esiste ancora preview model unico
confermato che nessun output/KPI è stato anticipato
aggiornato prossimo nodo: da definire in Roadmap

v08 — 2026-05-07

aggiornamento post PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
documentata relazione preview / create_suggestion_state
documentata distinzione preview / hint informativo / suggestion create
documentato container suggestion inline
documentato che create_suggestion_state non salva eventi
documentato che preview non esegue insert_project / insert_entity
documentato che suggestion create richiede conferma utente
documentato che evento non viene salvato automaticamente dopo creazione project/entity
documentato ignore globale suggestion
documentato entity autofill controlled minimal come non-preview e non-matching
documentato no-match generico ignorabile
documentato flow combinato project + entity
documentata ambiguità entity bloccante senza create suggestion
aggiornati limiti: container suggestion UI grezza, command intent non implementato
confermato che preview resta layer ibrido
confermato che nessun output/KPI è stato anticipato
aggiornato prossimo nodo candidato: UX Cleanup Suggestion Container / Mobile oppure Command Intent

v09 — 2026-05-09

aggiornamento post UX MOBILE COHERENCE PASS
documentata Sintesi strutturata mobile confermata
documentata card Da verificare separata dalla Sintesi
documentato notice associazioni mancanti
documentato Dati evento come zona decisionale separata
documentato che Cambia / Scegli restano indicatori visivi non cliccabili
documentato che feedback mobile non è preview
documentato che feedback_summary non è fonte preview
documentato che Navigation dock non è preview
documentata Dashboard in nav come voce disabilitata non collegata alla preview
documentato che container suggestion è rifinito a livello mobile base
documentato vincolo mobile Safari font-size 16px su input/select
documentato che il fix Safari non modifica la logica preview
aggiornati limiti futuri:
- Cambia / Scegli Actions
- Hint / Ambiguità Advanced
- Suggestion Create vs Edit Consistency
- Project Create Suggestion — Match Present / User Override
- Mobile Polish Finale / Icon System
confermato che preview resta layer ibrido
confermato che nessun output/KPI è stato anticipato
confermato DB invariato
confermato parser invariato
confermato matching invariato
confermato create_suggestion_state invariato
confermato save flow invariato lato preview

v10 — 2026-05-13

- integrazione Command Intent — Create Project / Entity
- documentato rapporto tra preview e command_intent_state
- documentato container_command_intent come layer separato dalla Sintesi
- documentato che i comandi puri non vengono renderizzati come eventi
- documentato che Sintesi evento e Dati evento vengono nascosti per command intent
- documentato comando generico “crea”
- documentato create project incompleto
- documentato create project completo
- documentato create entity incompleto
- documentato create entity completo
- documentato elemento già presente
- documentata guida non operativa “modifica evento”
- documentato che command intent non salva eventi
- documentato che insert_project / insert_entity restano azioni controllate
- documentato che create_suggestion_state e command_intent_state non devono competere
- documentato feedback command separato tramite feedback_mode
- aggiunti esempi preview non mostrata per comandi puri
- aggiunti test Command Intent validati
- documentati residui:
  - “Da verificare” ancora interno alla Sintesi
  - preview ancora ibrida
  - hint/warning non ancora separati
  - rendering progressivo input evento normale ancora migliorabile
  - input analysis model unico non implementato
- DB invariato
- parser invariato
- matching invariato
- create_suggestion_state invariato
- save flow evento ordinario invariato
- nessun output/KPI anticipato