	.data
	.align 0
	
hello:	.asciiz "Digite seu nro\n"
result:	.asciiz "O resultado é:\n"

	.text
	.globl main
	
main:	
	li $v0, 4
	la $a0, hello
	syscall
	
	li $v0, 5
	syscall
	
	addi $a0, $v0, -1
	li $a1, 1
	
	jal fat
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
fat: 	
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, -4($sp)
	
	beq $a0, $a1, exit
	
	mul $v0, $v0, $a0
	
	addi $a0, $a0, 1
	
	jal fat	
	
	lw $ra, -4($sp)
	lw $a0, 0($sp)
	addi $sp, $sp, 8
	
exit:	jr $ra
	