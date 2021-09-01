#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function setup_brew() {
  echo "Setting up brew..."
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  if [[ -z ${CI-} ]]; then
    brew bundle
  else
    # Install everything but the cask entries
    echo "Setting up brew without cask"
    cat Brewfile | grep -vE "cask " >Brewfile.alt
    mv Brewfile.alt Brewfile
    brew bundle
  fi
}

function setup_nix() {
  echo "Setting up nix..."
  if [[ -z ${CI-} ]]; then
    if ! [ -x "$(command -v nix)" ]; then
      # Install nix
      curl -L https://nixos.org/nix/install | sh

      # Install nix-darwin
      nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
      ./result/bin/darwin-installer
    fi
  fi
}

function setup_bash_it() {
  echo "Setting up bash-it..."
  if [ ! -d ~/.bash_it ]; then
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
  fi
}

function setup_volta() {
  echo "Setting up volta..."
  if ! [ -x "$(command -v volta)" ]; then
    curl https://get.volta.sh | bash
  fi
}

function setup_poetry() {
  echo "Setting up poetry..."
  if [[ ! -d ~/.poetry ]] && [[ -z ${CI-} ]]; then
    curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python3
  fi
}

function setup_pyenv() {
  echo "Setting up pyenv"
  if [[ -z ${CI-} ]]; then
    pyenv install -s 3.7.3
    pyenv global 3.7.3
  fi
}

function setup_code_extension() {
  echo "Setting up code extensions..."
  if [[ -z ${CI-} ]]; then
    cat "$(dirname $0)/../stow/vscode/extensions.txt" | while read extension; do
      code --install-extension $extension
    done
  fi
}

function setup() {
  setup_brew
  setup_nix
  setup_bash_it
  setup_volta
  setup_pyenv
  setup_poetry
  setup_code_extension
}

setup
