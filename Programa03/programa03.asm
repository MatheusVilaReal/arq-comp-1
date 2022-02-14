.data

msgA:
	.asciiz	"Insira A: "
	
msgB:
	.asciiz	"Insira B: "
	
msgErro:
	.asciiz	"ERRO: A e B têm de ser maiores do que 0."
	
newln:
	.asciiz	"\n"

.text
.globl main

main:
	li		$v0, 4
	la		$a0, msgA
	syscall				# Imprime msgA
	li		$v0, 5
	syscall				# Leitura de A 
	move		$a1, $v0		# Move o valor de A para a1
	li		$v0, 4
	la		$a0, msgB
	syscall				# Imprime msgB
	li		$v0, 5
	syscall				# Leitura de B
	move		$a2, $v0		# Move o valor de B para a2
	slti		$s0, $a1, 1		# Se A < 1
	beq		$s0, 1, error	# Pule para error
	slti		$s0, $a2, 1		# Se B < 1
	beq		$s0, 1, error	# Pule para error
	mult		$a1, $a2		# A * B
	mflo		$a3			# Acessando o registrador LO para copiar o resultado paara a3
	move		$t0, $a1		# Move A para t0
	move		$a0, $a1		# Move A para a0
	li		$v0, 1
	syscall				# Imprime o primeiro multiplo
	la		$a0, newln
	li		$v0, 4
	syscall				# Imprime newln

loop:
	add		$t0, $t0, $a1	# t0 = t0 + A
	move		$a0, $t0		# Move t0 para a0
	li		$v0, 1		
	syscall				# Imprime a0
	la		$a0, newln
	li		$v0, 4
	syscall				# Imprime newln
	bne		$t0, $a3, loop	# Se t0 != A * B pule para loop
	
exit:
	li		$v0, 10		
	syscall				# exit
		
error:
	li		$v0, 4
	la		$a0, msgErro
	syscall				# Imprime msgErro
	li		$v0, 10
	syscall				# exit