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
	mov.b #0001h, PM5CTL0 ;disable power on high Z

mainloop:
* here we are playing with the data memory instead of registers
	mov.w #block1, R4 ;put the value 2000h into R4 to be used as address

	mov.w 0(R4), 8(R4)  ;copy the 1st word in block 1 into 1st empty word in block2
	mov.w 2(R4), 10(R4) ;copy the 2nd word in block 1 into 2nd empty word in block2
	mov.w 4(R4), 12(R4) ;copy the 3rd word in block 1 into 3rd empty word in block2
	mov.w 6(R4), 14(R4) ;copy the 4th word in block 1 into 4th empty word in block 2

	jmp mainloop


;-------------------------------------------------------------------------------
; Memory allocation
;-------------------------------------------------------------------------------
	.data ; go to data memory location 2000h
	.retain; keep this space held, even if not used

block1: .short 0AAAAh, 0BBBBh, 0CCCCh, 0DDDDh
block2: .space 8





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
            
