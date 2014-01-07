
# your uw user name
# by default it takes the name of the current user. it might
# be a good idea to just hardcode this.
user     = $(USER)

# project number
# by default it takes the last digit of the current directory.
# so 'assn_02' => 2, 'ece250assignment3' => 3, .etc.
project  = $(shell basename `pwd` | tail -c2)

# list of files to be ignored
ignore   = ignore_this_file.cpp \
           and_this.h



run:
	g++ $(wildcard *.cpp) -o prog
	./prog

package:
	tar -cvf $(user)_p$(project).tar \
		$(filter-out $(ignore), $(wildcard *.cpp) $(wildcard *.h))
	gzip -f $(user)_p$(project).tar

clean:
	-rm prog
	-rm $(user)_p$(project).tar
	-rm $(user)_p$(project).tar.gz

