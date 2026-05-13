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

alias vi='vi'

alias ls='lsd --color never'
alias lsl='lsd --color never -l'
alias grep='grep --color=auto'

alias p3='python3'
alias ve='source .venv/bin/activate'
alias pge="python manage.py"

PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'; PS1='\u@\h \W ${PS1_CMD1}\n\$ '

export TERM=xterm-256color

export GTK_IM_MODULE=simple

export PATH="$HOME/.cargo/bin:$PATH"
