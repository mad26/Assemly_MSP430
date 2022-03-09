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
	mov.w #block1, R4 ;put the value 2000h in R4

    mov.w @R4+, R5 ;copy the data at address held in R4 into R5, Then R4+2 --> R4
    mov.w @R4+, R6 ;copy the data at address held in R4 into R6, Then R4+2 --> R4
    mov.w @R4+, R7 ;copy the data at address held in R4 into R7, Then R4+2 --> R4

	mov.b @R4+, R8 ;copy the data at address held in R4 into R8, Then R4+1 --> R4
	mov.b @R4+, R9 ;copy the data at address held in R4 into R9, Then R4+1 --> R4
	mov.b @R4+, R10 ;copy the data at address held in R4 into R10, Then R4+1 --> R4

	jmp mainloop
;-------------------------------------------------------------------------------
; Memory allocation
;------------------------------------------------------------------------------ -
	.data ;move to the data memory address 2000h
	.retain ;hold this space, even if something is not updated in it

block1: .short 1122h, 3453h, 5795h, 0C56Bh, 0B43Ah

                                            

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
            
