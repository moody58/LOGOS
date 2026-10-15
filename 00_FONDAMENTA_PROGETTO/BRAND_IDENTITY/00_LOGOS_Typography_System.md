# 00_LOGOS_Typography_System — LOGOS Sistema tipografico

**Documento canonico previsto:** `00_LOGOS_Typography_System.md`  
**Versione:** `v1.1` — recepimento documentale della decisione v1.0 del 2026-10-09, candidato  
**Data della decisione:** 09 ottobre 2026  
**Recepimento documentale predisposto:** 15 ottobre 2026  
**Ambito:** identità tipografica e criteri di leggibilità del progetto LOGOS (Event Operating System)  
**Stato decisionale:** **APPROVATO** per l'identità tipografica; **implementazione Retool e conformità WCAG AAA da validare**.  
**Fonte decisionale:** confronto progressivo fra Atkinson Hyperlegible Next, Inter, Geist Sans, IBM Plex Sans, Source Sans 3 e Public Sans; laboratori HTML 01, 02, 03 e correzione 03.1; valutazioni dell'utente in questa sessione.  
**Relazione con AIOS:** parentela visiva e metodologica preservata; l'interfaccia LOGOS adotta una famiglia proporzionale diversa da Geist Sans di AIOS per esigenze operative proprie.

> **Principio guida:** prima riconoscere correttamente nomi, cifre, importi e stati; poi ottimizzare densità e resa estetica. Non ridurre il carattere per ottenere più righe se la riconoscibilità peggiora.

## 00 / Decisione ufficiale

| Ruolo | Famiglia | Regola |
|---|---|---|
| UI primaria: titoli, testo, input, tabelle, KPI, dashboard | **Source Sans 3** | Famiglia proporzionale unica del prodotto; pesi 400 / 500 / 600 / 700 |
| Identificativi, codice, comandi, log, stringhe macchina | **IBM Plex Mono** | Usare selettivamente, preferendo i pesi 400 / 500 |
| Wordmark e simbolo LOGOS | **Artwork proprietario approvato** | Non ricostruire con font né modificare geometria e proporzioni |
| Fallback sans | Font di sistema compatibile | Da verificare su ambiente/dispositivo; non sostituire silenziosamente il brand font nei test |
| Fallback mono | Font monospaziato di sistema | Preservare allineamento e riconoscibilità |

**Decisione consolidata:** Source Sans 3 + IBM Plex Mono. Inter rimane il parametro comparativo, **non** una seconda famiglia ufficiale da alternare arbitrariamente nei componenti. La scelta riguarda il sistema tipografico LOGOS e non modifica i font approvati per AIOS.

### Motivazioni derivate dalle prove

- **Inter:** preferito per la sensazione di leggibilità generale e la lettura prolungata; permangono ambiguità percepite fra alcuni caratteri nella configurazione provata.
- **Source Sans 3:** preferito per distinzione di nomi/testi rispetto a Inter e per compattezza percepita su dashboard, KPI e mobile a parità di dimensione nominale; il vantaggio non è una misura universale e va ricontrollato su componenti reali.
- **Atkinson Hyperlegible Next:** elevata distinguibilità, ma zero percepito come invasivo e minore comfort/resa numerica nei test personali; non adottato.
- **Geist Sans:** buona distinzione ma forme percepite come troppo arrotondate; resta il font AIOS e non viene adottato per LOGOS.
- **IBM Plex Mono:** confermato per contenuti tecnici, già coerente con il livello monospace AIOS.

Le prove erano **valutazioni comparative esplorative**, non studi clinici di affaticamento visivo, né test di conformità WCAG eseguiti sulla vera applicazione.

## 01 / Ruoli, pesi e gerarchie

### Famiglia proporzionale: Source Sans 3

| Elemento | Peso previsto | Criterio |
|---|---:|---|
| Testo normale, descrizioni, testo dei form | 400 | Prima la lettura, nessuna densità forzata |
| Menu, etichette, valori secondari | 500 | Distinzione senza eccesso di massa |
| Titoli card, pulsanti primari, intestazioni tabella | 600 | Gerarchia stabile e riconoscibile |
| Titoli principali e KPI in evidenza | 700 | Limitare ai livelli primari |

