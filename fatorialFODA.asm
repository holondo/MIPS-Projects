	.data
	.align 0
	
hello:	.asciiz "Digite seu nro\n"
result:	.asciiz "O resultado é:\n"

	.text
	.globl main
	
main:	li $v0, 4
	la $a0, hello
	syscall
	
	li $v0, 5
	syscall
	
	move $a0, $v0
	
	addi $a1, $a0, -1
	
	addi $a2, $zero, 1
	
	jal fatorial
	
	move $t0, $v0
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	j finish
	
	
fatorial:	beq $a1, $a2, exit
	 	mul $a0, $a0, $a1
	 	addi $a1, $a1, -1
	 	j fatorial
exit:	move $v0, $a0
	jr $ra
	
finish: li $v0, 10
	syscall
