#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function sync() {
  rsync -avzh \
    --exclude ".DS_Store" \
    --no-perms \
    --max-delete=0 \
    ./macos/home/ "$HOME"

  sudo rsync -avzh \
    --exclude ".DS_Store" \
    --omit-dir-times \
    --omit-link-times \
    --max-delete=0 \
    --keep-dirlinks \
    --no-perms \
    --chown=root:wheel \
    ./macos/root/ /

  # Fix brew permissions
  sudo chown -R "$(whoami)" /usr/local/etc
}

if [ "${1-}" == "--force" ] || [ "${1-}" == "-f" ]; then
  sync
else
  read -r -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    sync
  fi
fi
unset sync
