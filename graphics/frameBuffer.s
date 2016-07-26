/******************************************************************************
* File:	frameBuffer.s
* Author: Alex Chadwick with modifications made by Dewey Greear
*
* This code creates a frame buffer for setting up screen
*
******************************************************************************/

.section .data
.align 4        /*must use this to communicate with GPU - aligns page*/
.globl setFrame  /*structure containing info for resolution and high color values*/
setFrame:
	.int 1280	/* #0 Width */
	.int 720	/* #4 Height */
	.int 1280	/* #8 vWidth */
	.int 720	/* #12 vHeight */
	.int 0		/* #16 GPU - Pitch */
	.int 16		/* #20 Bit Depth -------16------*/
	.int 0		/* #24 X */
	.int 0		/* #28 Y */
	.int 0		/* #32 GPU - Pointer */
	.int 0		/* #36 GPU - Size */


/* setUpBuffer creates a frame buffer of width and height specified in
* r0 and r1, and bit depth specified in r2, and makes LED flash; it also
* returns a 0 if failed frame.
*/
.section .text
.globl setUpBuffer
setUpBuffer:
	
	cmp r0,#5120         /*width (1280) x 4*/
	cmpls r1,#2880       /*height (720) x 4*/
	cmpls r2,#32         /*bit depth*/
	movhi r5,#0
	movhi pc,lr

	push {r4,lr}
    mov r6,r4		
	ldr r6,= setFrame
	str r0,[r4,#0]
	str r1,[r4,#4]
	str r0,[r4,#8]
	str r1,[r4,#12]
	str r2,[r4,#20]

	mov r0,r6
	add r0,#0x40000000 /*must add this to get correct values!!!!!!!!!!*/
	mov r1,#1
	bl writeValue
	
	mov r0,#1
	bl readValue
		
	teq r5,#0
	movne r5,#0
	popne {r4,pc}

	mov r5,r6
	pop {r4,pc}
	
