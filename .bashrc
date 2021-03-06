# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [ -f ~/.bash_path ]; then
    . ~/.bash_path
    for d in $path; do 
        if [ -d "$d" -a -z "$(echo $PATH | grep "$d" 2>/dev/null)" ]; then
            PATH=$PATH:$d
        fi
    done
    export PATH
fi


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export EDITOR=vim
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto git"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm|xterm-color|screen|xterm-256color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(__git_ps1 " (%s)")\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w $(__git_ps1 " (%s)")\$ '
    ;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export DEFAULT_SOLARIZED='dark'

function solarize() { 
    [ -z "$SOLARIZED" ] && export SOLARIZED=$DEFAULT_SOLARIZED
    if diff $HOME/.dir_colors{,.ansi-$SOLARIZED} >/dev/null 2>&1; then
        ln -sf $HOME/.dir_colors.ansi-$SOLARIZED $HOME/.dir_colors
    fi
    eval `dircolors $HOME/.dir_colors`; export LS_COLORS; 
    PS1='${debian_chroot:+($debian_chroot)}\[\033[00;32m\]\u@\h\[\033[00;39m\]:\[\033[00;34m\]\w\[\033[00;39m\] $(__git_ps1 "(%s)")\$ '
}

function desolarize() {
    eval `dircolors -b`; export LS_COLORS; 
    unset SOLARIZED;
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(__git_ps1 "(%s)")\$ '
}

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
    
    if [ -L $HOME/.dir_colors ]; then
        solarize
    else
        desolarize
    fi
fi

function _call_screen() {
    export SCREEN_SESSION=$1
    shift 1
    if [ -f "$HOME/.screenrc.$SCREEN_SESSION" ]; then
        export SCREENRC="$HOME/.screenrc.$SCREEN_SESSION"
        s="-S $SCREEN_SESSION"
    else
        export SCREENRC=''
    fi
    echo "calling screen $s $@"
    screen $s $@
}

# useful screen aliases
##for x in .screenrc.*; do 
##    eval "alias ${x/.screenrc.}=\"_call_screen ${x/.screenrc.} -d -R\""
##done

function mm() {
    host=${1:-localhost}
    if [ "$host" = "localhost" ]; then
        shift
        mysql -uroot "$@"
    else
        if ! echo $host | grep "$(hostname -d)\$" >/dev/null; then
            host="$host.$(hostname -d)"
        fi
        shift
        mysql -uuser -ppass -h$host "$@"
    fi
}

function screenpid() {
    pid=$1
    if [ -z "$pid" ]; then
        echo "screenpid PID - returns the screen running the process PID"
        return 1
    fi
    n=0
    parent=0
    while [ $parent -ne 1 ]; do
        parent=$(ps h -p $pid -o ppid 2>/dev/null)
        res=$?
        [ -z "$parent" ] && break
        [ $res -ne 0 -o $parent -eq 1 ] && break
        pid=$parent
        # just in case...
        n=$((n+1))
        [ $n -gt 100 ] && echo "recursion limit..." && break
    done
    screen -list | grep $pid
}

export HOSTNAME=`hostname`

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -z "$PYTHONPATH" ]; then
    export PYTHONPATH=$HOME/lib/python
elif ! echo $PYTHONPATH | grep $HOME > /dev/null; then
    export PYTHONPATH=$PYTHONPATH:$HOME/lib/python
fi

# make date and stuff show PST even though system clock is UTC
export TZ='America/Los_Angeles';
export LANG=en_US.utf8

# psql pager
#export PAGER=less
#export LESS="-iMSx4 -FX"

if [ ! -z "$(type -p ack-grep)" ]; then
    alias ack='ack-grep'
fi

export PERL5LIB=/home/cru/lib/perl/lib/perl/5.10/auto:/home/cru/lib/perl/lib/perl/5.10.1/auto:/home/cru/lib/perl/share/perl/5.10.1:/home/cru/lib/perl/share/perl/5.10:$PERL5LIB

export EC2_HOME=/usr/local/bin/ec2-api-tools
export JAVA_HOME=/usr

for x in ~/.bashrc.d/*.conf; do
    source $x;
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
