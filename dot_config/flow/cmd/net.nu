# flow net <cmd> — network utilities.

use ~/.config/flow/lib/ui.nu

# Print the public IP address (via ipinfo.io).
export def ip [] {
    http get --headers [ ACCEPT application/json ] https://ipinfo.io | get ip
}
