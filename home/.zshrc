# ============================================================
# ~/.zshrc — clean modern dev setup
# System: Ubuntu / Kitty / zsh / Oh My Zsh / Starship
# User: itkrivoshei
# ============================================================

# ------------------------------------------------------------
# PATH
# ------------------------------------------------------------

export PATH="$HOME/bin:$HOME/.local/bin:/opt/nvim-linux-x86_64/bin:$PATH"

# Atuin official installer path.
[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"

# fnm binary path.
export FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
fi

# ------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------

export ZSH="$HOME/.oh-my-zsh"

# Starship handles the prompt.
ZSH_THEME=""

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13

HIST_STAMPS="yyyy-mm-dd"

plugins=(
  git
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------
# Default editor
# ------------------------------------------------------------

export EDITOR="nvim"
export VISUAL="nvim"

# ------------------------------------------------------------
# Tool hooks
# ------------------------------------------------------------

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd --shell zsh)"
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh)"

# Keep Starship last because it owns the prompt.
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
