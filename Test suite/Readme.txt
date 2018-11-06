6809-strlen Test suite Readme.txt
by Richard John Foster Cavell
(c) 2017, 2018 (Licensed to you under the MIT License)
https://github.com/richardcavell/6809-strlen

To use the test suite on XRoar:

  1.  Type "make xroar" on your computer

To use the test suite on MAME:

  1.  Type "make mame"  on your computer

In order to use the test suite, you will need one of:

  1.  XRoar, by Ciaran Anscomb, located here:
             http://www.6809.org.uk/xroar/

  2.  MAME, located here:
            http://mamedev.org/

      You will also need the relevant ROM sets

In order to build the test suite yourself, you will need to install both:

  1.  asm6809, by Ciaran Anscomb, located here:
               http://www.6809.org.uk/asm6809/

  2.  decb, part of the Toolshed project, located here:
            https://sourceforge.net/p/toolshed/wiki/Home/

This test suite has been successfully tested with, and is only officially
supported in regard to, the following emulated machines:

xroar -machine coco2b

  (with bas13.rom, extbas11.rom and disk11.rom in the ~/.xroar/roms directory)

  There are annoying bugs with prior versions of Color BASIC and
  Extended Color BASIC. I suggest that you don't use them.

mame coco2b

  (with coco2b.zip in ~/.mame/roms)

It probably works with other machines as well, but no official support is
provided to other configurations.

Richard Cavell
