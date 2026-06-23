# xdg base dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# editor stuff 
export EDITOR="nvim"
export VISUAL="nvim"

# go
export GOPATH=$HOME/first-party/go

# random stuff
export TERM=xterm-256color
export GPG_TTY=$(tty)

# path with cargo and go bins
export PATH="$HOME/.cargo/bin:$PATH:/usr/local/go/bin:$GOPATH/bin"

if command -v bat >/dev/null 2>&1; then
	export MANPAGER="bat -l man -p"
fi

export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"
