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
		bic.b #0001h, &PM5CTL0 ; disable power on high impedance mode

mainloop:

*clearing the registers
		clr.w R4
		clr.w R5
		clr.w R6
		clr.w R7
		clr.w R8
		clr.w R9
		clr.w R10
		clr.w R11
		clr.w R12
		clr.w R13
		clr.w R14
		clr.w R15

*16 bit operations
		mov.w PC, R4 ; copy the content of program counter to R4
		mov.w R4, R5 ; copy the content of R4 to R5
		mov.w R5, R6 ; copy the content of R5 to R6

*8 bit operations
		mov.b PC, R7 ; copy the lower bit of PC into R7
		mov.b R7, R8 ; copy the lower bit of R7 into R8
		mov.b R8, R9 ; copy the lower bit of R8 into R9

*16 bit operations
		mov.w SP, R10  ; copy the content of SP to R10
		mov.w R10, R11 ; copy the content of R10 to R11
		mov.w R11, R12 ; copy the content of R11 to R12

*8 bit operations
		mov.b SP, R13 ; copy the lower bit of SP into R13
		mov.b R13, R14 ; copy the lower bit of R13 into R14
		mov.b R14, R15; copy the lower bit of R14 into R15

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
            
