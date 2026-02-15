# The following lines were added for oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
export GPG_TTY=$(tty)
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode disabled
zstyle ':omz:update' frequency 10

HYPHEN_INSENSITIVE="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="%Y-%m-%d %H:%M:%S"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source $ZSH_CUSTOM/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
# End of lines added for oh-my-zsh

source $ZSH_CUSTOM/zsh-newuser-install.zsh

autoload -U promptinit
promptinit

prompt gentoo

setopt globdots
# zstyle ':completion:*' file-patterns '*(D):files:files' '*(/):directories:directories'
# zstyle ':completion:*' list-grouped true
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' format '%F{yellow}--- %d ---%f'
# zstyle ':completion:*' list-dirs-first no

bindkey "^P" up-line-or-search
bindkey '^R' history-incremental-search-backward

# Keep j/k as default up/down
# Use K (shift+k) and J (shift+j) for history search instead
# bindkey -M vicmd 'K' history-beginning-search-backward
# bindkey -M vicmd 'J' history-beginning-search-forward
bindkey -M vicmd 'j' down-line-or-search

unsetopt AUTO_REMOVE_SLASH

bindkey '^W' backward-delete-path-component

# bindkey "^I" menu-complete
# bindkey "^[[Z" reverse-menu-complete
# bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

bindkey '\t' menu-select "$terminfo[kcbt]" menu-select # cycle through menu to autocomplete on tab

bindkey "^[^I" _smart-dir-accept
bindkey "^[^[[Z" _go-up-one-dir

# bindkey -M menuselect '^[' undo # stop cycling on esc

try_source () {
    filename=${2:-.bashrc}
    script_path="$ZSH_CUSTOM/$1/$filename"

    if test -f "$script_path"; then
        . "$script_path"
    fi
}

if test -f "$HOME/bashrc/local.sh"; then
  . "$HOME/bashrc/local.sh"
fi

try_source colorful-prompt colorful-prompt.sh
try_source kubetools
try_source git-tools
try_source shell

try_source docker-tools aliases.sh
try_source curl-tools
try_source paste-token aliases.sh

try_source smash .zshrc

try_source new main.sh
try_source cvesna
try_source bashrc

bindkey '^[[[CE' accept-line
bindkey -M menuselect '^M' .accept-line
bindkey '^[.' insert-last-word
