06_LOGOS_Label_Quality_v01

DATA: 2026-04-04

------------------------------------------------
SCOPO
------------------------------------------------

Definire le regole di generazione label (preview)
per garantire:

- coerenza
- leggibilità
- stabilità

SENZA:

- modificare il database
- introdurre semantica
- introdurre AI

------------------------------------------------
POSIZIONE NEL SISTEMA
------------------------------------------------

Layer:

→ sintesi (Retool)

NON coinvolge:

- input_raw
- button_input_confirm
- database

------------------------------------------------
PRINCIPI
------------------------------------------------

1. NON DISTRUTTIVO
- raw_input resta invariato
- nessuna perdita informazione

2. DETERMINISTICO
- nessuna inferenza
- nessuna ambiguità risolta automaticamente

3. USER-CONTROLLED
- il sistema suggerisce
- l’utente decide

------------------------------------------------
PIPELINE LABEL
------------------------------------------------

1. NORMALIZZAZIONE
- lowercase
- trim spazi
- normalizzazione whitespace

2. RIMOZIONE AMOUNT + UNIT
- pattern separati (es: "2 ore")
- pattern invertiti (es: "ore 2")
- pattern attaccati (es: "2h", "30min")

3. STOPWORDS BASE
- di, del, della, ecc.

4. NUMERIC SAFE
- numeri NON rimossi
- preservazione casi tipo:
  - "villa 2"
  - "lotto 3"

5. COMPOUND TOKEN
- unione parola + numero:
  - "villa 2"
  - "fase 1"

6. SORTING
- ordinamento alfabetico
- locale: it
- sensitivity: base

------------------------------------------------
MATCHING UX RULES
------------------------------------------------

Hint attivi SOLO se:

1. input ≥ 5 caratteri
OPPURE
2. input corto MA ambiguo

Ambiguo =

- match multipli
- e match su prefisso

Esempio:

✔ "rma" → mostra ambiguità  
✔ "mar" → non mostra  

------------------------------------------------
RIDUZIONE RIDONDANZA
------------------------------------------------

Se:

- progetto già selezionato
- suggerimento uguale

→ NON mostrare hint

------------------------------------------------
HINT INTELLIGENTI
------------------------------------------------

Durata ambigua:

Condizione:

- unit = ore
- più numeri presenti
- non formato orario

Output:

→ "Verifica durata (es: 2h 30min)"

------------------------------------------------
OUT OF SCOPE
------------------------------------------------

NON incluso:

- correzione typo
- sinonimi
- NLP
- normalizzazione semantica
- modifica DB

------------------------------------------------
RISULTATO
------------------------------------------------

- label coerenti
- riduzione variabilità
- zero regressioni
- UX più pulita