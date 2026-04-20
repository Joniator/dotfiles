def "nu-complete-oc-services" [context: string] {
    ^oc get service -o name | lines
}

def "nu-complete-oc-projects" [context: string] {
    ^oc projects -q | lines
}

def "oc forward-service" [
    service: string@"nu-complete-oc-services",
    port: string
] {
    let portArg = if ($port | str contains ":") {
        $port
    } else {
        $"($port):($port)"
    }
    ^oc port-forward $service $portArg
}
 
def "oc project" [project?: string@"nu-complete-oc-projects"] { 
    let project = $project | default (^oc projects -q | fzf)
    ^oc project $project
}
