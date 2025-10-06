section .text
global kfib

kfib:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    ; poz termen cerut (n)
    mov ecx, [ebp + 8] 
    ; tipul sirului fibonacci
    mov edi, [ebp + 12] 

    ; daca este strict mai mic decat n intru pe ramura 0
    cmp ecx, edi
    jl zero

    ; daca este n trec pe ramura 1
    cmp ecx, edi
    je one

    ; i = 1
    mov esi, 1 
    xor ebx, ebx

loop:
    ; salvez n
    mov edx, ecx 
    ; fac n - i
    sub edx, esi 

    ; salvez registrii
    push ecx
    push edi
    push esi
    push ebx

    push edi
    push edx

    call kfib
    ; curat stiva
    add esp, 8

    pop ebx
    pop esi
    pop edi
    pop ecx

    ; fac suma
    add eax, ebx
    mov ebx, eax

    inc esi
    cmp esi, edi
    jg done

    jmp loop

zero:
    xor eax, eax
    leave
    ret

one:
    ; return 1
    mov eax, 1
    leave
    ret

done:
    mov eax, ebx

    leave
    ret

