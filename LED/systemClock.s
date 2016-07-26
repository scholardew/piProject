/*******************************************************************************
* File:     systemClock.s
* Author:   Alex Chadwick and modified by Dewey Greear
* 	This is code that uses the system time clock.  The clock runs at 1MHz.
*******************************************************************************/

/* getInitialAddress returns the base address of the system clock as a physical
*  address and is held in register r0
*/

.globl getInitialAddress

getInitialAddress:
	
	ldr r0,=0x20003000
  /*base address of system timer from manual*/
	mov pc,lr




/* getTime fetches the current timestamp of the system timer and returns
*  the value across two registers; r0 and r1
*/

.globl getTime

getTime:
	
	push {lr}
	
	bl getInitialAddress
	
	ldrd r0,r1,[r0,#4]
	
	pop {pc}





/* passTime allows for a given amount of time given in microseconds from main.
* r0 holds the time to wait
*/

.globl passTime

passTime:
	
	mov r2,r0
	
	push {lr}
	
	bl getTime
	
	mov r3,r0

	
	loop$:
		
		bl getTime
		
		sub r1,r0,r3
		
		cmp r1,r2
		
		bls loop$
	
	pop {pc}
    
