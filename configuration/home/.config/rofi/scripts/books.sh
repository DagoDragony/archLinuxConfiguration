#!/bin/bash

###############################################################
#  script for easy book selection                             #
###############################################################

booksFolder="$HOME/Documents/books/"
cd $booksFolder

if [ -z $1 ]
then
	find . -type f -maxdepth 1 -printf "%T@ %f\n" | sort -rn | cut -f 1 -d ' ' --complement
	# deprecated as no file filter
	# ls -tu $booksFolder
else
	# . $HOME/.profile
	# cmd='zathura "'$1'"'
	# echo "$cmd" | systemd-cat
	coproc (zathura "$1" &)
fi
