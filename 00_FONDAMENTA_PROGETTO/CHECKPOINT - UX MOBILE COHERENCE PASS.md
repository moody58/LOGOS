CHECKPOINT — UX MOBILE COHERENCE PASS + FEEDBACK / NAVIGATION

DATA:
2026-05-09

NODO:
UX CLEANUP — SUGGESTION CONTAINER / MOBILE
ESTENSIONE OPERATIVA:
UX MOBILE COHERENCE PASS

STATO:
COMPLETATO

------------------------------------------------
SCOPO
------------------------------------------------

Completare la coerenza grafica e funzionale della UX mobile di LOGOS,
estendendo il lavoro già svolto sul flow input e suggestion container anche a:

- Home
- Events list
- Feedback post-salvataggio
- Navigation dock
- Dati evento
- Pulsanti principali
- Cancel contestuale create/edit
- Routing post-save

Obiettivo operativo:

portare il sistema a uno stato visivo mobile dignitoso, coerente e utilizzabile,
senza introdurre nuove logiche engine, dashboard, KPI o moduli verticali.

------------------------------------------------
VINCOLI RISPETTATI
------------------------------------------------

NON modificato:

- DB schema
- parser
- parse_input_controlled
- trigger_parse_debounced
- project_state
- entity_state
- create_suggestion_state
- insert_project
- insert_entity
- logica matching
- type classification
- duration normalization
- confirm guard
- duplicate guard
- WRITTEN / ERROR flow
- struttura Supabase
- logica dashboard / KPI
- command intent

Modifiche funzionali eseguite solo dove necessarie alla UX flow:

- gestione feedback post-save
- routing post insert/update
- disattivazione handler UI duplicato handle_event_success
- cancel contestuale create/edit

------------------------------------------------
RISULTATO RAGGIUNTO
------------------------------------------------

La UX mobile di LOGOS è ora coerente su tutte le aree principali:

1. Home
2. Input / Sintesi
3. Da verificare
4. Suggerimenti associazione
5. Dati evento
6. Events list
7. Feedback
8. Navigation dock

Il sistema ora:

- guida meglio l’utente
- mantiene l’inserimento rapido come centro operativo
- distingue meglio creazione, modifica e verifica eventi
- riduce altezza e ingombri dove possibile
- mantiene feedback breve e non bloccante
- prepara la futura Dashboard senza implementarla
- evita navigazione ridondante o confusa
- mantiene stabilità Retool / Supabase

------------------------------------------------
MODIFICHE COMPLETATE
------------------------------------------------

1. HOME MOBILE

La Home è stata rifinita come schermata principale del sistema.

Struttura consolidata:

- titolo:
  “Cosa vuoi fare?”

- sottotitolo:
  “Eventi, spese, tempi e azioni.”

- input principale:
  placeholder “Scrivi cosa vuoi fare...”
  con icona leggera coerente

- card Esempi:
  resa neutra e coerente con le altre card

- card Azioni rapide:
  migliorata graficamente
  pulsanti outline differenziati per tipo

- card Eventi da verificare:
  accesso diretto alla lista eventi NEW / da verificare

Decisione:

La Home resta predisposta al futuro command intent,
ma il command intent NON è stato implementato.

------------------------------------------------

2. CARD ESEMPI

La card Esempi è stata rifinita.

Prima:

- sfondo grigio percepito come “disabled” o tecnico

Dopo:

- card chiara e coerente con il resto della UI
- titolo con icona:
  “💡 Esempi”
- testo leggibile
- stile meno invasivo

Decisione:

La card Esempi deve guidare l’utente senza sembrare una zona disabilitata.

------------------------------------------------

3. AZIONI RAPIDE

La sezione Azioni rapide è stata riallineata.

Struttura:

- titolo:
  “⚡ Azioni rapide”

- sottotitolo:
  “Scorciatoie guidate per iniziare più facilmente.”

Pulsanti:

- Registra spesa
- Registra incasso
- Registra tempo
- Registra evento

Modifiche:

- pulsanti full-width
- bordi colorati semantici
- hover background definiti
- icone Retool add-on usate al posto delle emoji testuali
- icone rese più leggibili con colori più scuri

Colori consolidati:

Registra spesa:
- border #BFDBFE
- hover #EFF6FF
- icona blu

Registra incasso:
- border #BBF7D0
- hover #F0FDF4
- icona verde

