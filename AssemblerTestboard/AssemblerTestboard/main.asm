;
; AssemblerTestboard.asm
;
; Created: 10-02-2016 13:01:58
; Author : jimmi
;

;PORT B = LEDS
;PORT A = SWITCHES

.def INIT = R16				;DEFINES R16 TO A TEXT FOR BETTER REMEMBER
.def VAL = R17				;DEFINES R17 TO A TEXT FOR BETTER REMEMBER

	   LDI    INIT, 0xFF	;load 255 into DEFINED REGISTER (R16)
       OUT    DDRB, INIT	;make port B an output port
	   OUT    PORTB, INIT	;clear leds

Loop:
		COM INIT			;CHANGES THE INIT VALUE TO THE OPOSIT (0x00)
		OUT DDRA, INIT		;make port A an input port
		IN  VAL, PINA		;load the contens of port A (the switches) into DEFINED REGISTER (R17)
		COM VAL				;CHANGES TO THE OPOSIT VALUE FOR DISPLAY
		OUT PORTB, VAL		;send the contens of VAL to port B (the leds)     
RJMP Loop


