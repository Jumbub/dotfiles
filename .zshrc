#!/usr/bin/env zsh

# ZSH
ZSH_THEME="steeef"
ZSH_CUSTOM=$HOME/.custom-oh-my-zsh
plugins=(zsh-completions zsh-z)
source $ZSH/oh-my-zsh.sh
export LC_ALL="en_US.UTF-8" # https://github.com/robbyrussell/oh-my-zsh/issues/7426

# Aliases, bindings, variables
source $HOME/.aliases
source $HOME/.bindings
source $HOME/scripts/colors

# ZSH (2)
haveigot minikube && source <(minikube completion zsh)
haveigot kubectl && source <(kubectl completion zsh)
haveigot helm && source <(helm completion zsh)
haveigot kitty && source <(kitty + complete setup zsh)

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# NVM
source $HOME/scripts/lazy-nvm

# Kitty (generate theme)
($HOME/scripts/kitty-theme-generator &)
