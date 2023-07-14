SECTION .text
global	_sub

extern	getw, getdw, putw, putdw
extern	pres

; void _sub()
; calls right sub
_sub:
	enter	0, 0
	cmp byte [pres], '0'
	je		p16
	call	_sub32
	jmp		_sub_end
p16:
	call	_sub16
_sub_end:
	leave
	ret

; void _sub16()
; reads two int16 and prints sub
%define num1 word [EBP-2]
_sub16:
	enter	2, 0
	call	getw
	mov		num1, ax
	call	getw
	mov		bx, ax
	mov		ax, num1
	sub		ax, bx
	push	ax
	call	putw
	leave
	ret

; void _sub32()
; reads two int32 and prints sub
%define num1 dword [EBP-4]
_sub32:
	enter 4, 0
	call	getdw
	mov		num1, eax
	call	getdw
	sub		num1, eax
	push	eax
	call	putdw
	leave
	ret
