; main.s
; Version 1.1 (24 August 2017)
; https://github.com/richardcavell/6809-strlen
;
; A very short file to assist in assembling strlen.s
;
; Written by Richard John Foster Cavell (c) 2017.
; Licensed to you under the MIT License.
;
; If you are quite sure that the strings presented to strlen.s are valid
; and will never wrap, you can delete the first INCLUDE and use the second.

  ORG $3000                 ; Change this if you have <16K RAM

_main
_start

  INCLUDE "strlen.s"
; INCLUDE "no_error_strlen.s"

_end
  END
