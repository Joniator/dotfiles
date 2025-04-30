use std/dirs

$env.config.show_banner = false
$env.config.edit_mode = "vi"


let autoload_dir = ($nu.data-dir | path join 'vendor/autoload')
mkdir $autoload_dir

let omp_path = $"($autoload_dir)/oh-my-posh.nu"
let omp_config = "~/.config/omp/jonnyb.omp.yaml"
if (($omp_path | path type) != "file") {
    oh-my-posh init nu --config $omp_config --print | save $omp_path
}
