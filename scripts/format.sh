#!/usr/bin/env bash

sh_targets=($(git ls-files | grep "\.sh\$"))

sh_manual_targets=(
  git-churn
  git-cloc
  git-lg
  insecure-chrome
  port-usage
  bash_profile
  bashrc
)

format_targets=("${sh_targets[@]}" "${sh_manual_targets[@]}")
for f in "${format_targets[@]}"; do
  git ls-files | grep "${f}\$" | xargs shfmt -i 2 -w -s -ci -kp
done
