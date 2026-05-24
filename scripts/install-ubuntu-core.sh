#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE_FILE="$ROOT_DIR/packages/apt-core.txt"

if ! command -v apt-get >/dev/null 2>&1; then
  echo "apt-get not found. This installer is intended for Ubuntu/Debian systems." >&2
  exit 1
fi

if [[ ! -f "$PACKAGE_FILE" ]]; then
  echo "Package file not found: $PACKAGE_FILE" >&2
  exit 1
fi

sudo apt-get update
mapfile -t packages < <(grep -Ev '^\s*(#|$)' "$PACKAGE_FILE")

if [[ "${#packages[@]}" -eq 0 ]]; then
  echo "No packages listed in $PACKAGE_FILE" >&2
  exit 1
fi

sudo apt-get install -y "${packages[@]}"
