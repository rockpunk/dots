#!/bin/bash

base=$(cd "$(dirname $0)" && pwd)

if [ -z "$(type -P brew)" ]; then 
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

CASKS="iTerm2 adoptopenjdk docker gitup"
PKGS="nvim bash-completion scala pyenv pyenv-virtualenv lastpass-cli jq maven sbt autossh pgcli htop \
wget tree git dsh"

for cask in $CASKS; do 
    brew cask install $cask;
done

for pkg in $PKGS; do 
    brew install $pkg;
done

$base/update-homedir.sh

. ~/.bashrc

GLOBAL_PKGS="pipenv awscli"

for $pkg in $PKY_PKGS; do
    pip install $pkg;
done
