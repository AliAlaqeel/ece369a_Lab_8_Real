.data
asize0:  .word    4,  4,  2, 2    #i, j, k, l
frame0:  .word    0,  0,  1,  2, 
         .word    0,  0,  3,  4
         .word    0,  0,  0,  0
         .word    0,  0,  0,  0
window0: .word    1,  2, 
         .word    3,  4
newline: .asciiz     "\n" 

.text

.globl main

main: 
    addi    $sp, $sp, -4    # Make space on stack
    sw      $ra, 0($sp)     # Save return address

    la      $a0, asize0 
    la      $a1, frame0
    la      $a2, window0

    jal     vbsme           # call function
    # jal     print_result    # print results to console

    lw      $ra, 0($sp)         # Restore return address
    addi    $sp, $sp, 4         # Restore stack pointer
    j       end_program                 # Return

end_program:                    # remain in infinite loop
	j end_program

# print_result:
#     # Printing $v0
#    add     $a0, $v0, $zero     # Load $v0 for printing
#    li      $v0, 1              # Load the system call numbers
#    syscall
   
#     # Print newline.
#    la      $a0, newline          # Load value for printing
#    li      $v0, 4                # Load the system call numbers
#    syscall
   
#     # Printing $v1
#    add     $a0, $v1, $zero      # Load $v1 for printing
#    li      $v0, 1                # Load the system call numbers
#    syscall

#     # Print newline.
#    la      $a0, newline          # Load value for printing
#    li      $v0, 4                # Load the system call numbers
#    syscall
   
#     # Print newline.
#    la      $a0, newline          # Load value for printing
#    li      $v0, 4                # Load the system call numbers
#    syscall
   
#    jr      $ra                   #function return

.text
.globl  vbsme

vbsme:  
 
   li      $v0, 0              # reset $v0 and $V1
   li      $v1, 0

   # insert your code here
   
    addi    $sp, $sp, -4    #Increase stack by one
    sw      $ra, 0($sp)     #Store return address to stack

    ### REGISTER USES
    # $s0: stepsLeft, $s1: dirTracker, $s2: frameHeight, $s3: frameWidth, $s4: windowHeight, $s5: windowWidth, $s6: widthSlides, $s7: heightSlides
    # $t0: general use temp (can overwrite), $t9: general use temp (DO NOT OVERWRITE)
    #Free registers (for now): 
    ###

    addi    $t1, $zero, 0x7FFF

    # Let $s2 = frameHeight
    lw      $s2, 0($a0)

    # Let $s3 = frameWidth  (We'll use frame width later inside the loops)
    lw      $s3, 4($a0)

    # Let $s4 = windowHeight
    lw      $s4, 8($a0)

    # Let $s5 = windowWidth
    lw      $s5, 12($a0)

    # Let $s6 = widthSlides, widthSlides = frameWidth - windowWidth
    sub     $s6, $s3, $s5

    # Let $s7 = heightSlides, heightSlides = frameHeight - windowHeight
    sub     $s7, $s2, $s4

    # Let $s0 = stepsLeft, stepsLeft = (widthSlides + 1) * (heightSlides + 1) - 1 [SIMPLIFIES TO] stepsLeft = (widthSlides * heightSlides) + heightSlides + widthSlides
    addi    $s0, $zero, 0
    mul     $s0, $s6, $s7
    add     $s0, $s0, $s6
    add     $s0, $s0, $s7

    # Let $s1 = dirTracker
    addi    $s1, $zero, 0

    addi    $t7, $zero, 0       #t7 = totalsum on window vs frame

    addi    $s2, $zero, 0   #Current X
    addi    $t8, $zero, 0   #Current Y

    #addi    
    jal     calcSAD

    #Initial Going-Right Loop
    addi    $t9, $zero, 0  #Let t9 == i, loop continues for (i < widthSlides)
    beq     $s6, $zero, skipRight

firstRight:

        addi    $s2, $s2, 1     #Move to right by 1 (currX++)
        addi    $s0, $s0, -1    #subtract stepsLeft by 1
        jal     calcSAD
        addi    $t9, $t9, 1

    slt     $t0, $t9, $s6
    bne     $t0, $zero, firstRight


skipRight:
    #beq     $s0, $zero, skipVBSME
    #blt     $s0, $zero, skipVBSME
    blez    $s0, skipVBSME
