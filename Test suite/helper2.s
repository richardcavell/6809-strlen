; helper2.s
; Version 1.5
; https://github.com/richardcavell/6809-strlen
;
; A 6809 assembly routine to help with the testing of strlen.s
;
; Written by Richard John Foster Cavell (c) 2017, 2018.
; Licensed to you under the MIT License.
;
; Inputs:
;   Length of the string (0 to $FFFF)
;
; Outputs:
;   Nothing meaningful is passed back.
;   Beginning at the memory location STRING, a string of the length
;     requested, null-terminated, is created.
;
; The DECB calling conventions are honoured.
;
; 3 bytes of the System stack are used, in addition to the 2 used
; for the return address.
;
; This code may be placed anywhere in memory, so it is position-independent.
; It is re-entrant.  Interrupts are allowed to occur during execution.
; This routine assumes that your assembler uses the same character codes
; as the Color Computer. (Which overlaps with ASCII for all the characters
; produced by this routine).
;
; This routine could be made to run faster, but clarity is the goal here.
;
; Issues:
; This code must be assembled with an assembler that substitutes ASCII
;  codes for the characters given in the code.
; This routine can write into memory locations that have no RAM (in a
;  machine with less than 64K installed RAM).
; This routine can write into memory that you don't want it to.
; It is possible for the string to wrap (say from $FFFF to $0000).
;  This code makes no attempt to detect this possibility.

    INCLUDE "Symbols.inc"

    ORG HELPER2

_helper2
_helper2_start
_helper2_entry

    PSHS Y                          ; Preserve register Y
    JSR INTCNV                      ; D = Requested length
                                    ;     (passed from BASIC)
    LDX #STRING                     ; X = Start of the string
    PSHS B                          ; Store the LSB of the length
    ANDB #$fe                       ; Round down to an even number
    TFR D,Y                         ; Y = Length, rounded down to
                                    ;             an even number
    LDD #'A*256+'B                  ; String will start with "AB"

    LEAY ,Y                         ; Test length
    BEQ _helper2_terminate_string   ; If length is 0 or 1, don't loop

_helper2_copy_loop

    STD ,X++                        ; Store the next two characters
                                    ; and increment X by 2
    CMPB #'Z                        ; Have we reached the letter Z?
    BEQ _helper2_start_digits       ; If yes, start with the digits

    CMPB #'9                        ; Have we reached the digit 9?
    BEQ  _helper2_start_alphabet    ; If yes, start with the alphabet

    ADDD #$0202                     ; Alter the characters that
                                    ;   we're storing

_helper2_count_and_loop

    LEAY -2,Y                       ; Y is our counter
    BNE _helper2_copy_loop          ; If more chars are needed, loop

_helper2_terminate_string

    PULS B                          ; B = The LSB of the length
    ANDB #$1                        ; Is the length an odd number?
    BEQ _helper2_even_count         ; If no, skip the next instruction

    STA ,X+                         ; Store one last character

_helper2_even_count

    CLR ,X                          ; Add the terminating zero
    PULS Y,PC                       ; Restore register Y
                                    ; and return to BASIC

; Subroutines

_helper2_start_digits

    LDD #'0*256+'1                  ; Start with the digits
    BRA _helper2_count_and_loop

_helper2_start_alphabet

    LDD #'A*256+'B                  ; Start with the alphabet (again)
    BRA _helper2_count_and_loop

_helper2_end

    IF    (_helper2_end > HELPER2_LIMIT)
    ERROR "Helper2 object code does not fit into the space allocated"
    ENDIF

    END
