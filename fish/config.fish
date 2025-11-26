if status is-interactive
    # Commands to run in interactive sessions can go here
end

set PATH $PATH:/home/afk/.local/bin/

# Aliases 

alias c=clear
alias e=exit
alias phps="php -S localhost:8000"
alias gic="git commit"
alias gis="git status"

oh-my-posh init fish --config ~/.config/ohmyposh/theme.omp.json | source
