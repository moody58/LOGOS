PROJECT — SESSION MANAGEMENT PROTOCOL

Documento: 98_PROJECT_Session_Management_Protocol  
Versione: v1.0  

------------------------------------------------
SCOPO
------------------------------------------------

Definire la gestione sicura delle:

- micro-sessioni operative
- Regia (control room)

Obiettivo:

evitare deriva, incoerenza e saturazione.

------------------------------------------------
PRINCIPIO FONDANTE
------------------------------------------------

Regia coordina  
Sessioni eseguono  

---

La Regia NON lavora.

Le sessioni NON decidono direzione.

------------------------------------------------
MICRO-SESSIONI
------------------------------------------------

Regole:

✔ UNA sessione = UN nodo  
✔ durata breve  
✔ output obbligatorio  

Output ammessi:

- CHECKPOINT  
- DOC  

---

Una sessione termina quando:

- obiettivo raggiunto  
- nodo chiuso  

---

Divieto:

- cambiare nodo
- espandere scope
- introdurre nuove direzioni

------------------------------------------------
CICLO OPERATIVO
------------------------------------------------

Regia:

→ definisce nodo  
→ definisce confini  

↓

Micro-sessione:

→ analizza  
→ decide  
→ implementa  
→ testa  

↓

Output:

→ CHECKPOINT  

↓

Aggiornamento:

→ STATE  
→ documenti  

------------------------------------------------
GESTIONE REGIA
------------------------------------------------

La Regia è:

✔ stabile  
✔ leggera  
✔ non operativa  

---

La Regia NON accumula:

- analisi lunghe  
- codice  
- debug  

------------------------------------------------
SATURAZIONE REGIA
------------------------------------------------

Trigger di saturazione:

- incoerenza risposte
- perdita focus
- ripetizioni
- conflitti tra decisioni

---

Quando avviene:

→ RESET REGIA

------------------------------------------------
RESET REGIA (OBBLIGATORIO)
------------------------------------------------

Procedura:

1. nuova chat
2. Boot Sequence (#start)
3. caricare:

- 00_PROJECT_State
- Roadmap
- ultimo checkpoint

4. dichiarare nodo attivo

---

Divieto:

- riutilizzare vecchia Regia
- portare storico conversazione

------------------------------------------------
GESTIONE FONTI
------------------------------------------------

Le fonti:

✔ supportano il sistema  
✔ NON aggiornano la chat attiva  

---

Regola:

Ogni nuova sessione:

→ usa fonti aggiornate  

La Regia:

→ NON si aggiorna automaticamente  

---

Conseguenza:

Le fonti NON causano deriva  

La deriva è causata da saturazione chat  

------------------------------------------------
PRINCIPIO FINALE
------------------------------------------------

Stabilità > Continuità conversazionale  

---

Meglio:

✔ nuova Regia pulita  

Peggio:

❌ Regia lunga e incoerente  