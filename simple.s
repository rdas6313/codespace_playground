.equ CSR,0xE000E010
.equ RVR,0xE000E014
.equ CVR, 0xE000E018
.equ timeout, 0x000FFFFF
.section .vectors
vector_table:
    .word _stack_top
    .word reset_handler
    .org 0x003c
    .word systick_handler
    .zero 400

.section .data
    array: .word stack1,stack2,0x0

.section .text
    .align 1
    .type reset_handler, %function

reset_handler:
    
    //loading data from flash to memory 
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
    // end loading

    
    //setting systick
    ldr r0,=RVR
    ldr r2,=timeout
    str r2,[r0]

    ldr r0,=CVR
    mov r2,#0x0
    str r2,[r0]

    ldr r0,=CSR
    mov r2, #0x7
    str r2,[r0]

    b .

.section .text
.align 1
.type systick_handler, %function
systick_handler:
    push {r4-r7}
    mov r4,r8
    mov r5,r9
    mov r6,r10
    mov r7,r11
    push {r4-r7}
    //manually change the stack pointer for context switching

    ldr r0,=array // r0 = array
    ldr r1,[r0,#0x8] // r1 = [r0 + 8]
    lsl r1,r1,#2 // r1 = r1 << 2
    ldr r5,[r0,r1] // r5 = [r0 + r1]
    mov sp,r5 // sp = r5
    lsr r1,r1,#2 // r1 = r1 >> 2
    mov r6, #0x1 // r6 = 1
    eor r1,r1,r6 // r1 = r1 ^ r6
    str r1,[r0,#0x8] // [r0+8] = r1


switch:
    pop {r4-r7}
    mov r8,r4
    mov r9,r5
    mov r10,r6
    mov r11,r7
    pop {r4-r7}
    bx lr



/*Task 1*/
.section .text
.type task1, %function
task1:
    nop
    add r0,r0,#1
    b task1

/*Task 2*/
.type task2, %function
task2:
    add r1,r1,#1
    b task2

.section .stack
.align 4
stack1:
    .word 0x18
    .word 0x19
    .word 0x1a
    .word 0x1b
    .word 0x14
    .word 0x15
    .word 0x16
    .word 0x17
    .word 0x10
    .word 0x11
    .word 0x12
    .word 0x13
    .word 0x1c
    .word 0xFFFFFFFD
    .word task1
    .word 0x01000000 // Psr thumb bit must set to 1
    
    
stack2:
    .word 0x2b
    .word 0x2a
    .word 0x29
    .word 0x28
    .word 0x27
    .word 0x26
    .word 0x25
    .word 0x24
    .word 0x20
    .word 0x21
    .word 0x22
    .word 0x23
    .word 0x2c
    .word 0xFFFFFFFD
    .word task2
    .word 0x01000000
   


















