# Makefile
# by Richard John Foster Cavell (c) 2017
# Part of the 6809-strlen project
# https://github.com/richardcavell/6809-strlen

# We build strlen.bin and no_error_strlen.bin
# as raw binaries here

ASM     = asm6809

SOURCE1 = strlen.s
SOURCE2 = no_error_strlen.s

BINARY1 = strlen.bin
BINARY2 = no_error_strlen.bin

.DEFAULT: all
.PHONY:   all

all:    $(BINARY1) $(BINARY2)

$(BINARY1): $(SOURCE1)
	$(ASM) $< $(OUTPUT_OPTION)

$(BINARY2): $(SOURCE2)
	$(ASM) $< $(OUTPUT_OPTION)

.PHONY: clean

clean:
	$(RM) $(BINARY1) $(BINARY2)
