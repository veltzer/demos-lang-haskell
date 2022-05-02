##############
# parameters #
##############

########
# code #
########
ALL:=
SRC:=$(shell find . -name "*.hs")
ELF:=$(addsuffix .elf,$(basename $(SRC)))

ALL+=$(ELF)

.PHONY: all
all: $(ALL)
	@true

.PHONY: debug
debug:
	$(info SRC is $(SRC))
	$(info OBJ is $(OBJ))
	$(info ELF is $(ELF))
.PHONY: clean
clean:
	$(Q)rm -rf $(ALL)
.PHONY: clean_hard
clean_hard:
	$(Q)git clean -qffxd

# rules
$(ELF): %.elf: %.hs
	$(info doing [$@])
	$(Q)ghc -v0 -o $@ $<
