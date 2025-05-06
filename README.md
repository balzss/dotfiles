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
  - macOS: `brew install zsh`
  - Ubuntu: `sudo apt install zsh`
  - Fedora: `sudo dnf install zsh`
- [ripgrep](https://github.com/BurntSushi/ripgrep)
  - macOS: `brew install ripgrep`
  - Ubuntu: `sudo apt install ripgrep`
  - Fedora: `sudo dnf install ripgrep`
- [fd](https://github.com/sharkdp/fd)
  - macOS: `brew install fd`
  - Ubuntu: `sudo apt install fd-find`
  - Fedora: `sudo dnf install fd-find`
- [lazygit](https://github.com/jesseduffield/lazygit)
  - macOS: `brew install lazygit`
  - Ubuntu (for 25.10 or later, for version before [see instructions](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#debian-and-ubuntu)): `sudo apt install lazygit`
  - Fedora: `sudo dnf copr enable atim/lazygit -y && sudo dnf install lazygit`
- [neovim](https://github.com/neovim/neovim)
  - macOS: `brew install neovim`
  - Ubuntu: `sudo snap install nvim --classic`
  - Fedora: `sudo dnf install neovim`

#### macOS all-in-one:

```sh
brew install zsh ripgrep fd lazygit neovim
```

#### Ubuntu all-in-one:

```sh
sudo apt install zsh ripgrep fd-find lazygit && sudo snap install nvim --classic
```

#### Fedora all-in-one:

```sh
sudo dnf copr enable atim/lazygit -y && sudo dnf install zsh ripgrep fd-find lazygit neovim
```

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

### Remap Caps Lock on Linux

With Fedora 39 [keyd](https://github.com/rvaiya/keyd) seems to be working better than [Interception Tools](https://gitlab.com/interception/linux/tools)
