# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# GPG start
export GPG_TTY=$(tty)

# Bash Settings
PS1='[\u@\h \W]\$ '
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="&:?:?[ \t]*:??[ \t]:su*:sudo*:[bf]g*:exit:*-h:*--help:man*:[ \t]*"
export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'

# Bash variables
export PAGER=less
export EDITOR=nvim
export PYTHONIOENCODING=UTF-8

#ls colors
eval "$(dircolors /etc/colors/DIR_COLORS)"
alias ls="ls --color=auto"

# start ssh-agent on bg
export SSH_AUTH_SOCK=${HOME}/.ssh/agent
if ! pgrep -u ${USER} ssh-agent > /dev/null; then
    rm -f ${SSH_AUTH_SOCK}
fi
if [ ! -S ${SSH_AUTH_SOCK} ]; then
    eval $(ssh-agent -a ${SSH_AUTH_SOCK} 2> /dev/null)
fi

[[ -f "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"

eval "$(starship init bash)"

complete -C /home/mariano/go/bin/gocomplete go
