$env.config.shell_integration.osc133 = false
$env.EDITOR = 'nvim'

$env.XDG_CONFIG_HOME = ($env.HOME | path join .config)
$env.XDG_CACHE_HOME = ($env.HOME | path join .local cache)
$env.XDG_STATE_HOME = ($env.HOME | path join .local state)
$env.XDG_DATA_HOME = ($env.HOME | path join .local share)

const is_windows = ($nu.os-info.name == "windows")

if ($is_windows and (sys host | get hostname | str contains -i "msgn")) {
    print "Configure msg environment"
    const mise_root = ("/workspaces" | path join home mise)
    $env.MISE_CACHE_DIR = $mise_root | path join "cache"
    $env.MISE_STATE_DIR = $mise_root | path join "state"
    $env.MISE_DATA_DIR = $mise_root | path join "data"
}

$env.Path = ($env.Path 
    | prepend $"($env.HOME)/.local/bin"
    | prepend $"($env.XDG_DATA_HOME)/fnm"
)

$env.GOPATH = $"($env.XDG_DATA_HOME)/go"
$env.Path = $env.Path 
| prepend $"($env.HOME)/.local/go/bin"
| prepend $"($env.GOPATH)/bin"


mkdir $nu.data-dir
if (which mise | is-not-empty) {
    let mise_path = $nu.data-dir | path join mise.nu
    ^mise activate nu | save $mise_path --force
}
