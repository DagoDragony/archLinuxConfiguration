#!/bin/bash

###############################################################
#  script for easy book selection                             #
###############################################################

booksFolder="$HOME/Documents/books/"

if [ -z $1 ]
then
	ls -tu $booksFolder
else
	coproc (zathura "$booksFolder/$1" &)
fi
