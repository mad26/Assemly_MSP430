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

        bic.b #LOCKLPM5, &PM5CTL0   ;disable the power on high Z
		mov.b #0FFh, &P1DIR         ;setting the Port 1 as an output
		mov.b #00h, &P1OUT          ;clear the Port 1
		mov.b #0FFh, &P3DIR         ;setting the Port 3 as an output
		mov.b #00h, &P3OUT          ;clear the Po

loop:

        mov.b #0C0h, &P1OUT      ; displaying 0 on the LSB of 7 segment
        mov.b #0C0h, &P3OUT      ; displaing 0 on the MSB of 7 segment...following till 9
        call #Delay
        mov.b #0F9h, &P3OUT
        call #Delay
        mov.b #0A4H, &P3OUT
        call #Delay
        mov.b #0B0h, &P3OUT
        call #Delay
        mov.b #99H, &P3OUT
        call #Delay
        mov.b #92H, &P3OUT
        call #Delay
        mov.b #82H, &P3OUT
        call #Delay
        mov.b #0F8H, &P3OUT
        call #Delay
        mov.b #80H, &P3OUT
        call #Delay
        mov.b #90H, &P3OUT      ; displaing 9 on the MSB of 7 segment
        call #Delay



        mov.b #0F9h, &P1OUT     ; displaying 1 on the LSB of 7 segment
        mov.b #0C0h, &P3OUT     ; displaing 0 on the MSB of 7 segment...following till 9
        call #Delay
        mov.b #0F9h, &P3OUT
        call #Delay
        mov.b #0A4H, &P3OUT
        call #Delay
        mov.b #0B0h, &P3OUT
        call #Delay
        mov.b #99H, &P3OUT
        call #Delay
        mov.b #92H, &P3OUT
        call #Delay
        mov.b #82H, &P3OUT
        call #Delay
        mov.b #0F8H, &P3OUT
        call #Delay
        mov.b #80H, &P3OUT
        call #Delay
        mov.b #90H, &P3OUT    ; displaing 9 on the MSB of 7 segment
        call #Delay




        mov.b #0A4H, &P1OUT   ; displaying 2 on the LSB of 7 segment
        mov.b #0C0h, &P3OUT   ; displaing 0 on the MSB of 7 segment...following till 9
        call #Delay
        mov.b #0F9h, &P3OUT
        call #Delay
        mov.b #0A4H, &P3OUT
        call #Delay
        mov.b #0B0h, &P3OUT
        call #Delay
        mov.b #99H, &P3OUT
        call #Delay
        mov.b #92H, &P3OUT
        call #Delay
        mov.b #82H, &P3OUT
        call #Delay
        mov.b #0F8H, &P3OUT
        call #Delay
        mov.b #80H, &P3OUT
        call #Delay
        mov.b #90H, &P3OUT   ; displaing 9 on the MSB of 7 segment
        call #Delay



        mov.b #0B0h, &P1OUT  ; displaying 3 on the LSB of 7 segment
        mov.b #0C0h, &P3OUT  ; displaing 0 on the MSB of 7 segment...following till 9
        call #Delay
        mov.b #0F9h, &P3OUT
        call #Delay
        mov.b #0A4H, &P3OUT
        call #Delay
        mov.b #0B0h, &P3OUT
        call #Delay
        mov.b #99H, &P3OUT
        call #Delay
        mov.b #92H, &P3OUT
        call #Delay
        mov.b #82H, &P3OUT
        call #Delay
        mov.b #0F8H, &P3OUT
        call #Delay
        mov.b #80H, &P3OUT
        call #Delay
        mov.b #90H, &P3OUT    ; displaing 9 on the MSB of 7 segment
        call #Delay



        mov.b #99H, &P1OUT    ; displaying 4 on the LSB of 7 segment
        mov.b #0C0h, &P3OUT   ; displaing 0 on the MSB of 7 segment...following till 9
        call #Delay
        mov.b #0F9h, &P3OUT
        call #Delay
        mov.b #0A4H, &P3OUT
        call #Delay
        mov.b #0B0h, &P3OUT
        call #Delay
        mov.b #99H, &P3OUT
        call #Delay
        mov.b #92H, &P3OUT
        call #Delay
        mov.b #82H, &P3OUT
        call #Delay
        mov.b #0F8H, &P3OUT
        call #Delay
        mov.b #80H, &P3OUT
        call #Delay
        mov.b #90H, &P3OUT    ; displaing 9 on the MSB of 7 segment
        call #Delay




        mov.b #92H, &P1OUT    ; displaying 4 on the LSB of 7 segment
        mov.b #0C0h, &P3OUT   ; displaing 0 on the MSB of 7 segment...following till 9
        call #Delay
        mov.b #0F9h, &P3OUT
        call #Delay
        mov.b #0A4H, &P3OUT
        call #Delay
        mov.b #0B0h, &P3OUT
        call #Delay
        mov.b #99H, &P3OUT
        call #Delay
        mov.b #92H, &P3OUT
        call #Delay
        mov.b #82H, &P3OUT
        call #Delay
        mov.b #0F8H, &P3OUT
        call #Delay
        mov.b #80H, &P3OUT
        call #Delay
        mov.b #90H, &P3OUT    ; displaing 9 on the MSB of 7 segment
        call #Delay

        jmp loop
		nop

Delay:  ;mov.w #0FFFFh, R4 ;load FFFF in R4
        bis.w #TBCLR, &TB2CTL
        mov.b #0000001101000000b, &TB2CTL
        bis.w #MC__CONTINUOUS, &TB2CTL


d_loop:
		dec.w R4 ;decrement R4
		jnz d_loop ;jump to delay until is not zero
		ret


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
            
