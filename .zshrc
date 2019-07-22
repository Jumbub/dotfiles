export ZSH="/home/jamie/.oh-my-zsh"

# ZShell

ZSH_THEME="steeef"
ZSH_CUSTOM=$HOME/.custom-oh-my-zsh

plugins=(git)
source $ZSH/oh-my-zsh.sh

# Custom

if [ -d "$HOME/.npm-global/bin" ] ; then
    export PATH="$HOME/.npm-global/bin:$PATH"
fi

source $HOME/.aliases
