;
; AssemblerCalculator.asm
;
; Created: 24-02-2016 09:46:11
; Author : jimmi
;


 ;Define registers
.def TEMP = R16						;Used for storing temporary values
.def TOTAL = R17					;Used for storing the final total value
.def LED_REG = R18					;Used for storing values to send to the LED port
.def COUNTER = R19					;Used for determining whether the main input loop has been run once or twice
.def DELAY_OUTER_REG = R20			;Used for the outer delay loop
.def DELAY_INNER_REG = R21			;Used for the inner delay loop
.def COMPARE = R22					;Used for comparing values
.def FIRST_VALUE = R23				;Used for storing the first input value
.def SECOND_VALUE = R24				;Used for storing the second input value
.def BLINK_DELAY_REG = R25			;Used for the blinking delay loop
.def OP_CHOICE = R26				;Used for storing the chosen operation

;Clear all registers
;Allows us to reset without worrying about registers holding old values
LDI TEMP, 0x00
LDI TOTAL, 0x00
LDI LED_REG, 0x00
LDI COUNTER, 0x00
LDI DELAY_OUTER_REG, 0x00
LDI DELAY_INNER_REG, 0x00
LDI COMPARE, 0x00
LDI FIRST_VALUE, 0x00
LDI SECOND_VALUE, 0x00
LDI BLINK_DELAY_REG, 0x00
LDI OP_CHOICE, 0x00

;Define constants
.equ DELAY_INNER = 100				;Use 100 for inner loop delay
.equ DELAY_OUTER = 100				;Use 100 for outer loop delay
.equ DELAY_BLINK = 200				;Use 100 for blink loop delay

;Set up ports
OUT DDRA, TEMP						;Sets Port A to input using 0
LDI TEMP, 0xFF						;Saves 255 to temp
OUT DDRD, TEMP						;Sets Port D to output using 255 from temp
OUT PORTD, TEMP						;Turns off all the lights on Port D

;Initialize registers
LDI TEMP, 0x00						;Set TEMP back to 0
LDI LED_REG, 0xFF					;Set LED register value to 255 (all lights off)
LDI COMPARE, 0x01					;Set the compare register to 1 (probably a more clever way to do this...)

