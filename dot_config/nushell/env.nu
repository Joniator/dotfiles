# env.nu runs before nushell scans vendor autoload dirs and before config.nu.
# XDG vars must be set here so $nu.data-dir resolves to ~/.local/share/nushell
# on the very first launch — otherwise vendor autoloads (oh-my-posh, mise,
# carapace, zoxide, atuin) get written to a dir nushell never scanned this
# session, and only load on the *next* launch.

$env.XDG_CONFIG_HOME = ($env.HOME | path join .config)
$env.XDG_CACHE_HOME  = ($env.HOME | path join .local cache)
$env.XDG_STATE_HOME  = ($env.HOME | path join .local state)
$env.XDG_DATA_HOME   = ($env.HOME | path join .local share)
