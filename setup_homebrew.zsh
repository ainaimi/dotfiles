#!/usr/bin/env zsh

echo "\n<<< Starting Homebrew Setup >>>\n"

if command -v brew >/dev/null 2>&1; then
    echo "brew already installed, skipping ..."
else
    echo "brew not installed, installing ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# On a fresh machine the installer does not modify this shell's PATH
if ! command -v brew >/dev/null 2>&1 && [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew bundle --verbose
