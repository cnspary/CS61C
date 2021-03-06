.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the num of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================
relu:
    bge x0, a1, exit_8     
    
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

    li t0, 0 # idx
    li t1, 4 # 4byte

loop_start:
    bge t0, a1, loop_end

    mul t2, t1, t0
    add t2, t2, a0
    lw  t3, 0(t2)
    blt t3, x0, handler

loop_continue:
    addi t0, t0, 1
    j loop_start

loop_end:
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

handler:
    li t3, 0
    sw t3, 0(t2)
    j loop_continue

exit_8:
    li a1, 8
    jal exit2