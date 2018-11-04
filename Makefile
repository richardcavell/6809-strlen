# Makefile
# by Richard John Foster Cavell (c) 2017, 2018
# Part of the 6809-strlen project
# https://github.com/richardcavell/6809-strlen

# We build strlen.bin and no_error_strlen.bin
# as raw binaries here. The test suite builds
# its own versions of the routines, differently.

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

.DEFAULT: all
.PHONY:   all
all:    $(BINARY1) $(BINARY2)

.PHONY:   everything
everything: $(BINARY1) $(LISTING1) $(SYMBOL1) $(BINARY2) $(LISTING2) $(SYMBOL2)

.PHONY:   listings
listings: $(LISTING1) $(LISTING2)

.PHONY:   symbols
symbols: $(SYMBOL1) $(SYMBOL2)

.PHONY:   help
help:
	@echo "The valid targets for this makefile:"
	@echo "make all         # this builds only the binaries"
	@echo "make everything  # this builds absolutely everything"
	@echo "make listings"
	@echo "make symbols"
	@echo "make" $(BINARY1)
	@echo "make" $(LISTING1)
	@echo "make" $(SYMBOL1)
	@echo "make" $(BINARY2)
	@echo "make" $(LISTING2)
	@echo "make" $(SYMBOL2)
	@echo "make help"
	@echo "make clean"

$(BINARY1): $(SOURCE1)
$(BINARY2): $(SOURCE2)

%.bin:
	$(ASM) $(AFLAGS) $< $(OUTPUT_OPTION)

$(LISTING1): $(SOURCE1)
$(LISTING2): $(SOURCE2)

%.lst:
	$(ASM) $(AFLAGS) $(LSTFLAGS) $@ $<

$(SYMBOL1): $(SOURCE1)
$(SYMBOL2): $(SOURCE2)

%.sym:
	$(ASM) $(AFLAGS) $(SYMFLAGS) $@ $<

.PHONY: clean
clean:
	$(RM) $(BINARY1) $(LISTING1) $(SYMBOL1) $(BINARY2) $(LISTING2) $(SYMBOL2)
