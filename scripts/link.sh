#!/usr/bin/env bash

function sync() {
  echo "Syncing dotfiles..."

  if is_macos; then
    brew bundle dump --force
    code --list-extensions >./vscode/extensions.txt
  fi
}

function default() {
  echo "Welcome to the dotfiles script!"
}

case "$1" in
  sync) sync ;;
  *) default ;;
esac
