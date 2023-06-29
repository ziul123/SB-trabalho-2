SECTION .text
global	_sum

extern	getw, getdw, putw, putdw
extern	pres

; void _sum()
; calls right sum
_sum:
	enter	0, 0
	cmp byte [pres], '0'
	je		p16
	call	_sum32
	jmp		_sum_end
p16:
	call	_sum16
_sum_end:
	leave
	ret

; void _sum16()
; reads two int16 and prints sum
%define num1 word [EBP-2]
_sum16:
	enter	2, 0
	call	getw
	mov		num1, ax
	call	getw
	add		ax, num1
	push	ax
	call	putw
	leave
	ret

; void _sum32()
; reads two int32 and prints sum
%define num1 dword [EBP-4]
_sum32:
	enter 4, 0
	call	getdw
	mov		num1, eax
	call	getdw
	add		eax, num1
	push	eax
	call	putdw
	leave
	ret
