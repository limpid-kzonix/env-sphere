FROM alpine:3.20.2 AS base

ENV LANG=C.UTF-8

ENV USERNAME=vscode \
    USER_UID=1000 \
    USER_GID=1000

RUN ulimit -n 8192

RUN apk update && apk add --no-cache \
    build-base \
    llvm \
    clang \
    lld \
    git \
    bash \
    alpine-sdk \
    curl \
    binutils-gold \
    curl \
    gcc \
    g++ \
    gmp-dev \
    libc-dev \
    libffi-dev \
    make \
    musl-dev \
    ncurses \
    ncurses-dev \
    ncurses-libs \
    ncurses-terminfo \
    ncurses-terminfo-base \
    perl \
    tar \
    xz \
    zlib-dev \
    lazygit \
    zsh

RUN addgroup -g $USER_GID $USERNAME

RUN adduser -D -u $USER_UID -G $USERNAME -s /bin/bash $USERNAME

COPY .zshrc /home/${USERNAME}/.zshrc
RUN chown -R $USERNAME:$USERNAME /home/${USERNAME}/.zshrc

RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" --unattended --yes

USER ${USER_UID}:${USER_GID}

WORKDIR /home/${USERNAME}

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended --yes

RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/${USERNAME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions /home/${USERNAME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-history-substring-search /home/${USERNAME}/.oh-my-zsh/custom/plugins/zsh-history-substring-search


SHELL ["/bin/zsh", "-c"]

ENTRYPOINT ["/bin/zsh"]