FROM cachyos/cachyos

ARG USERNAME=jonnyb
ARG USER_UID=1001
ARG USER_GID=$USER_UID
ARG GITHUB_TOKEN

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER jonnyb:jonnyb
WORKDIR /home/$USERNAME

COPY --chown=1001:1001 . /tmp/dotfiles

RUN /tmp/dotfiles/setup/install.sh && \
    rm -r /tmp/dotfiles 

CMD [ "/usr/bin/nu" ]
