PROJECT --- CQD PROTOCOL

Documento: 98_PROJECT_CQD_Protocol

Versione: v1.0

Sistema: AIOS Project Framework

Tipo: Protocollo Controllo Qualità Documenti

1 --- SCOPO DEL PROTOCOLLO

Il CQD (Controllo Qualità Documenti) è il protocollo che garantisce

l\'integrità dei documenti generati all\'interno dei progetti

basati sul sistema AIOS.

Il suo obiettivo è assicurare che ogni documento esportato sia:

• completo

• coerente

• non troncato

• correttamente versionato

• compatibile con il sistema documentale del progetto

2 --- QUANDO APPLICARE CQD

Il CQD deve essere applicato prima della consegna

di qualsiasi documento ufficiale.

Casi tipici:

• generazione di nuovi documenti

• aggiornamento di versioni esistenti

• integrazione di contenuti

• consolidamento di decisioni progettuali

3 --- CONTROLLI DI INTEGRITÀ

Il protocollo CQD verifica:

• integrità del contenuto

• assenza di troncamenti

• continuità logica delle sezioni

• completezza del documento

• presenza di tutte le parti dichiarate

4 --- CONTROLLI STRUTTURALI

Il CQD verifica inoltre:

• presenza dell\'header documento

• presenza dell\'indice (quando necessario)

• coerenza delle sezioni

• presenza dello storico revisioni

• compatibilità con la struttura file del progetto

5 --- CONTROLLO VERSIONAMENTO

Il CQD controlla che il documento rispetti

il sistema di versionamento del progetto.

Formato standard:

NumeroArea_NomeDocumento_vX.X

Esempio:

98_PROJECT_CQD_Protocol_v1.0

La versione deve essere incrementata

solo quando il contenuto del documento cambia.

6 --- METRICHE DI CONTROLLO

Prima dell\'esportazione il sistema registra:

• conteggio parole

• conteggio caratteri

Dopo l\'esportazione verifica:

• dimensione del file

• integrità del documento generato

7 --- DOCUMENT PIPELINE

Ogni documento ufficiale del progetto deve essere generato

seguendo la Document Pipeline.

Sequenza operativa:

1 --- anteprima documento

2 --- verifica metriche preliminari

3 --- generazione file DOCX

4 --- verifica metriche post-export

5 --- applicazione CQD

6 --- consegna documento

Un documento è considerato ufficiale

solo dopo aver completato l\'intera pipeline.

8 --- REGOLA DI INTEGRITÀ DOCUMENTALE

Quando un documento viene aggiornato o modificato

il sistema deve avere accesso al contenuto completo

della versione precedente.

Se il contenuto precedente non è disponibile

deve essere richiesto il caricamento del documento originale.

È vietata la generazione di versioni parziali

o ricostruite in forma sintetica.

Le modifiche devono essere applicate

al documento completo mantenendo l\'integrità

del contenuto originale,

salvo esplicita richiesta di sintesi.

9 --- GESTIONE ERRORI GENERAZIONE DOCUMENTO

In caso di errore nella generazione del file DOCX

il sistema esegue massimo due tentativi.

Tentativo 1 --- rigenerazione documento

Tentativo 2 --- rigenerazione alternativa

Se entrambi falliscono

il sistema deve fornire il contenuto completo

in formato testo strutturato

per copia manuale nel file locale.

10 --- CQD ESCALATION LEVELS

CQD Livello 1 --- Standard

Controlli:

• parole pre/post

• caratteri pre/post

• dimensione file

CQD Livello 2 --- Diagnostico

Attivato in caso di errore.

Controlli aggiuntivi:

• conteggio paragrafi

• verifica continuità sezioni

• verifica blocchi mancanti

CQD Livello 3 --- Delta Check Evolutivo (modulo opzionale)

Confronto tra versioni successive dello stesso documento.

Il Delta Check calcola:

• caratteri versione precedente

• caratteri versione nuova

• differenza assoluta

• variazione percentuale

Il Delta Check:

• non sostituisce il CQD

• non è controllo integrità

• è strumento di analisi evolutiva

11 --- DOCUMENTI DI GRANDI DIMENSIONI

Quando un documento supera dimensioni compatibili

con l\'output singolo della chat

possono essere utilizzate modalità alternative:

• generazione in blocchi sequenziali

• utilizzo blocco codice completo

• copia manuale nel file locale

Il CQD deve comunque essere applicato

al documento finale.

12 --- MODALITÀ CQD COMPATTA

Se il controllo integrità è positivo

il risultato può essere comunicato

in forma sintetica.

Formato:

\"CQD verificato --- integrità confermata.\"

Le metriche complete vengono comunque calcolate

ma non mostrate in assenza di anomalie.

Se emergono errori o incoerenze

il report completo deve essere mostrato

prima della consegna del documento.

VERSION HISTORY

v1.0 --- Prima definizione del CQD Protocol universale

per progetti basati sul sistema AIOS.