Registra tempo:
- border #DDD6FE
- hover #F5F3FF
- icona viola

Registra evento:
- border #FDBA74
- hover #FFF7ED
- icona arancio

Decisione:

Le Azioni rapide sono per ora elementi UX predisposti.
La logica guidata specifica NON è stata implementata in questo nodo.

------------------------------------------------

4. SINTESI

La Sintesi strutturata del checkpoint precedente è stata mantenuta e integrata nel nuovo stile complessivo.

Confermata struttura:

- stato:
  OK / Verifica / Attenzione

- frase interpretata
- righe dati:
  - Tipo
  - Data
  - Importo
  - Progetto
  - Entità

Confermate micro-azioni visive:

- Tipo → Cambia
- Progetto → Scegli / Cambia
- Entità → Scegli / Cambia

Decisione:

Le micro-azioni “Cambia” / “Scegli” restano per ora solo indicazioni visive.

Da sviluppare in nodo futuro:

- focus campo relativo
- scroll verso Dati evento
- highlight temporaneo select
- apertura dropdown solo se Retool lo consente stabilmente

------------------------------------------------

5. CARD “DA VERIFICARE”

Confermata separazione tra Sintesi e warning/hint.

La Sintesi mostra cosa LOGOS ha interpretato.
La card “Da verificare” mostra cosa l’utente deve controllare.

Esempi validati:

- Definisci spesa o incasso
- Più entità trovate
- Esistono progetti più specifici

Decisione:

La card “Da verificare” resta una separazione base.
La tab “Ambiguità” o un blocco warning più avanzato resta nodo futuro.

------------------------------------------------

6. NOTICE ASSOCIAZIONI MANCANTI

Confermato notice blu nella Sintesi.

Esempi:

- Manca un progetto e un’entità
- Manca un progetto
- Manca un’entità

Testo:

“Puoi selezionare i dati nei campi sotto o usare i suggerimenti.”

Regola:

Il notice non compare in presenza di ambiguità bloccante.

Decisione:

Il notice resta nella Sintesi perché collega correttamente:

- interpretazione
- suggerimenti associazione
- dati evento

------------------------------------------------

7. SUGGERIMENTI ASSOCIAZIONE

Il container suggestion è stato mantenuto e coerentizzato nello stile mobile.

Struttura:

- titolo:
  “💡 Suggerimenti associazione”

- messaggi informativi:
  - Nessun progetto associato
  - Nessuna entità associata

- pulsanti:
  - Crea progetto
  - Crea entità
  - Ignora suggerimenti

Decisioni consolidate:

- Stack verticale su mobile
- pulsanti full-width
- layout stabile su iPhone 12 Pro
- nessuna creazione automatica
- nessun salvataggio automatico dopo creazione project/entity
- select resta decisione finale utente

------------------------------------------------

8. MICRO-EDITOR PROJECT / ENTITY

Confermati micro-editor inline:

Project create:

- input nuovo progetto
- Crea progetto
- Annulla

Entity create:

- input nuova entità
- Crea entità
- Annulla

Validato:

- nessuna sovrapposizione mobile
- warning duplicato leggibile
- pulsanti stabili
- Annulla chiude correttamente il micro-editor

Debito rilevato:

In edit flow può emergere differenza tra suggestion project/entity rispetto al create flow.
Non corretto in questo nodo per evitare di toccare create_suggestion_state.

Da verificare in nodo futuro:

- consistenza suggestion create vs edit
- project create suggestion in presenza di match generico
- override esplicito utente per creare progetto anche con match presente

------------------------------------------------

9. DATI EVENTO

La sezione Dati evento è stata compattata.

Prima:

- label sopra ogni select
- maggiore altezza verticale

Dopo:

- label inline / affiancate alle select
- layout più compatto
- maggiore leggibilità mobile

Struttura consolidata:

- Tipo evento | select
- Progetto | select
- Entità | select

Decisione:

La sezione Dati evento resta il punto reale di decisione utente prima del salvataggio.

Le select NON vengono spostate nella Sintesi.

------------------------------------------------

10. PULSANTI PRINCIPALI

Aggiornati e coerentizzati i pulsanti principali.

Pulsante conferma:

- testo:
  “Conferma evento”
- icona check add-on
- stile primario blu
- hover blu più scuro

