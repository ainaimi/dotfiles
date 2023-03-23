#!/usr/bin/env zsh

echo "\n<<< Starting Homebrew Setup >>>\n"

if exists brew; then
    echo "brew already installed, skipping ..."
else
    echo "brew not installed, installing ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ## formulae
# brew install httpie
# brew install bat

# ## casks 
# brew install --no-quarantine --cask google-chrome
# brew install --no-quarantine --cask visual-studio-code
# brew install --no-quarantine --cask alfred

brew bundle --verbose
