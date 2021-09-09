# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/gegeorgiev/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# rkj-repos
# macovsky 
ZSH_THEME="rkj-repos"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/openvpn/sbin:$PATH"
# For compilers to find openjdk you may need to set:
#  export CPPFLAGS="-I/usr/local/opt/openjdk/include"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshreset="exec zsh"
alias zshconfig="nvim ~/.zshrc"
alias gitconfig="nvim ~/.gitconfig"
alias ideavimconfig="nvim ~/.ideavimrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# VIM
alias v="vim"
alias vi="vim"
alias vim="nvim"

alias ll='ls -alF'
alias la='ls -a'
alias l='ls -CF'

alias cl="clear"

# prints size of file
alias grepK="du -h | grep -E '([0-9]+\.[0-9]+K)|([0-9]+K)'"
alias grepM="du -h | grep -E '[0-9]+\.[0-9]+M|[0-9]+M'"
alias grepG="du -h | grep -E '[0-9]+\.[0-9]+G|[0-9]+G'"

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias mkdir="mkdir -pv"
alias ex="exit"

# finds process running on specified port
alias port='find_port(){ lsof -i tcp:"$@"; }; find_port'

alias runDb="psql -U admin -d postgres -f ~/Downloads/postgres_2021-04-19_1001.sql"
alias sbuilder="cd ~/Project/solution-builder"
alias project="cd ~/Project/migration-manager"

# tmux aliases
alias mx="tmux"
alias mxl="tmux list-sessions"
alias mxk="tmux kill-session -t"
alias mxka="tmux kill-session -a"
alias mxkt="tmux kill-session -a -t"

# work
alias mci="mvn clean install"
alias depResolve="mvn dependency:resolve"
alias nrb="npm run build"
alias migrationVPN="sshuttle --dns --to-ns=192.168.0.253 -r root@10.105.25.14 192.168.0.0/16"

