/******************************************************************************
* File: main.s
* Author: Alex Chadwick with modifications made by Dewey Greear
*
*  This program creates a frame buffer and cycles through the color wheel
*  in high color.
******************************************************************************/

.section .init
.globl _start
_start:

b main

.section .text

/* main: returns nothing and has no parameters*/

main:

	mov sp,#0x8000 /*stack point*/

/*This section sets up the T.V. screen
	mov r0,#1280 
	mov r1,#720  
	mov r2,#16 
	bl setUpBuffer

/* NEW
* Error check on frame buffer.
*/
	teq r0,#0
	bne pass$
		
	mov r0,#16 /GPIO pin #/
	mov r1,#1
	bl useGpioPin

	mov r0,#16
	mov r1,#0
	bl gpioOnOff

	fail$:
		b fail$

	pass$:
	
		mov r4,r0


	render$:
		
		ldr r3,[r4,#32 /*---------32------*/]
	
	mov r6,#720
	placeColor$:
		x .req r2
		mov r7,#1280
		drawColor$:
			strh r5,[r3]
			add r3,#2 
			sub r7,#1
			teq r7,#0
			bne drawColor$

		sub r6,#1
		add r5,#1
		teq r6,#0
		bne placeColor$

	b render$

