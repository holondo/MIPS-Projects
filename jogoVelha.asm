
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

instruction0 : string "-Pressione Espaco Para Iniciar-"
instruction1 : string " Enter para fazer a jogada e numeros do    teclado para selecionar a posicao"

vetPos : var #9

vetPix : var #10
	static vetPix + #0, #0
	static vetPix + #1, #5
	static vetPix + #2, #15
	static vetPix + #3, #15
	static vetPix + #4, #365
	static vetPix + #5, #375
	static vetPix + #6, #385
	static vetPix + #7, #725
	static vetPix + #8, #735
	static vetPix + #9, #745

;5   15  25
;365 375 385
;725 735 745
main:

	loadn r0, #525
	loadn r1, #instruction0
	loadn r2, #3328
	
	call Imprimestr 
	
	loadn r0, #560
	loadn r1, #instruction1
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
	
	gameLoop:
		xTime:
			call printX

rts
	

printX:
	push r0
	push r1 
	push r2 
	push r3
	push r4
	push r5
	
loopPrint:	
	inchar r3 ;le posição desejada
	loadn r6, #85
	outchar r3, r6
	loadn r4, #vetPos ;carrega o vetor em $r4
	add r4, r4, r3 ; soma a posição ao vetor
	loadi r4, r4 ;carrega o conteudo de r4 em r4
	loadn r5, #0
	cmp r4,r5
	
	jeq loopPrint ;loop se ja estiver ocupado
	
	loadn r4, #vetPix ;carrega o vetor em $r4
	add r4, r4, r3 ; soma a posição ao vetor
	
	loadi r0, r4 ;carrega a posiçao de print
	loadn r1, #x1
	loadn r2, #2304
	
	call Imprimestr
	jmp loopPrint
	
	halt
	
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