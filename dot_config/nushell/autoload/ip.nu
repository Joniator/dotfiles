def ipinfo [] {
    http get --headers [ ACCEPT application/json ] ipinfo.io | get ip
}

def windows-boot [] {
    systemctl reboot --boot-loader-entry=auto-windows
}
