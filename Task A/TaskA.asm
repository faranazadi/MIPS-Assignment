.data #Data segment - variables 
    namePrompt: .asciiz "Please enter your name." #Prompts the user to enter their name
    userName: .space 10 #Variable used to store the user's name (max 10 characters/bytes)
    outputName: .asciiz "\nThe user's name is: " #Used to output the user's name
    studentNoPrompt: .asciiz "Please enter the last 4 digits of your student registration number."
    outputStudentNo: .asciiz "\nThe last 4 digits of your registration number are: "

.text #Text segment - instructions
    main:
        #Prompts the user to enter their name
        li $v0, 4 #Service 4 for printing string
        la $a0, namePrompt
        syscall
    
        #Gets user's input as text
        li $v0, 8 #Prepares computer for text input
        la $a0, userName #Stores user's name/input in $a0
        li $a1, 10 #Tells computer max characters/bytes of input
        syscall
        
        #Displays output message
        li $v0, 4
        la $a0, outputName
        syscall
        
        #Displays user's name
        li $v0, 4
        la $a0, userName
        syscall
        
        #Prompts the user to enter their reg no.
        li $v0, 4
        la $a0, studentNoPrompt
        syscall
        
        #Get user's reg no.
        li $v0, 5
        syscall
        
        #Store reg no. in $t0 register
        move $t0, $v0
        
        #Display outputStudentNo message
        li $v0, 4
        la $a0, outputStudentNo
        syscall
        
        #Display actual student no.
        li $v0, 1
        move $a0, $t0 #Moves student no to argument register
        syscall
