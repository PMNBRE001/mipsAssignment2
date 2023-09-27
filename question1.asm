    .data
    inputFileName:    .asciiz "/home/brett/Desktop/CSC2002S/mipsA4Final/tree_64_in_ascii_lf.ppm" #path to image
    outputFileName:   .asciiz "/home/brett/Desktop/CSC2002S/mipsA4Final/outputFile.ppm"
    messageOriginal:  .asciiz "Average pixel value of the original image:\n"
    messageNew:       .asciiz "Average pixel value of new image:\n"
    currentLine:      .space 8 #max number of 255 ie 8 bits
    finalOutput:      .space 60000 #building up string to reach finaloutput
    fileValues:       .space 60000 #all values of file loaded here
    #headerCheck:      .space 20 #check to see length of header (19 bits)
    .text
    .globl main

main:
#KEEPING TRACK OF REGISTERS
    # 

    #STEP 1: OPEN INPUT FILE
    li   $v0,  13                #open file system call
    la   $a0,  inputFileName     #load address of input file name
    li   $a1,  0                 #flag(0; read ,  1; write)
    #li   $a2,  0                #mode is ignored
    syscall                      #call execute
    move $s0,  $v0               #put output in $s0 ie fileDescriptor
    

    #STEP 2: READ FILE AND LOAD ALL VALUES INTO "fileValues"
    li   $v0,  14                #Read from file system call
    move $a0,  $s0               #put fileDescriptor in $a0
    la   $a1,  fileValues        #address of fileValues
    li   $a2,  60000             #hardcoded file length, 70k as way over possible length
    syscall                      #execute

    #STEP 3: CLOSE THE FILE AS ALL VALUES HAVE BEEN LOADED
    li   $v0,  16                #system call for closing file
    move $a0,  $s0               #close fileDescriptor
    syscall                      #execute 

    #TEST: PRINT THE FILE TO CONSOLE
    #li   $v0,4                   #system call for print string
    #la   $a0,fileValues          #load all values of fileValues
    #syscall                      #execute

    #TEST: PRINT VALUES TO NEW FILE
    #STEP 1: OPEN OUTPUT FILE
    li   $v0,  13                #open file system call
    la   $a0,  outputFileName    #load address of output file name
    li   $a1,  1                 #flag(0; read ,  1; write)
    #li   $a2,  0                #mode is ignored
    syscall                      #call execute
    move $s1,  $v0               #put output in $s1 ie fileDescriptor
    
    #STEP 2: WRITE TO OUTPUT FILE
    li   $v0,  15                #write to file system call
    move $a0,  $s1               #move $s0 into $a0
    la   $a1,  fileValues
    li   $a2,  60000
    syscall

    #STEP 3: CLOSE THE FILE
    li   $v0,  16
    move $a0,  $s1
    syscall 

    li $v0,10
    syscall

    
