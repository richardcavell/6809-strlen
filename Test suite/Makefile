# Makefile
# by Richard John Foster Cavell (c) 2017, 2018
# Part of the 6809-strlen project

# Note that we build the strlen and no_error_strlen routines as
# DECB disk files here

ASM         = asm6809
AFLAGS      = -C -8 --setdp=-1 -v
DECBTOOL    = decb
XROAR       = xroar
MAME        = mame
SYMBOLS     = Symbols.inc
MAIN1       = main1.s
MAIN2       = main2.s
STRLENSRC   = ../strlen.s
STRLENBIN   = strlen.bin
NESTRLENSRC = ../no_error_strlen.s
NESTRLENBIN = nestrlen.bin
HELPER1SRC  = helper1.s
HELPER2SRC  = helper2.s
HELPER1BIN  = helper1.bin
HELPER2BIN  = helper2.bin
TESTBAS     = TEST.BAS
DSKIMG      = TSTSUITE.DSK

.DEFAULT: all
.PHONY:   all

all: $(STRLENBIN) $(NESTRLENBIN)
all: $(HELPER1BIN) $(HELPER2BIN)
all: $(DSKIMG)

$(STRLENBIN): $(MAIN1) $(STRLENSRC) $(SYMBOLS)
	$(ASM) $(AFLAGS) $< $(OUTPUT_OPTION)

$(NESTRLENBIN): $(MAIN2) $(NESTRLENSRC) $(SYMBOLS)
	$(ASM) $(AFLAGS) $< $(OUTPUT_OPTION)

$(HELPER1BIN): $(HELPER1SRC) $(SYMBOLS)
	$(ASM) $(AFLAGS) $< $(OUTPUT_OPTION)

$(HELPER2BIN): $(HELPER2SRC) $(SYMBOLS)
	$(ASM) $(AFLAGS) $< $(OUTPUT_OPTION)

$(DSKIMG): $(TESTBAS)
$(DSKIMG): $(STRLENBIN) $(NESTRLENBIN)
$(DSKIMG): $(HELPER1BIN) $(HELPER2BIN)
	$(RM) $@
	$(DECBTOOL) dskini $@ -3
	$(DECBTOOL) copy $(TESTBAS)     -0 -t $(DSKIMG),TEST.BAS
	$(DECBTOOL) copy $(STRLENBIN)   -2    $(DSKIMG),STRLEN.BIN
	$(DECBTOOL) copy $(NESTRLENBIN) -2    $(DSKIMG),NESTRLEN.BIN
	$(DECBTOOL) copy $(HELPER1BIN)  -2    $(DSKIMG),HELPER1.BIN
	$(DECBTOOL) copy $(HELPER2BIN)  -2    $(DSKIMG),HELPER2.BIN

.PHONY: xroar

xroar:  $(DSKIMG)
	@echo "Launching XRoar..."
	$(XROAR) -machine coco2b -load $(DSKIMG) -type 'RUN "TEST"\r' -q 2> /dev/null

.PHONY: mame

mame:   $(DSKIMG)
	@echo "Launching MAME..."
	$(MAME) coco2b -flop1 $(DSKIMG) -autoboot_command "RUN \"TEST\"\n" -autoboot_delay 2

.PHONY: clean

clean:
	$(RM) $(STRLENBIN) $(NESTRLENBIN) $(HELPER1BIN) $(HELPER2BIN) $(DSKIMG)
