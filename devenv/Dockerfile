FROM ubuntu:jammy as build

# Let scripts know we're running in Docker (useful for containerised development)
ENV RUNNING_IN_DOCKER true

RUN set -xe \
   && apt-get update \
   && apt-get install -y apt-utils tzdata locales

ENV TZ=Europe/Sofia
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
   && echo $TZ > /etc/timezone

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
   && locale-gen

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

# # Unminimize
# RUN yes | unminimize

RUN set -xe \
   && apt-get install -y wget tar man manpages-posix sudo netstat-nat net-tools curl w3m software-properties-common \
   build-essential \
   coreutils\
   libtool \
   libtool-bin \
   libnss-sss \
   libpcre3-dev \
   zip \
   unzip 



FROM build as devenv

ARG USER_ACCOUNT=auratiger
ARG PASSWORD=root

# Expose some ports to host by default.
EXPOSE 8080 3000 8000 9000 5000

# Install dependencies
RUN set -xe && apt-get update && apt-get -y upgrade && apt-get install -y \
   exa \
   xclip \
   tree \
   fzf \
   neofetch \
   python3 \
   python3-dev \ 
   python3-pip \
   make \
   cmake \
   automake \
   git \ 
   tmux \ 
   vim \
   zsh \
   ripgrep \
   perl \
   less \
   fonts-powerline

# Install Nerd Fonts
RUN curl --create-dirs -O --output-dir /usr/local/share/fonts -fLo "Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
RUN curl --create-dirs -O --output-dir /usr/local/share/fonts -fLo "Hack Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack/Bold/complete
RUN fc-cache -fv

# ---- Install Neovim
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get update \
   && apt-get install -y neovim

ENV \
   SHELL="/bin/zsh" \
   HOME=/home/${USER_ACCOUNT} \
   WORKSPACE="$HOME/workspace" \
   SSH_DIR="$HOME/.ssh"

# ---- Use the unprivileged user for safety
RUN useradd -s ${SHELL} -d ${HOME} -m -G sudo ${USER_ACCOUNT} && echo "${USER_ACCOUNT}:${PASSWORD}" | chpasswd
RUN chown -R ${USER_ACCOUNT}:${USER_ACCOUNT} ${HOME}/

USER ${USER_ACCOUNT}
WORKDIR ${HOME}

# ---- Install NVM and setup node versions
ENV \
   NODE_VERSION=18.3.0 \
   NVM_DIR=${HOME}/.nvm
RUN mkdir -p .nvm \ 
   && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="${NVM_DIR}/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

# ---- Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="${HOME}/.cargo/bin:${PATH}"

# ---- Install LunarVim
# RUN curl -s -o- https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh | bash -s -- -y

# ---- Setup dotfiles
# ARG TEMP_DIR=${HOME}/tempDots
# COPY --chown=${USER_ACCOUNT} . ${TEMP_DIR}
# RUN zsh ${TEMP_DIR}/setup_docker_env.zsh && rm -rf ${TEMP_DIR}

RUN git clone --bare https://github.com/auratiger/dotfiles.git $HOME/.dotfiles \
   # && git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status.showUntrackedFiles no \
   && git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME reset --hard HEAD

# Connect your SSH keys directory
VOLUME ${SSH_DIR}
# Optional workspace directory
VOLUME ${WORKSPACE}

ENTRYPOINT [ "/bin/zsh" ]
