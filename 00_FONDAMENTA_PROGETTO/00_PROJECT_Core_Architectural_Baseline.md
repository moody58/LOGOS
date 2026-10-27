# LOGOS — Baseline architetturale del Core
Versione: v1.0

Data: 2026-10-27  
Nodo: `CP-LOGOS-DOC-BASELINE-ARCH-20261027-04`  
Pathname: `00_FONDAMENTA_PROGETTO/00_PROJECT_Core_Architectural_Baseline.md`  
Repository di riferimento: `moody58/LOGOS` · branch `main` · snapshot `ecd6c8516981f3ce8e1ccf4ea24dda6190fd82ca`

## 1. Scopo, autorità e limiti

Questa baseline consolida le decisioni architetturali, le evidenze storiche recuperate e i limiti della valutazione del Core universale LOGOS. Serve a preservare contesto e provenienza per il lavoro successivo, evitando di ripetere analisi e prove già valide.

La baseline è subordinata alla gerarchia documentale LOGOS. Non sostituisce System, State, Roadmap, Gap Register, documenti tecnici madre o checkpoint originali e non modifica la loro autorità. Non attesta lo stato live di Retool o Supabase e non certifica readiness produttiva. La natura stabile e il pathname sono approvati dalla decisione della Regia «RETTIFICA TARGET BASELINE ARCHITETTURALE» del 27 ottobre 2026, riferita al nodo indicato in intestazione.

Le etichette usate sono:

- **APPROVATO** — decisione riportata come approvata dalla Regia nelle fonti conversazionali acquisite.
- **DOCUMENTATO** — descrizione presente in una fonte canonica o nel rapporto di idoneità.
- **VERIFICATO LIVE STORICAMENTE** — osservazione o prova riferita da un checkpoint precedente, con il suo perimetro e i suoi limiti.
- **NON VERIFICATO** — non attestato da prove sufficienti o non interrogato nelle acquisizioni documentali del 27 ottobre 2026.
- **CANDIDATO / DA DECIDERE** — raccomandazione o delta proposto, non approvato come implementazione.
- **NON IMPLEMENTATO** — la fonte non attesta che la capacità sia presente nel runtime.
- **NON AUTORIZZATO** — intervento che richiede un mandato o un consenso successivo.

Un PASS di sessione, una decisione architetturale, un’implementazione, un collaudo operativo e una pubblicazione sono stati distinti. Un PASS documentale non equivale a readiness produttiva.

## 2. Snapshot e manifest delle fonti

### Binding GitHub

Repository documentale: `moody58/LOGOS`. Snapshot di provenienza: branch `main`, commit `ecd6c8516981f3ce8e1ccf4ea24dda6190fd82ca`. Le fonti repository elencate sotto sono state acquisite tramite connettore GitHub allo stesso SHA. I digest riportati per i file GitHub sono gli identificativi blob Git restituiti dal connettore, non hash SHA-256 dei contenuti. Questo riferimento identifica lo snapshot documentale e non certifica lo stato dei servizi applicativi.

### Fonti documentali canoniche

