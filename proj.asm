.data
    element1: .word 1
    element2: .word 2
    element3: .word 3
    element4: .word 4
    element5: .word 5
.text
    main:
        # At first, store the old $ra
        sw $ra, 0($sp)
        addiu $sp, -4
        # create a stack frame
        jal create_stack
        # let $t0 store the size of this stack
        li $t0, 0
        # push 3 elements into the first stack
        lw $a0, element1
        jal push_integer
        addi $t0, 1
        lw $a0, element2
        jal push_integer
        addi $t0, 1
        lw $a0, element3
        jal push_integer
        addi, $t0, 1
        lw $a0, element4
        jal push_integer
        addi $t0, 1
        lw $a0, element5
        jal push_integer
        addi, $t0, 1
        # pop these elements in a loop and print them
        loop: 
            beq $t0, $zero end
            addi $t0, -1
            j pop_integer
        # restore the old $ra

        # End of this program
        end:
            addiu $sp, 4
            lw $fp, 0($sp)
            li $v0,10
            syscall



    create_stack:
    # create an new stack frame
        sw $fp, 0($sp)
        move $fp, $sp
        addiu $sp, -4
        jr $ra

    push_integer:
    # let $a0 store the element to be stored in stack
         sw $a0, 0($sp)
         addiu $sp, -4
         jr $ra

    pop_integer:
    # pop the element on the top of the block and print it
        addiu $sp, 4
        lw $a0, 0($sp)
        li $v0, 1
        syscall
        j loop