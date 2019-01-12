#!/usr/bin/env bash

function setup_submodule() {
  echo "Setting up brew..."
  git submodule init
  git submodule update --recursive
}

function setup_brew() {
  echo "Setting up brew..."
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "Setting up brew bunldes..."
  brew tap homebrew/bundle
  brew bundle
}

function setup_nvm() {
  echo "Setting up nvm..."
  if [ ! -d ~/.nvm ]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
  fi
}

function setup_fonts() {
  echo "Setting up fonts..."
  ./vendor/fonts/install.sh
}

function setup_mac() {
  setup_submodule
  setup_brew
  setup_nvm
  setup_fonts
}

function setup() {
  echo "setup"
}

setup
