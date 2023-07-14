SECTION .data
global	of
msg1 db		"Bem vindo. Digite seu nome: ", 0
msg2 db 	"Hola, ", 0
msg3 db 	", bem-vindo ao programa de CALC IA-32", 0xA, 0
msg4 db		"Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32): ", 0
menu1 db	"ESCOLHA UMA OPÇÃO:", 0xA, 0
menu2 db	"- 1: SOMA", 0xA, 0
menu3 db	"- 2: SUBTRACAO", 0xA, 0
menu4 db	"- 3: MULTIPLICACAO", 0xA, 0
menu5 db	"- 4: DIVISAO", 0xA, 0
menu6 db	"- 5: EXPONENCIACAO", 0xA, 0
menu7 db	"- 6: MOD", 0xA, 0
menu8 db	"- 7: SAIR", 0xA, 0
of db		"OCORREU OVERFLOW", 0xA, 0

SECTION .bss
global	pres
opt	resb	2	;opção do menu
pres resb	2	;precisão escolhida: 0x30->16, 0x31->32
nome resb	101	;nome do usuário

SECTION .text
global	_start

extern	puts, gets
extern	_sum, _sub, _mul, _div, _exp, _mod

_start:
	push	msg1
	call	puts

	;ler nome do usuário
	push dword 100
	push	nome
	call	gets

	push	msg2
	call	puts

	;print nome do usuário
	push	nome
	call	puts

	push	msg3
	call	puts
	push	msg4
	call	puts

	;ler precisão
	mov		eax, 3
	mov		ebx, 0
	mov		ecx, pres
	mov		edx, 2
	int		0x80

menu:
	push	menu1
	call	puts
	push	menu2
	call	puts
	push	menu3
	call	puts
	push	menu4
	call	puts
	push	menu5
	call	puts
	push	menu6
	call	puts
	push	menu7
	call	puts
	push	menu8
	call	puts

	;ler opção
	mov		eax, 3
	mov		ebx, 0
	mov		ecx, opt
	mov		edx, 2
	int		0x80

	cmp byte [opt], '1'
	je		Osum
	cmp byte [opt], '2'
	je		Osub
	cmp byte [opt], '3'
	je		Omul
	cmp byte [opt], '4'
	je		Odiv
	cmp byte [opt], '5'
	je		Oexp
	cmp byte [opt], '6'
	je		Omod

	mov		eax, 1
	mov		ebx, 0
	int		0x80

Osum:
	call	_sum
	jmp		menu
Osub:
	call	_sub
	jmp		menu
Omul:
	call	_mul
	jmp		menu
Odiv:
	call	_div
	jmp		menu
Oexp:
	call	_exp
	jmp		menu
Omod:
	call	_mod
	jmp		menu
