SECTION .text
global	_div

extern	getw, getdw, putw, putdw
extern	pres

; void _div()
; calls right div
_div:
	enter	0, 0
	cmp byte [pres], '0'
	je		p16
	call	_div32
	jmp		_div_end
p16:
	call	_div16
_div_end:
	leave
	ret

; void _div16()
; reads two int16 and prints div
%define num1 word [EBP-2]
_div16:
	enter	4, 0
	call	getw
	mov		num1, ax
	call	getw
	mov		bx, ax
	mov		ax, num1
	cwd				;extend sign of ax into dx
	idiv	bx
	push	ax
	call	putw
	leave
	ret

; void _div32()
; reads two int32 and prints div
%define num1 dword [EBP-4]
_div32:
	enter 4, 0
	call	getdw
	mov		num1, eax
	call	getdw
	mov		ebx, eax
	mov		eax, num1
	cdq				;extend sign of eax into edx
	idiv	ebx
	push	eax
	call	putdw
	leave
	ret
