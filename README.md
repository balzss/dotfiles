# Dotfiles

Config files for zsh, nvim, tmux, git and some others.

- [Prerequisites](#prerequisites)
  - [Nerd Font](#nerd-font)
  - [maxOS](#macos)
  - [Fedora](#fedora)
- [Setup](#setup)
- [Other things to do on a fresh setup](#other-things-to-do-on-a-fresh-setup)
  - [Generate new SSH key](#generate-new-ssh-key)
  - [Install Node](#install-node)
  - [Install Yarn](#install-yarn)
  - [Install language servers](#install-language-servers)
  - [Remap Caps Lock on Linux](#remap-caps-lock-on-linux)

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
- `ripgrep`
  - `brew install ripgrep`
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
- `ripgrep`
  - `sudo dnf install ripgrep`
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

### Install Yarn

https://yarnpkg.com/getting-started/install

### Install language servers

Neovim expects these language servers to be installed:

- Typescript
  - https://github.com/typescript-language-server/typescript-language-server
- Eslint
  - https://github.com/hrsh7th/vscode-langservers-extracted


### Remap Caps Lock on Linux

Install Interception Tools:
https://gitlab.com/interception/linux/tools

And the `caps2esc` plugin:
https://gitlab.com/interception/linux/plugins/caps2esc
