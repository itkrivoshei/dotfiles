#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXTENSIONS_FILE="$ROOT_DIR/vscode/extensions.txt"

if ! command -v code >/dev/null 2>&1; then
  echo "VS Code CLI 'code' not found" >&2
  exit 1
fi

while IFS= read -r extension || [[ -n "$extension" ]]; do
  [[ -z "$extension" || "$extension" =~ ^# ]] && continue
  echo "Installing: $extension"
  code --install-extension "$extension"
done <"$EXTENSIONS_FILE"
