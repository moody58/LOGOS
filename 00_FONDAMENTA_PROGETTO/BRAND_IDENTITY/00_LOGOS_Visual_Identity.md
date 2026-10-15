# 00_LOGOS_Visual_Identity — LOGOS Visual Identity System

**Documento canonico:** `00_LOGOS_Visual_Identity.md`  
**Versione del contenuto:** v1.1 — recepimento documentale canonico  
**Data del recepimento documentale:** 2026-10-16  
**Decisione creativa originale:** 2026-10-09  
**Progetto:** LOGOS — Event Operating System  
**Ambito:** identità visiva, asset di marca, palette, riferimenti di utilizzo  
**Stato della decisione:** APPROVATA CREATIVAMENTE dall'utente nel brainstorming LOGOS  
**Stato del recepimento:** versione v1.1 del presente documento; la baseline `f4e02738dd43668c7ce6e16821e81c02846423d6` pubblicava la versione originaria v1.0  
**Fonte primaria:** [`references/LOGOS_Visual_Identity_Reference_Board_20261009.png`](references/LOGOS_Visual_Identity_Reference_Board_20261009.png)  
**Sistema tipografico correlato:** [`00_LOGOS_Typography_System.md`](00_LOGOS_Typography_System.md)

## Premessa, autorità e confini

Questo documento è progettato come **fonte madre dell'identità visiva di LOGOS**, all'interno della macroarea 00. Il contenuto deriva dallo snapshot di brainstorming `LOGOS_Visual_Identity_Working_Snapshot_v0.1` del 9 ottobre 2026; il recepimento in repository richiede una successiva verifica indipendente e non avviene tramite la sola generazione del presente file.

Consolidare la decisione creativa **non** significa avere distribuito font, palette o icone nella UI Retool. Le schermate dimostrative nella tavola non sono screenshot del runtime. La specifica non autorizza modifiche a Retool, Supabase, database, input, parser, matching, payload, save flow o alla roadmap di sviluppo.

**Gerarchia delle fonti per questo contenuto:** tavola visuale originale (aspetto e proporzioni) → presente documento (regole di utilizzo e codici colore) → documento tipografico (famiglie, ruoli e criteri di verifica). In caso di discordanza tra descrizione testuale e sagoma reale del marchio prevale l'artwork originale, non una ricostruzione approssimativa.

---

## 1. Decisioni creative da preservare

| Elemento | Decisione | Evidenza/limite |
|---|---|---|
| Nome e wordmark | **LOGOS**, lettering geometrico personalizzato della tavola | Preservare forme e proporzioni; non ricomporre con un font standard |
| Simbolo | Nastro ripiegato che forma una **L** geometrica, con vuoto triangolare e finitura terracotta satinata | Il master vettoriale non è contenuto nella tavola |
| Logo primario | Simbolo a sinistra + wordmark a destra, come nella sezione 1 della tavola | Lockup approvato nel brainstorming; proporzioni da mantenere come nel riferimento |
| Marchio singolo | Simbolo autonomo, come sezione 2 della tavola | Uso su avatar, favicon, marchiatura compatta solo dopo verifica a scala reale |
| Icona app | Simbolo centrato in quadrato a spigoli arrotondati, sfondo scuro terracotta, come sezione 3 | Artwork nella tavola; per store/app serviranno file originali alle risoluzioni richieste |
| Materiale | **Satin Terracotta**, superfici, pieghe, luci e ombre morbide | La resa 3D non si riproduce col solo codice HEX |
| Colore principale | **#C9785B** | Identitario; non presupporre contrasto AAA per testo |
| Font UI | **Source Sans 3** (400/500/600/700) | Scelta creativa approvata; implementazione Retool non verificata |
| Font tecnico | **IBM Plex Mono** (400/500) | Codici, ID, log, contenuti macchina |
| Relazione con AIOS | Sistema visivo affine, ma distinto | AIOS mantiene Geist Sans + IBM Plex Mono; LOGOS adotta Source Sans 3 |

### Regole di integrità del logo

