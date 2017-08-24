; helper1.s
; Version 1.1
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
;   Pointer to the string (0 to 64k)
;
; Outputs:
;   Length of the string (0 to 64k)
;
; This routine adheres to the Disk Extended Color BASIC USRx()
; calling conventions.
;
; For this routine to work correctly, the strlen routine must be loaded to
; memory location $3000.
;
; This code may be placed anywhere in memory, so it is position-independent.
; It is re-entrant. But the memory location $3000 is hard-coded below.
; Interrupts are allowed to occur during execution.
;
; It uses 2 bytes of the System stack, in addition to the 2 bytes used
; for the return address.
;
; Issues:
; If memory location $3000 does not point to the strlen routine, the
;   behaviour is undefined.
; If the value passed from BASIC does not point to a valid string, the
;   behaviour is undefined.
;   If there is no terminating null byte, the code might access forbidden
;     areas of the memory map.
;   It is possible for X to wrap (say from $FFFF to $0000). This code makes
;     no attempt to detect this possibility, because the behaviour may be
;     desirable.

  ORG $3100   ; Change all the locations if you have <16K RAM

STRLEN EQU $3000                 ; This must be loaded here first
INTCNV EQU $B3ED                 ; Get the parameter from BASIC
GIVABF EQU $B4F4                 ; Give the result to BASIC

_helper1
_helper1_start
_helper1_entry

  JSR INTCNV      ; Get the pointer to the string
  TFR D,X         ; Transfer the pointer into register X
  JSR STRLEN      ; Execute strlen, result will be in D
  JMP GIVABF      ; Return the result in D to BASIC

_helper1_end
