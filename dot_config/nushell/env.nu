$env.config.shell_integration.osc133 = false
$env.EDITOR = "nvim"

$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_CACHE_HOME = $"($env.HOME)/.local/cache"
$env.XDG_STATE_HOME = $"($env.HOME)/.local/state"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"

$env.Path = ($env.Path 
    | prepend $"($env.HOME)/.local/bin"
)
