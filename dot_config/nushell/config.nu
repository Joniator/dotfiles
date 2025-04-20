$env.config.show_banner = false

const omp_path = "~/.config/omp/oh-my-posh.nu"
const omp_config = "~/.config/omp/jonnyb.omp.yaml"
if (($omp_path | path type) != "file") {
    oh-my-posh init nu --config $omp_config --print | save $omp_path
}
source $omp_path

source alias.nu
