# use emacs keybindings
bindkey -e

#ctrl-f edit current buffer in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^f' edit-command-line

zle -N prepend-sudo
bindkey "^s" prepend-sudo
bindkey "^p" history-substring-search-up
bindkey "^n" history-substring-search-down
