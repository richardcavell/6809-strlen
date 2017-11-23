; strlen.s
; Version 1.3 (23 November 2017)
; https://github.com/richardcavell/6809-strlen
;
; A 6809 assembly language routine to find the length of a C-style string.
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
;   (A value of 0xFFFF means there was a "no end" error)
;
;   All other registers, including X, are preserved.
;
; A C-style string, for the purposes of this routine, is a sequence of
; non-zero 8-bit bytes, followed by a zero byte. The sequence may have
; zero length.
;
; This code is position-independent and re-entrant. Interrupts are allowed
; to occur during execution. The code uses 2 bytes of the S stack, in
; addition to the 2 bytes used for the return PC value when calling this
; routine.
;
; This routine assembles to 21 bytes of object code using asm6809.
;
; There is a no_error_strlen.s version of this code, which does not detect
; the "no end" condition.
;
; Errors:
;
; A "no end" error occurs when the string appears to continue past memory
; location $FFFF.
;
; You can write your own error handler for this, below.
;
; Issues:
; If X does not point to a valid string, the behaviour is undefined.
;   If there is no terminating null byte, the code might access forbidden
;     areas of the memory map.

    CODE

_strlen
_strlen_start
_strlen_entry

    PSHS X                     ; Remember the start of the string

_strlen_loop

    LDA  ,X                    ; Is X pointing to the terminating zero?
    BEQ  _strlen_calc_length   ; If Yes -> calculate the length

    LEAX 1,X                   ; Has X wrapped around to $0000?
    BNE  _strlen_loop          ; If No -> loop again

_strlen_loop_end

                               ; A "no end" error has occurred

                               ; You can write your own error handling code
                               ; in here

    LDD  #0xFFFF               ; Return error
    PULS X,PC                  ; Honour our calling convention

_strlen_calc_length

    TFR  X,D                   ; Get ready for pointer arithmetic
    SUBD ,S                    ; Calculate the length (result is in D)
    PULS X,PC                  ; Restore X and return
                               ; The stack is left in a correct state

_strlen_end

strlen_length EQU (_strlen_end - _strlen_start)

    EXPORT _strlen
    EXPORT _strlen_start
    EXPORT _strlen_entry
    EXPORT _strlen_end

    EXPORT strlen_length
