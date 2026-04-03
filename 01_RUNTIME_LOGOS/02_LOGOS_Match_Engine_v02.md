02_LOGOS_Match_Engine_v02

DATA: 2026-04-03

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- inclusa logica reale aggiornata  
- coperti project + entity + hint + auto-select  
- allineato a runtime reale  

Q (Qualità): 9.5/10  
- eliminata ambiguità su partial match  
- definita logica token-based  
- terminologia coerente  

D (Deployabilità): 10/10  
- direttamente utilizzabile come riferimento runtime  
- nessuna dipendenza mancante  

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
→ tokenizzazione  
→ matching  
→ suggerimento / auto-select  

------------------------------------------------
NORMALIZZAZIONE
------------------------------------------------

Operazioni:

- lowercase
- trim
- compressione spazi

---

Obiettivo:

uniformare input e dataset

------------------------------------------------
TOKENIZZAZIONE
------------------------------------------------

Input:

- split su spazi
- filtro parole corte

---

Regola:

- lunghezza minima ≥ 3 (input)
- lunghezza minima ≥ 4 (matching entity)

---

Obiettivo:

considerare solo parole significative

------------------------------------------------
PROJECT MATCH (ATTUALE)
------------------------------------------------

STRATEGIA:

1. STRONG MATCH

- cleanText.includes(nome completo)

---

2. FULL MATCH

- tutte le parole del progetto presenti nei token input
- parole ≥ 3 caratteri
- esclusi numeri

---

3. PARTIAL MATCH

- nome progetto contiene cleanText

---

DISAMBIGUAZIONE:

- utilizzo numeri input
- confronto con nome progetto

---

OUTPUT:

- 1 match → auto-select
- >1 match → ambiguità
- 0 match → nessun suggerimento

------------------------------------------------
ENTITY MATCH (AGGIORNATO — STEP 2)
------------------------------------------------

STRATEGIA MULTI-LIVELLO:

1. STRONG MATCH

- cleanText.includes(nome completo)

---

2. FULL WORD MATCH

- tutte le parole significative presenti
- parole ≥ 4 caratteri

---

3. PARTIAL MATCH (RETROFIT)

PRIMA:
- includes(cleanText) → troppo permissivo

DOPO:
- confronto token significativi

Regola:

- almeno una parola ≥4 caratteri in comune
- match solo su parole rilevanti

---

OUTPUT:

- 1 match → auto-select
- >1 match → ambiguità (non forzata)
- 0 match → nessun suggerimento

------------------------------------------------
AUTO-SELECT LOGIC
------------------------------------------------

Auto-select SOLO se:

- match unico
- alta affidabilità
- campo vuoto

---

NON auto-select se:

- ambiguità
- valore già presente

------------------------------------------------
GESTIONE AMBIGUITÀ
------------------------------------------------

Se più match:

- mostrare hint:
  "Più entità trovate" / "Più progetti trovati"

- NON selezionare automaticamente

---

Obiettivo:

evitare errori silenziosi

------------------------------------------------
HINT SYSTEM
------------------------------------------------

Formato:

"Suggerito: X"

---

Caratteristiche:

- non invasivo
- informativo
- non vincolante

------------------------------------------------
CASI NON SUPPORTATI
------------------------------------------------

- sinonimi
- errori ortografici
- abbreviazioni complesse
- fuzzy matching

---

Motivo:

evitare inferenze errate

------------------------------------------------
LIMITI ATTUALI
------------------------------------------------

- nessuna gerarchia entity
- nessun ranking avanzato
- nessuna memoria storica
- nessuna disambiguazione automatica

------------------------------------------------
EVOLUZIONE FUTURA (NON ATTIVA)
------------------------------------------------

- ranking per frequenza
- storico selezioni
- entity hierarchy
- disambiguazione guidata

------------------------------------------------
OBIETTIVO MATCH ENGINE
------------------------------------------------

Ridurre ambiguità mantenendo controllo utente.

---

NON:

- automatizzare completamente
- interpretare intenzione utente

------------------------------------------------
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