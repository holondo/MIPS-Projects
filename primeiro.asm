	.data
	.align 0
str1: .asciiz "quero "
str2: .asciiz "jatada de "
str3: .asciiz "leite na cara\n"

	.text 
	.globl main

main: li $v0, 4
	la $a0, str1
	syscall 
	
	la $a0, str2
	syscall
	
	la $a0, str3
	syscall  
	
	li $v0, 10