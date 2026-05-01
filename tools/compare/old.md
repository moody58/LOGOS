{{
(() => {
  const text = input_raw.value?.toLowerCase() || "";

  // ------------------
  // TEMPO
  // ------------------

  const hasTime =
    /\b(ora|ore|min|minuti)\b/.test(text) ||
    /\d+h\b/.test(text) ||
    /\d+ore\b/.test(text) ||
    /\d+min\b/.test(text);

  if (hasTime) return "Tempo";

  // ------------------
// INCASSO (PRIORITARIO)
// ------------------

const isIncasso =
  text.includes("vendita") ||
  text.includes("incasso") ||
  text.includes("ricevuto") ||
  text.includes("entrata") ||
  text.includes("credito") ||
  (text.includes("acconto") && text.includes("ricevuto"));

if (isIncasso) return "Incasso";

// ------------------
// SPESA
// ------------------

const isSpesa =
  text.includes("acquisto") ||
  text.includes("spesa") ||
  text.includes("pagato") ||
  text.includes("pagamento") ||
  text.includes("costo") ||
  text.includes("anticipo") ||
  text.includes("saldo") ||
  (text.includes("acconto") && text.includes("dato"));

if (isSpesa) return "Spesa";

// ------------------
// AC-CONTO AMBIGUO
// ------------------

if (text.includes("acconto")) {
  return "Evento"; // → forza hint
}

  // ------------------
  // FALLBACK ECONOMICO
  // ------------------

  if (text.includes("€") || text.includes("euro")) {
    return "Evento"; // → forza hint
  }

  // ------------------
  // DEFAULT
  // ------------------

  return "Evento";
})()
}}