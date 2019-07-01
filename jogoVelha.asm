
jmp main

x1 : string "X        X"
x2 : string " X      X "
x3 : string "  X    X  "
x4 : string "   X  X   "
x5 : string "    XX    "

o1 : string "    OO    "
o2 : string "   OOOO   "               
o3 : string "  O    O  "
o4 : string " O      O " ; 3 vezes

instruction : string " Enter para fazer a jogada e numeros do    teclado para selecionar a posicao"

main:

	loadn r0, #560
	loadn r1, #instruction
	loadn r2, #3584
	
	call Imprimestr 
	call readIni

	halt

readIni:
	push r0
	push r1
	
	loopReadIni:
		inchar r0
		
		loadn r1, #' ';verifica espaço
		cmp r0, r1
		jne notSpace;Se for enter:
		call startGame
		jmp readIniEnd
		
		notSpace :

		jmp loopReadIni
		
		
	readIniEnd :
	pop r1
	pop r0
rts

startGame:
	call clrScrn
	rts
	
	
clrScrn:
	push r0
	push r1
	
	loadn r0, #1200
	loadn r1, #' '
	
	clrLoop:
		dec r0
		outchar r1, r0
		jnz clrLoop
		
	pop r1
	pop r0
rts

Imprimestr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

ImprimestrLoop:	
	loadi r4, r1
	cmp r4, r3
	jeq ImprimestrSai
	add r4, r2, r4
	outchar r4, r0
	inc r0
	inc r1
	jmp ImprimestrLoop
	
ImprimestrSai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts