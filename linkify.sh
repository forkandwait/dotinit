#!/bin/sh

## script to linkify all the config scripts.  No "for loop" for control.

set -e
set -u

case $OS in
	Windows_NT)
		# UGLY HACK FOR MISSING SYMLINK FUNCTIONALITY!!
		LNOPTS=' -vb'

		# DIRS
		mkdir $HOME/.emacs.d
		for EFILE in $HOME/.init/emacs.d/*.el; do
			FF=$(basename $EFILE)
			ln $LNOPTS $HOME/.init/emacs.d/$FF $HOME/.emacs.d/$FF
		done

		# FILES
		ln $LNOPTS $HOME/.init/bashrc     $HOME/.bashrc
		ln $LNOPTS $HOME/.init/inputrc    $HOME/.inputrc
		ln $LNOPTS $HOME/.init/psqlrc     $HOME/.psqlrc
		ln $LNOPTS $HOME/.init/octaverc   $HOME/.octaverc 
		;;
	*)
		LNOPTS=' -svb'

		# DIRS
		ln $LNOPTS $HOME/.init/emacs.d    $HOME/.emacs.d

		# FILES
		ln $LNOPTS $HOME/.init/bashrc     $HOME/.bashrc
		ln $LNOPTS $HOME/.init/inputrc    $HOME/.inputrc
		ln $LNOPTS $HOME/.init/psqlrc     $HOME/.psqlrc
		ln $LNOPTS $HOME/.init/octaverc   $HOME/.octaverc 
		;;
esac

