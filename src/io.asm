SECTION .bss
local_str resb 13	;max len of int32 str + \n + \0

SECTION .text
global	puts, putw, putdw, gets, getw, getdw

; void puts(char* str)
; prints str
puts:
	enter 	0, 0
	push dword [EBP+8]
    call    strlen

    mov     edx, eax
    mov     ecx, [EBP+8]
    mov     ebx, 1
    mov     eax, 4
    int     0x80

	leave
    ret		4

; int strlen(char* str)
; returns length of str
strlen:
	enter 	0, 0
	mov 	eax, [EBP+8]

strlen_loop:
	cmp 	byte [eax], 0
	jz		strlen_end
	inc		eax
	jmp 	strlen_loop

strlen_end:
	sub 	eax, [EBP+8]
	leave
	ret		4

; void putw(int16 x)
; prints x
%define num_str dword [EBP-4]
putw:
	enter	4, 0
	mov		num_str, local_str
	
	mov		ax, [EBP+8]
	xor		ecx, ecx
	mov		ebx, num_str
	mov		si, 10
	cmp		ax , 0
	jge		putw_loop1
	mov byte [ebx], '-'
	inc		ebx
	neg		ax

putw_loop1:
	cwd
	idiv	si
	add		dx, 0x30
	push	dx
	inc		ecx
	cmp		ax, 0
	je		putw_nt
	jmp		putw_loop1

putw_nt:
	mov word [ebx+ecx], 0x000A

putw_loop2:
	pop		dx
	mov		[ebx], dl
	inc		ebx
	dec		ecx
	jnz		putw_loop2

	push	num_str
	call	puts

	leave
	ret 2

; void putdw(int32 x)
; prints x
%define num_str dword [EBP-4]
putdw:
	enter	4, 0
	mov		num_str, local_str
	
	mov		eax, [EBP+8]
	xor		ecx, ecx
	mov		ebx, num_str
	mov		esi, 10
	cmp		eax , 0
	jge		putdw_loop1
	mov byte [ebx], '-'
	inc		ebx
	neg		eax

putdw_loop1:
	cdq
	idiv	esi
	add		edx, 0x30
	push	edx
	inc		ecx
	cmp		eax, 0
	je		putdw_nt
	jmp		putdw_loop1

putdw_nt:
	mov word [ebx+ecx], 0x000A

putdw_loop2:
	pop		edx
	mov		[ebx], dl
	inc		ebx
	dec		ecx
	jnz		putdw_loop2

	push	num_str
	call	puts

	leave
	ret 4

; void gets(char* str, int size)
; reads string from keyboard and stores in str
gets:
	enter	0, 0

	mov		eax, 3
	mov		ebx, 0
	mov		ecx, [EBP+8]
	mov		edx, [EBP+12]
	int		0x80

	mov		ebx, [EBP+8]
	mov byte [ebx+eax-1], 0

	leave
	ret		8

; int16 getw()
; reads 16 bit int from keyboard
%define num_str dword [EBP-4]
%define is_neg word [EBP-6]
getw:
	enter	6, 0
	mov		num_str, local_str

	push dword 12
	push 	num_str
	call	gets

	xor		ax, ax
	xor		ecx, ecx
	xor		dx, dx
	mov		ebx, num_str
	cmp byte [ebx], '-'	;is negative?
	sete	dl
	mov		is_neg, dx
	jne		getw_loop
	inc		ecx
	
getw_loop:
	sub byte [ebx+ecx], 0x30
	add		al, [ebx+ecx]
	adc		ah, 0

	cmp byte [ebx+ecx+1], 0
	je		getw_l_end
	mov		dx, ax
	sal		ax, 2
	add		ax, dx
	add		ax, ax		;ax = ax*10
	inc		ecx
	jmp		getw_loop

getw_l_end:
	cmp		is_neg, 0
	je		getw_end
	neg		ax
getw_end:
	leave
	ret

; int32 getdw()
; reads 32 bit int from keyboard
%define num_str dword [EBP-4]
%define is_neg word [EBP-6]
getdw:
	enter	6, 0
	mov		num_str, local_str

	push dword 12
	push 	num_str
	call	gets

	xor		eax, eax
	xor		ecx, ecx
	xor		dx, dx
	mov		ebx, num_str
	cmp byte [ebx], '-'	;is negative?
	sete	dl
	mov		is_neg, dx
	jne		getdw_loop
	inc		ecx
	
getdw_loop:
	sub byte [ebx+ecx], 0x30
	movsx	edx, byte [ebx+ecx]
	add		eax, edx

	cmp byte [ebx+ecx+1], 0
	je		getdw_l_end
	mov		edx, eax
	sal		eax, 2
	add		eax, edx
	add		eax, eax		;eax = eax*10
	inc		ecx
	jmp		getdw_loop

getdw_l_end:
	cmp		is_neg, 0
	je		getdw_end
	neg		eax
getdw_end:
	leave
	ret
