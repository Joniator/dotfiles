# flow review <cmd> — code review helpers.

use ~/.config/flow/lib/ui.nu
use ~/.config/flow/lib/util.nu

# Show the staged diff rendered as markdown, then (optionally) summarize via mods.
export def diff [] {
    util require git
    let diff = (git diff --cached)
    if ($diff | str trim | is-empty) {
        ui info "no staged changes"
        return
    }
    ui header "staged diff"
    $"```diff\n($diff)\n```" | ui md
    if (util has mods) and (ui confirm "Summarize with mods?") {
        $diff | mods "Summarize this diff for a code review. Highlight risks."
    }
}
