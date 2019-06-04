.data #Data segment - variables 
    num1Prompt: .asciiz "Please enter the 3 digit number you wish to add."
    outputResult: .asciiz "The result = "
    timeTaken: .asciiz "\nTime taken (ms): "

.text #Text segment - instructions
    main:
        #Prompt the user to enter the number they wish to add
        li $v0, 4 #Service 4 for string
        la $a0, num1Prompt
        syscall
        
        #Capture the number
        li $v0, 5 #Service 5 for reading integer
        syscall
        
        #Move number to $s1 storage register
        move $s1, $v0
        
        #Get system time using syscall 30 and save to register - first time
        li $v0, 30
        syscall
        add $t2, $zero, $a0
        
        #Nested loop structure   
        addi $t1, $zero, 1000 #outerLoop counter 
        outerLoop: 
        addi $t0, $zero, 1000 #innerLoop counter    
        innerLoop:
            add $s2, $s1, $s1 #3 digit number + 3 digit number
            addi $t0, $t0, -1 #Decrements by 1 each time (adding a minus number) - inner loop
            bgez $t0, innerLoop #Branch to innnerLoop if counter >= 0 
        
            addi $t1, $t1, -1 #Decrements by 1 each time (adding a minus number) - outer loop
            bgez $t1, outerLoop #Branch to outerLoop if counter >= 0
    
        #Get system time using syscall 30 and save to register - end time
        li $v0, 30
        syscall
        add $t3, $zero, $a0
        
        sub $t2, $t3, $t2 #End time - start time = time taken
        
    exit:
        #Display outputResult message
        li $v0, 4 #Service 4 for string
        la $a0, outputResult
        syscall
        
        #Output actual result
        li $v0, 1 #Service 1 for integer
        move $a0, $s2
        syscall
        
        #Display timeTaken message
        li $v0, 4 #Service 4 for string
        la $a0, timeTaken
        syscall
        
        #Output the time taken
        li $v0, 1 #Service 1 for integer
        move $a0, $t2
        syscall