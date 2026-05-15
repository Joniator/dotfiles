#!/usr/bin/env nu
# Run dotfiles installation tests using Docker.
# Each test builds an image and runs sanity.sh inside it.

const SANITY = "build/test/sanity.sh"

const CASES = [
    { name: "local-cachyos", dockerfile: "Dockerfile",                context: "."           },
    { name: "local-ubuntu",  dockerfile: "Dockerfile.ubuntu",         context: "."           },
    { name: "curl-ubuntu",   dockerfile: "build/test/Dockerfile.curl", context: "build/test" },
]

def main [] {
    let results = $CASES | each { |c|
        let tag = $"dotfiles-test-($c.name)"
        print $"\n── ($c.name) ──────────────────────────────"
        print $"   Building ($c.dockerfile)..."
        let build = (^docker build -t $tag -f $c.dockerfile $c.context | complete)
        if $build.exit_code != 0 {
            print $"  ✗ ($c.name) build FAILED"
            { name: $c.name, ok: false }
        } else {
            print $"   Running sanity checks..."
            let run = (^docker run --rm -v $"(pwd)/($SANITY):/sanity.sh:ro" $tag bash /sanity.sh | complete)
            let ok = $run.exit_code == 0
            if not $ok { print $"  ✗ ($c.name) sanity FAILED" }
            { name: $c.name, ok: $ok }
        }
    }

    let failures = $results | where { |r| not $r.ok } | get name

    print $"\n══════════════════════════════════════════"
    print $"  ($CASES | length) scenarios, ($failures | length) failed"

    if ($failures | is-not-empty) {
        print $"  Failed: ($failures | str join ', ')"
        exit 1
    }
}
