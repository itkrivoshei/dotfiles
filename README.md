# dotfiles

Personal Linux development environment for Ubuntu / GNOME / Kitty / zsh / Oh My Zsh / Starship / LazyVim / VS Code.

This repository is intended to be small, readable, and practical. It stores only portable configuration files and install helpers. It does not store secrets, tokens, SSH keys, `.env` files, caches, or machine-specific runtime state.

## Stack

| Area | Tooling |
|---|---|
| Shell | zsh, Oh My Zsh, Starship |
| Terminal | Kitty |
| Navigation/search | fzf, fzf-tab, zoxide, fd, ripgrep |
| Files | eza, bat |
| Git | git, gh, lazygit |
| Editors | Neovim/LazyVim, VS Code |
| Runtime | fnm, Node.js, npm, Python, uv, pipx |
| Containers | Docker, Docker Compose, Buildx |
| System debug | btop, duf, ncdu, lsof, dig, nc, traceroute |

## Layout

```text
.
├── home/                         # files linked into $HOME
│   ├── .zshrc
│   └── .oh-my-zsh/custom/
│       ├── dev-workflow.zsh
│       └── fzf-tab.zsh
├── config/                       # files linked into ~/.config
│   ├── kitty/kitty.conf
│   ├── starship.toml
│   ├── Code/User/settings.json
│   └── nvim/
├── scripts/
│   ├── install.sh                # symlink/copy dotfiles into place
│   ├── install-vscode-extensions.sh
│   └── doctor.sh                 # quick health check
├── packages/ubuntu-apt.txt
├── vscode/extensions.txt
├── .editorconfig
└── .gitignore
```

## Install

Clone:

```bash
git clone https://github.com/itkrivoshei/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Dry run first:

```bash
./scripts/install.sh --dry-run
```

Install using symlinks:

```bash
./scripts/install.sh
```

Install VS Code extensions:

```bash
./scripts/install-vscode-extensions.sh
```

Run a health check:

```bash
./scripts/doctor.sh
```

## Install behavior

`install.sh` creates symlinks from this repo into your real config locations. If a target already exists and is not already the correct symlink, it is backed up into:

```text
~/.dotfiles-backup/YYYYmmdd-HHMMSS/
```

Use copy mode instead of symlink mode:

```bash
./scripts/install.sh --copy
```

## Notes

- Docker is configured as installed but normally disabled from background startup on this laptop.
- VS Code is configured as the low-friction daily editor.
- LazyVim remains the terminal editor.
- Starship owns the prompt; therefore `ZSH_THEME=""` is intentional.
