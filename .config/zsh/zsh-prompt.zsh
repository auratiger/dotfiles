#!/bin/sh

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

# >> Inspired by: https://www.youtube.com/watch?v=UgDz_9i2nwc
# >> https://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

# >>>> Prompt man page: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

setopt PROMPT_SUBST
setopt promptsubst

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

function __set_prompt() {

	# Opening Bracket: ┌─[
	PS1="%{$fg_bold[blue]%}┌─["

  # Name and Host
  PS1+="%{$fg_bold[white]%}%n%b%{$fg[red]%}@%{$fg_bold[white]%}%m"

  # Closing Bracket: ']'
  PS1+="%{$fg_bold[blue]%}]%{$reset_color%}"

  PS1+=" - "

  # Opening Bracket: '['
  PS1+="%{$fg_bold[blue]%}["

  # Current Directory Path '~'
	# Path: http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
	PS1+="%{$fg_bold[cyan]%}${PWD/#$HOME/~}%{$reset_color%}"

  # Closing Bracket: ']'
  PS1+="%{$fg_bold[blue]%}]%{$reset_color%}"

  # New line
  PS1+=$'\n'

	# Opening Bracket: └─[
	PS1+="%{$fg_bold[blue]%}└─["

	# Status Code
  # >> This is a ternary operation: '%(x.true-text.false-text)'
  # https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
	PS1+="%(?.%{$fg_bold[magenta]%}%?%{$reset_color%}.%{$fg[red]%}%?%{$reset_color%})"

 	# Git
 	# if git rev-parse --is-inside-work-tree 2> /dev/null | grep -q 'true' ; then
 	# 	PS1+=', '
 	# 	PS1+="%{$fg[magenta]%}$(git rev-parse --abbrev-ref HEAD 2> /dev/null)%{$reset_color%}"
		# STATUS=$(git status --short | wc -l)
		# if [ $STATUS -gt 0 ]; then
 	# 		PS1+="%{$fg[green]%}+$(echo $STATUS | awk '{$1=$1};1')%{$reset_color%}"
 	# 	fi
 	# fi

	# Timer: http://stackoverflow.com/questions/2704635/is-there-a-way-to-find-the-running-time-of-the-last-executed-command-in-the-shel
	if [[ $_elapsed[-1] -ne 0 ]]; then
		PS1+=', '
		PS1+="%{$fg[yellow]%}$_elapsed[-1]s%{$reset_color%}"
	fi

	# PID
	if [[ $! -ne 0 ]]; then
		PS1+=', '
		PS1+="%{$fg[yellow]%}PID:$!%{$reset_color%}"
	fi

	# Sudo: https://superuser.com/questions/195781/sudo-is-there-a-command-to-check-if-i-have-sudo-and-or-how-much-time-is-left
	CAN_I_RUN_SUDO=$(sudo -n uptime 2>&1|grep "load"|wc -l)
	if [ ${CAN_I_RUN_SUDO} -gt 0 ]
	then
		PS1+=', '
		PS1+="%{$fg_bold[red]%}SUDO%{$reset_color%}"
	fi

  # Closing Bracket: ']'
  PS1+="%{$fg_bold[blue]%}] %{$reset_color%}"

  PS1+="%{$fg_bold[blue]%}<$(__mygit)$(__hg_prompt_info)%{$fg_bold[blue]%}>%{$reset_color%} "

  RPS1="%(?..%{$fg_bold[red]%} -> exit: %? <- %{$reset_color%})" # showing the exit code of the last ran command
  PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
}

# Here we are using zsh hooks. More information can be found here:
# >> https://github.com/rothgar/mastering-zsh/blob/master/docs/config/hooks.md
# >> https://zsh.sourceforge.io/Doc/Release/Functions.html

precmd_functions+=( __set_prompt )

preexec () {
   (( ${#_elapsed[@]} > 1000 )) && _elapsed=(${_elapsed[@]: -1000})
   _start=$SECONDS
}

precmd () {
   (( _start >= 0 )) && _elapsed+=($(( SECONDS-_start )))
   _start=-1
}


