# LOGOS — SUPABASE SYSTEM SNAPSHOT v1.0

## DESCRIZIONE GENERALE

Il backend LOGOS è costruito su Supabase e rappresenta il layer dati e logico del sistema.

Funzioni principali:

- Persistenza eventi generati da input naturale (raw_input)
- Supporto al parsing tramite campi strutturati (amount, unit, project_id, entity_id)
- Gestione stato eventi (NEW, WRITTEN, ERROR)
- Lookup dinamici per progetti ed entità
- Monitoraggio tramite query SQL manuali
- Aggiornamento stato tramite RPC e query dirette

Architettura:

Retool (UI)
→ Supabase Data API
→ Tabelle PostgreSQL
→ Query SQL + RPC

---

## CONFIGURAZIONE API

### API KEYS

- anon (public)
  → usata da Retool
  → accesso diretto Data API

- service_role (secret)
  → bypass RLS
  → non usata lato client

---

## DATA API SETTINGS

- Exposed schemas: public, extensions
- Exposed tables: 4/4
- Exposed functions: 1 (update_event_status)
- Default privileges: ENABLED ⚠️
- Max rows: 1000

---

## DATABASE STRUCTURE

### TABLE: events

Campi:

- id (uuid, PK, default gen_random_uuid())
- created_at (timestamp, default now())
- event_date (date)
- project_id (uuid)
- entity_id (uuid)
- type (text)
- amount (numeric)
- unit (text)
- reference_id (text)
- source (text)
- payment_method (text)
- notes (text)
- raw_input (text)
- payload (jsonb, default {})
- status (text, default 'NEW')

Uso:

→ tabella centrale del sistema

---

### TABLE: projects

Campi:

- id (uuid, PK)
- name (text, UNIQUE)
- parent_project_id (uuid)
- type (text)
- status (text, default 'ACTIVE')
- created_at (timestamp)

---

### TABLE: entities

Campi:

- id (uuid, PK)
- type (text)
- name (text)
- parent_entity_id (uuid)
- status (text)
- metadata (jsonb)
- created_at (timestamp)
- updated_at (timestamp)

---

### TABLE: system_logs

Campi:

- id (uuid, PK)
- event_id (uuid)
- action (text)
- timestamp (timestamp, default now())
- note (text)

---

## RPC FUNCTION

### update_event_status

```sql
begin
  update events
  set status = new_status
  where id = event_id::uuid;
end;

Parametri:

event_id (text)
new_status (text)

Uso:

→ aggiornamento stato evento da Retool

SQL QUERY LAYER (OPERATIVO)

Queste query rappresentano un layer attivo di interazione backend.

NEW EVENTS
SELECT
  id,
  raw_input,
  amount,
  unit,
  created_at
FROM events
WHERE status = 'NEW'
ORDER BY created_at DESC;
SEARCH EVENTS STATUS
SELECT
  id,
  raw_input,
  amount,
  unit,
  created_at
FROM events
WHERE status = 'NEW'
ORDER BY created_at DESC;
SEARCH EVENTS TESTO
SELECT
  id,
  raw_input,
  amount,
  unit,
  status,
  created_at
FROM events
WHERE raw_input ILIKE '%testo%'
ORDER BY created_at DESC;
LOOKUP EVENTS
SELECT
  id,
  raw_input,
  amount,
  unit,
  status,
  created_at
FROM events
ORDER BY created_at DESC;
LOOKUP ENTITIES
SELECT id, name FROM entities;
LOOKUP PROJECTS
SELECT id, name FROM projects;
ASSIGN
UPDATE events
SET
  project_id = '',
  entity_id = ''
WHERE id = '';
ERROR
UPDATE events
SET status = 'ERROR'
WHERE id = '';
WRITTEN
UPDATE events
SET status = 'WRITTEN'
WHERE id = '';
SECURITY STATUS
RLS (Row Level Security)

Stato:

❌ DISABILITATO su:

projects
entities
system_logs

(events probabilmente non incluso nel warning → verificare)

CONSEGUENZE
accesso completo via API
nessuna protezione dati
sistema funzionante ma non sicuro
NOTE ARCHITETTURALI
Il sistema usa Data API diretta (no backend custom)
Retool comunica via anon key
Le query SQL sono usate per debug e operatività
Lo stato eventi è gestito tramite:
RPC (update_event_status)
Query dirette (ERROR, WRITTEN)
RISCHI ATTUALI
RLS disabilitato
Default privileges attivi
API completamente esposta