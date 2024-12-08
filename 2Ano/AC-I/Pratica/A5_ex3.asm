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
	la $t0, array               # Reset pointer to start of array
	
bubble_sort_loop:	
	li $t4, FALSE               # Initialize swap flag to FALSE

	li $t5, 0                   # Initialize index i to 0
	
	li $t2, SIZE
	addi $t2, $t2, -1 
inner_loop:
	bge $t5, $t2, end_inner_loop  # Loop until index exceeds array size

compare_elements:
	sll $t1, $t5, 2             # Calculate offset for element at index i
	addu $t7, $t0, $t1          # Calculate address of element at index i
	lw $t8, 0($t7)              # Load array[i]
	lw $t9, 4($t7)              # Load array[i + 1]
	
	ble $t8, $t9, end_compare   # If array[i] <= array[i+1], skip swapping
	#bleu $t8, $t9, end_compare # swap unsigned
	
	sw $t9, 0($t7)              # Swap elements
	sw $t8, 4($t7)
	
	li $t4, TRUE                # Set swap flag to TRUE

end_compare:
	addi $t5, $t5, 1	     # Move to next index
	
	j inner_loop

end_inner_loop:
	bne $t4, $0, bubble_sort_loop  # Repeat if a swap was made
	
	
	li $v0, print_string
	la $a0, array_contents
	syscall
	
	la $t0, array               # Reset pointer to start of array
	
	li $t3, SIZE                # Set size of array in words
	sll $t3, $t3, 2             # Convert size to bytes
	add $t2, $t0, $t3           # Calculate end address of array
	
	
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
