6809-strlen Test suite Readme.txt
by Richard John Foster Cavell
(c) 2017, 2018, 2019, 2025 (Licensed to you under the MIT License)
https://github.com/richardcavell/6809-strlen

Note: It is not within the scope of this project to teach you how to use
      Linux, XRoar or MAME.

To use the test suite on XRoar:

  1.  If you have Linux, install make and xroar
  2.  Open a terminal
  3.  Go to the "Test suite" directory
  4.  Type "make xroar"

To use the test suite on MAME:

  1.  If you have Linux, install make and mame
  2.  Open a terminal
  3.  Go to the "Test suite" directory
  4.  Type "make mame"

In order to use the test suite, you will need one of:

  1.  XRoar, by Ciaran Anscomb, located here:
             http://www.6809.org.uk/xroar/

  2.  MAME, located here:
            http://mamedev.org/

      You will also need the relevant ROM sets to run a Coco 2 PAL machine
      (known as coco2b by both XRoar and MAME)

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
