# 06_LOGOS_View_Preview_System_v01

DATA: 2026-04-07

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

⚠ NON descrive un modello ideale
⚠ descrive lo stato reale attuale

------------------------------------------------
POSIZIONE NEL SISTEMA
------------------------------------------------

Layer:

→ sintesi (Retool)

Collocazione:

input_raw
→ parse_input
→ preview (sintesi)
→ confirm (insert)

------------------------------------------------
RUOLO DELLA PREVIEW
------------------------------------------------

La preview è il punto di visualizzazione dello stato input.

Mostra:

✔ dati parsati
✔ label derivata
✔ stato matching
✔ hint utente

---

ATTENZIONE:

La preview NON è solo view pura.

Attualmente è:

👉 un layer ibrido (view + trasformazione)

------------------------------------------------
INPUT DELLA PREVIEW
------------------------------------------------

Fonti dati utilizzate:

- input_raw.value
- parse_input.value

- select_project.value
- select_entity.value

- projects_list.data
- entities_list.data

- project_state.data.matches
- entity_state.data.matches

- select1.value

------------------------------------------------
OUTPUT DELLA PREVIEW
------------------------------------------------

Stringa UI composta da:

1. labelStyled
2. typeBadge (opzionale)
3. hint (opzionale)

Formato:

[labelStyled]
[typeBadge]
[hint]

Join:

.filter(Boolean).join("\n")

------------------------------------------------
COMPONENTI LOGICI INTERNI
------------------------------------------------

La preview contiene attualmente:

1. VALUE BUILDER

- costruzione amount + unit
- gestione formati:
  - euro → "50 €"
  - ore → "1 ora / 2 ore"
  - minuti

- evidenziazione:
  font-weight:600

---

2. DATE FORMATTER

- converte YYYY-MM-DD → "4 apr"
- mesi localizzati

---

3. LABEL CLEANING (ATTIVO)

Operazioni:

- normalizzazione testo
- separazione simboli (€)
- gestione unit compatte
- rimozione amount + unit
- rimozione date
- compressione spazi

---

4. TOKEN LOGIC

- split parole
- recombine parola + numero
  (es: "villa 2")

- limitazione lunghezza label

---

5. LABEL BUILDING

Struttura:

MAIN:

[data] • [value] • [primary]

SECONDARY:

resto label

Output:

labelFull

---

6. HIGHLIGHT ENGINE

- evidenzia:

  entity → verde (#059669)
  project → blu (#2563eb)

- ordine:

  entity → prima
  project → dopo

- protezione:

  escape regex

---

7. HINT SYSTEM

Basato su:

- entity_matches
- project_matches
- parsed.unit
- select1.value
- contenuto testo (parziale)

---

TIPI DI HINT:

AMBIGUITÀ:

⚠️ Seleziona entità  
⚠️ Seleziona progetto  

ECONOMICO:

ℹ️ Definisci spesa o incasso  

TEMPO:

⏱ Verifica durata  

---

Caratteristiche:

✔ non bloccante  
✔ condizionale  
✔ visivo  

------------------------------------------------
COMPORTAMENTO MATCHING IN PREVIEW
------------------------------------------------

La preview NON esegue matching.

Ma:

✔ utilizza risultati di matching
✔ evidenzia solo selezioni attive
✔ mostra ambiguità tramite hint

---

Regole:

- match = 1 → evidenziazione attiva
- match > 1 → hint ambiguità
- match = 0 → nessuna evidenza

------------------------------------------------
RELAZIONE CON PARSING
------------------------------------------------

Parsing avviene in:

✔ parse_input

MA:

⚠ la preview applica ulteriori trasformazioni

- cleaning
- rimozione pattern
- ricostruzione label

👉 quindi NON è pura rappresentazione

------------------------------------------------
RELAZIONE CON INSERT
------------------------------------------------

Parsing:

✔ coerente tra preview e confirm

Label:

✘ NON persistita

Dati salvati:

- raw_input
- amount
- unit
- event_date
- project_id
- entity_id

---

Relazione:

✔ preview riflette i dati salvati  
✘ ma applica trasformazioni visive aggiuntive  

------------------------------------------------
VINCOLI ATTUALI (REALI)
------------------------------------------------

✔ preview non blocca input  
✔ preview sempre attiva  
✔ preview può essere parzialmente errata  
✔ preview non modifica DB  

---

MA:

✘ contiene logica duplicata  
✘ contiene cleaning  
✘ contiene costruzione label  

------------------------------------------------
LIMITI STRUTTURALI
------------------------------------------------

1. DUPLICAZIONE LOGICA

- label costruita qui
- non esiste layer dedicato runtime

---

2. CLEANING DISTRIBUITO

- parsing + preview

---

3. HINT NON CENTRALIZZATI

- parte derivata da matching
- parte da logica locale

---

4. NON È VIEW PURA

- contiene trasformazioni dati

---

5. DEBUG COMPLESSO

- difficile isolare origine problemi

------------------------------------------------
PROPRIETÀ DEL SISTEMA
------------------------------------------------

✔ deterministico  
✔ funzionante lato utente  
✔ coerente con DB  

---

MA:

⚠ non allineato al modello ideale  
⚠ accoppiamento alto  
⚠ difficile evoluzione  

------------------------------------------------
STATO ATTUALE
------------------------------------------------

✔ sistema stabile  
✔ preview funzionante  
✔ UX utilizzabile  

---

⚠ architettura non separata  
⚠ logiche concentrate nella preview  

------------------------------------------------
OBIETTIVO FUTURO (NON ATTIVO)
------------------------------------------------

Separazione layer:

- parsing
- label
- matching
- preview

---

Preview target:

👉 funzione pura di rendering

---

⚠ NON implementato attualmente

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-07

- documento basato su runtime reale
- descrizione completa preview system
- evidenziate duplicazioni e limiti
- allineamento con stato attuale sistema