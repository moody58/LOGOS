# 01_LOGOS_Match_Engine_v01

DATA: 2026-04-01

------------------------------------------------
SCOPO DEL DOCUMENTO
------------------------------------------------

Definire il comportamento del sistema di matching
tra input utente e dati esistenti.

Il documento guida:

- suggerimenti automatici
- selezione project/entity
- riduzione ambiguità

------------------------------------------------
PRINCIPI FONDANTI
------------------------------------------------

1. SUGGERIRE ≠ DECIDERE

Il sistema suggerisce, non impone.

---

2. MATCH SOLO SE AFFIDABILE

Auto-selezione solo con certezza.

---

3. NO ASSUNZIONI

Il sistema non deve inferire dati non espliciti.

---

4. UTENTE IN CONTROLLO

La selezione finale è sempre manuale.

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
PIPELINE MATCH
------------------------------------------------

input_raw
→ normalizzazione
→ parsing label
→ matching
→ suggerimento / auto-select

------------------------------------------------
NORMALIZZAZIONE
------------------------------------------------

Operazioni:

- lowercase
- trim
- compressione spazi
- rimozione caratteri speciali

---

Obiettivo:

uniformare il testo per confronto

------------------------------------------------
PROJECT MATCH
------------------------------------------------

STRATEGIA:

1. split nome progetto in parole

2. filtro parole:

- lunghezza > 2
- non numeriche

3. confronto:

cleanText.includes(word)

---

OUTPUT:

- 1 match → auto-select
- >1 match → ambiguità
- 0 match → nessun suggerimento

------------------------------------------------
DISAMBIGUAZIONE PROJECT
------------------------------------------------

Se più match:

- ricerca numeri input
- confronto con nome progetto
- priorità match numerico

---

Se ancora ambiguo:

→ nessuna auto-selezione

------------------------------------------------
ENTITY MATCH
------------------------------------------------

STRATEGIA MULTI-LIVELLO:

1. STRONG MATCH

match nome completo

---

2. FULL WORD MATCH

tutte le parole presenti

---

3. PARTIAL MATCH

match parziale

---

OUTPUT:

- 1 match → auto-select
- >1 match → ambiguità
- 0 match → nessun suggerimento

------------------------------------------------
AUTO-SELECT LOGIC
------------------------------------------------

Regola:

auto-select SOLO se:

- match unico
- alta confidenza
- campo vuoto

---

NON auto-select se:

- ambiguità
- valore già presente

------------------------------------------------
GESTIONE AMBIGUITÀ
------------------------------------------------

Se più match:

- mostrare messaggio:

"Più risultati trovati"

- NON selezionare automaticamente

---

Obiettivo:

evitare errori silenziosi

------------------------------------------------
HINT SYSTEM
------------------------------------------------

Visualizzazione:

"Suggerito: PROJECT • ENTITY"

---

Caratteristiche:

- non invasivo
- non bloccante
- informativo

------------------------------------------------
CASI NON SUPPORTATI
------------------------------------------------

- sinonimi
- abbreviazioni complesse
- errori ortografici
- fuzzy matching avanzato

---

Motivo:

evitare inferenze errate

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- matching testuale semplice
- nessuna memoria storica
- nessun ranking avanzato

------------------------------------------------
EVOLUZIONE FUTURA (NON ATTIVA)
------------------------------------------------

- fuzzy matching
- storico selezioni
- ranking intelligente
- suggerimenti adattivi

------------------------------------------------
OBIETTIVO MATCH ENGINE
------------------------------------------------

Ridurre ambiguità senza introdurre errori.

---

NON:

- automatizzare completamente
- interpretare intenzioni utente

------------------------------------------------
CHANGELOG
------------------------------------------------

v01 — 2026-04-01

- Definizione completa matching project/entity
- Introduzione strategia multi-livello
- Regole auto-select definite
- Allineamento con sistema reale