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
	BRz OPTION_1			;checks if all machines are busy
	
	ADD R1, R1, #-1			;checks if all machines are free
	BRz OPTION_2

	ADD R1, R1, #-1
	BRz OPTION_3			;# of busy machines
	
	ADD R1, R1, #-1
	BRz OPTION_4			;#of free machines

	ADD R1, R1, #-1
	BRz OPTION_5			;mach stat

	ADD R1, R1, #-1
	BRz OPTION_6			;first free

	ADD R1, R1, #-1
	BRz OPTION_7			;end/goodbye

OPTION_1				;check if all busy
	LD R4, BUSY_ALL
	JSRR R4
	LEA R0, NEWLINE
	PUTS
	ADD R2, R2, #0
	BRp IF_BUSY
	
IF_NOT_BUSY
	LEA R0, ALLNOTBUSY
	PUTS
	BR INTRO

IF_BUSY
	LEA R0, ALLBUSY
	PUTS
	BR INTRO

OPTION_2				;check if all free
	LD R4, FREE_ALL
	JSRR R4
	LEA R0, NEWLINE
	PUTS
	ADD R2, R2, #0
	BRp IF_FREE

IF_NOT_FREE
	LEA R0, NOTFREE
	PUTS
	BR INTRO

IF_FREE
	LEA R0, FREE
	PUTS
	BR INTRO

OPTION_3				;# of busy machines
	LD R4, BUSY_NUM
	JSRR R4
	ADD R3, R2, #0
	LEA R0, NEWLINE
	PUTS
	LEA R0, BUSYMACHINE1
	PUTS
	LD R4, MACH_COUNT
	JSRR R4
	LEA R0, BUSYMACHINE2
	PUTS
	BR INTRO
	
OPTION_4				;# of free machines
	LD R4, FREE_NUM
	JSRR R4
	ADD R3, R2, #0
	LEA R0, NEWLINE
	PUTS
	LEA R0, FREEMACHINE1
	PUTS
	LD R4, MACH_COUNT
	JSRR R4
	LEA R0, FREEMACHINE2
	PUTS
	BR INTRO

OPTION_5				;status of machines
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
	LD R5, MACH_COUNT
	JSRR R5
	
	ADD R2, R2, #-1
	BRz FREE_MACH			;might be error here

BUSY_MACH
	LEA R0, STATUS2
	PUTS
	BR INTRO

FREE_MACH
	LEA R0, STATUS3 
	PUTS
	BR INTRO

OPTION_6				;first free machine
	LD R2, FREE_FIRST
	ADD R5, R5, #1
	LD R6, NEG_DEC_54
	ADD R1, R1, R5
	ADD R1, R1, R6
	JSRR R2
	
	LEA R0, NEWLINE
	PUTS

	ADD R2, R2, #0
	BRz NO_MACH			;possible error here

CHECK_MACH
	LEA R0, FIRSTFREE
	PUTS
	AND R3, R3, #0
	ADD R3, R2, #0
	LD R2, MACH_COUNT
	JSRR R2
	LEA R0, NEWLINE
	PUTS
	BR INTRO
	
NO_MACH
	ADD R6, R6, #0
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
MENU_PTR	.FILL	x3300
BUSY_ALL	.FILL	x3600
FREE_ALL	.FILL	x3900
BUSY_NUM	.FILL	x4200
FREE_NUM	.FILL	x4500
MACH_STAT	.FILL	x4800
FREE_FIRST	.FILL	x5100
USER_INPUT	.FILL	x5400
MACH_COUNT		.FILL	x5700

;Other data 
NEWLINE	.STRINGZ	"\n"
NEG_DEC_53	.FILL	#-53
NEG_DEC_54	.FILL	#-54

