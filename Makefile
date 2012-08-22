dir := $(dir $(lastword $(MAKEFILE_LIST)))
pwd := $(shell cd $(dir); pwd)
platform := $(shell uname)
specialfiles:= .bashrc .bash_path
dirs:= bin
normalfiles:= $(shell git ls-files | grep -v 'Makefile\|README\|bashrc\|bash_path\|ssh_config\|/')

install:
	@for x in $(normalfiles); do\
		ln -sf "$(pwd)/$$x" ~;\
	done
	@for d in $(dirs); do\
		if [ ! -e ~/$$d ]; then\
			ln -sf "$(pwd)/$$d" ~;\
		fi;\
	done
	@ln -sf "$(pwd)/.ssh_config" ~/.ssh/config
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
