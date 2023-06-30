SECTION .text
global	_mod

extern	getw, getdw, putw, putdw
extern	pres

; void _mod()
; calls right mod
_mod:
	enter	0, 0
	cmp byte [pres], '0'
	je		p16
	call	_mod32
	jmp		_mod_end
p16:
	call	_mod16
_mod_end:
	leave
	ret

; void _mod16()
; reads two int16 and prints mod
%define num1 word [EBP-2]
_mod16:
	enter	2, 0
	call	getw
	mov		num1, ax
	call	getw
	mov		bx, ax
	mov		ax, num1
	cwd				;extend sign of ax into dx
	idiv	bx
	push	dx		;mod in dx
	call	putw
	leave
	ret

; void _mod32()
; reads two int32 and prints mod
%define num1 dword [EBP-4]
_mod32:
	enter 4, 0
	call	getdw
	mov		num1, eax
	call	getdw
	mov		ebx, eax
	mov		eax, num1
	cdq				;extend sign of eax into edx
	idiv	ebx
	push	edx		;mod in edx
	call	putdw
	leave
	ret
