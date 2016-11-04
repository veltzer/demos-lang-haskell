# parameters
SRC:=$(shell find . -name "*.hs")
ELF:=$(addsuffix .elf,$(basename $(SRC)))
ALL:=tools.stamp $(ELF)

.PHONY: all
all: $(ALL)
	@true

tools.stamp: templardefs/deps.py
	$(info doing [$@])
	@templar_cmd install_deps
	@make_helper touch-mkdir $@

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
