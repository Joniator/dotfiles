#!/usr/bin/env zsh

fpath=($fpath ${0:A:h}/completions)

function executable_exists() {
    command -v "$1" >/dev/null 2>&1
    return $?
}

source ${0:A:h}/setup.zsh
source ${0:A:h}/alias.zsh

