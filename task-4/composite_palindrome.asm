global check_palindrome
global composite_palindrome
section .text
extern malloc
extern free
extern strlen
extern strcat
extern strcpy
extern strcmp
check_palindrome:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    push ebx

    ; iau str
    mov esi, [ebp + 8]
    ; iau lungimea
    mov ebx, [ebp + 12]

    ; presupun ca este palindrom
    mov eax, 1

    ; daca lungimea este 0 nu este palindrom
    cmp ebx, 0
    jle zero

    ; daca lungimea este 1 este palindrom
    cmp ebx, 1
    je end

    xor ecx, ecx
    dec ebx

cmp:
    mov dl, byte[esi + ecx]
    cmp dl, byte[esi + ebx]
    jne zero
    inc ecx
    dec ebx
    cmp ecx, ebx
    jge end
    jmp cmp

zero:
    ; nu este palindrom
    mov eax, 0

end:

    pop ebx

    leave
    ret

composite_palindrome:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax
    ; fac spațiu pe stivă pentru variabilele locale
    sub esp, 200

    ; salvez registrele
    push ebx
    push esi
    push edi

    ; fac un best pentru cea mai buna solutie
    mov dword [ebp - 196], 0
    ; fac un best_len pentru lungimea celei mai bune solutii
    mov dword [ebp - 192], 0

    ; retin len
    mov eax, [ebp + 12]
    ; calculez total = 1 << len
    mov edx, 1
    mov ecx, eax
    shl edx, cl
    ; salvez numarul total de subseturi posibile
    mov [ebp - 180], edx

    ; incep cu masca 1
    mov dword [ebp - 188], 1
    jmp mask_loop_condition

mask_loop_start:
    ; initializez fiecare masca
    mov byte [ebp - 172], 0

    ; initializez un i cu 0
    mov dword [ebp - 184], 0
    jmp word_loop_condition

check_bit_and_concat:
    ; il retin pe i in eax
    mov eax, [ebp - 184]
    ; retin masca curenta in edx
    mov edx, [ebp - 188]
    mov ecx, eax
    ; edx = (mask >> i) & 1
    shr edx, cl
    ; verific daca e 1
    and edx, 1
    ; daca nu sar peste
    test edx, edx
    je next_word

    ; retin i in eax
    mov eax, [ebp - 184]
    ; calculez offsetul pentru elementul i din vector
    lea edx, [eax * 4]
    ; retine str
    mov eax, [ebp + 8]
    ; calculez elemnntul str[i]
    add eax, edx
    mov eax, [eax]

    push eax
    ; obtin adresa buffer-ului
    lea eax, [ebp - 172]
    push eax
    call strcat
    ; curat stiva
    add esp, 8

next_word:
    ; i++
    inc dword [ebp - 184]

word_loop_condition:
    ; i < len
    mov eax, [ebp - 184]
    ; compar i cu len
    cmp eax, [ebp + 12]
    jl check_bit_and_concat

    ; buf_len = strlen(buffer)
    lea eax, [ebp - 172]
    push eax
    call strlen
    ; curat stiva
    add esp, 4
    ; salvez buf_len
    mov [ebp - 176], eax

    ; obitn adresa lungimii buffer-ului
    push dword [ebp - 176]
    ; obtin adresa buffer-ului
    lea eax, [ebp - 172]
    push eax
    call check_palindrome
    ; curat stiva
    add esp, 8
    test eax, eax
    je next_mask

    ; verific daca este cea mai buna solutie
    ; eax = buf_len
    mov eax, [ebp - 176]
    ; compar cu best_len
    cmp eax, [ebp - 192]
    ; daca e mai mare actualizez best
    jg update_best

    ; iau buf_len
    mov eax, [ebp - 176]
    ; iau best_len
    cmp eax, [ebp - 192]
    ; daca nu sunt egale sar peste
    jne next_mask

    ; daca este 0 sar peste
    cmp dword [ebp - 196], 0
    je next_mask

    ; retin best
    push dword [ebp - 196]
    ; retin adresa buffer-ului
    lea eax, [ebp - 172]
    push eax
    call strcmp
    ; curat stiva
    add esp, 8
    ; verific rezultatul strcmp
    test eax, eax
    ; daca buffer >= best sar peste
    jns next_mask

update_best:
    ; verific daca best este alocat
    cmp dword [ebp - 196], 0
    ; daca nu il aloc
    je allocate_new_best
    ; daca este alocat, eliberez
    push dword [ebp - 196]
    call free
    ; curat stiva
    add esp, 4

allocate_new_best:
    ; retin buf_len
    mov eax, [ebp - 176]
    inc eax
    push eax
    ; aloc best
    call malloc
    ; curat stiva
    add esp, 4
    ; salvez adresa lui best
    mov [ebp - 196], eax

    ; retin adresa buffer-ului curent
    lea eax, [ebp - 172]
    push eax
    ; dau push la adresa lui best
    push dword [ebp - 196]
    call strcpy
    ; curat stiva
    add esp, 8

    ; retin lungimea buffer-ului curent
    mov eax, [ebp - 176]
    ; salvez in best_len
    mov [ebp - 192], eax

next_mask:
    ; mask++
    inc dword [ebp - 188]

mask_loop_condition:
    ; retin masca
    mov eax, [ebp - 188]
    ; compar cu nr total de subseturi
    cmp eax, [ebp - 180]
    jl mask_loop_start

    ; return best
    mov eax, [ebp - 196]

    ; restauram registrele
    pop edi
    pop esi
    pop ebx

    leave
    ret
