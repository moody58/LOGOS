CHECKPOINT — PROJECT / ENTITY CREATE SUGGESTION FIRST CONTROLLED LEVEL

DATA:
2026-05-07

PROGETTO:
LOGOS

STACK:
- Retool frontend
- Supabase database
- logica client-side JS

NODO:
PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL

STATO:
COMPLETATO E VALIDATO

------------------------------------------------
SCOPO DEL NODO
------------------------------------------------

Introdurre un primo livello controllato di suggerimento e creazione inline
per project ed entity, senza modificare architettura, database o logica di
salvataggio evento.

Il nodo consente all’utente di:

- vedere quando manca un progetto o un’entità
- creare un progetto inline quando esiste una candidate controllata
- creare un’entità inline quando manca una entity
- ignorare i suggerimenti
- salvare eventi anche senza project/entity
- bloccare il salvataggio solo in caso di ambiguità attiva

------------------------------------------------
ALLINEAMENTO STRATEGICO — LOGOS CORE MODULARE
------------------------------------------------

Durante la chiusura del nodo è stata riconfermata la direzione strutturale
originaria del progetto LOGOS.

LOGOS mantiene l’obiettivo di essere un sistema espandibile a blocchi,
fondato su un cuore centrale stabile:

INPUT
→ interpretazione controllata
→ project / entity / type / amount / date
→ evento normalizzato
→ ledger eventi
→ viste / moduli / dashboard futuri

Il nodo PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
rafforza questa direzione perché consolida due strutture trasversali:

- project
- entity

Queste strutture non appartengono a un singolo caso d’uso,
ma possono supportare istanze future diverse, ad esempio:

- ASPRI
- ADEXIMA
- MaurizioLab
- uso personale
- lavoro
- ristrutturazioni
- clienti / fornitori / attività

Decisione consolidata:

LOGOS resta focalizzato sul Core Event System.

Le istanze ASPRI / ADEXIMA / MaurizioLab non devono essere anticipate
come moduli separati in questa fase.

Saranno derivate future del core, non sostituti del core.

Regola anti-deriva:

Non aprire nodi verticali specifici come:

- dashboard ASPRI
- CRM ADEXIMA
- gestione MaurizioLab
- moduli clienti avanzati
- moduli animali / allevamento
- moduli fatture / preventivi

prima che il Core Event System sia sufficientemente stabile.

Sequenza corretta futura:

1. consolidare cuore eventi
2. consolidare gestione project/entity
3. introdurre command intent guidato
4. rifinire UX mobile
5. solo dopo aprire viste, istanze o moduli verticali

Conclusione:

Il lavoro svolto resta coerente con l’idea originale di LOGOS
come sistema modulare a blocchi, ma lo sviluppo corrente resta vincolato
al consolidamento del core.

------------------------------------------------
PRINCIPI CONSOLIDATI
------------------------------------------------

1. select = decisione utente

Le select sono sempre la decisione finale dell’utente.

Valgono anche se il valore selezionato non è presente nel raw_input.

2. raw_input = testo sorgente

Il raw_input resta invariato e non viene modificato da creazioni inline,
select manuali o suggestion.

3. match = suggerimento

Il match engine suggerisce, ma non decide in modo definitivo.

4. project/entity mancanti ≠ blocco

Un evento può essere salvato anche con:

- project_id = null
- entity_id = null

5. project/entity ambigui = blocco

Se project o entity risultano ambigui, Conferma resta disabilitata
finché l’utente non risolve manualmente tramite select.

6. suggestion ignorata ≠ blocco

Ignorare una suggestion nasconde il micro-flow di creazione, ma non impedisce
il salvataggio evento.

7. una sola creazione guidata alla volta

Non è consentito aprire contemporaneamente creazione project e creazione entity.

------------------------------------------------
COMPONENTI / QUERY INTRODOTTI
------------------------------------------------

Nuove variabili Retool:

- project_create_inline_open
- project_create_suggestion_dismissed
- entity_create_inline_open
- entity_create_suggestion_dismissed

Nuove query/API:

- insert_project
- insert_entity

Nuovo stato JS:

- create_suggestion_state

Nuovi componenti UI:

