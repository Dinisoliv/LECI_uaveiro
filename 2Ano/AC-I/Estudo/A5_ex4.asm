	.data
	
prompt_input:	.asciiz "\nIntroduza número: "
array_contents:	.asciiz "\nContéudo do array:\n "
separator:	.asciiz "; "
	
	.align 2
array:	.space 40
	
	.eqv SIZE, 10
	.eqv TRUE, 1
	.eqv FALSE, 0
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_int10, 1
	
	.text
	.globl main
	
main:
	la $t0, array               # Set pointer to start of array
	
	li $t2, SIZE                # Set size of array in words
	sll $t2, $t2, 2             # Convert size to bytes
	add $t2, $t0, $t2           # Calculate end address of array
	
input_loop:
	bge $t0, $t2, end_input_loop  # Loop until pointer reaches end of array
	
	li $v0, print_string
	la $a0, prompt_input
	syscall
	
	li $v0, read_int
	syscall
	
	sw $v0, 0($t0)              # Store input value in array
	
	addi $t0, $t0, 4            # Move to next position in array
	
	j input_loop
	
end_input_loop:
	
	la $t0, array
	
	li $t1, 9
	sll $t1, $t1, 2
	
	addu $t2, $t1, $t0
	
	
do_bubble:
	li $t3, FALSE
	
	la $t4, array

for_bubble:
	bge $t4, $t2, end_for_bubble
	
	lw $t5, 0($t4)
	lw $t6, 4($t4) 
if: 	
	ble $t5, $t6, endif
	
	move $t7, $t5
	sw $t6, 0($t4)
	sw $t7, 4($t4)
	li $t3, TRUE
	
endif:
	addiu $t4, $t4, 4
	
	j for_bubble
	
end_for_bubble:

	beq $t3, TRUE, do_bubble


output_loop:
	bge $t0, $t2, end_output_loop # Loop until pointer reaches end of array
	
	lw $t1, 0($t0)              # Load current array element
	
	li $v0, print_int10
	move $a0, $t1
	syscall
	
	li $v0, print_string
	la $a0, separator
	syscall
	
	addi $t0, $t0, 4            # Move to next position in array
	
	j output_loop
	
end_output_loop:
	
	jr $ra
