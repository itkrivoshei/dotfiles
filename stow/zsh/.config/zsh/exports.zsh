# shell exports

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-R --use-color -Dd+r$Du+b"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

if [[ -d "$HOME/.npm-global/bin" ]]; then
  export PATH="$HOME/.npm-global/bin:$PATH"
fi
