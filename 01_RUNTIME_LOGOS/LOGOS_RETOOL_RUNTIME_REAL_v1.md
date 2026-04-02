\#DOC



LOGOS\_RETOOL\_RUNTIME\_REAL\_v1



STATO:

→ SISTEMA REALE DOCUMENTATO (AS-IS)



FONTE:

→ Screenshot Retool + Query + Script reali



\## DESCRIZIONE OPERATIVA DEL SISTEMA



Il sistema LOGOS implementato su Retool è un \*\*Event Operating System client-side\*\*, in cui l’intero ciclo di vita dell’evento viene gestito tramite logiche JavaScript distribuite nei componenti UI e query REST verso Supabase.



Il flusso operativo si articola nei seguenti step:



1\. \*\*Input utente\*\*



&#x20;  \* L’utente inserisce testo libero nel componente `input\_home`

&#x20;  \* Il valore viene sincronizzato in tempo reale su `input\_raw` tramite `input\_home.setValue → input\_raw.setValue`

&#x20;  \* Viene attivato lo stato di digitazione tramite `typing\_state.trigger`



2\. \*\*Pre-processing e matching automatico\*\*



&#x20;  \* Il testo viene normalizzato (lowercase + trim + pulizia spazi)

&#x20;  \* Viene eseguito un primo livello di \*\*matching automatico progetti\*\* nello script di `input\_raw` e nel `default value` di `select\_project`

&#x20;  \* Viene eseguito un \*\*matching entità\*\* nel `default value` di `select\_entity`

&#x20;  \* La logica utilizza:



&#x20;    \* tokenizzazione parole

&#x20;    \* filtro parole significative (length > 2)

&#x20;    \* matching completo (every word)

&#x20;    \* disambiguazione tramite numeri (`match(/\\d+/)`)



3\. \*\*Classificazione tipo evento\*\*



&#x20;  \* Il componente `select1` determina automaticamente il tipo:



&#x20;    \* `"Tempo"` se presenti keyword (`ora`, `ore`, `min`, `minuti`)

&#x20;    \* `"Evento"` in fallback o presenza di `euro/€`



4\. \*\*Preview (sintesi)\*\*



&#x20;  \* Il componente `sintesi` costruisce una rappresentazione leggibile combinando:



&#x20;    \* `input\_raw`

&#x20;    \* progetto selezionato (`select\_project`)

&#x20;    \* entità selezionata (`select\_entity`)

&#x20;  \* Serve come feedback visivo prima della conferma



5\. \*\*Parsing finale e inserimento evento\*\*



&#x20;  \* Alla pressione di `button\_input\_confirm`:



&#x20;    \* reset immediato input (`input\_home.setValue("")`)

&#x20;    \* switch UI a `feedback` tramite `ui\_state.trigger`

&#x20;    \* esecuzione parsing inline:



&#x20;      \* `amount` → primo numero trovato (`match(/\\d+/)`)

&#x20;      \* `unit` → rilevata solo per `"min"`

&#x20;    \* invio dati tramite `insert\_event.trigger`



6\. \*\*Persistenza su Supabase\*\*



&#x20;  \* Inserimento su tabella `events` con struttura:



&#x20;    \* `raw\_input`

&#x20;    \* `amount`

&#x20;    \* `unit`

&#x20;    \* `project\_id`

&#x20;    \* `entity\_id`

&#x20;    \* `status = NEW`

&#x20;    \* `payload = {}`



7\. \*\*Refresh e reset UI\*\*



&#x20;  \* Trigger `events\_new` per aggiornare la lista eventi

&#x20;  \* Reset selezioni (`select\_project.clearValue`, `select\_entity.clearValue`)

&#x20;  \* Ritorno automatico alla home dopo timeout (3.5s)



8\. \*\*Gestione eventi (processing manuale)\*\*



&#x20;  \* Lista eventi (`list\_events`) alimentata da `events\_new`

&#x20;  \* Azioni disponibili:



&#x20;    \* `btn\_written` → `update\_written.trigger` → status = WRITTEN

&#x20;    \* `btn\_error` → `update\_error.trigger` → status = ERROR

&#x20;  \* Navigazione gestita via visibilità container (`container\_events\_list`, `container\_home`)



\---



\## SINTESI FUNZIONALE



Il sistema attuale:



\* acquisisce input destrutturato (`input\_home`)

\* esegue parsing e matching \*\*in tempo reale lato UI\*\*

\* suggerisce automaticamente progetto ed entità

\* salva eventi in stato `NEW`

\* delega la validazione finale a una fase di processing manuale



