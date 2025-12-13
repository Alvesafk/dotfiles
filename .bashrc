#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias so='source ~/.bashrc'

alias c='clear'
alias e='exit'
alias sps='sudo pacman -S'
alias spss='sudo pacman -Ss'
alias sprns='sudo pacman -Rns'
alias kys='sudo pacman -Syu'

alias g='git'
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gpl='git pull'
alias gps='git push'
alias glog='git log --oneline --graph'

alias vim='nvim'

alias ls='lsd --color never'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
