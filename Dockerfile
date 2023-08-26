FROM ubuntu:latest

RUN apt update; \
    apt install -y curl zsh git gettext;

WORKDIR /dotfiles
COPY . /dotfiles
RUN sh -c "$(curl -fsLS https://joniator.github.io/dotfiles/install.sh)" --mode=local;

CMD zsh