Non esiste logica server-side:

tutta l’intelligenza è distribuita nei componenti Retool.





\#STRUCTURE.ARCHITECTURE



FRONTEND

Piattaforma: Retool

App: Logos / page1

Modalità: Single page app

Navigazione: gestione visibilità container (no routing)



\#STRUCTURE.UI\_LAYOUT



CONTAINER PRINCIPALI

wrapper

├── container\_home

├── container\_input

├── container\_feedback

├── container\_events\_list

NAVIGAZIONE



Gestita tramite script:



container\_events\_list.setHidden(true/false)

container\_home.setHidden(true/false)



\#STRUCTURE.INPUT\_FLOW



COMPONENTE INPUT

input\_home



Script:



input\_raw.setValue(input\_home.value);



typing\_state.trigger({

&#x20; additionalScope: {

&#x20;   typing: !!input\_home.value?.trim()

&#x20; }

});

input\_raw



Script (match project):



const text = input\_raw.value?.trim() || "";



const normalize = (str) =>

&#x20; (str || "").toLowerCase().replace(/\\s+/g, " ").trim();



const cleanText = normalize(text);



const projects = projects\_list.data || \[];



const projectMatches = projects.filter(p => {

&#x20; const name = normalize(p.name);



&#x20; const words = name

&#x20;   .split(" ")

&#x20;   .filter(w => w.length > 2)

&#x20;   .filter(w => isNaN(w));



&#x20; return words.every(word => cleanText.includes(word));

});



let finalMatches = projectMatches;



const numbers = cleanText.match(/\\d+/g);



if (numbers \&\& projectMatches.length > 1) {

&#x20; const filtered = projectMatches.filter(p => {

&#x20;   const name = normalize(p.name);

&#x20;   return numbers.some(n => name.includes(n));

&#x20; });



&#x20; if (filtered.length === 1) {

&#x20;   finalMatches = filtered;

&#x20; }

}



if (finalMatches.length === 1) {

&#x20; if (!select\_project.value) {

&#x20;   select\_project.setValue(finalMatches\[0].id);

&#x20; }

}



\#STRUCTURE.TYPE\_DETECTION



select1 (tipo evento)



Script:



const text = input\_raw.value.toLowerCase() || "";



const hasTime =

&#x20; text.includes("ora") ||

&#x20; text.includes("ore") ||

&#x20; text.includes("min") ||

&#x20; text.includes("minuti");



if (hasTime) {

&#x20; return "Tempo";

}



if (text.includes("euro") || text.includes("€")) {

&#x20; return "Evento";

}



return "Evento";



\#STRUCTURE.PROJECT\_MATCH



select\_project (default value)



Script:



const text = input\_raw.value?.trim() || "";



const normalize = (str) =>

&#x20; (str || "").toLowerCase().replace(/\\s+/g, " ").trim();



const cleanText = normalize(text);



const projects = projects\_list.data || \[];



const projectMatches = projects.filter(p => {

&#x20; const name = normalize(p.name);



&#x20; const words = name

&#x20;   .split(" ")

&#x20;   .filter(w => w.length > 2)

&#x20;   .filter(w => isNaN(w));



&#x20; return words.every(word => cleanText.includes(word));

});



let finalMatches = projectMatches;



const numbers = cleanText.match(/\\d+/g);



if (numbers \&\& projectMatches.length > 1) {

&#x20; const filtered = projectMatches.filter(p => {

&#x20;   const name = normalize(p.name);

&#x20;   return numbers.some(n => name.includes(n));

&#x20; });



&#x20; if (filtered.length === 1) {

&#x20;   finalMatches = filtered;

&#x20; }

}



if (finalMatches.length === 1) {

&#x20; return finalMatches\[0].id;

}



return null;



\#STRUCTURE.ENTITY\_MATCH



select\_entity (default value)



Script:



const text = input\_raw.value?.trim() || "";



const normalize = (str) =>

&#x20; (str || "").toLowerCase().replace(/\\s+/g, " ").trim();



const cleanText = normalize(text);



const entities = entities\_list.data || \[];



const entityMatches = entities.filter(e => {

&#x20; const name = normalize(e.name);



&#x20; const nameWords = name.split(" ").filter(w => w.length > 2);

&#x20; const inputWords = cleanText.split(" ").filter(w => w.length > 2);



&#x20; return nameWords.every(word =>

&#x20;   inputWords.includes(word)

&#x20; );

});



const exactMatches = entities.filter(e => {

&#x20; return normalize(e.name) === cleanText;

});



let finalMatches = entityMatches;



