/******************************************************************
* File: gpioPins
* Author: Alex Chadwick with modifications made by Dewey Greear
* 
* This file is used to manipulate GPIO pins.
******************************************************************/

/* pinNumbers returns the base address of the GPIO pin as a physical address 
*  in r0
*/

.globl pinNumbers

pinNumbers:
ldr r0,=0x20200000 /*base address as found in manual*/
mov pc,lr





/* useGpioPin sets GPIO register in r0 to the lowest 3 bits in r1
*/

.globl useGpioPin

useGpioPin:

	cmp r0,#53        /*54 pins total*/
	cmpls r1,#7

	movhi pc,lr

	push {lr}

	mov r2,r0

	bl pinNumbers



	cmpPinLoop$:

		cmp r2,#9

		subhi r2,#10

		addhi r0,#4

		bhi cmpPinLoop$

	add r2, r2,lsl #1

	lsl r1,r2

	mov r3,#7

	lsl r3,r2

	mvn r3,r3

	ldr r2,[r0]
and r2,r3

	orr r1,r2

	str r1,[r0]

	pop {pc}





/* gpioOnOff turns pin on or off depending on value of r0.
.globl gpioOnOff

gpioOnOff:

	cmp r0,#53

	movhi pc,lr

	push {lr}

	mov r2,r0

	bl pinNumbers


	lsr r3,r2,#5

	lsl r3,#2

	add r0,r3

	and r2,#31

	mov r3,#1

	lsl r3,r2

	teq r1,#0

	streq r3,[r0,#40]

	strne r3,[r0,#28]

	pop {pc}
