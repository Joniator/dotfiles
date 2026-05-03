#! /usr/bin/env zsh

alias ca="chezmoi apply"
alias cg="chezmoi git"
alias g="git"

if executable_exists eza
then
    alias ls="eza"
fi

if executable_exists nvim
then
    alias vi="nvim"
    alias vim="nvim"
fi

function vf() {
    local dir=${1:-.}
    local file=$(fd . --type file "$dir" | fzf)
    if [[ $? != 0 ]];
    then 
        return 0
    fi
    vi "$file"
}

function cf() {
    local dir=${1:-.}
    local file=$(fd . --type file "$dir" | fzf)
    if [[ $? != 0 ]];
    then 
        return 0
    fi
    ce "$file"
}

function ce() {
    local dir=$PWD
    cd ~/.local/share/chezmoi
    vi $@
    chezmoi apply
    cd $dir
    exec zsh
}

