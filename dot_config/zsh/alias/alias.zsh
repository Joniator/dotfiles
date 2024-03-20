#!/usr/bin/env zsh

alias ls='eza --group-directories-first'
alias fzf='fzf --preview "batcat --color=always --style=numbers --line-range=:500 {}"'
alias bat='batcat'
alias cat='bat'
alias zshsrc='source $HOME/.config/zsh/.zshrc'

alias gacp='gaa && gc && gp'

cdc() {
  mkdir -p "$1"
  cd "$1"
}

batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs batcat --diff
}

