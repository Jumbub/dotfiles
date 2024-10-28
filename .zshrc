#!/usr/bin/env zsh

# PowerLevel10k Instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH
UPDATE_ZSH_DAYS=90
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_CUSTOM=$HOME/.custom-oh-my-zsh
plugins=(zsh-completions fzf)
source $ZSH/oh-my-zsh.sh
export LC_ALL="en_US.UTF-8" # https://github.com/robbyrussell/oh-my-zsh/issues/7426

# Aliases, bindings, variables
source $HOME/.aliases
source $HOME/.bindings
source $HOME/scripts/colors

# ZSH (2)
haveigot minikube && source <(minikube completion zsh)
haveigot kubectl && source <(kubectl completion zsh)
haveigot helm && source <(helm completion zsh)
haveigot kitty && source <(kitty + complete setup zsh)
haveigot argocd && source <(argocd completion zsh)

# FZF
# export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude '*.o'"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Kitty (generate theme)
($HOME/scripts/kitty-theme-generator &)

# MAN pager
export MANPAGER="nvim +Man!"

# Prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# GCloud
if [ -f '/home/jamie/.local/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jamie/.local/bin/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/home/jamie/.local/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/jamie/.local/bin/google-cloud-sdk/completion.zsh.inc'; fi

# NVM
if [ -f '/usr/share/nvm/init-nvm.sh' ]; then . '/usr/share/nvm/init-nvm.sh'; fi


# bun completions
[ -s "/home/jamie/.bun/_bun" ] && source "/home/jamie/.bun/_bun"
