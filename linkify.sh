#!/bin/sh

## script to linkify all the config scripts.  No "for loop" for control.

set -e
set -u

ln -svb $HOME/.init/bashrc     $HOME/.bashrc
ln -svb $HOME/.init/emacs.d    $HOME/.emacs.d
ln -svb $HOME/.init/inputrc    $HOME/.inputrc
ln -svb $HOME/.init/psqlrc     $HOME/.psqlrc
ln -svb $HOME/.init/octaverc   $HOME/.octaverc
