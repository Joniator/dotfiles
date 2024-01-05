FROM ubuntu:latest

RUN apt update; \
    apt install -y curl zsh git gettext zip unzip;

WORKDIR /dotfiles
COPY . /dotfiles
RUN sh -c "./install.sh --mode=local";

CMD zsh
