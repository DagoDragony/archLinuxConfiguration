#!/bin/bash

###############################################################
#  script for easy book selection                             #
###############################################################

booksFolder="$HOME/Documents/books/"

if [ -z $1 ]
then
	ls $booksFolder
else
	coproc (zathura "$booksFolder/$1" &)
fi
