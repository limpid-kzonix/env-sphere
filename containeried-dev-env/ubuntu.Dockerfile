FROM ubuntu:kinetic

RUN apt-get update && apt-get install -y locales \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt update -y && apt upgrade -y && apt install git curl wget -y
RUN apt-get install dialog apt-utils -y

RUN DEBIAN_FRONTEND=noninteractive apt -y install \
	clang \
	gcc \
	g++ \
	meson \
	jq \
	llvm \
	python3-pip \
	python3-setuptools \
	cmake \
	make \
	libssl-dev \
	libxml2-dev \
	libyaml-dev \
	libgmp-dev \
	libreadline-dev \
	libz-dev \
    flex \
    bison \
    gperf \
    cmake \
    ninja-build \
    libffi-dev \
    libssl-dev \
    xclip \
    julia

RUN apt -y autoclean
RUN apt -y clean
RUN apt -y autoremove




# Install NodeJS and tools
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN bash -c 'source $HOME/.nvm/nvm.sh   && \
    nvm install node                    && \
    npm install -g doctoc urchin eclint dockerfile_lint neovim && \
    npm install --prefix "$HOME/.nvm/"'


# Install Python 3 environment and packages
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/.miniconda
RUN rm ~/miniconda.sh
RUN echo '\neval "$($HOME/.miniconda/bin/conda shell.bash hook)"\n' >> $HOME/.bashrc
RUN eval "$($HOME/.miniconda/bin/conda shell.bash hook)" && pip install neovim

# Install and configure Neovim
COPY ./nvim /root/.config/nvim
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

RUN apt update -y && apt upgrade -y && apt install neovim -y
RUN vim +PlugInstall +qall
RUN vim +PlugUpdate +qall
RUN vim +PlugUpgrade +qall
RUN vim +CocInstall +qall

ENV DEVDIR='/dev-volume'
WORKDIR ${DEVDIR}
