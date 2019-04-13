	.data
	.align 0
str:	.asciiz "cu de curioso"

	.text 
	.globl main
	
main:	move $a0, $sp
	sw $a1, str

	jal strcpy
	
	la $a0, 0($sp)
	li $v0, 4
	syscall
	
strcpy:	lb $t0, $a1
	beqz $t0, exit
	
	sb $t0, 0($a0)
	addi $a1, $a1, 1
	addi $a0, $a0, 1
	
	j strcpy
	

exit: jr $ra