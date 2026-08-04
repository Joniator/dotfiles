# flow dev <cmd> — day-to-day development flows.

use ~/.config/flow/lib/ui.nu
use ~/.config/flow/lib/util.nu

# Start a new feature branch off latest main.
#
# 1. Abort if the working tree is dirty.
# 2. Pick the project (FSSDEV / VDRDEV).
# 3. Prompt for ticket number (pre-filled with the project prefix + '-').
# 4. Prompt for a short slug.
# 5. switch main -> fetch -> switch -c feature/<TICKET>-<slug>.
export def start [] {
    util require git gum

    # 1. clean tree
    let dirty = (git status --porcelain | str trim)
    if ($dirty | is-not-empty) {
        ui error "working tree not clean — commit or stash first"
        git status --short
        exit 1
    }

    # 2. project
    let project = (["FSSDEV" "VDRDEV"] | ui pick "Project")
    if ($project | is-empty) {
        ui warn "aborted"
        return
    }

    # 3. ticket (pre-filled with "<PROJECT>-")
    let ticket = (gum input --prompt "Ticket: " --value $"($project)-" --placeholder $"($project)-1234" | str trim)
    if ($ticket | is-empty) or ($ticket == $"($project)-") {
        ui error "ticket number required"
        exit 1
    }

    # 4. slug — normalize to lowercase-dashed
    let raw_slug = (gum input --prompt "Slug: " --placeholder "short-description" | str trim)
    if ($raw_slug | is-empty) {
        ui error "slug required"
        exit 1
    }
    let slug = (
        $raw_slug
        | str downcase
        | str replace --all --regex '[^a-z0-9]+' '-'
        | str trim --char '-'
    )

    let branch = $"feature/($ticket)-($slug)"

    # 5. main + fetch + new branch
    ui info $"→ ($branch)"
    git switch main
    git fetch --prune
    git pull --ff-only
    git switch -c $branch
    ui success $"on ($branch)"
}
