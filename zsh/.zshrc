# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/gegeorgiev/.oh-my-zsh"


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
export PATH="/Users/gegeorgiev/.local/bin:$PATH"
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
