; helper1.s
; Version 1.2
; https://github.com/richardcavell/6809-strlen
;
; A 6809 assembly routine to help with the testing of strlen.s
;
; Written by Richard John Foster Cavell (c) 2017.
; Licensed to you under the MIT License.
;
; This routine is designed to be used with Disk Extended Color BASIC.
;
; Inputs:
;   A 16 bit integer which equals either:
;          0 (use strlen), or
;          1 (use no_error_strlen)
;
; Outputs:
;   Length of the string (0 to 0xffff)
;
; This routine adheres to the Disk Extended Color BASIC USRx()
; calling conventions.
;
; For this routine to work correctly, the strlen routine must be loaded to
; memory location $3000 and the no_error_strlen routine must be loaded to
; memory location $3080.
;
; This code may be placed anywhere in memory, so it is position-independent.
; It is re-entrant. But the memory locations $3000, $3080 and $3200 are
; hard-coded below. Interrupts are allowed to occur during execution.
;
; It uses 2 bytes of the System stack, in addition to the 2 bytes used
; for the return address.
;
; Issues:
; If memory location $3000 is not the start of the strlen routine, the
;   behaviour is undefined.
; If memory location $3080 is not the start of no_error_strlen routine, the
;   behaviour is undefined.
; If memory location $3200 is not the start of a valid string, the
;   behaviour is undefined.
;   If there is no terminating null byte, the code might access forbidden
;     areas of the memory map.
;   It is possible for X to wrap (from $FFFF to $0000). Only the regular
;     strlen routine detects this possibility (and returns $FFFF).

  ORG $3100   ; Change all the locations if you have <16K RAM

STRLEN   EQU $3000                 ; This must be loaded here first
NESTRLEN EQU $3080                 ; This also must be loaded here first
STRING   EQU $3200                 ; This is where our string is located
INTCNV   EQU $B3ED                 ; Get the parameter from BASIC
GIVABF   EQU $B4F4                 ; Give the result to BASIC

_helper1
_helper1_start
_helper1_entry

  JSR INTCNV      ; Get the parameter from BASIC
  LDX #STRING     ; Load the address of the string into X
  SUBD #0
  BNE _helper1_use_no_error_strlen

_helper1_use_strlen

  JSR STRLEN      ; Execute strlen -> result will be in D
  JMP GIVABF      ; Return the result in D to BASIC

_helper1_use_no_error_strlen

  JSR NESTRLEN    ; Execute no_error_strlen -> result will be in D
  JMP GIVABF      ; Return the result in D to BASIC

_helper1_end
