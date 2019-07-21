#!/bin/bash

  # 
  # Update repositories
  # 

# Sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# PHP
sudo add-apt-repository -y ppa:ondrej/php

sudo apt update

  # 
  # Install programs
  # 

LOG_FILE=/tmp/install-programs.txt;

echo "beginning installation of programs ..." >> $LOG_FILE

function install-program() {
  echo "installing ${2}"
  $1 $2
  if [[ $? > 0 ]]; then
    echo "ERROR: failed to install $2 ($1 $2)" >> $$LOG_FILE
  else
    echo "installed ${2}" >> $LOG_FILE
  fi
}

function install-program-apt() {
  install-program "sudo apt -y install" "${@}"
}

function install-program-snap() {
  install-program "sudo snap install" "${@}"
}

function install-program-pip() {
  install-program "pip3 install" "${@}"
}

install-program-apt apt-transport-https
install-program-apt autokey-gtk
install-program-apt awesome
install-program-apt curl
install-program-apt dconf-editor
install-program-apt haskell-stack
install-program-apt htop
install-program-apt php
install-program-apt php-curl
install-program-apt php-mbstring
install-program-apt php-xml
install-program-apt php7.2
install-program-apt php7.2-curl
install-program-apt php7.2-mbstring
install-program-apt php7.2-soap
install-program-apt php7.2-xml
install-program-apt php7.2-zip
install-program-apt python3
install-program-apt python3-pip
install-program-apt redshift
install-program-apt redshift-gtk
install-program-apt rofi
install-program-apt stack
install-program-apt sublime-merge
install-program-apt sublime-text
install-program-apt vim
install-program-apt vlc
install-program-apt xournal
install-program-apt zsh

install-program-snap node --classic --channel=10
install-program-snap spotify
install-program-snap code --classic
install-program-snap gotop-cjbassi

install-program-pip awscli

stack upgrade
stack update

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"
sudo chsh -s /usr/bin/zsh $USER
echo "Please log out and back in to see use ZShell"