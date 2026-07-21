#!/usr/bin/env zsh

echo "\n<<< Starting ZSH Setup >>>\n"

# --- Homebrew zsh as an approved login shell ---
if grep -Fxq '/opt/homebrew/bin/zsh' '/etc/shells'; then
    echo "/opt/homebrew/bin/zsh already in /etc/shells, skipping ..."
else
    echo "Enter superuser (sudo) password to add it to /etc/shells"
    echo '/opt/homebrew/bin/zsh' | sudo tee -a '/etc/shells' >/dev/null
fi

if [ "$SHELL" = '/opt/homebrew/bin/zsh' ]; then
    echo '$SHELL is already /opt/homebrew/bin/zsh'
elif [ -x '/opt/homebrew/bin/zsh' ]; then
    echo "Enter user password to change the login shell"
    chsh -s '/opt/homebrew/bin/zsh'
else
    echo "WARNING: /opt/homebrew/bin/zsh not found (did brew bundle fail?); keeping current login shell"
fi

# --- Default ruby for chruby (see zshrc) ---
if [ ! -f "$HOME/.ruby-version" ]; then
    echo 'ruby-3.4.4' > "$HOME/.ruby-version"
fi

# --- Node via nodenv ---
if command -v nodenv >/dev/null 2>&1; then
    nodenv install --skip-existing 22.17.0
    nodenv global 22.17.0
fi
