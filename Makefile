##############
# parameters #
##############
# do you want to see the commands executed ?
DO_MKDBG:=0

########
# code #
########
# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

ALL:=
SRC:=$(shell find . -name "*.hs")
ELF:=$(addsuffix .elf,$(basename $(SRC)))

ALL+=$(ELF)

.PHONY: all
all: $(ALL)
	@true

.PHONY: debug
debug:
	$(info doing [$@])
	$(info SRC is $(SRC))
	$(info OBJ is $(OBJ))
	$(info ELF is $(ELF))
.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)rm -rf $(ALL)
.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd

############
# patterns #
############
$(ELF): %.elf: %.hs
	$(info doing [$@])
	$(Q)ghc -v0 -o $@ $<
