# Makefile
# by Richard John Foster Cavell (c) 2017
# Part of the 6809-strlen project
# https://github.com/richardcavell/6809-strlen

# Note that we build strlen.bin as a raw binary here

ASM    = asm6809
SOURCE = strlen.s
BINARY = strlen.bin

.DEFAULT: all
.PHONY: all

all: $(BINARY)

$(BINARY): $(SOURCE)
	$(ASM) $< $(OUTPUT_OPTION)

clean:
	$(RM) $(BINARY)
