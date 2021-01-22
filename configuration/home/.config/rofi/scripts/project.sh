#!/bin/zsh

#################################
#  for quick project selection  #
#################################


mainDir="$HOME/Projects/"
cd $mainDir

if [ -z $1 ]
then
	ls -t
else
	cd $1
	coproc (st -e nvim)
fi
