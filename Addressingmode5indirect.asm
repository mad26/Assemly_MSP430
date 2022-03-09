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
	mov.b #0001h, &PM5CTL0 ; disable power on high z

mainloop:
	mov.w #2000h, R4 ; copy the hex value 1234 in the register R4
	mov.w @R4, R5; copy the contents of register whose address is 1234h into R5


	mov.w #constant2, R6 ;put the content of constant2 in R6
	mov.w @R6, R7 ;move the contents of the address(2002h) defined by constant 2(0BEEFh) to R7

    jmp mainloop


;-------------------------------------------------------------------------------
; Memory allocation
;-------------------------------------------------------------------------------

	.data ;go to data memory location (02000h)
	.retain ;hold this space even if it is empty

constant1: .short 0DEADh ;define a constant in the memory location 0x2000 which is holding the data DEADh
constant2: .short 0BEEFh ; define a constant in the next memory location 0x2002 which is holding the data BEEFh



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
            
