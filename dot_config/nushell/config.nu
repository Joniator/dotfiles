use std/dirs

$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.shell_integration.osc133 = false

# XDG_* vars are set in env.nu (runs before vendor autoload scan).

$env.NU_VENDOR_AUTOLOAD_DIR = ($nu.data-dir | path join 'vendor' 'autoload')
mkdir $env.NU_VENDOR_AUTOLOAD_DIR


const is_windows = ($nu.os-info.name == "windows")
if ($is_windows and (sys host | get hostname | str contains -i "msgn")) {
    print "Configure msg environment"
    const mise_root = ("/workspaces" | path join home mise)
    $env.MISE_CACHE_DIR = $mise_root | path join "cache"
    $env.MISE_STATE_DIR = $mise_root | path join "state"
    $env.MISE_DATA_DIR = $mise_root | path join "data"
}

$env.GOPATH = $"($env.XDG_DATA_HOME)/go"
$env.Path = ($env.Path 
    | prepend $"($env.HOME)/.local/bin"
    | prepend $"($env.HOME)/.local/go/bin"
    | prepend $"($env.GOPATH)/bin"
)

# Local secrets (gitignored, not managed by chezmoi)
# Uses `open --raw` (runtime), so safe when file doesn't exist
let secret_env = ($env.HOME | path join ".env.secret")
if ($secret_env | path exists) {
    open --raw $secret_env
    | lines
    | where { |line| ($line | str trim | str length) > 0 and not ($line | str trim | str starts-with "#") }
    | each { |line| $line | str replace --regex '^export\s+' '' }
    | each { |line|
        let idx = ($line | str index-of "=")
        let key = ($line | str substring 0..<$idx)
        let raw = ($line | str substring ($idx + 1)..)
        # Strip matching surrounding single or double quotes (dotenv-style)
        let val = if (($raw | str starts-with '"') and ($raw | str ends-with '"')) or (($raw | str starts-with "'") and ($raw | str ends-with "'")) {
            $raw | str substring 1..<(($raw | str length) - 1)
        } else {
            $raw
        }
        { $key: $val }
    }
    | reduce -f {} { |it, acc| $acc | merge $it }
    | load-env
}

if (which fastfetch | is-not-empty) {
    fastfetch
}
