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
export LC_ALL="c.utf-8" # https://github.com/robbyrussell/oh-my-zsh/issues/7426

# Aliases, bindings, variables
source $HOME/.zshenv
source $HOME/.aliases
source $HOME/.config/kitty/bindings.sh
source $HOME/scripts/colors

# ZSH (2)
haveigot minikube && source <(minikube completion zsh)
haveigot kubectl && source <(kubectl completion zsh)
haveigot helm && source <(helm completion zsh)
haveigot kitty && source <(kitty + complete setup zsh)
haveigot argocd && source <(argocd completion zsh)

# Kitty (generate theme)
($HOME/scripts/theme-generator $HOME/.config/kitty/kitty-themes/Template.conf $HOME/.config/kitty/theme.conf "Restart Kitty for new theme" &)

# MAN pager
export MANPAGER="nvim +Man!"

# Prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Machine specific
if [ -f $HOME/.zshrc_machine ]
then
  source $HOME/.zshrc_machine
fi
