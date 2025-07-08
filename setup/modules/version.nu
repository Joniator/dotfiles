export def put [ repo: string, version: string] {
    mut catalog = get_catalog

    mut github = $catalog.github | where repo != $repo | append { repo: $repo, version: $version }

    $catalog = {
        github: $github
    }
    $catalog | save -f ($env.XDG_DATA_HOME | path join "dotfiles" "versions.yaml")
}

export def get_version [ repo: string ] {
    get_catalog
    | get github
    | where repo == $repo
    | get 0.version -i 
}

def get_catalog [] {
    let file = $env.XDG_DATA_HOME | path join "dotfiles" "versions.yaml"
    if ($file | path exists) == false {
        touch $file
    }
    open $file | default { github: [] }
}