Pulsante ritorno / annulla:

- comportamento contestuale
- stile secondario soft
- non rosso
- non blu pieno
- non bianco piatto

Decisione:

Conferma evento resta azione primaria.
Torna alla home / Annulla modifica restano azioni secondarie.

------------------------------------------------

11. CANCEL CONTESTUALE CREATE / EDIT

È stato corretto il comportamento del pulsante cancel.

Prima:

- comportamento non pienamente coerente tra creazione e modifica
- in alcuni casi tornava alla lista eventi anche durante creazione nuovo input

Ora:

- in create/input mode:
  “Torna alla home”
  → svuota input
  → resetta stato
  → torna Home

- in edit mode:
  “Annulla modifica”
  → annulla edit
  → resetta editing_event
  → torna Lista eventi

Implementato:

- testo dinamico basato su edit_mode
- routing contestuale
- reset input_home / input_raw
- reset select_project / select_entity / select1
- reset ui_state.parsed
- reset feedback_text / feedback_project / feedback_summary
- stop debounce
- stop eventuale timer feedback pendente

Decisione:

La logica cancel è ora contestuale ma centralizzata.

------------------------------------------------

12. EVENTS LIST MOBILE

La lista eventi è stata rifinita graficamente.

Modifiche:

- titolo centrato:
  “Eventi da verificare”

- sottotitolo:
  “Controlla, modifica o archivia gli eventi non ancora verificati.”

- barra ricerca:
  più proporzionata
  placeholder:
  “Cerca evento...”
  icona search monotono add-on

- card evento:
  più leggibile
  spaziatura migliorata
  testo principale più chiaro
  metadati meno invasivi

- pulsanti evento:
  OK
  No
  Modifica

Pulsanti lista eventi:

- OK:
  verde
  icona check

- No:
  rosso
  icona X

- Modifica:
  blu
  icona edit/pencil

Decisione:

Il badge NEW nelle card NON è stato implementato.

Motivo:

La schermata mostra già solo eventi da verificare.
Il badge NEW su ogni card sarebbe ridondante.

------------------------------------------------

13. FEEDBACK MOBILE

Il feedback post-salvataggio è stato rifinito e stabilizzato.

Prima:

- feedback troppo rapido
- gestione duplicata tra button_input_confirm e handle_event_success
- ritorno automatico gestito da handler separato
- rischio conflitto UI

Ora:

- feedback visibile
- feedback stabile
- conferma breve
- auto-return consolidato
- riepilogo tabellare compatto

Struttura feedback:

- check verde
- titolo:
  “Evento salvato”
- testo:
  “L’evento è stato registrato correttamente.”
- mini-tabella coerente con Sintesi:
  - Tipo
  - Data
  - Importo
  - Progetto
  - Entità
- raw input riepilogato in basso

Stile:

- container con sfondo verde chiaro
- tabella riepilogo bianca
- testo ad alto contrasto
- verde usato come accento semantico

Colori consolidati:

- background feedback: #F0FDF4
- border feedback: #BBF7D0
- riepilogo interno: #FFFFFF
- border riepilogo: #E5E7EB

Decisione:

Feedback = toast-card temporanea, non pagina finale bloccante.

------------------------------------------------

14. ROUTING POST-SAVE

È stata corretta e consolidata la logica post-salvataggio.

Prima:

- handle_event_success gestiva feedback e ritorno Home
- button_input_confirm gestiva a sua volta feedback
- duplicazione e conflitto tra handler

Ora:

- handle_event_success disabilitato come gestore UI
- insert_event e update_event non usano più success handler UI duplicato
- button_input_confirm gestisce centralmente:
  - feedback
  - feedback_summary
  - refresh events_new
  - reset edit mode
  - routing post-save
  - timer auto-return

Comportamento consolidato:

Nuovo evento:
- Conferma evento
- feedback 1800 ms
- ritorno Home

Modifica evento reale:
- Conferma evento
- feedback 1800 ms
- ritorno Lista eventi

Edit senza modifiche:
- nessun update_event
- nessun feedback
- ritorno immediato Lista eventi
- updated_at invariato

Decisione:

Il routing post-save è ora contestuale.

Motivo:

- dopo insert l’utente probabilmente vuole inserire un nuovo evento
- dopo update dalla lista l’utente probabilmente vuole continuare a verificare eventi

------------------------------------------------

