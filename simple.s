.section .vectors
vector_table:
    .word 0xABC01200
    .word reset_handler
    .zero 400

.section .text
    .align 1
    .type reset_handler, %function

reset_handler:
    mov r0,#1
    mov r1,#2
    add r3,r2,r1
    bl .
