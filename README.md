<div align="center">

# Linux Workstation Dotfiles

Reproducible Linux workstation configuration for an Ubuntu-based development environment: shell, terminal, editor, package manifest, VS Code extensions, and health checks.

[![Check](https://img.shields.io/github/actions/workflow/status/itkrivoshei/dotfiles/check.yml?branch=main&style=for-the-badge&label=check&logo=githubactions&logoColor=white&labelColor=0f172a)](https://github.com/itkrivoshei/dotfiles/actions/workflows/check.yml)
[![CodeQL](https://img.shields.io/github/actions/workflow/status/itkrivoshei/dotfiles/codeql.yml?branch=main&style=for-the-badge&label=codeql&logo=github&logoColor=white&labelColor=0f172a)](https://github.com/itkrivoshei/dotfiles/actions/workflows/codeql.yml)
[![Shell](https://img.shields.io/badge/shell-bash%20%2B%20zsh-4eaa25?style=for-the-badge&logo=gnubash&logoColor=white&labelColor=0f172a)](scripts/install.sh)
[![ShellCheck](https://img.shields.io/badge/shellcheck-enabled-89b4fa?style=for-the-badge&logo=gnubash&logoColor=white&labelColor=0f172a)](https://www.shellcheck.net/)
[![Neovim](https://img.shields.io/badge/neovim-LazyVim-57a143?style=for-the-badge&logo=neovim&logoColor=white&labelColor=0f172a)](config/nvim)
[![License](https://img.shields.io/github/license/itkrivoshei/dotfiles?style=for-the-badge&labelColor=0f172a)](LICENSE)

</div>

## Overview

This repository provides a reusable Linux workstation setup with repeatable shell configuration, terminal tooling, editor settings, package manifests, VS Code extensions, and validation scripts.

It is designed for safe local setup: existing target files are moved into `~/.dotfiles-backup/YYYYmmdd-HHMMSS/` before new links or copies are created.

## Quick Start

Preview changes without modifying files:

```bash
./scripts/install.sh --dry-run
```

Apply dotfiles:

```bash
./scripts/install.sh
```

Run the health check:

```bash
./scripts/doctor.sh
```

## Install Modes

| Mode                     | Command                           |
| ------------------------ | --------------------------------- |
| Preview only             | `./scripts/install.sh --dry-run`  |
| Link dotfiles            | `./scripts/install.sh`            |
| Copy instead of symlink  | `./scripts/install.sh --copy`     |
| Install apt packages     | `./scripts/install.sh --packages` |
| Add VS Code extensions   | `./scripts/install.sh --vscode`   |
| Finish with health check | `./scripts/install.sh --doctor`   |

## What Gets Managed

```text
home/.zshrc                         -> ~/.zshrc
home/.oh-my-zsh/custom/*.zsh        -> ~/.oh-my-zsh/custom/
config/kitty/kitty.conf             -> ~/.config/kitty/kitty.conf
config/starship.toml                -> ~/.config/starship.toml
vscode/settings.json               -> ~/.config/Code/User/settings.json
config/nvim/                        -> ~/.config/nvim/
```

## Tooling Profile

| Area              | Tools                                                                                                                                                                                                                                    |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Shell             | [zsh](https://www.zsh.org/), [Oh My Zsh](https://ohmyz.sh/), [Starship](https://starship.rs/)                                                                                                                                            |
| Terminal          | [Kitty](https://sw.kovidgoyal.net/kitty/), [tmux](https://github.com/tmux/tmux)                                                                                                                                                          |
| Editor            | [Neovim](https://neovim.io/) / [LazyVim](https://www.lazyvim.org/), [VS Code](https://code.visualstudio.com/)                                                                                                                            |
| Search/navigation | [ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd), [fzf](https://github.com/junegunn/fzf), [zoxide](https://github.com/ajeetdsouza/zoxide)                                                           |
| CLI utilities     | [jq](https://jqlang.github.io/jq/), [yq](https://github.com/mikefarah/yq), [bat](https://github.com/sharkdp/bat), [btop](https://github.com/aristocratos/btop), [duf](https://github.com/muesli/duf), [ncdu](https://dev.yorhel.nl/ncdu) |
| Runtime base      | [Node.js](https://nodejs.org/), [npm](https://www.npmjs.com/), [Python](https://www.python.org/)                                                                                                                                         |

External/vendor tools such as Docker, GitHub CLI, VS Code, fnm, uv, atuin, and lazygit may need their own installers or package repositories.

## VS Code

[`vscode/settings.json`](vscode/settings.json) contains portable user settings, while [`vscode/extensions.txt`](vscode/extensions.txt) defines a small general-purpose extension baseline.

The shared settings avoid user identities, absolute home paths, personal dictionaries, and settings that depend on unmanaged extensions. Framework-specific extensions are intentionally left to each project's recommendations.

## Health Check

Health checks are defined in [`scripts/doctor.sh`](scripts/doctor.sh):

```bash
./scripts/doctor.sh
```

CI validates shell syntax, ShellCheck, shfmt, JSON, TOML, and the Ubuntu package manifest.

## Repository Layout

```text
config/                 # files linked into ~/.config
home/                   # files linked into $HOME
packages/ubuntu-apt.txt # apt package manifest
scripts/                # installer and doctor scripts
vscode/                  # portable VS Code settings and extensions
```

Key paths:

- [`config/`](config/) contains files linked into `~/.config`.
- [`home/`](home/) contains files linked into `$HOME`.
- [`packages/ubuntu-apt.txt`](packages/ubuntu-apt.txt) contains the Ubuntu apt package manifest.
- [`scripts/install.sh`](scripts/install.sh) applies the dotfiles.
- [`scripts/doctor.sh`](scripts/doctor.sh) validates the local environment.
- [`vscode/`](vscode/) contains portable VS Code settings and the extension manifest.

## Automation

- [`.github/workflows/check.yml`](.github/workflows/check.yml) validates shell scripts, formatting, JSON, TOML, package manifests, and repository health.
- [`.github/workflows/codeql.yml`](.github/workflows/codeql.yml) runs GitHub CodeQL analysis.
- [`scripts/doctor.sh`](scripts/doctor.sh) provides the local workstation health check.

## Boundaries

This repository intentionally excludes secrets, SSH keys, browser profiles, caches, `.env` files, cloud credentials, and machine-specific runtime state.

## License

[MIT](LICENSE)