### Famiglia monospaziata: IBM Plex Mono

Applicare solo a stringhe tecniche nelle quali la larghezza costante dei caratteri porta beneficio: `event_id`, `project_id`, `entity_id`, query SQL, flag, payload, riferimenti e blocchi di codice. **Non** convertire intere liste eventi, paragrafi, menu o descrizioni in monospace.

Per **importi e numeri ordinari** la prima scelta resta Source Sans 3 con **cifre tabulari**, non IBM Plex Mono: si conserva coerenza nel resto della UI riducendo disallineamenti fra colonne.

### Scala iniziale di progetto — desktop e mobile

La tabella è una **specifica iniziale di design da convalidare nella UI reale**, non una dimensione obbligatoria imposta da WCAG.

| Ruolo | Mobile | Desktop / dashboard | Peso | Line-height suggerita |
|---|---:|---:|---:|---:|
| H1 pagina | 25–28 px | 30–34 px | 700 | 1.18–1.25 |
| H2 sezione | 21–23 px | 24–27 px | 600 | 1.25–1.3 |
| H3 / titolo card | 18–20 px | 19–21 px | 600 | 1.3–1.4 |
| Body / descrizione evento | **17 px** | 16–17 px | 400 | 1.5–1.6 |
| Input e selettori | **16–17 px** | 16 px | 400–500 | 1.45–1.55 |
| Bottoni e navigazione | 16 px | 15–16 px | 600 | 1.35–1.5 |
| Label di campo | 15–16 px | 14–15 px | 500 | 1.35–1.5 |
| Tabelle / liste | 15–16 px | 14–16 px | 400–500 | 1.45–1.55 |
| Valori KPI | 25–30 px | 30–38 px | 700 | 1.12–1.2 |
| Caption / metadati | 14 px | 13–14 px | 400 | 1.4–1.5 |
| Codici e stringhe tecniche | 14–16 px | 13–15 px | Mono 400–500 | 1.5–1.6 |

**Limiti operativi:**

1. Su iPhone Safari, evitare input con `font-size` inferiore a **16 CSS px** per ridurre il rischio di autozoom quando ricevono il focus (misura pratica, non requisito WCAG).
2. **14 px** è una prova di stress legittima, ma non deve diventare il default del testo operativo principale per risparmiare spazio.
3. Se lo spazio è insufficiente, prima utilizzare impaginazione responsive, priorità dei dati, righe adattive, dettagli espandibili e abbreviazioni esplicite; non ridurre automaticamente la dimensione del font.
4. I pesi effettivamente disponibili e la resa in piattaforma devono essere verificati prima di fissare la scala nel tema Retool.

## 02 / Numeri, nomi e glifi ambigui

### Test di riconoscibilità obbligatorio

```text
I l 1 i  |  O 0 o  |  B 8  |  S 5  |  rn m
Cliente Olio O11  |  Cliente 0l1O
INV-01O5-I1l0  |  C-00B8-S5
€ 1.080,50  |  € 10.800,05  |  € 808,08
08/10/2026  |  08:03  |  18:30
NEW  |  WRITTEN  |  ERROR
Entità  |  quantità  |  unità  |  à è ì ò ù
```

**Regole:**

- Non basare la distinzione fra record simili soltanto sulla forma dei glifi: nei contesti critici mostrare anche tipo, contesto e/o una porzione utile del codice.
- Nelle tabelle attivare cifre tabulari (`font-variant-numeric: tabular-nums lining-nums`) e allineare gli importi a destra.
- Non usare un font condensato o tracking negativo come scorciatoia per aumentare densità di KPI.
- La variante OpenType di Source Sans 3 con **I maiuscola alternativa**, quando supportata nel file effettivo, può essere valutata per codici/nomi simili; **non viene imposta globalmente in v1.0**, perché disponibilità e supporto in Retool non sono ancora certificati.
- Zero barrato **non obbligatorio**: l'utente ha esplicitamente rifiutato l'effetto percettivo dello zero di Atkinson.

