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
	mov.b #0000h, &PM5CTL0 ; disable power on high impedance mode

mainloop:
*16 bit operation
	mov.w #1234h, R4 ; put the hex value 1234 into R4
	mov.w #0FACEh, R5; put the hex value FACE into R5

*8 bit operation
	mov.b #99h, R6 ; put the hex value 99 into R6
	mov.b #0EEh, R7 ; put the hex value EE into R7

*decimal, binary and char formats
	mov.w #371, R8 ; put the decimal value 371 into R8
	mov.b #10101010b, R9 ; put the binary value 101011010 into R9
	mov.b #'B', R10 ;ASCII code for B(42h) into R10

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
            
