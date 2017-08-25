; strlen.s
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
;   (A value of 0xFFFF means there was a "no end" error)
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
; The routine assembles to 26 bytes of object code using asm6809.
;
; Errors:
;
; A "no end" error occurs when the string appears to continue past memory
; location $FFFF
;
; You can write your own error handler for this, below.
;
; Issues:
; If X does not point to a valid string, the behaviour is undefined.
;   If there is no terminating null byte, the code might access forbidden
;     areas of the memory map.

_strlen
_strlen_start
_strlen_entry

  PSHS X                    ; Remember the start of the string

_strlen_loop

  LDA ,X+                   ; Is X pointing to the terminating zero?
  BEQ _strlen_calc_length   ; If Yes-> calculate the length

  LEAX ,X                   ; Has X wrapped around to $0000?
  BNE  _strlen_loop         ; If No -> loop again

_strlen_loop_end

  BRA _strlen_error_no_end  ; Handle the error

_strlen_calc_length

  TFR X,D                   ; Get ready for pointer arithmetic
  SUBD #1                   ; X went one byte too far
  SUBD ,S                   ; Calculate the length (result is in D)
  PULS X,PC                 ; Restore X and return
                            ; The stack is left in a correct state

_strlen_error_no_end

                            ; You can write your own error handling code
                            ; in here

  LDD  #0xFFFF              ; Return maximum length
  PULS X,PC                 ; Honour our calling convention

_strlen_end
