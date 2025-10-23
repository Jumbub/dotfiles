#!/usr/bin/env zsh

# Environment
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR=/home/jamie/.local/bin/nvim
export TERMINAL="kitty"
export BROWSER="firefox"
export NPM_PACKAGES="${HOME}/.npm-global"

# Path
function addToPath() {
  if [[ ! "$PATH" =~ "$1" ]] && [ -d "$1" ]
  then
      export PATH="$1:$PATH"
  fi
}
addToPath "$HOME/scripts"
addToPath "$HOME/.local/bin"
addToPath "$HOME/.npm/global/bin"
addToPath "$HOME/go/bin"