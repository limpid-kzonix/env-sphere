FROM alpine:3.20.2 AS base

ARG STACK_RESOLVER=lts

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
    ncurses-dev \
    perl \
    tar \
    xz \
    zlib-dev \
    zsh
RUN addgroup -g $USER_GID $USERNAME

RUN adduser -D -u $USER_UID -G $USERNAME -s /bin/bash $USERNAME

USER ${USER_UID}:${USER_GID}

WORKDIR /home/${USERNAME}

ENV PATH="/home/${USERNAME}/.local/bin:/home/${USERNAME}/.cabal/bin:/home/${USERNAME}/.ghcup/bin:$PATH"

RUN echo "export PATH=${PATH}" >> /home/${USERNAME}/.profile

ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
    BOOTSTRAP_HASKELL_MINIMAL=1

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
RUN bash -c "source ~/.ghcup/env" && \
    ghcup install ghc --set recommended && \
    ghcup install cabal --set recommended && \
    ghcup install stack --set recommended && \
    ghcup install hls --set recommended

RUN ((stack ghc -- --version 2>/dev/null) || true) && \
    stack config --system-ghc set system-ghc true --global && \
    stack config --system-ghc set install-ghc false --global && \
    stack config --system-ghc set resolver ${STACK_RESOLVER}

RUN cabal update && cabal new-install cabal-install

RUN cabal install --haddock-hoogle --minimize-conflict-set \
    stylish-haskell \
    haskell-dap \
    ghci-dap \
    haskell-debug-adapter \
    hlint \
    hoogle \
    retrie


RUN hoogle generate --download --haskell


ENTRYPOINT ["/bin/bash"]