| Percorso | Versione/data dichiarata | Blob Git | Acquisizione e completezza |
|---|---|---|---|
| `UNIVERSAL_PROJECT_RUNTIME_INSTRUCTIONS.md` | v1.6 · 2026-10-21 | `98fd70de48f1f5427cc3ed99e896fb5ad82ebe9b` | GitHub allo SHA fissato; contenuto completo acquisito |
| `00_FONDAMENTA_PROGETTO/00_PROJECT_KERNEL_MANIFEST.md` | v06 · 2026-10-16 | `385774f66a10f5be3f71713d924da6f4bf0fc8c4` | GitHub allo SHA fissato; contenuto completo acquisito |
| `98_SISTEMA_TECNICO/98_PROJECT_Session_Management_Protocol.md` | v1.2 · 2026-10-18 | `f20276dc9061e4f1d6a74ba68e514e0a0518a126` | GitHub allo SHA fissato; contenuto completo acquisito |
| `00_FONDAMENTA_PROGETTO/00_PROJECT_State.md` | v34 · 2026-10-16 | `56dc728fa9d7a5224a6ae8398f5d6a1beb048ca2` | GitHub allo SHA fissato; file completo acquisito. Stato documentale storico, non stato live |
| `00_FONDAMENTA_PROGETTO/00_PROJECT_Roadmap.md` | v25 · 2026-10-15 | `4c30998e17ab983df60b128ea4b3a9645c0c9a93` | GitHub allo SHA fissato; file completo acquisito. Non preassegna il nodo confermato successivamente |
| `98_SISTEMA_TECNICO/98_PROJECT_RUNTIME.md` | v1.6 · 2026-10-21 | `47bc3a3899215035b505fe57891ef67bbb7c6d63` | GitHub allo SHA fissato; contenuto completo acquisito |
| `98_SISTEMA_TECNICO/98_PROJECT_File_System_Guide.md` | — | `95d405bc3401fe53d818099c0f29331943464ee2` | GitHub allo SHA fissato; acquisito nel lotto di boot/procedura |
| `98_SISTEMA_TECNICO/98_PROJECT_Sistema_Fonti.md` | v1.0 | `c8f4001d2d71f97e14f4f7b8a568c8633852c20e` | GitHub allo SHA fissato; acquisito nel lotto di boot/procedura |
| `00_FONDAMENTA_PROGETTO/00_PROJECT_Regia.md` | v03 · 2026-10-18 | `b27bcaa9c7d4785ee98627f6a7d9f29cd984df99` | GitHub allo SHA fissato; acquisito nel lotto di boot/procedura |

Il Kernel distingue documentazione consolidata, allegati e stato live. Il checkpoint `CHECKPOINT_FONTI_CANONICHE_BOOT_CONTROLLATO.md` riguarda fonti e configurazione; non sostituisce i checkpoint architetturali identificati nella matrice seguente.

### Manifest delle fonti conversazionali A–G

| Fonte | Identificativo/titolo e data | Mezzo di recupero | Completezza e informazioni acquisite | Limiti |
|---|---|---|---|---|
| A | Discussione `LOGOS - REGIA`, decisioni del 25–27 ottobre 2026 | `read_thread` e blocco d’apertura allegato alla presente richiesta | Parziale: checkpoint C1/C2 e decisioni riportate nel mandato; approvazione della valutazione favorevole con condizioni, del Modello A e del nodo baseline. Decisione «RETTIFICA TARGET BASELINE ARCHITETTURALE» del 27 ottobre 2026 trasferita integralmente dall’utente: approvati pathname e natura stabile della baseline | La conversazione Regia completa non è stata acquisita integralmente; il blocco d’apertura resta il riferimento ricevuto per il mandato e non prova letture diverse da quelle dichiarate |
| B | `CP-LOGOS-ARCH-CORE-IDONEITA-20261027-02`, rapporto del 27 ottobre 2026 | Allegato `Testo incollato(20261027-082524).txt` recuperato dalla chat Regia | Rapporto completo come allegato: esito, cinque dimensioni, quattro delta, componenti da conservare, vincoli di release, STP e raccomandazione. Due copie recuperate coincidono nei byte e nel contenuto: 30.386 byte, 520 righe totali, 320 non vuote | Il confronto attesta l’identità delle due copie recuperate, non di fonti ulteriori non disponibili |
| C | `CP-LOGOS-ARCH-ISTANZA-20261027-01`, checkpoint `CONTRATTO DI ISTANZA C1/C2`, 27 ottobre 2026 | Messaggio checkpoint disponibile nella discussione `LOGOS - REGIA` | Completo per le dodici invarianti e per la candidatura del Modello A; il checkpoint dichiara che l’approvazione della Regia è ancora pendente | La successiva approvazione di C1/C2 è riportata dal blocco d’apertura (fonte A), non dal checkpoint C. Implementazione e verifica live restano distinte |
| D | `CP-LOGOS-FATTIBILITA-E2E-20261025-01`, discussione `Qualifica fattibilità LOGOS` | `read_thread` sui turni accessibili; riferimenti riassunti nel checkpoint C e nel rapporto B | Parziale: ricevuti riferimenti P3 routing dinamico sperimentale, P4 connessione PostgreSQL Session Pooler per BI distinta da `supabase_api`, P5 Export/Replace PASS su app semplice e relativi limiti | Checkpoint conclusivo E2E, dettagli P2 e allegati P5 non sono disponibili nella cronologia acquisita; nessun test storico è stato ripetuto |
| E | `Ricognizione strategica LOGOS e ripresa dello sviluppo`, checkpoint e rettifica del 25 ottobre 2026 | `read_thread` con turni recenti e riferimenti nel mandato | Parziale: il mandato indica le decisioni da preservare su scopo universale, ASPRI/ADEXIMA, input libero, Event Ledger, report, qualità dati e sequenza Core → istanze | I checkpoint originali del 25 ottobre non sono stati recuperati integralmente; non si ricostruiscono dettagli mancanti dalla memoria |
| F | `Confronto istruzioni Logos Aios`, fonte metodologica | `read_thread` con messaggi recenti | Parziale; non utilizzata a fondamento delle decisioni architetturali consolidate | Non aggiunge prove sul runtime applicativo |
| G | `Analisi metodo AIOS LOGOS`, fonte secondaria | Titolo e messaggi recenti disponibili tramite `read_thread` | Non usata per conclusioni architetturali di questa baseline | Esclusa per non aprire un audit metodologico trasversale |

