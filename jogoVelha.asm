jmp main

full: var #1

v0 : string "          "

x1 : string "X        X"
x2 : string " X      X "
x3 : string "  X    X  "
x4 : string "   X  X   "
x5 : string "    XX    "

o1 : string "    OO    "
o2 : string "   OOOO   "               
o3 : string "  O    O  "
o4 : string " O      O " ; essa string deve ser impressa 3 vezes seguidas

instruction0 : string "-Pressione Espaco Para Iniciar-"
instruction1 : string " Enter para fazer a jogada e numeros do    teclado para selecionar a posicao"

vetPos : var #10
	static vetPos + #0, #2
	static vetPos + #1, #2
	static vetPos + #2, #2
	static vetPos + #3, #2
	static vetPos + #4, #2
	static vetPos + #5, #2
	static vetPos + #6, #2
	static vetPos + #7, #2
	static vetPos + #8, #2
	static vetPos + #9, #2

vetPix : var #10
	static vetPix + #0, #0
	static vetPix + #1, #5
	static vetPix + #2, #15
	static vetPix + #3, #25
	static vetPix + #4, #365
	static vetPix + #5, #375
	static vetPix + #6, #385
	static vetPix + #7, #725
	static vetPix + #8, #735
	static vetPix + #9, #745

; notas sobre as posições da tela
;5   15  25
;365 375 385
;725 735 745


main:
	;imprime inst0
	loadn r0, #525
	loadn r1, #instruction0
	loadn r2, #3328
	call Imprimestr 
	
	;imprime inst1
	loadn r0, #560
	loadn r1, #instruction1
	loadn r2, #3584
	call Imprimestr 
	
	init:;le espaço p/ iniciar
		call keyboard
		loadn r5, #' '
		cmp r3, r5
		ceq startGame
		halt

;-------------------------------------startGame------------------------------------------
startGame:
	push r5
	push r6
	push r7
	
	call clrScrn ;limpa a tela
	loadn r6, #9 ;r6 guarda 9 para ver se o tabuleiro esta cheio
	loadn r7, #0
	loopStart:
		;verifica se o tabuleiro está cheio
		loadn r5, #full
		loadi r5, r5
		cmp r5, r6
		jeq endGame
		
		call turn
		not r7, r7 ;if 0, r7 = 1 && if 1, r7 = 0
		jmp loopStart ;proximo turno
		
	endGame:
		pop r7
		pop r6
		pop r5
		rts
		
printDebug:
	push r6
	push r7
	
	loadn r7, #1
	loadn r6, #'@'
	;mov r6, r3
	;mov r7, r3
	
	outchar r6, r7
	
	pop r7
	pop r6
	rts

;-------------------------------------turn------------------------------------------
turn:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	
	loopTurn:
		call keyboard ;Le posicao
		newTry:
		loadn r6, #48 ;subtrai 48 p/ chegar ao numero
		sub r3, r3, r6
		loadn r6, #9
		cmp r3, r6
		jgr loopTurn ;se posicao > 9, volta
		
		loadn r5, #vetPos
		add r5, r5, r3 ; soma a posição ao vetor
		loadi r5, r5 ;carrega a presença na posicao
		loadn r6, #2
		cmp r5, r6
		jne loopTurn ;se hover algo que não seja 2 na posição, volta
		
		;printar na posição
		loadn r5, #vetPix
		add r5, r5, r3 ; soma a posição ao vetor
		loadi r0, r5
		loadn r2, #2304 ;cor nao selecionado
		call print
		call keyboard
		call clrSelection
		loadn r5, #13
		cmp r3, r5
		jne newTry
		
		loadn r2, #3584
		call print
		rts
		;mov r4, r3 ;posicao em r4
		
clrSelection:
	push r0 ;posicao de print
	push r1 ;string
	push r4 ;contador
	
	loadn r4, #40
	
	loadn r1, #v0
	call Imprimestr
	
	add r0, r0, r4
	call Imprimestr
	add r0, r0, r4
	call Imprimestr
	add r0, r0, r4
	call Imprimestr
	add r0, r0, r4
	call Imprimestr
	add r0, r0, r4
	call Imprimestr
	add r0, r0, r4
	call Imprimestr
	add r0, r0, r4
	call Imprimestr
	add r0, r0, r4
	call Imprimestr
	
	pop r4
	pop r1
	pop r0
	rts
print:
	push r0 ;posicao de print
	push r5 ;verifica turno do x ou o
	push r4	;contador
	
	loadn r4, #40
	
	loadn r5, #1
	cmp r5, r7
	jeq oPrint
	
	;turno do x
	loadn r1, #x1
	call Imprimestr
	
	add r0, r0, r4
	loadn r1, #x2
	call Imprimestr
	
	add r0, r0, r4
	loadn r1, #x3
	call Imprimestr
	
	add r0, r0, r4
	loadn r1, #x4
	call Imprimestr
	
	add r0, r0, r4
	loadn r1, #x5
	call Imprimestr
	
	add r0, r0, r4
	loadn r1, #x4
	call Imprimestr
	
	add r0, r0, r4
	loadn r1, #x3
	call Imprimestr
	
	add r0, r0, r4
	loadn r1, #x2
	call Imprimestr
	
	add r0, r0, r4
	loadn r1, #x1
	call Imprimestr
	
	jmp endPrint
	
	oPrint:
		loadn r1, #o1
		call Imprimestr
		
		add r0, r0, r4
		loadn r1, #o2
		call Imprimestr
		
		add r0, r0, r4
		loadn r1, #o3
		call Imprimestr
		
		add r0, r0, r4
		loadn r1, #o4
		call Imprimestr
		
		add r0, r0, r4
		loadn r1, #o4 
		call Imprimestr
		
		add r0, r0, r4
		loadn r1, #o4
		call Imprimestr
		
		add r0, r0, r4
		loadn r1, #o3
		call Imprimestr
		
		add r0, r0, r4
		loadn r1, #o2
		call Imprimestr
		
		add r0, r0, r4
		loadn r1, #o1
		call Imprimestr
		jmp endPrint
		
	endPrint:
		pop r4
		pop r5
		pop r0
		
		rts

keyboard:
	push r5
	loadn r5, #255
	keyLoop:
		inchar r3
		cmp r3, r5 ;se r3 == 255 ler dnv
		jeq keyLoop
	pop r5
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