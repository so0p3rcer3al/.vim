cflags   = -std=c11
cxxflags = -std=c++11
ifneq ($F,1)
dbgcpp   =      -ggdb3 -O0                                                    \
                -pedantic -Wall -Wextra                                       \
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
                -Woverlength-strings
dbgc     =      -Wtraditional-conversion -Wdeclaration-after-statement        \
                -Wbad-function-cast -Wjump-misses-init                        \
                -Wstrict-prototypes -Wold-style-definition                    \
                -Wmissing-prototypes -Wnested-externs                         \
                -Wunsuffixed-float-constants
	# for reference: gcc >= 4.8 only
                # -Wzero-as-null-pointer-constant                             \
                # -Wconditionally-supported -Wdelete-incomplete               \
                # -Wuseless-cast -Wvarargs
else
dbgcpp   =      -O2
endif

exe   = prog
d_src = .
d_icl = .
d_ntm = tmp
cx    = c

srcs := $(wildcard $(d_src)/*.$(cx))
objs := $(srcs:$(d_src)/%.$(cx)=$(d_ntm)/%.o)
CC        = gcc
CXX       = g++
CFLAGS   += $(strip $(cflags) $(dbgcpp) $(dbgc))
CXXFLAGS += $(strip $(cxxflags) $(dbgcpp))
CPPFLAGS += $(addprefix -I, $(d_icl))

.PHONY: all
all: $(exe)
$(exe): $(objs)
	$(LINK.$(cx)) $^ $(LOADLIBES) $(LDLIBS) -o $@
$(d_ntm)/%.o : $(d_src)/%.$(cx)
	@mkdir -p $(@D)
	$(COMPILE.$(cx)) -MD -MP $(OUTPUT_OPTION) $<

.PHONY: clean
clean:
	-rm -fv $(exe)
	-rm -fv $(d_ntm)/*.d $(d_ntm)/*.o
	-rmdir --ignore-fail-on-non-empty -p $(d_ntm)

.PHONY: run
run: all
	`readlink -e $(exe)` $(runargs)

-include $(objs:.o=.d)
