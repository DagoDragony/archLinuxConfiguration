#!/usr/bin/env bash

path="$HOME/.scripts/tools/transadd"

if [[ -f $path ]]; then
  echo "existing file"
elif [[ -d $path ]]; then
  echo "existing directory"
else
  echo "unrecognized"
fi