;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
init:

	bic.b #01h, &PM5CTL0 ;enabling power on high Z

	;mov.b #02h, &P4DIR ;clearing up the first pin of 4th port(swith1 as input)
	bic.b #BIT3, &P2DIR ;clearing up the third pin of 2nd port(swith2 as input)

	;mov.b #02h, &P4REN ;enabling the pull up/down functionality for switch 1
	bis.b #BIT3, &P2REN ;enabling the pull up/down functionality for switch 2

	;mov.b #02h, &P4OUT ;selecting the pull up functionality for the P4.1 switch
    bis.b #BIT3, &P2OUT ;selecting the pull up functionality for the P2.3 switch


	;mov.b #01h, &P1DIR ;setting up the P1.0(led1) as an output
	bis.b #BIT6, &P6DIR ;setting up the P6.6(led2) as an output


	;mov.b #00h, &P1OUT ;set initial value of led1 as low
	bic.b #BIT6, &P6OUT ;set initial value of led2 as low


;mainloop:

;poll_s1:
	;bit.b #02h, &P4IN ; we are checking the value of switch by bit test, bit 2 of p4in is AND with the bit 2; which would result in result not equal to zero i.e Z not equal to 0
	;jnz poll_s1 ; this is jump if not zero (be in this loop until switch is not pressed)

;toggle_led1:
    ;xor.b #01h, &P1OUT ;Xoring the value in the address P1out with 1, it would complement its value


main:

poll_s2:
	bit.b #BIT3, &P2IN ; we are checking the value of switch by bit test, bit 3 of p2in is AND with the bit 3; which would result in result not equal to zero i.e Z not equal to 0
	jnz poll_s2 ; this is jump if not zero (be in this loop until switch is not pressed)

toggle_led2:
    xor.b #BIT6, &P6OUT ;Xoring the value in the address P1out with 1, it would complement its value


    ;jmp mainloop


    jmp main

                                            

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
