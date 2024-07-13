#!/usr/bin/env zsh

alias ls='eza --group-directories-first'
alias fzf='fzf --preview "batcat --color=always --style=numbers --line-range=:500 {}"'
alias bat='batcat'
alias cat='bat'
alias zshsrc='source $HOME/.config/zsh/.zshrc'
alias suvi='sudo -E nvim'

alias gacp='gaa && gc && gp'

cdc() {
  mkdir -p "$1"
  cd "$1"
}

batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs batcat --diff
}

alias yt-mp3='yt-dlp --extract-audio --audio-format mp3'
alias yt-mp4='yt-dlp -S res,ext:mp4:m4a --recode mp4'
alias lazy-update='nvim --headless "+Lazy! sync" +qa; ch re-add $HOME/.config/nvim/lazy-lock.json'