La matrice distingue ciò che è stato acquisito da ciò che è soltanto richiamato. Nessuna conversazione mancante è ricostruita. I limiti relativi a P2 e ai checkpoint D/E restano visibili e non sono promossi a evidenza.

## 3. Decisioni architetturali approvate

### Identità e destinazione

- **APPROVATO:** LOGOS è un Event Operating System universale, sviluppato come Core comune.
- **APPROVATO:** ASPRI e ADEXIMA sono destinate a essere due installazioni indipendenti dello stesso Core versionato, non un sistema multi-tenant con database condiviso.
- **APPROVATO:** ciascuna installazione ha database Supabase e risorse Retool propri; `logos_template` resta ambiente di sviluppo fino alla qualifica del Core e della replica.
- **APPROVATO:** il Core comune non richiede routing dinamico a runtime; l’installazione si lega al proprio backend con configurazione fissa e fail-closed.
- **APPROVATO (secondo il successivo blocco della Regia):** Modello A e dodici invarianti C1/C2 sono approvati come contratto architetturale. Il checkpoint C originale conteneva la candidatura e indicava l’approvazione come pendente. Implementazione e verifica live non sono attestate.
- **APPROVATO:** il limite Supabase Free di due progetti attivi e i privilegi ampi degli utenti Retool Free sono vincoli conosciuti e accettati per il perimetro discusso. Non riaprire tali valutazioni in questa baseline.
- **APPROVATO:** `logos_template` potrà essere sospeso nell’assetto finale; la strategia di sviluppo e ripristino successiva deve restare sostenibile.

### Dodici invarianti C1/C2

Il checkpoint C1/C2 le riporta come segue. Sono requisiti approvati, non prove d’implementazione:

1. Identificativo logico d’istanza stabile, associato al project ref Supabase autorevole.
2. Binding dell’istanza definito e validato nella configurazione di deployment.
3. Configurazione tecnica separata dai dati utente.
4. Risorse e credenziali specifiche dell’installazione.
5. Database indipendenti, senza autorizzazioni incrociate.
6. Distinzione fra autenticazione Retool, autorizzazione applicativa, permessi Supabase e amministrazione.
7. Backend d’installazione fissato; nessun selettore utente del database.
8. Letture, scritture e refresh riferiti allo stesso backend autorizzato.
9. Configurazione mancante o invalida: blocco delle operazioni dipendenti.
10. Nessun fallback automatico verso `logos_template` o un’altra istanza.
11. Differenze fra istanze limitate alla configurazione prevista, non alle logiche Core comuni.
12. Aggiornamenti futuri subordinati alla conservazione del binding e alla compatibilità della release.

### Regole d’uso preservate

