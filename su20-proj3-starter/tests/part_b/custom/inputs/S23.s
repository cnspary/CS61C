addi t0, t0, 1
addi t1, t1, 0x100


swlt t0, 2(t1)
addi s0, t0 ,1
add s0, s0, t1
sw t0, 0(t1)
