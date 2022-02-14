.data
msgEntrada:						# Mensagem de entrada
	.asciiz	"Entre com um valor inteiro (N>1): "

msgErro:						# Mensagem de erro
	.asciiz 	"O valor digitado N tem que ser maior que 1.\n\n"

msgResultado:					# Mensagem de resultado
	.asciiz 	"Resultado: "
	
newln:						# Nova linha
	.asciiz 	"\n"

.text
.globl main						# Pseudocódigo equivalente
main:
	addi		$v0, $zero, 4		# $v0 = 4
	la		$a0, msgEntrada		# $a0 = msgEntrada
	syscall					# print_string(msgEntrada)
	addi		$v0, $zero, 5		# $v0 = 5
	syscall					# $v0 = read_int()
	slti		$t1, $v0, 2			# $t1 = (v0 < 2)? 1 : 0
	bne		$t1, $zero, error		# if($t1 != 0) pule para error
	add		$s0, $zero, $v0		# $s0 = $v0

loop:
	add		$s1, $s1, $s0		# $s1 += $s0 
	subi		$s0, $s0, 1			# $s0 -= 1
	bne		$s0, $zero, loop		# if($s0 != 0) pule para loop
	
printResults:
	addi		$v0, $zero, 4		# $v0 = 4
	la		$a0, msgResultado		# $a0 = msgResultado
	syscall					# print_string(msgResultado)
	addi		$v0, $zero, 1		# $v0 = 1
	add		$a0, $s1, $zero		# $a0 = $s1
	syscall					# print_int($a0)
	addi		$v0, $zero, 4		# $v0 = 4
	la		$a0, newln			# $a0 = newln
	syscall					# print_string(newln)
	add		$v0, $zero, 10		# $v0 = 10
	syscall					# exit

error:						
	addi		$v0, $zero, 4		# $v0 = 4
	la		$a0, msgErro		# $a0 = msgErro
	syscall					# print_string(msgErro)
	jal		main				# pule para main
