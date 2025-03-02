# dotfiles and OS Setup

This repository contains dotfiles, OS setup files, Brew binaries, Mac Apps, VSCode extensions and other files that I use. 

## General procedure for a new machine:

0) Install dev tools using: `xcode-select --install`
1) cd into ~ and git clone dotfiles repository
2) run install.sh and route all output to file using: `./install.sh > dotfiles_setup_output.txt 2>&1`
3) debug ...

## After installs successfully run:

- Airdrop alfred preferences folder from /dotfiles/config to new computer



## TODOs
- [ ] 1Password settings
- [ ] Dropbox login and settings
- [ ] Programmatically install `code` CLI, w/o having to open up vscode
- [ ] Add conditional to check if vscode extensions already installed
- :ballot_box_with_check: Terminal Preferences from iTerm2
- :ballot_box_with_check: Install and Adapt VS Code Including:
    - :ballot_box_with_check: All user preferences in settings.json
    - :ballot_box_with_check: all extensions (see https://is.gd/FM4lyO)
    - :ballot_box_with_check: Add separate GH repo specific to VS Code installs R for liveshare
        - :ballot_box_with_check: Make this mac and windows friendly
- [ ] SSH configurations
    - [ ] for GH
    - [ ] for computing cluster


## Notes 

- :ballot_box_with_check: Use brew install watchman to avoid macOS GateKeeper: 
    - https://is.gd/DWmfDD
- Security:
    - https://is.gd/ql1EXR
- Add gitmessage: 
    - https://is.gd/qCHpR3