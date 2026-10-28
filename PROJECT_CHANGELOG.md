# PROJECT_CHANGELOG
Versione: v05

DATA: 2026-10-28

------------------------------------------------
SCOPO
------------------------------------------------

Registro delle modifiche principali del progetto LOGOS.

---

Questo documento traccia:

- evoluzione reale del sistema
- decisioni strutturali
- milestone operative

---

Git mantiene lo storico tecnico.

Questo file mantiene lo storico strategico.

------------------------------------------------
VERSIONING GUIDELINES
------------------------------------------------

### Added
nuovi elementi introdotti

### Changed
modifiche strutturali

### Fixed
correzioni e riallineamenti

### Removed
elementi eliminati

------------------------------------------------
2026-10-27 — CORE UNIVERSALE / HARDENING E CONSOLIDAMENTO DOCUMENTALE
------------------------------------------------

### Changed

- Modello A C1/C2 approvato: Core comune versionato per ASPRI/ADEXIMA,
  installazioni indipendenti con database e risorse propri; nessuna multi-tenancy.
- Baseline architetturale v1.0 consolidata; contratto dati nodo 03 completato
  come candidato, non integralmente approvato o implementato.
- Nodo 07 lifecycle PASS: guardie database sulle transizioni e sui terminali.
- Nodo 08 RLS/ACL PASS tecnico nel perimetro autorizzato; mantenuti i limiti
  della connessione Retool server-side privilegiata e del modello di fiducia.

### Fixed

- Nodo 09 PASS documentale: pubblicati cinque documenti tecnici al commit
  c2788ef4adf9c1121e985d0bbfca53c388fda82c (Lifecycle v14, Schema v12,
  Retool Architecture v24, Supabase Runtime v7, Retool Runtime v22).
  Il nodo 09 non ha effettuato nuove modifiche o verifiche live applicative.

### Limiti

- Logos resta in Draft; nessuna release definitiva o installazione verticale.
- Replica del Core completo non qualificata; ultimo collaudo post-hardening
  READ-ONLY, scritture non nuovamente collaudate dopo l'ultimo delta.
- R01 mantiene una dipendenza Python divergente; qualifica isolata R02 non
  equivale ad adozione del catalogo né al ripristino della corsia nativa.

------------------------------------------------
2026-10-16 — BRAND IDENTITY & TYPOGRAPHY / CONSOLIDAMENTO DOCUMENTALE
------------------------------------------------

### Added

- Registrata la pubblicazione iniziale dei sei file: Visual Identity v1.0, Typography System v1.1 e quattro PNG, nella baseline `f4e02738dd43668c7ce6e16821e81c02846423d6`.
- Consolidate documentalmente Visual Identity v1.1 e Typography System v1.2, senza attribuirle al commit iniziale.
- Aggiornate le fonti canoniche e la Session Boot Matrix del Kernel per i nodi pertinenti a Brand Identity, font e UI.

### Limiti

- Nessuna modifica a palette, artwork, PNG, famiglie tipografiche, Roadmap o Gap Register.
- I due pathname Brand Identity e i marker versionati sono fuori dal perimetro P6 qualificato.

------------------------------------------------
2026-10-14 — PROCEDURA DOCUMENTALE LOGOS P6 INTEGRATA E VERIFICATA
------------------------------------------------

### Added

- Ingresso operativo permanente nel Runtime v1.2: ruoli Work/Codex, attivazione, pacchetti, messaggi rapidi e dipendenze.
- Perimetro documentale qualificato di trenta pathname canonici esistenti, un documento modify_ranges per transazione.

### Changed

- Motore documentale e guardia aggiornati con binding LOGOS e verifiche native indipendenti.
- Runtime, istruzioni universali e AIOS_REFERENCE allineati tramite cicli reali Check, Apply e Verify revisionati.
- Consolidamento pubblicato con commit manuale b0d8614b6c373857406e27ca3f66cfe75d91af9b.

### Fixed

- Distinti stato della procedura, autorizzazione al singolo delta e stato funzionale del prodotto.
- Fonte madre tecnica unica nel Runtime; gli altri documenti mantengono rimandi e risultati di propria competenza.

### Limiti e seguito documentale

- Nessuna modifica a Retool, Supabase, schema DB, parser, matching, preview, payload o save flow nel ciclo P6.
- Nessuna atomicità multi-documento, adozione automatica della baseline o readiness produttiva globale attestata.
- Il 2026-10-15 l'allineamento State/Changelog ha evidenziato che il marker iniziale del modify_ranges deve restare invariato: l'incremento della versione sulla prima riga richiede un percorso distinto o un'estensione qualificata, non attestata dai precedenti cicli riusciti.
- Istruzioni nelle tab ChatGPT LOGOS/AIOS da verificare separatamente; ripristino delle regie successivo al recepimento delle fonti.
- Portabilità documentale verso ADEXIMA da valutare con accesso e binding specifici, senza avviare l'istanza applicativa.

------------------------------------------------
2026-04-02 — REBUILD COMPLETO LOGOS
------------------------------------------------

### Added

- Creazione struttura documentale completa:
  - 00_PROJECT_State_v01
  - 00_PROJECT_System_v01
  - 00_PROJECT_Regia_v01 → v02
  - 00_PROJECT_Roadmap_v01
  - 01_LOGOS_Input_System_v01
  - 02_LOGOS_Match_Engine_v01
  - 03_LOGOS_Event_Lifecycle_v01
  - 04_LOGOS_Retool_Architecture_v01
  - 05_LOGOS_Database_Schema_v01
  - 00_PROJECT_Gap_Register_v01

---

### Changed

- Separazione strutturale:
  - Regia → livello strategico
  - State → stato reale sistema
  - Roadmap → sviluppo operativo

- Rimozione contenuti operativi dalla Regia

- Allineamento architettura ai principi AIOS

---

### Fixed

- Eliminazione deriva metodologica
- Allineamento roadmap con stato reale
- Consolidamento architettura sistema
- Correzione separazione layer (input / processing / data)

---

### Removed

- Documenti ridondanti
- Snapshot incoerenti
- Versioni parallele non allineate

------------------------------------------------
2026-04-01 — AUDIT E RICOSTRUZIONE
------------------------------------------------

### Added

- Audit completo sistema LOGOS
- Identificazione problemi strutturali:
  - input non affidabile
  - parsing incompleto
  - matching debole
  - dati non normalizzati

---

### Changed

- Ridefinizione priorità:
  - input → prima
  - engine → posticipato
  - dashboard → posticipata

---

### Fixed

- Correzione errore strategico:
  - focus su input invece che UX superficiale

---

### Removed

- sviluppo non sequenziale
- interventi non validati

------------------------------------------------
2026-03-31 — SVILUPPO SISTEMA BASE
------------------------------------------------

### Added

- Sistema input libero
- Preview strutturata
- Insert event
- Processing UI (NEW → WRITTEN / ERROR)

---

### Changed

- Introduzione UI state (home / feedback)
- Miglioramento UX processing

---

### Fixed

- Flicker UI
- Dependency cycle
- Auto-select errato

---

### Removed

- Flow conferma doppio (rollback)

------------------------------------------------
TEMPLATE INITIALIZATION
------------------------------------------------

Struttura iniziale progetto generata tramite AIOS template:

- Fondamenta progetto
- Sistema tecnico
- Regia
- State
- System Map
- Protocollo operativo
- Anchor System

------------------------------------------------
NOTE FINALI
------------------------------------------------

Questo changelog riflette:

✔ stato reale sistema  
✔ evoluzione documentale  
✔ decisioni strategiche  

---

Non include:

❌ dettagli tecnici di codice  
❌ modifiche minori  

------------------------------------------------
CHANGELOG
------------------------------------------------

v05 — 2026-10-28

- registrate sinteticamente le milestone del 27 ottobre e i limiti post-hardening
- allineamento governance nodo 10 candidato; nessuna propria Apply/publicazione attestata
- storico precedente preservato integralmente

v04 — 2026-10-16

- registrata la pubblicazione iniziale dei sei file (due documenti originari Visual Identity v1.0 e Typography v1.1, più quattro PNG) nella baseline `f4e02738dd43668c7ce6e16821e81c02846423d6`
- registrato il successivo consolidamento documentale Visual Identity v1.1 e Typography v1.2, distinto dalla pubblicazione iniziale
- preservati identità, palette, artwork, PNG, famiglie tipografiche e criteri approvati; nessuna nuova versione viene attribuita alla pubblicazione iniziale
- pathname Brand Identity e marker versionato fuori dai limiti P6 disponibili

v03 — 2026-10-15

- registrati la milestone P6 verificata il 2026-10-14, il commit pubblicato e i limiti effettivi della procedura
- richiamati gli allineamenti delle istruzioni nelle tab e delle regie ancora da completare
- preservato integralmente lo storico strategico precedente

v02 — 2026-04-02

- Allineamento completo al sistema reale LOGOS
- Inserimento rebuild completo documentale
- Integrazione audit + STP + CQD
- Separazione Regia / State / Roadmap

v01 — Template iniziale