.globl classify

.data
    m0_row: .word 0
    m0_col: .word 0
    m0_add: .word 0
    m1_row: .word 0
    m1_col: .word 0
    m1_add: .word 0
    input_row: .word 0
    input_col: .word 0
    input_add: .word 0

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # 
    # If there are an incorrect number of command line args,
    # this function returns with exit code 49.
    #
    # Usage:
    #   main.s -m -1 <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

    addi sp, sp, -52
    sw ra,  0(sp)
    sw s0,  4(sp)
    sw s1,  8(sp)
    sw s2,  12(sp)
    sw s3,  16(sp)
    sw s4,  20(sp)
    sw s5,  24(sp)
    sw s6,  28(sp)
    sw s7,  32(sp)
    sw s8,  36(sp)
    sw s9,  40(sp)
    sw s10, 44(sp)
    sw s11, 48(sp)

    
    mv s0, a0
    mv s1, a1
    mv s2, a2


	# =====================================
    # loAD MATRICES
    # =====================================






    # load pretrained m0
    lw a0, 4(s1)
    la a1, m0_row
    la a2, m0_col

    addi sp, sp, -28
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw a2, 8(sp)
    sw a3, 12(sp)
    sw a4, 16(sp)
    sw a5, 20(sp)
    sw a6, 24(sp)

    jal ra, read_matrix
    la a1, m0_add
    sw a0, 0(a1)

    lw a0, 0(sp)
    lw a1, 4(sp)
    lw a2, 8(sp)
    lw a3, 12(sp)
    lw a4, 16(sp)
    lw a5, 20(sp)
    lw a6, 24(sp) 
    addi sp, sp, 28

    # load pretrained m1

    lw a0, 8(s1)
    la a1, m1_row
    la a2, m1_col

    addi sp, sp, -28
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw a2, 8(sp)
    sw a3, 12(sp)
    sw a4, 16(sp)
    sw a5, 20(sp)
    sw a6, 24(sp)

    jal ra, read_matrix
    la a1, m1_add
    sw a0, 0(a1)

    lw a0, 0(sp)
    lw a1, 4(sp)
    lw a2, 8(sp)
    lw a3, 12(sp)
    lw a4, 16(sp)
    lw a5, 20(sp)
    lw a6, 24(sp) 
    addi sp, sp, 28




    # load input matrix
    lw a0, 12(s1)
    la a1, input_row
    la a2, input_col

    addi sp, sp, -28
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw a2, 8(sp)
    sw a3, 12(sp)
    sw a4, 16(sp)
    sw a5, 20(sp)
    sw a6, 24(sp)

    jal ra, read_matrix
    la a1, input_add
    sw a0, 0(a1)

    lw a0, 0(sp)
    lw a1, 4(sp)
    lw a2, 8(sp)
    lw a3, 12(sp)
    lw a4, 16(sp)
    lw a5, 20(sp)
    lw a6, 24(sp) 
    addi sp, sp, 28





    # =====================================
    # ruN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)

    lw s3, m0_row
    lw s4, input_col
    mul s5, s3, s4
    li  t0, 4
    mul s5, s5, t0

    mv a0, s5
    jal ra, malloc
    mv s6, a0
    
    lw a0, m0_add
    lw a1, m0_row
    lw a2, m0_col

    lw a3, input_add
    lw a4, input_row
    lw a5, input_col 
    mv a6, s6
    jal ra, matmul

    mv a0, s6
    mul a1, s3, s4
    jal ra, relu

    lw s3, m1_row
    lw s4, input_col
    mul s5, s3, s4
    li t0, 4
    mul s5, s5, t0

    mv a0, s5
    jal ra, malloc
    mv s7, a0

    lw a0, m1_add
    lw a1, m1_row
    lw a2, m1_col
    mv a3, s6
    lw a4, m0_row
    lw a5, input_col 
    mv a6, s7
    jal ra, matmul

    # =====================================
    # wrITE OUTPUT
    # =====================================
    # write output matrix
    lw a0, 16(s1)
    mv a1, s7
    lw a2, m1_row
    lw a3, input_col
    jal ra, write_matrix





    # =====================================
    # caLCULATE CLASSIFICATION/LABEL
    # =====================================
    # call argmax
    mv a0, s7
    lw t0, m1_row
    lw t1, input_col
    mul a1, t1, t0
    jal ra, argmax

    mv t0, a0


    # print classification
    mv a1, t0
    jal ra, print_int


    # print newline afterwards for clarity
    li a1 '\n'
    jal print_char

    lw ra,  0(sp)
    lw s0,  4(sp)
    lw s1,  8(sp)
    lw s2,  12(sp)
    lw s3,  16(sp)
    lw s4,  20(sp)
    lw s5,  24(sp)
    lw s6,  28(sp)
    lw s7,  32(sp)
    lw s8,  36(sp)
    lw s9,  40(sp)
    lw s10, 44(sp)
    lw s11, 48(sp)
    addi sp, sp, 52


    ret