- Non modificare sagoma, geometria del nastro, pieghe, equilibrio dei vuoti, inclinazione, wordmark o proporzioni del lockup.
- Non sostituire il wordmark con Source Sans 3: è artwork grafico separato dal font UI.
- Non inventare area di rispetto, dimensione minima in pixel, coordinate geometriche o formule di gradiente **non misurate** dalla sorgente. Andrebbero definite sul master reale in futuro.
- Evitare emissione neon, bagliori aggiunti, variazioni cromatiche arbitrarie e cambio della direzione delle luci.
- Le versioni monocromatiche e flat possono essere richieste come derivati produttivi, ma qui non vengono spacciate per master vettoriali approvati.
- La tavola fornita rimane la prova primaria di aspetto e composizione. Estratti/crop usati per la lettura nel PDF **non sono asset di produzione**.

## 2. Palette identitaria e superfici

| Token descrittivo | HEX | Funzione dalla tavola |
|---|---|---|
| Terracotta Primary | `#C9785B` | Colore identitario, marchio, accenti intenzionali |
| Hover Clay | `#D98C73` | Tonalità di supporto / hover, non garantisce accessibilità |
| Pressed Rust | `#A6543D` | Tonalità di supporto / pressione, non automaticamente AAA |
| Soft Accent | `#E8B29C` | Accenti tenui, highlight, illustrazioni |
| Charcoal Background | `#0E0F12` | Sfondo principale tema scuro |
| Slate Surface | `#1A1D22` | Card, pannelli, superfici scure |
| Light Sand Background | `#F1E8E1` | Sfondo principale tema chiaro |
| Warm White Text on Dark | `#FAF6F2` | Testo primario sul tema scuro |
| Ink Text on Light | `#1F1A17` | Testo primario sul tema chiaro |
| Border / Divider Warm | `#3A2B24` | Separatore caldo: insufficientemente visibile su charcoal come unico bordo |

## 3. Colori semantici

| Stato | HEX | Funzione dalla tavola |
|---|---|---|
| Success Jade | `#2F8A73` | Esiti positivi / completato |
| Warning Amber | `#C88A35` | Avvisi / attenzione |
| Error Red Clay | `#B84E4E` | Errore / azione distruttiva |
| Info Steel Blue | `#53718C` | Informazione / link / neutro |

Gli stati non vanno comunicati soltanto col colore: aggiungere testo e, dove utile, icona. I colori semantici sono **colori di marca**, non coppie foreground/background automaticamente conformi WCAG.

## 4. Modalità dark e light

**Dark:** base Charcoal `#0E0F12`, card Slate `#1A1D22`, testo Warm White `#FAF6F2`, terracotta come accento e punto di attenzione (non per ogni riga di un grafico).

**Light:** base Light Sand `#F1E8E1`, testo Ink `#1F1A17`, terracotta come colore d’identità per azioni e highlight solo dove il contrasto del componente è stato verificato.

La tavola mostra mockup d’uso per entrambe le modalità. **Sono riferimenti grafici del brainstorming**, non schermate della vera app Retool. L’esatta geometria dei componenti, i KPI e le etichette raffigurate non costituiscono funzionalità implementate.

## 5. Contrasto e obiettivo WCAG 2.2 AAA

Le seguenti misure sono calcolate sui codici sRGB della tavola: non sono un audit dell’applicazione. Per testo ordinario il criterio 1.4.6 AAA richiede 7:1; per testo grande 4,5:1. Per icone e confini significativi si considera anche il requisito non-text contrast 3:1 quando applicabile.

| Testo/elemento | Sfondo | Rapporto | Risultato |
|---|---|---:|---|
| `#1F1A17` (Ink) | `#F1E8E1` | 14.26:1 | AAA normale |
| `#FAF6F2` (Warm White) | `#0E0F12` | 17.82:1 | AAA normale |
| `#C9785B` (Terracotta) | `#F1E8E1` | 2.75:1 | Non AAA |
| `#C9785B` (Terracotta) | `#0E0F12` | 5.77:1 | Non AAA normale |
| `#FFFFFF` (Bianco) | `#C9785B` | 3.32:1 | Non AAA |
| `#1F1A17` (Ink) | `#C9785B` | 5.19:1 | Non AAA normale |
| `#3A2B24` (Border Warm) | `#0E0F12` | 1.42:1 | Non raggiunge 3:1 |

