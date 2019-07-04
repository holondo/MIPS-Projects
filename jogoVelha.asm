jmp main

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
	static vetPos + #0, #0
	static vetPos + #1, #0
	static vetPos + #2, #0
	static vetPos + #3, #0
	static vetPos + #4, #0
	static vetPos + #5, #0
	static vetPos + #6, #0
	static vetPos + #7, #0
	static vetPos + #8, #0
	static vetPos + #9, #0

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

; notas sobre as posições da tela
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
		loadn r1, #' '
		cmp r0, r1
		jne notSpace
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
			loadn r7, #1
			call turn
rts

turn:
	push r0
	push r1 
	push r2 
	push r3
	push r4
	push r5
	
loopTurn:
	loadn r3, #5
	;inchar r3 ;le posição desejada
	otherTry:
	loadn r4, #vetPos ;carrega o vetor em $r4
	add r4, r4, r3 ; soma a posição ao vetor
	loadi r5, r4 ;carrega $r4 (que o endereço p/ vetPos) em $r5
	
	loadn r6, #0
	cmp r5,r6
	jne loopTurn ;loop se ja estiver ocupado
	
	loadn r4, #vetPix ;carrega o vetor em $r4
	add r4, r4, r3 ; soma a posição ao vetor
	loadi r0, r4 ;carrega posicao
	loadn r2, #256 ;cor de não selecionado
	
	call print
	
	inchar r3
	call verifyChange
	halt
	
	verifyChange:
		push r4
		
		loadn r4, #13
		
		cmp r4, r3
		jne otherTry
		
		;confirmar
		loadn r2, #3584
		call print
		
		pop r4
		rts
		
	
	;jmp loopPrint
	
print:
	push r0 ;posicao de print
	push r3 ;verifica turno do x ou o
	push r4	;contador
	
	loadn r4, #40
	
	loadn r3, #1
	cmp r3, r7
	jne oPrint
	
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
		pop r0
		pop r3
		pop r4
		
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
	
	
	
	