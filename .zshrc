# Environment variables
export ZSH="/home/jamie/.oh-my-zsh"
export EDITOR="nvim"
export VISUAL="nvim"
if [ -d "$HOME/.luarocks/bin" ] ; then
    export PATH="$HOME/.luarocks/bin:$PATH"
fi
if [ -d "$HOME/.npm-global/bin" ] ; then
    export PATH="$HOME/.npm-global/bin:$PATH"
fi
if [ -d "$HOME/.yarn/bin" ] ; then
    export PATH="$HOME/.yarn/bin:$PATH"
fi

# Load kitty autocompletions
autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin

# ZShell
ZSH_THEME="steeef"
ZSH_CUSTOM=$HOME/.custom-oh-my-zsh
plugins=()
source $ZSH/oh-my-zsh.sh

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Aliases
source $HOME/.aliases

