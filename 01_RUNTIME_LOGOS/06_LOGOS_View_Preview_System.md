# 06_LOGOS_View_Preview_System_v03

DATA: 2026-04-30

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
→ preview (sintesi)
→ confirm (insert/update)

---

La preview si colloca dopo il parsing controllato
e legge i dati strutturati principalmente da:

ui_state.parsed

---

Nota:

Il save flow non dipende più da parsing interno alla preview
né da parsing duplicato nel bottone confirm.

------------------------------------------------
RUOLO DELLA PREVIEW
------------------------------------------------

La preview è il punto di visualizzazione dello stato input.

Mostra:

✔ dati parsati  
✔ dati normalizzati base  
✔ label derivata  
✔ stato matching  
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

Ma:

⚠ la preview contiene ancora trasformazioni proprie  
⚠ la preview non è ancora pienamente allineata alla normalizzazione base  
⚠ la preview non è ancora un layer read-only puro  

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
- project_state.data?.matches
- entity_state.data?.matches
- select1.value

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
matching state
select values
local label logic
local hint logic

Conseguenza:

✔ dati principali coerenti con save flow
⚠ preview ancora dipendente da più fonti
⚠ possibile incoerenza visuale
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
label
eventuale data
eventuale project/entity
eventuale hint

Nota:

Il dato interno può essere corretto anche quando la visualizzazione non è ancora nel formato desiderato.

Esempio:

Dato interno:

amount: 1500.5
unit: euro

Possibile preview attuale:

1500.5 €

Preview desiderata futura:

1.500,50 €
COMPONENTI LOGICI INTERNI

La preview contiene attualmente:

VALUE BUILDER
costruzione amount + unit
gestione formati:
euro
ore
minuti
evidenziazione visuale

⚠ non ancora pienamente allineato alla formattazione italiana amount

DATE FORMATTER
converte YYYY-MM-DD → formato breve leggibile
mesi localizzati
LABEL CLEANING (ATTIVO)

Operazioni:

normalizzazione testo
separazione simboli (€)
gestione unit compatte
rimozione amount + unit
rimozione date
compressione spazi

⚠ alcune logiche possono non essere allineate al parser aggiornato

TOKEN LOGIC
split parole
recombine parola + numero
(es: "villa 2")
limitazione lunghezza label
LABEL BUILDING

Struttura:

MAIN:

[data] • [value] • [primary]

SECONDARY:

resto label

Output:

labelFull

HIGHLIGHT ENGINE

evidenzia:

