#!/usr/bin/env bash
set -euo pipefail

zsh_path="$(command -v zsh || true)"

if [[ -z "$zsh_path" ]]; then
  echo "zsh is not installed." >&2
  exit 1
fi

if [[ "$SHELL" == "$zsh_path" ]]; then
  echo "Default shell is already zsh: $zsh_path"
  exit 0
fi

if ! grep -qxF "$zsh_path" /etc/shells; then
  echo "$zsh_path is not listed in /etc/shells." >&2
  echo "Add it first with: echo '$zsh_path' | sudo tee -a /etc/shells" >&2
  exit 1
fi

chsh -s "$zsh_path"
echo "Shell changed to $zsh_path. Log out and back in to apply."
