# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# https://linuxhint.com/configure-use-aliases-zsh/

# >>>> ============ ALIASES ==================================================== <<<< #

# >> ------------ SUFFIX ------------ << #
# With suffix aliases, you can launch files with a specific extension (or suffix) in your favorite tool.
alias -s {png,jpg,avif,jpeg,pdf,svg}=display
alias -s {ts,tsx,js,jsx,json,env,m,html,css,scss,zsh,sh,py,toml,java}=vi
alias -s {mp3,mp4,mov,avi,wav,mpeg,mpg}=vi
alias -s git="git clone"

# >> ------------ EDITORS ------------ << #
alias v="${EDITOR}"
alias vi="${EDITOR}"

# >> ------------ CONFIGS ------------ << #
alias zshreset="exec zsh"
alias zshconfig="$EDITOR $ZDOTDIR/.zshrc"
alias aliconfig="$EDITOR $ZDOTDIR/.zsh-aliases.zsh"
alias gitconfig="$EDITOR ~/.gitconfig"
alias ideavimconfig="$EDITOR ~/.ideavimrc"
# alias mxconfig="$EDITOR ~/.tmux.conf"
alias mxconfig="$EDITOR ~/.config/tmux/tmux.conf"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

alias aweres="echo 'awesome.restart()' | awesome-client"

alias golunar="cd ~/.local/share/lunarvim/lvim"
alias golvim="cd ~/.config/lvim"
alias gozsh="cd $ZDOTDIR"

# >> ------------ COMMAND LINE ------------ << #
# alias ll='ls -alFG'
# alias la='ls -a'
# alias l='ls -CF'

alias g='git'
alias gs="git status"
# inspired from this blog post: https://www.atlassian.com/git/tutorials/dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias ls='exa'                                   # ls
alias l='exa -lbF'                         # list, size, type, git
alias ll='exa -lbFa'                       # long list
alias lf='exa -lbFa --group-directories-first'
alias llm='exa -lbGb --sort=modified'      # long list, modified date sort
alias la='exa -lbhHigUmuSa --color-scale'  # all list
alias lx='exa -lbhHigUmuSa@ --color-scale' # all + extended list
alias lt='exa -lbFa --tree --level=2'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Better directory navigation
alias cd='change_dir(){ cd $1 && exa }; change_dir'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cd..='cd ..'

alias cl="clear"

alias cp="cp -iv"
alias cpr='cp -rv'
alias mv="mv -iv"
alias rm="rm -v"
alias rmf="rm -vrf"
alias mkdir="mkdir -pv"
alias ex="exit"

alias -g ,1='2>&1'
# Redirects the error output to dev/null
alias -g ,2='2>/dev/null'

alias -g L='| less'
alias -g gr='| grep'
alias -g yes='y |'
alias -g and='&&'
alias -g or='||'

# >> ------------ MISC ------------ << #

# --- Languages ---

# gives you layouts (~100 on modern systems)
alias lang-layout=localectl list-x11-keymap-layouts 

# gives you variants for this layout (or all variants if no layout specified, ~300 on modern systems)
alias lang-variant=localectl list-x11-keymap-variants de 

# gives you all layout switching options
alias lang-options="localectl list-x11-keymap-options | grep grp:"

alias set-lang="setxkbmap -option grp:switch,grp_led:scroll,grp:ctrl_alt_toggle -layout us,bg -variant ,phonetic"

# ---------------------

relative_dir() { # returns the current dirrectory relative from where it is called. Used for scripts.
   cd "$(dirname "$0")" && pwd
}

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


# >> ------------ IMAGES ------------ << #

ico() {
   convert $1 x:
}

alias ide="identify"

iconv() {
   convert $1 -resize $2\! -quality 75 -define webp:lossless=true $3
}

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

alias dev="npm run dev"
alias serve="npm run serve"
alias build="npm run build"
alias book="npm run storybook"

alias yai="yarn install"
alias yau="yarn upgrade --latest"
alias yaui="yarn upgrade-interactive --latest"
alias ydev="yarn run dev"
alias yserve="yarn run serve"
alias ybuild="yarn run build"
alias ybook="yarn run storybook"

alias rmn="rm -rf ./node_modules ./node"
alias rmns="rm -rf ./node_modules ./node yarn.lock package-lock.json && yarn install"
alias rmnsf="rm -rf ./node_modules ./node yarn.lock package-lock.json && yarn install -f"

alias ginit="npm init gatsby"
alias gcl="gatsby clean"
alias gbuild="gatsby build"
alias gdev="gatsby develop"
alias gser="gatsby serve"
alias gres="gatsby clean && gatsby develop"

helpweb() {
   cat "$ZDOTDIR/alias-help/web.txt"
}

alias dDrop="mongo < ~/Project/dropDb.js"

# >> ------------ DOCKER ------------ << #

# Container commands
alias dc="docker container"
alias dcs="docker container stats"
alias dcx="docker container exec -it"  # Quickly run the docker exec command like this: 'dex container-name bash'

dcb() { # execute container in bash
    docker container exec -it $1 bash
}

# Image commands
alias di="docker image"
# alias dirm="docker rmi -f $(docker images -f dangling=true -q)"

# Network commands
alias dn="docker network"

# Volumes
alias dv="docker volume"
alias dvp="docker volume prune"

alias dfp="docker system prune --all"

dl() {
   docker logs -f $1
}

dins() { # inspect container with less command
   docker inspect $1 | less
}

# This command is a neat shell pipeline to stop all running containers no matter
# where you are and without knowing any container names
alias dsa="docker ps -q | awk '{print $1}' | xargs -o docker stop"


alias dm="docker compose"
alias dmu="docker compose up -d" # Start the docker-compose stack in the current directory
alias dmb="docker compose up -d --build" # Start the docker-compose stack in the current directory and rebuild the images

# Stop, delete (down) or restart the docker-compose stack in the current directory
alias dmc="docker compose stop"
alias dmd="docker compose down"
alias dmr="docker compose restart"

# Show the logs for the docker-compose stack in the current directory
# May be extended with the service name to get service-specific logs, like
# 'dcl php' to get the logs of the php container
alias dml="docker compose logs"

# >>>> ============ VERSIONS SCRIPT ==================================================== <<<< #

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

   typeset -A application_version_map=(
       [NPM]="npm --version"
       [YARN]="yarn -v"
       [NODE]="node --version"
       [MAVEN]="mvn --version"
       [GRADLE]="gradle -v"
       [PYTHON]="python3 --version"
       [TMUX]="tmux -V"
       [ZSH]="zsh --version"
       [BASH]="bash --version"
       [RUBY]="ruby --version"
       [LUA]="lua -v"
   )

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
      alias pacsyu='sudo pacman -Syu'                             # update only standard pkgs
      alias pacsyyu='sudo pacman -Syyu'                           # Refresh pkglist & update standard pkgs
      alias update='sudo pacman -Syyu && sudo pamac update -a'    # Refresh pkglist & update standard pkgs

      alias pc=pamac
      alias psearch=pamac search
      alias pinfo=pamac info

      alias yaysua='yay -Sua --noconfirm'                         # update only AUR pkgs (yay)
      alias yaysyu='yay -Syu --noconfirm'                         # update standard pkgs and AUR pkgs (yay)
      alias parsua='paru -Sua --noconfirm'                        # update only AUR pkgs (paru)
      alias parsyu='paru -Syu --noconfirm'                        # update standard pkgs and AUR pkgs (paru)
      alias unlock='sudo rm /var/lib/pacman/db.lck'               # remove pacman lock
      alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'            # remove orphaned packages

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

