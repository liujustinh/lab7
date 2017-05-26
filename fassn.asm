;=================================================
; Name: Justin Liu
; Email: jliu076@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 26
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
INTRO
LD R4, MENU_PTR
JSRR R4					

AND R2, R2, #0
AND R3, R3, #0

ADD R1, R1, #-1
BRz OPTION_1							
ADD R1, R1, #-1
BRz OPTION_2								
ADD R1, R1, #-1
BRz OPTION_3						
ADD R1, R1, #-1
BRz OPTION_4						
ADD R1, R1, #-1
BRz OPTION_5					
ADD R1, R1, #-1
BRz OPTION_6					
ADD R1, R1, #-1
BRz OPTION_7				


OPTION_1	
	LD R4, BUSY_ALL
	JSRR R4
	LEA R0, NEWLINE
	PUTS
	ADD R2, R2, #0
	BRz IF_FREE

IF_BUSY
	LEA R0, ALLBUSY
	PUTS
	BR INTRO

IF_FREE
	LEA R0, ALLNOTBUSY
	PUTS
	BR INTRO


OPTION_2			
	LD R4, FREE_ALL
	JSRR R4
	LEA R0, NEWLINE
	PUTS
	ADD R2, R2, #0
	BRp IF_FREE2
	BRz IF_NOT_FREE
IF_FREE2
	LEA R0, FREE
	PUTS
	BR INTRO

IF_NOT_FREE
	LEA R0, NOTFREE
	PUTS
	BR INTRO

OPTION_3			
	LD R4, BUSY_NUM
	JSRR R4
	ADD R3, R2, #0
	LEA R0, NEWLINE
	PUTS
	LEA R0, BUSYMACHINE1
	PUTS
	LD R4, PRINT_NUM
	JSRR R4
	LEA R0, BUSYMACHINE2
	PUTS
	BR INTRO

OPTION_4		
	LD R4, FREE_NUM
	JSRR R4
	ADD R3, R2, #0
	LEA R0, NEWLINE
	PUTS	
	LEA R0, FREEMACHINE1
	PUTS
	LD R4, PRINT_NUM
	JSRR R4
	LEA R0, FREEMACHINE2
	PUTS
	BR INTRO

OPTION_5
	LD R2, MACH_STAT
	ADD R5, R5, #1
	LD R6, NEG_DEC_53
	ADD R1, R1, R5
	ADD R1, R1, R6
	JSRR R2
    
	LEA R0, NEWLINE
	PUTS
	LEA R0, STATUS1
	PUTS
	
	LD R5, PRINT_NUM
	JSRR R5

	ADD R2, R2, #-1
	BRz FREE_MACH
	BRn BUSY_MACH

FREE_MACH
	LEA R0, STATUS3
	PUTS 
	BR INTRO

BUSY_MACH
	LEA R0, STATUS2
	PUTS
	BR INTRO

OPTION_6		
	LD R2, FREE_FIRST
	ADD R5, R5, #1
	LD R6, NEG_DEC_54
	ADD R1, R1, R5
	ADD R1, R1, R6
	JSRR R2
	LEA R0, NEWLINE
	PUTS

ADD R2, R2, #0
BRz NO_MACH
BRp CHECK_MACH

CHECK_MACH
	LEA R0, FIRSTFREE
	PUTS
	AND R3, R3, #0
	ADD R3, R2, #0
	LD R2, PRINT_NUM
	JSRR R2
	LEA R0, NEWLINE
	PUTS
	BR INTRO

NO_MACH
	ADD R6, R6,#0
	BRp CHECK_MACH
	LEA R0, FIRSTFREE3
	PUTS
	BR INTRO
    


OPTION_7
	LEA R0, NEWLINE
	PUTS
	LEA R0, Goodbye
	PUTS

LEA R0, NEWLINE
PUTS

