# >>>> ============ EXPORTED PATHS ==================================================== <<<< #

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


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/openvpn/sbin:$PATH"
export PATH="/Users/gegeorgiev/.local/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

# For compilers to find openjdk you may need to set:
#  export CPPFLAGS="-I/usr/local/opt/openjdk/include"


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# >>>> ============ USER CONFIGURATION ==================================================== <<<< #

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export TERMINAL="alacritty"
# export BROWSER="brave"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

