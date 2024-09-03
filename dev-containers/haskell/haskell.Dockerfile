FROM worxbend/base-dev-container:latest AS base

ARG STACK_RESOLVER=lts-22.33 \
    GHC_VERSION=9.6.6

ENV USERNAME=vscode \
    USER_UID=1000 \
    USER_GID=1000  \
    GHC_VERSION=${GHC_VERSION} \
    STACK_RESOLVER=${STACK_RESOLVER}

USER ${USER_UID}:${USER_GID}

WORKDIR /home/${USERNAME}

ENV PATH="/home/${USERNAME}/.local/bin:/home/${USERNAME}/.ghcup/bin:$PATH:/home/${USERNAME}/.cabal/bin"

RUN echo "export PATH=${PATH}" >> /home/${USERNAME}/.profile && \
    echo "source ~/.ghcup/env" >> /home/${USERNAME}/.bashrc && \
    echo "source ~/.ghcup/env" >> /home/${USERNAME}/.profile

SHELL ["/bin/zsh", "-c"]

ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
    BOOTSTRAP_HASKELL_MINIMAL=1

RUN mkdir -p /home/${USERNAME}/.stack/global-project && echo "resolver: ${STACK_RESOLVER}" > /home/${USERNAME}/.stack/global-project/stack.yaml

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh --unattended --yes

RUN bash -c "source ~/.ghcup/env" && \
    ghcup install ghc --set ${GHC_VERSION} && \
    ghcup install cabal --set latest && \
    ghcup install stack --set latest && \
    ghcup install hls --set latest

RUN ((stack ghc -- --version 2>/dev/null) || true) && \
    stack config --system-ghc set system-ghc true --global && \
    stack config --system-ghc set install-ghc false --global && \
    stack config --system-ghc set resolver ${STACK_RESOLVER}

RUN cabal update && cabal new-install cabal-install

RUN cabal install --haddock-hoogle --minimize-conflict-set \
    stylish-haskell \
    haskell-dap \
    haskell-debug-adapter \
    hlint \
    hoogle \
    ormolu

RUN hoogle generate --download --haskell

RUN mkdir -p /home/${USERNAME}/haskell-project

WORKDIR /home/${USERNAME}/haskell-project

ENTRYPOINT ["/bin/zsh"]
