#!/usr/bin/env bash
set -euo pipefail

commands=(
  zsh git gh curl wget unzip
  kitty starship fastfetch
  fzf zoxide atuin eza bat fd rg
  lazygit btop tmux jq yq
  direnv shellcheck shfmt tldr
  duf ncdu dig nslookup nc traceroute lsof
  nvim code node npm fnm uv pipx python3 docker wl-copy wl-paste
)

for cmd in "${commands[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf 'OK      %-14s %s\n' "$cmd" "$(command -v "$cmd")"
  else
    printf 'MISSING %-14s\n' "$cmd"
  fi
done

echo
echo "Config files:"
for file in \
  "$HOME/.zshrc" \
  "$HOME/.config/kitty/kitty.conf" \
  "$HOME/.config/starship.toml" \
  "$HOME/.config/Code/User/settings.json" \
  "$HOME/.config/nvim/init.lua"; do
  [[ -e "$file" ]] && echo "OK $file" || echo "MISSING $file"
done
