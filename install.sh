#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Colours ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
info()    { echo -e "${GREEN}[INFO]${NC}  $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error()   { echo -e "${RED}[ERR]${NC}   $*"; exit 1; }

# ── Detect OS ─────────────────────────────────────────────────────────────────
case "$(uname -s)" in
  Darwin) OS="mac" ;;
  Linux)  OS="linux" ;;
  *)      error "Unsupported OS: $(uname -s)" ;;
esac
info "Detected OS: $OS"

# ── Helper: create symlink (backs up existing file) ───────────────────────────
make_link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    info "Already linked: $dst → $src"
    return
  fi

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    warn "Backing up existing $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi

  ln -sf "$src" "$dst"
  info "Linked: $dst → $src"
}

# ── Symlinks ──────────────────────────────────────────────────────────────────
info "Creating symlinks..."

# Auto-link all tracked files except repo-only ones
while IFS= read -r file; do
  make_link "$DOTFILES_DIR/$file" "$HOME/$file"
done < <(git -C "$DOTFILES_DIR" ls-files \
  | grep -vE '^(README\.md|\.gitignore|install\.sh)$')

# .claude — detect which config dir this version uses
if [ -d "$HOME/.config/claude" ]; then
  CLAUDE_DIR="$HOME/.config/claude"
elif [ -d "$HOME/.claude" ]; then
  CLAUDE_DIR="$HOME/.claude"
else
  # Default: use .claude (will be created by make_link)
  CLAUDE_DIR="$HOME/.claude"
fi
info "Claude config dir: $CLAUDE_DIR"
make_link "$DOTFILES_DIR/.copilot/copilot-instructions.md" "$CLAUDE_DIR/CLAUDE.md"

# ── Source .myrc from shell rc ────────────────────────────────────────────────
SOURCE_LINE='[ -f ~/.myrc ] && source ~/.myrc'

add_source_line() {
  local rc_file="$1"
  if [ ! -f "$rc_file" ]; then
    warn "$rc_file not found, skipping."
    return
  fi
  if grep -qF "$SOURCE_LINE" "$rc_file"; then
    info "Already sourced in $rc_file"
  else
    echo "" >> "$rc_file"
    echo "# Added by dotfiles install.sh" >> "$rc_file"
    echo "$SOURCE_LINE" >> "$rc_file"
    info "Added source line to $rc_file"
  fi
}

if [ "$OS" = "mac" ]; then
  add_source_line "$HOME/.zshrc"
  # Also add to .bashrc if it exists (some mac users use bash)
  [ -f "$HOME/.bashrc" ] && add_source_line "$HOME/.bashrc"
else
  add_source_line "$HOME/.bashrc"
  # Also add to .zshrc if it exists
  [ -f "$HOME/.zshrc" ] && add_source_line "$HOME/.zshrc"
fi

info "Done. Reload your shell or run: source ~/.myrc"