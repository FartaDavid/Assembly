struc node
    .val resd 1
    .next resd 1
endstruc
; lungimea lui next in node
%define node_next 4
; lungimea unui node
%define node_size 8
global sort
section .text
;   struct node {
;    int val;
;    struct node* next;
;   };

;; struct node* sort(int n, struct node* node);
;   The function will link the nodes in the array
;   in ascending order and will return the address
;   of the new found head of the list
; @params:
;   n -> the number of nodes in the array
;   node -> a pointer to the beginning in the array
;   @returns:
;   the address of the head of the sorted list
sort:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax
    push ebx
    push ecx
    push edx
    push edi
    push esi
    ; n
    mov ebx, [ebp + 8]
    ; array
    mov esi, [ebp + 12]
    ; primul nod
    lea eax, [esi]
    ; i = 0
    xor ecx, ecx
    ; tin minte i-ul curent
    push ecx
    xor edi, edi

for:
    ; elementul din for
    lea edx, [esi + ecx * node_size]
    ; pastrez elementul initial;
    mov edi, [edx]
    dec edi
    ; verific daca sunt egale
    cmp [eax], edi
    je adding

    ; cresc i
    inc ecx
    ; verific daca se termina de cautat in for
    cmp ecx, ebx
    je end
    jmp for

adding:
    pop ecx
    inc ecx

    ; incarc in .next urm nod
    mov [eax + node_next], edx

    ; incarc urm nod caruia ii caut .next in eax
    lea eax, [esi + ecx * node_size]
    ; verific daca este maximul din vector
    mov edi, [eax]
    cmp edi, ebx
    je highest

    ; verific daca a ajuns la final
    cmp ecx, ebx
    je end
    push ecx
    xor ecx, ecx

    jmp for

highest:
    ; daca este maximul si mai sunt pasi de facut continui in for
    inc ecx
    cmp ecx, ebx
    jge end
    ; trec la urmatorul element
    lea eax, [esi + ecx * node_size]
    ; dau push la ecx pentru a retine elementul la care sunt in lista
    push ecx
    ; fac ecx = 0 pt for
    xor ecx, ecx
    jmp for

end:
    ; daca se termina de cautat in for resetez registrii
    pop ecx
    xor ecx, ecx
    xor eax, eax

formin:
    ; iau nod din cu ajutorul lui formin
    lea eax, [esi + ecx * node_size]
    ; retin valoarea in edi
    mov edi, [eax]
    ; verific daca este 1
    cmp edi, 1
    je realend

    inc ecx
    cmp ecx, ebx
    je realend
    jmp formin

realend:
    ; daca este 1 se termina programul

    pop esi
    pop edi
    pop edx
    pop ecx
    pop ebx
    leave
    ret

