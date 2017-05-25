;=================================================
; Name: Tarun Motwani
; Email: tmotw001@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 025
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
INTRO_MAIN
LD R6, MENU_SUB
JSRR R6					

AND R2, R2, #0
AND R5, R5, #0

ADD R1, R1, #-1
BRz OPTION1							;1 CHECK TO SEE WHETHER ALL MACHINES ARE BUSY
ADD R1, R1, #-1
BRz OPTION2								;2 CHECK TO SEE WHETHER ALL MACHINES ARE FREE
ADD R1, R1, #-1
BRz OPTION3						;3 REPORT # OF BUSY MACHINES
ADD R1, R1, #-1
BRz OPTION4						;4 REPORT NUMBER OF FREE MACHINES
ADD R1, R1, #-1
BRz OPTION5						;5 MACH STAT OF MACHINE n
ADD R1, R1, #-1
BRz OPTION6						;6 REPORT FIRST FREE
ADD R1, R1, #-1
BRz PRINT_BYE					;7 GOODBYE


OPTION1			;ALL BUSY?
LD R6, ALL_BUSY
JSRR R6

LEA R0, NEWLINE_MAIN
PUTS


ADD R2, R2, #0
BRp TRUE_1
BRz FALSE_1


TRUE_1
LEA R0, ALLBUSY
PUTS
BR END_OPTION1

FALSE_1
LEA R0, ALLNOTBUSY
PUTS
BR END_OPTION1

END_OPTION1
BR INTRO_MAIN

OPTION2			; ALL FREE?
LD R6, ALL_FREE
JSRR R6

LEA R0, NEWLINE_MAIN
PUTS

ADD R2, R2, #0
BRp TRUE2
BRz FALSE2

TRUE2
LEA R0, FREE
PUTS
BR END_OPTION2

FALSE2
LEA R0, NOTFREE
PUTS


BR END_OPTION2

END_OPTION2
BR INTRO_MAIN

OPTION3			;# BUSY?
	LD R6, NUM_BUSY
	JSRR R6
		
		ADD R5, R2, #0


LEA R0, NEWLINE_MAIN
PUTS
		
	LEA R0, BUSYMACHINE1
	PUTS
	
	LD R6, PRINT_NUMBER
	JSRR R6
	
	LEA R0, BUSYMACHINE2
	PUTS
	
BR INTRO_MAIN

OPTION4			;# FREE?
	LD R6, NUM_FREE
	JSRR R6

		ADD R5, R2, #0

LEA R0, NEWLINE_MAIN
PUTS	
	LEA R0, FREEMACHINE1
	PUTS
	
	LD R6, PRINT_NUMBER
	JSRR R6
	
	LEA R0, FREEMACHINE2
	PUTS
	
BR INTRO_MAIN

;OPTION5			;MACH STAT?
; LD R6, MACH_STAT
; JSRR R6

; LEA R0, STATUS1
; PUTS

; LD R6, CONVERT_MAIN

; AND R0, R0, #0
; ADD R0, R5, #0
; ADD R0, R0, R6
; OUT

; ADD R2, R2, #0
; BRz	BUSY_MAIN
; BRp FREE_MAIN

; BUSY_MAIN
; LEA R0, STATUS2
; PUTS
; BR END_OPTION5

; FREE_MAIN
; LEA R0, STATUS3
; PUTS
; BR END_OPTION5
; END_OPTION5

; BR INTRO_MAIN
OPTION5
      LD R2, MACH_STAT
      ADD R3, R3, #1
      LD R4, C5
      ADD R1, R1, R3
      ADD R1, R1, R4
      ;BRnp CHOICE_6
      JSRR R2
    
    MACHA
	LEA R0, NEWLINE_MAIN
	PUTS
	LEA R0, STATUS1
	PUTS
	
	
	LD R3, PRINT_NUMBER
	JSRR R3

	CHECK_MAIN
	  ADD R2, R2, #-1
	  BRz FREE_3K
	  BRn BUSY_3K
	
	FREE_3K
	  LEA R0, STATUS3
	  PUTS 
	  BR INTRO_MAIN
      
	BUSY_3K
	  LEA R0, STATUS2
	  PUTS
	  BR INTRO_MAIN


OPTION6			;FIRSTFREE
; LD R6, FIRST_FREE
; JSRR R6
LD R2, FIRST_FREE
ADD R3, R3, #1
LD R4, C6
ADD R1, R1, R3
ADD R1, R1, R4
JSRR R2
  
