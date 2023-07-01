SECTION .bss
local_str resb 11	;max len of int32 str

SECTION .text
global	puts, putw, putdw, getw, getdw

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
putw:
	ret

; void putdw(int32 x)
; prints x
putdw:
	ret

; void gets(char* str, int size)
; reads string from keyboard and stores in str
gets:
	ret

; int16 getw()
; reads 16 bit int from keyboard
getw:
	ret

; int32 getdw()
; reads 32 bit int from keyboard
getdw:
	ret
