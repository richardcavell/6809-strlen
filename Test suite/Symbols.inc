; Symbols.inc
; by Richard John Foster Cavell (c) 2017
; https://github.com/richardcavell/6809-strlen

; DECB routines

INTCNV          EQU $B3ED       ; Get the parameter from BASIC
GIVABF          EQU $B4F4       ; Give the result to BASIC

; Symbols for calling helper1

USE_STRLEN      EQU  0
USE_NESTRLEN    EQU  1

; User-supplied routines
;
;   If you have less than 16K RAM, you need to re-work the memory map
;   and change these values

;   main1.s (strlen) machine language object code

STRLEN          EQU  $3000      ; Is also the entry point
STRLEN_LIMIT    EQU  $307F

;   main2.s (no_error_strlen) machine language object code

NESTRLEN        EQU  $3080      ; Is also the entry point
NESTRLEN_LIMIT  EQU  $30FF

;      helper1 machine language object code

HELPER1         EQU  $3100      ; Is also the entry point
                                ; (This is USR1 in TEST.BAS)
HELPER1_LIMIT   EQU  $317F

;      helper2 machine language object code

HELPER2         EQU  $3180      ; Is also the entry point
                                ; (This is USR2 in TEST.BAS)
HELPER2_LIMIT   EQU  $31FF

;      The string to be tested is placed here either by:
;        the TEST.BAS program, which is written in BASIC,
;        or the helper2 program, which is written in assembly

STRING          EQU  $3200      ; (This is PS in TEST.BAS)
STRING_LIMIT    EQU  $3FFF
