# shell functions

mkcd() {
  mkdir -p "$1" && cd "$1" || return
}

path-prepend() {
  [[ -d "$1" ]] || return 1
  export PATH="$1:$PATH"
}

ports() {
  ss -tulpn 2>/dev/null || sudo ss -tulpn
}

extract() {
  [[ -f "$1" ]] || return 1

  case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz) tar xzf "$1" ;;
    *.tar.xz) tar xJf "$1" ;;
    *.tar) tar xf "$1" ;;
    *.tbz2) tar xjf "$1" ;;
    *.tgz) tar xzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.gz) gunzip "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.7z) 7z x "$1" ;;
    *) echo "Unsupported archive: $1" >&2; return 1 ;;
  esac
}
