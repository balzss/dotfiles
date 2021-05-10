# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
KEYTIMEOUT=1

setopt append_history 
setopt inc_append_history 
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt extended_history

# custom autocomplete
zstyle :compinstall filename '/home/balzss/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

autoload -Uz compinit
compinit
_comp_options+=(globdots)

# setup hooks
autoload -Uz add-zsh-hook
add-zsh-hook precmd new_line
add-zsh-hook preexec new_line

# keybindings (-v for vim; -e for emacs)
bindkey -v

zle -N zle-line-init
zle -N zle-keymap-select
zle -N prepend-sudo

bindkey "^s" prepend-sudo
bindkey "^p" history-substring-search-up
bindkey "^n" history-substring-search-down
bindkey "^u" backward-kill-line

bindkey "^?" backward-delete-char
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey -M vicmd "H" vi-beginning-of-line
bindkey -M vicmd "L" vi-end-of-line
bindkey -M vicmd "M" vi-join
bindkey -M vicmd "U" redo
bindkey -M vicmd "g" vi-fetch-history
# bindkey -M vicmd "s" prepend-sudo
