//arm prologue for dynarec
//Save stuff, prepare stack and register
//called with pointer to emu as 1st parameter
//and address to jump to as 2nd parameter

.text
.align 4

.extern rv64_next

.global rv64_prolog
rv64_prolog:
    //save all 18 used register
    addi    sp,  sp, -(8 * 22)
    sd      ra, (sp)  // save ra
    sd      x8, 8(sp) // save fp
    sd      x18, 16(sp)
    sd      x19, 24(sp)
    sd      x20, 32(sp)
    sd      x21, 40(sp)
    sd      x22, 48(sp)
    sd      x23, 56(sp)
    sd      x24, 64(sp)
    sd      x25, 72(sp)
    sd      x26, 80(sp)
    sd      x27, 88(sp)
    fsd     f18, (12*8)(sp)
    fsd     f19, (13*8)(sp)
    fsd     f20, (14*8)(sp)
    fsd     f21, (15*8)(sp)
    fsd     f22, (16*8)(sp)
    fsd     f23, (17*8)(sp)
    fsd     f24, (18*8)(sp)
    fsd     f25, (19*8)(sp)
    fsd     f26, (20*8)(sp)
    fsd     f27, (21*8)(sp)
    //setup emu -> register
    ld      x16, (a0)
    ld      x17, 8(a0)
    ld      x18, 16(a0)
    ld      x19, 24(a0)
    ld      x20, 32(a0)
    ld      x21, 40(a0)
    ld      x22, 48(a0)
    ld      x23, 56(a0)
    ld      x24, 64(a0)
    ld      x25, 72(a0)
    ld      x26, 80(a0)
    ld      x27, 88(a0)
    ld      x28, 96(a0)
    ld      x29, 104(a0)
    ld      x30, 112(a0)
    ld      x31, 120(a0)
    ld      x8, 128(a0)     //xFlags
    ld      x7, 136(a0)     // xRIP
    // // adjust flags bit 11 -> bit 5
    andi    x8, x8, ~(1<<5)    // probably not usefull?
    srli    x5, x8, 11-5
    andi    x5, x5, 1<<5
    or      x8, x8, x5
    // setup xMASK
    xori    x5, x0, -1
    srli    x5, x5, 32
    // jump to block
    jalr    a1
