#! /usr/bin/env zsh

# executable_exists is an internal shell helper used by other zsh config
# files (config.plugin.zsh, executable_alias.zsh). User-facing utilities
# live in `flow` — see ~/.config/flow/.
function executable_exists() {
    command -v "$1" >/dev/null 2>&1
    return $?
}
