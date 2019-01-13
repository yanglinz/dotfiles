#!/usr/bin/env bash

function is_macos() {
  ./scripts/utils/osname.py | grep -q "Darwin" 
}

function is_linux() {
  ./scripts/utils/osname.py | grep -q "Linux"
}

function is_work_profile() {
  ./scripts/utils/profile.py | grep -q "profile:work"
}

function is_personal_profile() {
  ./scripts/utils/profile.py | grep -q "profile:personal"
}

function replace_and_backup() {
  declare -r source="$1"
  declare -r target="$2"

  cp -n "${target}" "${target}.bak"
  cp "${source}" "${target}"
}
