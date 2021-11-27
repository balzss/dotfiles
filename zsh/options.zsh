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

zstyle :compinstall filename '/home/balzss/.zshrc'
zstyle ':completion:*' menu select
[ "$(uname)" = "Linux" ] && eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

autoload -Uz compinit && compinit
_comp_options+=(globdots)

function zvm_after_lazy_keybindings() {
  bindkey -M vicmd "k" history-substring-search-up
  bindkey -M vicmd "j" history-substring-search-down
  bindkey -M vicmd "H" vi-beginning-of-line
  bindkey -M vicmd "L" vi-end-of-line
  bindkey -M vicmd "M" vi-join
  bindkey -M vicmd "U" redo
}

function zvm_after_init() {
  zvm_bindkey viins '^p' history-substring-search-up
  zvm_bindkey viins '^n' history-substring-search-down
}