**Conclusione operativa:** la palette approvata **non va modificata automaticamente**. Occorrono token funzionali distinti da definire/verificare quando si implementerà la UI: foreground per pulsanti, link, focus, bordi e stati, soprattutto nelle due modalità. Per esempio `#C9785B` non è una tinta per testo normale AAA sullo sfondo chiaro `#F1E8E1`; la stessa tinta non raggiunge 7:1 su Charcoal. Anche il separatore `#3A2B24` su Charcoal ha contrasto troppo basso per essere l’unico confine informativo. Questo non invalida la tinta identitaria del marchio.

Per prove: utilizzare cifre tabulari nei KPI, testo scalabile e form mobile a 16–17 px; non ridurre l’UI a 13–14 px per aumentare artificialmente la densità. Il documento tipografico allegato esplicita gli altri requisiti di zoom, spaziatura, reflow e target. **AAA è un target, non una certificazione conseguita.**

## 6. Materiale satinato, sfumature e stampa

- La finitura del simbolo è **terracotta satinata**, con superfici raccordate e contrasti morbidi.
- **Non esiste nella tavola una formula tecnica esatta** per stop, coordinate, angoli o profili di gradiente: usarla come riferimento visivo, non come SVG descrittivo.
- Varianti **flat** e **monocromatiche** sono necessarie per stampa a un colore, documenti, icone molto piccole e condizioni senza sfumature; la resa definitiva deve essere confrontata con il simbolo master.
- Le seguenti corrispondenze sono proposte **approssimative riportate nella tavola** e **non** equivalenze colorimetriche verificate:

| Colore | Pantone approssimativo | RAL approssimativo |
|---|---|---|
| Terracotta `#C9785B` | 7583 C | 3012 |
| Charcoal `#0E0F12` | Black 6 C | 9005 |
| Light Sand `#F1E8E1` | Warm Gray 1 C | 9001 |
| Slate `#1A1D22` | Cool Gray 11 C | 7021 |

La produzione richiede campionario fisico, supporto, finitura, prove colore e profili di conversione appropriati. Pantone/RAL non sono valori «ufficiali certi» derivabili automaticamente dagli HEX.

## 7. Tipografia approvata in questa sessione

**Source Sans 3** è la famiglia proporzionale per titoli, menu, descrizioni, form, liste, dashboard e KPI. **IBM Plex Mono** compare selettivamente in codice, identificativi, flag, query e log. Inter resta un riferimento di confronto, non un secondo font ufficiale.

Le dimensioni e le regole complete sono preservate in `00_LOGOS_Typography_System.md`. Il logo/wordmark non cambia a seguito della scelta tipografica.

## 8. Registro di evidenze, limiti e cose da verificare

| ID | Elemento | Stato |
|---|---|---|
| B01 | Scelta logo, simbolo, iconografia e terracotta | **Approvato creativamente**; immagine di riferimento preservata |
| B02 | Codici HEX della tavola e colori semantici | **Trascritti**; non sostituiscono token Retool |
| B03 | Source Sans 3 / IBM Plex Mono | **Approvato creativamente**; documento v1.0 allegato |
| B04 | File vettoriali master del logo e wordmark | **Non verificati** / non inclusi nella tavola |
| B05 | Misura clearspace, minimo dimensionale, export app icon | **Da produrre/testare** dal master |
| B06 | Formula gradiente/materiale | **Non specificata tecnicamente** |
| B07 | Equivalenze Pantone/RAL | **Indicative**; swatch fisici da validare |
| B08 | AAA, contrasti di tutti i componenti, mobile Safari | **Da verificare su UI reale** |
| B09 | Uso dei font in Retool web/mobile e dashboard futura | **Da verificare sul piano e runtime effettivi** |
| B10 | Integrazione nei documenti canonici del repo | Documento recepito come v1.1; la baseline `f4e02738dd43668c7ce6e16821e81c02846423d6` conteneva la versione originaria v1.0 |

## 9. Registro degli asset raster e provenienza

I file sono **copie binarie identiche** ai PNG forniti alla sessione, salvate con nomi LOGOS appropriati. Le precedenti denominazioni `aios-...` sono soltanto nomi di file di origine e non identificano il brand AIOS. Non sono stati alterati colori, risoluzioni, composizione o sfondo.

