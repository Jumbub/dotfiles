# Environment
export ZSH="/home/jamie/.oh-my-zsh"
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="google-chrome-stable"

# Paths
if [ -d "$HOME/.luarocks/bin" ] ; then
    export PATH="$HOME/.luarocks/bin:$PATH"
fi
if [ -d "$HOME/.npm-global/bin" ] ; then
    export PATH="$HOME/.npm-global/bin:$PATH"
fi
if [ -d "$HOME/.yarn/bin" ] ; then
  export PATH="$HOME/.yarn/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.config/composer/vendor/bin" ] ; then
    export PATH="$HOME/.config/composer/vendor/bin:$PATH"
fi
if [ -d "$HOME/scripts" ] ; then
    export PATH="$HOME/scripts:$PATH"
fi
