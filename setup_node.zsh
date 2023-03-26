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

# npm uninstall --global firebase-tools
# npm uninstall --global @angular/cli
# npm uninstall --global @ionic/cli

# npm uninstall --global typescript
# npm uninstall --global json-server
# npm uninstall --global http-server
npm install --location=global trash-cli

echo "Global NPM Packages Installed:"
npm list --location=global --depth=0