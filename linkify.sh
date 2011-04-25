#!/bin/sh  ## -*-mode:shell-script-*-

## script to linkify all the config scripts.  No "for loop" for control.

set -e
set -u

case $OS in
	Windows_NT)
		# WINDOWS LAMENESS: MSYS/ XP will just "cp" to emulate symlink (?!?!?!?)
		LNOPTS=' -svb'
		;;
	*)
		LNOPTS=' -svb'
		;;
esac

# DIRS
ln $LNOPTS $HOME/.init/emacs.d    $HOME/.emacs.d

# FILES
ln $LNOPTS $HOME/.init/bashrc     $HOME/.bashrc
ln $LNOPTS $HOME/.init/inputrc    $HOME/.inputrc
ln $LNOPTS $HOME/.init/psqlrc     $HOME/.psqlrc
ln $LNOPTS $HOME/.init/octaverc   $HOME/.octaverc 
