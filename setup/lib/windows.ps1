# Windows install — sourced by install.ps1.
#
# Strategy: prefer scoop (per-user, no admin, great CLI coverage),
# fall back to winget for anything scoop lacks.

function Ensure-Scoop {
    if (Get-Command scoop -ErrorAction SilentlyContinue) { return }
    Write-Host '[scoop] installing...'
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri 'https://get.scoop.sh' | Invoke-Expression
    scoop bucket add extras
    scoop bucket add nerd-fonts
}

function Ensure-Winget {
    if (Get-Command winget -ErrorAction SilentlyContinue) { return }
    Write-Warning 'winget not found — some fallbacks may be skipped.'
}

# Install-Tool -Scoop <bucket/pkg> -Winget <Publisher.Id>
# Tries scoop first. If scoop install fails (or the tool isn't available in
# any added bucket) falls back to winget.
function Install-Tool {
    param(
        [Parameter(Mandatory)] [string]$Scoop,
        [Parameter(Mandatory)] [string]$Winget
    )
    $pkgName = ($Scoop -split '/')[-1]
    if (scoop list 2>$null | Select-String -SimpleMatch $pkgName) {
        Write-Host "[skip] $pkgName already installed via scoop"
        return
    }
    try {
        Write-Host "[scoop] installing $Scoop"
        scoop install $Scoop
        return
    } catch {
        Write-Warning "[scoop] failed for $Scoop — falling back to winget ($Winget)"
    }
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install --id $Winget --silent --accept-source-agreements --accept-package-agreements
    } else {
        Write-Error "Could not install $pkgName: scoop failed and winget unavailable."
    }
}

Ensure-Scoop
Ensure-Winget

# --- Charm suite: the whole reason flow works nicely ---
Install-Tool -Scoop 'main/gum'         -Winget 'charmbracelet.gum'
Install-Tool -Scoop 'main/glow'        -Winget 'charmbracelet.glow'
Install-Tool -Scoop 'main/mods'        -Winget 'charmbracelet.mods'

# --- shells & prompt ---
Install-Tool -Scoop 'main/nu'          -Winget 'Nushell.Nushell'
Install-Tool -Scoop 'extras/oh-my-posh' -Winget 'JanDeDobbeleer.OhMyPosh'

# --- dotfiles + version management ---
Install-Tool -Scoop 'main/chezmoi'     -Winget 'twpayne.chezmoi'
Install-Tool -Scoop 'main/mise'        -Winget 'jdx.mise'

# --- shell UX ---
Install-Tool -Scoop 'main/atuin'       -Winget 'ellie.atuin'
Install-Tool -Scoop 'main/zoxide'      -Winget 'ajeetdsouza.zoxide'
Install-Tool -Scoop 'main/carapace'    -Winget 'rsteube.Carapace'
Install-Tool -Scoop 'main/fzf'         -Winget 'junegunn.fzf'

# --- core CLI tools ---
Install-Tool -Scoop 'main/ripgrep'     -Winget 'BurntSushi.ripgrep.MSVC'
Install-Tool -Scoop 'main/fd'          -Winget 'sharkdp.fd'
Install-Tool -Scoop 'main/eza'         -Winget 'eza-community.eza'
Install-Tool -Scoop 'main/git'         -Winget 'Git.Git'
Install-Tool -Scoop 'main/neovim'      -Winget 'Neovim.Neovim'
Install-Tool -Scoop 'main/fastfetch'   -Winget 'Fastfetch-cli.Fastfetch'

Write-Host ''
Write-Host 'Windows tool install complete.'
Write-Host 'Note: ~/.local/bin/flow.cmd requires ~/.local/bin on PATH.'
Write-Host '      Add it once with:  setx PATH "$env:USERPROFILE\.local\bin;$env:PATH"'
