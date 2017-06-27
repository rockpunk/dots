# some more ls aliases
alias ls='ls -FG'
alias l='ls -CF'
alias ll='l -l'
alias la='l -ACF'
alias c='clear'
alias less='less -R'

# screen
alias ss='_call_screen'
alias screen='screen -U'
alias sl='screen -ls'
alias sr='screen -r'
alias sdr='screen -d -r'

# ssh
alias aa='keychain ~/.ssh/id_rsa ; . ~/.keychain/`hostname`-sh'

# hg
alias h='hg status'
alias hc='hg commit'
alias hd='hg diff'
alias ha='hg add'
alias haa='hg add .'
alias hrm='hg rm'
alias hu='hg pull -u'
alias hi='hg in'
alias ho='hg out'
alias hp='hg push'
alias ht='hg tip'
alias htp='hg tip -p'
alias hqc='hg qrefresh'
alias hqp='hg qpop'
alias hqa='hg qapplied'
alias hqs='hg qseries'
alias hqpp='hg qpush'

alias dev='hg up -r dev'
alias prd='hg up -r default'

# git
alias g='git status'
alias gc='git commit -a'
alias gd='git diff'
alias ga='git add .'
alias gp='git push'
alias gu='git pull'
alias gt='git tip'
alias gtp='git tip -p'
alias gb='git branch'
alias gba='git branch -a'
alias bfg='java -jar ~/lib/java/bfg.jar'


alias light='export SOLARIZED=light; solarize; echo -e "\033]1337;SetProfile=Solarized Light\a"'
alias dark='export SOLARIZED=dark; solarize; echo -e "\033]1337;SetProfile=Solarized Dark\a"'

function growl() {
   echo -e "\033]9;${@}\a"
}

alias tt='tmux attach || tmux -f ~/.tmux.bob.conf new'
alias wl='wemux l'
alias wk='wemux k'
function ww() { 
    if [ -z $1 ]; then
        wemux
    else
        wemux j $1 > /dev/null && wemux
    fi
}

function greename() {
    if echo $1 | grep '[0-9]\+' >/dev/null; then
        grep $1 /etc/dsh/group/gree -B1
    else
        grep $1 /etc/dsh/group/gree -A1 | sed '/^$/d'
    fi
}

greessh() {
    ssh $(greename $1 | tail -n1)
}

if [ ! -z "$(type -f nvim)" ]; then
    alias vim='nvim'
fi

