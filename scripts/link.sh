#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STOW_DIR="$ROOT_DIR/stow"
TARGET_DIR="$HOME"

if ! command -v stow >/dev/null 2>&1; then
  echo "GNU Stow is required. Install it first: sudo apt install stow" >&2
  exit 1
fi

packages=(zsh git kitty starship tmux nvim)

for package in "${packages[@]}"; do
  if [[ ! -d "$STOW_DIR/$package" ]]; then
    echo "Missing stow package: $package" >&2
    exit 1
  fi

  stow \
    --dir="$STOW_DIR" \
    --target="$TARGET_DIR" \
    --restow \
    --verbose=1 \
    "$package"
done
