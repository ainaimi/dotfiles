#!/bin/bash

dotfiles_dir="$HOME"/dotfiles
echo dotfiles_dir
if [ "$PWD" = "$dotfiles_dir" ]; then
  ./save_code_extensions.sh
  git add code_extensions
fi