## 03 / Applicazione a LOGOS

| Superficie | Regola |
|---|---|
| Input rapido evento | Source Sans 3 16–17 px; hint e warning separati visivamente; niente testi tagliati |
| Project / entity matching | Nomi completi quando possibile, supporto contestuale, codici in IBM Plex Mono quando utili |
| Lista eventi | Titolo riconoscibile, metadati secondari, importo con tabular nums, stato non solo cromatico |
| Dashboard e KPI | Source Sans 3 per titoli e valori; unità e assi leggibili; serie e legenda distinguibili anche senza colore |
| SQL / log tecnici | IBM Plex Mono per sola sintassi o valori macchina; scorrimento controllato dei blocchi lunghi |
| Safari / web mobile | Dimensionamento del testo, reflow e focus senza perdita dati o autozoom evitabile |
| Documentazione di prodotto | Source Sans 3 per coerenza; IBM Plex Mono solo nei blocchi di codice |

**Futura dashboard**: le indicazioni sono requisiti tipografici; non implicano che dashboard o KPI siano già stati implementati nel runtime Retool/Supabase.

## 04 / Accessibilità — target WCAG 2.2 AAA

**ATTENZIONE: nessuna famiglia di font può essere dichiarata di per sé “WCAG AAA”.** La conformità riguarda le pagine e i flussi effettivi; LOGOS adotta AAA come **obiettivo di progettazione e collaudo**, non come risultato già certificato.

| Verifica | Riferimento | Obiettivo applicativo |
|---|---|---|
| Contrasto testo ordinario | WCAG 1.4.6 (AAA) | **Almeno 7:1** fra testo e sfondo effettivi |
| Contrasto testo grande | WCAG 1.4.6 (AAA) | **Almeno 4.5:1** nei casi previsti |
| Testo ingrandibile | WCAG 1.4.4 (AA) | Fino al **200%** senza perdita di contenuto/funzione |
| Reflow | WCAG 1.4.10 (AA) | Larghezza equivalente a **320 CSS px** senza scorrimento bidimensionale, salvo eccezioni ammesse |
| Spaziatura testo | WCAG 1.4.12 (AA) | Nessuna perdita applicando 1.5 line-height, 2x paragrafi, .12em lettere, .16em parole |
| Presentazione blocchi testo | WCAG 1.4.8 (AAA) | Meccanismo per adattare colori, larghezza, spaziatura e zoom; non giustificare il testo |
| Target cliccabili | WCAG 2.5.5 (AAA) | Dimensione almeno **44×44 CSS px** salvo eccezioni del criterio |
| Codifica degli stati | WCAG 1.4.1 (A) | Colore mai unico indicatore di NEW / WRITTEN / ERROR |

**Contrasto e palette:** non cambiare automaticamente la palette terracotta ufficiale per applicare il nuovo font. Usare token foreground/background già approvati oppure definire un adeguamento in un nodo colore separato, verificando il rapporto sul **componente reale**, sia light sia dark. La tinta di marca non è necessariamente idonea come colore di testo.

### Leggibilità effettiva e affaticamento

- Verificare lettura continua di **10 minuti o più** di descrizioni, liste e stati; le prove esplorative di durata inferiore non misurano fatica prolungata.
- Su mobile testare **320, 360, 390, 430 CSS px**, oltre al 200% di ingrandimento e alle preferenze di accessibilità del dispositivo.
- Controllare che etichette e messaggi restino leggibili con aumenti di testo, senza tagli, sovrapposizioni o campi troppo bassi.
- Adottare `line-height` non compressi; usare un massimo indicativo di **60–75 caratteri** per riga nei testi di lettura prolungata. Per AAA 1.4.8 assicurare il meccanismo richiesto, non equiparare questa raccomandazione al requisito completo.
- VoiceOver, navigazione da tastiera, focus visibile, ordine di lettura e nomi accessibili sono verifiche applicative separate dal font.