INPUT:								;Value input loop
		OUT PORTD, LED_REG			;Send the current LED register value to Port D
		CALL DELAY					;Call the delay loop

		NEXT0: 
			SBIC PINA, 0			;If button not pressed
			RJMP NEXT1				;Move to next loop
			PRESSDOWN0:				
				SBIS PINA, 0		;If button pressed 
				RJMP PRESSDOWN0		;Loop until no longer pressed
			LDI TEMP, 0b00000001	;Load 1 into temporary register
			EOR LED_REG, TEMP		;Exclusive-Or with LED register
			RJMP INPUT				;Start over at main loop

		NEXT1: 
			SBIC PINA, 1			;If button not pressed
			RJMP NEXT2				;Move to next loop
			PRESSDOWN1:				
				SBIS PINA, 1		;If button pressed 
				RJMP PRESSDOWN1		;Loop until no longer pressed
			LDI TEMP, 0b00000010	;Load 2 into temporary register
			EOR LED_REG, TEMP		;Exclusive-Or with LED register
			RJMP INPUT				;Start over at main loop

		NEXT2: 
			SBIC PINA, 2			;If button not pressed
			RJMP NEXT3				;Move to next loop
			PRESSDOWN2:			
				SBIS PINA, 2		;If button pressed 
				RJMP PRESSDOWN2		;Loop until no longer pressed
			LDI TEMP, 0b00000100	;Load 4 into temporary register
			EOR LED_REG, TEMP		;Exclusive-Or with LED register
			RJMP INPUT				;Start over at main loop

		NEXT3: 
			SBIC PINA, 3			;If button not pressed
			RJMP NEXT4				;Move to next loop
			PRESSDOWN3:				
				SBIS PINA, 3		;If button pressed 
				RJMP PRESSDOWN3		;Loop until no longer pressed
			LDI TEMP, 0b00001000	;Load 8 into temporary register
			EOR LED_REG, TEMP		;Exclusive-Or with LED register
			RJMP INPUT				;Start over at main loop

		NEXT4: 
			SBIC PINA, 4			;If button not pressed
			RJMP NEXT5				;Move to next loop
			PRESSDOWN4:				
				SBIS PINA, 4		;If button pressed 
				RJMP PRESSDOWN4		;Loop until no longer pressed
			LDI TEMP, 0b00010000	;Load 16 into temporary register
			EOR LED_REG, TEMP		;Exclusive-Or with LED register
			RJMP INPUT				;Start over at main loop

		NEXT5: 
			SBIC PINA, 5			;If button not pressed
			RJMP NEXT6				;Move to next loop
			PRESSDOWN5:				
				SBIS PINA, 5		;If button pressed 
				RJMP PRESSDOWN5		;Loop until no longer pressed
			LDI TEMP, 0b00100000	;Load 32 into temporary register
			EOR LED_REG, TEMP		;Exclusive-Or with LED register
			RJMP INPUT				;Start over at main loop

		NEXT6: 
			SBIC PINA, 6			;If button not pressed
			RJMP NEXT7				;Move to next loop
			PRESSDOWN6:				
				SBIS PINA, 6		;If button pressed 
				RJMP PRESSDOWN6		;Loop until no longer pressed
			LDI TEMP, 0b01000000	;Load 64 into temporary register
			EOR LED_REG, TEMP		;Exclusive-Or with LED register
			RJMP INPUT				;Start over at main loop

		NEXT7: 
			SBIC PINA, 7						;If button not pressed
			RJMP INPUT							;Move to INPUT loop
			PRESSDOWN7:							
				SBIS PINA, 7					;If button pressed 
				RJMP PRESSDOWN7					;Loop until no longer pressed
			CP COUNTER, COMPARE					;Compare the counter to the compare value
			BREQ EQUAL							;If equal, jump to equal loop
			ADD FIRST_VALUE, LED_REG			;Store value in LED as first number
			COM FIRST_VALUE
			LDI LED_REG, 0xFF					;Reset LED register to 255 (all lights off)
			INC COUNTER							;Increment the counter
			RJMP INPUT							;Go back to main input loop

		EQUAL:									;Loop for when counter is equal to the compare value
			ADD SECOND_VALUE, LED_REG			;Store value in LED as second number
			COM SECOND_VALUE
			LDI LED_REG, 0xFF					;Reset LED register to 255 (all lights off)
			OUT PORTD, LED_REG
			LDI COUNTER, 0						;Reset the counter to 0
			RJMP OPLOOP							;Jump to the ADD loop

	OPLOOP:
		OPNEXT0: 
			SBIC PINA, 0						;If button not pressed
			RJMP OPNEXT1						;Move to next loop
			OPPRESSDOWN0:						
				SBIS PINA, 0					;If button pressed 
				RJMP OPPRESSDOWN0				;Loop until no longer pressed
				LDI OP_CHOICE, 0b11111110		;Set the operation choice to 1
				OUT PORTD, OP_CHOICE			;Send the new choice to the LEDs
			RJMP OPLOOP							;Restart main operation input loop

		OPNEXT1: 
			SBIC PINA, 1						;If button not pressed
			RJMP OPNEXT2						;Move to next loop
			OPPRESSDOWN1:				
				SBIS PINA, 1					;If button pressed 
				RJMP OPPRESSDOWN1				;Loop until no longer pressed
				LDI OP_CHOICE, 0b11111101		;Set the operation choice to 2
				OUT PORTD, OP_CHOICE			;Send the new choice to the LEDs
			RJMP OPLOOP							;Restart main operation input loop

		OPNEXT2: 
			SBIC PINA, 2						;If button not pressed
			RJMP OPNEXT3						;Move to next loop
			OPPRESSDOWN2:				
				SBIS PINA, 2					;If button pressed 
				RJMP OPPRESSDOWN2				;Loop until no longer pressed
				LDI OP_CHOICE, 0b11111011		;Set the operation choice to 4
				OUT PORTD, OP_CHOICE			;Send the new choice to the LEDs
			RJMP OPLOOP							;Restart main operation input loop

		OPNEXT3: 
			SBIC PINA, 3						;If button not pressed
			RJMP OPNEXT4						;Move to next loop
			OPPRESSDOWN3:				
				SBIS PINA, 3					;If button pressed 
				RJMP OPPRESSDOWN3				;Loop until no longer pressed
				LDI OP_CHOICE, 0b11110111		;Set the operation choice to 8
				OUT PORTD, OP_CHOICE			;Send the new choice to the LEDs
			RJMP OPLOOP							;Restart main operation input loop

		OPNEXT4:
			SBIC PINA, 7						;If button not pressed
			RJMP OPLOOP							;Restart main operation input loop
			OPPRESSDOWN4:						
				SBIS PINA, 7					;If button pressed
				RJMP OPPRESSDOWN4				;Loop until no longer pressed
				LDI COMPARE, 0b11111110			;Load 1 into the compare register
				CP OP_CHOICE, COMPARE			;See if operation choice was 1 (switch 0)
				BREQ ADDITION					;If it was, go to the addition loop
				LDI COMPARE, 0b11111101			;Load 2 into the compare register
				CP OP_CHOICE, COMPARE			;See if operation choice was 2 (switch 1)
				BREQ SUBTRACTION				;If it was, go to the subtraction loop
				LDI COMPARE, 0b11111011			;Load 4 into the compare register
				CP OP_CHOICE, COMPARE			;See if operation choice was 4 (switch 2)
				BREQ DIVISION					;If it was, go to the division loop
				LDI COMPARE, 0b11110111			;Load 8 into the compare register
				CP OP_CHOICE, COMPARE			;See if operation choice was 8 (switch 3)
				BREQ MULTIPLICATION				;If it was, go to the multiplication loop

		ADDITION:								;Addition loop
			ADD TOTAL, FIRST_VALUE				;Add the first value to the total
			ADD TOTAL, SECOND_VALUE				;Add the second value to the total
			COM TOTAL							;Invert the total to display correctly
			RJMP DISPLAY						;Move to the display loop

		SUBTRACTION:							;Subtraction loop
			ADD TOTAL, FIRST_VALUE				;Add the first value to the total
			SUB TOTAL, SECOND_VALUE				;Subtract the second value from the first value
			COM TOTAL							;Invert the total to display correctly
			RJMP DISPLAY						;Move to the display loop

		DIVISION:								;Division loop
			ADD TOTAL, FIRST_VALUE				;Add first value to total
			LDI COUNTER, 0						;Reset counter to zero
			LDI COMPARE, 0						;Reset compare to zero
			DIV:								;Start of div loop
				SUB TOTAL, SECOND_VALUE			;Subtract second value from total every time loop runs
				INC COUNTER						;Increment counter
				CP TOTAL, COMPARE				;compare total with compare
				BRNE DIV						;If total is not zero yet, loop again (div)
				MOV TOTAL, COUNTER				;Move counter to total
				COM TOTAL						;Invert the total to display correctly
			RJMP DISPLAY						;Move to the display loop

		MULTIPLICATION:
			MOV TEMP, SECOND_VALUE					;Move the second value to temp
			MULT:									;Start of mult loop
				ADD TOTAL, FIRST_VALUE				;Adds first value to total every time loop runs
				DEC TEMP							;Decrements temp value
				BRNE MULT							;If temp register is not zero yet, loop again (mult)		
			COM TOTAL								;Invert the total to display correctly
			RJMP DISPLAY							;Move to the display loop

		DISPLAY:									;Display loop
			LDI TEMP, 0xFF							;Load the temp register with 0xFF (all lights off)
			OUT PORTD, TOTAL						;Send the total value to the LEDs
			CALL BLINK_DELAY						;Delay for a while with the blink delay subroutine
			OUT PORTD, TEMP							;Send the temp value (all lights off) to the LEDs
			CALL BLINK_DELAY						;Delay for a while with the blink delay subroutine
			RJMP DISPLAY							;Loop back to delay
			
		DELAY:										;Delay subroutine
			LDI DELAY_OUTER_REG, DELAY_OUTER		;Prepare outer register with delay count
			OUTER:									;Start of outer loop
				LDI DELAY_INNER_REG, DELAY_INNER	;Prepare inner register with delay count
				INNER:								;Start of inner loop
					DEC DELAY_INNER_REG				;Decrement the inner register
					BRNE INNER						;If inner register is not zero yet, loop again (inner)
					DEC DELAY_OUTER_REG				;Decrement the outer register
					BRNE OUTER						;If outer register is not zero yet, loop again (outer)
			RET										;Return to call location

		BLINK_DELAY:								;Blinking delay subroutine
			LDI BLINK_DELAY_REG, DELAY_BLINK		;Prepare blink delay register with blink delay count
			BLINK_LOOP:								;Start the outer blink loop
				CALL DELAY							;Call the delay subroutine for the first delay
				DEC BLINK_DELAY_REG					;Decrement the blink delay count
				BRNE BLINK_LOOP						;If not zero yet, then go back to the blink loop
			RET										;Return to call location
