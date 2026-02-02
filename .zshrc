# PowerLevel10k Instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH
source ~/.p10k.zsh
UPDATE_ZSH_DAYS=90
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_CUSTOM=$HOME/.custom-oh-my-zsh
plugins=(zsh-completions fzf)
source $HOME/.oh-my-zsh/oh-my-zsh.sh
export LC_ALL="C.UTF-8" # https://github.com/robbyrussell/oh-my-zsh/issues/7426

# Environment, Aliases, Bindings
source $HOME/.zshenv
source $HOME/.aliases
source $HOME/.config/kitty/bindings.sh
source $HOME/scripts/colors
haveigot nvim && export MANPAGER="nvim +Man!"

# Completions
haveigot minikube && source <(minikube completion zsh)
haveigot kubectl && source <(kubectl completion zsh)
haveigot helm && source <(helm completion zsh)
haveigot kitty && source <(kitty + complete setup zsh)
haveigot argocd && source <(argocd completion zsh)

# Kitty (generate theme)
[ -f $HOME/scripts/theme-generator ] && ($HOME/scripts/theme-generator $HOME/.config/kitty/kitty-themes/Template.conf $HOME/.config/kitty/theme.conf "Restart Kitty for new theme" &)

# Machine overrides
[ -f $HOME/.machine ] && source $HOME/.machine

# .zsh_history might need to be stored in a folder
if [ -d "$HISTFILE" ]; then
  export HISTFILE="$HISTFILE/.zsh_history"
fi

# Don't start with errors
return 0