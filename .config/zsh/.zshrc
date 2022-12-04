#!/bin/zsh

# beeping is annoying
unsetopt BEEP

# >> Reference for colors: http://stackoverflow.com/questions/689765/how-can-i-change-the-color-of-my-prompt-in-zsh-different-from-normal-text
autoload -U colors && colors

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# Useful Functions
source "$ZDOTDIR/zsh-functions.zsh"

# Normal files to source
zsh_add_file "custom/git-plugin.zsh"
zsh_add_file "zsh-exports.zsh"
zsh_add_file "zsh-plugins.zsh"
zsh_add_file "zsh-prompt.zsh"
zsh_add_file "zsh-aliases.zsh"

# Sets keyboard language layouts
setxkbmap -option grp:switch,grp_led:scroll,grp:alt_shift_toggle -layout us,bg -variant ,phonetic

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
