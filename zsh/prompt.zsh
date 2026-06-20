NEWLINE=$'\n'

setopt PROMPT_SUBST

PROMPT="${NEWLINE}%K{#3c3836}%F{#ebdbb2}$(date +%_I:%M%P) %K{#504945}%F{#fbf1c7} %n %K{#665c54} %2~ %K{#b57614}%F{#1d2021}\$(git branch --show-current 2>/dev/null | sed 's/.*/  & /') %f%k❯ "

echo -e "${NEWLINE}\x1b[38;2;235;219;178m\x1b[48;2;40;40;40m it's$(date +%_I:%M%P) \x1b[38;2;215;153;33m\x1b[48;2;40;40;40m $(uptime -p | cut -c 4-) \x1b[38;2;104;157;106m\x1b[48;2;40;40;40m $(uname -r) \033[0m"
