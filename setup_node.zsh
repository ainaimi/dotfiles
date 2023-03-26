#!/usr/bin/env zsh

echo "\n<<< Starting Node Setup >>>\n"

# Node versions are managed with `n`, whihc is in the brewfile
# see zshrc for N_PREFIX variable nad addition to PATH

if exists node; then
    echo "Node $(node --version) and NPM $(npm --version) already installed"
else
    echo "Installing Node and NPM with n ..."
    n latest
fi