HALT
;---------------	
;Data
;---------------
;Add address for subroutines
MENU_PTR		.FILL	x3200
BUSY_ALL		.FILL	x3400
FREE_ALL		.FILL	x3600
BUSY_NUM		.FILL	x3800
FREE_NUM		.FILL	x4000
MACH_STAT		.FILL	x4200
FREE_FIRST		.FILL	x4400
GET_INPUT		.FILL	x4600
PRINT_NUM	.FILL	x4800

;Other data
NEG_DEC_53		.FILL	#-53 
NEG_DEC_54		.FILL	#-54
NEWLINE		.STRINGZ	"\n"
CONVERT_MAIN		.FILL		x30
;Strings for options
Goodbye .Stringz "Goodbye!\n"
ALLNOTBUSY .Stringz "Not all machines are busy\n"
ALLBUSY .Stringz "All machines are busy\n"
FIRSTFREE3 .STRINGZ "No machines are free\n"
FREE .STRINGZ "All machines are free\n"
NOTFREE .STRINGZ "Not all machines are free\n"
BUSYMACHINE1 .STRINGZ "There are "
BUSYMACHINE2 .STRINGZ " busy machines\n"
FREEMACHINE1 .STRINGZ "There are "
FREEMACHINE2 .STRINGZ " free machines\n"
STATUS1 .STRINGZ "Machine "
STATUS3 .STRINGZ " is free\n"
STATUS2  .STRINGZ " is busy\n"

FIRSTFREE .STRINGZ "The first available machine is number "


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3200
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
;HINT back up 
ST R0, R0_3200
ST R1, R1_3200
ST R2, R2_3200
ST R3, R3_3200
ST R4, R4_3200
ST R5, R5_3200
ST R6, R6_3200
ST R7, R7_3200

AND R1, R1, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0

INTRO_3200
	LD R0, Menu_string_addr
	PUTS

	GETC
	OUT

	LD R5, NEG_DEC_55_3200
	LD R6, DEC_6_3200
	AND R2, R2, #0
	ADD R2, R2, R0
  
CHECK_3200
	ADD R2, R2, R5
	BRnz NEXT_3200
	BRp ERROR_3200

NEXT_3200
	ADD R2, R2, R6
	BRzp END_3200

ERROR_3200
	LEA R0, Error_message_1
	PUTS
	BR INTRO_3200

END_3200
	ADD R1, R1, R0
	LD R5, HEX_CONV_3200
	ADD R1, R1, R5

;HINT Restore
LD R0, R0_3200
LD R2, R2_3200
LD R3, R3_3200
LD R4, R4_3200
LD R5, R5_3200
LD R6, R6_3200
LD R7, R7_3200

RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_message_1 .STRINGZ "\nINVALID INPUT\n"
Menu_string_addr .FILL x6000
HEX_CONV_3200		.FILL	#-48
NEG_DEC_55_3200		.FILL	#-55
DEC_6_3200		.FILL	#6

R0_3200	.BLKW	#1
R1_3200	.BLKW	#1	
R2_3200	.BLKW	#1
R3_3200	.BLKW	#1
R4_3200	.BLKW	#1
R5_3200	.BLKW	#1
R6_3200	.BLKW	#1
R7_3200	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3400
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
;HINT back up 
ST R0, R0_3400
ST R1, R1_3400
ST R2, R2_3400
ST R3, R3_3400
ST R4, R4_3400
ST R5, R5_3400
ST R6, R6_3400
ST R7, R7_3400

AND R2, R2, #0			

LDI R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY
BRz IF_BUSY_3400						
BR END_3400

IF_BUSY_3400
	ADD R2, R2, #1			
	BR END_3400

END_3400
	LD R0, R0_3400
	LD R1, R1_3400
	LD R5, R5_3400
	LD R6, R6_3400
	LD R3, R3_3400
	LD R4, R4_3400
	LD R7, R7_3400
RET
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xD000

R0_3400	.BLKW	#1
R1_3400	.BLKW	#1	
R2_3400	.BLKW	#1
R3_3400	.BLKW	#1
R4_3400	.BLKW	#1
R5_3400	.BLKW	#1
R6_3400	.BLKW	#1
R7_3400	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3600
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
;HINT back up 
ST R0, R0_3600
ST R1, R1_3600
ST R2, R2_3600
ST R3, R3_3600
ST R4, R4_3600
ST R5, R5_3600
ST R6, R6_3600
ST R7, R7_3600

