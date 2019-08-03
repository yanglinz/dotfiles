#!/usr/bin/env bash

function is_work_profile() {
  ./scripts/utils/profile.py | grep -q "profile:work"
}

function is_personal_profile() {
  ./scripts/utils/profile.py | grep -q "profile:personal"
}

function slugify() {
  declare -r str="$1"

  # Replace all / with -
  echo "$str" | sed 's/\//-/g'
}

function replace_and_backup() {
  declare -r source="$1"
  declare -r target="$2"

  cp -n "${target}" "${target}.bak"
  cp "${source}" "${target}"
}
