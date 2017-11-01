; main1.s
; Version 1.2 (1 November 2017)
; https://github.com/richardcavell/6809-strlen
;
; A very short file to assist in assembling strlen.s for the test suite
;
; Written by Richard John Foster Cavell (c) 2017.
; Licensed to you under the MIT License.

    INCLUDE "Symbols.inc"

    ORG  STRLEN

_start
_main1

    INCLUDE "../strlen.s"

_end

    IF    (_end > STRLEN_LIMIT)
    ERROR "Strlen object code does not fit into the space allocated"
    ENDIF

    END
