#!/usr/bin/env bash

# Modify the output color of echo statements
# https://en.wikipedia.org/wiki/ANSI_escape_code
green="\033[0;32m"
red="\033[0;31m"

active_dotfiles=(bash fish git tmux vim zsh)
vscode_conf_path="/Users/$(whoami)/Library/Application Support/Code/User"

function init() {
  # Initialize git submodule
  git submodule init

  # Setup homebrew
  brew tap homebrew/bundle
  brew bundle

  # Install fonts
  ./vendor/fonts/install.sh
}

function link() {
  echo "Linking dotfiles..."

  # Stow dotfiles
  cd dotfiles
  for d in "${active_dotfiles[@]}"; do
    stow -t $HOME "${d}" && echo -e "${green}Linked ${d}"
  done
  cd -

  # Stow code settings
  if [ -x "$(command -v code)" ]; then
    code --list-extensions > ./vscode/extensions.txt
    stow --adopt -t "${vscode_conf_path}" vscode && echo -e "${green}Linked vscode"
  fi
}

function unlink() {
  echo "Unlinking dotfiles"

  # Unstow dotfiles
  cd dotfiles
  for d in "${active_dotfiles[@]}"; do
    stow -t $HOME -D "${d}" && echo -e "${red}Unlinked ${d}"
  done
  cd -

  # Unstow code settings
  if [ -x "$(command -v code)" ]; then
    stow -t "${vscode_conf_path}" -D vscode && echo -e "${red}Unlinked vscode"
  fi
}

function default() {
  echo "Welcome to the dotfiles script!"
}

case "$1" in
  init)   init ;;
  link)   link ;;
  unlink) unlink ;;
  *)      default ;;
esac