- container suggestion inline
- input_new_project_name
- input_new_entity_name
- btn_open_project_create
- btn_open_entity_create
- btn_create_project_inline
- btn_create_entity_inline
- bottone Ignora globale
- bottoni Annulla contestuali per micro-editor project/entity

------------------------------------------------
PROJECT CREATE FLOW
------------------------------------------------

Flusso validato:

1. input utente con progetto base riconosciuto + possibile estensione
2. create_suggestion_state propone candidate project
3. utente apre micro-editor project
4. input_new_project_name precompilato
5. insert_project crea record in projects
6. projects_list viene aggiornata
7. select_project viene valorizzata con nuovo progetto
8. suggestion project viene chiusa/dismissed
9. evento NON viene salvato automaticamente
10. utente mantiene controllo e può confermare manualmente

Validato con:

- Villa Sierri 6
- Villa Sierri 7
- Villa Sierri 15

------------------------------------------------
ENTITY CREATE FLOW
------------------------------------------------

Flusso validato:

1. input utente con entity mancante
2. create_suggestion_state mostra “Nessuna entità associata”
3. utente apre micro-editor entity
4. input_new_entity_name compilabile manualmente
5. insert_entity crea record in entities
6. entities_list viene aggiornata
7. select_entity viene valorizzata con nuova entità
8. suggestion entity viene chiusa/dismissed
9. evento NON viene salvato automaticamente
10. utente mantiene controllo e può confermare manualmente

Validato con:

- Tecnico Sierri 4
- Referente Kappa

------------------------------------------------
ENTITY AUTOFILL CONTROLLED MINIMAL
------------------------------------------------

Aggiunto primo autofill controllato per input_new_entity_name.

Regola:

- non crea automaticamente entità
- non seleziona automaticamente entità
- non modifica DB
- non modifica raw_input
- precompila solo input_new_entity_name quando la candidate è sicura

Candidate consentite solo in caso di:

- entity no-match reale
- entity non ambigua
- nessuna entity già selezionata
- testo residuo pulito
- presenza di prefisso entity forte

Prefissi ammessi:

- referente
- tecnico
- cliente
- fornitore
- operaio
- collaboratore
- contatto
- responsabile
- muratore
- idraulico
- elettricista
- geometra
- architetto

Esempio validato:

input:
villa sierri 15 sopralluogo referente kappa

autofill:
Referente Kappa

Caso negativo validato:

input:
acquisto 50 euro materiale nuovo

risultato:
nessun autofill entity

Caso ambiguo validato:

input:
alfie mario rossi

risultato:
Crea entità non visibile
Conferma disabilitata finché l’utente seleziona manualmente una entity

------------------------------------------------
IGNORA GLOBALE
------------------------------------------------

Introdotto un solo bottone Ignora globale nello stato chiuso del container.

Comportamento:

- chiude project_create_inline_open
- chiude entity_create_inline_open
- imposta dismissed su project/entity suggestion
- svuota input_new_project_name
- svuota input_new_entity_name
- non modifica input_raw
- non modifica select
- non blocca Conferma

Validato con:

input:
acquisto 50 euro materiale nuovo

risultato:
container suggestion nascosto
project vuoto
entity vuota
Conferma abilitata

DB validato:
project_id = null
entity_id = null
type = Spesa
amount = 50
unit = euro
status = NEW

------------------------------------------------
ANNULLA MICRO-EDITOR
------------------------------------------------

Annulla project:

- chiude solo il micro-editor project
- ignora la proposta di creazione project
- non cancella il match base già riconosciuto
- non cancella select_project

Regola consolidata:

Annulla creazione progetto = annulla solo la proposta estesa.
Non cancella il match base reale.

Esempio:

input:
villa sierri 13 sopralluogo

dopo Annulla:
suggestion “Villa Sierri 13” chiusa
select_project resta Villa

Annulla entity:

- chiude micro-editor entity
- ignora proposta entity
- svuota input_new_entity_name
- non modifica project
- non modifica raw_input

------------------------------------------------
CASI COMPLESSI VALIDATI
------------------------------------------------

Caso combinato project + entity:

input:
villa sierri 15 sopralluogo referente kappa

sequenza:
1. crea progetto Villa Sierri 15
2. crea entità Referente Kappa
3. conferma evento

