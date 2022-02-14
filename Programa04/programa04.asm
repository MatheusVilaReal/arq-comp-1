.data

msgN:								# Mensagem de boas vindas do programa
	.asciiz	"Insira N: "
	
msgPrimo:							# Mensagem se N for primo
	.asciiz	" é primo."

msgnPrimo:							# Mensagem se N não for primo
	.asciiz	"\nO número digitado não é primo."

msgErro:							# Mensagem caso N < 0
	.asciiz	"ERRO: N tem de ser maior do que 0."
	
msgNPrimos:							# Mensagem da impressão dos N primeiros primos
	.asciiz	"N primeiros primos:\n"
	
newln:							# Quebra de linha
	.asciiz	"\n"

.text
.globl main

main:
	li		$v0, 4
	la		$a0, msgN
	syscall				# Imprime msgN
	li		$v0, 5
	syscall				# Leitura de N
	blt		$v0, 1, error	# Se N < 1, pule para error
	move		$a1, $v0		# Move v0 para a1
	li		$t7, 1
	li		$t2, 1
	li		$t0, 1		# t0 = 1
	div		$a2, $a1, 2		# a2 = N / 2
	addi		$a2, $a2, 1		# a2 = a2 + 1
	li		$a3, 1		# a3 representa se N é primo ou não
	
teste:
	addi		$t0, $t0, 1		# Incrementa t0
	div		$a1, $t0		# Divide a1 por t0
	mfhi		$t1			# Acessa o resto em HI e salva em t1
	sne		$a3, $t1, 0		# Se t1 != 0, então a3 = 1
	beq		$a3, 0, nprimo	# Se a3 == 0, pule para nprimo
	blt		$t0, $a2, teste	# Se t0 != N / 2 + 1, pule para ePrimo
	
primo:
	li		$v0, 1
	move		$a0, $a1
	syscall				# Imprime N
	li		$v0, 4
	la		$a0, msgPrimo
	syscall				# Imprime msgPrimo
	li		$v0, 4
	la		$a0, newln		# Imprime newln
	syscall
	bgt		$a1, 1, printTwo	# Se N > 1, então 2 está no intervalo
	
primosAteN:
	li		$t0, 1		# t0 = 1
	addi		$t7, $t7, 1		# t7 = t7 + 1
	div		$a2, $t7, 2		# a2 = t7 / 2
	addi		$a2, $a2, 1		# a2 = a2 + 1
	li		$a3, 1		# a3 representa se N é primo ou não
	
teste2:
	addi		$t0, $t0, 1		# Incrementa t0
	div		$t7, $t0		# Divide t7 por t0
	mfhi		$t1			# Acessa o resto em HI e salva em t1
	sne		$a3, $t1, 0		# Se t1 != 0, então a3 = 1
	beq		$a3, 0, primosAteN# Se a3 == 0, pule para nprimo
	blt		$t0, $a2, teste2	# Se t0 <= N / 2 + 1, pule para loop
	
printPrime:
	li		$v0, 1
	move		$a0, $t7
	syscall				# Imprime N
	li		$v0, 4
	la		$a0, newln		# Imprime newln
	syscall
	bne 		$t7, $a1, primosAteN	# Se t7 < N, pule para primosAteN
	li		$t7, 1		# Reseta valor de t7
	j		NPrimos		# Pule para nPrimos
	
nprimo:
	beq		$a1, 2, primo	# Se N = 2, Ns é primo
	li		$v0, 1
	move		$a0, $a1
	syscall				# Imprime N
	li		$v0, 4
	la		$a0, msgnPrimo
	syscall				# Imprime msgnPrimo
	
NPrimos:
	li		$v0, 4
	la		$a0, msgNPrimos	# Imprime msgNPrimos
	syscall
	li		$v0, 4
	la		$a0, newln		# Imprime newln
	syscall
	li		$v0, 1
	li		$a0, 2
	syscall				# Imprime N
	li		$v0, 4
	la		$a0, newln		# Imprime newln
	syscall
	
loop:
	li		$t0, 1		# t0 = 1
	addi		$t7, $t7, 1		# t7 = t7 + 1
	div		$a2, $t7, 2		# a2 = t7 / 2
	addi		$a2, $a2, 1		# a2 = a2 + 1
	li		$a3, 1		# a3 representa se N é primo ou não
	
teste3:
	addi		$t0, $t0, 1		# Incrementa t0
	div		$t7, $t0		# Divide t7 por t0
	mfhi		$t1			# Acessa o resto em HI e salva em t1
	sne		$a3, $t1, 0		# Se t1 != 0, então a3 = 1
	beq		$a3, 0, loop	# Se a3 == 0, pule para nprimo
	blt		$t0, $a2, teste3	# Se t0 <= N / 2 + 1, pule para loop
	
printPrime2:
	li		$v0, 1
	move		$a0, $t7
	syscall				# Imprime N
	li		$v0, 4
	la		$a0, newln		# Imprime newln
	syscall
	addi		$t2, $t2, 1		# Incrementa t2
	bne 		$t2, $a1, loop	# Se t2 != N, pule para loop
	j		exit
	
printTwo:
	li		$v0, 1
	li		$a0, 2
	syscall				# Imprime N
	li		$v0, 4
	la		$a0, newln		# Imprime newln
	syscall
	j		primosAteN
	
error:
	li		$v0, 4
	la		$a0, msgErro	# Imprime newln
	syscall
	
exit:
	li		$v0, 10
	syscall				# exit
