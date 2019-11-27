
; Including "tn85def.inc" can replace some of the following equates and defines 

;.equ	FLASHEND=$fff	;words
;.equ	E2END   =$1ff
;.equ	RAMBEG  =$60
;.equ	RAMEND  =$25f

; CPU and I/O registers


; General purpose registers
; Immediate instructions only available on R16-R31

;LFSR 1, a 31-bit register
;.DEF    LFSR1_1=r31
;.DEF	LFSR1_2=r30
;.DEF	LFSR1_3=r29
;.DEF	LFSR1_4=r28
;LFSR 2, a 23-bit register
;.DEF	LFSR2_1=r27
;.DEF	LFSR2_2=r26
;.DEF    LFSR2_3=r25
;.DEF    TEMP=r24
;.DEF    TEMP2=r23

;-----------------------------------------------------------------------------


init:				;default reset pin left as low going reset
				;default internal 8MHZ clock, startup time, and system clock prescaler

	;ldi	regA,low(RAMEND)	;get end of RAM location
	;ldi	regB,high(RAMEND)
	;out	SPL,regA		;set stack pointer
	;out	SPH,reg
    ldi r31, 0x45 ;LFSR1_1, 0x45
    ldi r30, 0x57 ;LFSR1_2, 0x57
    ldi r29, 0x9F ;LFSR1_3, 0x9F
    ldi r28, 0xF2 ;LFRS1_4, 0xF2
    ldi r27, 0xD7 ;LFSR2_1, 0xD7
    ldi r26, 0xC8 ;LFSR2_2, 0xC8
    ldi r25, 0x79 ;LFSR2_3, 0x79
    ldi r16, 0x01
    out $17,r16 ;;DDRB
    
MainLoop:
; 31-bit LFSR with taps at 31 and 28
;----------------------------------------------------
    mov r28, TEMP  
    swap TEMP   ;get Bit 28
    mov r28, TEMP2
    lsl TEMP2
    eor TEMP, TEMP2
    lsl TEMP            ;shift XORD bit to carry
    ;shift registers
    rol r31 ;LFSR1_1
    rol r30 ;LFSR1_2
    rol r29 ;LFSR1_3
    rol r28 ;LFSR1_4
    out $18, r31 ;LFSR1_1, PORTB

; 21-bit LFSR with taps at 21 and 19
;----------------------------------------------------
    mov r_25, TEMP
    lsr TEMP        ;Get bit 19
    lsr TEMP
    mov r_25, TEMP2
    swap TEMP2      ;Get bit 21
    eor TEMP, TEMP2
    ;shift xord bit to carry
    lsr TEMP
    ;Shift registers
    rol r27 ;LFSR2_1
    rol r26 ;LFSR2_2
    rol r25 ;LFSR2_3
    out $18, r27

    jmp  MainLoop
