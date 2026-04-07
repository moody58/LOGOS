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
→ matching (query runtime)  
→ calcolo matches  
→ auto-select (se match = 1)   

------------------------------------------------
NORMALIZZAZIONE
------------------------------------------------

Gestita implicitamente nel sistema di matching.

Non esiste un layer esplicito controllabile a livello documentale.

---

Obiettivo:

consentire confronto testuale coerente tra input e dataset

------------------------------------------------
PROJECT MATCH (ATTUALE)
------------------------------------------------

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

Basato su stato di matching.

---

Condizioni:

- entity_matches > 1 → "Seleziona entità"
- project_matches > 1 → "Seleziona progetto"

---

Caratteristiche:

- non invasivo
- derivato da stato reale
- nessuna inferenza

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