.data
prompt_for_input: .asciiz "Please enter your numbers, pressing enter after each, (0 to terminate):\n"
prompt_for_output: .asciiz "Your quantity of interest is equal to: "

.text
main:
# prompting the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall

li  $s0, 0
li $t0, 2 # assign 2 to register t0

LOOP:
li  $v0, 5
syscall
beq $v0, $zero, TerminateLoop # terminate loop if v0 == 0
div $v0, $t0 # divide v0 by register t0 containing value 2
mfhi $t1 # load remainer of division to register t1
beq $t1, 0, LOOP # loop skips the increment of odd entry count if the remainder is 0 (entry is even)
addu $s0, $s0, 1 # increase odd entry count by 1
beq $zero, $zero, LOOP # infinite loop (untill termination condition becomes true in line 18)

TerminateLoop:
# prompting the user with a message for the processed output:
li $v0, 4
la $a0, prompt_for_output
syscall

# printing the output
addiu  $v0, $zero, 1
addu $a0, $zero, $s0
syscall

# Finish the programme:
li $v0, 10      # syscall code for exit
syscall         # exit
