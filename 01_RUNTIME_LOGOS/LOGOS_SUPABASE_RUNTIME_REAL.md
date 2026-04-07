# LOGOS_SUPABASE_RUNTIME_REAL_v1_FULL

## DESCRIZIONE

Documento tecnico completo del database reale LOGOS su Supabase.

Obiettivo:

* fotografare lo stato reale del sistema (AS-IS)
* documentare ogni tabella, campo, vincolo e comportamento
* rappresentare fedelmente l’uso attuale lato Retool

Il database funge da **storage layer passivo**, senza logica di business né validazione strutturale.

---

# ARCHITETTURA GENERALE

Database: PostgreSQL (Supabase)
Schema: public

Ruolo:

* persistenza dati
* nessuna validazione applicativa
* nessuna logica lato DB (eccetto RPC minimale)

Pattern architetturale:

INPUT → Retool (JS) → Supabase (storage)

---

# ELENCO TABELLE

CORE:

* events
* projects
* entities

SUPPORT:

* system_logs

---

# TABELLA: events

## STRUTTURA

id (uuid, NOT NULL, default: gen_random_uuid())
created_at (timestamp, NULL, default: now())
event_date (date, NULL)
project_id (uuid, NULL)
entity_id (uuid, NULL)
type (text, NULL)
amount (numeric, NULL)
unit (text, NULL)
reference_id (text, NULL)
source (text, NULL)
payment_method (text, NULL)
notes (text, NULL)
raw_input (text, NULL)
payload (jsonb, NULL, default: {})
status (text, NULL, default: 'NEW')

---

## CONSTRAINT

PRIMARY KEY:

* id

CHECK:

* 2200_17534_1_not_null

ASSENTI:

* foreign key su project_id
* foreign key su entity_id
* unique constraints aggiuntivi

---

## UTILIZZO REALE

Campi popolati:

* raw_input → sempre valorizzato
* amount → valorizzato via parsing regex
* unit → valorizzato solo per "minuti"
* project_id → valorizzato raramente
* entity_id → quasi sempre null
* status → sempre "NEW"

Campi non utilizzati:

* type
* reference_id
* source
* payment_method
* notes

payload:

* sempre {} (vuoto)

---

## COMPORTAMENTO REALE

Parsing:

* amount → primo numero (`match(/\d+/)`)
* unit → rilevata solo per "min"

Limitazioni:

* euro non riconosciuti
* orari interpretati come numeri
* nessuna gestione multi-valore

---

## ESEMPIO DATI REALI

"50 euro vaccinazione Alfie allevamento Aspri"
→ amount: 50
→ unit: null
→ project_id: valorizzato
→ entity_id: null

"50 minuti di prove"
→ amount: 50
→ unit: minuti

"15:35 TEST"
→ amount: 15 (errore semantico)

---

# TABELLA: projects

## STRUTTURA

id (uuid, NOT NULL, default: gen_random_uuid())
name (text, NULL)
parent_project_id (uuid, NULL)
type (text, NULL)
status (text, NULL, default: 'ACTIVE')
created_at (timestamp, NULL, default: now())

---

## CONSTRAINT

PRIMARY KEY:

* id

UNIQUE:

* name

CHECK:

* 2200_17545_1_not_null

ASSENTI:

* foreign key su parent_project_id

---

## CARATTERISTICHE

* name univoco → base per matching
* supporto gerarchia tramite parent_project_id (non vincolata)
* campo type non utilizzato
* campo status non utilizzato lato Retool

---

## UTILIZZO REALE

* utilizzato per matching testuale
* utilizzato per popolare select_project
* nessuna gestione gerarchia
* nessun filtro per status

---

# TABELLA: entities

## STRUTTURA

id (uuid, NOT NULL, default: gen_random_uuid())
type (text, NULL)
name (text, NULL)
parent_entity_id (uuid, NULL)
status (text, NULL)
metadata (jsonb, NULL, default: {})
created_at (timestamp, NULL, default: now())
updated_at (timestamp, NULL, default: now())

---

## CONSTRAINT

PRIMARY KEY:

* id

CHECK:

* 2200_17557_1_not_null

ASSENTI:

* unique su name
* foreign key su parent_entity_id

---

## CARATTERISTICHE

* struttura simile a projects
* nessun vincolo di unicità → possibili duplicati
* metadata disponibile per estensioni (non usato)
* supporto aggiornamento (updated_at)

---

## UTILIZZO REALE

* caricata in UI (entities_list)
* matching tentato via JS
* entity_id quasi sempre null

---

# TABELLA: system_logs

## STRUTTURA

id (uuid, NOT NULL, default: gen_random_uuid())
event_id (uuid, NULL)
action (text, NULL)
timestamp (timestamp, NULL, default: now())
note (text, NULL)

---

## CONSTRAINT

PRIMARY KEY:

* id

ASSENTI:

* foreign key su event_id

---

## CARATTERISTICHE

* struttura per logging eventi
* supporto audit trail
* non utilizzata nel sistema attuale

---

## UTILIZZO REALE

* nessun inserimento rilevato
* nessuna integrazione con Retool

---

# RPC: update_event_status

## PARAMETRI

event_id (text)
new_status (text)

---

## IMPLEMENTAZIONE

begin
update events
set status = new_status
where id = event_id::uuid;
end;

---

## CARATTERISTICHE

* nessuna validazione input
* nessun controllo stato precedente
* nessun ritorno
* nessun logging

---

# COMPORTAMENTO GLOBALE SISTEMA

Flusso reale:

input testo
→ parsing minimo (numero)
→ matching parziale
→ inserimento evento
→ status NEW
→ processing manuale

---

# STATO SISTEMA

events:

* attivo
* utilizzato
* parzialmente valorizzato

projects:

* attivo
* utilizzato per matching

entities:

* strutturato ma poco utilizzato

system_logs:

* presente ma inattivo

---

# CONCLUSIONI

Il database LOGOS:

* è strutturalmente solido
* è progettato per scalabilità
* non impone vincoli rigidi
* delega tutta la logica a Retool

Stato attuale:

* sistema funzionante
* parsing minimale
* matching parziale
* grande capacità inutilizzata

---

# FINE DOCUMENTO
