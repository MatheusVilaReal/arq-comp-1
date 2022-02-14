.data
vetor:
	.word		-2, 4, 7, -3, 0, -3, 5, 6
	
sizeofVetor:
	.word		8						# Número de elementos do vetor
	
msgPositivos:
	.asciiz	"A soma dos valores positivos = "	# Mensagem de resultados positivos
	
msgNegativos:
	.asciiz	"A soma dos valores negativos = "	# Mensagem de resultados negativos
	
newln:								
	.asciiz	"\n"						# Quebra de linha
	
.text
.globl main
main:
	la		$a0, vetor					# Define ponteiro para vetor
	lw		$a1, sizeofVetor				# $s7 = sizeofVetor
	li		$t0, 0					# Variável de controle = 0
	li		$t3, 0					# t3 armazenará os positivos
	li		$t4, 0					# t4 armazenará os negativos

loop:
	beq		$t0, $a1, return				# Se controle = tamanho do vetor, retorne
	lw		$t1, ($a0)					# t0 = inteiro apontado por a0
	sgt		$t2, $t1, 0					# Se t0 > 0, t1 = 1 senão t1 = 0
	beq		$t2, $zero, sumNegative			# Se t1 = 0, pule para sumNegative
	add		$t3, $t3, $t1				# v0 += t0
	
increment:
	addiu		$a0, $a0, 4					# Incrementa ponteiro para vetor (+4 bytes)
	addiu		$t0, $t0, 1					# Incrementa variável de controle
	j 		loop						# Pule para loop
	
sumNegative:
	add		$t4, $t4, $t1				# v0 += t0
	j		increment
	
return:
	la		$a0, msgPositivos				
	li		$v0, 4					
	syscall							# Imprime msgPositivos
	move		$a0, $t3					# a0 = t3 // Positivos
	li		$v0, 1					# v0 recebe código para print_int
	syscall							# Imprime a soma dos positivos
	la		$a0, newln					
	li		$v0, 4
	syscall							# Imprime quebra de linha na tela
	la		$a0, msgNegativos				
	li		$v0, 4					
	syscall							# Imprime msgNegativos
	move		$a0, $t4					# a0 = t4 // Negativos
	li		$v0, 1					# v0 recebe código para print_int
	syscall							# Imprime a soma dos negativos
	la		$a0, newln					
	li		$v0, 4
	syscall							# Imprime quebra de linha na tela
	li		$v0, 10
	syscall							# exit