#!/usr/bin/env bash
set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
info() { echo -e "${GREEN}[INFO]${NC}  $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error() { echo -e "${RED}[ERR]${NC}   $*"; exit 1; }

# Files/dirs in the repo root that should NOT be symlinked into $HOME
SKIP=(
  .DS_Store
  .git
  .gitignore
  install.sh
  README.md
)

case "$(uname -s)" in
  Darwin) OS="mac" ;;
  Linux)  OS="linux" ;;
  *) error "Unsupported OS: $(uname -s)" ;;
esac
info "Detected OS: $OS"

make_link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    info "Already linked: $dst → $src"; return
  fi
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    warn "Backing up: $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -sf "$src" "$dst"
  info "Linked: $dst → $src"
}

# Build skip lookup
skip_lookup() { local f="$1"; for s in "${SKIP[@]}"; do [[ "$s" == "$f" ]] && return 0; done; return 1; }

info "Creating symlinks..."
for entry in "$DOTFILES_DIR"/{.*,*}; do
  name="$(basename "$entry")"
  skip_lookup "$name" && continue
  make_link "$entry" "$HOME/$name"
done

# .claude — detect config dir
if [ -d "$HOME/.config/claude" ]; then
  CLAUDE_DIR="$HOME/.config/claude"
else
  CLAUDE_DIR="$HOME/.claude"
fi
info "Claude config dir: $CLAUDE_DIR"

# CLAUDE.md (global instructions)
make_link "$DOTFILES_DIR/.copilot/copilot-instructions.md" "$CLAUDE_DIR/CLAUDE.md"

# Agents: symlink each .md file individually (preserve any existing agents)
if [ -d "$DOTFILES_DIR/.copilot/agents" ]; then
  mkdir -p "$CLAUDE_DIR/agents"
  for agent in "$DOTFILES_DIR/.copilot/agents"/*.md; do
    [ -f "$agent" ] || continue
    make_link "$agent" "$CLAUDE_DIR/agents/$(basename "$agent")"
  done
else
  warn "No .copilot/agents/ dir found, skipping agents"
fi

SOURCE_LINE='[ -f ~/.myrc ] && source ~/.myrc'
add_source_line() {
  local rc="$1"
  [ -f "$rc" ] || { warn "$rc not found, skipping."; return; }
  grep -qF "$SOURCE_LINE" "$rc" && { info "Already sourced in $rc"; return; }
  printf '\n# Added by dotfiles install.sh\n%s\n' "$SOURCE_LINE" >> "$rc"
  info "Added source line to $rc"
}

if [ "$OS" = "mac" ]; then
  add_source_line "$HOME/.zshrc"
  [ -f "$HOME/.bashrc" ] && add_source_line "$HOME/.bashrc"
else
  add_source_line "$HOME/.bashrc"
  [ -f "$HOME/.zshrc" ] && add_source_line "$HOME/.zshrc"
fi

info "Done. Reload your shell or run: source ~/.myrc"