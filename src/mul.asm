SECTION .text
global	_mul

extern	getw, getdw, putw, putdw, puts
extern	pres, of

; void _mul()
; calls right mul
_mul:
	enter	0, 0
	cmp byte [pres], '0'
	je		p16
	call	_mul32
	jmp		_mul_end
p16:
	call	_mul16
_mul_end:
	leave
	ret

; void _mul16()
; reads two int16 and prints mul
%define num1 word [EBP-2]
_mul16:
	enter	2, 0
	call	getw
	mov		num1, ax
	call	getw
	imul	num1
	jo		overflow
	push	ax
	call	putw
	leave
	ret

; void _mul32()
; reads two int32 and prints mul
%define num1 dword [EBP-4]
_mul32:
	enter 4, 0
	call	getdw
	mov		num1, eax
	call	getdw
	imul	num1
	jo		overflow
	push	eax
	call	putdw
	leave
	ret

overflow:
	push	of
	call	puts
	mov		eax, 1
	mov		ebx, 1
	int		0x80
