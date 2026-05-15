#!/usr/bin/env nu
# Run dotfiles installation tests using Docker.
# Each test builds an image and runs sanity.sh inside it.

const SANITY = "build/test/sanity.sh"

const CASES = [
    { name: "local-cachyos", dockerfile: "Dockerfile",              context: "."          },
    { name: "local-ubuntu",  dockerfile: "Dockerfile.ubuntu",       context: "."          },
    { name: "curl-ubuntu",   dockerfile: "build/test/Dockerfile.curl", context: "build/test" },
]

def run_case [c: record] {
    let tag = $"dotfiles-test-($c.name)"

    print $"\n── ($c.name) ──────────────────────────────"
    print $"   Building ($c.dockerfile)..."
    ^docker build -t $tag -f $c.dockerfile $c.context

    print $"   Running sanity checks..."
    ^docker run --rm -v $"(pwd)/($SANITY):/sanity.sh:ro" $tag bash /sanity.sh
}

def main [] {
    mut failures = []

    for c in $CASES {
        try {
            run_case $c
        } catch { |err|
            print $"  ✗ ($c.name) FAILED: ($err.msg)"
            $failures = $failures | append $c.name
        }
    }

    print $"\n══════════════════════════════════════════"
    print $"  ($CASES | length) scenarios, ($failures | length) failed"

    if ($failures | is-not-empty) {
        print $"  Failed: ($failures | str join ', ')"
        exit 1
    }
}
