# LOGOS — procedura documentale P5

Questa proposta si applica a C:\AIOS_GITHUB\LOGOS dopo provisioning revisionato.
Le regole del progetto derivano dal Kernel Manifest, da
UNIVERSAL_PROJECT_RUNTIME_INSTRUCTIONS.md e dai protocolli locali LOGOS.

Work prepara contenuti, delta, profilo, pacchetto e comandi revisionabili.
Codex esegue letture locali mirate e i comandi esatti del relativo HANDOFF_GUI.
Non delegare a Codex la riprogettazione del motore per completare un handoff.

Prima di un'azione documentale leggere integralmente la preimage locale,
anche se dirty. Conservare hash, BOM/EOL e byte fuori dai range approvati.
Rilevare istruzioni applicabili, configurazione e stato Git prima/dopo.
Non ripristinare, pulire, staged, committare o pubblicare automaticamente.

La prima corsia P5 ammette soltanto il documento esistente tracciato
98_SISTEMA_TECNICO/98_PROJECT_RUNTIME.md, modify_ranges, un file per transazione.
Nuovi target richiedono un adattamento revisionato del perimetro.
AGENTS, configurazioni e runtime seguono un provisioning distinto dai documenti.

Preparazione + Check + raccolta precedono la review del contenuto.
Apply richiede decisione separata vincolata a stato, artefatti e comando esatti.
Apply passa dal wrapper approvato dopo setup verificato; poi gate e Verify
indipendente con raccolta delle evidenze. Nessuna adozione automatica baseline.

Eseguire gli script del motore con Windows PowerShell 5.1 Desktop,
FullLanguage e policy RemoteSigned senza modificare policy o LanguageMode.
La shell GUI può essere diversa: delega al comando nativo già preparato.
Non attestare permessi effettivi o origine umana da soli file/configurazioni.
Dall'invio del task operativo, fermarsi al primo errore; preservare output e stato parziale.
Nessun retry automatico per operazioni fallite o di esito ignoto.

P4 resta concluso nel perimetro AIOS_CORE. P5 non avvia lo sviluppo prodotto
né attività su servizi esterni. baseline_adopted e production_ready restano false
finché le relative decisioni non sono esplicitamente concluse nel loro perimetro.

VALIDAZIONE: nodo: OK · scope: OK · deviazione: NO

## Ingresso documentale permanente

Leggere 98_SISTEMA_TECNICO/98_PROJECT_RUNTIME.md per attivazione, divisione
Work/Codex, archivi, messaggi rapidi, fonti AIOS e dipendenze di ripartenza.
Non far ripetere questi dettagli all'utente a ogni avvio. Work prepara codice,
controlli complessi e ZIP; Codex esegue le letture/task pinned e i comandi pronti.
Nelle letture preliminari completare soltanto blocchi mancanti o rettificare
un pathname materiale errato se l'handoff lo consente, prima dell'invio operativo.
Non ricomporre preflight, campi JSON o comandi. Non correggere/riprovare un task.
Il perimetro effettivo deriva dalla release verificata: la prima corsia P5
resta quella sopra descritta fino alla nuova qualifica e al provisioning P6.
Per un altro documento usare il profilo esatto revisionato e la release che
lo ammette; questo adattatore non abilita da solo nuovi target.
