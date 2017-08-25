# Makefile
# by Richard John Foster Cavell (c) 2017
# Part of the 6809-strlen project

# Note that we build the strlen routine as a DECB disk file here

ASM        = asm6809
AFLAGS     = -C
DECBTOOL   = decb
XROAR      = xroar
MAME       = mame
MAIN       = main.s
STRLENBIN  = strlen.bin
HELPER1BIN = helper1.bin
HELPER2BIN = helper2.bin
DSKIMG     = TSTSUITE.DSK

.DEFAULT: all
.PHONY:   all

all: $(STRLENBIN) $(HELPER1BIN) $(HELPER2BIN) $(DSKIMG)

$(STRLENBIN): $(MAIN)
	$(ASM) $(AFLAGS) $< $(OUTPUT_OPTION)

$(HELPER1BIN): helper1.s
	$(ASM) $(AFLAGS) $< $(OUTPUT_OPTION)

$(HELPER2BIN): helper2.s
	$(ASM) $(AFLAGS) $< $(OUTPUT_OPTION)

$(DSKIMG): $(HELPER1BIN) $(HELPER2BIN) $(STRLENBIN)
	$(RM) $@
	$(DECBTOOL) dskini $@ -3
	$(DECBTOOL) copy TEST.BAS  -0  -t $(DSKIMG),TEST.BAS
	$(DECBTOOL) copy $(STRLENBIN)  -2 $(DSKIMG),STRLEN.BIN
	$(DECBTOOL) copy $(HELPER1BIN) -2 $(DSKIMG),HELPER1.BIN
	$(DECBTOOL) copy $(HELPER2BIN) -2 $(DSKIMG),HELPER2.BIN

.PHONY: xroar

xroar:
	@echo "....................."
	@echo "...Launching XRoar..."
	@echo "....................."
	@echo "  Type : RUN \"TEST\""
	@echo "....................."
	@$(XROAR) -machine coco2b -load $(DSKIMG) -q 2> /dev/null

mame:
	@echo "....................."
	@echo "...Launching MAME...."
	@echo "....................."
	@echo "  Type : RUN \"TEST\""
	@echo "....................."
	@$(MAME) coco2b -flop1 $(DSKIMG)

clean:
	$(RM) $(STRLENBIN) $(HELPER1BIN) $(HELPER2BIN) $(DSKIMG)
