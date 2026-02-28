use std/dirs

$env.config.show_banner = false
$env.config.edit_mode = "vi"

let autoload_dir = ($nu.data-dir | path join 'vendor' 'autoload')
mkdir $autoload_dir

use ($nu.data-dir | path join mise.nu)

source alias.nu
source oc.nu
