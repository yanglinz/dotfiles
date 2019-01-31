#!/usr/bin/env bash

source scripts/utils/colors.sh
source scripts/utils/func.sh

function copy() {
  source=""
  if is_macos; then
    source="sync/macos/.ssh"
  fi
  if is_linux; then
    source="sync/linux/.ssh"
  fi

  rsync -avh "$source" ~
}

copy
