.section .vectors
vector_table:
    .word _stack_top
    .word reset_handler
    .zero 400

.section .data
    array: .word 1,2,3,4,5

.section .text
    .align 1
    .type reset_handler, %function

reset_handler:
    ldr r0,=_etext
    ldr r1,=_sdata
    ldr r5,=_edata
loop:
    ldr r2,[r0]
    str r2,[r1]
    add r0,r0,#0x4
    add r1,r1,#0x4
    cmp r5,r1
    bgt loop
    ldr r6,=array
    ldr r7,[r6]
    bl .
