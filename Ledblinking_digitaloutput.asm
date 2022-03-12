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
	mov.b #01h, &P1DIR ; Setting up the user led 1 as an output
    bis.b #BIT6, &P6DIR; set p6.6 sixth pin(6) of port 6 as an output.
	mov.b #0000h, &PM5CTL0 ;setting up power on high Z mode
    ;bic.w #LOCKLPM5, &PM5CTL0 ; disable the power-on high impedance mode

mainloop:
*turning on led
	mov.b #01h, &P1OUT; Turning on the led P1.0 by setting the 1st bit of p1out high
	bis.b #BIT6, &P6OUT ; Turning on the led P6.6 by setting the 6th bit of p6out high

* 1st delay
    mov.w #0FFFFh, R4; moving a large value in R4
delay:
	dec.w R4 ; decrement R4
	jnz delay ; repeat until R4 reaches 0

*turning off led
	bic.b #BIT6, &P6OUT; Turning off the led P1.0 by setting the 1st bit of p1out low
    mov.b #00h, &P1OUT; Turning off the led P6.6 by setting the 6th bit of p6out low

* 2nd delay
	;mov.w #0FFFFh, R6; moving a large value in R4

Delay:
	dec.w R4 ; decrement R6
	jnz Delay ; repeat until R6 reaches 0
*looping the loop
    jmp mainloop

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
            