15. NAVIGATION DOCK

È stata introdotta una navigation dock coerente con la direzione futura del sistema.

Voci:

- Home
- Eventi
- Dashboard

Dashboard:

- presente come sezione prevista
- disabilitata
- nessuna dashboard implementata
- nessun KPI anticipato

Motivo:

La Dashboard è una futura area logica certa del sistema.
Predisporre la nav ora evita di rifare la struttura UX a breve.

Comportamento:

Home vuota:
- nav visibile in basso

Input/Sintesi attiva:
- nav nascosta

Events list:
- nav visibile in alto

Feedback:
- nav nascosta

Decisione:

La nav non è fixed/sticky.
È contestuale al layout Retool per evitare sovrapposizioni o instabilità mobile.

------------------------------------------------

16. ICONE

Sono state rivalutate le icone.

Decisione aggiornata:

- nella Sintesi e nel Feedback restano per ora le emoji/icône colorate perché chiare e già funzionanti
- nei pulsanti principali e nav sono stati introdotti Icon add-ons Retool
- nei pulsanti Azioni rapide sono stati introdotti Icon add-ons Retool
- nella lista eventi sono stati introdotti Icon add-ons Retool

Motivo:

Gli add-on Retool sono più stabili e puliti nei pulsanti.
Nel codice HTML della Sintesi/Feedback non si interviene ora per evitare regressioni.

Decisione finale:

- icone Retool add-on: usate nei componenti reali
- emoji/color icon: mantenute in Sintesi/Feedback dove già integrate e leggibili
- standardizzazione completa icone rimandata a nodo futuro se necessario

------------------------------------------------
TEST VALIDATI
------------------------------------------------

1. Home vuota

Esito:

- Home visibile
- input principale visibile
- Esempi visibili
- Azioni rapide visibili
- Eventi da verificare visibile
- nav visibile in basso

RISULTATO:
OK

------------------------------------------------

2. Input nuovo evento

Input:

20 euro benzina

Esito:

- Sintesi visibile
- Importo 20,00 €
- Da verificare visibile per spesa/incasso
- Suggestion container visibile
- Dati evento visibile
- nav nascosta
- Conferma evento attiva

RISULTATO:
OK

------------------------------------------------

3. Nuovo evento — conferma

Azione:

Conferma evento

Esito:

- insert_event eseguito
- feedback visibile
- feedback_summary mostrato
- events_new aggiornato
- dopo 1800 ms ritorno Home

RISULTATO:
OK

------------------------------------------------

4. Events list

Azione:

Gestisci eventi / nav Eventi

Esito:

- lista eventi visibile
- nav visibile in alto
- search visibile
- card eventi leggibili
- pulsanti OK / No / Modifica visibili
- freccia indietro rimossa / non necessaria

RISULTATO:
OK

------------------------------------------------

5. Edit evento reale

Azione:

Lista eventi
→ Modifica
→ modifica contenuto
→ Conferma evento

Esito:

- update_event eseguito
- feedback visibile
- events_new aggiornato
- dopo 1800 ms ritorno Lista eventi

RISULTATO:
OK

------------------------------------------------

6. Edit senza modifiche

Azione:

Lista eventi
→ Modifica
→ nessuna modifica
→ Conferma evento

Esito:

- update_event NON eseguito
- nessun feedback
- ritorno immediato Lista eventi
- updated_at invariato

RISULTATO:
OK

------------------------------------------------

7. Cancel create/input

Azione:

Home
→ scrivi input
→ Torna alla home

Esito:

- input_home svuotato
- input_raw svuotato
- select resettate
- ui_state.parsed resettato
- Home visibile
- nav Home visibile
- nessun salvataggio

RISULTATO:
OK

------------------------------------------------

8. Cancel edit

Azione:

Lista eventi
→ Modifica
→ Annulla modifica

Esito:

- edit_mode false
- editing_event null
- input svuotati
- select resettate
- ritorno Lista eventi
- nav Events visibile
- nessun update_event

RISULTATO:
OK

------------------------------------------------

9. Feedback

Esito:

- feedback stabile
- nessun ritorno immediato indesiderato
- auto-return 1800 ms
- feedback_summary corretto
- tabella coerente con Sintesi

RISULTATO:
OK

------------------------------------------------

10. Mobile iPhone 12 Pro

Validato su preview mobile.

