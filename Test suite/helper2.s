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
; At the memory location pointed to by [$317E], a string of length
; given in [$317C], null-terminated.
;
; This code may be placed anywhere in memory, so it is position-independent.
; It is re-entrant.
; But the memory locations $317C and $317E are hard-coded below.
;
; Issues:
; This code must be assembled with an assembler that substitutes ASCII
;  codes for the characters given in the code.
; If you don't choose the inputs wisely, this routine can write over the top
;  of memory that you don't want it to.
; It is possible for the string to wrap (say from $FFFF to $0000).
;  This code makes no attempt to detect this possibility, because the
;  behaviour may be desirable.

  ORG $3180   ; Change all the locations if you have <16K RAM

_helper2
_helper2_start

_helper2_entry

  LDX $317E               ; Start of the string
  LDY $317C               ; Length of the string
  BEQ _terminate_string   ; If length == 0

  LDA #'A'                ; The string will consist of this character

_copy_loop
  STA ,X+                 ; Store the character and increment X

  CMPA _Z,PCR             ; Have we reached the letter Z?
  BEQ _start_digits       ; Yes, start with the digits

  CMPA _nine,PCR          ; Have we reached the digit 9?
  BEQ  _start_alphabet    ; Yes, start with the alphabet

  INCA                    ; Alter the character that we're storing

_count_and_loop
  LEAY -1,Y               ; Y is our counter
  BNE _copy_loop          ; If more chars are needed, loop

_terminate_string
  CLR ,X                  ; Add the terminating zero
  RTS                     ; Return to BASIC


; Subroutines

_start_digits
  LDA #'0'                ; Start with the digits
  BRA _count_and_loop

_start_alphabet
  LDA #'A'                ; Start with the alphabet (again)
  BRA _count_and_loop

; Data

_Z
  FCB 'Z'

_nine
  FCB '9'

_helper2_end
