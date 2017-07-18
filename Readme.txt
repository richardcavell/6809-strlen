6809 Assembly Language String Length Calculation
by Richard John Foster Cavell (c) 2017
Version 1.0

A 6809 assembly routine to find the length of a C-style string.

Inputs:
  X = Pointer to the string.

Outputs:
  D = Length of the string.

All other registers, including X, are preserved.

Issues:
 If X does not point to a valid string, the behaviour is undefined.
   If there is no terminating null byte, the code might access forbidden
     areas of the memory map.
   It is possible for X to wrap (say from $FFFF to $0000). This code makes
     no attempt to detect this possibility, because the behaviour may be
     desirable.

Licensed to you under the MIT License
Published and maintained at: https://github.com/richardcavell/6809-strlen
