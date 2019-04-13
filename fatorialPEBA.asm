	.data
	.align 0
strdigite: .asciiz "Insert a number:\n"
strres: .asciiz "The factorial is: "

	.text
	.globl main
	
main:	li $v0, 4
	la $a0, strdigite
	syscall #print the input calling
	
	li $v0, 5
	syscall #reads the number
	
	move $a0, $v0
	move $t0, $a0
	
	addi $t1, $zero, 1
	
	j fatorial

final:	li $v0, 4
	la $a0, strres
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall #ending the program
	
fatorial:
	beq $a0, $t1, final  #fazer o return1
	
	addi $a0, $a0, -1
	mul $t0, $t0, $a0
	
	j fatorial