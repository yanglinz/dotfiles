#!/usr/bin/env bash

git ls-files | grep "\.sh\$" | xargs shfmt -i 2 -w -s -ci -kp
