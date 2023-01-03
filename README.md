# Dotfiles

Config files for zsh, nvim, tmux, git and some others.

## Prerequisites

### Nerd Font

Neovim is configured to use nerd icons which requires a compatible font (e.g. from the [fonts](/fonts) directory) to
be installed.

### macOS

1. `Karabiner-Elements`
  - https://karabiner-elements.pqrs.org/
2. `iTerm2`
  - https://iterm2.com/
3. `homebrew`
  - https://brew.sh/
4. `zsh`
  - `brew install zsh`
5. `zinit`
  - https://github.com/zdharma-continuum/zinit#automatic
6. `tmux`
  - `brew install tmux`
7. `neovim`
  - `brew install neovim`
8. `vim-plug`
  - https://github.com/junegunn/vim-plug#neovim
9. `lazygit`
  - `brew install lazygit`

### Fedora

1. `zsh`
  - `sudo dnf install zsh`
2. `zinit`
  - https://github.com/zdharma-continuum/zinit#automatic
3. `tmux`
  - `sudo dnf install tmux`
4. `neovim`
  - `sudo dnf install neovim`
5. `vim-plug`
  - https://github.com/junegunn/vim-plug#neovim

## Setup

Run `link.sh` to create symlinks.

## Other things to do on a fresh setup

### Generate new SSH key

```
ssh-keygen -t rsa
```

### Install Node

`nvm` should be already installed by zsh/zinit ([intructions](https://github.com/nvm-sh/nvm#installing-and-updating) if it isn't)

Install Node with NVM:

```
nvm install 16
```
