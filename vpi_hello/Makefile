VVPC ?= iverilog
VPIC ?= $(VVPC)-vpi

OBJNAME := hello
OBJ := $(OBJNAME).vpi $(OBJNAME).vvp

all: $(OBJ)

run:
	vvp -M. -m$(OBJNAME) $(OBJNAME).vvp

clean:
	rm -f *.o *.vpi *.vvp *~

%.vpi: %.c
	$(VPIC) $<

%.vvp: %.v
	$(VVPC) $< -o $@
