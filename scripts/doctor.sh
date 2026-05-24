#!/usr/bin/env bash
set -euo pipefail

required=(
  zsh git curl wget unzip
  kitty starship
  fzf zoxide bat fd rg
  btop tmux jq yq
  direnv shellcheck shfmt
  duf ncdu dig nslookup nc traceroute lsof
  nvim node npm python3 wl-copy wl-paste
)

optional=(
  gh atuin eza lazygit tldr code fnm uv pipx docker
)

missing_required=0

check_command() {
  local level="$1"
  local cmd="$2"

  if command -v "$cmd" >/dev/null 2>&1; then
    printf 'OK       %-9s %-14s %s\n' "$level" "$cmd" "$(command -v "$cmd")"
  else
    printf 'MISSING  %-9s %-14s\n' "$level" "$cmd"
    [[ "$level" == "required" ]] && missing_required=1
  fi
}

for cmd in "${required[@]}"; do
  check_command required "$cmd"
done

for cmd in "${optional[@]}"; do
  check_command optional "$cmd"
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

exit "$missing_required"
