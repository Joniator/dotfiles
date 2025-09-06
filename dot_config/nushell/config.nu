use std/dirs

$env.config.show_banner = false
$env.config.edit_mode = "vi"

let autoload_dir = ($nu.data-dir | path join 'vendor' 'autoload')
mkdir $autoload_dir

if (which mise | is-not-empty) {
    use ($nu.data-dir | path join mise.nu)
}

if ((which oh-my-posh | length) != 0) {
    let omp_path = $autoload_dir | path join "oh-my-posh.nu"
    let omp_config = "~/.config/omp/jonnyb.omp.yaml"
    if (($omp_path | path type) != "file") {
        oh-my-posh init nu --config $omp_config --print | save $omp_path
    }
}

if ((which carapace | length) != 0) {
    let carapace_path = $autoload_dir | path join "carapace.nu"
    $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
    if (($carapace_path | path type) != "file") {
        carapace _carapace nushell | save --force  $carapace_path
    }
}

if ((which zoxide | length) != 0) {
    let zoxide_path = $autoload_dir | path join "zoxide.nu"
    if (($zoxide_path | path type) != "file") {
        zoxide init --cmd cd nushell | save --force $zoxide_path
    }
}

# Workaround to get ssh_agent working
if $nu.os-info.name == "linux" {
    do --env {
        let ssh_agent_file = (
            $nu.temp-path | path join $"ssh-agent-(whoami).nuon"
        )

        if ($ssh_agent_file | path exists) {
            let ssh_agent_env = open ($ssh_agent_file)
            if ($"/proc/($ssh_agent_env.SSH_AGENT_PID)" | path exists) {
                load-env $ssh_agent_env
                return
            } else {
                rm $ssh_agent_file
            }
        }

        let ssh_agent_env = ^ssh-agent -c
            | lines
            | first 2
            | parse "setenv {name} {value};"
            | transpose --header-row
            | into record
        load-env $ssh_agent_env
        $ssh_agent_env | save --force $ssh_agent_file
    }
}
