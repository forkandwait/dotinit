##  -*- mode:shell-script -*-

set -e
set -u

shopt -s extglob progcomp checkwinsize

export SHPX="{dbf,prj,s{b{n,x},h{p{,.xml},x}}}"
export HISTIGNORE="&:ls:ls *:[bf]g"
export INPUTRC="$HOME/.init/inputrc"
export PS1="\W/ (j=\j,r=\$?)$ "

test -z "$SSH_AUTH_SOCK" && eval `ssh-agent -s`

alias ll='ls -ltr'

set +e 
set +u
if [ -f $HOME/.bashrc.local ]; then . $HOME/.bashrc.local; fi
if [ -f /etc/bash_completion ]; then . /etc/bash_completion; fi

