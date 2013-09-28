cflags = -std=c11 -ggdb3 -O0
dbgflags = 	-pedantic						\
		-Wall -Wextra						\
		-Wno-switch-default -Wno-sign-compare			\
		-Wdouble-promotion -Wformat=2 -Wmissing-include-dirs	\
		-Wsync-nand -Wunused -Wuninitialized -Wunknown-pragmas	\
		-Wstrict-overflow=5 -Wtrampolines -Wfloat-equal		\
		-Wundef -Wshadow -Wunsafe-loop-optimizations		\
		-Wcast-qual -Wcast-align -Wwrite-strings -Wconversion	\
		-Wsign-conversion -Wlogical-op -Wmissing-declarations	\
		-Wno-multichar -Wnormalized=nfc -Wpacked -Wpadded	\
		-Wredundant-decls -Winline -Winvalid-pch		\
		-Wvector-operation-performance -Wvla			\
		-Wdisabled-optimization -Wstack-protector		\
		-Woverlength-strings					\
	# c only
		-Wtraditional-conversion -Wdeclaration-after-statement	\
		-Wbad-function-cast -Wjump-misses-init			\
		-Wstrict-prototypes -Wold-style-definition		\
		-Wmissing-prototypes -Wnested-externs			\
		-Wunsuffixed-float-constants
	# gcc >= 4.8 only
		# -Wzero-as-null-pointer-constant			\
		# -Wconditionally-supported -Wdelete-incomplete		\
		# -Wuseless-cast -Wvarargs
out  = main
srcs = $(wildcard *.c)
incl = $(wildcard *.h)

CC = gcc
CFLAGS += $(cflags) $(dbgflags) $(incl)

.PHONY : all
all : $(out)

.PHONY : clean
clean :
	[ -f $(out) ] && rm -f $(out)

$(out) : $(srcs)
