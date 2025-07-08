#! /usr/bin/nu

def main [] {
    use ./modules/installer.nu
    use ./modules/version.nu

    installer linux_dependencies
}

