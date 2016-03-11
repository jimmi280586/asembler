;
; Assemblerfibonacinumber.asm
;
; Created: 11-03-2016 10:38:03
; Author : jimmi

 .org 0

 .def TEMP				= R16			; Temporary register

 ; Set up the display output
 LDI TEMP, 0xFF							; Load 0xFF into temporary register
 OUT DDRC, TEMP							; Set Port B (LEDs) to output

 ; Initialize array pointer to the start of the array used to store the FIB numbers
 .equ MEMSTARTHIGH		= 0x05
 .equ MEMSTARTLOW		= 0x00
 LDI R27, MEMSTARTHIGH
 LDI R26, MEMSTARTLOW

 ; Set up the stack
 LDI TEMP, low(RAMEND)
 OUT SPL, TEMP
 LDI TEMP, high(RAMEND)
 OUT SPH, TEMP

 ; =======TARGET NUMBER HERE=======
 .equ TARGET_NUMBER		= 0x01			; Anything higher than 0x0D (13) will overflow
 ; ================================

 ; Set up Fib math registers
 .def FIB_TARGET		= R18			; The Fibonacci number we're looking for (this is our counter and will be decremented until it hits 0)
 .def N_CURRENT			= R19			; N, the current N value
 .def N_MINUS_ONE		= R20			; N-1, the previous N value

 LDI FIB_TARGET, TARGET_NUMBER			; Load our target number into the counter

 ; Handle 0 case
 LDI N_CURRENT, 0x00					; When N = 0, value is 0
 ST X+, N_CURRENT						; Store current value
 CPI FIB_TARGET, 0x00					; Is the target number 0?
	 BREQ DISPLAY						; If so, break to the display loop

 ; Handle 1 case
 LDI N_CURRENT, 0x01					; When N = 1, value is 1
 ST X+, N_CURRENT						; Store current value
 CPI FIB_TARGET, 0x01					; Is the target number 1?
	 BREQ DISPLAY						; If so, break to the display loop

; Decrement target counter twice to account for the first two checks
 DEC FIB_TARGET							; Decrement the target counter
 DEC FIB_TARGET							; Decrement the target counter

 LDI N_MINUS_ONE, 0x01					; N-1 value will start at 1 (since we're at N = 2 now)

 MAIN:									; MAIN loop
	ST X+, N_CURRENT					; Store current N value
	CPI FIB_TARGET, 0x00				; When target counter reaches 0
		BREQ DISPLAY					; Go display the result
	RCALL FIB							; Call the FIB subroutine
	DEC FIB_TARGET						; Decrement the counter
	RJMP MAIN							; Repeat the loop

FIB:
	MOV TEMP, N_CURRENT					; Stash the current N value
	ADD N_CURRENT, N_MINUS_ONE			; Add N-1 to N (this is our N = N-1 + N-2)
	MOV N_MINUS_ONE, TEMP				; Move the old N value to N-1
	RET									; Return to caller

DISPLAY: 
	LD TEMP, -X							; Load the value to send to the LEDs (this is the last value sent to the X array)
	COM TEMP							; Complement the LED value so the lights turn on instead of off
	OUT PORTC, TEMP						; Send the LED value to Port C (LEDs)
	END: RJMP END						; End by looping forever

/* SAVING BLINK CODE HERE :D */


 ; Set up delay subroutine
 .def DEL_OUTER = R22
 .def DEL_INNER_1 = R23
 .def DEL_INNER_2 = R24
 .equ DEL_OUTER_VAL = 0xA0
 .equ DEL_INNER_1_VAL = 0xA0
 .equ DEL_INNER_2_VAL = 0xA0

	LDI TEMP, 0xFF					; Load LED off value to the temp port
	BLINK: 
		OUT PORTC, LED_VALUE		; Send the Fib result value to the LEDs
		CALL DELAY					; Delay
		OUT PORTC, TEMP				; Turn the LEDs off
		CALL DELAY					; Delay
		RJMP BLINK					; Repeat

 DELAY:
	 LDI DEL_OUTER, DEL_OUTER_VAL
	 OUTER: 
		LDI DEL_INNER_1, DEL_INNER_1_VAL
		INNER_1: 
			LDI DEL_INNER_2, DEL_INNER_2_VAL
			INNER_2: 
				DEC DEL_INNER_2 
				BRNE INNER_2 
				DEC DEL_INNER_1 
				BRNE INNER_1 
				DEC DEL_OUTER
				BRNE OUTER 
				RET 	   
