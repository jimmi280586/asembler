;
; AssemblerFlagExercise.asm
;
; Created: 02-03-2016 11:05:25
; Author : jimmi
;


LDI R16, 10						;load 00001010 into register 16, 10
LDI R18, 20						;load 00010100 into register 18, 20
mov r17, r18					;move register 18 into register 17
ADD R17, R16					;add register 17 and register 18 = 30 = 00001010 + 00010100 = 00011110 no flags			
LDI R16, 50						;load  into register 16, 50
LDI R18, 100					;load  into register 18, 100
mov r17, r18					;move register 18 into register 17
ADD R17, R16					;add register 17 and register 18 = 150 = 00110010 + 01100100 = 10010110 V-flag set N-flag set
LDI R16, 120					;load  into register 16, 120
LDI R18, 150					;load  into register 18, 150
mov r17, r18					;move register 18 into register 17
ADD R17, R16					;add register 17 and register 18 = 270 = 01111000 + 10010110 = 00001110 C-flag set V-flag unset N-flag unset
LDI R16, 20						;load  into register 16, 20
LDI R18, 150					;load  into register 18, 150
mov r17, r18					;move register 18 into register 17
ADD R17, R16					;add register 17 and register 18 = 170 = 00010100 + 10010110 = 10101010 S-flag set N-flag set C-flag unset
LDI R16, 20						;load  into register 16, 20
LDI R18, 20						;load  into register 18, 20
mov r17, r18					;move register 18 into register 17
SUB R17, R16					;sub register 17 and register 18 = 0 = 00010100 - 00010100 = 00000000 S-flag unset N-flag unset Z-flag set
LDI R16, 20						;load  into register 16, 20
LDI R18, 15						;load  into register 18, 15
mov r17, r18					;move register 18 into register 17
SUB R17, R16					;sub register 17 and register 18 = -5 = 00010100 - 00001111 = 11111011 S-flag set N-flag set C-flag set
LDI R16, 120					;load  into register 16, 120
LDI R18, 160					;load  into register 18, 160
mov r17, r18					;move register 18 into register 17
SUB R17, R16					;sub register 17 and register 18 = 40 = 01111000 - 10100000 = 00101000 H-flag set S-flag ? N-flag unset C-flag unset
LDI R16, 160					;load  into register 16, 160
LDI R18, 120					;load  into register 18, 120
mov r17, r18					;move register 18 into register 17
SUB R17, R16					;sub register 17 and register 18 = -40 = 10100000 - 01111000 = 11011000 H-flag unset S-flag unset V-flag ? n-flag set C-flag set
LDI R16, 12						;load  into register 16, 12
LDI R18, 30						;load  into register 18, 30
mov r17, r18					;move register 18 into register 17
MUL R17, R16					;multiply register 17 and register 18 = 360 = 00001100 * 00011110 = 00011110 V-flag ? N-flag ? C-flag unset
ldi R18, 5
