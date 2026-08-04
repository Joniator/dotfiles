# flow chezmoi <cmd> — chezmoi-related helpers.

use ~/.config/flow/lib/ui.nu
use ~/.config/flow/lib/util.nu

# Rewrite the dotfiles remote from https to ssh.
export def "origin-to-ssh" [] {
    util require chezmoi
    let url = "ssh://git@codeberg.org/JonnyB/dotfiles.git"
    chezmoi git remote set-url origin $url
    ui success $"origin → ($url)"
}

# Weekly-throttled dotfiles refresh + regenerate vendor autoload init files.
#
# Rate-limited via a small YAML at $nu.data-dir/autoupdate.yaml so it's cheap
# to call from a shell startup. Force a refresh with `--force`.
export def update [--force] {
    util require chezmoi
    let autoload_dir = ($nu.vendor-autoload-dirs | last)
    mkdir $autoload_dir

    const config_file = $nu.data-dir | path join "autoupdate.yaml"
    mut config = {}
    if ($config_file | path exists) {
        $config = open $config_file
    }

    let last = ($config.last_updated? | default null)
    let stale = ($force
        or ($last | is-empty)
        or (($last | date from-human) < (date now) - 7day))

    if $stale {
        ui info "updating dotfiles"
        $config | upsert last_updated (date now) | save -f $config_file
        chezmoi update
    } else {
        ui info $"last updated ($last) — skipping \(use --force to override\)"
    }

    # Regenerate each vendor-tool init file if the tool is present.
    if (util has mise) {
        ^mise activate nu | save ($autoload_dir | path join 'mise.nu') --force
        mise up
    }
    if (util has oh-my-posh) {
        let omp_config = "~/.config/omp/jonnyb.omp.yaml"
        oh-my-posh init nu --config $omp_config --print
        | save --force ($autoload_dir | path join "oh-my-posh.nu")
    }
    if (util has carapace) {
        $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
        carapace _carapace nushell
        | save --force ($autoload_dir | path join "carapace.nu")
    }
    if (util has zoxide) {
        zoxide init --cmd cd nushell
        | save --force ($autoload_dir | path join "zoxide.nu")
    }
    if (util has atuin) {
        atuin init nu --disable-up-arrow
        | save --force ($autoload_dir | path join "atuin.nu")
    }

    ui success "vendor autoloads regenerated"
}
