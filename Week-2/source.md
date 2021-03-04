# **Practice 1: C to RISC-V**
```c
// copy string p to q;
char *p, *q;
while ( (*q++ = *p++) != '\0');
```

```nasm
; p->s0 q->s1
loop:
    lb t0, 0(s0)
    sb t0, 0(s1)
    addi s0, s0, 1
    addi s1, s1, 1
    bne t0, x0, loop
exit:
    nop
```

# **Practice 2: Functions in Assembly**
## 2.1 six steps of calling a function
* 1. Put arguments in place where function can access them
* 2. Transfer control to the function
* 3. The function will acquire any(local) storage resources it needs
* 4. The function performs its desired task
* 5. The function puts ***return value*** in an accessiable place and 'clean up' 
* 6. Controls is returned to you

```c
int add(int a, int b) {
    return a + b;
}

int main() {
    int a = 3;
    int b = 4;
    a = add(a, b);
}
```

```nasm
add:
    add a0, a0, a1
    jr ra

main:
    addi a0, x0, 3
    addi a1, x0, 4
    jal ra, add
```
# **Practice 3: Functions Calling Conventions**
* ## Calle*R*: the calling function
* ## Calle*E*: the function being called
* ## Register Conventions: A set of generally accepted rules as to which registers will be unchanged after a procedure call and which may have changed

# **Practice 4: RISC-V instruction format**

* *R-Format* : 3 register input (add, xor, mul)
* *I-Format* : with immediates (addi, lw, jalr, slli)
* *S-Format* : store instruction (sw, sb)
* *B-Format* : branch instruction (beq, bge)
* *U-Format* : instruction with upper immediates, upper immediates is 20 bits (auipc, lui)
* *UJ-Format* : jump instruction (jal)