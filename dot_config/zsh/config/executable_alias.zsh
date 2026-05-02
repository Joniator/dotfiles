#! /usr/bin/env zsh

alias ca="chezmoi apply"
alias cg="chezmoi git"
alias g="git"

function ce() {
    local dir=$PWD
    cd ~/.local/share/chezmoi
    vi $@
    chezmoi apply
    cd $dir
    exec zsh
}

if executable_exists nvim
then
    alias vi="nvim"
    alias vim="nvim"

    vf() {
        file="$(find . | fzf)"
        if [[ $? = 0 ]]; then
            nvim "$file"
        fi
    }
fi

