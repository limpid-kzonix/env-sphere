FROM elixir:1.17-alpine

ENV LANG=C.UTF-8

ENV USERNAME=vscode \
    USER_UID=1000 \
    USER_GID=1000

RUN ulimit -n 8192

RUN apk update && apk add --no-cache \
    openssl3 openssl-dev \
    unixodbc unixodbc-dev \
    lksctp-tools \
    lksctp-tools-dev \
    ca-certificates \
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
    libgcc \
    libstdc++ \
    gcc \
    g++ \
    gmp-dev \
    libc-dev \
    libffi-dev \
    make \
    musl \
    musl-dev \
    ncurses \
    ncurses-dev \
    ncurses-libs \
    ncurses-terminfo \
    ncurses-terminfo-base \
    perl \
    tar \
    xz \
    zlib \
    zlib-dev \
    lazygit \
    zsh \
    dpkg-dev dpkg \
    linux-headers \
    autoconf \
    tar

RUN addgroup -g $USER_GID $USERNAME

RUN adduser -D -u $USER_UID -G $USERNAME -s /bin/bash $USERNAME

COPY ./../base/.zshrc /home/${USERNAME}/.zshrc
RUN chown -R $USERNAME:$USERNAME /home/${USERNAME}/.zshrc

RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" --unattended --yes

USER ${USER_UID}:${USER_GID}

WORKDIR /home/${USERNAME}

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended --yes

RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/${USERNAME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions /home/${USERNAME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-history-substring-search /home/${USERNAME}/.oh-my-zsh/custom/plugins/zsh-history-substring-search


SHELL ["/bin/zsh", "-c"]

 