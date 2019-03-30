#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

source scripts/utils/func.sh

function setup_fonts() {
  echo "Setting up fonts..."
  ./vendor/fonts/install.sh
}
function setup() {
  if is_macos; then
    setup_fonts
  fi
}

setup
