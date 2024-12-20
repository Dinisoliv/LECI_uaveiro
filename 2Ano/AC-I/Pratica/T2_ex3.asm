# Mapa de registos:
# nv: $a0
# pt: $a1
# i: $t0
# j: $t1
# sum: $f2
# inter: $t3, $t4, $t5, $f4, $f6
	.data
	
const:	.double 0.0
	
	.text
	.globl func3
func3:
	la $t3, const
	l.d $f2, 0($t3)	

	li $t0, 0
for:
	bge $t0, $a0, endf
	
	li $t1, 0
do:
	addu $t4, $a1, $t1
	lb $t3, 16($t4)
	
	mtc1 $t3, $f4
	cvt.d.w $f4, $f4
	add.d $f2, $f2, $f4
	
	addiu $t1, $t1, 1
	
	lb $t5, 4($a1)
	blt $t1, $t5, do
	
	l.d $f4, 8($a1)
	div.d $f6, $f2, $f4
	cvt.w.d $f6, $f6
	s.d $f6, 0($a1)
	
	addiu $t0, $t0, 1
	addiu $a1, $a1, 40
endf:
	lw $t4, 32($t3)
	
	mtc1 $t4, $f6
	cvt.d.w $f6, $f6
	mul.d $f0, $f4, $f6 
	
	jr $ra