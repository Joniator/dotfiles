# flow git <cmd> — implementations. Wire new entries in ~/.local/bin/flow.

use ~/.config/flow/lib/ui.nu
use ~/.config/flow/lib/util.nu

# Interactive branch checkout.
export def branch [] {
    util require git gum
    let picked = (
        git branch --format='%(refname:short)'
        | lines
        | each { |b| $b | str trim }
        | where { |b| $b != "" }
        | ui pick "Checkout branch"
    )
    if ($picked | is-empty) { return }
    git checkout $picked
    ui success $"on ($picked)"
}

# Stage-all + commit with a prompted message.
export def commit [] {
    util require git gum
    let dirty = (git status --porcelain | lines)
    if ($dirty | is-empty) {
        ui info "nothing to commit"
        return
    }
    ui header "changes"
    git status --short
    print ""
    if not (ui confirm "Stage all and commit?") {
        ui warn "aborted"
        return
    }
    git add -A
    let msg = (ui input "commit message")
    if ($msg | str trim | is-empty) {
        ui error "empty message — aborting"
        return
    }
    git commit -m $msg
    ui success "committed"
}

# Quick WIP commit (stages everything, canned message).
export def wip [] {
    util require git
    git add -A
    git commit -m "wip" --no-verify
    ui success "wip committed"
}
