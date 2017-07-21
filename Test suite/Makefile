# Makefile
# by Richard John Foster Cavell (c) 2017
# Part of the 6809-strlen project

ASM = asm6809

.DEFAULT: all
.PHONY: all

all: helper.bin

helper.bin: helper.s
	$(ASM) $< $(OUTPUT_OPTION)

clean:
	$(RM) helper.bin
