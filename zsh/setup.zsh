
# >>>> !!!! THIS SCRIPT MUST BE RAN FROM DIRECTORY ITSELF !!!! <<<< #

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

# Copy .zprofile to HOME dir
cp ./.zprofile ~/

# Copies the zsh directory to '~/.config'
mkdir -p ~/.config && cp $(pwd) ~/.config
