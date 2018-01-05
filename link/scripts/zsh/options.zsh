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


# keybindings

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
