; main.s
; Version 1.0 (18 August 2017)
; https://github.com/richardcavell/6809-strlen
;
; A very short file to assist in assembling strlen.s
;
; Written by Richard John Foster Cavell (c) 2017.
; Licensed to you under the MIT License.
;

  ORG $3000                 ; Change this if you have <16K RAM

_main

  INCLUDE "strlen.s"

_end
  END
