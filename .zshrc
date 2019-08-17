export ZSH="/home/jamie/.oh-my-zsh"

# ZShell

ZSH_THEME="steeef"
ZSH_CUSTOM=$HOME/.custom-oh-my-zsh

plugins=()
source $ZSH/oh-my-zsh.sh

# Custom

if [ -d "$HOME/.luarocks/bin" ] ; then
    export PATH="$HOME/.luarocks/bin:$PATH"
fi

if [ -d "$HOME/.npm-global/bin" ] ; then
    export PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d "$HOME/.yarn/bin" ] ; then
    export PATH="$HOME/.yarn/bin:$PATH"
fi

source $HOME/.aliases

# Load kitty autocompletions
autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
