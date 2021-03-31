addi t0, t0, 0x100
addi t1, t1, 0x0201

sw t1, 0(t0)

lb t2, 0(t0)
lh t2, 0(t0)
lw t2, 0(t0)
