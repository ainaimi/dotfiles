#!/usr/bin/env zsh

echo "\n<<< Starting Homebrew Setup >>>\n"

if exists brew; then
    echo "brew already installed, skipping ..."
else
    echo "brew not installed, installing ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# TODO: keep watch for different '--no-quarantine' solution.
# Currently, there is no '--no-quarantine' optioin for brew bundle
# It's in zshrc:
# export HOMEBREW_CASK_OPTS="--no-quarantine"
# https://github.com/Homebrew/homebrew-bundle/issues/474

brew bundle --verbose
