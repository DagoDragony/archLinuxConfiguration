#!/bin/bash

###############################################################
#  script for easy code examples and hotkeys search and copy  #
###############################################################

cmdAndKeysInfoDir="$HOME/Documents/vimwiki/itwiki/keys"
scripts="$HOME/.config/scripts"

if [ -z $1 ]
then
	
	find {$cmdAndKeysInfoDir,$scripts} -type f -exec grep -Iq . {} \; -print | xargs cat | grep -v "^$" | grep -v "^\`" | grep -v "^#[^!]" | grep -v "^\[" | uniq
	# cat $cmdAndKeysInfoDir/* $scripts/* | grep -v "^$" | grep -v "^\`" | grep -v "^#[^!]" | grep -v "^\[" | uniq
else
	# filter option is complication, however, without it xclip hangs
	# echo "$(echo "foo" | xclip -selection clipboard)" # hangs
	# echo "$(echo "foo" | xclip -selection clipboard -f)" # doesn't hang but output input
	# echo "$1" | xclip -selection clipboard -f > /dev/null 
	echo "$1" | xclip -selection clipboard -r -f > /dev/null
fi
