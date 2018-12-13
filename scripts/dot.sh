#!/usr/bin/env bash

source scripts/global.sh

vscode_conf_path="/Users/$(whoami)/Library/Application Support/Code/User"

common_dotfiles=(
  bash
  bin
  fish
  iterm
  tmux
  vim
  zsh
)
work_dotfiles=("git.work" "ssh.work")
personal_dotfiles=("git.personal" "ssh.personal")

# Determine which dotfiles to sync based on profile
active_dotfiles=()
if python3 ./scripts/profile.py | grep -q "profile:work"; then
  active_dotfiles=("${common_dotfiles[@]}" "${work_dotfiles[@]}")
fi
if python3 ./scripts/profile.py | grep -q "profile:personal"; then
  active_dotfiles=("${common_dotfiles[@]}" "${personal_dotfiles[@]}")
fi

function setup_submodule() {
  # Initialize git submodule
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

function setup() {
  setup_submodule
  setup_brew
  setup_nvm
  setup_fonts
}

function link() {
  echo "Linking dotfiles..."

  # Stow dotfiles
  cd dotfiles || exit
  for d in "${active_dotfiles[@]}"; do
    stow -t "$HOME" "$d" && echo -e "${GREEN}Linked ${d}${RESET}"
  done
  cd - || exit

  # Stow code settings
  stow --adopt -t "$vscode_conf_path" vscode && echo -e "${GREEN}Linked vscode${RESET}"
}

function unlink() {
  echo "Unlinking dotfiles"

  # Unstow dotfiles
  cd dotfiles || exit
  for d in "${active_dotfiles[@]}"; do
    stow -t "$HOME" -D "$d" && echo -e "${RED}Unlinked ${d}${RESET}"
  done
  cd - || exit

  # Unstow code settings
  stow -t "$vscode_conf_path" -D vscode && echo -e "${RED}Unlinked vscode${RESET}"
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
