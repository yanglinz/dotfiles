#!/usr/bin/env bash

while IFS=$'\n' read -r line; do
  sh_targets+=("$line")
done < <(git ls-files | grep "\.sh\$")

sh_manual_targets=(
  git-churn
  git-cloc
  git-lg
  insecure-chrome
  mfa
  pbs-dns
  port-usage
  bash_profile
  bashrc
)

format_targets=("${sh_targets[@]}" "${sh_manual_targets[@]}")
for f in "${format_targets[@]}"; do
  echo "$f"
  git ls-files | grep "${f}\$" | xargs shfmt -i 2 -w -s -ci -kp
done
