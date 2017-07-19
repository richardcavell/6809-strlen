# Makefile
# by Richard John Foster Cavell (c) 2017
# Part of the 6809-strlen project

ASM = asm6809

.DEFAULT: all
.PHONY: all

all: strlen.bin

strlen.bin: strlen.s
	$(ASM) $< $(OUTPUT_OPTION)

clean:
	$(RM) strlen.bin
