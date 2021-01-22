#!/usr/bin/zsh

pluginsRepo="$HOME/.config/zsh/plugins"
gitRepos=(
	"https://github.com/wfxr/forgit.git"
	"https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

ohMyZshRepo="https://github.com/ohmyzsh/ohmyzsh.git"
ohMyZshPlugins=(
	'fzf'
	'systemd'
)

mkdir -p $pluginsRepo

copyDirectRepos(){
	typeset mdir="/tmp/$(uuidgen)"
	mkdir $mdir && cd $mdir
	for repo in $gitRepos
	do
		git clone $repo
	done
	cp -rf * $pluginsRepo
}

copyOhMyZshRepos(){
	typeset tempOhMyZshDir="/tmp/$(uuidgen)"
	mkdir $tempOhMyZshDir && cd $tempOhMyZshDir
	git clone $ohMyZshRepo
	for pName in $ohMyZshPlugins
	do
		echo "copying $tempOhMyZshDir/ohmyzsh/plugins/$pName"
		cp -rf "$tempOhMyZshDir/ohmyzsh/plugins/$pName" "$pluginsRepo"
	done
}

copyDirectRepos
copyOhMyZshRepos
