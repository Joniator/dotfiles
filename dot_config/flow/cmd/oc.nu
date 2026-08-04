# flow oc <cmd> — OpenShift helpers.

use ~/.config/flow/lib/ui.nu
use ~/.config/flow/lib/util.nu

# Switch project. If no name is provided, fuzzy-pick from `oc get projects`.
export def project [name?: string] {
    util require oc
    let target = if ($name | is-not-empty) {
        $name
    } else {
        oc get projects -o name
        | lines
        | each { |n| $n | str replace "project.project.openshift.io/" "" }
        | ui pick "Switch project"
    }
    if ($target | is-empty) { return }
    oc project $target
    ui success $"project → ($target)"
}

# Browse pods in the current project as a styled table.
export def pods [] {
    util require oc
    oc get pods -o json
    | from json
    | get items
    | select metadata.name status.phase spec.nodeName
    | rename name phase node
}
