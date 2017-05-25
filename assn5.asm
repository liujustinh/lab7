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
	
	AND R1, R1, #0
	AND R2, R2, #0
	ADD R3, R3, #-1
	BRz OPTION_1			;checks if all machines are busy
	
	ADD R3, R3, #-1			;checks if all machines are free
	BRz OPTION_2

	ADD R3, R3, #-1
	BRz OPTION_3			;# of busy machines
	
	ADD R3, R3, #-1
	BRz OPTION_4			;#of free machines

	ADD R3, R3, #-1
	BRz OPTION_5			;mach stat

	ADD R3, R3, #-1
	BRz OPTION_6			;first free

	ADD R3, R3, #-1
	BRz OPTION_7			;end/goodbye

OPTION_1
	LD R4, BUSY_ALL
	JSRR R4

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
PRINT		.FILL	x5700

NEWLINE	.STRINGZ	"\n"

;Other data 

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
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_message_1 .STRINGZ "INVALID INPUT\n"
Menu_string_addr .FILL x6000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xD000


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xD000


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
