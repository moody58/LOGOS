PROJECT — File System Guide



Sistema: AIOS Project Framework





1 — SCOPO DEL DOCUMENTO



Questo documento definisce la struttura standard

del file system per i progetti basati sul sistema AIOS.



La struttura ha tre obiettivi principali:



• garantire ordine e coerenza documentale  

• permettere duplicazione rapida dei progetti  

• separare contenuti operativi, tecnici e storici  





2 — PRINCIPIO DI STRUTTURA



Il sistema utilizza macroaree numeriche

per mantenere la struttura stabile tra progetti diversi.



Le macroaree sono progettate per essere:



• replicabili  

• indipendenti dal tipo di progetto  

• compatibili con evoluzioni future  





3 — MACROAREE DEL PROGETTO



La struttura universale prevede le seguenti macroaree.





00 — CORE PROGETTO



Contiene i documenti fondamentali del progetto.



Documenti tipici:



00\_PROJECT\_Regia  

00\_PROJECT\_State  

00\_PROJECT\_System\_Map  

00\_PROJECT\_KERNEL\_MANIFEST  



Questa area rappresenta il centro operativo del progetto.





90 — SCAMBIO ESTERNO



Area utilizzata per materiali provenienti dall'esterno.



Esempi:



• documenti ricevuti da clienti  

• materiali forniti da partner  

• file di riferimento esterni  



Questa cartella serve come zona di ingresso

per contenuti non ancora integrati nel sistema.





97 — SISTEMA DATI



Area dedicata a dataset,

strutture dati o modelli informativi.



Può contenere:



• database progetto  

• dataset strutturati  

• modelli di analisi  

• pipeline dati  



Non tutti i progetti utilizzano questa area,

ma la struttura la prevede per compatibilità futura.





98 — SISTEMA TECNICO



Contiene i documenti tecnici

che governano il funzionamento del progetto.



Documenti tipici:



98\_PROJECT\_RUNTIME  

98\_PROJECT\_PROTOCOL  

98\_PROJECT\_CQD\_Protocol  

98\_PROJECT\_STP\_Protocol  

98\_PROJECT\_Anchor\_System  

98\_PROJECT\_Sistema\_Fonti  

98\_PROJECT\_Incident\_Management  

98\_PROJECT\_File\_System\_Guide  

98\_PROJECT\_Radar  



Questa area costituisce il sistema tecnico del progetto.





99 — ARCHIVIO STRATEGICO



Contiene documenti non più attivi

ma rilevanti per la memoria storica del progetto.



Include:



• versioni precedenti dei documenti  

• analisi superate  

• decisioni archiviate  



I documenti presenti in questa cartella

non sono operativi.





4 — BACKUP ESTERNO



Il sistema prevede una cartella esterna denominata:



PROJECT\_BACKUP



Questa cartella non fa parte della struttura interna

del progetto ma viene utilizzata per:



• backup periodici  

• snapshot di sicurezza  

• archiviazione versioni complete del progetto  



Il backup è responsabilità operativa dell’utente

e non è gestito automaticamente dal sistema.





5 — PRINCIPI OPERATIVI



La struttura file segue alcuni principi fondamentali.



Stabilità  

Le macroaree non devono cambiare tra progetti diversi.



Coerenza  

Ogni documento deve essere collocato

nella macroarea corretta.



Versionamento  

Il versionamento dei documenti avviene

nei progetti derivati dal template.



Separazione  

Documenti operativi, tecnici e storici

devono rimanere separati.





6 — DUPLICAZIONE PROGETTI



Il Launch Kit utilizza questa struttura

per permettere la creazione rapida di nuovi progetti.



Procedura tipica:



1 duplicare il Launch Kit  

2 rinominare i documenti PROJECT  

3 avviare la Regia del progetto  

4 iniziare le sessioni operative



