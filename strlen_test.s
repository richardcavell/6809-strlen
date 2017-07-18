; strlen_test.s
; Version 1.0
;
; A 6809 assembly routine to help with the testing of strlen.s
;
; Written by Richard John Foster Cavell (c) 2017.
; Licensed to you under the MIT License.
;
; Inputs:
; Memory location $2FFE (2 bytes) = Pointer to the string.
;
; Outputs:
; Memory location $2FFE (2 bytes) = Length of the string.
;
; Issues:
; If ($2FFE) does not point to a valid string, the behaviour is undefined.
;   If there is no terminating null byte, the code might access forbidden
;     areas of the memory map.
;   It is possible for X to wrap (say from $FFFF to $0000). This code makes
;     no attempt to detect this possibility, because the behaviour may be
;     desirable.

  ORG $3100   ; Change this if you have a 4K Coco

_strlen_test

  LDX $2FFE   ; Pull the pointer from memory into register X
  JSR [$2FFC] ; Execute strlen
  STD $2FFE   ; Store the result in memory

  RTS         ; Return to BASIC

_strlen_test_end
