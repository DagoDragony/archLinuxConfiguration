#!/bin/zsh

# for some reason can't be moved to ~/.config/zsh/.zprofile, because then ~/.profile link doesn't work

export PATH="$PATH:$HOME/.config/scripts"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$HOME/.config/zsh/history"
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND='rg --hidden --files --ignore-file $HOME/.config/git/ignore'

