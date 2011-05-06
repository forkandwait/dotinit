#!/bin/sh

## script to linkify all the config scripts.  No "for loop" for control.

set -e
set -u

case $OSTYPE in
	*windows*)
		echo "WINDOWS SUCKS!  NO SYMLINKS! ADD SOURCE STATEMENTS TO RC FILES!"
		exit 1
		;;
	*)
		LNOPTS=' -svb'
		
		# DIRS
		ln $LNOPTS $HOME/.init/emacs.d         $HOME/.emacs.d

		# FILES
		ln $LNOPTS $HOME/.init/bash_profile    $HOME/.bash_profile
		ln $LNOPTS $HOME/.init/bashrc          $HOME/.bashrc
		ln $LNOPTS $HOME/.init/inputrc         $HOME/.inputrc
		ln $LNOPTS $HOME/.init/octaverc        $HOME/.octaverc 
		ln $LNOPTS $HOME/.init/psqlrc          $HOME/.psqlrc
		ln $LNOPTS $HOME/.init/vimrc           $HOME/.vimrc
		;;
esac

