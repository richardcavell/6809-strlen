# Makefile
# by Richard John Foster Cavell (c) 2017
# Part of the 6809-strlen project

ASM = asm6809

.DEFAULT: all
.PHONY: all

all: helper1.bin helper2.bin

helper1.bin: helper1.s
	$(ASM) $< $(OUTPUT_OPTION)

helper2.bin: helper2.s
	$(ASM) $< $(OUTPUT_OPTION)

clean:
	$(RM) helper1.bin helper2.bin
