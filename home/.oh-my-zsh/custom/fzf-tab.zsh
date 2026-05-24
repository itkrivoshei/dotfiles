# fzf-tab integration.
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# Preview folders when completing cd.
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=auto --color=always $realpath 2>/dev/null'

# Preview files for common viewers/editors.
zstyle ':fzf-tab:complete:cat:*' fzf-preview 'bat --color=always --style=numbers --line-range=:200 $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:bat:*' fzf-preview 'bat --color=always --style=numbers --line-range=:200 $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:nano:*' fzf-preview 'bat --color=always --style=numbers --line-range=:200 $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'bat --color=always --style=numbers --line-range=:200 $realpath 2>/dev/null'
