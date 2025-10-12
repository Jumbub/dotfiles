#!/usr/bin/env zsh

# Environment
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

# Path
function addToPath() {
  if [[ ! "$PATH" =~ "$1" ]] && [ -d "$1" ]
  then
      export PATH="$1:$PATH"
  fi
}
addToPath "$HOME/.local/bin"
