.data #Data segment - variables 
    studentNoPrompt: .asciiz "Please enter the last 3 digits of your student registration number."
    outputResult: .asciiz "\nYour student number/2 = "

.text #Text segment - instructions
    main:
        #Prompts the user to enter their reg no.
        li $v0, 4 #Service 4 for string
        la $a0, studentNoPrompt
        syscall
        
        #Get user's reg no.
        li $v0, 5
        syscall
        
        move $t0, $v0 #Store reg no. in $t0 register
        addi $t1, $zero, 2 #Stores 2 in $t1 - what I'll be dividing by
        
        #Division
        div $t3, $t0, $t1 #$t3 = $t0(reg no) / $t1(2)
        
        addi $t4,$zero, 9 #Loops down from 9 because a loop is also done at 0 (10 loops in total)
        loop:
        addi $t4, $t4, -1 #Decrements by 1 each time (adding a minus number)
        
        #Display outputResult message
        li $v0, 4 #Service 4 for string
        la $a0, outputResult
        syscall
        
        #Output result
        li $v0, 1 #Service 1 for integer
        move $a0, $t3
        syscall
      
        #Branch to loop if >= 0 
        bgez $t4, loop
