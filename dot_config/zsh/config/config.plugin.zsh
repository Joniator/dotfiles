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

function dm_install() {
    tool=$1
    shift
    case $tool in
	*)
	    echo Not supported
    esac
}

function dm_edit() {
    segment=$1
    shift
    case $segment in
	zsh)
	    chezmoi edit --apply ~/.config/zsh
	    exec zsh
	    ;;
	nvim)
	    nvim ~/.config/nvim
	    ;;
    esac

}

function dm() {
    command=$1
    shift
    case $command in
	i|install)
	    dm_install $@
	    ;;
	e|edit)
	    dm_edit $@
	    ;;
    esac
}

alias ca="chezmoi apply"
alias ce="chezmoi edit --apply"
alias cg="chezmoi git"
