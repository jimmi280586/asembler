;
; AssemblerViaCallingConvention.asm
;
; Created: 11-03-2016 10:42:05
; Author : jimmi
;


start:
    .INCLUDE "M2560DEF.INC"
	.ORG 00
	LDI R16, 0xFF
	OUT SPL, R16
	LDI R16, 0x21
	OUT SPH, R16
	
	LDI R27, 15
	
	main_loop:
		LDI R16, 4
		PUSH R16			
		LDI R16, 222
		PUSH R16
		LDI R16, 3
		PUSH R16			; param1 0xFF
		LDI R16, 111
		PUSH R16			; param2 0x20
		CALL add_u16int
		POP R18
		POP R19
	JMP main_loop
	
	add_u16int:
		PUSH R5
		PUSH R6
		PUSH R7
		PUSH R8
		PUSH R26
		PUSH R27
		
		IN R26, SPL
		IN R27, SPH
		ADIW R26, 14 ; 4 + 3 + 6  + 1 

		LD R5, -X   ;msb1
		LD R6, -X	;lsb1
		LD R7, -X	;msb2
		LD R8, -X   ;lsb2
				
		ADD R6, R8
		ADC R5, R7

		ST X+, R7
		ST X+, R6

		POP R27
		POP R26
		POP R8
		POP R7
		POP R6
		POP R5
	RET				; 2 + 5
	

    rjmp start
