; Symbols.inc
; by Richard John Foster Cavell (c) 2017, 2018, 2019
; https://github.com/richardcavell/6809-strlen

; This is the base pointer for our 4K RAM area, where the machine
; language routines and the constructed strings go
;
; If you have less than 32K RAM, you need to re-work the memory map

USER_ML_AREA    EQU $6000

; DECB routines

INTCNV          EQU $B3ED       ; Get the parameter from BASIC
GIVABF          EQU $B4F4       ; Give the result to BASIC

; Symbols for calling helper1

USE_STRLEN      EQU  0
USE_NESTRLEN    EQU  1

ERROR_OFFBY1    EQU  1
ERROR_NOEND     EQU  2

; User-supplied routines
;
;   main1.s (strlen) machine language object code

STRLEN          EQU  (USER_ML_AREA + 0)    ; Is also the entry point
STRLEN_LIMIT    EQU  (USER_ML_AREA + $7F)

;   main2.s (no_error_strlen) machine language object code

NESTRLEN        EQU  (USER_ML_AREA + $80)  ; Is also the entry point
NESTRLEN_LIMIT  EQU  (USER_ML_AREA + $FF)

;      helper1 machine language object code

HELPER1         EQU  (USER_ML_AREA + $100) ; Is also the entry point
                                           ; (This is USR1 in TEST.BAS)
HELPER1_LIMIT   EQU  (USER_ML_AREA + $17F)

;      helper2 machine language object code

HELPER2         EQU  (USER_ML_AREA + $180) ; Is also the entry point
                                           ; (This is USR2 in TEST.BAS)
HELPER2_LIMIT   EQU  (USER_ML_AREA + $1FF)

;      The string to be tested is placed here either by:
;        the TEST.BAS program, which is written in BASIC,
;        or the helper2 program, which is written in assembly

STRING          EQU  (USER_ML_AREA +$200)  ; (This is PS in TEST.BAS)
STRING_LIMIT    EQU  (USER_ML_AREA +$FFF)
