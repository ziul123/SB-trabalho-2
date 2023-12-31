SECTION .text
global	_exp

extern	getw, getdw, putw, putdw, puts
extern	pres, of

; void _exp()
; calls right exp
_exp:
	enter	0, 0
	cmp byte [pres], '0'
	je		p16
	call	_exp32
	jmp		_exp_end
p16:
	call	_exp16
_exp_end:
	leave
	ret

; void _exp16()
; reads two int16 and prints exp
%define num1 word [EBP-2]
_exp16:
	enter	2, 0
	call	getw
	mov		num1, ax
	call	getw

	cmp 	ax, 0
	jl 		ltz0

	mov 	cx, ax
	mov 	ax, 1
ls0:
		test cx, cx
		jz   le0
		imul num1
		jo	 overflow
		dec  cx
		jmp  ls0

ltz0:
	mov 	ax, 0
le0:
	push	ax
	call	putw
	leave
	ret

; void _exp32()
; reads two int32 and prints exp
%define num1 dword [EBP-4]
_exp32:
	enter 4, 0
	call	getdw
	mov		num1, eax
	call	getdw

	cmp		eax, 0
	jl  	ltz1

	mov 	ecx, eax
	mov 	eax, 1
ls1:
		test ecx, ecx
		jz   le1
		imul num1
		jo   overflow
		dec  ecx
		jmp  ls1

ltz1:
	mov 	eax, 0
le1:
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
