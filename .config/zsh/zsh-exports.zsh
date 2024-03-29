#!/bin/zsh

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

# XDG_CONFIG_HOME="$HOME/.config"

# https://github.com/nvm-sh/nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

PATHS=(
	"/usr/local/opt/openjdk/bin"
	"/usr/local/bin"
	"/usr/local/opt/openjdk/bin"
	"/usr/local/opt/openssl/bin"
	"/usr/local/opt/openvpn/sbin"
   "/usr/local/go/bin"
	"$HOME/.local/bin"
	"$HOME/.cargo/bin"
   "$HOME/.local/opt/firefox/firefox"
)

for new_path in "${PATHS[@]}"; do
	export PATH="${new_path}:$PATH"
done

# For compilers to find openjdk you may need to set:
#  export CPPFLAGS="-I/usr/local/opt/openjdk/include"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# >>>> ============ Color man pages ==================================================== <<<< #
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;31m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

# >>>> ============ USER CONFIGURATION ==================================================== <<<< #

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export TERMINAL="alacritty"
export BROWSER="vivaldi-stable"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else

	if [[ -e ~/.local/bin/lvim ]]; then
		# export EDITOR='lvim'
		export EDITOR='nvim'
	elif [[ -e /usr/bin/nvim ]]; then
		export EDITOR='nvim'
	else
		export EDITOR='vim'
	fi

fi

export GIT_EDITOR=$EDITOR
