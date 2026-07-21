# Brewfile — curated by hand. This file leads; the machine follows.
#   Add something:    add a line here, then `brew bundle install`
#   Remove something: delete the line here, then `brew bundle cleanup --force`
#   Check for drift:  `bbd` (dumps current machine state to /tmp and diffs it against this file)

# --- Core CLI ---
brew "coreutils"
brew "git"
brew "git-filter-repo"
brew "git-lfs"
brew "gh"
brew "jq"
brew "less"
brew "bat"
brew "bat-extras"
brew "eza"
brew "zoxide"
brew "zsh"
brew "mas"
brew "httpie"
brew "nmap"
brew "neovim"
brew "cmatrix"

# --- Shell prompt & plugins (sourced in zshrc) ---
brew "powerlevel10k"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

# --- Build toolchain (R packages compile with these; gcc provides gfortran) ---
brew "cmake"
brew "gcc"
brew "libomp", link: true
brew "openjdk"

# --- Languages & version managers ---
# R itself comes from the CRAN build (cask "r-app" below), not the brew formula
brew "juliaup"
brew "uv"
brew "pipx"
brew "chruby"
brew "ruby-install"
brew "nodenv"
brew "yarn"

# --- Documents & academic pipeline ---
brew "pandoc"
brew "bib-tool"
brew "ghostscript"
brew "imagemagick"
brew "ffmpeg"
brew "qpdf"
brew "poppler"
brew "manim"

# --- Cloud / dev misc ---
brew "awscli"
brew "pre-commit"
brew "ollama"
brew "opencode"

# --- Casks: applications ---
cask "1password"
cask "1password-cli"
cask "adobe-acrobat-reader"
cask "alfred"
cask "anki"
cask "bartender"
cask "caffeine"
cask "claude-code"
cask "codex"
cask "ddpm"
cask "dropbox"
cask "firefox"
cask "gimp"
cask "gitkraken"
cask "google-chrome"
cask "google-drive"
cask "istat-menus"
cask "iterm2"
cask "keycastr"
cask "keymapp"
cask "libreoffice"
cask "mactex"
cask "miniforge"
cask "notion"
cask "obs"
cask "obsidian"
cask "quarto"
cask "r-app"
cask "raindropio"
cask "rstudio"
cask "slack"
cask "spotify"
cask "steam"
cask "superhuman"
cask "telegram"
cask "texifier"
cask "transmit"
cask "visual-studio-code"
cask "whatsapp"
cask "zettlr"
cask "zotero"

# --- Fonts ---
cask "font-libertinus"
cask "font-libertinus-math"
cask "font-libertinus-mono"
cask "font-libertinus-sans"
cask "font-libertinus-serif"
cask "font-mononoki-nerd-font"
# required by iTerm2 profile + VS Code terminal (MesloLGS NF)
cask "font-meslo-lg-nerd-font"

# --- Mac App Store (requires being signed in to the App Store first) ---
mas "Apple Configurator", id: 1037126344
mas "Drafts", id: 1435957248
mas "Fantastical", id: 975937182
mas "GarageBand", id: 682658836
mas "iMovie", id: 408981434
mas "Keynote", id: 409183694
mas "Magnet", id: 441258766
mas "Numbers", id: 409203825
mas "Pages", id: 409201541
mas "PDF Expert", id: 1055273043
mas "Todoist", id: 585829637
mas "Xcode", id: 497799835

# --- VS Code extensions (single source of truth; brew bundle installs these) ---
vscode "andrewberty.noir-theme-bundle"
vscode "anthropic.claude-code"
vscode "be5invis.vscode-custom-css"
vscode "enkia.tokyo-night"
vscode "james-yu.latex-workshop"
vscode "julialang.language-julia"
vscode "maltehei.latex-citations"
vscode "ms-python.debugpy"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-python.vscode-python-envs"
vscode "ms-toolsai.jupyter"
vscode "ms-toolsai.jupyter-keymap"
vscode "ms-toolsai.jupyter-renderers"
vscode "ms-toolsai.vscode-jupyter-cell-tags"
vscode "ms-toolsai.vscode-jupyter-slideshow"
vscode "ms-vscode.makefile-tools"
vscode "ms-vsliveshare.vsliveshare"
vscode "rdebugger.r-debugger"
vscode "reditorsupport.r"
vscode "reditorsupport.r-syntax"
vscode "rickaym.manim-sideview"
vscode "yzane.markdown-pdf"
