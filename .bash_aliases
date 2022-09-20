alias ll='ls -alF'
alias la='ls -a'
alias l='ls -CF'

alias cl="clear"

alias grepK="du -h | grep -E '([0-9]+\.[0-9]+K)|([0-9]+K)'"
alias grepM="du -h | grep -E '[0-9]+\.[0-9]+M|[0-9]+M'"
alias grepG="du -h | grep -E '[0-9]+\.[0-9]+G|[0-9]+G'"

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias mkdir="mkdir -pv"
alias ex="exit"
alias mx="tmux"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ipconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\([0-9]\+\.\)\{3\}[a-fA-F0-9:]\+\)' | awk '{sub(\inet6? (addr:)? ?/, \"\"); print }'"

# Flush
alias flushFont="fc-cache -f -v"
alias flushDns="systemd-resolve --flush-caches"

# VIM
alias v="vim"
alias vi="vim"

# GIT
# alias g="git"
# alias ga="git add"
# alias gaa="git add ."
# alias gc="git commit -m"
# alias ga="git add . && git commit -avm"
# alias gs="git status"
# alias gb="git branch --all"
# alias gout="git checkout"
# alias gp="git push"

# alias gd=!"git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat"