- **APPROVATO:** input libero assistito e completamento guidato sono modalità distinte; non si attiva ora una guided event mode completa.
- **DOCUMENTATO:** Event Ledger, conferma umana, `Project`, `Entity`, `Type`, matching e persistenza costituiscono la base del Core descritto nelle fonti canoniche.
- **APPROVATO:** ASPRI/ADEXIMA non introducono logiche verticali nel Core comune. Le installazioni derivano dal Core stabilizzato.

## 4. Architettura documentata e valutazione

Il rapporto B conclude che il Core è conservabile e concettualmente compatibile con un motore universale, ma non ancora qualificato per la distribuzione definitiva. La valutazione architetturale è favorevole con condizioni; non è una certificazione produttiva.

### Componenti documentati da preservare

- Stack Retool + Supabase.
- Input libero, interpretazione controllata e `raw_input` preservato.
- Parsing, normalizzazione, matching e disambiguazione umana già documentati.
- `Project` come contenitore operativo e `Entity` come soggetto coinvolto.
- `Type` come natura dell’oggetto; `parent` come gerarchia stabile futura; `metadata` come estensione guidata futura.
- Conferma esplicita prima del salvataggio e flussi esistenti `insert_event`, `update_event` e gestione dei `NEW`.
- Classificazione base `Evento / Spesa / Incasso / Tempo` e durate certe espresse in minuti.
- Separazione fra logiche comuni del Core e configurazione per installazione secondo C1/C2.

Il rapporto non indica ragioni dimostrate per sostituire lo stack, creare un database condiviso, introdurre multi-tenancy, spostare tutta la logica applicativa fuori da Retool o ricominciare il sistema. Gli scenari rappresentativi nel rapporto comprendono input libero e registrazioni Event Ledger; per ASPRI prenotazione, cliente, animale, acconti e scadenze; per ADEXIMA commessa, materiali, ore e incassi; in entrambi i casi servono dati coerenti e report affidabili.

### Quattro delta minimi candidati

I delta seguenti sono **CANDIDATI / DA DECIDERE**. Sono aspetti di un debito architetturale comune, non quattro nodi aperti né autorizzazioni all’implementazione.

| Delta | Evidenza documentata | Esigenza da chiarire | Dipendenze e limite |
|---|---|---|---|
| 1 — Definitività e rettifica del ledger | Le modifiche ai `NEW` sovrascrivono; non è documentato uno storico revisioni; `WRITTEN`/`ERROR` sono terminali nella specifica; la RPC di cambio stato non documenta controlli completi sulle transizioni | Definire `NEW` come provvisorio, criteri d’inclusione nei report e semantica di rettifica post-validazione preservando l’originale e il collegamento | Event Lifecycle, schema, relazione fra registrazioni e confine di scrittura; non implica eliminare `update_event` sui `NEW` |
| 2 — Correlazione universale | Un evento ha un singolo `project_id` e `entity_id`; `reference_id` è documentato come non operativo; `parent` e `metadata` non sono relazioni core occasionali | Definire associazioni e correlazione minima fra eventi/soggetti, con significato, cardinalità e stabilità, senza introdurre schemi verticali | Dipende dalla policy Project/Entity, dal Delta 1 e dallo schema effettivo; eventuali campi nuovi devono derivare dal contratto |
| 3 — Integrità del confine dati | Il rapporto documenta assenza di foreign key per `events.project_id`/`entity_id`, validazioni forti non attestate per `status`/`type` e controlli incompleti delle transizioni nella RPC | Qualificare le invarianti delle scritture e valutare vincoli relazionali o guardie mirate senza trasferire tutta la logica a Supabase | Dipende dai Delta 1–2, dallo schema effettivo, dai dati esistenti e dalle query; nessuna modifica DB è approvata qui |
| 4 — Release, replica e continuità | Specifiche e manifest documentali sono versionati; P5 copre un’app semplice; il Core completo non ha una release qualificata nelle fonti | Fissare Core comune/configurazioni, artefatti versionati, compatibilità schema, migrazioni, backup, test e ripristino | Dipende da C1/C2 e dai primi tre delta; non comporta necessariamente riscrittura Retool |

