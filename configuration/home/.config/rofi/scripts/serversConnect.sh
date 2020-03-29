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
    "W_d1:adPass"
    "W_d3:ppPass"
    "W_pp:ppPass"
    "W_pr:ad"
)

log() {
	echo $1 | systemd-cat -t "${0#*/}"
}


if [ -z $1 ]
then
	cat $HOME/.config/psen/servers
else
	log "serverLine: $@"
	serverLine=($@)

	if [ ${serverLine[2]} == "pr" ] || [ ${serverLine[2]} == "pp" ]; then
		nmcli con show --active | grep -i Production > /dev/null || (notify-send --urgency=critical "Production vpn is needed for ${serverLine[2]}"; exit 1)
	fi

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

	if [ "W" == $osType ]; then
		log "windows!"
		domain=$(echo $user | grep -Po "^[^\\\\]*")
		userName=$(echo $user | grep -Po "(?<=\\\\)[^:]*")
		sharedFolder="/drive:rdpShare,$HOME/Documents/remoteShare"
		cmd="nohup pass $passId | xfreerdp /u:$userName /d:$domain /v:$server /cert-ignore /clipboard /workarea $sharedFolder /from-stdin > /dev/null 2>> logfile.log &"
		log "$cmd"
		eval $cmd
	elif [ "L" == $osType ]; then
		cmd='nohup gnome-terminal -e "bash -c \"sshpass -f <(pass ppPass) ssh -o StrictHostKeyChecking=no $user@$server \"" > /dev/null'
		log $cmd
		eval $cmd
	else
		log "uknown os type $osType"
		exit 1
	fi
	#nohup gnome-terminal -e "pass $passId | sshpass -f1 ssh -o StrictHostKeyChecking=no $server | while read TEXT; do notify-send \"$TEXT\"; done;"
fi
