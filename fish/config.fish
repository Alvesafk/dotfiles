if status is-interactive
    # Commands to run in interactive sessions can go here
end

set PATH $PATH:/home/afk/.local/bin/

# Aliases 

alias vim=nvim
alias v=nvim
alias c=clear
alias e=exit

oh-my-posh init fish --config ~/.config/ohmyposh/theme.omp.json | source
