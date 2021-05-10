source $HOME/scripts/zsh/zsh-history-substring-search.zsh
source $HOME/scripts/zsh/zsh-git-prompt/zshrc.sh

source $HOME/scripts/zsh/aliases.zsh
source $HOME/scripts/zsh/functions.zsh
source $HOME/scripts/zsh/prompt.zsh
source $HOME/scripts/zsh/options.zsh

BR_DIR=$HOME/.config/broot/launcher/bash
[ -f "$BR_DIR/br" ] && source "$BR_DIR/br"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### -------------------------------------------------------------- ###
### end of my zsh config, only autoinserted stuff comes after this ###
### -------------------------------------------------------------- ###

