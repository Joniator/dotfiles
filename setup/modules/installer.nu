use ./version.nu

def get_os [] { 
    open /etc/os-release
    | lines
    | parse "{key}={value}"
    | where key == "ID"
    | get value
    | first
}

export def linux_dependencies [] {
    if ((get_os) == "cachyos") {
        paru --noconfirm -Sy ripgrep fd neovim zoxide
    } else {
        install ripgrep
        install fd
        install nvim
        install zoxide
        install go
    }
    install carapace
    install oh-my-posh
}

export def windows_dependencies [] {
    [ 
        ripgrep,
        fd,
        versions/neovim-nightly,
        oh-my-posh,
        zoxide,
        extras/carapace,
        go,

    ]
    | each { |name|
        scoop install $name
    }
}

def install_release [ repo: string, selector: string, unpack: closure, install: closure] {
    let headers = []
    let temp = mktemp -d "dotfiles.XXXXX"
    do {
        cd $temp
        let tar_file = "download"
        let release = http get --headers $headers $"https://api.github.com/repos/($repo)/releases/latest"
        let release_id = $"($release.id)"
        let installed_version = version get_version $repo
        if (($installed_version | is-empty) or ($installed_version != $release_id)) {
            print $"Installing ($repo) version ($release_id)"
            $release.assets
            | where name =~ $selector
            | first
            | http get --headers $headers $in.url
            | http get --headers $headers $in.browser_download_url
            | save "download"
            do $unpack ($tar_file)
            do $install
            version put $repo $"($release_id)"
        } else {
            print $"($repo) already up to date"
        }
    }
    rm -r $temp
}

def "install ripgrep" [] {
    let repo = "BurntSushi/ripgrep"
    let selector =  "x86_64-unknown-linux-musl.tar.gz$"
    let unpack = { |file| tar xzf $file }
    let install = { || mv ripgrep*/rg ~/.local/bin/rg }
    install_release $repo $selector $unpack $install
}

def "install fd" [] {
    let repo = "sharkdp/fd"
    let selector =  "x86_64-unknown-linux-gnu.tar.gz$"
    let unpack = { |file| tar xzf $file }
    let install = { || mv fd*/fd ~/.local/bin/fd }
    install_release $repo $selector $unpack $install
}

def "install nvim" [] {
    if (which nvim | is-empty) {
        mut sudo = if ((whoami) != root) { "sudo " } else { "" }
        $'($sudo) add-apt-repository -y ppa:neovim-ppa/unstable
        ($sudo) apt-get install -y neovim build-essential' | bash
        log installed neovim
    } else {
        log already_installed neovim
    }
}

def "install oh-my-posh" [] {
    if (which oh-my-posh | is-empty) {
        if ((get_os) == "cachyos") {
            paru --noconfirm -S unzip
        } else {
            mut sudo = if ((whoami) != root) { "sudo " } else { "" }
            $"($sudo) apt-get install -y unzip" | bash
        }
        curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
        log installed oh-my-posh
    } else {
        log already_installed oh-my-posh
    }
}

def "install go" [] {
    if (which go | is-empty) {
        let temp = mktemp -d "dotfiles.XXXXX"
        let tar = $"($temp)/go.tar.gz"
        http get https://go.dev/dl/go1.24.5.linux-amd64.tar.gz
        | save $tar
        tar -C ~/.local -xzf $tar
        rm -r $temp
        log installed go
    } else {
        log already_installed go
    }
}

def "install zoxide" [] {
    http get https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
}

def "install carapace" [] {
    let repo = "carapace-sh/carapace-bin"
    let selector =  "linux_amd64.tar.gz"
    let unpack = { |file| tar xzf $file }
    let install = { || mv carapace ~/.local/bin/carapace }
    install_release $repo $selector $unpack $install
}

def "log already_installed" [ name: string ] {
    print $"($name) is already installed"
}

def "log up_to_date" [ name: string ] {
    print $"($name) is up to date"
}

def "log installed" [ name: string ] {
    print $"($name) was installed"
}

def "log updated" [ name: string ] {
    print $"($name) was updated"
}
