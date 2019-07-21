#!/usr/bin/env bash

set -e

# Change the default shell
sudo chsh -s /usr/bin/zsh $USER

# Source alises
source $HOME/repos/dotfiles/.aliases

# Convert dotfiles repo into a bare repository
mv $HOME/repos/dotfiles/.git $HOME/repos/dotfiles.git
rm -rf $HOME/repos/dotfiles

# Run alias to apply changes
dotcheckout
