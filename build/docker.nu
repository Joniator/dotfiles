#! /usr/bin/env nu

def commands [] {
  [ "release" ]
}

def main [command?: string@commands] {
  let commit = git rev-parse HEAD

  docker build -t "joniator/dotfiles:latest" .
  print "Tagging"
  docker tag "joniator/dotfiles:latest" $"joniator/dotfiles:($commit)"

  if ($command == "release") {
    [
      "joniator/dotfiles:latest",
      $"joniator/dotfiles:($commit)"
    ]
    | each { |tag| print $"Pushing ($tag)"; docker push $tag }
  }
}