vbsmeLoop:  # Mega Loop

    #If dirTracker == 0, 1, 2, or 3, go to their respective tracker
    beq     $s1, $zero, goingDown
    addi    $t0, $zero, 1
    beq     $s1, $t0, goingLeft
    addi    $t0, $zero, 2
    beq     $s1, $t0, goingUp
    addi    $t0, $zero, 3
    beq     $s1, $t0, goingRight

    goingDown: 
        #Going down Loop
        addi    $t9, $zero, 0   # Loop iterator i
        beq     $s7, $zero, breakSwitchCases    #Emergency skip     #Mistake: used s6 instead of s7

        downLoop:
        addi    $t8, $t8, 1     # Y increases by 1
        addi    $s0, $s0, -1    # decrement stepsLeft by 1
        jal     calcSAD

        addi    $t9, $t9, 1
        slt     $t0, $t9, $s7
        bne     $t0, $zero, downLoop    #if(i < heightSlides) loop

        addi    $s7, $s7, -1    # decrement heightSlides by 1
        j breakSwitchCases

    goingLeft:
        #Going left Loop
        addi    $t9, $zero, 0
        beq     $s6, $zero, breakSwitchCases 

        leftLoop:
        addi    $s2, $s2, -1
        addi    $s0, $s0, -1    # decrement stepsLeft by 1
        jal     calcSAD
        addi    $t9, $t9, 1
        slt     $t0, $t9, $s6
        bne     $t0, $zero, leftLoop    #if(i < widthSlides) loop

        addi    $s6, $s6, -1    # decrement widthSlides by 1
        j breakSwitchCases

    goingUp:
        #Going up Loop
        addi    $t9, $zero, 0
        beq     $s7, $zero, breakSwitchCases

        upLoop:
        addi    $s0, $s0, -1    # decrement stepsLeft by 1
        addi    $t8, $t8, -1
        jal     calcSAD
        addi    $t9, $t9, 1
        slt     $t0, $t9, $s7
        bne     $t0, $zero, upLoop    #if(i < heightSlides) loop

        addi    $s7, $s7, -1    # decrement heightSlides by 1
        j breakSwitchCases

    goingRight:
        #Going right Loop
        addi    $t9, $zero, 0
        beq     $s6, $zero, breakSwitchCases 

        rightLoop:
        addi    $s2, $s2, 1
        addi    $s0, $s0, -1    #subtract stepsLeft by 1
        jal     calcSAD
        addi    $t9, $t9, 1
        slt     $t0, $t9, $s6
        bne     $t0, $zero, rightLoop

        addi    $s6, $s6, -1    # decrement widthSlides by 1


    breakSwitchCases:

    #if dirTracker == 3, reset it to zero, increment otherwise
        addi    $t0, $zero, 3
        beq     $s1, $t0, resetTracker

        addi    $s1, $s1, 1
        j dontResetTracker

        resetTracker:
        add     $s1, $zero, $zero

        dontResetTracker:

    #bgt         $s0, $zero, vbsmeLoop   #while(stepsLeft > 0)
    bgtz    $s0, vbsmeLoop

skipVBSME:

    lw      $ra, 0($sp)     #get ye ole return address
    addi    $sp, $sp, 4    #decrease stack by 1
    jr      $ra 


#SAD CALCULATIONS BELOW
# t5: i, t6: j, t3: frame value, t4: window value, 

calcSAD:

    addi    $t7, $zero, 0   # reset currentSum
    addi    $t5, $zero, 0   # reset i
    iLoop:

        addi    $t6, $zero, 0   # reset j
        jLoop:

            # Getting the window pt. 
            mul     $t2, $t6, $s5       #finding the window location ()
            add     $t2, $t2, $t5       #adding the row to the column data for a 1 Dimentional array
            sll     $t2, $t2, 2         #multiplying by 4 because of int value
            add     $t2, $t2, $a2       #adding te address to the array
            lw      $t4, 0($t2)         #loads Window Value

            # Getting the frame pt.
            add     $t0, $t8, $t6       #adding the currY to the j value
            mul     $t2, $t0, $s3       # multiplying by the frame width
            add     $t0, $s2, $t5       #adding Current x to the i value
            add     $t2, $t2, $t0       #adding Current X to the Y value
            add     $t0, $zero, $zero   #reset for later use 
            sll     $t2, $t2, 2         #multiplies by 4 for int value
            add     $t2, $t2, $a1       #adds frame value
            lw      $t3, 0($t2)         #loads Frame Value

            # Compare the points
            #blt     $t3, $t4, winBigger
            slt   $t0, $t3, $t4
            bne   $t0, $zero, winBigger   #COULD BE PROBLEM
            sub     $t0, $t3, $t4
            add     $t7, $t7, $t0
            j       winSmaller
            winBigger:
            sub     $t0, $t4, $t3
            add     $t7, $t7, $t0
            winSmaller:

        addi    $t6, $t6, 1
        #blt     $t6, $s4, jLoop
        slt    $t0, $t6, $s4
        bne    $t0, $zero, jLoop


    addi    $t5, $t5, 1
    #blt     $t5, $s5, iLoop
    slt     $t0, $t5, $s5
    bne     $t0, $zero, iLoop

    # t1: old sum, t7: current sum 

    # nop
    # slt     $t0, $t7, $t1
    # bne     $t0, $zero, newSum
    # nop
    # j noNewSum

    # newSum:
    # or     $v0, $zero, $t8
    # or     $v1, $zero, $s2
    # or     $t1, $zero, $t7

    # noNewSum:
    # add    $t7, $0, $0
    # jr     $ra 

    beq     $s2, $t8, xSamey
    nop
    j   notFirstPoint
    nop
    xSamey: 
        beq     $s2, $zero, firstEverPoint
        nop
        j   notFirstPoint
            firstEverPoint:
            addi    $v0, $zero, 0
            addi    $v1, $zero, 0
            addi    $t1, $t7, 0
            jr $ra

    notFirstPoint:
    #bgt     $t1, $t7, newLowerSum
    nop
    slt  $t0, $t7, $t1
    bne  $t0, $zero, newLowerSum
    
    nop
    beq     $t7, $t1, SameSum
    addi    $t7, $zero, 0
    jr $ra
    nop

    newLowerSum:
    add    $v0, $zero, $t8
    add    $v1, $zero, $s2
    add     $t1, $zero, $t7
    addi    $t7, $zero, 0
    jr $ra
SameSum:
	addi $t7,$zero,0
	jr $ra