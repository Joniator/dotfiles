# Small shared helpers used across cmd/*.nu.
# Keep this module tiny — anything ui-shaped belongs in ui.nu instead.

use ui.nu

# Abort with a styled error message and non-zero exit.
export def abort [msg: string] {
    ui error $msg
    exit 1
}

# Return true if the given external command exists on PATH.
export def has [cmd: string]: nothing -> bool {
    (which $cmd | is-not-empty)
}

# Require a set of commands; abort listing any that are missing.
export def require [...cmds: string] {
    let missing = ($cmds | where { |c| not (has $c) })
    if ($missing | is-not-empty) {
        abort $"missing required command\(s\): ($missing | str join ', ')"
    }
}
