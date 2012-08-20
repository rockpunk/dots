# some more ls aliases
alias ls='ls -FG'
alias l='ls -CF'
alias ll='l -l'
alias la='l -ACF'
alias c='clear'

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

# git
alias g='git status'
alias gc='git commit -m'
alias gd='git diff'
alias ga='git add'
alias gaa='git add .'
alias gp='git push'
alias gu='git pull'


alias light='export SOLARIZED=light; solarize; echo -e "\033]50;SetProfile=SolarizedLight\a"'
alias dark='export SOLARIZED=dark; solarize; echo -e "\033]50;SetProfile=SolarizedDark\a"'

alias tt='tmux attach || tmux new'
alias ack='ack-grep'
