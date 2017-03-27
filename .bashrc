# Ignore duplicate and don't insert command begin with spaces/tabs
export HISTCONTROL=ignoreboth

# Don't check mail
unset MAILCHECK

# Flush history file
export HISTFILESIZE=0
export HISTSIZE=100

# Ignore sensible commands
export HISTIGNORE=mysqladmin:pgadmin

# Exit after 3 hours
export TMOUT=10800

# Editor
export EDITOR=vim
alias vi="vim"

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto --human-readable --file-type '
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias less='less -r'
alias grep='grep --color=auto'

# fast back
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."

# Special directory listing
alias lsp='ls --color | less -R'
alias llp='ll --color | less -R'
alias lap='la --color | less -R'

# Command prompt before doing stupids things
#alias cp='cp -i'
#alias mv='mv -i'
#alias rm='rm -I'

# others alias
alias md='mkdir'
alias dh='df -h'
alias ssu='sudo su -'
alias sa='source ~/.ssh/agent-vars' 
alias sa-net='source ~/.ssh/agent-vars-netsec' 

# set a fancy prompt
parse_git_branch()
{
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1='[\u@\[\033[01;33m\]\H\[\033[00m\] \W\[\033[32m\]$(parse_git_branch)\[\033[00m\]]\$ '

#disable XOFF
stty ixany
stty ixoff -ixon
stty stop undef
stty start undef

# Includes user's private bin if it exists
if [ -d ~/bin ] ; then
	export PATH=~/bin:"${PATH}"
fi	
WORK_DIR=~/.work

if [ -d ${WORK_DIR} ]; then
	for WORK_FILE in `find ${WORK_DIR} -name "$1*"` ; do
		if [[ "${WORK_DIR}" != "${WORK_FILE}" ]] ; then
			source "${WORK_FILE}"
		fi
	done
fi

case $TERM in
	xterm*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD/#$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME}:${PWD/#$HOME/~}\033\\"'
		;;
	*)
		PROMPT_COMMAND=""
		;;
esac
