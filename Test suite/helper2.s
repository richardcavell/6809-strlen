; helper2.s
; Version 1.0
;
; A 6809 assembly routine to help with the testing of strlen.s
;
; Written by Richard John Foster Cavell (c) 2017.
; Licensed to you under the MIT License.
;
; Inputs:
; Memory location $317C (2 bytes) = The length of a string to be constructed.
; Memory location $317E (2 bytes) = Pointer to where the string should start.
;
; Outputs:
; None.
;
; This code may be placed anywhere in memory, so it is position-independent.
; It is re-entrant.
; But the memory locations $317C and $317E are hard-coded below.
;
; Issues:
; If you don't choose the inputs wisely, this routine can write over the top
;  of memory that you don't want it to.
; It is possible for the string to wrap (say from $FFFF to $0000).
;  This code makes no attempt to detect this possibility, because the
;  behaviour may be desirable.

  ORG $3180   ; Change all the locations if you have <16K RAM

_helper2
_helper2_start

  LDX $317E               ; Start of the string
  LDY $317C               ; Length of the string
  BEQ _terminate_string   ; If length == 0

  LDA #'A'                ; The string will consist of this character

_copy_loop
  STA ,X+                 ; Store the character and increment X

  LEAY -1,Y               ; Y is our counter
  BNE _copy_loop          ; If more chars are needed, loop

_terminate_string
  CLR ,X                  ; Add the terminating zero
  RTS                     ; Return to BASIC

_helper2_end
