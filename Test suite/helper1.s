; helper1.s
; Version 1.3
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
;   Length of the string (0 to 0xFFFF)
;   OR 0xFFFF if no_error_strlen is used and there was a "no end" error
;
; This routine adheres to the Disk Extended Color BASIC USRx()
; calling conventions.
;
; For this routine to work correctly, the strlen routine must be loaded to
; memory location STRLEN and the no_error_strlen routine must be loaded to
; memory location NESTRLEN.
;
; If there is a valid string starting at location STRING, its length will
; be returned. If there is no valid string there, it is possible for the
; CPU to read disallowed areas of the memory map, or for a "no end" error
; to occur.
;
; This code may be placed anywhere in memory, so it is position-independent.
; It is re-entrant. Interrupts are allowed to occur during execution.
;
; The System stack must have enough room to accommodate the calls to the
; BASIC interpreter, and the strlen/no_error_strlen routine.
;
; Issues:
; If memory location STRLEN is not the start of the strlen routine, the
;   behaviour is undefined.
; If memory location NESTRLEN is not the start of no_error_strlen routine,
;   the behaviour is undefined.
; If memory location STRING is not the start of a valid string, the
;   behaviour is undefined.
;   If there is no terminating null byte, the code might access forbidden
;     areas of the memory map.
;   It is possible for X to wrap (from $FFFF to $0000). Only the regular
;     strlen routine detects this possibility (and returns 0xFFFF).

    INCLUDE "Symbols.inc"

    ORG HELPER1

_helper1
_helper1_start
_helper1_entry

    JSR INTCNV        ; Get the parameter from BASIC
    LDX #STRING       ; Load the address of the string into X
    SUBD #USE_STRLEN  ; Does D equal USE_STRLEN or not?
    BNE _helper1_use_no_error_strlen  ; If not, then use the no_error version

_helper1_use_strlen

    JSR STRLEN        ; Execute strlen -> result will be in D
    JMP GIVABF        ; Return the result in D to BASIC

_helper1_use_no_error_strlen

    JSR NESTRLEN      ; Execute no_error_strlen -> result will be in D
    JMP GIVABF        ; Return the result in D to BASIC

_helper1_end

    IF    (_helper1_end > HELPER1_LIMIT)
    ERROR "Helper1 object code does not fit into the space allocated"
    ENDIF

    END
