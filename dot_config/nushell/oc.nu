def "nu-complete-oc-services" [context: string] {
    oc get service -o name | lines
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
    oc port-forward $service $portArg
}

