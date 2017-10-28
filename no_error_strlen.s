; no_error_strlen.s
; Version 1.1 (24 August 2017)
; https://github.com/richardcavell/6809-strlen
;
; A 6809 assembly routine to find the length of a C-style string.
;
; Written by Richard John Foster Cavell (c) 2017.
; Licensed to you under the MIT License.
;
; Inputs:
;
;   X = Pointer to the string.
;
; Outputs:
;
;   D = Length of the string.
;
;   All other registers, including X, are preserved.
;
; A C-style string, for the purposes of this routine, is a sequence of
; non-zero 8-bit bytes, followed by a zero byte. The sequence may have
; zero length.
;
; The code is position-independent and re-entrant. Interrupts are allowed
; to occur during execution. It uses 2 bytes of the S stack, in addition
; to the 2 bytes used for the return PC value when calling this routine.
;
; The routine assembles to 15 bytes (0xF bytes) of object code using asm6809.
;
; There is another version of this routine which detects the situation that
; exists when the routine reaches location 0xFFFF without encountering
; the end of string.
;
; Issues:
; If X does not point to a valid string, the behaviour is undefined.
;   If there is no terminating null byte, the code might access forbidden
;     areas of the memory map.
;   It is possible for X to wrap (say from $FFFF to $0000). This code makes
;     no attempt to detect this possibility. You should only use this code
;     if you can be certain that the string given to the routine is valid and
;     will never wrap.

    CODE

_no_error_strlen
_no_error_strlen_start
_no_error_strlen_entry

    PSHS X                      ; Remember the start of the string

_no_error_strlen_loop

    LDA  ,X+                    ; Is X pointing to the terminating zero?
    BNE  _no_error_strlen_loop  ; If no -> test the next byte

_no_error_strlen_loop_end

    TFR  X,D                    ; Get ready for pointer arithmetic
    SUBD #1                     ; X went one byte too far
    SUBD ,S                     ; Calculate the length (result is in D)
    PULS X,PC                   ; Restore X and return
                                ; The stack is left in a correct state
_no_error_strlen_end

_no_error_strlen_length EQU (_no_error_strlen_end - _no_error_strlen_start)

    EXPORT _no_error_strlen
    EXPORT _no_error_strlen_start
    EXPORT _no_error_strlen_entry
    EXPORT _no_error_strlen_end
    EXPORT _no_error_strlen_length
