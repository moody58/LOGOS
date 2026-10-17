# Procedura documentale LOGOS
Versione: v1.0

Alla chiusura del nodo di lavoro, richiedere l'aggiornamento dei documenti
necessari. Work prepara contenuti completi, Check e comandi; l'utente revisiona
e approva il delta prima dell'Apply. Codex VS Code esegue i task predisposti.
Commit e push restano manuali. Nessun avvio automatico in background.

Il collegamento usa la release comune 0.6-R01; il percorso P6 precedente
conserva il proprio perimetro. La scelta fra i percorsi viene dichiarata
nel task: nessun fallback automatico dopo un blocco.

Il motore e le sue prove devono restare disponibili in:
C:\AIOS_MIGRAZIONE\DWF06_Q01
Il clone della sola repository non ricrea questa dipendenza esterna.
Il pacchetto di ripartenza e il catalogo ne conservano sorgenti, pin e mappa.
Non cancellare o spostare quel percorso o le prove delle transazioni.

I file profile.json e admission.json contengono le regole e l'identita della
repository. Non certificano i permessi effettivi della sessione: i task
Check/Apply conservano ricevute, fonti, preimage e consensi propri.

Il launcher riceve i pin da un handoff chiuso, gia preparato da Work.
Info legge i collegamenti; Check non aggiorna documenti; Apply richiede
consenso esterno sullo specifico hash. Non riusare richieste consumate.

Versione in seconda riga, storico finale preservato nei documenti aggiornati.
Nuovi documenti, rinomine e nuove root richiedono un percorso specifico.
Su errore o esito ignoto: STOP, conservare prove e parziali, nessun retry,
cleanup o ripristino automatico.

## Storico modifiche

- v1.0 — 2026-10-17 — Collegamento alla release comune, configurazione locale,
  dipendenza esterna esplicita e convivenza con P6. Non attesta una Apply reale.
