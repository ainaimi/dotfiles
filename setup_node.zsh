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


# Install Global NPM Packages

#### not clear on my use case for this yet. doing to follow along in course...

npm install --global firebase-tools
npm install --global @angular/cli
npm install --global @ionic/cli

npm install --global typescript
npm install --global json-server
npm install --global http-server

echo "Global NPM Packages Installed:"
npm list --global --depth=0