#!/usr/bin/env bash

source scripts/utils/colors.sh

copy_dotfiles=(
  ".ssh"
)

function copy() {
  for d in "${copy_dotfiles[@]}"; do
    echo -e "${GREEN}Copying ${d}${RESET}"
    rsync -avh "./sync/${d}" ./test-sync;
  done
}

copy
