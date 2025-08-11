$env.config.shell_integration.osc133 = false
$env.EDITOR = "nvim"

$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_CACHE_HOME = $"($env.HOME)/.local/cache"
$env.XDG_STATE_HOME = $"($env.HOME)/.local/state"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"

$env.Path = ($env.Path 
    | prepend $"($env.HOME)/.local/bin"
    | prepend $"($env.XDG_DATA_HOME)/fnm"
)

$env.GOPATH = $"($env.XDG_DATA_HOME)/go"
$env.Path = $env.Path 
| prepend $"($env.HOME)/.local/go/bin"
| prepend $"($env.GOPATH)/bin"

if (which fnm | is-not-empty) {
    fnm env --json | from json | load-env

    $env.PATH = $env.PATH | prepend ($env.FNM_MULTISHELL_PATH | path join "bin")

    $env.config.hooks.env_change.PWD = (
        $env.config.hooks.env_change.PWD? | append {
            condition: {|| ['.nvmrc' '.node-version'] | any {|el| $el | path exists}}
            code: {|| fnm use}
        })
}
