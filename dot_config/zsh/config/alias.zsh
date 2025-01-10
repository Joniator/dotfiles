#!/usr/bin/env zsh

bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

if executable_exists "yt-dlp"; then
  alias yt-mp3='yt-dlp --extract-audio --audio-format mp3'
  alias yt-mp4='yt-dlp -S res,ext:mp4:m4a --recode mp4'
fi

if executable_exists "batcat"; then
  alias bat='batcat'
  alias cat='bat'
  alias fzf='fzf --preview "batcat --color=always --style=numbers --line-range=:500 {}"'
fi

if executable_exists "chezmoi"; then
  alias ch='chezmoi'
  alias cha='ch apply'
  alias chaa='cha --refresh-externals'
  alias chadd='ch add'
  alias chaddt='cha --template'
  alias chae='chap --exclude=encrypted'
  alias che='ch edit --apply'
  alias chg="ch git"
fi

if executable_exists "eza"; then
  alias ls='eza --group-directories-first'
fi

alias gacp='gaa && gc && gp'
alias lazy-update='nvim --headless "+Lazy! sync" +qa; ch re-add $HOME/.config/nvim/lazy-lock.json'
alias suvi='sudo -E nvim'
alias suz='sudo -E zsh'
alias vi='vim'
alias vim='nvim'
alias zshsrc='source $HOME/.config/zsh/.zshrc'

cdc() {
  mkdir -p "$1"
  cd "$1"
}

batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs batcat --diff
}