AND R2, R2, #0

LDI R0, BUSYNESS_ADDR_ALL_MACHINES_FREE
NOT R0, R0

BRnp END_3600

FREE_3600
	ADD R2, R2, #1


END_3600

;HINT Restore
LD R0, R0_3600
LD R1, R1_3600
LD R3, R3_3600
LD R4, R4_3600
LD R5, R5_3600
LD R6, R6_3600
LD R7, R7_3600
RET
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xD000

R0_3600		.BLKW	#1
R1_3600		.BLKW	#1	
R2_3600		.BLKW	#1
R3_3600		.BLKW	#1
R4_3600		.BLKW	#1
R5_3600		.BLKW	#1
R6_3600		.BLKW	#1
R7_3600		.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3800
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
;HINT back up 
ST R0, R0_3800
ST R1, R1_3800
ST R2, R2_3800
ST R3, R3_3800
ST R4, R4_3800
ST R5, R5_3800
ST R6, R6_3800
ST R7, R7_3800

AND R2, R2, #0

LD R5, COUNTER_3800


LDI R1, BUSYNESS_ADDR_NUM_BUSY_MACHINES
BRn IF_FREE_3800
							
COUNT_3800
	ADD R1, R1, R1				
	BRn IF_FREE_3800

ADD R5, R5, #-1
BRz END_3800
BRnp COUNT_3800

IF_FREE_3800
	ADD R2, R2, #1
	ADD R5, R5, #-1
	BRz END_3800
	BRnp COUNT_3800

END_3800
	LD R5, COUNTER_3800	
	NOT R2, R2
	ADD R2, R2, #1			
	ADD R2, R2, R5		

;HINT Restore
LD R0, R0_3800
LD R1, R1_3800
LD R3, R3_3800
LD R4, R4_3800
LD R5, R5_3800
LD R6, R6_3800
LD R7, R7_3800
RET
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xD000
COUNTER_3800	.FILL	#16
R0_3800		.BLKW	#1
R1_3800		.BLKW	#1	
R2_3800		.BLKW	#1
R3_3800		.BLKW	#1
R4_3800		.BLKW	#1
R5_3800		.BLKW	#1
R6_3800		.BLKW	#1
R7_3800		.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4000
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
;HINT back up 
ST R0, R0_4000
ST R1, R1_4000
ST R2, R2_4000
ST R3, R3_4000
ST R4, R4_4000
ST R5, R5_4000
ST R6, R6_4000
ST R7, R7_4000

LD R5, COUNTER_4000
AND R2, R2, #0
LDI R1, BUSYNESS_ADDR_NUM_FREE_MACHINES

ADD R1, R1, #0
BRn IF_FREE_4000

COUNT_4000
	ADD R1, R1, R1
	BRn IF_FREE_4000
	ADD R5, R5, #-1
	BRz END_4000
	BRnp COUNT_4000

IF_FREE_4000
	ADD R2, R2, #1
	ADD R5, R5, #-1
	BRnp COUNT_4000

END_4000
	LD R0, R0_4000
	LD R1, R1_4000
	LD R5, R5_4000
	LD R4, R4_4000
	LD R3, R3_4000
	LD R6, R6_4000
	LD R7, R7_4000
RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xD000

COUNTER_4000	.FILL	#16

R0_4000		.BLKW	#1
R1_4000		.BLKW	#1	
R2_4000		.BLKW	#1
R3_4000		.BLKW	#1
R4_4000		.BLKW	#1
R5_4000		.BLKW	#1
R6_4000		.BLKW	#1
R7_4000		.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4200
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
ST R1, R1_4200
ST R5, R5_4200
ST R4, R4_4200
ST R6, R6_4200
ST R7, R7_4200

AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0

LD R2, USER_INPUT
JSRR R2

