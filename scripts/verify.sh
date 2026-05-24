#!/usr/bin/env bash
set -euo pipefail

required=(git zsh stow)
optional=(kitty starship tmux nvim rg fd fdfind fzf jq yq zoxide)

missing_required=()
for cmd in "${required[@]}"; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    missing_required+=("$cmd")
  fi
done

if [[ "${#missing_required[@]}" -gt 0 ]]; then
  echo "Missing required commands: ${missing_required[*]}" >&2
  exit 1
fi

for cmd in "${optional[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf 'ok: %s\n' "$cmd"
  fi
done

expected=(
  "$HOME/.zshrc"
  "$HOME/.gitconfig"
  "$HOME/.config/kitty/kitty.conf"
  "$HOME/.config/starship.toml"
  "$HOME/.tmux.conf"
  "$HOME/.config/nvim/init.lua"
)

for path in "${expected[@]}"; do
  if [[ -e "$path" || -L "$path" ]]; then
    printf 'linked: %s\n' "$path"
  else
    printf 'missing: %s\n' "$path" >&2
    exit 1
  fi
done
