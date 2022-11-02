export EDITOR="vim"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
export ZSH_CUSTOM="$XDG_CONFIG_HOME/oh-my-zsh_custom"
export ZSH_CACHE_DIR="$ZSH/cache"

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export LESSHISTFILE="$XDG_STATE_HOME/lesshst"
export HISTFILE="$XDG_STATE_HOME/zsh_history"
export VIMINIT='source $XDG_CONFIG_HOME/vim/vimrc'

export PATH="$PATH:$HOME/.local/bin"
