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

if sh --version | grep -q zsh; then
    echo '/bin/zsh already linked to /private/var/select/sh'
else
    echo "Enter user password to symlink sh to zsh"
    # this didn't work the way we wanted to so reverted back.
    ## this runs the original version fo zsh, not the homebrew version of zsh
    sudo ln -sfv /bin/zsh /private/var/select/sh

    # we tried to get this to work, but wouldn't symlink
    ## this would run the homebrew version of zsh, but didn't work
    # sudo ln -sfv /opt/homebrew/bin/zsh /private/var/select/sh
fi