LEA R0, NEWLINE_MAIN
PUTS
      
MACH1
ADD R2, R2, #0
BRz MACH0
BRp NUM_MACH

MACH0
ADD R4, R4,#0
BRp NUM_MACH
NO_MACHINE
LEA R0, FIRSTFREE3
PUTS
BR INTRO_MAIN
    
NUM_MACH
LEA R0, FIRSTFREE
PUTS
AND R5, R5, #0
ADD R5, R2, #0
LD R2, PRINT_NUMBER
JSRR R2
LEA R0, NEWLINE_MAIN
PUTS
BR INTRO_MAIN

PRINT_BYE
LEA R0, NEWLINE_MAIN
PUTS


LEA R0, Goodbye
PUTS
BR END

END
LEA R0, NEWLINE_MAIN
PUTS

HALT
;---------------	
;Data
;---------------
;Add address for subroutines
MENU_SUB		.FILL	x3200
ALL_BUSY		.FILL	x3400
ALL_FREE		.FILL	x3600
NUM_BUSY		.FILL	x3800
NUM_FREE		.FILL	x4000
MACH_STAT		.FILL	x4200
FIRST_FREE		.FILL	x4400
GET_INPUT		.FILL	x4600
PRINT_NUMBER	.FILL	x4800
;Other data
C5		.FILL	#-53 
C6		.FILL	#-54
NEWLINE_MAIN		.STRINGZ	"\n"
CONVERT_MAIN		.FILL		x30
;Strings for options
FIRSTFREE3 .STRINGZ "No machines are free\n"
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
STATUS3 .STRINGZ " is free\n"
STATUS2  .STRINGZ " is busy\n"

FIRSTFREE .STRINGZ "The first available machine is number "
;FIRSTFREE2 .STRINGZ "\n"



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
ST R0, R0_32
ST R1, R1_32
ST R2, R2_32
ST R3, R3_32
ST R4, R4_32
ST R5, R5_32
ST R6, R6_32
ST R7, R7_32

;INTRO_32
;AND R1, R1, #0
;AND R2, R2, #0

AND R1, R1, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0

INTRO_32
LD R0, Menu_string_addr
PUTS

GETC
OUT

LD R3, NDEC_55
LD R4, NDEC_6
AND R2, R2, #0
ADD R2, R2, R0
  
CHECK_32
ADD R2, R2, R3
BRnz CHECK_32_2
BRp ERROR_32

CHECK_32_2
ADD R2, R2, R4
BRzp RETURN_32

ERROR_32
;LEA R0, NEWLINE_32
;PUTS
LEA R0, Error_message_1
PUTS
BR INTRO_32

RETURN_32
ADD R1, R1, R0
LD R3, CONVERT_32
ADD R1, R1, R3
; LD R2, CONVERT_32
; LD R3, NDEC_7
; LD R4, NDEC_6
; MENU_32
; LD R0, Menu_string_addr
 ; PUTS

 ; GETC
 ; OUT
; ADD R5, R5, R0

; CHECK_32
; ADD R5, R5, R2
; ADD R5, R5, R3
; BRnz CHECK2_32
; BRp ERROR_32

; CHECK2_32
; ADD R5, R5, R4
; BRzp CHOICE_32

; ERROR_32
; LEA R0, NEWLINE_32
; PUTS
; LEA R0, Error_message_1
; PUTS
; BR MENU_32

; CHOICE_32
; ADD R1, R1, R0

; END_32 
 
 
 ; BR INPUT_32
;							INPUT FOR THE MENU
; INPUT_32
; GETC
; OUT
						;PUT INTO REG 1 .... WE CAN CHECK DIS NOW
; ADD R1, R1, R0
; NOT R2, R2
; ADD R2, R2, #1
; ADD R1, R1, R2
								;GOTTA PUT IT BACK LATER
; CHECK_32
;							THE VALUE WILL BE BETWEEN 1 THRU 7 SO ASCII 49 THRU 56
; ADD R1, R1, #-7
; BRp ERR_32
; ADD R1, R1, #7
								;DIS TAKE MORE OUT OF QUESTION
; ADD R1, R1, #-1
; BRn ERR_32
; ADD R1, R1, #1
; BR END_32


; ERR_32
; LEA R0, Error_message_1
; PUTS
; BR INTRO_32


; END_32





; NOT R4, R4
; ADD R4, R4, #1
;LETS TAKE POSITIVE CONVERT VAL TO NEG
;SUBTRACT TO GET RESULT
;RETURN R1

;HINT Restore
LD R0, R0_32
;LD R1, R1_32
LD R2, R2_32
LD R3, R3_32
LD R4, R4_32
LD R5, R5_32
LD R6, R6_32
LD R7, R7_32

RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_message_1 .STRINGZ "\nINVALID INPUT\n"
Menu_string_addr .FILL x6000
NEWLINE_32		.STRINGZ	"\n"
CONVERT_32		.FILL	#-48
NDEC_55		.FILL	#-55
NDEC_6		.FILL	#6
;NDEC_48		.FILL	#-48

;DATA_BK
R0_32	.BLKW	#1
R1_32	.BLKW	#1	
R2_32		.BLKW	#1
R3_32		.BLKW	#1
R4_32		.BLKW	#1
R5_32		.BLKW	#1
R6_32		.BLKW	#1
R7_32		.BLKW	#1

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
ST R0, R0_34
ST R1, R1_34
ST R2, R2_34
ST R3, R3_34
ST R4, R4_34
ST R5, R5_34
ST R6, R6_34
ST R7, R7_34

AND R2, R2, x0			; THIS IS TO RESET R2

LDI R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY
BRz BUSY_34								;ZZERO IS BUSY AND ONE IS FREE
BR END_SUB34

BUSY_34
ADD R2,R2, #1				;FLAGGIT
BR END_SUB34

END_SUB34


;HINT Restore
LD R0, R0_34
LD R1, R1_34
;LD R2, R2_34
LD R3, R3_34
LD R4, R4_34
LD R5, R5_34
LD R6, R6_34
LD R7, R7_34
RET
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xC000

;DATA BK
R0_34	.BLKW	#1
R1_34	.BLKW	#1	
R2_34		.BLKW	#1
R3_34		.BLKW	#1
R4_34		.BLKW	#1
R5_34		.BLKW	#1
R6_34		.BLKW	#1
R7_34		.BLKW	#1



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
ST R0, R0_36
ST R1, R1_36
ST R2, R2_36
ST R3, R3_36
ST R4, R4_36
ST R5, R5_36
ST R6, R6_36
ST R7, R7_36

AND R2, R2, #0	;RESETS R2 AS THE TARGET FLAG REGISTER

LDI R0, BUSYNESS_ADDR_ALL_MACHINES_FREE
NOT R0, R0
BRz FREE_36
BR ENDSUB_36

FREE_36
ADD R2, R2, #1
BR ENDSUB_36

ENDSUB_36

;HINT Restore
LD R0, R0_36
LD R1, R1_36
;LD R2, R2_36
LD R3, R3_36
LD R4, R4_36
LD R5, R5_36
LD R6, R6_36
LD R7, R7_36
RET
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xC000

;DATA BK
R0_36		.BLKW	#1
R1_36		.BLKW	#1	
R2_36		.BLKW	#1
R3_36		.BLKW	#1
R4_36		.BLKW	#1
R5_36		.BLKW	#1
R6_36		.BLKW	#1
R7_36		.BLKW	#1


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
ST R0, R0_38
ST R1, R1_38
ST R2, R2_38
ST R3, R3_38
ST R4, R4_38
ST R5, R5_38
ST R6, R6_38
ST R7, R7_38
AND R2, R2, #0

LD R3, MACHINES_38


LDI R1, BUSYNESS_ADDR_NUM_BUSY_MACHINES
BRn FREE_38
							;STILL CALCULATES ONLY FREE
COUNT_38
ADD R1, R1, R1				;BITWISSE SHIFT
BRn FREE_38

ADD R3, R3, #-1
BRz END_38
BR COUNT_38

FREE_38
ADD R2, R2, #1

ADD R3, R3, #-1
BRz END_38
BR COUNT_38

END_38
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LD R3, MACHINES_38		;RELOAD #16

NOT R2, R2
ADD R2, R2, #1			;2S COMPLEMENT

ADD R2, R2, R3			;SUBTRACT FROM THE FREE MACHINES TO GET BUSY MACHINES