Ordine logico proposto dal rapporto: prima semantica del ledger e correlazione, poi integrità, quindi distribuzione e aggiornamenti controllati. Il rapporto raccomanda un intervento minimo sui contratti prima delle funzionalità che dipendono da tali dati; la Regia deve decidere scope e sequenza. Questa baseline non apre quel lavoro.

### STP conclusivo già svolto

- **Livello 1 — Coerenza interna:** favorevole con condizioni. Il modello Retool + Supabase, le entità Project/Entity/Event e le due installazioni indipendenti sono compatibili; integrità e correlazione necessitano però di contratti affidabili.
- **Livello 2 — Tesi opposta e scenario limite:** una prenotazione con più acconti o una registrazione economica già validata ma errata non è sufficientemente rappresentata/corretta dal contratto oggi documentato. Il rischio è reale e va affrontato, ma è circoscritto ai contratti dati e non prova che l’architettura generale sia da rifare.
- **Livello 3 — Simulazione esterna:** scenari ragionati, non test con utenti esterni. Un acconto ASPRI potrebbe essere associato alla prenotazione errata; una marginalità ADEXIMA potrebbe essere alterata da eventi non validati o rettifiche non collegate; due release manualmente divergenti potrebbero rivelare incompatibilità dopo l’uso.
- **Conclusione:** consolidare il Core esistente; non sostituirlo né anticipare verticalizzazioni. Il livello 3 è simulazione, non prova empirica.

Il rapporto indica inoltre come futuro controllo discriminante per affermare la replicabilità effettiva un confronto mirato dell’export completo dell’app Retool usata con il manifest documentato, per individuare dipendenze da risorse/endpoint. La baseline non attesta che tale confronto sia stato eseguito.

## 5. Matrice delle evidenze e riuso

| Requisito/decisione | Prova disponibile | Origine | Risultato classificato | Limite | Riuso ammesso |
|---|---|---|---|---|---|
| Core comune per due istanze indipendenti | Rapporto di idoneità e checkpoint C1/C2 recepiti dalla Regia | Fonti B e C, 27 ottobre 2026 | **APPROVATO** con readiness architetturale condizionata | Non certifica release né produzione | Non ripetere il confronto generale A/B senza nuovo elemento verificabile |
| Configurazione per istanza, database/risorse indipendenti | Dodici invarianti C1/C2 e successiva decisione riportata | Fonte C per la candidatura/invarianti; fonte A per l’approvazione successiva | **APPROVATO** come contratto | Implementazione e verifica live **NON VERIFICATE** | Usare come requisito per future specifiche; non ricalcolare il Modello A |
| Routing dinamico | P3 riferito nel checkpoint C | Fonte C; prova storica P3 | **VERIFICATO LIVE STORICAMENTE** nel perimetro sperimentale | Non dimostra necessità né sicurezza di routing di produzione | Non ripetere P3; il Modello A non lo richiede |
| Connessione BI via PostgreSQL Session Pooler | P4 riferito nel checkpoint C | Fonte C; prova storica P4 | **VERIFICATO LIVE STORICAMENTE** per connessione BI | Distinta dalla risorsa REST Retool `supabase_api`; non certifica altre connessioni | Non ripetere P4 per il presente nodo |
| Export/Replace | P5 PASS su app semplice, riportato in C e B | Fonti B/C; prova storica P5 | **VERIFICATO LIVE STORICAMENTE** sul caso provato | Non qualifica export/replace del Core completo; JSON P5.J/P5.L non importati. C riferisce di preservare l’app originale `Logos`, di avere `LOGOS_TEST_ROUTIN` come app sperimentale non distribuibile e `LOGOS_REPLACE_TEST` non cancellata. Gli ID tecnici delle app non sono riportati nelle fonti acquisite | Non ripetere P5; non usarlo come certificazione di release universale |
| P2 | Il mandato richiede tracciabilità P2–P5 ma il checkpoint P2 non è stato recuperato | Fonte D indicata, non disponibile | **NON VERIFICATO IN QUESTA BASELINE** | Esito e confini P2 non vengono ricostruiti | Recuperare solo il checkpoint P2/E2E originale se una decisione dipende da esso |
| Export completo dell’app Retool e release comune | Rapporto propone un confronto futuro discriminante | Fonte B | **CANDIDATO / DA DECIDERE** | Nessuna verifica effettuata in questo nodo | Considerare solo in un mandato futuro con domanda e criterio di arresto espliciti |
| Readiness produttiva ASPRI/ADEXIMA | Nessun collaudo completo o verifica live disponibile qui | B/C e mandato | **NON VERIFICATO** | Credenziali, autorizzazioni, isolamento live, backup/restore e deploy completi non attestati | Non dichiarare produzione pronta |
| Retool e Supabase allo stato corrente | Nessuna lettura live eseguita per questo nodo documentale | Limite di sessione | **NON VERIFICATO** | Snapshot GitHub non congela i servizi | Nessuna verifica live estranea a un futuro nodo |

