#!/usr/bin/env zsh

# Environment
export ZSH="/home/jamie/.oh-my-zsh"
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe"

# Path
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
addToPath "$HOME/.cargo/bin"
addToPath "$HOME/.config/composer/vendor/bin"
addToPath "$HOME/scripts"

