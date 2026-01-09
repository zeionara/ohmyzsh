# The following lines were added by compinstall
# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _ignored _approximate
# zstyle ':completion:*' completions 1
# zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort access
zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' ignore-parents parent pwd
# zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' list-suffixes true
# zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
# zstyle ':completion:*' max-errors 3
# zstyle ':completion:*' menu select=7
# zstyle ':completion:*' original false
# zstyle ':completion:*' preserve-prefix '//[^/]##/'
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl true
# zstyle ':completion:*' verbose true
# zstyle :compinstall filename '/home/zeio/.zshrc'

# autoload -Uz compinit
# compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt nomatch
unsetopt autocd beep extendedglob notify
bindkey -v
# End of lines configured by zsh-newuser-install
