# AIOS Project Reference

Questo progetto è stato creato utilizzando il template universale AIOS.

## Procedura documentale LOGOS e fonti AIOS_CORE

Versione di questa integrazione: v1.0 — integrazione del 2026-10-14.

Il documento madre operativo locale è
[98_PROJECT_RUNTIME.md](98_SISTEMA_TECNICO/98_PROJECT_RUNTIME.md).
Contiene attivazione, ruoli Work/Codex, archivi, messaggi rapidi e dipendenze.
Le istruzioni AIOS_CORE non diventano automaticamente istruzioni di LOGOS.

Fonti di derivazione verificate allo SHA 23e9305f538554fa952d3dd2c65d46d7c38eb174:

- [Manuale AIOS Codex v1.2](https://github.com/moody58/AIOS_CORE/blob/23e9305f538554fa952d3dd2c65d46d7c38eb174/05_WORKSPACE/05_AIOS_Codex_Procedura_Documentale_e_Piano_Operativo.md): flusso §5, attivazione §6, pacchetti §7, snapshot §8 e ripartenza §13.
- [Contratto Safe Document Apply v0.6](https://github.com/moody58/AIOS_CORE/blob/23e9305f538554fa952d3dd2c65d46d7c38eb174/02_PROTOCOLS/02_AIOS_Codex_Safe_Document_Apply.md): invarianti, approvazioni, recovery e Verify.

Versioni e prove storiche sono riferimenti di provenienza, non autorizzazioni
a eseguire vecchi launcher. LOGOS conserva fonti, percorsi, profilo e release propri.

## Architettura del sistema

AIOS governa il metasistema dei progetti. I progetti operano in modo
autonomo ma restano collegati ad AIOS tramite le rispettive Regie.

Schema architetturale:

AIOS (governance e metodo) ↓ PROGETTO (sviluppo operativo) ↓ LOGOS
(raccolta e analisi dati)

AIOS e i progetti comunicano tramite aggiornamento delle Regie.
