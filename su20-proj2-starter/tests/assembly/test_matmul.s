.import ../../src/matmul.s
.import ../../src/utils.s
.import ../../src/dot.s

# static values for testing
.data
m0: .word 1 2 3 4 5 6 7 8 9
m1: .word 1 2 3 4 5 6 7 8 9
d:  .word 0 0 0 0 0 0 0 0 0 # allocate static space for output

.text
main:
    # Load addresses of input matrices (which are in static memory), and set their dimensions
    
    la s0, m0
    la s1, m1
    la s3, d

    # Call matrix multiply, m0 * m1
    mv a0, s0
    li a1, 3
    li a2, 3
    mv a3, s1
    li a4, 3
    li a5, 3
    mv a6, s3

    addi sp, sp, -28
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw a2, 8(sp)
    sw a3, 12(sp)
    sw a4, 16(sp)
    sw a5, 20(sp)
    sw a6, 24(sp)

    jal ra, matmul 

    lw a0, 0(sp)
    lw a1, 4(sp)
    lw a2, 8(sp)
    lw a3, 12(sp)
    lw a4, 16(sp)
    lw a5, 20(sp)
    lw a6, 24(sp) 
    addi sp, sp, 28


    # Print the output (use print_int_array in utils.s)
    la a0, d
    li a1, 3
    li a2, 3 
    jal ra, print_int_array



    # Exit the program
    jal exit