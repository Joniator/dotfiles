#! /usr/bin/env nu

let commit = git rev-parse HEAD

docker build -t "joniator/dotfiles:latest" .
print "Tagging"
docker tag "joniator/dotfiles:latest" $"joniator/dotfiles:($commit)"

[
    "joniator/dotfiles:latest",
    $"joniator/dotfiles:($commit)"
]
| each { |tag| print $"Pushing ($tag)"; docker push $tag }

