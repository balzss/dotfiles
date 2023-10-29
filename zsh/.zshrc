# auto install zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Preceed commands with empty lines for readablity https://stackoverflow.com/a/59576993/4503695
precmd() precmd() echo

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source other zsh configs
source $HOME/dotfiles/zsh/.p10k.zsh
source $HOME/dotfiles/zsh/options.zsh
source $HOME/dotfiles/zsh/aliases.zsh
source $HOME/dotfiles/zsh/functions.zsh

# Start tmux if not in a session already
# [ -z "$TMUX" ] && create_tmux_session

# zsh plugins
zinit light lukechilds/zsh-nvm
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode # https://github.com/jeffreytse/zsh-vi-mode/issues/124
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice from"gh-r" as"program"; zinit load junegunn/fzf-bin

# end of config, only auto-insertions come after this
