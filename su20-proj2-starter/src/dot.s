.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================
dot:
    bge x0, a2, exit_5
    bge x0, a3, exit_6
    bge x0, a4, exit_6

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

    mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3
    mv s4, a4

    li t0, 0 # dot
    li t1, 0 # idx
    li t2, 4 # 4bytes

loop_start:
    bge t1, a2, loop_end

    mul t3, t1, s3
    mul t3, t3, t2
    add t3, s0, t3
    mul t4, t1, s4
    mul t4, t4, t2
    add t4, s1, t4

    lw t3, 0(t3)
    lw t4, 0(t4)
    mul t3, t3, t4
    add t0, t0, t3
    addi t1, t1, 1
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
    
    mv a0, t0

    ret

exit_5:
    li a1, 5
    jal exit2

exit_6:
    li a1, 6
    jal exit2

