	.data
	.align 0
opt:	.byte
strini:	.asciiz  "\nEscolha uma opcao:\n \n1: Soma de 2 numeros\n2: Subtracao de 2 numeros\n3: Multiplicacao de 2 numeros\n4: Divisao de 2 numeros\n5: Potencia\n6: Raiz Quadrada\n7: Tabuada de 1 numero\n8: IMC\n9: Fatorial\n10: Fibonacci\n0: ENCERRAR\n"
strdois:.asciiz  "Digite 2 numeros:\n"
strum:	.asciiz  "Digite um numero:\n"
strres: .asciiz  "O resultado é: "
stresp:	.asciiz  "\nPressione uma tecla...\n"
	
	.text
	.globl main

main:	jal inicio
	j final

final:	li $v0, 10
	syscall
	
inicio:	li $v0, 4
	la $a0, strini
	syscall
	
	li $v0, 5 
	syscall #le a opcao
	
	move $t0, $zero
	
	beq $v0, $t0, final #Opçao saida
	addi $t0, $t0, 1
	
	beq $v0, $t0, soma #Opçao soma
	addi $t0, $t0, 1
	
	beq $v0, $t0, sub #Opçao subtracao
	addi $t0, $t0, 1
	
	beq $v0, $t0, mult #Opçao multiplicacao
	addi $t0, $t0, 1
	
	beq $v0, $t0, div #Opçao divisao
	addi $t0, $t0, 1
	
	beq $v0, $t0, pot #Opçao potencia
	addi $t0, $t0, 1
	
	#beq $v0, $t0, raiz #Opçao raiz
	#addi $t0, $t0, 1
	
	beq $v0, $t0, tab #Opçao tabuada
	addi $t0, $t0, 1
	
	
	
	jr $ra
	
espera:	li $v0, 4
	la $a0, stresp
	syscall
	li $v0, 12
	syscall
	j inicio
	
soma:	li $v0, 4
	la $a0, strdois
	syscall
	
	li $v0, 5
	syscall #le o primeiro numero
	move $t0, $v0
	
	li $v0, 5
	syscall #le o segundo numero
	move $t1, $v0
	
	li $v0, 4
	la $a0, strres
	syscall
	
	add $a0, $t0, $t1
	
	li $v0, 1
	syscall #imprime resultado
	
	j espera
	
sub:	li $v0, 4
	la $a0, strdois
	syscall
	
	li $v0, 5
	syscall #le o primeiro numero
	move $t0, $v0
	
	li $v0, 5
	syscall #le o segundo numero
	move $t1, $v0
	
	li $v0, 4
	la $a0, strres
	syscall
	
	sub $a0, $t0, $t1
	
	li $v0, 1
	syscall #imprime resultado
	
	j espera

mult:	li $v0, 4
	la $a0, strdois
	syscall
	
	li $v0, 5
	syscall #le o primeiro numero
	move $t0, $v0
	
	li $v0, 5
	syscall #le o segundo numero
	move $t1, $v0
	
	li $v0, 4
	la $a0, strres
	syscall
	
	mul $a0, $t0, $t1
	
	li $v0, 1
	syscall #imprime resultado
	
	j espera
	
div:	li $v0, 4
	la $a0, strdois
	syscall
	
	li $v0, 5
	syscall #le o primeiro numero
	move $t0, $v0
	
	li $v0, 5
	syscall #le o segundo numero
	move $t1, $v0
	
	li $v0, 4
	la $a0, strres
	syscall
	
	div $a0, $t0, $t1
	
	li $v0, 1
	syscall #imprime resultado
	
	j espera
	
pot:	li $v0, 4
	la $a0, strdois
	syscall
	
	li $v0, 5
	syscall #le o primeiro numero
	move $t0, $v0
	
	li $v0, 5
	syscall #le o segundo numero
	move $t1, $v0
	
	li $v0, 4
	la $a0, strres
	syscall
	
	move $a0, $t0
loopot:
	sub $t1, $t1, 1
	beqz $t1, sloopot
	mul $a0, $a0, $t0
	j loopot
	
sloopot:
	li $v0, 1
	syscall #imprime resultado
	
	j espera
	
tab:	li $v0, 4
	la $a0, strum
	syscall
	
	li $v0, 5
	syscall #le o numero
	move $t0, $v0	
	
	li $v0, 4
	la $a0, strres
	syscall
	
	move $a0, $t0
	li $t1, 1 # carrega o numero 1
	li $t2, 10 #carrega o 10 para ser usado no loop
looptab:
	mul $a0, $t0, $t1
	
	li $v0, 1
	syscall
	
	beq $t1, $t2, slooptab
	addi $t1, $t1, 1
	j looptab
	
slooptab:
	
	j espera
	
