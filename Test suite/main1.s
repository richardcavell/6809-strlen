; main1.s
; Version 1.7 (30 March 2019)
; https://github.com/richardcavell/6809-strlen
;
; A very short file to assist in assembling strlen.s for the test suite.
;
; Written by Richard John Foster Cavell (c) 2017, 2018, 2019.
; Licensed to you under the MIT License.
;
; This is designed to assemble correctly with asm6809 by Ciaran Anscomb.

    INCLUDE "Symbols.inc"

    ORG  STRLEN

_start
_main1

    INCLUDE "../strlen.s"

_end

    IF    (_end > STRLEN_LIMIT)
    ERROR "Strlen object code does not fit into the space allocated"
    ENDIF

    EXPORT _start
    EXPORT _main1
    EXPORT _end

    END
