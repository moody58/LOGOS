1. 🎯 SCOPO DEL NODO

Definire e stabilizzare il comportamento della sintesi input (preview) nel sistema LOGOS.

La preview ha il compito di:

mostrare cosa è stato interpretato dall’input utente
guidare l’utente alla conferma
evidenziare ambiguità e dati mancanti
NON sostituire l’engine semantico
2. 🧠 PRINCIPI CONSOLIDATI
2.1 Preview ≠ Parsing
parsing → genera dati per DB
preview → rappresenta visivamente quei dati

👉 separazione mantenuta e stabilizzata

2.2 Nessuna duplicazione informativa

Rimosso completamente:

meta (progetto + entità duplicati)

Motivo:

generava rumore
duplicava informazione già presente nella label
2.3 Label come elemento centrale

La preview è basata su:

[DATA] • [VALORE] • [TIPO] + descrizione

Esempio:

4 apr • 50 € • benzina alfie allevamento aspri
2.4 Evidenziazione inline (INTRODOTTA)
progetto → blu (#2563eb)
entità → verde (#059669)

👉 integrati direttamente nella label
👉 nessun blocco separato

2.5 Hint ridotti e gerarchici

Gli hint NON sono più informativi generici, ma:

PRIORITÀ
⚠️ Ambiguità (bloccanti)
ℹ️ Dati mancanti critici
⏱ Incoerenze temporali
3. ⚙️ COMPORTAMENTO FINALE
3.1 Rendering Preview

Output finale:

labelStyled
typeBadge
hint (se presente)
3.2 Value Highlight
sempre evidenziato (font-weight:600)
coerente con unità
3.3 Label Cleaning

Pipeline stabile:

normalizzazione testo
rimozione amount/unit
rimozione date
preservazione coppie parola+numero (es: "villa 2")
limitazione lunghezza
3.4 Highlight Engine (preview level)
match diretto su:
project.name
entity.name
applicato inline
escape regex introdotto (robustezza base)
3.5 Hint System (stabile)
Ambiguità
⚠️ Seleziona entità
⚠️ Seleziona progetto
Economico
ℹ️ Definisci spesa o incasso
Tempo
⏱ Verifica durata (es: 2h 30min)
4. 🐞 BUG RISOLTI
✔ Sintesi multiline incoerente

→ corretto output e join

✔ Parsing rotto dopo refactor

→ separato parse_input da preview

✔ Hint incoerenti

→ riallineati a logica reale

✔ Meta duplicata

→ eliminata

✔ Highlight parziale

→ migliorato (entity-first + escape)

5. ⚠️ LIMITI ATTUALI (ACCETTATI)
5.1 Matching entità non fuzzy
match basato su stringhe
non gestisce:
alias
plurali
sinonimi

👉 rimandato a fase ENGINE

5.2 Highlight non semantico
può evidenziare substring non ideali
accettabile in questa fase
5.3 Layout dipendente da UI container
possibili wrap su mobile
non gestito lato codice
6. 🧪 VALIDAZIONE

Test eseguiti su:

input economici
input tempo
input evento
input misti
casi ambigui

Risultato:

Parsing: STABILE ✅
Preview: COERENTE ✅
Hint: FUNZIONALI ✅
UX: MIGLIORATA ✅

1. 🧩 COMPONENTI COINVOLTI

Questo nodo dipende da:

INPUT
input_raw.value
PARSER
parse_input.value
(deve restituire:)
{
  "amount": number|null,
  "unit": "euro"|"ore"|"minuti"|null,
  "event_date": "YYYY-MM-DD"|null
}
SELECT
select1.value → tipo (Evento / Spesa / Incasso / Tempo)
select_project.value
select_entity.value
DATA
projects_list.data
entities_list.data
MATCH STATE
project_state.data.matches
entity_state.data.matches
2. 🧠 OUTPUT PREVIEW

Formato finale:

[labelStyled]
[typeBadge]
[hint]

Join:

.filter(Boolean).join("\n")
3. 🧮 CODICE COMPLETO (SINTESI)

👉 QUESTO È IL BLOCCO DA INCOLLARE (SORGENTE DI VERITÀ)

{{
(() => {

  const text = input_raw.value?.trim() || "";

  const parsed = parse_input.value || {};
  const parsedAmount = parsed.amount || null;
  const parsedUnit = parsed.unit || null;
  const parsedDate = parsed.event_date || null;

  const projectId = select_project.value;
  const entityId = select_entity.value;

  const projects = projects_list.data || [];
  const entities = entities_list.data || [];

  const project = projects.find(p => p.id === projectId)?.name || null;
  const entity = entities.find(e => e.id === entityId)?.name || null;

  const projectMatches = project_state.data?.matches ?? 0;
  const entityMatches = entity_state.data?.matches ?? 0;

  // -----------------------------
  // DATE DISPLAY
  // -----------------------------

  const formatDate = (dateStr) => {
    if (!dateStr) return null;
    const [y, m, d] = dateStr.split("-");
    const mesi = ["gen","feb","mar","apr","mag","giu","lug","ago","set","ott","nov","dic"];
    return `${parseInt(d)} ${mesi[parseInt(m)-1]}`;
  };

  const displayDate = formatDate(parsedDate);

  // -----------------------------
  // VALUE
  // -----------------------------

  let value = null;

  if (parsedAmount && parsedUnit) {
    if (parsedUnit === "euro") {
      value = `<span style="font-weight:600;">${parsedAmount} €</span>`;
    } else if (parsedUnit === "ore" && parsedAmount === 1) {
      value = `<span style="font-weight:600;">1 ora</span>`;
    } else {
      value = `<span style="font-weight:600;">${parsedAmount} ${parsedUnit}</span>`;
    }
  }

  // -----------------------------
  // LABEL CLEAN
  // -----------------------------

  let note = text.toLowerCase();

  note = note
    .replace(/€/g, " € ")
    .replace(/(\d)(h|min|ore|minuti)/g, "$1 $2")
    .replace(/(h|min|ore|minuti)(\d)/g, "$1 $2")
    .replace(/\s+/g, " ")
    .trim();

  if (parsedAmount && parsedUnit) {
    const regex = new RegExp(`(${parsedAmount}\\s*(€|euro|eur|ora|ore|h|min|minuti)|(€|euro|eur|ora|ore|h|min|minuti)\\s*${parsedAmount})`, "i");
    note = note.replace(regex, "");
  }

  note = note
    .replace(/\b\d{1,2}\/\d{1,2}(?:\/\d{2,4})?\b/g, "")
    .replace(/\b\d{1,2}\s+(gennaio|febbraio|marzo|aprile|maggio|giugno|luglio|agosto|settembre|ottobre|novembre|dicembre)\b/g, "")
    .replace(/\b20\d{2}\b/g, "")
    .replace(/\s+/g, " ")
    .trim();

  // parola + numero (es: villa 2)
  const words = note.split(" ");
  const combined = [];

  for (let i = 0; i < words.length; i++) {
    if (words[i + 1] && /^\d+$/.test(words[i + 1])) {
      combined.push(words[i] + " " + words[i + 1]);
      i++;
    } else {
      combined.push(words[i]);
    }
  }

  note = combined.join(" ").trim();
  note = note.split(" ").slice(0, 6).join(" ");

  // -----------------------------
  // LABEL SPLIT
  // -----------------------------

  const parts = note ? note.split(" ") : [];
  const primary = parts[0] || null;
  const secondary = parts.slice(1).join(" ") || null;

  // -----------------------------
  // MAIN
  // -----------------------------

  let main = null;

  if (parsedAmount && parsedUnit) {
    main = [displayDate, value, primary].filter(Boolean).join(" • ");
  } else {
    main = [displayDate, primary].filter(Boolean).join(" ");
  }

  let labelFull = [main, secondary].filter(Boolean).join(" ");

  // -----------------------------
  // HIGHLIGHT (ENTITY FIRST)
  // -----------------------------

  if (entity) {
    const safe = entity.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    labelFull = labelFull.replace(new RegExp(`\\b${safe}\\b`, "gi"),
      `<span style="color:#059669;font-weight:500;">${entity}</span>`);
  }

  if (project) {
    const safe = project.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    labelFull = labelFull.replace(new RegExp(`\\b${safe}\\b`, "gi"),
      `<span style="color:#2563eb;font-weight:500;">${project}</span>`);
  }

  // -----------------------------
  // TYPE BADGE
  // -----------------------------

  const typeBadge = `<span style="font-size:12px;color:#6B7280;">Tipo: ${select1.value}</span>`;

  // -----------------------------
  // HINT SYSTEM
  // -----------------------------

  let hint = null;
  let hintColor = "#6B7280";

  const lowerText = text.toLowerCase();

  const isSpesa =
    lowerText.includes("acquisto") ||
    lowerText.includes("spesa") ||
    lowerText.includes("pagato");

  const isIncasso =
    lowerText.includes("vendita") ||
    lowerText.includes("incasso");

  if (entityMatches > 1) {
    hint = "⚠️ Seleziona entità";
    hintColor = "#dc2626";
  } else if (projectMatches > 1) {
    hint = "⚠️ Seleziona progetto";
    hintColor = "#dc2626";
  } else if (parsedUnit === "euro" && select1.value === "Evento") {
    hint = "ℹ️ Definisci spesa o incasso";
  } else if (parsedUnit === "ore") {
    const numbers = lowerText.match(/\d+/g) || [];

    if (
      numbers.length > 1 &&
      !/\d+\s*(min|minuti)/.test(lowerText)
    ) {
      hint = "⏱ Verifica durata (es: 2h 30min)";
    }
  }

  return [
    labelFull,
    typeBadge,
    hint && `<span style="color:${hintColor};">${hint}</span>`
  ]
  .filter(Boolean)
  .join("\n");

})()
}}
4. 🔁 DIPENDENZE CRITICHE

Se vuoi ricostruire il sistema:

✔ parse_input deve funzionare

(se no → preview vuota)

✔ select1 deve avere logica semantica

(es: Spesa / Incasso)

✔ project_state / entity_state devono esporre:
{ "matches": number }
5. ⚠️ REGOLE OPERATIVE CRITICHE
NON modificare parse_input in questo nodo
NON introdurre logica semantica avanzata
NON duplicare dati (meta eliminato)
highlight SOLO su match certo
6. 🧠 STATE (RICOSTRUTTIVO)
#STATE

NODE: INPUT_PREVIEW_SYNTHESIS
STATUS: CONSOLIDATED

----------------------------------------

COMPONENTS:

- input_raw
- parse_input
- select1
- select_project
- select_entity
- project_state
- entity_state

----------------------------------------

OUTPUT STRUCTURE:

labelStyled
typeBadge
hint

----------------------------------------

LOGIC:

- parsing external (parse_input)
- label cleaning internal
- highlight inline (project/entity)
- hint conditional

----------------------------------------

CRITICAL RULES:

- no duplication (meta removed)
- no semantic engine logic
- preview = UX layer only

----------------------------------------

DEPENDENCIES:

parse_input MUST return:
{ amount, unit, event_date }

----------------------------------------

NEXT NODE:

MATCH_ENGINE_REFINEMENT