## 05 / Implementazione tecnica di riferimento (NON applicata)

### CSS web di esempio — font self-hosted

```css
/* Percorsi esemplificativi: usare file WOFF2 originali verificati e licenze OFL. */
@font-face {
  font-family: "Source Sans 3";
  src: url("/assets/fonts/source-sans-3-variable.woff2") format("woff2");
  font-style: normal;
  font-weight: 400 700;
  font-display: swap;
}
@font-face {
  font-family: "IBM Plex Mono";
  src: url("/assets/fonts/ibm-plex-mono-regular.woff2") format("woff2");
  font-style: normal;
  font-weight: 400;
  font-display: swap;
}
@font-face {
  font-family: "IBM Plex Mono";
  src: url("/assets/fonts/ibm-plex-mono-medium.woff2") format("woff2");
  font-style: normal;
  font-weight: 500;
  font-display: swap;
}
:root {
  --logos-font-ui: "Source Sans 3", system-ui, -apple-system, "Segoe UI", sans-serif;
  --logos-font-code: "IBM Plex Mono", ui-monospace, "SFMono-Regular", Consolas, monospace;
}
body, input, select, textarea, button { font-family: var(--logos-font-ui); }
.logos-number, .logos-kpi { font-variant-numeric: lining-nums tabular-nums; }
.logos-code, code, pre { font-family: var(--logos-font-code); }
.logos-code { overflow-wrap: anywhere; }
```

**Nota:** pesi multipli in un unico file WOFF2 funzionano **solo** se il file usato è effettivamente variabile e copre gli assi dichiarati. Verificare il file prima del deploy; altrimenti usare `@font-face` separati per peso. Non importare nomi file presunti come se esistessero già in Retool.

### Retool Web / Retool Mobile

1. **Non modificare il runtime nella presente decisione.** Prima verificare, nella specifica organizzazione e sul piano realmente utilizzato, se è possibile configurare Source Sans 3 e IBM Plex Mono in modo stabile attraverso componenti/tema/CSS consentiti.
2. La disponibilità di temi e typography custom differisce tra **Retool Web**, **Retool Mobile** e piani commerciali: non assumere che un'impostazione del browser desktop valga anche nell'app nativa.
3. Evitare injection CSS fragili, dipendenze da CDN non necessarie e hack che alterano componenti interni non pubblici.
4. Se l'host impedisce i font custom, conservare come **requisito di progetto** il sistema Source Sans 3 / IBM Plex Mono, usare un fallback di sistema documentato e aprire una verifica tecnica dedicata; non dichiarare il deployment completato.
5. Dopo l'implementazione eseguire regression test di input, editing, conferma, dropdown, warning, lista, feedback, screenshot mobile/dark e liste dashboard future. Nessuna modifica a parser, matching, payload o Supabase deriva dalla tipografia.

## 06 / Distribuzione e licenze

- **Source Sans 3 (Adobe)** e **IBM Plex Mono (IBM)** sono progetti open source distribuiti sotto **SIL Open Font License 1.1**; controllare comunque i file e la versione effettivamente incorporati e conservare licenze/notice conformemente ai relativi termini.
- Preferire asset self-hosted WOFF2 con subset adatto ai caratteri realmente utilizzati (`it`, accenti, simboli €, punteggiatura e glifi tecnici); la creazione di subset richiede verifica e conformità alla licenza.
- Versionare la scelta tipografica e le **versioni dei font** nel repository del prodotto quando verranno effettivamente distribuite; evitare differenze silenziose fra PC, browser mobile e dashboard esterna.
- Un eventuale PDF del documento è una copia descrittiva di lettura, non uno specimen certificato con i due font. Nessuna copia PDF è inclusa nel presente pacchetto candidato; per approvare la resa visiva usare i font autentici in browser e applicazione.

## 07 / Piano di verifica e criteri di accettazione

