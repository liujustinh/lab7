;=================================================
; Name: Tarun Motwani
; Email: tmotw001@ucr.edu 
; 
; Lab: lab 8
; Lab section: 025
; TA: Gaurav Jhaveri
;=================================================
.ORIG x3000

LD R0, ARRAY
LD R6, SUB_PTR
ADD R6, R6, #0
JSRR R6
LD R0, ARRAY
PUTS
LD R6, PTR2
JSRR R6

OUT
LD R4, CONVERT
ADD R4, R0, R4

HALT
;local data
SUB_PTR .fill	x4000
ARRAY .fill x5000
PTR2	.fill	x7000
CONVERT .fill	#-48


.ORIG x4000
ST R7, backup_R7_5000

ADD R1, R0, #0

LEA R0, INTRO
PUTS

LD R5, CTR

MAINLOOP
  GETC
  OUT
  STR R0, R1, #0
  ADD R5, R5, #1
  ADD R1, R1, #1
  ADD R0, R0, #-10
  BRz ENDING
  BRnp MAINLOOP

ENDING
  

LEA R0, NEWLINE
PUTS

LD R2, ZERO
ADD R1, R1, #-1
ADD R5, R5, #-1
STR R2, R1, #0

LD R7, backup_R7_5000

RET
;subdata
backup_R7_5000	.blkw #1
NEWLINE	.STRINGZ "\n"
CTR	.fill	#0
INTRO 	.STRINGZ "Type in a string, terminate with the Enter key \n"
ZERO	.fill #0

.ORIG x7000

ST R7, backup_R7_7000

LD R6, CAPS
JSRR R6

ADD R2, R5, R0
ADD R2, R2, #-1

COMPARE
  LDR R3, R0, #0
  LDR R4, R2, #0
  NOT R4, R4
  ADD R4, R4, #1
  ADD R3, R3, R4
  BRnp NOTAPP
  NOT R3, R2
  ADD R3, R3, #1
  ADD R3, R3, R0
  BRzp PALINDROME
  ADD R0, R0, #1
  ADD R2, R2, #-1
  BRnzp COMPARE

NOTAPP
  LEA R0, NEW2
  PUTS
  LD R0, CERO
  ADD R1, R1, #0
  BRnzp DONE

PALINDROME
  LEA R0, NEW2
  PUTS
  LD R0, ONE
  ADD R1, R1, #0
  BRnzp DONE

DONE

LD R7, backup_R7_7000

RET

;subdata
backup_R7_7000	.blkw #1
NEW2	.STRINGZ	"\n"
CERO	.fill	x30
ONE	.fill	x31
CAPS	.fill	x7500

.ORIG x7500

ST R7, backup_R7_7500

ADD R1, R0, #0
ADD R2, R5, #0
LD R4, TOUPPER

LOOP_NEXT
  LDR R3, R1, #0
  AND R3, R3, R4
  STR R3, R1, #0
  ADD R1, R1, #1
  ADD R2, R2, #-1
  BRz AFTER
  BRp LOOP_NEXT

AFTER

LD R7, backup_R7_7500

RET
;subdata
backup_R7_7500	.blkw #1
TOUPPER	.fill	x5F

.END