;Strings for options
Goodbye .Stringz "Goodbye!\n"
ALLNOTBUSY .Stringz "Not all machines are busy\n"
ALLBUSY .Stringz "All machines are busy\n"
FREE .STRINGZ "All machines are free\n"
NOTFREE .STRINGZ "Not all machines are free\n"
BUSYMACHINE1 .STRINGZ "There are "
BUSYMACHINE2 .STRINGZ " busy machines\n"
FREEMACHINE1 .STRINGZ "There are "
FREEMACHINE2 .STRINGZ " free machines\n"
STATUS1 .STRINGZ "Machine "
STATUS2  .STRINGZ " is busy\n"
STATUS3 .STRINGZ " is free\n"
FIRSTFREE .STRINGZ "The first available machine is number "
FIRSTFREE2 .STRINGZ "\n"
FIRSTFREE3 .STRINGZ "No machines are free\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.ORIG x3300
;HINT back up 
ST R0, R0_3300
ST R1, R1_3300
ST R2, R2_3300
ST R3, R3_3300
ST R4, R4_3300
ST R5, R5_3300
ST R6, R6_3300
ST R7, R7_3300


AND R1, R1, #0
AND R5, R5, #0
AND R3, R3, #0
AND R4, R4, #0
AND R6, R6, #0

INTRO_3300
	LD R0, Menu_string_addr
	PUTS
	GETC
	OUT
	
	LD R5, NEG_DEC_55
	LD R6, NEG_DEC_6
	AND R2, R2, #0
	ADD R2, R2, R0
	ADD R2, R2, R5
	BRnz CHECK_3300
	
IF_ERROR_3300
	LEA R0, Error_message_1 
	PUTS
	BR INTRO_3300
	
CHECK_3300
	ADD R2, R2, R6
	BRn IF_ERROR_3300		;possible error

NEXT_3300
	ADD R3, R3, R0
	LD R5, HEX_CONV_3300
	ADD R3, R3, R5

;HINT Restore
LD R0, R0_3300
LD R2, R2_3300
LD R4, R4_3300
LD R5, R5_3300
LD R6, R6_3300
LD R7, R7_3300

RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_message_1 .STRINGZ "INVALID INPUT\n"
Menu_string_addr .FILL x6000

NEG_DEC_55	.FILL	#-55
NEG_DEC_6	.FILL	#-6
HEX_CONV_3300	.FILL	#-48

R0_3300	.BLKW	#1
R1_3300	.BLKW	#1
R2_3300	.BLKW	#1
R3_3300	.BLKW	#1
R4_3300	.BLKW	#1
R5_3300	.BLKW	#1
R6_3300	.BLKW	#1
R7_3300	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.ORIG x3600
;HINT back up 
ST R0, R0_3600
ST R1, R1_3600
ST R2, R2_3600
ST R3, R3_3600
ST R4, R4_3600
ST R5, R5_3600
ST R6, R6_3600
ST R7, R7_3600

AND R2, R2, x0
LDI R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY
BRnp END_3600
ADD R2, R2, #1

END_3600
	LD R0, R0_3600
	LD R3, R3_3600
	LD R1, R1_3600
	LD R4, R4_3600
	LD R5, R5_3600
	LD R6, R6_3600
	LD R7, R7_3600
	RET
;HINT Restore

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xD000

R0_3600	.BLKW	#1
R1_3600	.BLKW	#1
R2_3600	.BLKW	#1
R3_3600	.BLKW	#1
R4_3600	.BLKW	#1
R5_3600	.BLKW	#1
R6_3600	.BLKW	#1
R7_3600	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
.ORIG x3900
;HINT back up 
ST R0, R0_3900
ST R1, R1_3900
ST R2, R2_3900
ST R3, R3_3900
ST R4, R4_3900
ST R5, R5_3900
ST R6, R6_3900
ST R7, R7_3900

AND R2, R2, x0

LDI R0, BUSYNESS_ADDR_ALL_MACHINES_FREE
NOT R0, R0
BRnp END_3900

ADD R2, R2, #1

