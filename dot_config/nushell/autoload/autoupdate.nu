const config_file = $nu.data-dir | path join "autoupdate.yaml"
mut config = {};

if ($config_file | path exists) {
    $config = open $config_file
}

if (($config._last_updated? | is-empty) or ($config.last_updated | date from-human) < (date now) - 1day) {
    print "Updating dotfiles"
    $config.last_updated = date now
    $config | save -f $config_file
    chezmoi update
}
