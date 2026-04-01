PROJECT — Kernel Manifest



Scopo del documento



Il Kernel Manifest dichiara l’architettura del progetto e la sua

integrazione con il metasistema AIOS.



Il documento ha funzione dichiarativa.



Serve a permettere al sistema di comprendere:



• la struttura del progetto  

• i componenti fondamentali del sistema  

• la relazione con AIOS  

• la gerarchia dei protocolli operativi





Architettura del metasistema



AIOS rappresenta il metasistema che governa il metodo

e coordina i progetti.



Il progetto rappresenta un’istanza operativa autonoma

del metasistema.



Relazione architetturale:



AIOS

↓

PROJECT

↓

MACROAREE OPERATIVE

↓

SESSIONI OPERATIVE

↓

DOCUMENTI





Kernel documentale del progetto



Il kernel del progetto è costituito dai documenti

fondamentali che permettono al sistema di ricostruire

lo stato e la struttura del progetto.



Documenti kernel:



00\_PROJECT\_Regia  

00\_PROJECT\_State  

00\_PROJECT\_System\_Map  

00\_PROJECT\_KERNEL\_MANIFEST





Runtime conversazionale



Il comportamento delle chat del progetto è governato

dal runtime conversazionale.



Documenti runtime:



PROJECT\_RUNTIME\_INSTRUCTIONS  

98\_PROJECT\_RUNTIME





Metodo operativo



Il metodo operativo del progetto è definito dal

protocollo principale e dal sistema di anchor.



Documenti metodo:



98\_PROJECT\_PROTOCOL  

98\_PROJECT\_Anchor\_System





Protocol Layer



Il sistema utilizza protocolli tecnici modulari.



Protocolli attivi:



98\_PROJECT\_CQD\_Protocol  

98\_PROJECT\_STP\_Protocol  

98\_PROJECT\_Sistema\_Fonti  

98\_PROJECT\_Incident\_Management





Funzione del Kernel Manifest



Il Kernel Manifest permette al sistema di:



• identificare il progetto  

• stabilire la gerarchia dei protocolli  

• evitare conflitti tra sistema e progetto  

• mantenere coerenza tra metasistema e istanza  



Questo documento non sostituisce i protocolli

operativi del progetto ma ne dichiara l’architettura.



