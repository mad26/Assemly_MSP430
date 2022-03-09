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
	mov.b #0001, &PM5CTL0 ; disable power on high impedance mode

mainloop:
	mov.w &2000h, R4 ; copy the contents of address 2000h into R4
	mov.w R4, &2004h ; copy the contents of R4 into address 2004h

	mov.w &2002h, R5 ; copy the content of address 2002h into R5
	mov.w R5, &2006h ; copy the content of R5 into 2006h

	jmp mainloop

;-------------------------------------------------------------------------------
; Memory allocation
;-------------------------------------------------------------------------------
	.data ;go to the data memory(2000h)
	.retain ;keep this section, even if not used

Const1: .short 1234h ;define a constant in the address 2000h with 1234h inside
Const2: .short 0CAFEh ;define a constant in the adress 2002h with CAFEh inside

Var1: .space 2 ;reserve space in the next address 2004h for var1
Var2: .space 2 ;reserve space in the next address 2006h for var2


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
            
