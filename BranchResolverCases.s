.data                   	# Put Global Data here
N:      .word 3 		    # 'N' is the address which contains the loop count, 5
X:      .word -2, -4, 7 	# 'X' is the address of the 1st element in the array to be added
SUM:    .word 0			    # 'SUM' is the address that stores the final sum
str:    .asciiz "The sum of the array is = " 

.text				# Put program here 
.globl main			# globally define 'main' 

# For only the Branch Resolver test bench

main:
nop
nop 
nop
nop
bgez $t0, main
beq $t0, $t1, exit
bne $t0, $t1, main
bgtz $t0, exit
blez $t0, main
bltz $t0, exit
j main
jal exit
jr $ra
exit: