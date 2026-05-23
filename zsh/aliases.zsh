# normal use stuff
alias so="source $ZDOTDIR/.zshrc"
alias c="clear"
alias e="exit"

alias ls="eza --icons --colour=never"
alias ll="eza -lh --icons --git --colour=never"
alias la="eza -lah --icons --git --colour=never"
alias tree="eza --tree --icons --colour=never"

compdef eza=ls

alias grep="rg --color=never"
alias diff="diff --color=never"
alias df="df -h"

# dev aliases
alias p3='python3'
alias ve='source .venv/bin/activate'
alias pge="python manage.py"

alias glog="PAGER='less -F -X' git log"
alias gadog="PAGER='less -F -X' git log --all --decorate --oneline --graph"
