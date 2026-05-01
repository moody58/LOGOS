{{
(() => {
  const text = (input_raw.value || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");

  const parsed = ui_state.value?.parsed || {};
  const parsedUnit = String(parsed.unit || "").toLowerCase();

  // ------------------------------------------------
  // 1. TEMPO — fonte primaria: ui_state.parsed
  // ------------------------------------------------
  // Dopo Duration Normalization tutte le durate certe
  // sono salvate come:
  // amount = totale minuti
  // unit = "minuti"
  //
  // Questo risolve casi come:
  // 2h30 rendering → Tempo
  // 1 ora lavoro → Tempo
  // 18min test → Tempo

  if (parsedUnit === "minuti") {
    return "Tempo";
  }

  // ------------------------------------------------
  // 2. ECONOMICO — solo se c'è segnale economico
  // ------------------------------------------------

  const hasEuro =
    parsedUnit === "euro" ||
    /€|\beuro\b|\beur\b/.test(text);

  // ------------------------------------------------
  // 3. INCASSO — keyword controllate
  // ------------------------------------------------
  // Regola:
  // classificare Incasso solo se il testo contiene
  // segnali abbastanza espliciti di entrata.

  const isIncasso =
    /\bincasso\b/.test(text) ||
    /\bincassato\b/.test(text) ||
    /\bentrata\b/.test(text) ||
    /\bvendita\b/.test(text) ||
    /\bvenduto\b/.test(text) ||
    /\bpagamento ricevuto\b/.test(text) ||
    /\bacconto ricevuto\b/.test(text) ||
    /\bsaldo ricevuto\b/.test(text);

  // ------------------------------------------------
  // 4. SPESA — keyword controllate
  // ------------------------------------------------
  // Regola:
  // classificare Spesa solo se il testo contiene
  // segnali abbastanza espliciti di uscita.

  const isSpesa =
    /\bspesa\b/.test(text) ||
    /\bacquisto\b/.test(text) ||
    /\bacquistato\b/.test(text) ||
    /\bcomprato\b/.test(text) ||
    /\bpagato\b/.test(text) ||
    /\bpagamento\b/.test(text) ||
    /\bcosto\b/.test(text) ||
    /\bcosti\b/.test(text) ||
    /\buscita\b/.test(text) ||
    /\bacconto dato\b/.test(text) ||
    /\bacconto versato\b/.test(text) ||
    /\bsaldo pagato\b/.test(text) ||
    /\bsaldo versato\b/.test(text);

  // ------------------------------------------------
  // 5. AMBIGUITÀ ECONOMICA
  // ------------------------------------------------
  // Se emergono segnali contrastanti, non decidere.
  // Lascia Evento per forzare scelta/hint utente.

  if (isIncasso && isSpesa) {
    return "Evento";
  }

  if (isIncasso) {
    return "Incasso";
  }

  if (isSpesa) {
    return "Spesa";
  }

  // ------------------------------------------------
  // 6. EURO SENZA DIREZIONE
  // ------------------------------------------------
  // Esempio:
  // 20 euro materiale
  // 50 euro benzina
  //
  // Non decidiamo automaticamente Spesa/Incasso.
  // Restiamo su Evento così l'utente viene guidato
  // a scegliere manualmente.

  if (hasEuro) {
    return "Evento";
  }

  // ------------------------------------------------
  // 7. DEFAULT
  // ------------------------------------------------

  return "Evento";
})()
}}