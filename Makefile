##############
# parameters #
##############
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
	@pymakehelper touch_mkdir $@

.PHONY: debug
debug:
	$(info SRC is $(SRC))
	$(info OBJ is $(OBJ))
	$(info ELF is $(ELF))
.PHONY: clean
clean:
	@rm -rf $(ALL)

# rules
$(ELF): %.elf: %.hs
	$(info doing [$@])
	@ghc -v0 -o $@ $<
