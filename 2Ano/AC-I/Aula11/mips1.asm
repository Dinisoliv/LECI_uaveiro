	.data
	
stg:
    	.word 72343               # id_number
    	.asciiz "Napoleao"        # first_name (até 18 caracteres)
    	.space 9                  # Completar os 18 bytes para alinhamento 
   	.asciiz "Bonaparte"       # last_name (até 15 caracteres)
    	.space 5                  # Completar os 15 bytes para alinhamento
    	.space 3		   # opcional	
    	.float 5.1                # grade
	
nLine: 	.asciiz "\n"          # Quebra de linha
nmecL: 	.asciiz "N. Mec: "
nameL: 	.asciiz "Nome: "
notaL: 	.asciiz "Nota: "
comma: 	.asciiz ","
	
	.text
	.globl main
	
main:
	la $t0, stg
	
	li $v0, 4
	la $a0, nmecL
	syscall
	
	#print_int10(stg.id_number)
	li $v0, 36
	lw $a0, 0($t0)
	syscall
	
	li $v0, 4
	la $a0, nLine
	syscall
	li $v0, 4
	la $a0, nameL
	syscall 
	
	#print_string(stg.last_name)
	li $v0, 4
	addiu $a0, $t0, 22
	syscall
	
	li $v0, 4
	la $a0, comma
	syscall
	
	#print_string(stg.first_name)
	li $v0, 4
	addiu $a0, $t0, 4
	syscall
	
	li $v0, 4
	la $a0, nLine
	syscall
	
	li $v0, 4
	la $a0, notaL
	syscall
	
	#print_float(stg.grade)
	li $v0, 2
	l.s $f12, 40($t0)
	syscall
	
	jr $ra 
	