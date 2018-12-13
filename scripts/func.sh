#!/usr/bin/env bash

function replace_and_backup() {
  local source="$1"
  local target="$2"

  cp -n "${target}" "${target}.bak"
  cp "${source}" "${target}"
}
