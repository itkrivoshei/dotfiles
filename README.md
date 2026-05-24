# dotfiles

[![check](https://img.shields.io/github/actions/workflow/status/itkrivoshei/dotfiles/check.yml?branch=main&style=flat-square&label=check)](https://github.com/itkrivoshei/dotfiles/actions/workflows/check.yml)
[![license](https://img.shields.io/github/license/itkrivoshei/dotfiles?style=flat-square)](LICENSE)

Linux dotfiles and setup scripts for an Ubuntu-based development environment.

## Stack

| Area | Tools |
|---|---|
| Shell | zsh, Oh My Zsh, Starship |
| Terminal | Kitty |
| Editor | Neovim/LazyVim, VS Code |
| Search/navigation | fzf, zoxide, ripgrep, fd |
| CLI utilities | git, tmux, jq, yq, bat, btop, duf, ncdu |
| Runtime basics | Node.js, npm, Python |

## Scope

This repository stores portable configuration and setup helpers for a Linux workstation. It does not store secrets, SSH keys, browser profiles, caches, `.env` files, cloud credentials, or machine-specific runtime state.

## Install

Clone the repository:

```bash
git clone https://github.com/itkrivoshei/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Preview changes without modifying files:

```bash
./scripts/install.sh --dry-run
```

Install dotfiles using symlinks:

```bash
./scripts/install.sh
```

Install Ubuntu packages from `packages/ubuntu-apt.txt`:

```bash
./scripts/install.sh --packages
```

Install packages, dotfiles, VS Code extensions, and then run verification:

```bash
./scripts/install.sh --packages --vscode --doctor
```

Use copy mode instead of symlinks:

```bash
./scripts/install.sh --copy
```

Existing target files are backed up to:

```text
~/.dotfiles-backup/YYYYmmdd-HHMMSS/
```

## Verify

Run the local health check:

```bash
./scripts/doctor.sh
```

Run the same style of checks used by CI:

```bash
bash -n scripts/*.sh
shellcheck scripts/*.sh
shfmt -d scripts/*.sh home/.oh-my-zsh/custom/*.zsh
jq . config/Code/User/settings.json >/dev/null
jq . config/nvim/lazyvim.json >/dev/null
python3 - <<'PY'
import tomllib
from pathlib import Path

for path in [Path('config/starship.toml'), Path('config/nvim/stylua.toml')]:
    with path.open('rb') as file:
        tomllib.load(file)
PY
```

There is no build step for this repository.

## Project structure

```text
.
├── config/                     # files linked into ~/.config
│   ├── Code/User/settings.json
│   ├── kitty/kitty.conf
│   ├── nvim/
│   └── starship.toml
├── home/                       # files linked into $HOME
│   ├── .zshrc
│   └── .oh-my-zsh/custom/
├── packages/ubuntu-apt.txt     # Ubuntu package manifest
├── scripts/
│   ├── doctor.sh
│   ├── install.sh
│   └── install-vscode-extensions.sh
├── vscode/extensions.txt
├── LICENSE
└── README.md
```

## Notes

- `scripts/install.sh` defaults to symlink mode.
- `scripts/doctor.sh` reports required and optional tools separately.
- Vendor tools such as Docker, GitHub CLI, VS Code, fnm, uv, atuin, and lazygit may require their own official repositories or installers and are not assumed to be installed by the base package manifest.

## License

MIT. See [LICENSE](LICENSE).
