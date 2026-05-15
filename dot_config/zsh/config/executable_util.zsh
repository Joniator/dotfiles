#! /usr/bin/env zsh

function executable_exists() {
    command -v "$1" >/dev/null 2>&1
    return $?
}

function oc() {
    if [[ "$1" == "project" && $# -eq 1 ]]; then
        local project
        project=$(command oc projects -q | fzf) || return 0
        command oc project "$project"
    else
        command oc "$@"
    fi
}

function chezmoi_origin_to_ssh() {
    chezmoi git remote set-url origin ssh://git@codeberg.org/JonnyB/dotfiles.git
}

