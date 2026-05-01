#! /usr/bin/env zsh

function executable_exists() {
    command -v "$1" >/dev/null 2>&1
    return $?
}

