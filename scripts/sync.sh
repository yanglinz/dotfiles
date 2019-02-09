#!/usr/bin/env bash

function sync() {
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    -avh --no-perms ./sync/ "$HOME"
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
  sync
else
  read -r -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    sync
  fi
fi
unset sync
