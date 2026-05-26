# dotfiles

[![Check](https://img.shields.io/github/actions/workflow/status/itkrivoshei/dotfiles/check.yml?branch=main&style=flat-square&label=check&logo=githubactions&logoColor=white)](https://github.com/itkrivoshei/dotfiles/actions/workflows/check.yml)
[![Shell](https://img.shields.io/badge/Shell-Bash%20%2B%20zsh-4eaa25?style=flat-square&logo=gnubash&logoColor=white)](scripts/install.sh)
[![Neovim](https://img.shields.io/badge/Neovim-LazyVim-57a143?style=flat-square&logo=neovim&logoColor=white)](config/nvim)
[![License](https://img.shields.io/github/license/itkrivoshei/dotfiles?style=flat-square)](LICENSE)

Linux workstation configuration for an Ubuntu-based development environment: shell, terminal, editor, package manifest, VS Code extensions, and health checks.

## Install Modes

| Mode | Command |
| --- | --- |
| Preview only | `./scripts/install.sh --dry-run` |
| Link dotfiles | `./scripts/install.sh` |
| Copy instead of symlink | `./scripts/install.sh --copy` |
| Install apt packages | `./scripts/install.sh --packages` |
| Add VS Code extensions | `./scripts/install.sh --vscode` |
| Finish with health check | `./scripts/install.sh --doctor` |

Existing target files are moved into `~/.dotfiles-backup/YYYYmmdd-HHMMSS/` before new links or copies are created.

## What Gets Managed

```text
home/.zshrc                         -> ~/.zshrc
home/.oh-my-zsh/custom/*.zsh        -> ~/.oh-my-zsh/custom/
config/kitty/kitty.conf             -> ~/.config/kitty/kitty.conf
config/starship.toml                -> ~/.config/starship.toml
config/Code/User/settings.json      -> ~/.config/Code/User/settings.json
config/nvim/                        -> ~/.config/nvim/
```

## Tooling Profile

| Area | Tools |
| --- | --- |
| Shell | zsh, Oh My Zsh, Starship |
| Terminal | Kitty, tmux |
| Editor | Neovim/LazyVim, VS Code |
| Search/navigation | ripgrep, fd, fzf, zoxide |
| CLI utilities | jq, yq, bat, btop, duf, ncdu |
| Runtime base | Node.js, npm, Python |

External/vendor tools such as Docker, GitHub CLI, VS Code, fnm, uv, atuin, and lazygit may need their own installers or package repositories.

## Health Check

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
vscode/extensions.txt   # VS Code extension list
```

## Boundaries

This repo intentionally excludes secrets, SSH keys, browser profiles, caches, `.env` files, cloud credentials, and machine-specific runtime state.

## License

[MIT](LICENSE)