;HINT Restore
LD R0, R0_38
LD R1, R1_38
;LD R2, R2_38
LD R3, R3_38
LD R4, R4_38
LD R5, R5_38
LD R6, R6_38
LD R7, R7_38
RET
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xC000
MACHINES_38	.FILL	#16
;DATA BK
R0_38		.BLKW	#1
R1_38		.BLKW	#1	
R2_38		.BLKW	#1
R3_38		.BLKW	#1
R4_38		.BLKW	#1
R5_38		.BLKW	#1
R6_38		.BLKW	#1
R7_38		.BLKW	#1


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
ST R0, R0_40
ST R1, R1_40
ST R2, R2_40
ST R3, R3_40
ST R4, R4_40
ST R5, R5_40
ST R6, R6_40
ST R7, R7_40

LD R3, MACH_40
ADD R2, R2, #0
LDI R1, BUSYNESS_ADDR_NUM_FREE_MACHINES

ADD R1, R1, #0
BRn FREE_4K

COUNT_4K
ADD R1, R1, R1
BRn FREE_4K

ADD R3, R3, #-1
BRz END_4K
BR COUNT_4K

FREE_4K
ADD R2, R2, #1

ADD R3, R3, #-1
BRz END_4K
BR COUNT_4K

END_4K

;HINT Restore
LD R0, R0_40
LD R1, R1_40
;LD R2, R2_40
LD R3, R3_40
LD R4, R4_40
LD R5, R5_40
LD R6, R6_40
LD R7, R7_40
RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xC000
MACH_40		.FILL	#16

;DATA BK
R0_40		.BLKW	#1
R1_40		.BLKW	#1	
R2_40		.BLKW	#1
R3_40		.BLKW	#1
R4_40		.BLKW	#1
R5_40		.BLKW	#1
R6_40		.BLKW	#1
R7_40		.BLKW	#1


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
;HINT back up 
; ST R0, R0_42
; ST R1, R1_42
; ST R2, R2_42
; ST R3, R3_42
; ST R4, R4_42
; ST R5, R5_42
; ST R6, R6_42
; ST R7, R7_42
;AND R1, R1, #0

; LD R6, INPUTCALL
; JSRR R6

; LD R3, MACH_42
; NOT R5, R5
; ADD R3, R3, R5
; NOT R5, R5

; LDI R6, BUSYNESS_ADDR_MACHINE_STATUS

; CHECK_COUNT_3
; ADD R3, R3, #0
; BRp FIND_42
; BRnz STATUS_42

; FIND_42
; ADD R6, R6, R6

; ADD R3, R3, #-1
; BRp FIND_42

; STATUS_42
; ADD R6, R6, #0
; BRn FIRST_LOOP2
; BRzp ZERO_42

; FIRST_LOOP2
; ADD R2, R2, #1
; BR END_42

; ZERO_42
; AND R2, R2, #0
; BR END_42

; END_42

 ; LD R6, INPUTCALL
 ; JSRR R6
; LDI R4, BUSYNESS_ADDR_MACHINE_STATUS
; NOT R1, R1
; ADD R1, R1, #1
; LD R2, MACH_42

; ADD R1, R1, R2

; O_LOOP_4400
	; ADD R1, R1, #-1
	; BRnz DFIRST_LOOP400
	; ADD R4, R4, R4
	; JSR O_LOOP_4400

; DFIRST_LOOP400
; ADD R4, R4, #0
; BRn	FIRST_LOOP400
	; AND R2, R2, #0
; BR END_44
	
; FIRST_LOOP400
	; AND R2, R2, #0
	; ADD R2, R2, #1
; BR END_44

; END_44

; AND R2, R2, #0
; LDI R3, BUSYNESS_ADDR_MACHINE_STATUS
; LD R4, MACH_42

; LD R6, INPUTCALL
; JSRR R6

; NOT R5, R5						;2S COMPLEMENT TO SUBTRACT AS COUNTER.
; ADD R5, R5, #1

; ADD R4, R4, R5
; BRz SELECT					; IF ZERO THEN SELECT, IF NOT SHIFT THE BIT TO GET TO NEXT
; BR BIT_SHIFT

; BIT_SHIFT						
; ADD R3, R3, R3				;LEFT SHIFT UNTIL THE NUMBER OF MACHINES REACHES ZERO
; ADD R4, R4, #-1
; BRp BIT_SHIFT

; SELECT
; ADD R4, R4, #0
; BRzp END_42
; BRn FLAG_42

