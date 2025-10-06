section .text
global sort
global get_words
extern qsort
extern strcmp

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    ; Creează un nou stack frame
    enter 0, 0

    push eax
    push ecx 
    push ebx
    push edx
    push edi
    push esi

    ; retin **words
    mov eax, [ebp + 8]
    ; retin number_of_words
    mov ebx, [ebp + 12]
    ; retin size
    mov ecx, [ebp + 16]

    ; Pune parametrii pe stivă în ordine inversă
    push comp          ; Al patrulea parametru: funcția de comparație
    push ecx ; Al treilea parametru: dimensiunea fiecărui element
    push ebx ; Al doilea parametru: numărul de elemente
    push eax           ; Primul parametru: adresa array-ului

    ; Apelează qsort
    call qsort

    ; Curăță stiva
    add esp, 16

    pop esi
    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax


    leave
    ret

comp:
    ; fac un nou stack frame
    enter 0, 0

    xor eax, eax

    push ebx
    push ecx
    push edx
    push edi
    push esi

    ; iau primul cuvant
    mov esi, [ebp + 8]
    mov esi, [esi]
    ; iau al doilea cuvant
    mov edx, [ebp + 12]
    mov edx, [edx]
    xor ecx, ecx
    xor edi, edi

len1:
    ; verific daca ajunge la finalul cuvantului 1
    cmp byte[esi + ecx], 0
    je len2
    inc ecx
    jmp len1

len2:
    ; verific daca ajunge la finalul cuvantului 2
    cmp byte[edx + edi], 0
    je cmplen
    inc edi
    jmp len2

cmplen:
    cmp ecx, edi
    jg one
    jl minone

    push edx
    push esi
    call strcmp
    ; curat stiva
    add esp, 8
    jmp end1

one:
    ; pun 1 ca rezultat
    mov eax, 1
    jmp end1

minone:
    ; pun -1 ca rezultat
    mov eax, -1

end1:

    ; Ieșire
    pop esi
    pop edi
    pop edx
    pop ecx
    pop ebx

    leave
    ret

; Funcția de comparație
;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    ; iau *s
    mov esi, [ebp + 8]
    ; iau **words
    mov eax, [ebp + 12]
    ; iau numarul de cuvinte
    mov ebx, [ebp + 16]
    ; fac ecx = 0
    xor ecx, ecx

for:
    ; verifica daca ajunge la final
    cmp byte[esi + ecx], 0
    je end
    ; verifica daca nu este spatiu
    cmp byte[esi + ecx], ' '
    jne space

    inc ecx
    jmp for

space:
    ; verifica daca ajunge la final
    cmp byte[esi + ecx], 0
    je end
    ; verifica daca este spatiu
    cmp byte[esi + ecx], ' '
    ; daca este spatiu inseamna ca se termina cuvantul
    je elim
    inc ecx
    jmp space

elim:
    ; pune \0 in loc de spatiu
    mov byte[esi + ecx], 0
    ; pune cuvantul in words
    mov [eax], esi
    ; trece la urmatorul element din words
    add eax, 4
    ; trece la urmatorul element din *s
    add esi, ecx
    ; trece si de \0
    inc esi
    ; incepe din nou in for
    xor ecx, ecx
    jmp for

end:
    ; la final va ramane cu un cuvant pe care il pune in words
    mov [eax], esi

    leave
    ret

