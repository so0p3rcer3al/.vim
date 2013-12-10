
cxx   = g++
file  = main.cpp
o     = -O2
v     = 1
# needed for icpc
misc = -I/usr/include/x86_64-linux-gnu/c++/4.8

.PHONY: all
all:
	$(cxx) -S -fverbose-asm $(misc) $o -std=c++11 $(file) -o $(cxx).s
	[ $v -eq 1 ] && vim $(cxx).s

