#!/usr/bin/env bash

sudo chsh -s /usr/bin/zsh $USER
source $HOME/repos/dotfiles/.aliases
dotcheckout