Esito:

- Home coerente
- input/sintesi leggibile
- suggestion container stabile
- Dati evento compatti
- lista eventi leggibile
- feedback leggibile
- nav contestuale funzionante
- scroll presente ma funzionale

RISULTATO:
OK

------------------------------------------------
DECISIONI CONSOLIDATE
------------------------------------------------

1. Mobile-first

Priorità alla stabilità su mobile rispetto alla compattezza estrema.

2. Navigation dock contestuale

La nav è presente ma non invasiva.
Home / Eventi / Dashboard sono le tre aree previste.
Dashboard resta disabilitata.

3. Feedback temporaneo

Il feedback non è una pagina finale.
È una toast-card leggibile e non bloccante.

4. Routing contestuale

Insert e update non hanno lo stesso ritorno:

- insert → Home
- update → Events list

5. Cancel contestuale

Create/input e edit non devono avere lo stesso effetto:

- create/input → Home
- edit → Events list

6. Dati evento compatti

Le select compatte con label inline sono preferite al layout alto con label sopra.

7. Sintesi non diventa form

La Sintesi resta interpretazione.
Dati evento resta decisione.

8. Azioni rapide predisposte

Le Azioni rapide sono visibili e coerenti, ma non ancora operative come flow guidato.

9. Dashboard predisposta

Dashboard appare in nav come futura sezione, ma resta disabilitata.

10. Icone

Icon add-ons Retool sono preferiti nei pulsanti.
Sintesi/Feedback restano invariati per non toccare HTML funzionante.

------------------------------------------------
DEBITI / NODI FUTURI
------------------------------------------------

1. Rendere cliccabili “Cambia” / “Scegli”

Azioni future:

- focus relativo
- scroll verso campo
- highlight temporaneo
- apertura dropdown solo se stabile in Retool

------------------------------------------------

2. Blocco Ambiguità / Hint avanzati

La card “Da verificare” è una separazione base.
Possibile evoluzione:

- ambiguità bloccanti
- warning non bloccanti
- hint informativi
- priorità messaggi
- UI dedicata

------------------------------------------------

3. Suggestion create vs edit consistency

Da verificare:

- differenze suggestion in create flow e edit flow
- project suggestion mancante in alcuni edit flow
- entity suggestion visibile in modo differente

Non modificato ora per non toccare create_suggestion_state.

------------------------------------------------

4. Project creation override con match generico

Caso:

input “villa”

Il sistema mostra progetto esistente e segnala progetti più specifici,
ma non propone creazione nuovo progetto.

Possibile nodo futuro:

PROJECT CREATE SUGGESTION — MATCH PRESENT / USER OVERRIDE

------------------------------------------------

5. Dashboard

Nav predisposta.
Dashboard non implementata.

Nodo futuro dedicato.

------------------------------------------------

6. Azioni rapide operative

I pulsanti sono presenti come scorciatoie UX.
La logica guidata non è stata implementata.

Nodo futuro dedicato.

------------------------------------------------

7. Icon system

Valutare in futuro:

- standardizzazione completa Icon add-ons
- SVG inline
- Icon components Retool
- sostituzione icone HTML nella Sintesi / Feedback

------------------------------------------------

8. Mobile compact advanced

Il sistema è stabile ma alcune aree restano alte.

Possibili evoluzioni:

- collapsible suggestion
- progressive disclosure
- card compatte
- riduzione altezza warning/hint

------------------------------------------------
RISULTATO FINALE
------------------------------------------------

Il sistema LOGOS ha ora una UX mobile coerente e utilizzabile.

Prima:

- home grezza
- suggestion container instabile su mobile
- feedback troppo rapido e conflittuale
- lista eventi poco rifinita
- navigazione non strutturata
- cancel non pienamente contestuale
- pulsanti non uniformi
- Dati evento più alti e meno compatti

Dopo:

- Home chiara
- Input/Sintesi leggibile
- warning separati
- suggestion container stabile
- Dati evento compatti
- lista eventi rifinita
- feedback stabile con auto-return
- routing post-save contestuale
- nav Home/Eventi/Dashboard predisposta
- cancel create/edit corretto
- pulsanti e icone più coerenti
- sistema mobile-first più vicino a una app reale

------------------------------------------------
STATO NODO
------------------------------------------------

UX MOBILE COHERENCE PASS

COMPLETATO