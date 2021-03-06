### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light chriskempson/base16-shell

# Preceed commands with empty lines for readablity https://stackoverflow.com/a/59576993/4503695
precmd() precmd() echo

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/dotfiles/zsh/.p10k.zsh
source $HOME/dotfiles/zsh/options.zsh
source $HOME/dotfiles/zsh/aliases.zsh
source $HOME/dotfiles/zsh/functions.zsh

# Start tmux if not in a session already
[ -z "$TMUX" ] && create_tmux_session

# Load a few important annexes, without Turbo (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

# My plugins
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit light lukechilds/zsh-nvm
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice from"gh-r" as"program"; zinit load junegunn/fzf-bin

### --------------------------------------------------- ###
### end of config, only auto-insertions come after this ###
### --------------------------------------------------- ###

