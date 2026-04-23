02_LOGOS_Match_Engine_v03

DATA: 2026-04-23

------------------------------------------------
CQD — VALIDAZIONE DOCUMENTO
------------------------------------------------

C (Completezza): 10/10  
- inclusa logica reale aggiornata  
- coperti project + entity + hint + auto-select  
- allineato a runtime reale  

Q (Qualità): 7.5/10  
- logica definita ma non unificata  
- presenza di più sistemi di matching  
- incoerenza tra runtime e documentazione   

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
→ sistemi di matching paralleli  
→ calcolo matches (multipli)  
→ suggestion / select / preview  
→ auto-select (solo in select layer)   

------------------------------------------------
NORMALIZZAZIONE
------------------------------------------------

Gestita implicitamente e in modo NON uniforme nei diversi sistemi di matching.

Non esiste un layer esplicito controllabile a livello documentale.

---

Obiettivo:

consentire confronto testuale coerente tra input e dataset

------------------------------------------------
PROJECT MATCH (ATTUALE)
------------------------------------------------

⚠ esistono più logiche:

- matching deterministico (select)
- matching ranking (input_raw)
- matching detected (preview)

→ non unificate

COMPORTAMENTO REALE:

matching basato su confronto testuale tra input_raw e projects_list

---

OUTPUT:

- project_matches

Fonte:

project_state.data?.matches

---

LOGICA:

match = 1  
→ auto-select  

match > 1  
→ ambiguità  
→ nessuna selezione  

match = 0  
→ nessun suggerimento

------------------------------------------------
ENTITY MATCH (AGGIORNATO — STEP 2)
------------------------------------------------

⚠ logica non unificata con project match e preview

→ possibili incoerenze nei risultati

COMPORTAMENTO REALE:

matching basato su confronto testuale tra input_raw e entities_list

---

OUTPUT:

- entity_matches

Fonte:

entity_state.data?.matches

---

LOGICA:

match = 1  
→ auto-select  

match > 1  
→ ambiguità  
→ nessuna selezione  

match = 0  
→ nessun suggerimento

------------------------------------------------
AUTO-SELECT LOGIC
------------------------------------------------

Auto-select SOLO se:

- match = 1
- campo vuoto

---

NON auto-select se:

- ambiguità
- valore già presente

⚠ auto-select basato solo su uno dei sistemi di matching (select layer)

→ non necessariamente coerente con preview

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

Basato su stato derivato (non unificato).

---

Condizioni:

- entity_matches > 1 → "Seleziona entità"
- project_matches > 1 → "Seleziona progetto"

---

Caratteristiche:

- non invasivo
- derivato da stato reale
- nessuna inferenza
⚠ utilizzo di detection parallela (preview)
⚠ non sempre coerente con select

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
- nessun ranking avanzato unificato
- duplicazione logiche matching
- incoerenza tra select / preview / ranking
- assenza priority match
- nessuna disambiguazione automatica

------------------------------------------------
PROBLEMA STRUTTURALE (CRITICO)
------------------------------------------------

Attualmente esistono 3 sistemi di matching indipendenti:

1. INPUT_RAW MATCHING (ranking)
2. SELECT MATCHING (deterministico)
3. PREVIEW DETECTION (token-based)

---

CONSEGUENZE:

- incoerenza risultati
- duplicazione logica
- difficoltà evoluzione engine

---

STATO:

❗ NON RISOLTO
❗ BLOCCANTE per sviluppo engine

---

TARGET:

unificazione in un unico match engine

------------------------------------------------
EVOLUZIONE FUTURA (NON ATTIVA)
------------------------------------------------

- unificazione sistemi di matching (priorità assoluta)
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

v03 — 2026-04-23  

- identificazione sistemi di matching multipli  
- documentazione incoerenza strutturale  
- introduzione problema unificazione matching  
- allineamento con stato reale sistema  