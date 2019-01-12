#!/usr/bin/env bash

# Functions

function replace_and_backup() {
  declare -r source="$1"
  declare -r target="$2"

  cp -n "${target}" "${target}.bak"
  cp "${source}" "${target}"
}
