##  -*- mode:shell-script -*-

set -e -u

shopt -s extglob progcomp checkwinsize

export EDITOR='vi'				# is this really necessary?
export PAGER='less -X'

alias ll='ls -ltr'
alias tm0='tmux attach-session -t 0'
alias tml='tmux list-session'
alias emacs='emacs --no-site-file'
alias less='less -X'

export SHPX="{dbf,prj,s{b{n,x},h{p{,.xml},x}}}"
export HISTIGNORE="&:[bf]g"
export INPUTRC="$HOME/.init/inputrc"
export PS1="\W/ (j=\j,r=\$?)$ "

test -z "${SSH_AUTH_SOCK:-xxx}" && eval `ssh-agent -s`

set +e +u
if [ -f $HOME/.bashrc.local ]; then . $HOME/.bashrc.local; fi
if [ -f /etc/bash_completion ]; then . /etc/bash_completion; fi

