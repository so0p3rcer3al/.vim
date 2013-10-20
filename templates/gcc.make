cflags = -std=c11 -ggdb3 -O0
dbgflags =      -pedantic                                                     \
                -Wall -Wextra                                                 \
                -Wno-switch-default -Wno-sign-compare                         \
                -Wdouble-promotion -Wformat=2 -Wmissing-include-dirs          \
                -Wsync-nand -Wunused -Wuninitialized -Wunknown-pragmas        \
                -Wstrict-overflow=5 -Wtrampolines -Wfloat-equal               \
                -Wundef -Wshadow -Wunsafe-loop-optimizations                  \
                -Wcast-qual -Wcast-align -Wwrite-strings -Wconversion         \
                -Wsign-conversion -Wlogical-op -Wmissing-declarations         \
                -Wno-multichar -Wnormalized=nfc -Wpacked -Wpadded             \
                -Wredundant-decls -Winline -Winvalid-pch                      \
                -Wvector-operation-performance -Wvla                          \
                -Wdisabled-optimization -Wstack-protector                     \
                -Woverlength-strings                                          \
        # c only
                -Wtraditional-conversion -Wdeclaration-after-statement        \
                -Wbad-function-cast -Wjump-misses-init                        \
                -Wstrict-prototypes -Wold-style-definition                    \
                -Wmissing-prototypes -Wnested-externs                         \
                -Wunsuffixed-float-constants
        # gcc >= 4.8 only
                # -Wzero-as-null-pointer-constant                             \
                # -Wconditionally-supported -Wdelete-incomplete               \
                # -Wuseless-cast -Wvarargs
exe   = prog
d_src = .
d_icl = .
d_ntm = tmp

srcs := $(wildcard $(d_src)/*.c)
objs := $(srcs:$(d_src)/%.c=$(d_ntm)/%.o)
CC        = gcc
CFLAGS   += $(cflags) $(dbgflags)
CPPFLAGS += $(addprefix -I, $(d_icl))

.PHONY: all
all: $(exe)
$(exe): $(objs)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
$(d_ntm)/%.o : $(d_src)/%.c
	@mkdir -p $(@D)
	$(COMPILE.c) -MD -MP $(OUTPUT_OPTION) $<

.PHONY: clean
clean:
	-rm -f $(exe)
	-rm -f $(d_ntm)/*.d $(d_ntm)/*.o
	-rmdir --ignore-fail-on-non-empty -p $(d_ntm)

.PHONY: run
run: all
	`readlink -e $(exe)`

-include $(objs:.o=.d)
