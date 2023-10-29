# Dotfiles

Config files for zsh, neovim, git and some others.

- [Prerequisites](#prerequisites)
  - [Kitty Terminal Emulator](#kitty-terminal-emulator)
  - [Nerd Font](#nerd-font)
  - [macOS](#macos)
  - [Common](#common)
  - [Optional](#optional)
- [Setup](#setup)
- [Other things to do on a fresh setup](#other-things-to-do-on-a-fresh-setup)
  - [Generate new SSH key](#generate-new-ssh-key)
  - [Install Node](#install-node)
  - [Install language servers](#install-language-servers)
  - [Remap Caps Lock on Linux](#remap-caps-lock-on-linux)

## Prerequisites

### Kitty Terminal Emulator

- [Binary install](https://sw.kovidgoyal.net/kitty/binary/#binary-install)
- [Desktop integration on Linux](https://sw.kovidgoyal.net/kitty/binary/#desktop-integration-on-linux)

### Nerd Font

Kitty is configured to use the Iosevka Nerd Font which can be installed from the [fonts](/fonts) directory.
Neovim also uses Nerd icons.

### macOS

- [Karabiner-Elements](https://karabiner-elements.pqrs.org/) (for swapping Caps Lock with Esc)
- [homebrew](https://brew.sh/)

### Common

- [zsh](https://www.zsh.org/)
  - `brew install zsh`
  - `sudo dnf install zsh`
- [ripgrep](https://github.com/BurntSushi/ripgrep)
  - `brew install ripgrep`
  - `sudo dnf install ripgrep`
- [fd](https://github.com/sharkdp/fd)
  - `brew install fd`
  - `sudo dnf install fd-find`
- [lazygit](https://github.com/jesseduffield/lazygit)
  - `brew install lazygit`
  - `sudo dnf copr enable atim/lazygit -y && sudo dnf install lazygit`
- [neovim](https://github.com/neovim/neovim)
  - `brew install neovim`
  - `sudo dnf install neovim`

### Optional

- [tmux](https://github.com/tmux/tmux)
  - `brew install tmux`
  - `sudo dnf install tmux`

## Setup

Run `link.sh` to create symlinks. Before running comment/uncomment specific config files if needed.

## Other things to do on a fresh setup

### Generate new SSH key

```
ssh-keygen -t rsa
```

### Install Node

`nvm` should already be installed by zsh/zinit ([intructions](https://github.com/nvm-sh/nvm#installing-and-updating) if it isn't)

Install Node with NVM:

```
nvm install latest
```

### Install language servers

**note: this might not be needed with the new neovim config**

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

More info/article:
http://nelsonware.com/blog/2019/04/30/how-to-map-caps-lock-to-escape-and-control-on-fedora-via-caps2esc.html