AND R2, R2, #0
LD R5, COUNTER_4200
ADD R6, R3, #0
NOT R6, R6
ADD R6, R6, #1
ADD R5, R5, R6

LD R4, BUSYNESS_ADDR_MACHINE_STATUS
LDR R1, R4, #0

CHECKER_4200
	ADD R5, R5, #0
	BRnz CHECK_STATUS

	ADD R1, R1, R1
	ADD R5, R5, #-1
	BRp CHECKER_4200

CHECK_STATUS
	ADD R1, R1, #0
	BRzp IF_FAIL_4200
	ADD R2, R2, #1
	BR END_4200

IF_FAIL_4200
  AND R2, R2, #0

END_4200
	LD R1, R1_4200
	LD R5, R5_4200
	LD R4, R4_4200
	LD R6, R6_4200
	LD R7, R7_4200

RET
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xD000
INPUTCALL	.FILL	x4600
MACH_42		.FILL	#16
USER_INPUT    	.FILL        x4600
COUNTER_4200    .FILL        #15

;DATA BK
R0_4200	.BLKW	#1
R1_4200	.BLKW	#1	
R2_4200	.BLKW	#1
R3_4200	.BLKW	#1
R4_4200	.BLKW	#1
R5_4200	.BLKW	#1
R6_4200	.BLKW	#1
R7_4200	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4400
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
;HINT back up
;ST R0, R0_44
;ST R1, R1_44
;ST R3, R3_44
;ST R4, R4_44
;ST R5, R5_44
;ST R6, R6_44
;ST R7, R7_44

ST R1, R1_44
ST R3, R3_44
ST R5, R5_44
ST R4, R4_44
ST R7, R7_44

AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0

LD R4, BUSYNESS_ADDR_FIRST_FREE
LDR R1, R4, #0

;LDI R6, BUSYNESS_ADDR_FIRST_FREE

LD R5, DEC_15_44

FIND_44
  ADD R1, R1, #0
  BRn FIRST_CASE
  BRzp SECOND_CASE

FIRST_CASE
  ADD R6, R6, #1
  AND R2, R2, #0
  ADD R2, R2, R5
  ADD R5, R5, #-1
  BR BITSHIFT_44

SECOND_CASE
  ADD R5, R5, #-1

BITSHIFT_44
  ADD R1, R1, R1
  
CHECK_44
  ADD R5, R5, #0
  BRzp FIND_44

;HINT Restore
LD R1, R1_44
LD R3, R3_44
LD R5, R5_44
LD R4, R4_44
LD R7, R7_44

RETURN_7
  RET

;HINT Restore

;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------

BUSYNESS_ADDR_FIRST_FREE .Fill xD000
R1_44        .BLKW        #1   
R3_44        .BLKW        #1
R4_44        .BLKW        #1
R5_44        .BLKW        #1
R6_44        .BLKW        #1
R7_44        .BLKW        #1
DEC_15_44      .FILL        #15 
; WORD_CT      .FILL        #15

; R0_44		.BLKW	#1
; R1_44		.BLKW	#1	
; R2_44		.BLKW	#1
; R3_44		.BLKW	#1
; R4_44		.BLKW	#1
; R5_44		.BLKW	#1
; R6_44		.BLKW	#1
; R7_44		.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5 .....4?
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4600
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
ST R1, R1_4600
ST R2, R2_4600
ST R5, R5_4600
ST R4, R4_4600
;ST R5, R5_4600
ST R6, R6_4600
ST R7, R7_4600

LD R0, NEWLINE_4600
OUT

INTRODUCTION
LEA R0, prompt ;Output Intro Message
PUTS
LD R2, DASH_DEC
LD R5, PLUS_DEC
;LD R6, CONVERT_46
AND R3, R3, #0
BR CZECH


;Example of how to Output Error Message
ERROR
;LD R0, NEWLINE_4600
;OUT
LEA R0, Error_message_2  ;Output Error Message
PUTS
BR INTRODUCTION

ERROR2
LD R0, NEWLINE_4600
OUT
LEA R0, Error_message_2  ;Output Error Message
PUTS
BR INTRODUCTION