END_3900
	LD R0, R0_3900
	LD R3, R3_3900
	LD R1, R1_3900
	LD R4, R4_3900
	LD R5, R5_3900
	LD R6, R6_3900
	LD R7, R7_3900
;HINT Restore


;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xD000

R0_3900	.BLKW	#1
R1_3900	.BLKW	#1
R2_3900	.BLKW	#1
R3_3900	.BLKW	#1
R4_3900	.BLKW	#1
R5_3900	.BLKW	#1
R6_3900	.BLKW	#1
R7_3900	.BLKW	#1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.ORIG x4200
;HINT back up 
ST R0, R0_4200
ST R1, R1_4200
ST R2, R2_4200
ST R3, R3_4200
ST R4, R4_4200
ST R5, R5_4200
ST R6, R6_4200
ST R7, R7_4200

AND R2, R2, #0
LD R5, DEC_16_4200

LDI R1, BUSYNESS_ADDR_NUM_BUSY_MACHINES
BRn IF_FREE_4200
BR COUNTER_4200

COUNTER_4200
	ADD R1, R1, R1
	BRn IF_FREE_4200
	ADD R5, R5, #-1
	BRz END_4200
	BRnp COUNTER_4200
	
IF_FREE_4200	
	ADD R2, R2, #1
	ADD R5, R5, #-1
	BRz END_4200
	BRnp COUNTER_4200

END_4200
	LD R5, DEC_16_4200
	NOT R2, R2
	ADD R2, R2, #1
	ADD R2, R2, R5
	LD R0, R0_4200
	LD R3, R3_4200
	LD R1, R1_4200
	LD R4, R4_4200
	LD R5, R5_4200
	LD R6, R6_4200
	LD R7, R7_4200
RET
;HINT Restore

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xD000
DEC_16_4200	.FILL	#16

R0_4200	.BLKW	#1
R1_4200	.BLKW	#1
R2_4200	.BLKW	#1
R3_4200	.BLKW	#1
R4_4200	.BLKW	#1
R5_4200	.BLKW	#1
R6_4200	.BLKW	#1
R7_4200	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.ORIG x4500
;HINT back up 
ST R0, R0_4500
ST R1, R1_4500
ST R2, R2_4500
ST R3, R3_4500
ST R4, R4_4500
ST R5, R5_4500
ST R6, R6_4500
ST R7, R7_4500

LD R5, DEC_16_4500
AND R2, R2, #0
LDI R1, BUSYNESS_ADDR_NUM_FREE_MACHINES

ADD R1, R1, #0
BRn IF_FREE_4500

COUNTER_4500
	ADD R1, R1, R1
	BRn IF_FREE_4500
	ADD R5, R5, #-1
	BRz END_4500
	BRnp COUNTER_4500
	
IF_FREE_4500
	ADD R2, R2, #1
	ADD R5, R5, #-1
	BRnp COUNTER_4500

END_4500
	LD R0, R0_4500
	LD R3, R3_4500
	LD R1, R1_4500
	LD R4, R4_4500
	LD R5, R5_4500
	LD R6, R6_4500
	LD R7, R7_4500

;HINT Restore

;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xD000
DEC_16_4500

R0_4500 .BLKW #1
R1_4500 .BLKW #1
R2_4500 .BLKW #1
R3_4500 .BLKW #1
R4_4500 .BLKW #1
R5_4500 .BLKW #1
R6_4500 .BLKW #1
R7_4500 .BLKW #1


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------

;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_message_2 .STRINGZ "ERROR INVALID INPUT\n"
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: 
; Postcondition: 
; The subroutine prints the number that is in 
; Return Value : 
; NOTE: This subroutine should print the number to the user WITHOUT 
;		leading 0's and DOES NOT output the '+' for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------

;--------------------------------
;Data for subroutine print number
;--------------------------------



.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xD000			; Remote data
BUSYNESS .FILL xABCD		; <----!!!VALUE FOR BUSYNESS VECTOR!!!

;---------------	
;END of PROGRAM
;---------------	
.END
