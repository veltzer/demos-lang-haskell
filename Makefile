##############
# parameters #
##############
# do you want to do tools?
DO_TOOLS:=1

########
# code #
########
ALL:=
TOOLS=tools.stamp
SRC:=$(shell find . -name "*.hs")
ELF:=$(addsuffix .elf,$(basename $(SRC)))

# tools
ifeq ($(DO_TOOLS),1)
.EXTRA_PREREQS+=$(TOOLS)
ALL+=$(TOOLS)
endif # DO_TOOLS

ALL+=$(ELF)

.PHONY: all
all: $(ALL)
	@true

tools.stamp: config/deps.py
	$(info doing [$@])
	$(Q)pymakehelper touch_mkdir $@

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
