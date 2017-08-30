; main1.s
; Version 1.1 (24 August 2017)
; https://github.com/richardcavell/6809-strlen
;
; A very short file to assist in assembling strlen.s for the test suite
;
; Written by Richard John Foster Cavell (c) 2017.
; Licensed to you under the MIT License.

  ORG $3000                 ; Change this if you have <16K RAM

_main1
_start

  INCLUDE "../strlen.s"

_end
  END
