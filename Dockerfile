FROM ubuntu

ARG USERNAME=jonnyb
ARG USER_UID=1001
ARG USER_GID=$USER_UID

RUN apt-get update && \
    apt-get install -y unminimize curl sudo software-properties-common && \
    yes | unminimize && \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER jonnyb:jonnyb
WORKDIR /home/$USERNAME

RUN curl -o- -s https://codeberg.org/JonnyB/dotfiles/raw/branch/main/setup/install.sh | bash && \
    nvim --headless +qa

CMD [ "/usr/bin/nu" ]
