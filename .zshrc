# Aliases
source $HOME/.aliases
source $HOME/scripts/colors

# ZShell
ZSH_THEME="steeef"
ZSH_CUSTOM=$HOME/.custom-oh-my-zsh
plugins=(zsh-completions)
source $ZSH/oh-my-zsh.sh

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://github.com/robbyrussell/oh-my-zsh/issues/7426
export LC_ALL="en_US.UTF-8"

haveigot minikube && source <(minikube completion zsh)
haveigot kubectl && source <(kubectl completion zsh)
haveigot helm && source <(helm completion zsh)
haveigot kitty && source <(kitty + complete setup zsh)

# Lazy load Node Version Manager
source ./scripts/lazynvm

# Edit command in vim
autoload -U edit-command-line
bindkey '^j' edit-command-line

trap __catch_signal_usr1 USR1
__catch_signal_usr1() { trap __catch_signal_usr1 USR1; vim; }