; FLAG_42						;ONLY FLAGS IF THE BIT IS FREE
; ADD R2, R2, #1

; END_42
; NOT R5, R5
; ADD R5, R5, #1
ST R1, R1_42
ST R3, R3_42
ST R4, R4_42
ST R6, R6_42
ST R7, R7_42

AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0

LD R2, GET_INPUT1
JSRR R2

AND R2, R2, #0
LD R3, COUNT_42
ADD R4, R5, #0
NOT R4, R4
ADD R4, R4, #1
ADD R3, R3, R4

LD R6, BUSYNESS_ADDR_MACHINE_STATUS
LDR R1, R6, #0

CHECK_COUNT_3
  ADD R3, R3, #0
  BRp FIND_42
  BRnz STATUS

FIND_42
	ADD R1, R1, R1
	BR COUNTDOWN

COUNTDOWN
  ADD R3, R3, #-1
  BRp CHECK_COUNT_3

STATUS
  ADD R1, R1, #0
  BRn ONE_3
  BRzp ZERO_4

ONE_3
  ADD R2, R2, #1
  BR RETURN_6

ZERO_4
  AND R2, R2, #0

RETURN_6
;HINT Restore
LD R1, R1_42
LD R3, R3_42
LD R4, R4_42
LD R6, R6_42
LD R7, R7_42

RET
;HINT Restore
;LD R0, R0_42
;LD R1, R1_42
;LD R2, R2_42
;LD R3, R3_42
;LD R4, R4_42
;LD R5, R5_42
;LD R6, R6_42
;LD R7, R7_42

;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xC000
INPUTCALL		.FILL	x4600
MACH_42			.FILL	#16
GET_INPUT1    	      .FILL        x4600
COUNT_42        .FILL        #15

;DATA BK
R0_42		.BLKW	#1
R1_42		.BLKW	#1	
R2_42		.BLKW	#1
R3_42		.BLKW	#1
R4_42		.BLKW	#1
R5_42		.BLKW	#1
R6_42		.BLKW	#1
R7_42		.BLKW	#1

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
ST R6, R6_44
ST R7, R7_44

AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0

LD R6, BUSYNESS_ADDR_FIRST_FREE
LDR R1, R6, #0

;LDI R6, BUSYNESS_ADDR_FIRST_FREE

LD R3, DEC_15_44

FIND_44
  ADD R1, R1, #0
  BRn FIRST_CASE
  BRzp SECOND_CASE

FIRST_CASE
  ADD R4, R4, #1
  AND R2, R2, #0
  ADD R2, R2, R3
  ADD R3, R3, #-1
  BR BITSHIFT_44

SECOND_CASE
  ADD R3, R3, #-1

BITSHIFT_44
  ADD R1, R1, R1
  
CHECK_44
  ADD R3, R3, #0
  BRzp FIND_44

;HINT Restore
LD R1, R1_44
LD R3, R3_44
LD R5, R5_44
LD R6, R6_44
LD R7, R7_44

RETURN_7
  RET

;HINT Restore

;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------

; BUSYNESS_ADDR_FIRST_FREE .Fill xC000
; FIRSTFREE3_4400 .STRINGZ "\nNo machines are free\n"
; BUSY_S .FILL x3400
; MASKB_YO .FILL x0001
; COUNTER_4400 .FILL #0
BUSYNESS_ADDR_FIRST_FREE .Fill xC000
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
ST R3, R3_4600
ST R4, R4_4600
;ST R5, R5_4600
ST R6, R6_4600
ST R7, R7_4600

LD R0, NEWLINE
OUT

INTRODUCTION
LEA R0, prompt ;Output Intro Message
PUTS
LD R2, DASH_DEC
LD R3, PLUS_DEC
;LD R6, CONVERT_46
AND R5, R5, #0
BR CZECH


;Example of how to Output Error Message
ERROR
;LD R0, NEWLINE
;OUT
LEA R0, Error_message_2  ;Output Error Message
PUTS
BR INTRODUCTION

ERROR2
LD R0, NEWLINE
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
ADD R1, R1, R3			;ADDS THE PLUS VALUE BACK AND CHECKS that
BRz REINIT			

LD R4, COUNTER
AND R3, R3, #0
;ADD R4, R4, #-1
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
LD R4, COUNTER
AND R3, R3, #0
ADD R3, R3, #1					;NEED TO INDICATE SIGN TO MAKE THINGS HAPPEN
BR LASTCHECK
;BR MORE_INPUT

