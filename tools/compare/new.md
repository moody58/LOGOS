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
  // VALUE (BOLD) — PREVIEW ALIGNMENT BASE
  // -----------------------------

  const formatAmountIT = (amount, unit) => {
    const num = Number(amount);

    if (!Number.isFinite(num)) return null;

        if (unit === "euro") {
      return num.toLocaleString("it-IT", {
        useGrouping: true,
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
      });
    }

        if (unit === "ore" || unit === "minuti") {
      return num.toLocaleString("it-IT", {
        useGrouping: true,
        minimumFractionDigits: 0,
        maximumFractionDigits: 2
      });
    }

        return num.toLocaleString("it-IT", {
      useGrouping: true,
      minimumFractionDigits: 0,
      maximumFractionDigits: 2
    });
  };

  const formatUnitIT = (amount, unit) => {
    const num = Number(amount);

    if (unit === "euro") return "€";
    if (unit === "ore") return num === 1 ? "ora" : "ore";
    if (unit === "minuti") return num === 1 ? "minuto" : "minuti";

    return unit;
  };

  let value = null;

  if (parsedAmount && parsedUnit) {
    const amountLabel = formatAmountIT(parsedAmount, parsedUnit);
    const unitLabel = formatUnitIT(parsedAmount, parsedUnit);

    if (amountLabel && unitLabel) {
      value = `<span style="font-weight:600;">${amountLabel} ${unitLabel}</span>`;
    }
  }

    // -----------------------------
  // LABEL CLEAN
  // -----------------------------

  let note = lowerText;

  note = note
    .replace(/€/g, " € ")

    // unità compatte
    // ordine importante: "minuti" prima di "min"
    // per evitare residui tipo "uti"
    .replace(/(\d)(minuti|minuto|min|ore|ora|h)/g, "$1 $2")
    .replace(/(minuti|minuto|min|ore|ora|h)(\d)/g, "$1 $2")

    .replace(/\s+/g, " ")
    .trim();

  if (parsedAmount && parsedUnit) {
    note = note
      // euro separati o compatti:
      // 1.500,50 euro / 1500,50 euro / 10 euro / 10€ / €10
      .replace(/\b\d{1,3}(?:\.\d{3})*(?:[,.]\d+)?\s*(€|euro|eur)\b/gi, " ")
      .replace(/\b\d+(?:[,.]\d+)?\s*(€|euro|eur)\b/gi, " ")
      .replace(/\b(€|euro|eur)\s*\d{1,3}(?:\.\d{3})*(?:[,.]\d+)?\b/gi, " ")
      .replace(/\b(€|euro|eur)\s*\d+(?:[,.]\d+)?\b/gi, " ")

      // ore separate o compatte:
      // 1 ora / 1,5 ore / 2.2 ore / 2h / h2
      .replace(/\b\d+(?:[,.]\d+)?\s*(ore|ora|h)\b/gi, " ")
      .replace(/\b(h)\s*\d+(?:[,.]\d+)?\b/gi, " ")

      // minuti separati o compatti:
      // 18 minuti / 18min / min30
      .replace(/\b\d+(?:[,.]\d+)?\s*(minuti|minuto|min)\b/gi, " ")
      .replace(/\b(minuti|minuto|min)\s*\d+(?:[,.]\d+)?\b/gi, " ")

      .replace(/\s+/g, " ")
      .trim();
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
  // TOKEN FILTER PREVIEW
  // -----------------------------

  const previewStopTokens = [
    "ora",
    "ore",
    "h",
    "min",
    "minuto",
    "minuti",
    "euro",
    "eur"
  ];

  const getPreviewTokens = () =>
    lowerText
      .split(" ")
      .map(t => t.trim())
      .filter(t => t.length >= 3)
      .filter(t => !previewStopTokens.includes(t));

  // -----------------------------
  // DETECTION ENTITÀ / PROGETTI
  // -----------------------------

const detectedEntities = lowerText.length >= 3
  ? entities.filter(e => {
      const name = e.name.toLowerCase();
      const tokens = getPreviewTokens();

      return tokens.some(t => name.includes(t));
    })
  : [];

const detectedProjects = lowerText.length >= 3
  ? projects.filter(p => {
      const name = p.name.toLowerCase();
      const tokens = getPreviewTokens();

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
    main = [displayDate, note].filter(Boolean).join(" • ");
  }

  let labelStyled = main;

  // -----------------------------
  // HIGHLIGHT
  // -----------------------------

  const escapeRegex = (str) =>
    str.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

  detectedEntities.forEach(e => {
  const name = e.name.toLowerCase();
  const tokens = getPreviewTokens();

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
  const tokens = getPreviewTokens();

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