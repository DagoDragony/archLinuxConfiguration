#!/bin/bash

#watch ./serversConnect.sh $(./serversConnect.sh | head -n 1)

logLevelInfo="logLevelInfo"
logLevelWarn="logLevelWarn"
logLevelError="logLevelError"

logLevel=$logLevelInfo

adPass="adPass"
ppPass="ppPass"
ad="ad"

defaultPassMap=(
    "L_d1:ppPass"
    "L_d3:ppPass"
    "L_pp:ppPass"
    "L_pr:ppPass"
    "W_d1:ppPass"
    "W_d3:ppPass"
    "W_pp:ppPass"
    "W_pr:ad"
)

scriptName=$(basename $0)

log() {
	echo $1 | systemd-cat -t $scriptName
}

if [[ -z $1 ]]
then
	cat $HOME/.config/psen/servers
else
	log "serverLine: $@"
	serverLine=($@)

	# prod vpn check
	# if [ ${serverLine[2]} == "pr" ] || [ ${serverLine[2]} == "pp" ]; then
	# 	nmcli con show --active | grep -i Production > /dev/null || (notify-send --urgency=critical "Production vpn is needed for ${serverLine[2]}"; exit 1)
	# fi

	#echo "first is: ${serverLine[1]}"
	osType=${serverLine[0]}
	passMapKey="${serverLine[0]}_${serverLine[2]}"
	server=${serverLine[1]#*@}
	recipient=${serverLine[1]%@*}


	user=$(echo $recipient | grep -Po "^[^:]*")
	passId=$(echo $recipient | grep -Po "(?<=:).*")

	if [ -z $passId ]
	then
		for pKey in "${defaultPassMap[@]}" ; do
			key=${pKey%:*}
			if [ $key == $passMapKey ]; then
				passId=${pKey#*:}
				break
			fi
		done
	fi

	case $osType in
		"W")
			log "windows!"
			domain=$(echo $user | grep -Po "^[^\\\\]*")
			userName=$(echo $user | grep -Po "(?<=\\\\)[^:]*")
			if [[ -z $userName ]]
			then
				userName=$domain
				domain=""
			fi
			log 'domain='$domain' username='$userName
			log $user
			log $domain
			log $userName
			sharedFolderArg="/drive:rdpShare,$HOME/Documents/remoteShare"
			if [[ -z $domain ]]
			then
				domainArg="/d:."
			else
				domainArg="/d:$domain"
			fi
			cmd="nohup pass $passId | xfreerdp /u:$userName $domainArg /v:$server /cert-ignore /workarea /clipboard $sharedFolderArg /from-stdin > /dev/null 2>> logfile.log &"
			log "$cmd"
			eval $cmd
			;;
		"L")
			sessionName="tmux_$PPID"

			tmux start-server

			# if session doesn't exist
			tmux has-session -t $sessionName 2>/dev/null
			
			if [ $? != 0 ]; then
				log "no session $sessionName!"
				# tmux new-session -d -s $sessionName -d "/usr/bin/env sh -c \"echo 'first shell'\"; /usr/bin/env sh -i"
				tmux new-session -d -s $sessionName -d "sshpass -f <(pass $passId) ssh -o StrictHostKeyChecking=no $user@$server"
				cmd="nohup st -e bash -c \"tmux attach -t$sessionName \" > /dev/null &"
				# cmd="nohup st -e bash -c \"sshpass -f <(pass $passId) ssh -o StrictHostKeyChecking=no $user@$server \" > /dev/null &"
				log "$cmd"
				eval $cmd
			else
				tmux split-window -t "$sessionName:0" "sshpass -f <(pass $passId) ssh -o StrictHostKeyChecking=no $user@$server"
			fi

			tmux select-layout -t "$sessionName:0" tiled
			;;
		"V")
			cmd="nohup st -e bash -c \"vncviewer -passwd <(pass $passId | vncpasswd -f) $server \" > /dev/null &"
			log "$cmd"
			eval $cmd
			;;
		*)
			log "Unknown type of connection: $osType"
			exit 1
			;;
	esac

fi
