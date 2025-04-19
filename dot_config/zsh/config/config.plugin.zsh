#! /usr/bin/env zsh

fpath=($fpath ${0:A:h}/completions)

function executable_exists() {
    command -v "$1" >/dev/null 2>&1
    return $?
}

if executable_exists oh-my-posh
then 
	eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/omp/jonnyb.omp.yaml)" 
fi

if executable_exists nvim
then
    alias vi="nvim"
    alias vim="nvim"
fi

alias ca="chezmoi apply"
alias ce="chezmoi edit --apply"
