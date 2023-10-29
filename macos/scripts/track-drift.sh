#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

DOTFILES_REPO_DIR=$(pwd)

brew bundle dump --force && sort Brewfile -o Brewfile
code --list-extensions | sort -f > ./macos/drift/vscode-extensions.txt
