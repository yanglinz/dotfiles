#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

source scripts/utils/func.sh

function setup_submodule() {
  echo "Setting up submodule..."
  git submodule init
  git submodule update --recursive
}

function setup_bash_it() {
  echo "Setting up bash-it..."
  if [ ! -d ~/.bash_it ]; then
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
  fi
}

function setup_nvm() {
  echo "Setting up nvm..."
  if [ ! -d ~/.nvm ]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
  fi
}

function setup_rust() {
  echo "Setting up rust..."
  if [ ! -d ~/.cargo ] && [ -z "$CI" ]; then
    curl https://sh.rustup.rs -sSf | sh
  fi
}

function setup_poetry() {
  echo "Setting up poetry..."
  if [ ! -d ~/.poetry ] && [ -z "$CI" ]; then
    curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python
  fi
}

function setup_brew() {
  echo "Setting up brew..."
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "Setting up brew bundles..."
  brew tap homebrew/core
  brew tap homebrew/services
  brew tap homebrew/bundle
  brew tap homebrew/cask
  brew tap homebrew/cask-versions
  brew tap heroku/brew
  brew tap netlify/netlifyctl

  brew bundle
}

function setup_apt() {
  echo "Setting up apt"

  sudo apt-get update
  sudo apt-get install dos2unix
  sudo apt-get install fish
  sudo apt-get install tmux
  sudo apt-get install zsh
  sudo apt-get install stow
}

function setup() {
  setup_submodule

  if is_macos; then
    setup_brew
  fi

  if is_linux; then
    setup_apt
  fi

  setup_bash_it
  setup_nvm
  setup_rust
}

setup
