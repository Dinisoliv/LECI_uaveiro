	.data
	
const:	.float -1.0, 1.0, 0.0
	
	.text
	.globl func2
# Mapa de registo:
# a: $a0
# t: $f12
# n: $a1
# oldg: $f2
# g: $f4
# s: $f6
# k: $t0
# $f8: inter
# $f10: a[k]
func2:
	la $t1, const
	l.s $f2, 0($t1)
	l.s $f4, 4($t1)
	l.s $f6, 8($t1)
	
	li $t0, 0
for:
	bge $t0, $a1, endf
	
while:	sub.s $f8, $f4, $f2
	c.le.s $f8, $f12
	bc1t endw

	mov.s $f2, $f4
	
	sll $t2, $t0, 2
	add $t2, $a0, $t2
	l.s $f10, 0($t2)
	
	add.s $f8, $f4, $f10
	div.s $f4, $f8, $f12
	
	j while
endw:
	add.s $f6, $f6, $f4
	
	sll $t2, $t0, 2
	add $t2, $a0, $t2
	s.s $f4, 0($t2)
	
	addiu $t0, $t0, 1
	j for
endf:
	mtc1 $a1, $f8
	cvt.s.w $f8, $f8
	
	div.s $f0, $f6, $f8

	jr $ra