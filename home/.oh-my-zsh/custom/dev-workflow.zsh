# ============================================================
# Dev workflow aliases/functions
# Loaded automatically by Oh My Zsh from ~/.oh-my-zsh/custom/*.zsh
# ============================================================

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

# Better ls via eza
alias l='eza --icons=auto --group-directories-first'
alias ll='eza -lah --icons=auto --git --group-directories-first'
alias la='eza -la --icons=auto --group-directories-first'
alias lt='eza --tree --level=2 --icons=auto --group-directories-first'
alias lta='eza --tree --level=2 -a --icons=auto --group-directories-first'

# File viewing/search
alias catp='bat --paging=never'
alias preview='bat --style=numbers --color=always'
alias findf='fd'
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
alias lg='lazygit'

# GitHub CLI
alias ghrepo='gh repo view --web'
alias ghpr='gh pr list'
alias ghissue='gh issue list'

# Node / npm / fnm
alias ni='npm install'
alias nr='npm run'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrt='npm run test'
alias fnmls='fnm list'

# Python / uv
alias py='python3'
alias uvv='uv --version'
alias uvvenv='uv venv'
alias uvpip='uv pip'

# Docker: installed but disabled by default.
alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dc='docker compose'
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcd='docker compose down'

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
alias top='btop'
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
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .venv'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules --exclude .venv'
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border --inline-info'

# bat
export BAT_PAGER='less -RF'

# Safer interactive defaults
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