entity → verde (#059669)
project → blu (#2563eb)

ordine:

entity → prima
project → dopo

protezione:

escape regex

HINT SYSTEM

Basato su:

entity_matches
project_matches
parsed.unit
select1.value
contenuto testo
condizioni locali

TIPI DI HINT:

AMBIGUITÀ:

⚠️ Seleziona entità
⚠️ Seleziona progetto

ECONOMICO:

ℹ️ Definisci spesa o incasso

TEMPO:

⏱ Verifica durata

Caratteristiche:

✔ non bloccante
✔ condizionale
✔ visivo

⚠ non basato su stato unificato completo
⚠ utilizza logiche parallele
⚠ possibile incoerenza con select
⚠ logiche duplicate rispetto ad altri layer

COMPORTAMENTO MATCHING IN PREVIEW

La preview NON dovrebbe essere fonte primaria di matching.

Attualmente:

✔ utilizza risultati di matching
✔ evidenzia selezioni attive
✔ mostra ambiguità tramite hint

Ma:

⚠ utilizza risultati da sistemi multipli non unificati
⚠ può mostrare hint non perfettamente coerenti con select
⚠ dipende da project_state/entity_state e logiche locali

Regole generali:

match = 1 → evidenziazione attiva
match > 1 → hint ambiguità
match = 0 → nessuna evidenza

Integrazione ancora problematica:

matching ranking / input_raw
matching select / deterministico
detection locale preview

→ possibile divergenza risultati

RELAZIONE CON PARSING

Parsing strutturato avviene ora in:

✔ parse_input_controlled

e viene trasferito in:

✔ ui_state.parsed

La preview legge:

ui_state.parsed.amount
ui_state.parsed.unit
ui_state.parsed.event_date

Dopo il Normalization Layer Base:

ui_state.parsed contiene:

amount numerico
unit normalizzata
event_date
numeri senza unità esclusi da amount
amount con formato italiano convertito a numero

Esempi dati interni:

1.500,50 euro → amount 1500.5, unit euro
1ora lavoro → amount 1, unit ore
villa 2 mario → amount null, unit null

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

RELAZIONE CON NORMALIZATION LAYER BASE

Il Normalization Layer Base ha consolidato:

amount normalization
unit normalization
numeri senza unità ignorati come amount
formato numerico italiano convertito a numero
insert/update basati su ui_state.parsed

La preview deve ora essere allineata a questo nuovo stato.

Punti da verificare nel prossimo nodo:

Formattazione amount
1500.5 → 1.500,50
1.5 → 1,5
Visualizzazione unit
euro → €
ore → ora/ore
minuti → minuto/minuti
Label cleaning coerente con parser aggiornato

Esempi critici:

1.500,50 euro materiale
1ora lavoro
30minuti test
villa 2 mario
Nessuna alterazione del dato salvato

La preview deve restare visuale.

RELAZIONE CON INSERT / UPDATE

Dati salvati:

raw_input
amount
unit
event_date
project_id
entity_id

Fonte dati salvata:

✔ ui_state.parsed

button_input_confirm:

✔ non ricalcola più parsing
✔ non contiene più parsing legacy
✔ costruisce payload da ui_state.parsed
✔ usa insert_event/update_event
✔ aggiorna events_new dopo save completato

Relazione:

✔ preview e DB leggono lo stesso parsed data di base
✔ dati persistiti sono coerenti con parser controllato
✘ label NON persistita
✘ preview applica ancora trasformazioni visive aggiuntive

VINCOLI ATTUALI (REALI)

✔ preview non blocca input
✔ preview sempre attiva quando input presente
✔ preview può essere parzialmente errata
✔ preview non modifica DB
✔ preview non è fonte del salvataggio
✔ preview legge ui_state.parsed per amount/unit/event_date

MA:

✘ contiene logica duplicata
✘ contiene cleaning
✘ contiene costruzione label
✘ contiene hint logic
✘ contiene highlight logic
✘ non è ancora view pura

⚠ dipende da aggiornamenti multipli
⚠ usa fonti non completamente orchestrate
⚠ non completamente allineata al Normalization Layer Base

LIMITI STRUTTURALI
DUPLICAZIONE LOGICA
label costruita qui
non esiste layer label dedicato runtime
CLEANING DISTRIBUITO
parsing controllato
preview
label cleaning
HINT NON CENTRALIZZATI
parte derivata da matching
parte da logica locale
NON È VIEW PURA
contiene trasformazioni dati
contiene label logic
contiene hint logic
DEBUG COMPLESSO
difficile isolare origine problemi visuali
MULTI-SOURCE STATE
parsed
raw_input
select
matching state
liste project/entity
type select

→ assenza di preview model unico

FORMATO AMOUNT NON ALLINEATO
dato interno numerico corretto
visualizzazione non ancora localizzata

Esempio:

1500.5 €

invece di:

1.500,50 €
PROPRIETÀ DEL SISTEMA

✔ deterministico localmente
✔ funzionante lato utente
✔ coerente con DB nei dati principali
✔ usa ui_state.parsed come fonte strutturata
✔ non modifica DB

MA:

⚠ non allineato al modello ideale
⚠ accoppiamento alto
⚠ difficile evoluzione
⚠ ancora non completamente coerente globalmente
⚠ non ancora pronto per output/KPI

STATO ATTUALE

✔ preview funzionante
✔ UX utilizzabile
✔ preview alimentata da ui_state.parsed
✔ save flow non dipende dalla preview
✔ DB coerente con dati normalizzati

⚠ preview ancora ibrida
⚠ formattazione amount da allineare
⚠ label cleaning da verificare dopo normalizzazione
⚠ hint non completamente state-driven
⚠ matching non unificato
⚠ architettura non separata

OBIETTIVO FUTURO IMMEDIATO

PREVIEW ALIGNMENT BASE

Scopo:

allineare la visualizzazione ai dati normalizzati
senza modificare salvataggio, DB, matching o type classification.

Ammesso:

✔ formattazione italiana amount
✔ formattazione unit leggibile
✔ coerenza visuale con ui_state.parsed
✔ controllo label cleaning su casi aggiornati
✔ nessuna modifica DB
✔ nessuna modifica matching
✔ nessuna nuova semantica

Vietato:

✘ duration normalization
✘ 1 ora e 15 minuti
✘ 2h30
✘ giorni/settimane
✘ spesa/incasso
✘ type classification
✘ matching unification
✘ dashboard/KPI
✘ refactor globale preview

OBIETTIVO FUTURO NON ATTIVO

Separazione layer:

parsing
normalization
label
matching
preview

Preview target:

👉 funzione pura di rendering

Input target:

parsed data
selected project/entity
hint state già calcolato

Output target:

rendering leggibile
nessuna logica decisionale
nessuna trasformazione strutturale

⚠ NON implementato attualmente

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