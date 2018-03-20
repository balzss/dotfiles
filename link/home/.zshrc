HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
KEYTIMEOUT=1

setopt append_history 
setopt inc_append_history 
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt extended_history

# sourcing other parts of config
source $HOME/scripts/zsh/zsh-history-substring-search.zsh
source $HOME/scripts/zsh/zsh-git-prompt/zshrc.sh
source $HOME/scripts/zsh/alias.zsh
source $HOME/scripts/zsh/options.zsh
source $HOME/scripts/zsh/prompt.zsh

# setup hooks
autoload -Uz add-zsh-hook
add-zsh-hook precmd new_line
add-zsh-hook preexec new_line

# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export PATH=/home/balzss/.local/bin:$PATH
