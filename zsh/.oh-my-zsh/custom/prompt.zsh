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

# >>> Shows date, but isn't really useful and take up a lot of space <<<<
# PROMPT=$'%{$fg_bold[blue]%}┌─[%{$fg_bold[green]%}%n%b%{$fg[black]%}@%{$fg[cyan]%}%m%{$fg_bold[blue]%}]%{$reset_color%} - %{$fg_bold[blue]%}[%{$fg_bold[default]%}%~%{$fg_bold[blue]%}]%{$reset_color%} - %{$fg_bold[blue]%}[%b%{$fg[yellow]%}'%D{"%Y-%m-%d %I:%M:%S"}%b$'%{$fg_bold[blue]%}]
# %{$fg_bold[blue]%}└─[%{$fg_bold[magenta]%}%?$(__retcode)%{$fg_bold[blue]%}] <$(__mygit)$(__hg_prompt_info)>%{$reset_color%} '

PROMPT=$'%{$fg_bold[blue]%}┌─[%{$fg_bold[green]%}%n%b%{$fg[black]%}@%{$fg[cyan]%}%m%{$fg_bold[blue]%}]%{$reset_color%} - %{$fg_bold[blue]%}[%{$fg_bold[default]%}%~%{$fg_bold[blue]%}]%{$reset_color%}
%{$fg_bold[blue]%}└─[%{$fg_bold[magenta]%}%?$(__retcode)%{$fg_bold[blue]%}] <$(__mygit)$(__hg_prompt_info)>%{$reset_color%} '

RPS1='%(?..%{$fg_bold[red]%} -> exit: %? <- %{$reset_color%})' # showing the exit code of the last ran command
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

