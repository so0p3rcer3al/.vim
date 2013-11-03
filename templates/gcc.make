###
# Template base: Nov 3 2013
# Can be quickly modified and extended to fit small projects.
#
cflags   = -std=c11
cxxflags = -std=c++11 #-pthread -Wl,--no-as-needed

ifneq ($F,0)
dbgcpp  += -O2
else
dbgcpp  += -O0
endif

ifneq ($F,1)
dbgcpp  +=      -ggdb3 -pedantic -Wall -Wextra                                \
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
dbgc    +=      -Wtraditional-conversion -Wdeclaration-after-statement        \
                -Wbad-function-cast -Wjump-misses-init                        \
                -Wstrict-prototypes -Wold-style-definition                    \
                -Wmissing-prototypes -Wnested-externs                         \
                -Wunsuffixed-float-constants
        # gcc >= 4.8 only
dbgcxx  +=      -Wzero-as-null-pointer-constant                               \
                -Wuseless-cast -Wvarargs
endif

exe   = prog
d_src = .
d_icl = .
d_ntm = tmp
c     = cpp
# additional: F={0,1,2}, runargs=..

srcs := $(wildcard $(d_src)/*.$c)
objs := $(srcs:$(d_src)/%.$c=$(d_ntm)/%.o)
CC        = gcc
CXX       = g++
CFLAGS   += $(strip $(cflags) $(dbgcpp) $(dbgc))
CXXFLAGS += $(strip $(cxxflags) $(dbgcpp) $(dbgcxx))
CPPFLAGS += $(addprefix -I,$(d_icl))

.PHONY: all check-config
all: check-config $(exe)
$(exe): $(objs)
	$(LINK.$c) $^ $(LOADLIBES) $(LDLIBS) -o $@
$(d_ntm)/%.o: $(d_src)/%.$c
	$(COMPILE.$c) -MD -MP $(OUTPUT_OPTION) $<

.PHONY: clean
clean:
	-rm -fv $(exe) $(d_ntm)/prevcfg $(d_ntm)/*.d $(d_ntm)/*.o
	-rmdir --ignore-fail-on-non-empty -p $(d_ntm)

.PHONY: run
run: all
	`readlink -e $(exe)` $(runargs)

newcfg   := $(strip $(foreach v,srcs LINK.$c COMPILE.$c,$v:$($v)))
-include $(d_ntm)/prevcfg
ifneq ($(newcfg),$(prevcfg))
check-config:
	@mkdir -p $(d_ntm)
	@rm -fv $(exe) $(d_ntm)/*.d $(d_ntm)/*.o
	@echo prevcfg=$(newcfg) > $(d_ntm)/prevcfg
$(objs): check-config
else
-include $(objs:.o=.d)
endif

