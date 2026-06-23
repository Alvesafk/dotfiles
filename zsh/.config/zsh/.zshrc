# history time 

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# shell behaviour

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

# zoxide
eval "$(zoxide init zsh)"

# autocomplete

autoload -Uz compinit

compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*' menu select

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# fzf

if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
fi 

# modular config

# fzf config
source "$ZDOTDIR/fzf.zsh"

# aliases
source "$ZDOTDIR/aliases.zsh"

# binds
source "$ZDOTDIR/binds.zsh"

# plugins
source "$ZDOTDIR/plugins.zsh"

# prompt
source "$ZDOTDIR/prompt.zsh"

# programs specific stugg
source "$ZDOTDIR/programs.zsh"

