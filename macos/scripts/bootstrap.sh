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

function setup() {
  setup_brew
  setup_nix
}

setup
