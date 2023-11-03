[ -f ~/.local-env-vars.zsh ] && source ~/.local-env-vars.zsh

_myos="$(uname)"

export PATH="$HOME/gems/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export FZF_DEFAULT_OPTS='--height 50% --layout=reverse'

export VIRTUAL_ENV_DISABLE_PROMPT=1
export PIP_REQUIRE_VIRTUALENV=false
export CLICOLOR=1
export MOZ_USE_XINPUT2=1
export MOZ_USE_XINPUT2=1
export GEM_HOME="$HOME/gems"

export EDITOR="nvim"
export PAGER="nvim +Man!"
export MANPAGER="nvim +Man!"
export MANWIDTH=999
export VISUAL="nvim"

export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"
