### Needed for a pretty prompt
setopt prompt_subst # Enables additional prompt extentions
autoload -U colors && colors    # Enables colours

function zle-line-init zle-keymap-select {
    case $KEYMAP in
        main)
            VIM_MODE=" %F{blue}$%f"
            ;;
        vicmd)
            VIM_MODE=" %F{red}$%f"
            ;;
    esac
    zle reset-prompt
}

# display host if in an SSH session, executed when .zshrc is sourced (on login)
if [[ -z "$SSH_CLIENT" ]]; then
    prompt_host=""
    # autostart tmux
    if [ "$TMUX" = "" ]
    then
        create_tmux_session
    fi
else
    prompt_host="%F{172}[$(hostname -s)] %f "
fi

# modified python virtualenv prompt
function get_virtualenv_info(){
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "%F{yellow}[`basename $(dirname $VIRTUAL_ENV)`]%f "
    else
        echo ""
    fi
}

PROMPT='$prompt_host%F{magenta}[%d]%f $(get_virtualenv_info)%F{blue}$(git_super_status)%f 
$VIM_MODE%f '
