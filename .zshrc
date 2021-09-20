#!/usr/bin/env zsh

# ZSH
ZSH_THEME="steeef"
ZSH_CUSTOM=$HOME/.custom-oh-my-zsh
plugins=(zsh-completions zsh-z zsh-nvm)
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
haveigot argocd && source <(argocd completion zsh)

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Kitty (generate theme)
($HOME/scripts/kitty-theme-generator &)

# MAN pager
export MANPAGER="nvim -c 'set ft=man' -"
