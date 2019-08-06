#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

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
  if [[ ! -d ~/.cargo ]] && [[ -z ${CI-} ]]; then
    curl https://sh.rustup.rs -sSf | sh
  fi
}

function setup_poetry() {
  echo "Setting up poetry..."
  if [[ ! -d ~/.poetry ]] && [[ -z ${CI-} ]]; then
    curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python3
  fi
}

function setup_brew() {
  echo "Setting up brew..."
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  if [[ -z ${CI-} ]]; then
    brew bundle
  else
    brew bundle --cask
  fi
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

function setup_pyenv() {
  echo "Setting up pyenv"
  if [[ -z ${CI-} ]]; then
    pyenv install -s 3.7.3
    pyenv global 3.7.3
  fi
}

function setup() {
  [[ $OSTYPE == "darwin18"   ]] && setup_brew

  setup_bash_it
  setup_nvm
  setup_rust
  setup_pyenv
}

setup
