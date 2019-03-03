; helper1.s
; Version 1.6
; https://github.com/richardcavell/6809-strlen
;
; A 6809 assembly routine to help with the testing of strlen.s
;
; Written by Richard John Foster Cavell (c) 2017, 2018, 2019.
; Licensed to you under the MIT License.
;
; This routine is designed to be used with Disk Extended Color BASIC.
;
; Inputs:
;   A 16 bit integer. The low byte equals either:
;          0 (use strlen), or
;          1 (use no_error_strlen)
;
;   The high byte equals one of:
;          0 (normal operation)
;          1 (simulate off-by-1 error)
;          2 (simulate no-end error)
;
; Outputs:
;   Length of the string (0 to $FFFF)
;   OR $FFFF if no_error_strlen is used and there was a "no end" error
;   OR if an error simulation is requested, an incorrect result
;
; This routine adheres to the Disk Extended Color BASIC USRx()
; calling conventions.
;
; For this routine to work correctly, the strlen routine must be loaded to
; memory location STRLEN and the no_error_strlen routine must be loaded to
; memory location NESTRLEN. (As defined in Symbols.inc)
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
; If memory location NESTRLEN is not the start of the no_error_strlen routine,
;   the behaviour is undefined.
; If memory location STRING is not the start of a valid string, the
;   behaviour is undefined.
;   If there is no terminating null byte, the code might access forbidden
;     areas of the memory map.
;   It is possible for X to wrap (from $FFFF to $0000). Only the regular
;     strlen routine detects this possibility (and returns $FFFF).

    INCLUDE "Symbols.inc"

    ORG HELPER1

_helper1
_helper1_start
_helper1_entry

    JSR  INTCNV            ; Get the parameter from BASIC
    PSHS A                 ; Save the error request byte
    LDX  #STRING           ; Load the address of the string into X
    SUBB #USE_STRLEN       ; Does the low byte equal USE_STRLEN or not?
    BNE  _helper1_use_no_error_strlen  ; If not, then use the no_error version

_helper1_use_strlen

    JSR  STRLEN            ; Execute strlen -> result will be in D
    BRA  _helper1_error_simulation     ; Jump over the next instruction

_helper1_use_no_error_strlen

    JSR NESTRLEN           ; Execute no_error_strlen -> result will be in D

_helper1_error_simulation

    PSHS D                 ; Save our result on the S stack
    LDA  2,S               ; Restore the error request byte into A
    BEQ _helper1_normal_operation  ; If no error is requested
    SUBA #ERROR_OFFBY1     ; Is off-by-one error requested?
    BEQ _helper1_offby1    ; Yes, so do that

_helper1_noend

    LEAS 2,S               ; Jump over the saved result, and ignore it
    LDD  #$FFFF            ; Indicate no-end error
    BRA _helper1_finalise

_helper1_offby1

    PULS D                 ; Restore the correct result in D
    ADDD #1                ; Now add 1 to it
    BRA  _helper1_finalise ; Now finalize

_helper1_normal_operation

    PULS D                 ; Restore the correct result in D

_helper1_finalise

    LEAS 1,S               ; Jump over that saved error request byte
    JMP  GIVABF            ; Return the result in D to BASIC

_helper1_end

    IF    (_helper1_end > HELPER1_LIMIT)
    ERROR "Helper1 object code does not fit into the space allocated"
    ENDIF

    EXPORT _helper1
    EXPORT _helper1_start
    EXPORT _helper1_entry
    EXPORT _helper1_end

helper1_length EQU (_helper1_end - _helper1_start)

    EXPORT helper1_length

    END
