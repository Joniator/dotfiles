# Windows install — entry point, mirrors setup/install.sh for Linux.
#
# Usage (local):   powershell -ExecutionPolicy Bypass -File .\setup\install.ps1
# Usage (remote):  iwr -useb https://codeberg.org/JonnyB/dotfiles/raw/branch/main/setup/install.ps1 | iex

$ErrorActionPreference = 'Stop'

$BaseUrl = 'https://codeberg.org/JonnyB/dotfiles/raw/branch/main/setup'

# Resolve lib dir. If running from a checkout, source the sibling lib/*.ps1
# directly so edits apply immediately; otherwise fetch from Codeberg.
$ScriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { $null }
$LibDir    = if ($ScriptDir) { Join-Path $ScriptDir 'lib' } else { $null }

function Source-Lib {
    param([string]$Name)
    $local = if ($LibDir) { Join-Path $LibDir $Name } else { $null }
    if ($local -and (Test-Path $local)) {
        . $local
    } else {
        $url = "$BaseUrl/lib/$Name"
        $tmp = New-TemporaryFile
        try {
            Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $tmp
            . $tmp
        } finally {
            Remove-Item $tmp -ErrorAction SilentlyContinue
        }
    }
}

Source-Lib 'windows.ps1'

# Apply dotfiles
chezmoi init --apply https://codeberg.org/JonnyB/dotfiles.git
