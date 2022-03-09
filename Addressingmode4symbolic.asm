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
	mov.w #0001h, &PM5CTL0 ;disable power on high Z

mainloop:
    mov.w #0000h, R4
    mov.w #0000000000000000b,R5

	mov.w constant1, R4 ;move the value in the address defined at constant1 in R4
	mov.w R4, var1 ;move the value inside register R4 into the address defined at var1

	mov.w constant2, R5 ;move the value in the address defined at constant2 in R5
	mov.w R5, var2 ;move the value inside register R5 into the address defined at var2

	jmp mainloop



;-------------------------------------------------------------------------------
; Memory allocation
;-------------------------------------------------------------------------------

	.data ; go to data memory
	.retain ;keep this section, even if not used

constant1: .short 1234h ;define a constant at address 2000h with 1234h inside
constant2: .short 0CAFEh ;define a constant at address 2002h with CAFEh inside

var1: .space 2 ;reserve space in the next address 2004h for var1
var2: .space 2 ;reserve space in the next address 2006h for var2



                                            

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
            
