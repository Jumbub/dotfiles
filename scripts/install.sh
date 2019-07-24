#!/usr/bin/env bash

LOG_FILE=/tmp/install_programs.txt
log() {
  echo "$@" >> $LOG_FILE
}

echo "" > $LOG_FILE
log "beginning install..."

install_program() {
  log "installing ${2}..."
  $@
  if [[ $? > 0 ]]
  then
    log "ERROR: failed to install $2 ($1 $2)"
  else
    log "installed ${2}"
  fi
}

if [ ! $1 ] || [ "$1" = "firsttime" ]
then
  # Sublime
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  sudo apt install apt-transport-https
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

  # PHP
  sudo add-apt-repository -y ppa:ondrej/php

  #  Node
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
fi

if [ ! $1 ] || [ "$1" = "apt" ]
then
  sudo apt update
  install_apt() {
    install_program "sudo apt install -y" "${@}"
  }
  install_apt apt-transport-https
  install_apt autokey-gtk
  install_apt awesome
  install_apt ca-certificates
  install_apt clang
  install_apt curl
  install_apt dconf-editor
  install_apt gnupg2
  install_apt haskell-stack
  install_apt htop
  install_apt libxft-dev
  install_apt ninja-build
  install_apt nodejs
  install_apt php
  install_apt php-curl
  install_apt php-mbstring
  install_apt php-xml
  install_apt php7.2
  install_apt php7.2-curl
  install_apt php7.2-mbstring
  install_apt php7.2-soap
  install_apt php7.2-xml
  install_apt php7.2-zip
  install_apt python3
  install_apt python3-pip
  install_apt redshift
  install_apt redshift-gtk
  install_apt rofi
  install_apt software-properties-common
  install_apt sublime-merge
  install_apt sublime-text
  install_apt vim
  install_apt vlc
  install_apt xournal
  install_apt zsh

  # https://github.com/elw00d/awesome-deb-docker
fi

# Docker (https://docs.docker.com/install/linux/docker-ce/ubuntu/)
if [ ! $1 ] || [ "$1" = "firsttime" ]
then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

  sudo apt-get update

  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
fi

if [ ! $1 ] || [ "$1" = "snap" ]
then
  install_snap() {
    install_program "sudo snap install" "${@}"
  }
  install_snap spotify
  install_snap code --classic
  install_snap gotop-cjbassi
fi

if [ "$1" = "codeupdate" ]
then
  code --list-extensions > $HOME/scripts/.code_extensions
fi

if [ ! $1 ] || [ "$1" = "code" ]
then
  install_code() {
    install_program "code --install-extension" "${@}"
  }
  cat $HOME/scripts/.code_extensions | xargs -L 1 code --install-extension
fi

if [ ! $1 ] || [ "$1" = "pip" ]
then
  install_pip() {
    install_program "pip3 install" "${@}"
  }
  install_pip awscli
fi

if [ ! $1 ] || [ "$1" = "firsttime" ]
then
  # Is this broken? Go to https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
  install_npm() {
    install_program "npm i -g" "${@}"
  }
  install_npm yarn
fi

if [ ! $1 ] || [ "$1" = "yarn" ]
then
  install_yarn() {
    install_program "yarn global add" "${@}"
  }
  install_yarn prettier
  install_yarn @prettier/plugin-lua
fi

if [ ! $1 ] || [ "$1" = "haskell" ]
then
  log "haskell..."
  stack upgrade
  stack update
  stack install hsdev # Dependency of sublime plugin
  stack install stylish-haskell # Optional of sublime plugin
  stack install hindent # Optional of sublime plugin
  log "done with haskell"
fi

if [ ! $1 ] || [ "$1" = "firsttime" ]
then
  git clone https://git.suckless.org/st $HOME/repos/st
  make -C $HOME/repos/st

  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"
fi

log "done.\n"
cat $LOG_FILE