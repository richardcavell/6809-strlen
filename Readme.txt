6809 Assembly Language C-Style String Length Calculation Routine
by Richard John Foster Cavell (c) 2017, 2018
Version 1.4 (7 January 2018)
https://github.com/richardcavell/6809-strlen

A 6809 assembly language routine to find the length of a C-style string.

This project is intended only for serious students of computer programming.

$FFFF means hexadecimal FFFF.

Inputs:

    register X = (unsigned 16-bit) pointer to the string.

Outputs:

    register D = (unsigned 16-bit) length of the string.
    (A value of $FFFF means there was a "no end" error)

    All other registers, including X, are preserved.

A C-style string, for the purposes of this routine, is a sequence of
non-zero 8-bit bytes, followed by a zero byte. The sequence may have
zero length.

A "no end" error can occur if the string continues past memory location
$FFFF. The default error handler returns a length of $FFFF. You should
check for this. You can also write your own error handler.

The code is position-independent and re-entrant. Interrupts are allowed
to occur during execution. The code uses 2 bytes of the S stack, in addition
to the 2 bytes used for the return PC value when calling this routine.

The code assembles to 21 bytes of object code using asm6809.

Issues:
 If X does not point to a valid string, the behaviour is undefined.
   If there is no terminating null byte, the code might access forbidden
     areas of the memory map.

The folder "Test suite" contains a method of testing this routine to be
sure that it works.

Another version of the routine is included, called "no_error_strlen.s". This
routine is smaller in code size. It assembles to 15 bytes of object code
and will complete faster in most cases. It does not detect the "no end"
condition and will simply wrap from $FFFF to $0000 while searching for
the end of the string.

You should only use no_error_strlen.s if you want extra performance or
reduced code size and can be quite sure that the string passed into the
routine is valid, and that the "no end" condition will never occur.

All of this is licensed to you under the MIT License.

Published and maintained at: https://github.com/richardcavell/6809-strlen
