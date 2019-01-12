#!/usr/bin/env bash

source scripts/utils/colors.sh
source scripts/utils/func.sh

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
personal_dotfiles=("aws.personal" "git.personal" "ssh.personal")

# Determine which dotfiles to sync based on profile
active_dotfiles=()
if is_work_profile; then
  active_dotfiles=("${common_dotfiles[@]}" "${work_dotfiles[@]}")
fi
if is_personal_profile; then
  active_dotfiles=("${common_dotfiles[@]}" "${personal_dotfiles[@]}")
fi

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
  link)   link ;;
  unlink) unlink ;;
  sync)   sync ;;
  *)      default ;;
esac
