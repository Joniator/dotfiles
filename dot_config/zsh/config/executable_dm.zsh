#! /usr/bin/env zsh

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
        *)
            dm_help
            ;;
    esac
}