Le prove P2–P5 sono storiche e non sono state rieseguite. Non aggiungere log, screenshot, JSON, query o report duplicati a questa baseline.

## 6. Condizioni aperte e ciò che resta non verificato

Rimangono condizioni, non nuove decisioni strategiche:

- contratto per eventi provvisori, definitivi e rettifiche;
- correlazione universale fra registrazioni collegate;
- invarianti e garanzie effettive al confine di persistenza;
- contenuto e compatibilità della release completa Retool;
- evoluzione schema e migrazioni compatibili;
- backup, ripristino e continuità dopo sospensione dell’ambiente di sviluppo;
- isolamento effettivo dei database e binding per installazione;
- qualifica end-to-end degli aggiornamenti su entrambe le installazioni;
- dettagli P2 e checkpoint E2E non recuperati;
- implementazione live del contratto C1/C2.

Nessuna di queste condizioni è trasformata in PASS dalla documentazione o dalle prove limitate P3–P5. Nessuna lettura Retool o Supabase è stata effettuata nelle acquisizioni documentali del 27 ottobre 2026.

## 7. Continuità e anti-deriva

Le decisioni approvate e le prove storiche valide si riutilizzano. Si riaprono soltanto quando compare un nuovo elemento verificabile che può cambiare la conclusione. In particolare:

- nessuna riapertura automatica della fattibilità generale;
- nessuna ripetizione automatica delle prove P2–P5;
- nessuna riapertura del confronto Modello A contro routing dinamico;
- nessuna implementazione automatica dei Delta 1–4;
- nessun refactor generale, nuova proposta di schema o verticalizzazione anticipata;
- nessun nuovo nodo attivato dai candidati storici;
- ogni nuova prova deve indicare la domanda discriminante e il criterio di arresto;
- ogni aggiornamento di questa baseline deve riferirsi a una decisione e a fonti identificabili.

La baseline non costituisce una nuova Roadmap operativa o un calendario.

## 8. Provenienza e storico

### Manifest sintetico

- **Snapshot canonico:** `moody58/LOGOS` · `main` · `ecd6c8516981f3ce8e1ccf4ea24dda6190fd82ca`.
- **Fonti canoniche decisive:** Runtime Instructions v1.6; Kernel Manifest v06; Session Management Protocol v1.2; State v34; Roadmap v25; Runtime documentale v1.6; File System Guide e documento Regia allo stesso SHA.
- **Checkpoint conversazionali:** rapporto di idoneità allegato; checkpoint C1/C2 nel thread Regia; checkpoint E2E/P2 non integralmente disponibile; fonti strategiche E solo parzialmente recuperate.
- **Stato live:** Retool e Supabase **NON VERIFICATI** nelle acquisizioni documentali del 27 ottobre 2026.
- **SHA-256 del rapporto B acquisito:** `1d0169f19b2fe42a83c9eecb2203b0e93749e6501c95a00fc1ace892b63f1dc5` (calcolato sulla copia allegata locale, non dichiarato come hash originario dal rapporto).

### Storico revisioni

| Versione | Data | Contenuto |
|---|---|---|
| v1.0 | 2026-10-27 | Prima baseline: decisioni approvate, architettura documentata, prove recuperate, condizioni aperte e limiti di provenienza. Pathname e natura stabile secondo la rettifica della Regia del 27 ottobre 2026. |

