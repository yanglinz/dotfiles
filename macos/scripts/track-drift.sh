#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

DOTFILES_REPO_DIR=$(pwd)

brew bundle dump --force && sort Brewfile -o Brewfile
code --list-extensions | sort -f > ./macos/drift/vscode-extensions.txt

# We have to cd to a different direactory to avoid volta outputting repo local tool versions 
(cd ~ && volta list > "${DOTFILES_REPO_DIR}/macos/drift/volta-list.txt")

cp ~/.iterm/com.googlecode.iterm2.plist ./macos/home/iterm/