CZECH
GETC
OUT
ADD R1, R0, #0
ADD R1, R1, #-10		;MAKES SURE THERE IS NO ENTER AS FIRST CHAR
BRz ERROR

ADD R1, R0, #0
ADD R1, R1, R2			;DECREMENTS AND CHECKS FOR MINUS SIGN
BRz FLAG
ADD R1, R0, #0
ADD R1, R1, R5			;ADDS THE PLUS VALUE BACK AND CHECKS that
BRz REINIT			

LD R6, COUNTER
AND R5, R5, #0
;ADD R6, R6, #-1
ADD R1, R0, #0
BR INPUT

LASTCHECK			;CHECKS FOR ANY ERRORS IN THE LAST CHARACTER, NEEDS TO SKRRRRT TO THE NEXT INPUT THO
GETC
OUT
ADD R1, R0, #0
ADD R1, R1, #-10
BRz ERROR
ADD R1, R0, #0
BR INPUT

FLAG 							;;;;THIS IS FOR THE NEGATIVE CASE
LD R6, COUNTER
AND R5, R5, #0
ADD R5, R5, #1					;NEED TO INDICATE SIGN TO MAKE THINGS HAPPEN
BR LASTCHECK
;BR MORE_INPUT

REINIT							;THIS IS FOR THE POSITIVE CASE TO REINITIALIZE THE COUNTER
LD R6, COUNTER
;BR MORE_INPUT
BR LASTCHECK

MORE_INPUT						;THIS GETS INPUTS 2-5 (OR 6 IF SIGN)
GETC
OUT
BRp INPUT

INPUT								;THIS NEEDS TO BE HERE TO CHECK STUFF
LD R4, CONVERT_46
ADD R1, R0, #0				
ADD R1, R1, #-10			;MAKES ENTER GO TO END (AGAIN)
BRz ENDING
ADD R1, R0, #0				;REINIT THE VALUE TO CHECK SOMETHING ELSE
ADD R1, R1, R4				;THIS IS A CONVERT_46 CHECKER. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!NOT SURE WHY IT DOESNT WORK -48
BRn ERROR
ADD R1, R1, #-9
BRnz FORMULATE
BRp ERROR2

FORMULATE
ADD R1, R1, #9						
AND R4, R4, #0

ADD R4, R3, #0
LD R2, COUNTER2							;COUNTER2 = #9

MULTIPLY								;THIS IS WHERE R5 MAGIC HAPPENS
ADD R3, R3, R4
ADD R2, R2, #-1
BRp MULTIPLY

ADD R3, R3, R1
BR COUNT_CONTROL

COUNT_CONTROL									;COUNTER CONTROL UNIT
ADD R6, R6, #-1						;DECREMENTS THE MAIN COUNTER
BRz ENDING
BRp MORE_INPUT

ENDING
; LD R0, NEWLINE_4600
; OUT										;ENDING OF THE PROGRAM
ADD R5, R5, #-1
BRz R5_STABILIZE
BR ENDING2
R5_STABILIZE			;DOES THE 2S COMPLEMENT IF THE NEGATIVE FLAG WAS EVER THROWN
NOT R3, R3
ADD R3, R3, #1
;;;;;;;
; LD R6, NDEC_17
; ADD R5, R5, R6
; BRn ERROR		
; LD R6, DEC_17					;PSEUDO ERROR CHECK
; ADD R5, R5, R6
; ADD R5, R5, #-2
; BRn ERROR
; ADD R5, R5, #2
ENDING2

LD R4, ZERO
BRp TWOSC
LOOP_46
ADD R4, R3, #0
BRn ERROR
ADD R4, R3, #-15
BRp ERROR
BR END_46
TWOSC
NOT R3, R3
ADD R3, R3, #1
BR LOOP_46

END_46


LD R1, R1_4600
LD R2, R2_4600
LD R5, R5_4600
LD R4, R4_4600
;LD R5, R5_4600
LD R6, R6_4600
LD R7, R7_4600

RET

;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_message_2 .STRINGZ "ERROR INVALID INPUT\n"

