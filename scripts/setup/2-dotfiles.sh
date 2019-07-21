#!/usr/bin/env zsh

sudo chsh -s /usr/bin/zsh $USER
source $HOME/repos/dotfiles/.aliases && dot_checkout