REINIT							;THIS IS FOR THE POSITIVE CASE TO REINITIALIZE THE COUNTER
LD R4, COUNTER
;BR MORE_INPUT
BR LASTCHECK

MORE_INPUT						;THIS GETS INPUTS 2-5 (OR 6 IF SIGN)
GETC
OUT
BRp INPUT

INPUT								;THIS NEEDS TO BE HERE TO CHECK STUFF
LD R6, CONVERT_46
ADD R1, R0, #0				
ADD R1, R1, #-10			;MAKES ENTER GO TO END (AGAIN)
BRz ENDING
ADD R1, R0, #0				;REINIT THE VALUE TO CHECK SOMETHING ELSE
ADD R1, R1, R6				;THIS IS A CONVERT_46 CHECKER. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!NOT SURE WHY IT DOESNT WORK -48
BRn ERROR
ADD R1, R1, #-9
BRnz FORMULATE
BRp ERROR2

FORMULATE
ADD R1, R1, #9						
AND R6, R6, #0

ADD R6, R5, #0
LD R2, COUNTER2							;COUNTER2 = #9

MULTIPLY								;THIS IS WHERE R5 MAGIC HAPPENS
ADD R5, R5, R6
ADD R2, R2, #-1
BRp MULTIPLY

ADD R5, R5, R1
BR COUNT_CONTROL

COUNT_CONTROL									;COUNTER CONTROL UNIT
ADD R4, R4, #-1						;DECREMENTS THE MAIN COUNTER
BRz ENDING
BRp MORE_INPUT

ENDING
; LD R0, NEWLINE
; OUT										;ENDING OF THE PROGRAM
ADD R3, R3, #-1
BRz R5_STABILIZE
BR ENDING2
R5_STABILIZE			;DOES THE 2S COMPLEMENT IF THE NEGATIVE FLAG WAS EVER THROWN
NOT R5, R5
ADD R5, R5, #1
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

LD R6, ZERO
BRp TWOSC
LOOP_46
ADD R6, R5, #0
BRn ERROR
ADD R6, R5, #-15
BRp ERROR
BR END_46
TWOSC
NOT R5, R5
ADD R5, R5, #1
BR LOOP_46

END_46


LD R1, R1_4600
LD R2, R2_4600
LD R3, R3_4600
LD R4, R4_4600
;LD R5, R5_4600
LD R6, R6_4600
LD R7, R7_4600

RET
;DATA
;PROMPT .STRINGZ "INPUT ANY DECIMAL NUMBER BETWEEN -32768 AND 32767"
;introMessage .FILL x6000
;errorMessage .FILL x6100
NEWLINE			.FILL 	x0A
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
LD R3, PLUSCVT

TEN_THOU
ADD R2, R2, #1
ADD R5, R5, R1
BRzp TEN_THOU

LD R1, TEN_KP
ADD R5, R5, R1
ADD R2, R2, #0
BRz NOT1

ADD R0, R2, R3
OUT

NOT1
LD R1, ONEK
LD R2, COUNTERZERO
LD R3, PLUSCVT

ONE_THOU
ADD R2, R2, #1
ADD R5, R5, R1
BRzp ONE_THOU

LD R1, ONEKP
ADD R5, R5, R1
ADD R2, R2, #0
BRz NOT2

ADD R0, R2, R3
OUT

NOT2
LD R1, HUNDRED
LD R2, COUNTERZERO
LD R3, PLUSCVT

HUNNID
ADD R2, R2, #1
ADD R5, R5, R1
BRzp HUNNID

LD R1, HUND
ADD R5, R5, R1
ADD R2, R2, #0
BRz NOT3

ADD R0, R2, R3
OUT

NOT3

LD R1, TENN
LD R2, COUNTERZERO
LD R3, PLUSCVT

TENS
ADD R2, R2, #1
ADD R5, R5, R1
BRzp TENS

LD R1, TN
ADD R5, R5, R1
ADD R2, R2, #0
BRz NOT4

ADD R0, R2, R3
OUT

NOT4
ADD R0, R5, #0
ADD R0, R0, R3
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

.ORIG xC000			; Remote data
BUSYNESS .FILL xABCD		; <----!!!VALUE FOR BUSYNESS VECTOR!!!

;---------------	
;END of PROGRAM
;---------------	
.END
