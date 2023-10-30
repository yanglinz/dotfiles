#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

VSCODE_PATH="/Users/${USER}/Library/Application Support/Code/User"

function validate_cwd() {
  local expected_cwd_files=(
    "macos/scripts/bootstrap.sh"
    Brewfile
    Makefile
  )

  for f in "${expected_cwd_files[@]}"; do
    if [[ ! -f $f   ]]; then
      echo "Expected file \"${f}\" does not exist."
      exit 1
    fi
  done
}

function stow_link() {
  validate_cwd

  cd ./macos/home

  stow -t $HOME bin
  echo -e "${GREEN}Linked bin${RESET}"

  stow -t $HOME git
  echo -e "${GREEN}Linked git${RESET}"

  stow -t $HOME nix
  echo -e "${GREEN}Linked nix${RESET}"

  stow -t $HOME shell
  echo -e "${GREEN}Linked shell${RESET}"

  stow -t $HOME vim
  echo -e "${GREEN}Linked vim${RESET}"

  mkdir -p $VSCODE_PATH
  stow -t $VSCODE_PATH vscode
  echo -e "${GREEN}Linked vscode${RESET}"

  stow -t $HOME vscode-extensions
  echo -e "${GREEN}Linked vscode-extensions${RESET}"

  cd - &>/dev/null
}

function stow_unlink() {
  validate_cwd

  cd ./macos/home

  stow -t $HOME -D bin
  echo -e "${RED}Unlinked bin${RESET}"

  stow -t $HOME -D git
  echo -e "${RED}Unlinked git${RESET}"

  stow -t $HOME -D nix
  echo -e "${RED}Unlinked nix${RESET}"

  stow -t $HOME -D shell
  echo -e "${RED}Unlinked shell${RESET}"

  stow -t $HOME -D vim
  echo -e "${RED}Unlinked vim${RESET}"

  mkdir -p $VSCODE_PATH
  stow -t $VSCODE_PATH -D vscode
  echo -e "${RED}Unlinked vscode${RESET}"

  stow -t $HOME -D vscode-extensions
  echo -e "${RED}Unlinked vim${RESET}"

  cd - &>/dev/null
}

subcommand="${1-unknown}"
case "$subcommand" in
  "link")
    stow_link
    ;;
  "unlink")
    stow_unlink
    ;;
  *)
    echo "Unknown subcommand \"${subcommand}\""
    exit 1
    ;;
esac
