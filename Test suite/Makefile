# Makefile
# by Richard John Foster Cavell (c) 2017, 2018, 2019
# Part of the 6809-strlen project

# Note that we build the strlen and no_error_strlen routines as
# DECB disk files here

ASM         = asm6809
AFLAGS      = -C -8 --setdp=-1 -v
LSTFLAGS    = -l
SYMFLAGS    = -s
DECBTOOL    = decb
XROAR       = xroar
MAME        = mame
SYMBOLS     = Symbols.inc
MAIN1       = main1.s
MAIN2       = main2.s
STRLENSRC   = ../strlen.s
STRLENBIN   = strlen.bin
STRLENLST   = strlen.lst
STRLENSYM   = strlen.sym
NESTRLENSRC = ../no_error_strlen.s
NESTRLENBIN = nestrlen.bin
NESTRLENLST = nestrlen.lst
NESTRLENSYM = nestrlen.sym
HELPER1SRC  = helper1.s
HELPER1BIN  = helper1.bin
HELPER1LST  = helper1.lst
HELPER1SYM  = helper1.sym
HELPER2SRC  = helper2.s
HELPER2BIN  = helper2.bin
HELPER2LST  = helper2.lst
HELPER2SYM  = helper2.sym
TESTBAS     = TEST.BAS
DSKIMG      = TSTSUITE.DSK
VERSION     = 1.7

# This is not the intended use of -V but it works for our purposes
SORT        = sort -V

.DEFAULT: all

.PHONY:   all
.PHONY:   everything
.PHONY:   binaries
.PHONY:   listings
.PHONY:   symbols
.PHONY:   disk
.PHONY:   xroar
.PHONY:   mame
.PHONY:   mame-debug
.PHONY:   info
.PHONY:   version
.PHONY:   help
.PHONY:   clean

all:        binaries disk
everything: binaries listings symbols disk
binaries:   $(STRLENBIN) $(NESTRLENBIN) $(HELPER1BIN) $(HELPER2BIN)
listings:   $(STRLENLST) $(NESTRLENLST) $(HELPER1LST) $(HELPER2LST)
symbols:    $(STRLENSYM) $(NESTRLENSYM) $(HELPER1SYM) $(HELPER2SYM)
disk:       $(DSKIMG)

$(STRLENBIN):   $(MAIN1) $(STRLENSRC) $(SYMBOLS)
$(NESTRLENBIN): $(MAIN2) $(NESTRLENSRC) $(SYMBOLS)
$(HELPER1BIN):  $(HELPER1SRC) $(SYMBOLS)
$(HELPER2BIN):  $(HELPER2SRC) $(SYMBOLS)

%.bin:
	$(ASM) $(AFLAGS) $< $(OUTPUT_OPTION)

$(STRLENLST):   $(MAIN1) $(STRLENSRC) $(SYMBOLS)
$(NESTRLENLST): $(MAIN2) $(NESTRLENSRC) $(SYMBOLS)
$(HELPER1LST):  $(HELPER1SRC) $(SYMBOLS)
$(HELPER2LST):  $(HELPER2SRC) $(SYMBOLS)

%.lst:
	$(ASM) $(AFLAGS) $(LSTFLAGS) $@ $<

$(STRLENSYM):   $(MAIN1) $(STRLENSRC) $(SYMBOLS)
$(NESTRLENSYM): $(MAIN2) $(NESTRLENSRC) $(SYMBOLS)
$(HELPER1SYM):  $(HELPER1SRC) $(SYMBOLS)
$(HELPER2SYM):  $(HELPER2SRC) $(SYMBOLS)

%.sym:
	$(ASM) $(AFLAGS) $(SYMFLAGS) $@ $<
	$(SORT) $@ -o $@.sorted
	mv $@.sorted $@

$(DSKIMG): $(TESTBAS) $(STRLENBIN) $(NESTRLENBIN) $(HELPER1BIN) $(HELPER2BIN)
	$(RM) $@
	$(DECBTOOL) dskini $@ -3
	$(DECBTOOL) copy $(TESTBAS)     -0 -t $(DSKIMG),TEST.BAS
	$(DECBTOOL) copy $(STRLENBIN)   -2    $(DSKIMG),STRLEN.BIN
	$(DECBTOOL) copy $(NESTRLENBIN) -2    $(DSKIMG),NESTRLEN.BIN
	$(DECBTOOL) copy $(HELPER1BIN)  -2    $(DSKIMG),HELPER1.BIN
	$(DECBTOOL) copy $(HELPER2BIN)  -2    $(DSKIMG),HELPER2.BIN

xroar:  $(DSKIMG)
	@echo "Launching XRoar..."
	$(XROAR) -machine coco2b -load $(DSKIMG) -type 'RUN "TEST"\r' -q 2> /dev/null

mame:   $(DSKIMG)
	@echo "Launching MAME..."
	$(MAME) coco2b -flop1 $(DSKIMG) -autoboot_command "RUN \"TEST\"\n" -autoboot_delay 2

mame-debug:   $(DSKIMG)
	@echo "Launching MAME..."
	$(MAME) coco2b -flop1 $(DSKIMG) -autoboot_command "RUN \"TEST\"\n" -autoboot_delay 2 -debug

info:
	@echo "6809-strlen version" $(VERSION) "by Richard Cavell"

version:
	@echo $(VERSION)

help:
	@echo "Some valid targets for this makefile:"
	@echo "make all         # this builds the binaries and disk"
	@echo "make everything  # this builds absolutely everything"
	@echo "make binaries"
	@echo "make listings"
	@echo "make symbols"
	@echo "make disk"
	@echo "make xroar"
	@echo "make mame"
	@echo "make mame-debug"
	@echo "make info"
	@echo "make version"
	@echo "make help"
	@echo "make clean"

clean:
	$(RM) $(STRLENBIN) $(NESTRLENBIN) $(HELPER1BIN) $(HELPER2BIN) $(STRLENLST) $(NESTRLENLST) $(HELPER1LST) $(HELPER2LST) $(STRLENSYM) $(NESTRLENSYM) $(HELPER1SYM) $(HELPER2SYM) $(DSKIMG)
