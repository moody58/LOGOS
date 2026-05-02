# 06_LOGOS_View_Preview_System_v07

DATA: 2026-05-02

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
→ parse_input_controlled
→ ui_state.parsed
→ project_state / entity_state
→ select_project / select_entity
→ select1 / type classification base
→ preview (sintesi)
→ confirm (insert/update)

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

---

Nota:

Il save flow non dipende più da parsing interno alla preview
né da parsing duplicato nel bottone confirm.

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
local label logic
local hint logic

Conseguenza:

✔ dati principali coerenti con save flow
⚠ preview ancora dipendente da più fonti
✔ matching project/entity più coerente con select/confirm
⚠ preview ancora dipendente da più fonti
⚠ possibile incoerenza visuale su hint non matching
⚠ possibile divergenza tra dato interno e formattazione mostrata

OUTPUT DELLA PREVIEW

Stringa UI composta da:

labelStyled
typeBadge (opzionale)
hint (opzionale)

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

COMPONENTI LOGICI INTERNI

La preview contiene attualmente:

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
→ nessuna evidenza obbligatoria
→ conferma non bloccata

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

RELAZIONE CON NORMALIZATION LAYER BASE / DURATION NORMALIZATION / TYPE CLASSIFICATION / MATCH ENGINE

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


MA:

✘ contiene logica duplicata
✘ contiene cleaning
✘ contiene costruzione label
✘ contiene hint logic embedded
✘ contiene highlight logic embedded
✘ non è ancora view pura
✘ type display e hint sono ancora accoppiati alla preview/select

⚠ dipende da aggiornamenti multipli
⚠ usa ancora fonti multiple
✔ allineata visualmente al Normalization Layer Base per amount/unit/date
✔ allineata visualmente alla Duration Normalization Base per ore/minuti
✔ mostra durata normalizzata senza modificare il dato salvato
✔ matching project/entity allineato a primo livello  
✔ hint matching project/entity state-driven  

⚠ non ancora separata come view pura

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
liste project/entity
type select
duration hint locale

→ assenza di preview model unico

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

MA:

✔ allineato visualmente ai dati normalizzati principali

⚠ non allineato al modello ideale di view pura
⚠ accoppiamento alto
⚠ difficile evoluzione
⚠ ancora non completamente separato architetturalmente
⚠ non ancora pronto per output/KPI
⚠ type base non sufficiente da solo per report avanzati

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

⚠ preview ancora ibrida
✔ hint matching project/entity state-driven  
✔ matching project/entity unificato a primo livello controllato  
⚠ hint duration/type ancora embedded nella preview  
⚠ match engine avanzato separato non implementato  
⚠ architettura non separata
⚠ preview non ancora view pura

OBIETTIVO FUTURO IMMEDIATO

Nessun ulteriore nodo preview attivo immediato.

Match Engine Unification First Controlled Level è completato.

La parte critica di allineamento preview/hint/highlight per project/entity
è stata risolta a primo livello.

Restano futuri, ma non immediati:

- PREVIEW MODEL / HINT STATE CONSOLIDATION
- separazione preview come view pura
- estrazione label cleaning in modulo dedicato
- hint duration/type separati da preview
- preview model unico
- type/economic direction advanced

Preview Alignment Base è completato.
Duration Normalization Base è completata.
Type Classification Base è completata.
Match Engine Unification First Controlled Level è completato.

Il prossimo nodo operativo deve essere definito in Roadmap,
preferibilmente tra micro-nodi UX/helper o cleanup.

OBIETTIVO FUTURO NON ATTIVO

Separazione layer:

parsing
normalization
type classification
label
matching
preview

Preview target:

👉 funzione pura di rendering

Input target:

parsed data
type già determinato
selected project/entity
hint state già calcolato
match state già calcolato

Output target:

rendering leggibile
nessuna logica decisionale
nessuna trasformazione strutturale

⚠ NON implementato attualmente

Nota:

questo obiettivo resta non attivo.
Preview Alignment Base ha migliorato la rappresentazione visuale,
ma non ha separato architetturalmente la preview.

Nota:

la preview target futura resta una funzione pura di rendering,
ma questo non è stato implementato.

Il matching project/entity è stato però allineato
sufficientemente da non essere più un blocco preview immediato.

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