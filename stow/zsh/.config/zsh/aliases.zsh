# shell aliases

alias c='clear'
alias h='history'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'

alias g='git'
alias gs='git status --short --branch'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'

command -v batcat >/dev/null 2>&1 && alias bat='batcat'
command -v fdfind >/dev/null 2>&1 && alias fd='fdfind'
command -v kubectl >/dev/null 2>&1 && alias k='kubectl'
command -v docker >/dev/null 2>&1 && alias d='docker'
command -v docker >/dev/null 2>&1 && alias dc='docker compose'
