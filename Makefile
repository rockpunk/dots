dir := $(dir $(lastword $(MAKEFILE_LIST)))
pwd := $(shell cd $(dir); pwd)
platform := $(shell uname)
specialfiles:= .bashrc .bash_path .bash_profile
dirs:= bin .bashrc.d
normalfiles:= $(shell git ls-files | grep -v 'Makefile\|README\|bash_profile\|bashrc\|bash_path\|ssh_config\|dircolors\|/')

install:
	@mkdir -p ~/.ssh && chmod 700 ~/.ssh
	@for x in $(normalfiles); do\
		ln -sf "$(pwd)/$$x" ~;\
	done
	@for d in $(dirs); do\
		if [ ! -e ~/$$d ]; then\
			ln -sf "$(pwd)/$$d" ~;\
		fi;\
	done
	@ln -sf "$(pwd)/.ssh_config" ~/.ssh/config
	@mkdir -p ~/.config/nvim
	@ln -sf ~/.vimrc ~/.config/nvim/init.vim
ifeq ($(platform),Darwin)
	@for x in $(specialfiles); do\
		ln -sf "$(pwd)/$$x.mac" ~/$$x;\
	done
else
	@for x in $(specialfiles); do\
		ln -sf "$(pwd)/$$x" ~;\
	done
	@for x in dark light; do\
		ln -sf $(pwd)/dircolors-solarized/dircolors.ansi-$$x ~/.dir_colors.ansi-$$x;\
	done
	@ln -sf ~/.dir_colors.ansi-dark ~/.dir_colors
endif
	@echo ". ~/.bashrc"
