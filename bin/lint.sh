#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

while IFS=$'\n' read -r line; do
  sh_targets+=("$line")
done < <(git ls-files | grep "\.sh\$")

sh_manual_targets=(
  git-churn
  git-cloc
  git-lg
  insecure-chrome
  sdns
  port-usage
  bash_profile
  bashrc
)

format_targets=("${sh_targets[@]}" "${sh_manual_targets[@]}")
for f in "${format_targets[@]}"; do
  echo "$f"
  git ls-files | grep "${f}\$" | xargs shellcheck
done
