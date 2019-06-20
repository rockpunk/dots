#!/bin/bash

if [ -z "$(type -P brew)" ]; then 
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

CASKS="iTerm2 adoptopenjdk"
PKGS="nvim bash-completion scala"

for cask in $CASKS; do 
    brew cask install $cask;
done

for pkg in $PKGS; do 
    brew install $pkg;
done
