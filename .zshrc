# Environment variables
export ZSH="/home/jamie/.oh-my-zsh"
export EDITOR="nvim"
export TERMINAL="kitty"
if [ -d "$HOME/.luarocks/bin" ] ; then
    export PATH="$HOME/.luarocks/bin:$PATH"
fi
if [ -d "$HOME/.npm-global/bin" ] ; then
    export PATH="$HOME/.npm-global/bin:$PATH"
fi
export PATH="$(yarn global bin):$PATH"
if [ -d "$HOME/repos/other/path" ] ; then
    export PATH="$HOME/repos/other/path:$PATH"
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

# Aliases
source $HOME/.aliases
source $HOME/scripts/colors

# Load kitty autocompletions
haveigot kitty\
  && autoload -Uz compinit\
  && compinit\
  && kitty + complete setup zsh | source /dev/stdin

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

nvm() {
  echo "🚨 NVM not loaded! Loading now..."
  unset -f nvm # Unset this nvm function

  # Node versioning with NVM
  source /usr/share/nvm/init-nvm.sh

  nvm $@
}

# Edit command in vim
autoload -U edit-command-line
bindkey '^j' edit-command-line
