;
; AssemblerMain.asm
;
; Created: 09-02-2016 10:51:00
; Author : jimmi
;


	   LDI    R16, 0xFF		;load 255 into R16
       OUT    DDRB, R16		;make port B an output port
	   OUT    PORTB, R16 	;clear leds

Loop:
		LDI R18, 0x0		;load 0 into R18
		OUT DDRA, R18		;make port A an input port
		IN  R19, PINA		;load the contens of port A (the switches) into R19
		OUT PORTB, R19		;send the contens of R19 to port B (the leds)     
RJMP Loop				    ; Jump back to Loop
   