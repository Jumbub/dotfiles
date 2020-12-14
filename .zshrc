#!/usr/bin/env zsh

# Environment
export ZSH="/home/jamie/.oh-my-zsh"
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="google-chrome-stable"

# Paths
function addToPath() {
  if [[ ! "$PATH" =~ "$1" ]] && [ -d "$1" ]
  then
      export PATH="$1:$PATH"
  fi
}

addToPath "$HOME/.luarocks/bin"
addToPath "$HOME/.npm-global/bin"
addToPath "$HOME/.yarn/bin"
addToPath "$HOME/.local/bin"
addToPath "$HOME/.config/composer/vendor/bin"
addToPath "$HOME/scripts"

# ZShell
ZSH_THEME="steeef"
ZSH_CUSTOM=$HOME/.custom-oh-my-zsh
plugins=(zsh-completions)
source $ZSH/oh-my-zsh.sh

# Aliases
source $HOME/.aliases
source $HOME/scripts/colors

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://github.com/robbyrussell/oh-my-zsh/issues/7426
export LC_ALL="en_US.UTF-8"

haveigot minikube && source <(minikube completion zsh)
haveigot kubectl && source <(kubectl completion zsh)
haveigot helm && source <(helm completion zsh)
haveigot kitty && source <(kitty + complete setup zsh)

# Lazy load Node Version Manager
source $HOME/scripts/lazy-nvm

# Edit command in vim
autoload -U edit-command-line
bindkey '^j' edit-command-line

# Generate Kitty theme
$HOME/scripts/kitty-theme-generator
