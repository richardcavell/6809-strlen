6809 Assembly Language String Length Calculation
by Richard John Foster Cavell (c) 2017
Version 1.1 (24 August 2017)

A 6809 assembly routine to find the length of a C-style string.

Inputs:
  X = Pointer to the string.

Outputs:
  D = Length of the string.

  All other registers, including X, are preserved.

A C-style string, for the purposes of this routine, is a sequence of
non-zero 8-bit bytes, followed by a zero byte. The sequence may have
zero length.

A "no end" error can occur if the string continues past memory location
0xFFFF. The default error handler returns a length of 0xFFFF. You should
check for this. You can also write your own error handler.

The code is position-independent and re-entrant. Interrupts are allowed
to occur during execution. It uses 2 bytes of the S stack, in addition
to the 2 bytes used for the return PC value when calling this routine.

It assembles to 26 bytes (0xF bytes) of object code using asm6809.

Issues:
 If X does not point to a valid string, the behaviour is undefined.
   If there is no terminating null byte, the code might access forbidden
     areas of the memory map.

The folder "Test suite" contains a method of testing this routine to be
sure that it works.

Another version of the routine is included, as "no_error_strlen.s". This
routine is significantly smaller in code size. It assembles to 15 bytes of
object code and will run faster if the no-end condition never occurs.

It does not detect the "no end" condition and will simply wrap from 0xFFFF
to 0x0000 while searching for the end of the string.

You should only use this routine if you want extra performance or reduced
code size and can be quite sure that the string passed into the routine
is valid, and that the "no end" condition will never occur.

Licensed to you under the MIT License.

Published and maintained at: https://github.com/richardcavell/6809-strlen
