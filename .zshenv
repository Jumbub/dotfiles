# Environment
export ZSH="/home/jamie/.oh-my-zsh"
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="google-chrome-stable"

function addToPath() {
  if [[ ! "$PATH" =~ "$1" ]] && [ -d "$1" ]
  then
      export PATH="$1:$PATH"
  fi
}

# Paths
addToPath "$HOME/.luarocks/bin"
addToPath "$HOME/.npm-global/bin"
addToPath "$HOME/.yarn/bin"
addToPath "$HOME/.local/bin"
addToPath "$HOME/.config/composer/vendor/bin"
addToPath "$HOME/scripts"

# Code pad helper
function pad {
  local CODEPAD="$HOME/repos/codepad/codepad"

  if [ "$1" = "new" ]
  then
    cd "`$CODEPAD $@`"
  else
    $CODEPAD $@
  fi
}
