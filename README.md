# dotfiles

Personal macOS setup for an Apple Silicon Mac: [Dotbot](https://github.com/anishathalye/dotbot) symlinks, a curated Homebrew `Brewfile`, and zsh configuration (powerlevel10k prompt, no framework). Everything replaceable is fetched at install time; this repo tracks only my own configuration. No secrets are ever tracked.

## Fresh-machine install

1. Install the Command Line Tools: `xcode-select --install`
2. Sign in to the Mac App Store (required for the `mas` apps, including Xcode)
3. Clone and run:

   ```sh
   cd ~ && git clone https://github.com/ainaimi/dotfiles.git
   cd dotfiles && ./install.sh 2>&1 | tee setup.log
   ```

   Expect interactive prompts along the way: the Homebrew installer (password + Enter), sudo for `/etc/shells` and macOS defaults, and the login-shell change.
4. If Xcode was installed, accept its license: `sudo xcodebuild -license accept`
5. Open a new terminal — prompt, plugins, and PATH should all be live. Some macOS settings need a logout/restart.

### What install.sh does

`install.sh` initializes the Dotbot submodule and runs Dotbot with `install.conf.yaml`, which:

- creates `~/.ssh` (mode 0700), `~/.config`, `~/projects`
- links `~/.zshrc`, `~/.zshenv`, `~/.p10k.zsh`, git config, SSH config (`~/.ssh/config`, `~/.ssh/allowed_signers`), bat/RStudio config, and VS Code settings into this repo
- runs `setup_homebrew.zsh` — installs Homebrew if missing, then `brew bundle` (all formulae, casks, App Store apps, and VS Code extensions come from the `Brewfile`)
- runs `setup_zsh.zsh` — makes Homebrew's zsh the login shell; sets the default ruby (`~/.ruby-version`) and node (`nodenv`)
- runs `setup_macos.zsh` — macOS defaults (several sudo prompts)

## Manual steps after install

- Sign in: Dropbox, 1Password
- Alfred: preferences live in `~/Dropbox/appdata/Alfred.alfredpreferences` (synced by Dropbox, not this repo) — on a new machine, set Alfred → Advanced → Syncing to `~/Dropbox/appdata`
- iTerm2: Settings → General → Settings → "Load preferences from a custom folder" → `~/dotfiles/config/iterm2`
- SSH: sign in to 1Password and enable its SSH agent (Settings → Developer → "Use the SSH agent") — all keys live in the vault, so a new machine needs no key files. Host-specific config (cluster hostname/username) goes in `~/.ssh/config.local`, which is intentionally untracked.

## Managing packages

The `Brewfile` is the source of truth — edit it by hand:

- **Add** a package: add its line, then `brew bundle install`
- **Remove** a package: delete its line, then `brew bundle cleanup --force`
- **Check drift**: `bbd` (alias) dumps the machine's actual state to `/tmp` and diffs it against the `Brewfile`, so ad-hoc installs are easy to spot and either adopt or remove
- **Update everything**: run `update` (zshrc function) — it chains `brew upgrade` → `brew autoremove` → `brew cleanup` → `mas upgrade` → `juliaup update`, skipping any tool that isn't installed. Plain `brew upgrade` works too; R updates through the `r-app` cask (the official CRAN build — no manual downloads). Self-updating apps (Chrome, Slack, VS Code, …) are intentionally left to update themselves; VS Code extensions and R packages update inside their own apps.

## Layout

| Path | Purpose |
|---|---|
| `install.sh`, `install.conf.yaml` | Dotbot bootstrap and link/setup manifest |
| `Brewfile` | all software: formulae, casks, App Store apps, VS Code extensions |
| `zshrc`, `zshenv`, `p10k.zsh` | shell configuration (linked into `~`) |
| `git/` | git config and global ignore file |
| `ssh/` | portable SSH config (1Password agent wiring + include of untracked `~/.ssh/config.local`) and `allowed_signers` for commit-signature verification |
| `config/bat`, `config/rstudio`, `config/vscode` | app configs (linked) |
| `config/iterm2` | iTerm2 settings plist (loaded via iTerm2's custom-folder setting) |
| `setup_*.zsh` | install steps run by Dotbot's shell directive |
| `dotbot/` | Dotbot itself (git submodule) |

## Design notes

- The zsh setup is deliberately framework-free: powerlevel10k, zsh-autosuggestions, and zsh-syntax-highlighting are installed by Homebrew and sourced directly in `zshrc`; `zoxide` provides directory jumping (`z`, aliased to `cd`)
- R is the official CRAN build (`r-app` cask), which RStudio detects natively and which installs precompiled CRAN binaries; the Homebrew `r` formula is intentionally not used
- Julia is managed by `juliaup`; Python by `uv`/`pipx`/`miniforge`; Ruby by `chruby`/`ruby-install`; Node by `nodenv`
- SSH keys exist only inside the 1Password SSH agent, never as files on disk; the tracked `ssh/config` just wires the agent and includes the untracked `~/.ssh/config.local`; `known_hosts` is never tracked
- Git: all `https://github.com/` remotes are transparently rewritten to SSH (`url.insteadOf`), and commits are SSH-signed through the 1Password key (`gpg.format = ssh`, verifiers listed in the tracked `ssh/allowed_signers`)
