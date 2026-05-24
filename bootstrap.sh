#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_PACKAGES=0
CHANGE_SHELL=0

usage() {
  cat <<USAGE
Usage: ./bootstrap.sh [options]

Options:
  --install-packages   Install baseline Ubuntu packages from packages/apt-core.txt
  --change-shell       Change the default shell to zsh after linking dotfiles
  -h, --help           Show this help message

Default behavior links dotfiles and runs verification only.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --install-packages)
      INSTALL_PACKAGES=1
      shift
      ;;
    --change-shell)
      CHANGE_SHELL=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ "$INSTALL_PACKAGES" -eq 1 ]]; then
  "$ROOT_DIR/scripts/install-ubuntu-core.sh"
fi

"$ROOT_DIR/scripts/link.sh"

if [[ "$CHANGE_SHELL" -eq 1 ]]; then
  "$ROOT_DIR/scripts/change-shell.sh"
fi

"$ROOT_DIR/scripts/verify.sh"