NEWLINE_4600			.FILL 	x0A
COUNTER			.FILL	#5
COUNTER2		.FILL	#9
NUMBER 			.FILL	#7
DASH_DEC		.FILL	#-45
DASH_INC		.FILL	#45
PLUS_DEC		.FILL	#-43
PLUS_INC		.FILL	#43
CONVERT_46		.FILL	#-48
DEC_17			.FILL 	#17
NDEC_17			.FILL	#-17
ZERO 	.FILL #0
R1_4600	.BLKW 	#1
R2_4600	.BLKW	#1
R3_4600 .BLKW 	#1
R4_4600 .BLKW	#1
R5_4600 .BLKW	#1
R6_4600 .BLKW	#1
R7_4600 .BLKW	#1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: 
; Postcondition: 
; The subroutine prints the number that is in 
; Return Value : 
; NOTE: This subroutine should print the number to the user WITHOUT 
;		leading 0's and DOES NOT output the '+' for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4800
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
ST R1, BACK_R1_X3400
ST R2, BACK_R2_X3400
ST R3, BACK_R3_X3400
ST R4, BACK_R4_X3400
ST R5, BACK_R5_X3400
ST R6, BACK_R6_X3400
ST R7, BACK_R7_X3400

LD R1, TEN_K
LD R2, COUNTERZERO
LD R5, PLUSCVT

TEN_THOU
ADD R2, R2, #1
ADD R3, R3, R1
BRzp TEN_THOU

LD R1, TEN_KP
ADD R3, R3, R1
ADD R2, R2, #0
BRz NOT1

ADD R0, R2, R5
OUT

NOT1
LD R1, ONEK
LD R2, COUNTERZERO
LD R5, PLUSCVT

ONE_THOU
ADD R2, R2, #1
ADD R3, R3, R1
BRzp ONE_THOU

LD R1, ONEKP
ADD R3, R3, R1
ADD R2, R2, #0
BRz NOT2

ADD R0, R2, R5
OUT

NOT2
LD R1, HUNDRED
LD R2, COUNTERZERO
LD R5, PLUSCVT

HUNNID
ADD R2, R2, #1
ADD R3, R3, R1
BRzp HUNNID

LD R1, HUND
ADD R3, R3, R1
ADD R2, R2, #0
BRz NOT3

ADD R0, R2, R5
OUT

NOT3

LD R1, TENN
LD R2, COUNTERZERO
LD R5, PLUSCVT

TENS
ADD R2, R2, #1
ADD R3, R3, R1
BRzp TENS

LD R1, TN
ADD R3, R3, R1
ADD R2, R2, #0
BRz NOT4

ADD R0, R2, R5
OUT

NOT4
ADD R0, R3, #0
ADD R0, R0, R5
OUT


LD R1, BACK_R1_X3400
LD R2, BACK_R2_X3400
LD R3, BACK_R3_X3400
LD R4, BACK_R4_X3400
LD R5, BACK_R5_X3400
LD R6, BACK_R6_X3400
LD R7, BACK_R7_X3400
RET
;--------------------------------
;Data for subroutine print number
;--------------------------------
;DATA BK
BACK_R1_X3400 .BLKW #1
BACK_R2_X3400 .BLKW #1
BACK_R3_X3400 .BLKW #1
BACK_R4_X3400 .BLKW #1
BACK_R5_X3400 .BLKW #1
BACK_R6_X3400 .BLKW #1
BACK_R7_X3400 .BLKW #1
;LOC DATA
TEN_K .FILL #-10000
ONEK .FILL #-1000
HUNDRED .FILL #-100
TENN .FILL #-10

TEN_KP .FILL #10000
ONEKP .FILL #1000
HUND .FILL #100
TN .FILL #10


COUNTERZERO .FILL #-1
PLUSCVT .FILL #48



.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xD000			; Remote data
BUSYNESS .FILL xABCD		; <----!!!VALUE FOR BUSYNESS VECTOR!!!

;---------------	
;END of PROGRAM
;---------------	
.END
