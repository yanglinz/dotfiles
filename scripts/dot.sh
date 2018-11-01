#!/usr/bin/env bash

# Modify the output color of echo statements
# https://en.wikipedia.org/wiki/ANSI_escape_code
green="\033[0;32m"
red="\033[0;31m"

vscode_conf_path="/Users/$(whoami)/Library/Application Support/Code/User"

# Determine which dotfiles to sync based on profile
active_dotfiles=()
if python3 ./scripts/profile.py | grep -q "profile:personal"; then
  active_dotfiles=(bash fish git iterm tmux vim zsh)
fi
if python3 ./scripts/profile.py | grep -q "profile:work"; then
  active_dotfiles=(bash fish git iterm tmux vim zsh)
fi

function setup_submodule() {
  # Initialize git submodule
  git submodule init
  git submodule update --recursive
}

function setup_brew() {
  echo "Setting up brew..."

  # Install brew
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "Setting up brew bunldes..."
  # Install brew bundles
  brew tap homebrew/bundle
  brew bundle
}

function setup_nvm() {
  echo "Setting up nvm..."

  # Install nvm
  if [ ! -d ~/.nvm ]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
  fi
}

function setup_fonts() {
  echo "Setting up fonts..."

   # Install fonts
  ./vendor/fonts/install.sh
}

function setup() {
  setup_submodule
  setup_brew
  setup_nvm
  setup_fonts
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
  stow --adopt -t "${vscode_conf_path}" vscode && echo -e "${green}Linked vscode"
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
  stow -t "${vscode_conf_path}" -D vscode && echo -e "${red}Unlinked vscode"
}

function sync() {
  echo "Syncing dotfiles..."

  brew bundle dump --force
  code --list-extensions > ./vscode/extensions.txt
}

function default() {
  echo "Welcome to the dotfiles script!"
}

case "$1" in
  setup)  setup ;;
  link)   link ;;
  unlink) unlink ;;
  sync)   sync ;;
  *)      default ;;
esac
