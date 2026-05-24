#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
MODE="symlink"
DRY_RUN="false"
INSTALL_PACKAGES="false"
INSTALL_DOTFILES="true"
INSTALL_VSCODE="false"
RUN_DOCTOR="false"

usage() {
  cat <<'EOF'
Usage: ./scripts/install.sh [options]

Options:
  --packages       Install packages from packages/ubuntu-apt.txt
  --dotfiles       Install/link dotfiles. Enabled by default.
  --no-dotfiles    Skip dotfile install/link step.
  --vscode         Install VS Code extensions from vscode/extensions.txt
  --doctor         Run scripts/doctor.sh after install
  --symlink        Link files into place. Default.
  --copy           Copy files instead of symlinking
  --dry-run        Print actions without changing files
  -h, --help       Show this help message

Examples:
  ./scripts/install.sh --dry-run
  ./scripts/install.sh --packages --vscode --doctor
  ./scripts/install.sh --copy
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --packages) INSTALL_PACKAGES="true" ;;
    --dotfiles) INSTALL_DOTFILES="true" ;;
    --no-dotfiles) INSTALL_DOTFILES="false" ;;
    --vscode) INSTALL_VSCODE="true" ;;
    --doctor) RUN_DOCTOR="true" ;;
    --symlink) MODE="symlink" ;;
    --copy) MODE="copy" ;;
    --dry-run) DRY_RUN="true" ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 1 ;;
  esac
  shift
done

log() { printf '%s\n' "$*"; }

run() {
  if [[ "$DRY_RUN" == "true" ]]; then
    printf '[dry-run]'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

read_package_file() {
  grep -Ev '^\s*(#|$)' "$ROOT_DIR/packages/ubuntu-apt.txt"
}

install_packages() {
  if ! command -v apt-get >/dev/null 2>&1; then
    echo "apt-get not found. Package install is intended for Ubuntu/Debian." >&2
    exit 1
  fi

  if [[ ! -f "$ROOT_DIR/packages/ubuntu-apt.txt" ]]; then
    echo "Missing package manifest: packages/ubuntu-apt.txt" >&2
    exit 1
  fi

  mapfile -t packages < <(read_package_file)
  if [[ "${#packages[@]}" -eq 0 ]]; then
    echo "No packages listed in packages/ubuntu-apt.txt" >&2
    exit 1
  fi

  run sudo apt-get update
  run sudo apt-get install -y "${packages[@]}"
}

install_item() {
  local src="$1"
  local dst="$2"

  if [[ ! -e "$src" ]]; then
    log "skip missing source: $src"
    return
  fi

  run mkdir -p "$(dirname "$dst")"

  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    log "ok already linked: $dst"
    return
  fi

  if [[ -e "$dst" || -L "$dst" ]]; then
    local backup="$BACKUP_DIR/${dst#$HOME/}"
    run mkdir -p "$(dirname "$backup")"
    run mv "$dst" "$backup"
    log "backup: $dst -> $backup"
  fi

  if [[ "$MODE" == "copy" ]]; then
    if [[ -d "$src" ]]; then
      run cp -a "$src" "$dst"
    else
      run cp "$src" "$dst"
    fi
    log "copy: $src -> $dst"
  else
    run ln -s "$src" "$dst"
    log "link: $dst -> $src"
  fi
}

install_dotfiles() {
  install_item "$ROOT_DIR/home/.zshrc" "$HOME/.zshrc"
  install_item "$ROOT_DIR/home/.oh-my-zsh/custom/dev-workflow.zsh" "$HOME/.oh-my-zsh/custom/dev-workflow.zsh"
  install_item "$ROOT_DIR/home/.oh-my-zsh/custom/fzf-tab.zsh" "$HOME/.oh-my-zsh/custom/fzf-tab.zsh"
  install_item "$ROOT_DIR/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
  install_item "$ROOT_DIR/config/starship.toml" "$HOME/.config/starship.toml"
  install_item "$ROOT_DIR/config/Code/User/settings.json" "$HOME/.config/Code/User/settings.json"
  install_item "$ROOT_DIR/config/nvim" "$HOME/.config/nvim"
}

if [[ "$INSTALL_PACKAGES" == "true" ]]; then
  install_packages
fi

if [[ "$INSTALL_DOTFILES" == "true" ]]; then
  install_dotfiles
fi

if [[ "$INSTALL_VSCODE" == "true" ]]; then
  run "$ROOT_DIR/scripts/install-vscode-extensions.sh"
fi

if [[ "$RUN_DOCTOR" == "true" ]]; then
  run "$ROOT_DIR/scripts/doctor.sh"
fi

log "done"
log "reload shell with: source ~/.zshrc"
