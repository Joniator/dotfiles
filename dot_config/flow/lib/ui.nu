# Shared UI helpers built on Charm's gum + glow.
#
# Every command in flow should style its output through this module so the
# look stays consistent. Keep gum/glow flags in here, not in cmd/*.nu.

# ---- styled output ---------------------------------------------------------

export def header [text: string] {
    gum style --border rounded --padding "0 2" --border-foreground 212 --foreground 212 --bold $text
}

export def info [text: string] {
    gum style --foreground 244 $"  ($text)"
}

export def success [text: string] {
    gum style --foreground 42 --bold $"✓ ($text)"
}

export def warn [text: string] {
    gum style --foreground 214 $"! ($text)"
}

export def error [text: string] {
    gum style --foreground 196 --bold $"✗ ($text)"
}

# ---- prompts ---------------------------------------------------------------

# Yes/no confirm. Returns true on confirm.
export def confirm [prompt: string]: nothing -> bool {
    (do -i { gum confirm $prompt } | complete | get exit_code) == 0
}

# Single-line text input.
export def input [placeholder: string]: nothing -> string {
    gum input --placeholder $placeholder
}

# Multi-line editor (returns text).
export def write [placeholder: string]: nothing -> string {
    gum write --placeholder $placeholder
}

# Fuzzy pick one item from stdin (lines).
export def pick [header: string]: list<string> -> string {
    $in | to text | gum filter --header $header
}

# Pick many items from stdin (lines) via space-toggle.
export def "pick many" [header: string]: list<string> -> list<string> {
    $in | to text | gum choose --no-limit --header $header | lines
}

# ---- long-running actions --------------------------------------------------

# Print a titled progress line before running the given closure. Kept simple
# because gum spin cannot easily wrap a nushell closure (closures aren't
# serializable). If you need a real spinner, invoke `gum spin -- <external>`
# directly from the command that owns the work.
export def progress [title: string, action: closure] {
    info $title
    do $action
}

# ---- markdown --------------------------------------------------------------

# Render markdown text via glow.
export def md []: string -> nothing {
    $in | glow -
}

# ---- top-level help --------------------------------------------------------

export def help [] {
    header "flow"
    print ""
    print "Commands:"
    print "  flow chezmoi origin-to-ssh   rewrite dotfiles remote as ssh"
    print "  flow chezmoi update [--force]  weekly refresh + regen vendor autoloads"
    print "  flow edit zsh|nvim|nu|mise   chezmoi edit a config subtree"
    print "  flow git branch              interactive checkout"
    print "  flow git commit              stage + commit with prompt"
    print "  flow git wip                 quick WIP commit"
    print "  flow net ip                  public ip via ipinfo.io"
    print "  flow nvim update             headless Lazy sync + re-add lockfile"
    print "  flow oc project [name]       switch OpenShift project (fuzzy if omitted)"
    print "  flow oc pods                 browse pods in current project"
    print "  flow review diff             review staged diff with glow + mods"
    print ""
    print "Extend at ~/.config/flow/ — see README.md."
}
