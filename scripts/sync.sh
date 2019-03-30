#!/usr/bin/env bash

function sync() {
  rsync --exclude ".DS_Store" \
    -avh --no-perms ./sync-home/ "$HOME"

  sudo rsync --exclude ".DS_Store" \
    --chown=root:wheel \
    --omit-dir-times \
    -avh --no-perms ./sync-root/ /
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
