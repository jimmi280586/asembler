;
; AssemblerFlagExercise.asm
;
; Created: 02-03-2016 11:05:25
; Author : jimmi
;


LDI R16, 10						;load 00001010 into register 16
LDI R18, 20						;load 00010100 into register 18
mov r17, r18					;move register 18 into register 17
ADD R17, R16					;add register 17 and register 18 = 00001010 + 00010100 = 00011110 no flags			
LDI R16, 50						;load  into register 16
LDI R18, 100					;load  into register 18
mov r17, r18					;move register 18 into register 17
ADD R17, R16					;add register 17 and register 18 = 00001010 + 00010100 = 00011110
LDI R16, 120					;load  into register 16
LDI R18, 150					;load  into register 18
mov r17, r18					;move register 18 into register 17
ADD R17, R16					;add register 17 and register 18 = 00001010 + 00010100 = 00011110
LDI R16, 20						;load  into register 16
LDI R18, 150					;load  into register 18
mov r17, r18					;move register 18 into register 17
ADD R17, R16					;add register 17 and register 18 = 00001010 + 00010100 = 00011110
LDI R16, 20						;load  into register 16
LDI R18, 20						;load  into register 18
mov r17, r18					;move register 18 into register 17
SUB R17, R16					;sub register 17 and register 18 = 00001010 - 00010100 = 00011110
LDI R16, 20						;load  into register 16
LDI R18, 15						;load  into register 18
mov r17, r18					;move register 18 into register 17
SUB R17, R16					;sub register 17 and register 18 = 00001010 - 00010100 = 00011110
LDI R16, 120					;load  into register 16
LDI R18, 160					;load  into register 18
mov r17, r18					;move register 18 into register 17
SUB R17, R16					;sub register 17 and register 18 = 00001010 - 00010100 = 00011110
LDI R16, 160					;load  into register 16
LDI R18, 120					;load  into register 18
mov r17, r18					;move register 18 into register 17
SUB R17, R16					;sub register 17 and register 18 = 00001010 - 00010100 = 00011110
LDI R16, 12						;load  into register 16
LDI R18, 30						;load  into register 18
mov r17, r18					;move register 18 into register 17
MUL R17, R16					;multiply register 17 and register 18 = 00001010 * 00010100 = 00011110
ldi R18, 5
