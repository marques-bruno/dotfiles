# oh-my-posh prompt customization
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# Set the path to Zinit plugin mgr
ZINIT_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git

# DL Zinit if it's not there yet:
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source / load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Emacs-style key bindings
bindkey -e
# limit search to what matches what is already typed in prompt
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

## shell integrations
# Enable fuzzy-search with ^r
eval "$(fzf --zsh)"
# Enable zoxide in zsh
eval "$(zoxide init --cmd cd zsh)"

# Add syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

# Add zshell completions for various CLI tools
zinit light zsh-users/zsh-completions

# Add zshell autosuggestions based on command history
zinit light zsh-users/zsh-autosuggestions

# Replace default completion menu with kickass fzf-tab
zinit light Aloxaf/fzf-tab

## COMPLETiONS:
# Load vanilla completions from zsh-completions
autoload -U compinit && compinit
# speedup compinit startup time
zinit cdreplay -q

## Add in extra completion snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

## Completion styling
# case insensitive completions
zstyle ':completion:*' list-colors "m:{a-z}={A-Za-z}"
# colored compleitons
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# disable default completion menu (replaced with fzf-tab)
zstyle ':completion:*' menu no
# even better autocompletion menu based on fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# enable completion style with zoxide as well
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

## HISTORY
# Max nb of entries in history cache
HISTSIZE=5000
# History file
HISTFILE=~/.zsh_history
# Max nb of entries in history log file 
SAVEHIST=$HISTSIZE

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space

# Erase duplicates in history file
HISTDUP=erase
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

alias ls='ls --color'
alias e='nvim'
alias c='clear'
