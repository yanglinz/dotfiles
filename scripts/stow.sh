#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

VSCODE_PATH="/Users/${USER}/Library/ApplicationSupport/Code/User"

function validate_cwd() {
  local expected_cwd_files=(
    "macos/setup/bootstrap.sh"
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

  cd ./stow

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

  cd - &>/dev/null
}

function stow_unlink() {
  validate_cwd

  cd ./stow

  stow -t $HOME -D git
  echo -e "${RED}Linked git${RESET}"

  stow -t $HOME -D nix
  echo -e "${RED}Linked nix${RESET}"

  stow -t $HOME -D shell
  echo -e "${RED}Linked shell${RESET}"

  stow -t $HOME -D vim
  echo -e "${RED}Linked vim${RESET}"

  mkdir -p $VSCODE_PATH
  stow -t $VSCODE_PATH -D vscode
  echo -e "${RED}Linked vscode${RESET}"

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