| ID | Controllo | Stato attuale | Evidenza necessaria per chiudere |
|---|---|---|---|
| T01 | Scelta comparativa familiare | **Approvata** | Decisione di questa sessione / test 01–03.1 |
| T02 | Caricamento reale Source Sans 3 / Plex Mono in Retool | **Non verificato** | Screenshot + test font effettivamente applicato |
| T03 | Caratteri ambigui e form a 14/16/17 px | **Esplorato** | Verifica mobile Safari e web app con glifi reali |
| T04 | Tabular nums e allineamento dati | **Da verificare** | KPI e colonne con valori comparabili |
| T05 | WCAG AAA su light/dark | **Non certificato** | Audit componenti con misure e test interattivi |
| T06 | Ingrandimento, text spacing, reflow | **Da verificare** | Test 200%, 320 px, preferenze utente |
| T07 | Dashboard esterna | **Futuro** | Verifica famiglia font disponibile nel tool scelto |

**Criterio di chiusura del documento:** identità e regole tipografiche consolidate; T02–T07 rimangono condizioni di **deployment e conformità**, non riserve sulla scelta estetica già approvata.

## 08 / Tracciabilità, versionamento e fonti

### Changelog

| Versione | Data | Modifica |
|---|---|---|
| v1.0 | 09.10.2026 | Prima approvazione del sistema LOGOS: Source Sans 3 + IBM Plex Mono. Gerarchie, accessibilità, condizioni Retool, distribuzione e test futuri. |
| v1.1 (candidata) | 15.10.2026 | Allineamento di nomenclatura, sede canonica e provenienza della decisione v1.0; famiglie, pesi e criteri approvati invariati. |

### Origine delle decisioni

1. Base tipografica **AIOS**: Geist Sans + IBM Plex Mono; wordmark AIOS proprietario (discussione e documento ufficiale AIOS già confrontato).
2. **LOGOS**: scelta esplicita dell'utente dopo prove comparative; Source Sans 3 favorito per disambiguazione e compattezza; Inter favorito sui testi lunghi ma non selezionato.
3. Versione LOGOS deliberatamente differente dal font UI AIOS; wordmark LOGOS proprietario invariato.
4. **Fonte madre tipografica prevista:** questo documento, dopo recepimento verificato in `00_FONDAMENTA_PROGETTO/BRAND_IDENTITY/`; il semplice file candidato non attesta pubblicazione. **Non** sostituisce `00_PROJECT_State`, Roadmap, Kernel, documenti di runtime Retool/Supabase, né aggiorna automaticamente il repository GitHub.

### Fonti primarie di verifica

- Adobe Source Sans 3, repository e distribuzione: https://github.com/adobe-fonts/source-sans
- Adobe Source Sans 3, licenza OFL: https://github.com/adobe-fonts/source-sans/blob/release/LICENSE.md
- IBM Plex, progetto ufficiale: https://github.com/IBM/plex
- IBM Plex, licenza OFL: https://github.com/IBM/plex/blob/master/LICENSE.txt
- Retool, disponibilità dei piani: https://retool.com/pricing
- Retool, evoluzione temi/font: https://community.retool.com/t/new-updated-organization-and-app-theming/49434
- WCAG 2.2, contrasto migliorato (AAA): https://www.w3.org/WAI/WCAG22/Understanding/contrast-enhanced
- WCAG 2.2, spaziatura testo: https://www.w3.org/WAI/WCAG22/Understanding/text-spacing
- WCAG 2.2, reflow: https://www.w3.org/WAI/WCAG22/Understanding/reflow
- WCAG 2.2, presentazione visiva (AAA): https://www.w3.org/WAI/WCAG22/Understanding/visual-presentation

### CQD / consegna

- Documento **nuovo**, non sostituisce una precedente versione ufficiale LOGOS inesistente in questo perimetro.
- Identità approvata / runtime invariato / accessibilità e disponibilità dei font in Retool **non ancora certificati**.
- Markdown è il **master testuale**; l'eventuale PDF potrà essere prodotto con la procedura CQD dedicata, non dal ciclo P6 Markdown.
- **Recepimento delle copie canoniche e commit GitHub:** passaggio successivo esplicito dell'utente; non eseguito in questa sessione.
