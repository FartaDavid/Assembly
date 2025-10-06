	.file	"c.c"
	.intel_syntax noprefix
	.text
	.globl	composite_palindrome
	.type	composite_palindrome, @function
composite_palindrome:
.LFB0:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	push	ebx
	sub	esp, 212
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	add	ebx, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	eax, DWORD PTR 8[ebp]
	mov	DWORD PTR -204[ebp], eax
	mov	eax, DWORD PTR gs:20
	mov	DWORD PTR -12[ebp], eax
	xor	eax, eax
	mov	DWORD PTR -192[ebp], 0
	mov	eax, DWORD PTR 12[ebp]
	mov	edx, 1
	mov	ecx, eax
	sal	edx, cl
	mov	eax, edx
	mov	DWORD PTR -180[ebp], eax
	mov	DWORD PTR -188[ebp], 1
	jmp	.L2
.L8:
	mov	BYTE PTR -172[ebp], 0
	mov	DWORD PTR -184[ebp], 0
	jmp	.L3
.L5:
	mov	eax, DWORD PTR -184[ebp]
	mov	edx, DWORD PTR -188[ebp]
	mov	ecx, eax
	sar	edx, cl
	mov	eax, edx
	and	eax, 1
	test	eax, eax
	je	.L4
	mov	eax, DWORD PTR -184[ebp]
	lea	edx, 0[0+eax*4]
	mov	eax, DWORD PTR -204[ebp]
	add	eax, edx
	mov	eax, DWORD PTR [eax]
	sub	esp, 8
	push	eax
	lea	eax, -172[ebp]
	push	eax
	call	strcat@PLT
	add	esp, 16
.L4:
	add	DWORD PTR -184[ebp], 1
.L3:
	mov	eax, DWORD PTR -184[ebp]
	cmp	eax, DWORD PTR 12[ebp]
	jl	.L5
	sub	esp, 12
	lea	eax, -172[ebp]
	push	eax
	call	strlen@PLT
	add	esp, 16
	mov	DWORD PTR -176[ebp], eax
	sub	esp, 8
	push	DWORD PTR -176[ebp]
	lea	eax, -172[ebp]
	push	eax
	call	is_palindrome@PLT
	add	esp, 16
	test	eax, eax
	je	.L6
	mov	eax, DWORD PTR -176[ebp]
	cmp	eax, DWORD PTR -192[ebp]
	jg	.L7
	mov	eax, DWORD PTR -176[ebp]
	cmp	eax, DWORD PTR -192[ebp]
	jne	.L6
	sub	esp, 8
	lea	eax, best.0@GOTOFF[ebx]
	push	eax
	lea	eax, -172[ebp]
	push	eax
	call	strcmp@PLT
	add	esp, 16
	test	eax, eax
	jns	.L6
.L7:
	sub	esp, 8
	lea	eax, -172[ebp]
	push	eax
	lea	eax, best.0@GOTOFF[ebx]
	push	eax
	call	strcpy@PLT
	add	esp, 16
	mov	eax, DWORD PTR -176[ebp]
	mov	DWORD PTR -192[ebp], eax
.L6:
	add	DWORD PTR -188[ebp], 1
.L2:
	mov	eax, DWORD PTR -188[ebp]
	cmp	eax, DWORD PTR -180[ebp]
	jl	.L8
	lea	eax, best.0@GOTOFF[ebx]
	mov	edx, DWORD PTR -12[ebp]
	sub	edx, DWORD PTR gs:20
	je	.L10
	call	__stack_chk_fail_local
.L10:
	mov	ebx, DWORD PTR -4[ebp]
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	composite_palindrome, .-composite_palindrome
	.local	best.0
	.comm	best.0,160,32
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB1:
	.cfi_startproc
	mov	ebx, DWORD PTR [esp]
	ret
	.cfi_endproc
.LFE1:
	.hidden	__stack_chk_fail_local
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
