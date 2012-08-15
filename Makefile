dir := $(dir $(lastword $(MAKEFILE_LIST)))
pwd := $(shell cd $(dir); pwd)
platform := $(shell uname)
specialfiles:= .bashrc .bash_path
normalfiles:= $(shell git ls-files | grep -v 'Makefile\|README\|bashrc\|bash_path')

install:
	@for x in $(normalfiles); do\
		ln -sf "$(pwd)/$$x" ~;\
	done
ifeq ($(platform),Darwin)
	@for x in $(specialfiles); do\
		ln -sf "$(pwd)/$$x.mac" ~/$$x;\
	done
else
	@for x in $(specialfiles); do\
		ln -sf "$(pwd)/$$x" ~;\
	done
endif
	@echo ". ~/.bashrc"
