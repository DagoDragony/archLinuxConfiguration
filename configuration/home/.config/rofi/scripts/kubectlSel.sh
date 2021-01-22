#!/bin/zsh

#####################################
#  for quick k8s context selection  #
#####################################

scriptName=${0:t}

if [ -z $1 ]
then
	kubectl config get-contexts --no-headers --output=name
else
	output=$(kubectl config use-context $1 2> >(xargs -I{} notify-send -u critical $scriptName {}))
	if [ $? -eq 0 ]; then
		notify-send -u normal $scriptName $output
	fi
fi


