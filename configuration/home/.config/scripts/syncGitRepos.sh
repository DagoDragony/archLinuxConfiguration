#!/bin/zsh

#######################################################
# script that pull all repos in specified folder      #
#######################################################

gitSyncDir=$1

pullRepo() {
	typeset syncDir=$1
	cd $syncDir
	tsp "cd $syncDir; git pull"
}

if [[ -d $gitSyncDir ]]; then
	cd $gitSyncDir
	set -A dirs $(ls -d $PWD/*)
	for syncDir in $dirs; pullRepo "$syncDir";
else
	echo "Bad path passed $gitSyncDir" 1>&2
	exit 1
fi

