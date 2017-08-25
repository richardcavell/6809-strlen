; main.s
; Version 1.1 (24 August 2017)
; https://github.com/richardcavell/6809-strlen
;
; A very short file to assist in assembling strlen.s
;
; Written by Richard John Foster Cavell (c) 2017.
; Licensed to you under the MIT License.
;
; If you are quite sure that the strings presented to the routine are valid
; and will never wrap, change the next line to equal 1

GUARANTEED_NO_ERROR EQU 0

  ORG $3000                 ; Change this if you have <16K RAM

_main
_start

  IF (GUARANTEED_NO_ERROR==0)
  INCLUDE "../strlen.s"
  ELSE
  INCLUDE "../no_error_strlen.s"
  ENDIF

_end
  END
