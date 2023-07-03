# zsh config dir
export ZDOTDIR=$HOME/.config/zsh

##### SETUP #####################################################################################
#                                                                                               #
#   For this configuration to work, we must change the default location of zsh                  #
#   to from '~/' to '~/.config/zsh'. This is done by setting 'export ZDOTDIR=$HOME/.config/zsh' #
#   in the .zprofile config file. This file needs to be put in one of the default zsh paths     #
#   so zsh can find and load it. PATHS: ( /etc/, ~/ )                                           #
#                                                                                               #
#   Order of Operations: [ .zshenv -> .zprofile -> .zshrc -> .zlogin -> .zlogout ]              #
#                                                                                               #
#################################################################################################

# Added by Toolbox App
export PATH="$PATH:/home/ggeorgi/.local/share/JetBrains/Toolbox/scripts"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
