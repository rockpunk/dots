#!/bin/bash

base=$(cd "$(dirname $0)" && pwd)

if [ -z "$(type -P brew)" ]; then 
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

CASKS="iTerm2 adoptopenjdk docker gitup"
PKGS="nvim bash-completion scala pyenv pyenv-virtualenv lastpass-cli jq maven autossh pgcli htop \
wget tree git dsh node yarn"

for cask in $CASKS; do 
    brew cask install $cask;
done

for pkg in $PKGS; do 
    brew install $pkg;
done

$base/update-homedir.sh

. ~/.bashrc

GLOBAL_PKGS="pipenv awscli poetry"

for $pkg in $PKY_PKGS; do
    pip install $pkg;
done

# sdkman!
curl -s https://get.sdkman.io | sed '/^sdkman_bash_profile=/s/^\(sdkman_bash_profile\)=.*/\1=$HOME\/.bashrc.d\/15-sdkman.conf/' | bash
