echo "running the .zshrc file"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# Path to your oh-my-zsh installation.
export ZSH="/Users/ain/.config/oh-my-zsh" # for some reason, can't replace `/Users/ain/` with `~`

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-autosuggestions
    )


export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST 
# above taken from: https://bit.ly/3npcXId
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set Variables
export HOMEBREW_CASK_OPTS="--no_quarantine"
export NULLCMD=bat
export N_PREFIX="$HOME/.n" # we want this n folder to match the hidden, so dotfile it
export PREFIX="$N_PREFIX" #do we really need this?

## PATH RELATED ITEMS
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export PATH=/opt/R/arm64/bin:$PATH
# export PATH="$PATH:$N_PREFIX/bin"

typeset -U path

path=(
  $path
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  "$N_PREFIX/bin"
)

# USER CONFIGURATIONS
alias ls='exa -laFh --git'
alias exa="exa -laFh --git"
alias bbd="brew bundle dump --force --describe"
alias trail='<<<${(F)path}' # single quotes matter here!!
alias rm=trash # don't forget that you did this: changing rm default behavior

# ADD NEW MKDIR FUNCTION
function mkcd() {
   mkdir -p "$@" && cd "$_";
}

# SYNTAX HIGHLIGHTING FOR MAN PAGES USING BAT
export MANPAGER="sh -c 'col -bx | bat -l man -p'"source ~/powerlevel10k/powerlevel10k.zsh-theme