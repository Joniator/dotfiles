#!/usr/bin/env zsh

alias ls='eza --group-directories-first'
alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias bat='batcat'
alias cat='bat'
alias zshsrc='source $HOME/.config/zsh/.zshrc'

cdc() {
  mkdir -p "$1"
  cd "$1"
}
