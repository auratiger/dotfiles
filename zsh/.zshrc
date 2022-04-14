# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/gegeorgiev/.oh-my-zsh"


# >>>> ==================================== MY ZSH THEME =============================================== <<<< 

#########################################################################
#                                                                       #
#     Set name of the theme to load --- if set to "random", it will     #
#   load a random theme each time oh-my-zsh is loaded, in which case,   #
#    to know which specific one was loaded, run: echo $RANDOM_THEME     #
#          See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes           #
#                                                                       #
#                         ZSH_THEME="rkj-repos"                         #
#                                                                       #
#         Set list of themes to pick from when loading at random        #
#   Setting this variable when ZSH_THEME=random will cause zsh to load  #
#     a theme from this variable instead of looking in $ZSH/themes/     #
#      If set to an empty array, this variable will have no effect.     #
#                                                                       #
#       ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )       #
#                                                                       #
#########################################################################

# User, Host, Full Path, and time/date on two lines for easier vgrepping
function __hg_prompt_info {
  if (( $+commands[hg] )) && grep -q "prompt" ~/.hgrc; then
    hg prompt --angle-brackets "\
<hg:%{$fg[magenta]%}<branch>%{$reset_color%}><:%{$fg[magenta]%}<bookmark>%{$reset_color%}>\
</%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
  fi
}

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✱"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}✈"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

function __mygit() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_prompt_short_sha)$(git_prompt_status)%{$fg_bold[blue]%}$ZSH_THEME_GIT_PROMPT_SUFFIX "
  fi
}

function __retcode() {}

PROMPT=$'%{$fg_bold[blue]%}┌─[%{$fg_bold[green]%}%n%b%{$fg[black]%}@%{$fg[cyan]%}%m%{$fg_bold[blue]%}]%{$reset_color%} - %{$fg_bold[blue]%}[%{$fg_bold[default]%}%~%{$fg_bold[blue]%}]%{$reset_color%} - %{$fg_bold[blue]%}[%b%{$fg[yellow]%}'%D{"%Y-%m-%d %I:%M:%S"}%b$'%{$fg_bold[blue]%}]
%{$fg_bold[blue]%}└─[%{$fg_bold[magenta]%}%?$(__retcode)%{$fg_bold[blue]%}] <$(__mygit)$(__hg_prompt_info)>%{$reset_color%} '
RPS1='%(?..%{$fg_bold[red]%} -> exit: %? <- %{$reset_color%})' # showing the exit code of the last ran command
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

########### ZSH UPDATE SCHEDULE ####################################################
#  Uncomment the following line to disable bi-weekly auto-update checks.           #
#     DISABLE_AUTO_UPDATE="true"                                                   #
#                                                                                  #
#  Uncomment the following line to automatically update without prompting.         #
#     DISABLE_UPDATE_PROMPT="true"                                                 #
#                                                                                  #
#  Uncomment the following line to change how often to auto-update (in days).      #
#     export UPDATE_ZSH_DAYS=13                                                    #
####################################################################################

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

##### HISTORY #######################################################################
#   Uncomment the following line if you want to change the command execution time   #
#   stamp shown in the history command output.                                      #
#   You can set one of the optional three formats:                                  #
#   "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"                                          #
#   or set a custom format using the strftime function format specifications,       #
#   see 'man strftime' for details.                                                 #
#####################################################################################
HIST_STAMPS="dd.mm.yyyy"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

##### PLUGINS ########################################################################
#                                                                                    #
#   Would you like to use another custom folder than $ZSH/custom?                    #
#     ZSH_CUSTOM=/path/to/new-custom-folder                                          #
#                                                                                    #
# >> -------- PLUGINS: ---------------------------------------------------------- << #
#   zsh-syntax-highlighting - https://github.com/zsh-users/zsh-syntax-highlighting   #
#   zsh-autosuggestions - https://github.com/zsh-users/zsh-autosuggestions           #
#   zsh-vi-mode - https://github.com/jeffreytse/zsh-vi-mode                          #
#                                                                                    #
#   Which plugins would you like to load?                                            #
#     - Standard plugins can be found in $ZSH/plugins/                               #
#     - Custom plugins may be added to $ZSH_CUSTOM/plugins/                          #
#     - Example format: plugins=(rails git textmate ruby lighthouse)                 #
#                                                                                    #
#   Add wisely, as too many plugins slow down shell startup.                         #
######################################################################################
plugins=(git zsh-vi-mode zsh-autosuggestions zsh-syntax-highlighting)

VI_MODE_SET_CURSOR=true

ZSH_AUTOSUGGEST_STRATEGY=(completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

source $ZSH/oh-my-zsh.sh

# >>>> ============ EXPORTED PATHS ==================================================== <<<< #
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/openvpn/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

# For compilers to find openjdk you may need to set:
#  export CPPFLAGS="-I/usr/local/opt/openjdk/include"

# >>>> ============ USER CONFIGURATION ==================================================== <<<< #

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# https://linuxhint.com/configure-use-aliases-zsh/

# >>>> ============ ALIASES ==================================================== <<<< #

# >> ------------ CONFIGS ------------ << #
alias zshreset="exec zsh"
alias zshconfig="nvim ~/.zshrc"
alias gitconfig="nvim ~/.gitconfig"
alias ideavimconfig="nvim ~/.ideavimrc"
alias mxconfig="nvim ~/.tmux.conf"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# >> ------------ EDITORS ------------ << #
alias v="vim"
alias vi="vim"
alias vim="nvim"
alias c="code"

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

alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'

alias cl="clear"

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias rmf="rm -vrf"
alias mkdir="mkdir -pv"
alias ex="exit"

alias -g L='| less'
alias -g g='| grep'

# >> ------------ MISC ------------ << #

#   prints size of file
alias grepK="du -h | grep -E '([0-9]+\.[0-9]+K)|([0-9]+K)'"
alias grepM="du -h | grep -E '[0-9]+\.[0-9]+M|[0-9]+M'"
alias grepG="du -h | grep -E '[0-9]+\.[0-9]+G|[0-9]+G'"

# finds process running on specified port
alias port='find_port(){ lsof -i tcp:"$@"; }; find_port'

alias runDb="psql -U admin -d postgres -f ~/Downloads/postgres_2021-04-19_1001.sql"

alias neofetch="neofetch --source /usr/local/Cellar/neofetch/7.1.0/share/images/neofetch_ascii/merlin.txt"

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