DB validato:

raw_input = villa sierri 15 sopralluogo referente kappa
project_id = Villa Sierri 15
entity_id = Referente Kappa
type = Evento
status = NEW

------------------------------------------------
REGRESSIONI VALIDATE
------------------------------------------------

1. Flow normale

input:
mario casa mare 2.2 ore sopralluogo urgente

risultato:
type = Tempo
project = Casa Mare
entity = Mario
amount/unit = 132 minuti
nessuna suggestion create
Conferma abilitata

2. No-match generico

input:
acquisto 50 euro materiale nuovo

risultato:
salvabile senza project/entity
amount = 50
unit = euro
type = Spesa

3. Ambiguità entity

input:
alfie mario rossi

risultato:
warning Più entità trovate
Crea entità non visibile
Conferma disabilitata
dopo selezione manuale entity, Conferma abilitata

4. Edit no-op

Validato:
nessuna regressione sul flusso edit/no-op.

------------------------------------------------
LIMITI NOTI / DA NON RISOLVERE ORA
------------------------------------------------

1. UI grafica ancora da rifinire

Il container suggestion funziona, ma il layout è ancora grezzo.

Da rimandare a micro-cleanup UX dedicato:

- spaziature
- dimensioni container
- allineamento bottoni
- gerarchia visiva
- mobile friendliness
- alleggerimento grafico

2. Dopo Annulla project resta il match base

Comportamento intenzionale e accettato:

- Annulla non cancella select_project se il match base è reale
- l’utente può sempre cambiare select manualmente

Da monitorare solo lato UX.

3. Nessuna creazione simultanea

Scelta intenzionale:

- project ed entity non si creano in parallelo
- una sola creazione guidata alla volta
- riduce rischio di stati incrociati

------------------------------------------------
OSSERVAZIONE EMERSA — COMMAND INTENT FUTURO
------------------------------------------------

Durante la validazione finale è emersa una possibile evoluzione UX:

consentire input testuali di tipo comando, ad esempio:

- crea progetto Aspri
- crea nuovo progetto Casa Ostuni
- crea entità Patrizio
- aggiungi nuova entità Mario Bianchi

Decisione:

NON introdurre questa logica nel nodo corrente.

Motivo:

Il nodo PROJECT / ENTITY CREATE SUGGESTION — FIRST CONTROLLED LEVEL
gestisce suggestion e creazione inline a partire da un input evento.

Le frasi comando rappresentano invece un comportamento distinto:

- non sono eventi operativi ordinari
- non devono essere salvate automaticamente in events
- devono essere interpretate come intenti di sistema
- devono richiedere conferma esplicita prima di scrivere nel DB

Regola da consolidare:

Le frasi “crea progetto…” / “crea entità…” non sono eventi.
Sono comandi di sistema e devono aprire una conferma guidata,
non salvare automaticamente dati.

Nodo futuro candidato:

COMMAND INTENT — CREATE PROJECT / ENTITY

Scope futuro previsto:

- riconoscere frasi comando
- distinguere evento operativo da comando di sistema
- mostrare riepilogo/conferma guidata
- riusare insert_project / insert_entity già esistenti
- evitare duplicati
- non salvare evento se l’input è un comando puro
- mantenere raw_input come testo sorgente
- preservare tracciabilità e controllo utente

Nota UX:

Il placeholder attuale “Scrivi cosa vuoi fare...” può generare aspettativa
di comandi diretti. Per ora, senza introdurre command intent, è preferibile
un placeholder più prudente, ad esempio:

“Scrivi cosa vuoi registrare...”

Il placeholder potrà essere rivalutato quando il nodo COMMAND INTENT sarà
aperto.

------------------------------------------------
STATO FINALE
------------------------------------------------

Il nodo è completato e validato.

LOGOS ora supporta:

- suggestion project controllata
- creation project inline
- suggestion entity controllata
- creation entity inline
- autofill entity minimale controllato
- ignore globale
- blocco solo su ambiguità reale
- salvataggio evento anche incompleto
- selezione manuale come decisione utente finale

Il sistema resta stabile, incrementale e coerente con:

- Preview ≠ parsing
- select = user decision
- insert/update = save
- database passivo
- no architettura nuova
- no semantica avanzata