#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

brew bundle dump --force && sort Brewfile -o Brewfile
code --list-extensions | sort -f > ./macos/manifest/vscode-extensions.txt
volta list --format=plain > ./macos/manifest/volta-list.txt

SPECTACLE_SHORTCUT="~/Library/Application Support/Spectacle/Shortcuts.json"
[[ -f "$SPECTACLE_SHORTCUT" ]] && cp "$SPECTACLE_SHORTCUT" ./macos/manifest/spectacle.json

cp ~/.iterm/com.googlecode.iterm2.plist ./macos/home/iterm/
