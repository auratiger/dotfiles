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
alias zshconfig="lvim $ZDOTDIR/.zshrc"
alias aliconfig="lvim $ZDOTDIR/.zsh-aliases.zsh"
alias gitconfig="lvim ~/.gitconfig"
alias ideavimconfig="lvim ~/.ideavimrc"
# alias mxconfig="lvim ~/.tmux.conf"
alias mxconfig="lvim ~/.config/tmux/tmux.conf"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias golunar="cd ~/.local/share/lunarvim/lvim"
alias golvim="cd ~/.config/lvim"
alias gozsh="cd $ZDOTDIR"

# >> ------------ COMMAND LINE ------------ << #
# alias ll='ls -alFG'
# alias la='ls -a'
# alias l='ls -CF'

alias g='git'

alias ls='exa'                                   # ls
alias l='exa -lbF --git'                         # list, size, type, git
alias ll='exa -lbFa --git'                       # long list
alias llm='exa -lbGb --git --sort=modified'      # long list, modified date sort
alias la='exa -lbhHigUmuSa --git --color-scale'  # all list
alias lx='exa -lbhHigUmuSa@ --git --color-scale' # all + extended list
alias lt='exa -lbFa --tree --level=2'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Better directory navigation
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
alias -g and='&&'
alias -g or='||'

# >> ------------ MISC ------------ << #

alias dirSizeK="du -h | grep -E '([0-9]+\.[0-9]+K)|([0-9]+K)'" # Prints the sizes of all files in Kb
alias dirSizeM="du -h | grep -E '[0-9]+\.[0-9]+M|[0-9]+M'"     # Prints the sizes of all files in Mb
alias dirSizeG="du -h | grep -E '[0-9]+\.[0-9]+G|[0-9]+G'"     # Prints the sizes of all files in Gb
alias dirTotal="du -sh ."                                      # Prints the total size of all files in the directory
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Play video files in current dir by type
alias playavi='vlc *.avi'
alias playmov='vlc *.mov'
alias playmp4='vlc *.mp4'

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

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
alias rmn="rm -rf ./node_modules"
alias nress="rm -rf ./node_modules ./node && npm i"
alias nressf="rm -rf ./node_modules ./node && npm i -f"

alias gcl="gatsby clean"
alias gbuild="gatsby build"
alias gdev="gatsby develop"
alias gser="gatsby serve"
alias gres="gatsby clean && gatsby develop"

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


# >>>> ============ SCRIPTS ==================================================== <<<< #

# Functions which expects two input parameters one for the file extention to change and the second for the new extention.
# If both are not empty, replaces all files with the old file extention in the directory with the new one
function __change_file_extensions() {
   local oldExt=$1
   local newExt=$2

   if [[ -n "$oldExt" && -n "$newExt" ]]; then
      for file in *.$oldExt; do 
          mv -- "$file" "${file%.*}.$newExt"
      done
   else
      echo "No extention was specified"
   fi
}

alias extChange=__change_file_extensions


# >>>> ============ This is a switch case for handling aliases between different OS's ==================================================== <<<< #
case "$(uname -s)" in

Darwin) # Maps only for Mac distros 
	;;

Linux) # Maps only for Linux distros 

   if [[ -f "/etc/lsb-release" ]];then # Checks if using Arch distro
      # pacman and yay
      alias pac=pacman
      alias pacsyu='sudo pacman -Syu'                  # update only standard pkgs
      alias update='sudo pacman -Syyu'                 # Refresh pkglist & update standard pkgs
      alias pacsyyu='sudo pacman -Syyu'                # Refresh pkglist & update standard pkgs
      alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
      alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
      alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
      alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)
      alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
      alias cleanup='sudo pacman -Rns $(pacman -Qtdq)' # remove orphaned packages

   elif [[ -f "/etc/debian_version" ]]; then # Checks if using Debian distro
      echo "Hello Debian (This message is comming from $ZDOTDIR/zsh-aliases.zsh)"

   elif [[ -f "/etc/alpine-release" ]]; then # Checks if using Alpine distro
      echo "Hello Alpine (This message is comming from $ZDOTDIR/zsh-aliases.zsh)"

   elif [[ -f "/etc/centos-release" ]]; then # Checks if using Centos distro
      echo "Hello Centos (This message is comming from $ZDOTDIR/zsh-aliases.zsh)"

   elif [[ -f "/etc/fedora-release" ]]; then # Checks if using Fedora distro
      echo "Hello Fedora (This message is comming from $ZDOTDIR/zsh-aliases.zsh)"

   fi

	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*) # Maps only for Windows distros... Don't ask why I added it.
	;;

*) # Other
	;;

esac

