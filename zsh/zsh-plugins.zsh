
##### PLUGINS ########################################################################
#                                                                                    #
# >> -------- PLUGINS: ---------------------------------------------------------- << #
#   zsh-syntax-highlighting - https://github.com/zsh-users/zsh-syntax-highlighting   #
#   zsh-autosuggestions - https://github.com/zsh-users/zsh-autosuggestions           #
#   zsh-vi-mode - https://github.com/jeffreytse/zsh-vi-mode                          #
#   git - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git                 #
#                                                                                    #
#   Add wisely, as too many plugins slow down shell startup.                         #
######################################################################################

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "jeffreytse/zsh-vi-mode"
zsh_add_plugin "hlissner/zsh-autopair"
# zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

VI_MODE_SET_CURSOR=true

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
