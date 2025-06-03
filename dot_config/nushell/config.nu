use std/dirs

$env.config.show_banner = false
$env.config.edit_mode = "vi"

let autoload_dir = ($nu.data-dir | path join 'vendor/autoload')
mkdir $autoload_dir

if ((which oh-my-posh | length) != 0) {
    let omp_path = $"($autoload_dir)/oh-my-posh.nu"
    let omp_config = "~/.config/omp/jonnyb.omp.yaml"
    if (($omp_path | path type) != "file") {
        oh-my-posh init nu --config $omp_config --print | save $omp_path
    }
}

if ((which carapace | length) != 0) {
    let carapace_path = $"($autoload_dir)/carapace.nu"
    $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
    if (($carapace_path | path type) != "file") {
        carapace _carapace nushell | save --force  $carapace_path
    }
}
