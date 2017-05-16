;=================================================
; Name: Justin Liu
; Email:  jliu076@ucr.edu
; 
; Lab: lab 7
; Lab section: 22
; TA: Amir
;=================================================
.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

LD R0, introMessage
PUTS

LD R6, COUNT

VALIDATION

  LD R2, COUNT_2
  LD R3, NEGATIVE

  DO_WHILE_LOOP
      GETC
      OUT

      ADD R4, R0, #0
      ADD R4, R4, #-10
      BRz VALI
  END_DO_WHILE_LOOP

  NEGATIVE_DO_WHILE_LOOP
    ADD R4, R0, #0
    ADD R4, R4, R3

    BRz CHECK_SIGN
    BRnp POSITIVE_DO_WHILE_LOOP
  END_NEGATIVE_DO_WHILE_LOOP

  POSITIVE_DO_WHILE_LOOP
    LD R3, POSITIVE

    AND R4, R4, #0
    ADD R4, R0, #0
    ADD R4, R4, R3
    
    BRz VALIDATION
    BRnp NUMBER_DO_WHILE_LOOP
  END_POSITIVE_DO_WHILE_LOOP

    CHECK_SIGN
      AND R1, R1, #0
      ADD R1, R1, #-1
    
    BRn VALIDATION
    END_CHECK_SIGN

  NUMBER_DO_WHILE_LOOP
    LD R3, NUM_VAL

    AND R4, R4, #0
    ADD R4, R0, #0
    ADD R4, R4, R3

    BRp NOT_VALID_2
    BRnz THE_CONVERTER
  END_NUMBER_DO_WHILE_LOOP

  VALI
    ADD R6, R6, #-1

    BRn NOT_VALID
    BRzp END_THE_LOOP
  END_VALI

  NOT_VALID
    LD R0, errorMessage
    PUTS
    LD R0, introMessage
    PUTS

    AND R1, R1, #0
    AND R5, R5, #0
    ADD R3, R3, #0

    BRn VALIDATION
  END_NOT_VALID

  NOT_VALID_2
    LEA R0, START_LINE
    PUTS
    LD R0, errorMessage
    PUTS
    LD R0, introMessage
    PUTS
    AND R1, R1, #0
    AND R5, R5, #0
    ADD R3, R3, #0
    
    BRn VALIDATION
  END_NOT_VALID_2



  STR_O
    LD R3, LIMIT
    ADD R6, R6, #1
    ADD R3, R3, R6
    
    BRzp SIGN_VALIDATION_CHECK
    BRn VALIDATION
  END_STR_O


  END_THE_LOOP
    LD R3, LIMIT
    ADD R3, R3, R0

    BRzp SIGN_VALIDATION_CHECK
  END_END_THE_LOOP

  AND R5, R5, #0

  THE_CONVERTER
    ADD R4, R4, #9
    ADD R3, R5, #0
  END_THE_CONVERTER

  MULTI_CONV
    ADD R5, R5, R3
    ADD R2, R2, #-1

    BRp MULTI_CONV
  END_MULTI_CONV

  ADD R5, R5, R4
  BR STR_O

  SIGN_VALIDATION_CHECK
    AND R3, R3, #0
    ADD R3, R1, #0
    ADD R3, R3, #0

    BRzp END_IT
    BRn FLIP_THE_SIGN
   END_SIGN_VALIDATION_CHECK


  FLIP_THE_SIGN
    NOT R5, R5
    ADD R5, R5, #1

    BR END_IT
   END_FLIP_THE_SIGN


END_IT
  LEA R0, START_LINE
  PUTS
  HALT



;---------------	
;Data
;---------------
NEGATIVE    .FILL #-45
POSITIVE    .FILL #-43
NUM_VAL     .FILL #-57
LIMIT       .FILL #-5
COUNT .FILL #0
COUNT_2 .FILL #9
START_LINE .STRINGZ "\n"


introMessage .FILL x6000
errorMessage .FILL x6100



	
;------------
;Remote data
;------------
.ORIG x6000
;---------------
;messages
;---------------
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
;---------------
;error_messages
;---------------
.ORIG x6100	
error_mes .STRINGZ	"ERROR INVALID INPUT\n"

;---------------
;END of PROGRAM
;---------------
.END
;-------------------
;PURPOSE of PROGRAM
;-------------------