if (exactMatches.length === 1) {

&#x20; finalMatches = exactMatches;

}



if (finalMatches.length === 1) {

&#x20; return finalMatches\[0].id;

}



return null;



\#STRUCTURE.SINTESI



sintesi (preview)



Script:



const text = input\_raw.value?.trim() || "";



const project = select\_project.selectedItem?.name;

const entity = select\_entity.selectedItem?.name;



const timeUnits = text.match(/(ora|ore|minuti|min)/gi);



const normalize = (str) =>

&#x20; (str || "").toLowerCase().replace(/\\s+/g, " ").trim();



const cleanText = normalize(text);



const tokens = cleanText.split(" ").filter(w => w.length >= 3);



const projects = projects\_list.data || \[];

const entities = entities\_list.data || \[];



let detectedProject = null;

let projectHint = null;

let finalProjectMatches = \[];



if (tokens.length > 0) {

&#x20; const strongProjectMatches = projects.filter(p => {

&#x20;   const name = normalize(p.name);

&#x20;   return cleanText.includes(name);

&#x20; });



&#x20; const fullProjectMatches = projects.filter(p => {

&#x20;   const name = normalize(p.name);



&#x20;   const nameWords = name

&#x20;     .split(" ")

&#x20;     .filter(w => w.length > 2)

&#x20;     .filter(w => isNaN(w));



&#x20;   const inputWords = tokens;



&#x20;   return nameWords.every(word =>

&#x20;     inputWords.includes(word)

&#x20;   );

&#x20; });



&#x20; const partialProjectMatches = projects.filter(p => {

&#x20;   const name = normalize(p.name);

&#x20;   return name.includes(cleanText);

&#x20; });

}



(continua nello script reale — non modificato)



\#STRUCTURE.CONFIRM\_FLOW



button\_input\_confirm



Script:



const lastInput = input\_home.value;

input\_home.setValue("");



await ui\_state.trigger({

&#x20; additionalScope: {

&#x20;   view: "feedback"

&#x20; }

});



await insert\_event.trigger({

&#x20; additionalScope: {

&#x20;   raw\_input: input\_raw.value,

&#x20;   amount: input\_raw.value \&\&

&#x20;     input\_raw.value.match(/\\d+/)

&#x20;       ? Number(input\_raw.value.match(/\\d+/)\[0])

&#x20;       : null,

&#x20;   unit: input\_raw.value \&\&

&#x20;     input\_raw.value.includes("min")

&#x20;       ? "minuti"

&#x20;       : null,

&#x20;   project\_id: select\_project.value || null,

&#x20;   entity\_id: select\_entity.value || null

&#x20; }

});



await events\_new.trigger();



select\_project.clearValue();

select\_entity.clearValue();



setTimeout(() => {

&#x20; ui\_state.trigger({

&#x20;   additionalScope: {

&#x20;     view: "home"

&#x20;   }

&#x20; });

}, 3500);



\#STRUCTURE.FEEDBACK



feedback\_resume

{{

\[

&#x20; input\_raw.value,

&#x20; select\_project.selectedItem?.name

]

.filter(Boolean)

.join("\\n")

}}



\#STRUCTURE.EVENT\_LIST



list\_events

datasource: events\_new

primary key: item.id

btn\_written

await update\_written.trigger({

&#x20; additionalScope: {

&#x20;   id: item.id

&#x20; }

});



await events\_new.trigger();

btn\_error

await update\_error.trigger({

&#x20; additionalScope: {

&#x20;   id: item.id

&#x20; }

});



await events\_new.trigger();

btn\_back\_home

container\_events\_list.setHidden(true)

container\_home.setHidden(false)



\#STRUCTURE.QUERIES



GET

projects\_list

/projects?select=id,name\&order=name

entities\_list

/entities?select=id,name\&order=name

events\_new

/events?select=\*\&status=eq.NEW\&order=created\_at.desc

POST

insert\_event

{

&#x20; raw\_input,

&#x20; amount,

&#x20; unit,

&#x20; project\_id,

&#x20; entity\_id,

&#x20; status: "NEW",

&#x20; payload: {}

}

update\_written

rpc/update\_event\_status



Body:



{

&#x20; event\_id: id,

&#x20; new\_status: "WRITTEN"

}

update\_error

rpc/update\_event\_status



Body:



{

&#x20; event\_id: id,

&#x20; new\_status: "ERROR"

}



\#STRUCTURE.STATE



ui\_state

return {

&#x20; view: view || "home"

};

typing\_state

return {

&#x20; isTyping: typing || false

};

