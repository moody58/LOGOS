{{
(() => {

  const text = input_raw.value?.trim() || "";
  const lowerText = text.toLowerCase();

  const parsed = ui_state.value?.parsed || {};
  const parsedAmount = parsed.amount || null;
  const parsedUnit = parsed.unit || null;
  const parsedDate = parsed.event_date || null;

  const projects = projects_list.data || [];
  const entities = entities_list.data || [];

  const projectId = select_project.value;
  const entityId = select_entity.value;

  const selectedProject = projects.find(p => p.id === projectId)?.name || null;
  const selectedEntity = entities.find(e => e.id === entityId)?.name || null;

  // -----------------------------
  // DATE
  // -----------------------------

  const formatDate = (dateStr) => {
    if (!dateStr) return null;
    const [y, m, d] = dateStr.split("-");
    const mesi = ["gen","feb","mar","apr","mag","giu","lug","ago","set","ott","nov","dic"];
    return `${parseInt(d)} ${mesi[parseInt(m)-1]}`;
  };

  const displayDate = formatDate(parsedDate);

  // -----------------------------
  // VALUE (BOLD)
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

  let note = lowerText;

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
  // DETECTION ENTITÀ / PROGETTI
  // -----------------------------

const detectedEntities = lowerText.length >= 3
  ? entities.filter(e => {
      const name = e.name.toLowerCase();
      const tokens = lowerText.split(" ").filter(t => t.length >= 3);

      return tokens.some(t => name.includes(t));
    })
  : [];

const detectedProjects = lowerText.length >= 3
  ? projects.filter(p => {
      const name = p.name.toLowerCase();
      const tokens = lowerText.split(" ").filter(t => t.length >= 3);

      return tokens.some(t => name.includes(t));
    })
  : [];

  // -----------------------------
  // LABEL BASE
  // -----------------------------

  let main = null;

  if (parsedAmount && parsedUnit) {
    main = [displayDate, value, note].filter(Boolean).join(" • ");
  } else {
    main = [displayDate, note].filter(Boolean).join(" ");
  }

  let labelStyled = main;

  // -----------------------------
  // HIGHLIGHT
  // -----------------------------

  const escapeRegex = (str) =>
    str.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

  detectedEntities.forEach(e => {
  const name = e.name.toLowerCase();
  const tokens = lowerText.split(" ").filter(t => t.length >= 3);

  tokens.forEach(t => {
    if (name.includes(t)) {
      const regex = new RegExp(`\\b${escapeRegex(t)}\\b`, "gi");
      labelStyled = labelStyled.replace(
        regex,
        `<span style="color:#059669;font-weight:500;">${t}</span>`
      );
    }
  });
});

  detectedProjects.forEach(p => {
  const name = p.name.toLowerCase();
  const tokens = lowerText.split(" ").filter(t => t.length >= 3);

  tokens.forEach(t => {
    if (name.includes(t)) {
      const regex = new RegExp(`\\b${escapeRegex(t)}\\b`, "gi");
      labelStyled = labelStyled.replace(
        regex,
        `<span style="color:#2563eb;font-weight:500;">${t}</span>`
      );
    }
  });
});

// -----------------------------
// HINT MULTI + PRIORITÀ + COLORI
// -----------------------------

let hints = [];

const entityMatches =
  (entity_state.data?.matches ?? detectedEntities.length ?? 0);

const projectMatches =
  (project_state.data?.matches ?? detectedProjects.length ?? 0);

const isMeaningful = lowerText.length >= 3;

// -----------------------------
// AMBIGUITÀ MATCH (ROSSO)
// -----------------------------

if (isMeaningful && entityMatches > 1) {
  hints.push({ text: "⚠️ Più entità trovate", color: "#dc2626" });
}

if (isMeaningful && projectMatches > 1) {
  hints.push({ text: "⚠️ Più progetti trovati", color: "#dc2626" });
}

// -----------------------------
// SPESA / INCASSO (BLU)
// -----------------------------

if (parsedUnit === "euro" && select1.value === "Evento") {
  hints.push({ text: "ℹ️ Definisci spesa o incasso", color: "#d97706" });
}

// -----------------------------
// DURATA (GRIGIO)
// -----------------------------

if (parsedUnit === "ore") {

  const hasDecimal = /\d+[.,]\d+/.test(lowerText);

  const hasMixedFormat =
    /(\d+\s*(h|ore)).*(\d+\s*(min|minuti))/.test(lowerText) ||
    /(\d+\s*(min|minuti))/.test(lowerText);

  if (hasDecimal || hasMixedFormat) {
    hints.push({ text: "⏱ Verifica durata", color: "#6B7280" });
  }
}

// -----------------------------
// OUTPUT HINT MULTIPLI
// -----------------------------

const hintOutput = hints
  .map(h => `<span style="color:${h.color};">${h.text}</span>`)
  .join("<br>");

  // -----------------------------
  // OUTPUT
  // -----------------------------

  return [
  labelStyled,
  hintOutput
]
.filter(Boolean)
.join("<br>");

})()
}}