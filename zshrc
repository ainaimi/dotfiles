echo "running the .zshrc file"

 # --- Instant Prompt Config (must be at the very top, no console output above this) ---
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Powerlevel10k Theme ---
export ZSH="/Users/ain/.config/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# --- Oh My Zsh Plugins ---
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  git
  z
)

export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST 
source $ZSH/oh-my-zsh.sh

# Load Powerlevel10k config if present
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- Environment Variables ---
export HOMEBREW_CASK_OPTS="--no_quarantine"
export NULLCMD=bat
export N_PREFIX="$HOME/.n"
export PREFIX="$N_PREFIX"

export LDFLAGS="-L/opt/homebrew/opt/libomp/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libomp/include"

# --- PATH Management ---
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
  "$HOME/.local/bin"
  "$N_PREFIX/bin"
  "$HOME/rubyonmac"
  $path
)

# --- Aliases ---
alias ls="eza --icons --long --header"
alias bbd="brew bundle dump --force --describe"
alias trail='<<<${(F)path}'
alias rm=trash
alias cd="z"  # note: overrides builtin 'cd'

# --- Functions ---
function mkcd() {
   mkdir -p "$@" && cd "$_";
}

# --- Tools Config ---
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# --- Init Scripts ---
eval "$(nodenv init -)"
eval "$(zoxide init zsh)"

# Load zsh syntax highlighting manually if not using oh-my-zsh version
[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- Ruby via chruby ---
source "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh"
source "$(brew --prefix)/opt/chruby/share/chruby/auto.sh"
chruby ruby-3.4.4

# Set nodenv global
nodenv global 22.17.0
