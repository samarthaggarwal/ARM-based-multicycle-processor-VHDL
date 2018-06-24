mov r0,#100
mov r1,#12
str r1,[r0]
ldr r2,[r0]

@ldrb r2,[r0]

mov r0,#11
mov r1,#15
strb r1,[r0]

@ldrb r2,[r0]

mov r0,#8
ldr r2,[r0]

ldr r2,[r1,r12];
str r2,[r0,r12];

@str r1,[r0]
@ldr r2,[r0]
@add r0,r0,#10;

@ mov r0,#10
@ mov r1,#8
@ sub r2,r0,r1
@ mul r7,r0,r1
@ mla r7,r2,r1,r0

@ add r2,r0,r1
@ sub r3,r0,r1
@ sub r4,r1,#3
@ and r5,r0,r1
@ orr r6,r0,r1

mov r0,#2
mov r1,#5
add r2,r0,r1
sub r3,r1,r0
mul r4,r0,r1
orr r5,r0,r1
mov r6,#100
str r1,[r6]
ldr r7,[r6]






































































mov r0,#100
mov r1,#12
str r1,[r0]
ldr r2,[r0]
