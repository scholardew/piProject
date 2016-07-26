/******************************************************************************
* File:	mailbox.s
* Author: Alex Chadwick with modifications made by Dewey Greear
*
*	This code is for communication between CPU and GPU
******************************************************************************/


/* baseAddress returns the base address of the mailbox as a physical
* address in register r0.
*/
.globl baseAddress
baseAddress: 
	ldr r0,=0x2000B880 /*Address found in manual*/
	mov pc,lr


* writeValue writes the value given in the top 28 bits of r0 to the channel
* given in the low 4 bits of r1.
*/
.globl writeValue
writeValue: 
	tst r0,#0b1111
	movne pc,lr
	cmp r1,#15
	movhi pc,lr
	mov r2,r0
	push {lr}
	bl baseAddress
	mov r3,r0
		
	loop$:
		ldr r4,[r4,#0x18]

		tst r4,#0x80000000
		bne loop$

	add r2,r1	
	str r2,[r3,#0x20]
	pop {pc}

/* NEW
* readValue returns the value in the box addressed to r1
* given in the low 4 bits of r0, as the top 28 bits of r0.
*/
.globl readValue
readValue: 
	cmp r0,#15
	movhi pc,lr
	mov r1,r0
	push {lr}
	bl baseAddress
	box .req r0
	
	rightmail$:
		loop2$:
			status .req r2
			ldr status,[box,#0x18]
			
			tst status,#0x40000000
			.unreq status
			bne loop2$
		
		mail .req r2
		ldr mail,[box,#0]

		inchan .req r3
		and inchan,mail,#0b1111
		teq inchan,r1
		.unreq inchan
		bne rightmail$
	.unreq box

	and r0,mail,#0xfffffff0
	.unreq mail
	pop {pc}
