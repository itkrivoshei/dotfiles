#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
MODE="symlink"
DRY_RUN="false"

usage() {
  cat <<'EOF'
Usage: ./scripts/install.sh [--symlink|--copy] [--dry-run]

Default mode is --symlink.
Existing files are backed up to ~/.dotfiles-backup/YYYYmmdd-HHMMSS/.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
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
    printf '[dry-run] %q ' "$@"
    printf '\n'
  else
    "$@"
  fi
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

install_item "$ROOT_DIR/home/.zshrc" "$HOME/.zshrc"
install_item "$ROOT_DIR/home/.oh-my-zsh/custom/dev-workflow.zsh" "$HOME/.oh-my-zsh/custom/dev-workflow.zsh"
install_item "$ROOT_DIR/home/.oh-my-zsh/custom/fzf-tab.zsh" "$HOME/.oh-my-zsh/custom/fzf-tab.zsh"
install_item "$ROOT_DIR/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
install_item "$ROOT_DIR/config/starship.toml" "$HOME/.config/starship.toml"
install_item "$ROOT_DIR/config/Code/User/settings.json" "$HOME/.config/Code/User/settings.json"
install_item "$ROOT_DIR/config/nvim" "$HOME/.config/nvim"

log "done"
log "reload shell with: source ~/.zshrc"
