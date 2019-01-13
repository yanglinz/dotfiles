#!/usr/bin/env bash

source scripts/utils/colors.sh
source scripts/utils/func.sh

vscode_conf_path="/Users/$(whoami)/Library/Application Support/Code/User"

# Build a list of dotfiles to sync and unsync
# Common dotfiles are shared across all profiles and environments
common_dotfiles=(
  bash
  bin
  fish
  iterm
  tmux
  vim
)

# Work and personal profile determine which dotfiles to sync based on profile
work_dotfiles=("git.work" "ssh.work")
personal_dotfiles=("aws.personal" "git.personal" "ssh.personal")

link_dotfiles=()
if is_work_profile; then
  link_dotfiles=("${common_dotfiles[@]}" "${work_dotfiles[@]}")
fi
if is_personal_profile; then
  link_dotfiles=("${common_dotfiles[@]}" "${personal_dotfiles[@]}")
fi

function link() {
  echo "Linking dotfiles..."

  # Stow dotfiles
  cd dotfiles || exit
  for d in "${link_dotfiles[@]}"; do
    stow -t "$HOME" "$d" && \
      echo -e "${GREEN}Linked ${d}${RESET}"
  done
  cd - || exit

  # Stow code settings
  if is_macos; then
    stow --adopt -t "$vscode_conf_path" vscode && \
      echo -e "${GREEN}Linked vscode${RESET}"
  fi
}

function unlink() {
  echo "Unlinking dotfiles"

  # Unstow dotfiles
  cd dotfiles || exit
  for d in "${link_dotfiles[@]}"; do
    stow -t "$HOME" -D "$d" && \
      echo -e "${RED}Unlinked ${d}${RESET}"
  done
  cd - || exit

  # Unstow code settings
  if is_macos; then
    stow -t "$vscode_conf_path" -D vscode && \
      echo -e "${RED}Unlinked vscode${RESET}"
  fi
}

function sync() {
  echo "Syncing dotfiles..."
  
  if is_macos; then
    brew bundle dump --force
    code --list-extensions > ./vscode/extensions.txt
  fi
}

function default() {
  echo "Welcome to the dotfiles script!"
}

case "$1" in
  link)   link ;;
  unlink) unlink ;;
  sync)   sync ;;
  *)      default ;;
esac
