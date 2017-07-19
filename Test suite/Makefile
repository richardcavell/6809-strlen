# Makefile
# by Richard John Foster Cavell (c) 2017
# Part of the strlen.s project

ASM = asm6809

.DEFAULT: all
.PHONY: all

all: strlen_test.bin

strlen_test.bin: strlen_test.s
	$(ASM) $< $(OUTPUT_OPTION)

clean:
	$(RM) strlen_test.bin
