#!/bin/zsh

# for some reason can't be moved to ~/.config/zsh/.zprofile, because then ~/.profile link doesn't work

export PATH="$PATH:$HOME/.config/scripts"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$HOME/.config/zsh/history"
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND='rg --hidden --files --ignore-file $HOME/.config/git/ignore'

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo "Initialising new SSH agent..." | systemd-cat
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo "SSH agent initialization succeeded" | systemd-cat
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     #ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi
