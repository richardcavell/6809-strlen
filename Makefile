# Makefile
# by Richard John Foster Cavell (c) 2017, 2018, 2019, 2025
# Part of the 6809-strlen project
# https://github.com/richardcavell/6809-strlen

# We build strlen.bin and no_error_strlen.bin
# as raw binaries here. The test suite builds
# its own versions of the routines, differently.

#The asm6809 assembler was created by Ciaran Anscomb
ASM       = asm6809
AFLAGS    = -B -8 --setdp=-1 -v

LSTFLAGS  = -l
SYMFLAGS  = -s

SOURCE1   = strlen.s
BINARY1   = strlen.bin
LISTING1  = strlen.lst
SYMBOL1   = strlen.sym

SOURCE2   = no_error_strlen.s
BINARY2   = no_error_strlen.bin
LISTING2  = no_error_strlen.lst
SYMBOL2   = no_error_strlen.sym

EVERYTHING  = $(BINARY1) $(LISTING1) $(SYMBOL1) $(SYMBOL1).sorted
EVERYTHING += $(BINARY2) $(LISTING2) $(SYMBOL2) $(SYMBOL2).sorted

# This gives the desired result but it's not the intended use of -V
SORT      = sort -V

VERSION   = 1.8

.DEFAULT:   all

.PHONY:     all
.PHONY:     everything
.PHONY:     binaries
.PHONY:     listings
.PHONY:     symbols

# make all          makes just the binaries
# make everything   makes the binaries, and the listings and symbols

all:        binaries
everything: binaries listings symbols
binaries:   $(BINARY1) $(BINARY2)
listings:   $(LISTING1) $(LISTING2)
symbols:    $(SYMBOL1) $(SYMBOL2)

$(BINARY1): $(SOURCE1)
$(BINARY2): $(SOURCE2)

$(LISTING1): $(SOURCE1)
$(LISTING2): $(SOURCE2)

$(SYMBOL1): $(SOURCE1)
$(SYMBOL2): $(SOURCE2)

%.bin:
	$(ASM) $(AFLAGS) $< $(OUTPUT_OPTION)

%.lst:
	$(ASM) $(AFLAGS) $(LSTFLAGS) $@ $<

%.sym:
	$(ASM) $(AFLAGS) $(SYMFLAGS) $@ $<
	$(SORT) $@ -o $@.sorted
	mv $@.sorted $@

.PHONY:     info
.PHONY:     version
.PHONY:     help
.PHONY:     clean

info:
	@echo "6809-strlen version" $(VERSION) "by Richard Cavell"

version:
	@echo $(VERSION)

help:
	@echo "The valid targets for this makefile:"
	@echo "make all         # this builds only the binaries"
	@echo "make everything  # this builds absolutely everything"
	@echo "make binaries"
	@echo "make listings"
	@echo "make symbols"
	@echo "make" $(BINARY1)
	@echo "make" $(LISTING1)
	@echo "make" $(SYMBOL1)
	@echo "make" $(BINARY2)
	@echo "make" $(LISTING2)
	@echo "make" $(SYMBOL2)
	@echo "make info"
	@echo "make version"
	@echo "make help"
	@echo "make clean"

clean:
	$(RM) $(EVERYTHING)
