.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error checks
    bge x0, a1, exit_2
    bge x0, a2, exit_2
    bge x0, a4, exit_3
    bge x0, a5, exit_3
    bne a2, a4, exit_4


    # Prologue
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

    li s0, 0
    li s1, 0
    li s2, 0
    li s3, 4

outer_loop_start:
    bge s1, a1, outer_loop_end

    li s2, 0

inner_loop_start:
    bge s2, a5, inner_loop_end

    addi sp, sp, -28
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw a2, 8(sp)
    sw a3, 12(sp)
    sw a4, 16(sp)
    sw a5, 20(sp)
    sw a6, 24(sp)

    mul t0, s1, a2
    mul t0, t0, s3
    add a0, a0, t0

    mul t0, s2, s3
    add a1, a3, t0
    
    mv a2, a2
    li a3, 1
    mv a4, a5

    jal ra, dot
    mv t0, a0

    lw a0, 0(sp)
    lw a1, 4(sp)
    lw a2, 8(sp)
    lw a3, 12(sp)
    lw a4, 16(sp)
    lw a5, 20(sp)
    lw a6, 24(sp) 
    addi sp, sp, 28

    # save result
    mul t1, s0, s3
    add t1, t1, a6
    sw t0, 0(t1)
    addi s0, s0, 1

    addi s2, s2, 1
    j inner_loop_start

inner_loop_end:

    addi s1, s1, 1
    j outer_loop_start

outer_loop_end:


    # Epilogue
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

exit_2:
    li a1, 2
    jal exit2

exit_3:
    li a1, 3
    jal exit2

exit_4:
    li a1, 4
    jal exit2