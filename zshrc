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

# Brewfile drift check: dump machine state to /tmp and diff against the repo's Brewfile.
# The Brewfile itself is edited by hand; see README.
alias bbd='brew bundle dump --describe --force --file=/tmp/Brewfile.dump; git diff --no-index ~/dotfiles/Brewfile /tmp/Brewfile.dump'

# --- Functions ---
function mkcd() {
  mkdir -p "$@" && cd "$_";
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
