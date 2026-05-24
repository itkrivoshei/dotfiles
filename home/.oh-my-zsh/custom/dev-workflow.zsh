# ============================================================
# Dev workflow aliases/functions
# Loaded automatically by Oh My Zsh from ~/.oh-my-zsh/custom/*.zsh
# ============================================================

# Compatibility aliases for Ubuntu package names.
command -v batcat >/dev/null 2>&1 && alias bat='batcat'
command -v fdfind >/dev/null 2>&1 && alias fd='fdfind'

# Quality of life
alias c='clear'
alias reload='source ~/.zshrc'
alias path='echo $PATH | tr ":" "\n"'
alias please='sudo'

alias zshconfig='nvim ~/.zshrc'
alias kittyconfig='nvim ~/.config/kitty/kitty.conf'
alias starshipconfig='nvim ~/.config/starship.toml'
alias nvimconfig='nvim ~/.config/nvim'
alias vscodeconfig='nvim ~/.config/Code/User/settings.json'

# Better ls via eza when available.
if command -v eza >/dev/null 2>&1; then
  alias l='eza --icons=auto --group-directories-first'
  alias ll='eza -lah --icons=auto --git --group-directories-first'
  alias la='eza -la --icons=auto --group-directories-first'
  alias lt='eza --tree --level=2 --icons=auto --group-directories-first'
  alias lta='eza --tree --level=2 -a --icons=auto --group-directories-first'
else
  alias l='ls -CF'
  alias ll='ls -lah'
  alias la='ls -la'
fi

# File viewing/search
command -v bat >/dev/null 2>&1 && alias catp='bat --paging=never'
command -v bat >/dev/null 2>&1 && alias preview='bat --style=numbers --color=always'
command -v fd >/dev/null 2>&1 && alias findf='fd'
alias jqp='jq .'
alias yqp='yq .'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'
alias dl='cd ~/Downloads'
alias desk='cd ~/Desktop'
alias docs='cd ~/Documents'
alias proj='cd ~/Projects'

mkcd() {
  mkdir -p "$1" && cd "$1" || return
}

# Git
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias glog='git log --oneline --graph --decorate --all -20'
command -v lazygit >/dev/null 2>&1 && alias lg='lazygit'

# GitHub CLI
command -v gh >/dev/null 2>&1 && alias ghrepo='gh repo view --web'
command -v gh >/dev/null 2>&1 && alias ghpr='gh pr list'
command -v gh >/dev/null 2>&1 && alias ghissue='gh issue list'

# Node / npm / fnm
alias ni='npm install'
alias nr='npm run'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrt='npm run test'
command -v fnm >/dev/null 2>&1 && alias fnmls='fnm list'

# Python / uv
alias py='python3'
command -v uv >/dev/null 2>&1 && alias uvv='uv --version'
command -v uv >/dev/null 2>&1 && alias uvvenv='uv venv'
command -v uv >/dev/null 2>&1 && alias uvpip='uv pip'

# Docker: optional and disabled by default.
command -v docker >/dev/null 2>&1 && alias d='docker'
command -v docker >/dev/null 2>&1 && alias dps='docker ps'
command -v docker >/dev/null 2>&1 && alias dpsa='docker ps -a'
command -v docker >/dev/null 2>&1 && alias di='docker images'
command -v docker >/dev/null 2>&1 && alias dc='docker compose'
command -v docker >/dev/null 2>&1 && alias dcu='docker compose up'
command -v docker >/dev/null 2>&1 && alias dcud='docker compose up -d'
command -v docker >/dev/null 2>&1 && alias dcd='docker compose down'

dockon() {
  sudo systemctl enable --now containerd.service docker.socket docker.service
  docker --version
  docker compose version
}

dockoff() {
  sudo systemctl disable --now docker.socket docker.service containerd.service
}

dockstatus() {
  systemctl is-active docker.socket docker.service containerd.service
  systemctl is-enabled docker.socket docker.service containerd.service
}

# System
alias ff='fastfetch'
command -v btop >/dev/null 2>&1 && alias top='btop'
alias ports='lsof -i -P -n'
alias myip='curl -s https://ifconfig.me && echo'
alias update='sudo apt update && sudo apt upgrade'
alias aptsearch='apt search'
alias aptinstalled='apt list --installed'

# Network debug
alias pingg='ping google.com'
alias digg='dig google.com'
alias portsopen='ss -tulpn'

# fzf defaults
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .venv'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules --exclude .venv'
fi
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border --inline-info'

# bat
export BAT_PAGER='less -RF'

# Safer interactive defaults
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
