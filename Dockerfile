FROM ubuntu:jammy as base

# Let scripts know we're running in Docker (useful for containerised development)
ENV RUNNING_IN_DOCKER true

RUN set -xe \
   && apt-get update \
   && apt-get install -y apt-utils tzdata locales

ENV TZ=Europe/Sofia
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
   && echo $TZ > /etc/timezone

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
   locale-gen

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



FROM base as devenv

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
RUN cd usr/local/share/fonts && curl -fLo "Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
RUN cd usr/local/share/fonts && curl -fLo "Hack Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack/Bold/complete
RUN fc-cache -fv

# ---- Install Neovim
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get update && apt-get install -y neovim

ENV \
   SHELL="/bin/zsh" \
   USER_HOME=/home/${USER_ACCOUNT} \
   WORKSPACE="$USER_HOME/workspace" \
   SSH_DIR="$USER_HOME/.ssh"

# ---- Use the unprivileged user for safety
RUN useradd -s ${SHELL} -d ${USER_HOME} -m -G sudo ${USER_ACCOUNT} && echo "${USER_ACCOUNT}:${PASSWORD}" | chpasswd

USER ${USER_ACCOUNT}
WORKDIR ${USER_HOME}

# ---- Install NVM and setup node versions
RUN mkdir .nvm
ENV NODE_VERSION=18.3.0
ENV NVM_DIR=${USER_HOME}/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="${NVM_DIR}/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

# ---- Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# ---- Setup Zsh configs
COPY ./zsh ./zsh
RUN zsh ./zsh/setup.zsh 

COPY ./.gitconfig ./.gitconfig

USER root
RUN rm -rf ./zsh
RUN chown -R ${USER_ACCOUNT}:${USER_ACCOUNT} ./
USER ${USER_ACCOUNT}

VOLUME /home ${SSH_DIR} ${WORKSPACE}

# COPY docker-entrypoint.sh /usr/local/bin/
# ENTRYPOINT ["docker-entrypoint.sh"]

ENTRYPOINT [ "/bin/zsh" ]
