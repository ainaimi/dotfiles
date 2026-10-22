# --- Powerlevel10k instant prompt (must stay at the very top; no console output above) ---
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- History ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# --- Keybindings & completion ---
bindkey -e
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

# --- Prompt: Powerlevel10k (installed via Homebrew; config in ~/.p10k.zsh) ---
[[ -f /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]] && \
  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- Environment ---
export NULLCMD=bat
export LDFLAGS="-L/opt/homebrew/opt/libomp/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libomp/include"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# 1Password SSH agent: ssh finds it via ssh/config's IdentityAgent, but
# ssh-add/ssh-copy-id only look at SSH_AUTH_SOCK, so export it too.
_1p_sock="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
[[ -S "$_1p_sock" ]] && export SSH_AUTH_SOCK="$_1p_sock"
unset _1p_sock

# --- PATH ---
typeset -U path
path=(
  /opt/homebrew/bin
  /opt/homebrew/opt/openjdk/bin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  /Library/TeX/texbin
  /Applications/iTerm.app/Contents/Resources/utilities
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  "$HOME/bin"
  "$HOME/.local/bin"
  $path
)

# --- Aliases ---
alias ls="eza --icons --long --header"
alias trail='<<<${(F)path}'
alias rm=trash
alias cd="z"  # zoxide; overrides builtin 'cd'
alias init-grant='bash ~/Dropbox/03\ Resources/AI_assistants/grant-templates/init-grant-project.sh'

# --- Functions ---
function mkcd() {
  mkdir -p "$@" && cd "$_";
}

# Brewfile drift check: compare what the Brewfile declares against what's installed.
# The Brewfile is edited by hand and lists only things wanted on purpose, so the two
# directions need different filters:
#   missing    — declared but absent, checked against *everything* installed, so
#                declared-but-depended-on formulae (gcc, ffmpeg, …) don't false-positive
#   undeclared — present but unlisted, checked against `brew leaves` only, so
#                dependencies pulled in by declared packages aren't reported as drift
# See README.
function bbd() {
  local repo="$HOME/dotfiles/Brewfile" dump=/tmp/Brewfile.dump
  [[ -r $repo ]] || { echo "bbd: cannot read $repo" >&2; return 1 }
  brew bundle dump --force --file="$dump" || return 1

  # 'brew "libomp", link: true' -> 'brew libomp'; 'mas "Xcode", id: 497799835' -> 'mas Xcode'
  local norm='s/^([a-z]+) "([^"]+)".*/\1 \2/'
  local kinds='^(brew|cask|mas|vscode|tap) '

  local declared installed toplevel
  declared=$(grep -E $kinds "$repo" | sed -E "$norm" | sort -u)
  installed=$(grep -E $kinds "$dump" | sed -E "$norm" | sort -u)
  toplevel=$({ brew leaves | sed 's/^/brew /'
               grep -E '^(cask|mas|vscode|tap) ' "$dump" | sed -E "$norm" } | sort -u)

  local missing undeclared
  missing=$(comm -23 <(print -rl -- ${(f)declared}) <(print -rl -- ${(f)installed}))
  undeclared=$(comm -13 <(print -rl -- ${(f)declared}) <(print -rl -- ${(f)toplevel}))

  if [[ -z $missing && -z $undeclared ]]; then
    echo "Brewfile and machine agree — no drift."
    return 0
  fi
  [[ -n $missing ]] && {
    echo "==> declared but not installed (run 'brew bundle install', or drop the line):"
    print -rl -- ${(f)missing} | sed 's/^/    /'
  }
  [[ -n $undeclared ]] && {
    echo "==> installed but undeclared (add to the Brewfile, or uninstall):"
    print -rl -- ${(f)undeclared} | sed 's/^/    /'
  }
  return 1
}

# One-command system update: Homebrew (formulae + casks), orphan/dep cleanup,
# App Store apps, and Julia. Self-updating apps (Chrome, Slack, …) are skipped
# by design; VS Code extensions and R packages update through their own apps.
function update() {
  echo "==> brew upgrade"
  brew upgrade
  echo "==> brew autoremove"
  brew autoremove
  echo "==> brew cleanup"
  brew cleanup
  if exists mas; then
    echo "==> mas upgrade (App Store apps)"
    mas upgrade
  fi
  if exists juliaup; then
    echo "==> juliaup update"
    juliaup update
  fi
  echo "==> done — run 'bbd' occasionally to check for undeclared installs"
}

# --- Tool init ---
exists nodenv && eval "$(nodenv init -)"
exists zoxide && eval "$(zoxide init zsh)"

# --- Ruby via chruby (default version pinned in ~/.ruby-version) ---
if [[ -f /opt/homebrew/opt/chruby/share/chruby/chruby.sh ]]; then
  source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
  source /opt/homebrew/opt/chruby/share/chruby/auto.sh
fi

# --- Zsh plugins (Homebrew); syntax highlighting must be sourced last ---
[[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/ain/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
