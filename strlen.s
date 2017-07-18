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
; Issues:
; If X does not point to a valid string, the behaviour is undefined.
;   If there is no terminating null byte, the code might access forbidden
;     areas of the memory map.
;   It is possible for X to wrap (say from $FFFF to $0000). This code makes
;     no attempt to detect this possibility, because the behaviour may be
;     desirable.

  ORG $3000                 ; Change this if you have a 4K Coco

_strlen_start

  STX ,--S                  ; Remember what the start value was

_strlen_loop

  TST ,X+                   ; Is X pointing to the terminating zero?
  BNE _strlen_loop          ; If no -> get ready to test the next byte

  LEAX -1,X                 ; We went one byte too far
  TFR X,D                   ; Calculate the length using pointer arithmetic
  SUBD ,S                   ; Result is in D
  LDX ,S++                  ; Restore X. The stack is left in a correct state
  RTS

_strlen_loop_end
