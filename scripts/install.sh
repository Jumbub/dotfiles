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

if [ ! $1 ] || [ "$1" = "apt" ]
then
  # Sublime
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  sudo apt install apt-transport-https
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

  # PHP
  sudo add-apt-repository -y ppa:ondrej/php

  sudo apt update
fi

if [ ! $1 ] || [ "$1" = "apt" ] || [ "$1" = "fastapt" ]
then
  install_apt() {
    install_program "sudo apt -y install" "${@}"
  }
  install_apt apt-transport-https
  install_apt autokey-gtk
  install_apt awesome
  install_apt curl
  install_apt dconf-editor
  install_apt haskell-stack
  install_apt htop
  install_apt libxft-dev
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
  install_apt sublime-merge
  install_apt sublime-text
  install_apt vim
  install_apt vlc
  install_apt xournal
  install_apt zsh
fi

if [ ! $1 ] || [ "$1" = "snap" ]
then
  install_snap() {
    install_program "sudo snap install" "${@}"
  }
  install_snap node --classic --channel=10
  install_snap spotify
  install_snap code --classic
  install_snap gotop-cjbassi
fi

if [ ! $1 ] || [ "$1" = "code" ]
then
  install_code() {
    install_program "code --install-extension" "${@}"
  }
  install_code anseki.vscode-color
  install_code arthurwang.vsc-prolog
  install_code bmewburn.vscode-intelephense-client
  install_code christian-kohler.path-intellisense
  install_code chrmarti.regex
  install_code dsznajder.es7-react-js-snippets
  install_code EditorConfig.EditorConfig
  install_code esbenp.prettier-vscode
  install_code fabiospampinato.vscode-highlight
  install_code formulahendry.auto-rename-tag
  install_code Fr43nk.seito-openfile
  install_code ikappas.phpcs
  install_code johnpyp.vscode-jumpy-plus
  install_code mohsen1.prettify-json
  install_code ms-python.python
  install_code neilbrayfield.php-docblocker
  install_code pranaygp.vscode-css-peek
  install_code pstreule.codebucket
  install_code ryu1kn.annotator
  install_code sissel.shopify-liquid
  install_code sleistner.vscode-fileutils
  install_code steoates.autoimport
  install_code travisthieman.better-search
  install_code vscode-icons-team.vscode-icons
  install_code waderyan.gitblame
  install_code WakaTime.vscode-wakatime
  install_code WallabyJs.quokka-vscode
  install_code wix.vscode-import-cost
  install_code wmaurer.change-case
  install_code wmaurer.vscode-jumpy
  install_code Zignd.html-css-class-completion
fi

if [ ! $1 ] || [ "$1" = "pip" ]
then
  install_pip() {
    install_program "pip3 install" "${@}"
  }
  install_pip awscli
fi

if [ ! $1 ] || [ "$1" = "stack" ]
then
  log "upgrading stack..."
  stack upgrade
  stack update
  log "done upgrading stack"
fi

if [ ! $1 ] || [ "$1" = "firsttime" ]
then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"
fi

log "done.\n"
cat $LOG_FILE