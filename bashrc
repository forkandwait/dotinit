##  -*- mode:shell-script -*-

set -e
set -u

export SHPX="{dbf,prj,s{b{n,x},h{p{,.xml},x}}}"
export HISTIGNORE="&:ls:ls *:[bf]g"

alias ll='ls -ltr'

app_ () { for x in $@; do mv -b "$x" "_$x"; done; }

set +e 
set +u
source $HOME/.bashrc.local