| File destinazione | Nome originale consegnato | Pixel | Tipo | SHA-256 | Ruolo |
|---|---|---:|---|---|---|
| `LOGOS_Logo_Primary.png` | `aios-logo.png` | 2048×682 | RGBA trasparenza presente | `b3925ef17292c9064eaf03c9e5b9d5f4561548f85fcec17ba0cdb12f54b20890` | Asset raster approvato (non master vettoriale) |
| `LOGOS_Symbol_Primary.png` | `aios-symbol.png` | 1254×1254 | RGBA trasparenza presente | `e333dc80fee80ca6134451562981faffc870069b17601b130a6ea2b79f19296d` | Asset raster approvato (non master vettoriale) |
| `LOGOS_App_Icon.png` | `aios-icon.png` | 1254×1254 | RGBA opaco | `e29ac28d89cd419e851a0010f727090be6c58f5c622a13be8ec15d5dbc1d28a1` | Asset raster approvato (non master vettoriale) |
| `LOGOS_Visual_Identity_Reference_Board_20261009.png` | `aios-brand-indetity(1).png` | 1055×1491 | RGBA opaco | `46f8e3b8fb0291d67c4483db942dc7c9a32741ccf8d5d64fe385111cfb834152` | Riferimento visuale, non asset UI |

**Limiti:** il wordmark rimane artwork custom; nessun SVG, AI/EPS o master vettoriale è verificato. Gli export a dimensioni store, il clearspace, le dimensioni minime, la formula esatta delle sfumature e le varianti flat/monocromatiche non sono inclusi nel presente recepimento e non vengono presentati come pronti per produzione. Il fatto che un file sia PNG non certifica automaticamente la sua adeguatezza per tutte le destinazioni.

## 10. Regole di applicazione e verifiche future

- **UI Retool:** utilizzare la palette come specifica di riferimento, non come prova di token già impostati; il caricamento font, il rendering light/dark e i vincoli della piattaforma necessitano un nodo tecnico distinto.
- **Accessibilità:** il target è WCAG 2.2 AAA; la conformità non è stata dimostrata. I colori semantici non sostituiscono etichette/stati testuali. I token di contrasto funzionali si definiscono dopo verifica reale e senza alterare automaticamente la tinta identitaria.
- **Stampa:** Pantone/RAL sono approssimazioni dalla tavola, non conversioni ufficiali misurate. Richiedere prove su materiale e campionario reale.
- **Integrità:** non ridisegnare il simbolo o ricomporre il wordmark con Source Sans 3. Per derivati produttivi serve un passaggio specifico sul file sorgente più affidabile disponibile.
- **Tracciabilità:** documentare in State/Changelog l'avvenuto recepimento solo dopo verifica applicativa dei file; la struttura documentale si aggiorna nel Kernel con richiamo breve, non duplicando queste regole.

## 11. Tracciabilità e revisioni

- Fonte di contenuto: `LOGOS_Visual_Identity_Working_Snapshot_v0.1(1).md`, SHA-256 `7abb97be9bd04eeb65d9c6506bb54e60134de02e2de93c94c99912203352532e`, snapshot non canonico del 2026-10-09.
- Fonte immagine primaria: tavola LOGOS confermata, SHA-256 `46f8e3b8fb0291d67c4483db942dc7c9a32741ccf8d5d64fe385111cfb834152`.
- Fonte tipografia: documento di brainstorming `LOGOS_Typography_System_v1.0` del 2026-10-09, riprodotto nel documento canonico corrispondente.
- Standard e criteri: WCAG 2.2 W3C (https://www.w3.org/TR/WCAG22/), verifiche applicative future, non certificazione del prodotto.

**v1.0 (candidato, 2026-10-15):** recepimento conservativo delle scelte creative 2026-10-09, trascrizione fedele di palette e limiti, asset originali con hash e ruoli; nessun aggiornamento del runtime.

**v1.1 (2026-10-16):** consolidamento documentale canonico; la versione originaria v1.0 era stata pubblicata nella baseline `f4e02738dd43668c7ce6e16821e81c02846423d6`. Identità, palette, artwork e PNG invariati.
