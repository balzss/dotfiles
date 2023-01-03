# Dotfiles

Config files for zsh, nvim, tmux, git and some others.

## Prerequisites

### Nerd Font

Neovim is configured to use nerd icons which requires a compatible font (e.g. from the [fonts](/fonts) directory) to
be installed.

### macOS

- `Karabiner-Elements`
  - https://karabiner-elements.pqrs.org/
- `iTerm2`
  - https://iterm2.com/
- `homebrew`
  - https://brew.sh/
- `zsh`
  - `brew install zsh`
- `zinit`
  - https://github.com/zdharma-continuum/zinit#automatic
- `tmux`
  - `brew install tmux`
- `neovim`
  - `brew install neovim`
- `vim-plug`
  - https://github.com/junegunn/vim-plug#neovim
- `lazygit`
  - `brew install lazygit`

### Fedora

- `zsh`
  - `sudo dnf install zsh`
- `zinit`
  - https://github.com/zdharma-continuum/zinit#automatic
- `tmux`
  - `sudo dnf install tmux`
- `neovim`
  - `sudo dnf install neovim`
- `vim-plug`
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
