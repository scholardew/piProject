/*************************************************************************
* File: main.s
* Author: Alex Chadwick and modified by Dewey Greear
* This part of my operating system shows my understanding and use of the
* onboard LED light on the Raspberry Pi.
*
*	
*
*	
*************************************************************************/

/*
* .globl_start is basically used as the entry point for the program and this name is 
* used almost universally.  Using this also keeps from getting a linker warning for
* not having an entry point.
*/

.section .init

.globl _start


_start:


b main


.section .text


/* main - returns nothing and takes no parameters*/

main:

	mov sp,#0x8000   /*stack point*/


	mov r0,#16       /
*GPIO port 16 is LED*/
	
	mov r1,#1        /*sets GPIO to 1 which is actually off*/

	bl useGpioPin



		onLoop$:

			mov r0,#16 

			mov r1,#0        /*This value turns the LED on*/
			bl gpioOnOff

			ldr r0,=500000

			bl passTime

			
mov r0,#16

			mov r1,#1        /*LED off*/
			bl gpioOnOff

			ldr r0,=500000   /*This time works with clock to blink once per second*/
    			bl passTime

			b onLoop$






        /*Continuous Loop*/