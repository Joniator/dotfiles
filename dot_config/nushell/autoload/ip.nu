def ipinfo [] {
    http get --headers [ ACCEPT application/json ] ipinfo.io | get ip
}

def windows-boot [] {
}
