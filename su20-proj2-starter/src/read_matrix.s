.globl read_matrix
.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================
read_matrix:

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

    mv a1, s0
    li a2, 0
    jal ra, fopen
    bgt x0, a0, exit_50

    mv t0, a0

    mv a1, t0
    mv a2, s1
    li a3, 4
    jal ra, fread
    bne a0, a3, exit_51

    mv a1, t0
    mv a2, s2
    li a3, 4
    jal ra, fread
    bne a0, a3, exit_51

    lw t1, 0(s1) 
    lw t2, 0(s2)
    mul t1, t1, t2
    li t2, 4
    mul t1, t1, t2
    mv a0, t1
    jal ra, malloc
    beq a0, x0, exit_48

    mv t3, a0

    mv a1, t0
    mv a2, t3
    mv a3, t1
    jal ra, fread
    bne a0, a3, exit_50

    mv a0, t3



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

exit_48:
    li a1, 48
    jal exit2

exit_50:
    li a1, 50
    jal exit2

exit_51:
    li a1, 51
    jal exit2

exit_52:
    li a1, 52
    jal exit2