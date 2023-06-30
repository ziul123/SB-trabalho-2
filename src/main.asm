SECTION .data
msg1 db		"Bem vindo. Digite seu nome: ", 0
msg2 db 	"Hola, ", 0
msg3 db 	", bem-vindo ao programa de CALC IA-32", 0xA, 0
msg4 db		"Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32): ", 0
menu1 db	"ESCOLHA UMA OPÇÃO:", 0xA, 0
menu2 db	"- 1: SOMA", 0xA, 0
menu3 db	"- 2: SUBTRACAO", 0xA, 0
menu4 db	"- 3: MULTIPLICACAO", 0xA, 0
menu5 db	"- 4: DIVISAO", 0xA, 0xA, 0
menu6 db	"- 5: EXPONENCIACAO", 0xA, 0
menu7 db	"- 6: MOD", 0xA, 0
menu8 db	"- 7: SAIR", 0xA, 0
of db		"OCORREU OVERFLOW", 0xA, 0

SECTION .bss
nome resb	50	;nome do usuário
pres resb	1	;precisão escolhida: 0x30->16, 0x31->32
opt	resb	1	;opção do menu

SECTION .text
global	_start
global	pres, of

extern	puts
extern	_sum
extern	_sub
extern	_mul
extern	_div
extern	_exp
extern	_mod

_start:
	push	msg1
	call	puts
	;ler nome do usuário

	push	msg2
	call	puts
	;print nome do usuário

	push	msg3
	call	puts
	push	msg4
	call	puts
	;ler precisão

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
