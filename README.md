La task-ul 1:
    -am pastrat la inceput primul element dupa care am parcurs cu un for toate elementele
    -am salvat in alt registru de fiecare data elementul parcurs - 1
    -daca este egal cu elementul de la incepu am pus la .next din eax nodul gasit
    -daca acesta este egal cu numarul n atunci verific daca mai sunt pasi de facut
    -la final il caut pe 1 si il pun in registrul eax

La task-ul 2:
    -am pastrat str si lungimea 
    -am facut un for care parcurge string-ul caracter cu caracter
    -verific daca ajunge la final, iar daca da pune ultimul cuvant in vectorul de string-uri
    -daca gaseste spatiu
    -atunci cand gaseste, pune NULL in loc de spatiu si adauga cuvantul in vector
    -pentru qsort am luat cuvintele din vector, dereferentiindu-le
    -apoi am calculat lungimea fiecaruia, parcurgandu-le caracter cu caracter
    -daca lungimea este mai mica, interschimb cuvintele
    -daca lungimea este egala, pun in stiva cele 2 cuvinte, apelez functia strcmp si sterg stiva

La task-ul 3:
    -fac recursiv sirul k-Fibonacci
    -daca n (ecx) este mai mic decat k (edi) returneaza 0
    -daca n (ecx) este egal cu k (edi) returneaza 1
    -altfel calculeaza n - i, salveaza registrele pe stiva, pregateste parametrii si 
    apeleaza recursiv functia
    -apoi restaureaza registrele si adauga rezultatul apelului recursiv la suma totala
    -incrementeaza contorul si verifica daca a calculat toti termenii necesari

La task-ul 4:

    Subtask-ul 1:
    -verifica daca string-ul este palindrom parcurgand de la stanga la dreapta si de la dreapta
    la stanga
    -daca are 0 elemente, returneaza 0, iar daca are 1 element returneaza 1

    Subtask-ul 2:
    -prima oara am alocat memorie pentru variabile, pastrez un "cel mai bun palindrom", si cea mai 
    buna lungime apoi lungimea vectorului
    -m-am folosit de o masca binara pentru a genera toate subseturile posibile ale vectorului de 
    string-uri
    -am calculat total = 1 << len care reprezinta numarul total de subseturi posibile
    -pentru fiecare masca verific bit cu bit pentru a decide daca adaug str[i] in buffer
    -daca bitul este setat atunci concatenez in buffer str[i]
    -dupa ce am format un cuvant ii calculez lungimea si verific daca este palindrom
    -daca este palindrom si este mai lung decat best_len atunci eliberez memoria anterioara, aloc 
    un nou best copiez noul buffer in best si actualizez best_len
    -la final dau return la best

