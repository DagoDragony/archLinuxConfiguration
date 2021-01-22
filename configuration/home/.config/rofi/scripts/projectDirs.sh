#!/bin/zsh

#################################
#  for quick project selection  #
#################################


mainDir="$HOME/Projects/"
cd $mainDir

if [ -z $1 ]
then
	find . -maxdepth 1 ! -path . -type d -printf "%T+\t%p\n" | sort -rn | awk '{ print $2 }'
else
	cd $1
	coproc (st -e)
fi
