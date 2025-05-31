; strlen.s
; Version 1.8 (31 May 2025)
; https://github.com/richardcavell/6809-strlen
;
; A 6809 assembly language routine to find the length of a C-style string.
;
; Written by Richard John Foster Cavell (c) 2017, 2018, 2019, 2025.
; Licensed to you under the MIT License.
;
; ($FFFF means hexadecimal FFFF)
;
; Inputs:
;
;   register X = (unsigned 16-bit) pointer to the string.
;
; Outputs:
;
;   register D = (unsigned 16-bit) length of the string.
;                (A value of $FFFF means there was a "no end" error)
;
;   All other registers, including X, are preserved.
;
; A C-style string, for the purposes of this routine, is a sequence of
; non-zero 8-bit bytes, followed by a zero byte. The sequence may have
; zero length, in which case there is just a zero byte.
;
; This code is position-independent and re-entrant. Interrupts are allowed
; to occur during execution. The code uses 2 bytes of the S stack, in addition
; to the 2 bytes used for the return PC value when calling this routine.
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
; You can write your own error handler for this, below. Insert the relevant
; code under the label "_strlen_no_end_error_handler".
;
; Issues:
;
; If X does not point to a valid string, the behaviour is undefined.
;
;   If there is no terminating null byte, the code might access forbidden
;     areas of the memory map.
;
; This is designed to assemble correctly with asm6809 by Ciaran Anscomb.

    CODE

_strlen
_strlen_start
_strlen_entry

    PSHS X                     ; Remember the start of the string

_strlen_loop

    LDA  ,X                    ; Is X pointing to the terminating zero?
    BEQ  _strlen_normal_finish ; If Yes -> calculate the length

    LEAX 1,X                   ; Has X wrapped around to $0000?
    BNE  _strlen_loop          ; If No -> loop again

_strlen_loop_end

_strlen_no_end_error_handler
                               ; A "no end" error has occurred

                               ; You can write your own error handling code
                               ; in here

    LDD  #0xFFFF               ; Return error
    PULS X,PC                  ; Honour our calling convention

_strlen_normal_finish

    TFR  X,D                   ; Get ready for pointer arithmetic
    SUBD ,S                    ; Calculate the length (result is in D)
    PULS X,PC                  ; Restore X and return
                               ; The stack is left in a correct state

_strlen_end

; Symbols that represent addresses

    EXPORT _strlen
    EXPORT _strlen_start
    EXPORT _strlen_entry
    EXPORT _strlen_end

; A symbol that represents the size of this code

strlen_length EQU (_strlen_end - _strlen_start)

    EXPORT strlen_length
