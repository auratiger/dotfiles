# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# https://linuxhint.com/configure-use-aliases-zsh/

# >>>> ============ ALIASES ==================================================== <<<< #

# >> ------------ EDITORS ------------ << #
alias v="lvim"
alias vi="lvim"
alias vim="lvim"
alias c="code"

# >> ------------ CONFIGS ------------ << #
alias zshreset="exec zsh"
alias zshconfig="lvim ~/.zshrc"
alias aliconfig="lvim ~/.oh-my-zsh/custom/aliases.zsh"
alias gitconfig="lvim ~/.gitconfig"
alias ideavimconfig="lvim ~/.ideavimrc"
alias mxconfig="lvim ~/.tmux.conf"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# >> ------------ COMMAND LINE ------------ << #
# alias ll='ls -alFG'
# alias la='ls -a'
# alias l='ls -CF'

alias ls='exa'                                   # ls
alias l='exa -lbF --git'                         # list, size, type, git
alias ll='exa -lbFa --git'                       # long list
alias llm='exa -lbGb --git --sort=modified'      # long list, modified date sort
alias la='exa -lbhHigUmuSa --git --color-scale'  # all list
alias lx='exa -lbhHigUmuSa@ --git --color-scale' # all + extended list
alias lt='exa -lbFa --tree --level=2'

alias cd='change_dir(){ cd $1 && exa }; change_dir'
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'

alias cl="clear"

alias cp="cp -iv"
alias cpr='cp -r'
alias mv="mv -iv"
alias rm="rm -v"
alias rmf="rm -vrf"
alias mkdir="mkdir -pv"
alias ex="exit"

alias -g L='| less'
alias -g gr='| grep'

# >> ------------ MISC ------------ << #

#   prints size of file
alias grepK="du -h | grep -E '([0-9]+\.[0-9]+K)|([0-9]+K)'"
alias grepM="du -h | grep -E '[0-9]+\.[0-9]+M|[0-9]+M'"
alias grepG="du -h | grep -E '[0-9]+\.[0-9]+G|[0-9]+G'"

# finds process running on specified port
alias port='find_port(){ lsof -i tcp:"$@"; }; find_port'

alias runDb="psql -U admin -d postgres -f ~/Downloads/postgres_2021-04-19_1001.sql"

# Config and images for neofetch are located in ~/.config/neofetch/
alias neofetch="neofetch --source ~/.config/neofetch/neofetch_ascii/merlin.txt"

# >> ------------ TMUX ------------ << #
alias mx="tmux"
alias mxl="tmux list-sessions"

alias mxkill="tmux kill-session -t"
alias mxkall="tmux kill-session -a"
alias mxkt="tmux kill-session -a -t"

alias mxnew="tmux new -s"

# >> ------------ WORKFLOW ------------ << #
alias mci="mvn clean install"
alias depResolve="mvn dependency:resolve"

alias serve="npm run serve"
alias build="npm run build"
alias nress="rm -rf ./node_modules ./node && npm i"
alias nressf="rm -rf ./node_modules ./node && npm i -f"

# delete later
alias migrationVPN="sshuttle --dns --to-ns=192.168.0.253 -r root@10.105.25.14 192.168.0.0/16"
alias vpn="sshuttle --dns --to-ns=192.168.0.253 -r root@10.26.220.75 192.168.0.0/16"
alias vpp="sshuttle --dns --to-ns=192.168.0.253 -r root@10.105.25.10 192.168.0.0/16"

alias dDrop="mongo < ~/Project/dropDb.js"

# >> ------------ DOCKER ------------ << #

function __docker-show-logs {
	docker logs -f $1
}

function __docker-inspect-container {
	docker inspect $1 | less
}

function __docker-exec-bash {
    docker container exec -it $1 bash
}

# Container commands
alias dc="docker container"
alias dcs="docker container stats"
alias dcx="docker container exec -it"  # Quickly run the docker exec command like this: 'dex container-name bash'
alias dcb=__docker-exec-bash

# Image commands
alias di="docker image"

# Network commands
alias dn="docker network"

# Volumes
alias dv="docker volume"

alias dfp="docker system prune --all"
alias dl=__docker-show-logs
alias dins=__docker-inspect-container

# This command is a neat shell pipeline to stop all running containers no matter
# where you are and without knowing any container names
alias dsa="docker ps -q | awk '{print $1}' | xargs -o docker stop"

# Start the docker-compose stack in the current directory
# alias dcu="docker-compose up -d"

# Start the docker-compose stack in the current directory and rebuild the images
# alias dcub="docker-compose up -d --build"

# Stop, delete (down) or restart the docker-compose stack in the current directory
# alias dcs="docker-compose stop"
# alias dcd="docker-compose down"
# alias dcr="docker-compose restart"

# Show the logs for the docker-compose stack in the current directory
# May be extended with the service name to get service-specific logs, like
# 'dcl php' to get the logs of the php container
# alias dcl="docker-compose logs"

# >>>> ============ VERSIONS SCRIPT ==================================================== <<<< #

typeset -A application_version_map=(
    [NPM]="npm --version"
    [NODE]="node --version"
    [MAVEN]="mvn --version"
    [PYTHON]="python3 --version"
    [TMUX]="tmux -V"
    [ZSH]="zsh --version"
    [BASH]="bash --version"
    [RUBY]="ruby --version"
    [LUA]="lua -v"
)

function __print_versions {
    local RED_BOLD=$fg_bold[red]
    local YELLOW=$fg[yellow]

    function __print_colored_function_output() {
        echo $1 "$( bash <<EOF
            eval $2
EOF
        )" $reset_color
    }

    function __print_title() {
        echo  "[ ====================== $RED_BOLD $1 $reset_color ====================== ] \n"
    }


    for key val in "${(@kv)application_version_map}"; do
        __print_title $key
        __print_colored_function_output $YELLOW $val
        echo
    done
}

alias versions=__print_versions


