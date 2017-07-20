; strlen.s
; Version 1.0
;
; A 6809 assembly routine to find the length of a C-style string.
;
; Written by Richard John Foster Cavell (c) 2017.
; Licensed to you under the MIT License.
;
; Inputs:
; X = Pointer to the string.
;
; Outputs:
; D = Length of the string.
;
; All other registers, including X, are preserved.
;
; The code is position-independent, re-entrant, and interrupts are allowed
; to occur during execution.
;
; Issues:
; If X does not point to a valid string, the behaviour is undefined.
;   If there is no terminating null byte, the code might access forbidden
;     areas of the memory map.
;   It is possible for X to wrap (say from $FFFF to $0000). This code makes
;     no attempt to detect this possibility, because the behaviour may be
;     desirable.

  ORG $3000                 ; Change this if you have <16K RAM

_strlen
_strlen_start

  PSHS X                    ; Remember what the start value was

_strlen_loop

  LDA ,X+                   ; Is X pointing to the terminating zero?
  BNE _strlen_loop          ; If no -> test the next byte

_strlen_loop_end

  LEAX -1,X                 ; X was incremented one byte too far
  TFR X,D                   ; Get ready for pointer arithmetic
  SUBD ,S                   ; Calculate the length (result is in D)
  PULS X                    ; Restore X. The stack is left in a correct state
  RTS

_strlen_end
