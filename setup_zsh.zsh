#!/usr/bin/env zsh

echo "\n<<< Starting ZSH Setup >>>\n"


if grep -Fxq '/opt/homebrew/bin/zsh' '/etc/shells'; then
    echo "/opt/homebrew/bin/zsh already in shells folder, skipping ..."
else
    echo "Enter superuser (sudo) password to edit /etc/shells"
    echo '/opt/homebrew/bin/zsh' | sudo tee -a '/etc/shells' >/dev/null
fi

if [ "$SHELL" = "/opt/homebrew/bin/zsh" ]; then
    echo '$SHELL is already /opt/homebrew/bin/zsh'
else
    echo "Enter user password to change the login shell"
    chsh -s '/opt/homebrew/bin/zsh'
fi

echo "Enter user password to symlink sh to zsh"
# this didn't work the way we wanted to so reverted back.
sudo ln -sfv /bin/zsh /private/var/select/sh