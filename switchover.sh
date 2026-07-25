#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "==> Backup directory: $BACKUP_DIR"

# Files that live directly in $HOME
HOME_FILES=(
  "$HOME/.bashrc"
  "$HOME/.bash_profile"
  "$HOME/.gitconfig"
)

for f in "${HOME_FILES[@]}"; do
  if [ -e "$f" ] && [ ! -L "$f" ]; then
    cp -a "$f" "$BACKUP_DIR/"
    echo "Backed up $f"
  fi
done

# Directories under .config
CONFIG_DIRS=(
  "nvim"
  "ghostty"
  "starship.toml"
  "fontconfig"
  "dunst"
  "walker"
  "elephant"
  "sway"
  "swaylock"
  "waybar"
  "gtk-3.0"
  "gtk-4.0"
  "systemd/user"
)

for d in "${CONFIG_DIRS[@]}"; do
  src="$HOME/.config/$d"
  if [ -e "$src" ] && [ ! -L "$src" ]; then
    mkdir -p "$BACKUP_DIR/.config"
    cp -a "$src" "$BACKUP_DIR/.config/"
    rm -rf "$src"
    echo "Moved $src to backup"
  fi
done

# Local bin scripts
mkdir -p "$BACKUP_DIR/.local/bin"
for s in pick-color screenshot-save; do
  src="$HOME/.local/bin/$s"
  if [ -e "$src" ] && [ ! -L "$src" ]; then
    cp -a "$src" "$BACKUP_DIR/.local/bin/"
    rm -f "$src"
    echo "Moved $src to backup"
  fi
done

# Wallpaper (system-level original, if present)
src="/usr/share/backgrounds/kagurabachi.JPG"
if [ -f "$src" ]; then
  cp -a "$src" "$BACKUP_DIR/"
  echo "Backed up wallpaper"
fi

# Local share assets that Stow will manage (only paths that would conflict)
LOCAL_SHARE_PATHS=(
  "$HOME/.local/share/backgrounds/kagurabachi.JPG"
  "$HOME/.local/share/themes/Nordic"
)
for src in "${LOCAL_SHARE_PATHS[@]}"; do
  if [ -e "$src" ] && [ ! -L "$src" ]; then
    rel="${src#$HOME/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    cp -a "$src" "$BACKUP_DIR/$rel"
    rm -rf "$src"
    echo "Moved $src to backup"
  fi
done

echo "==> Running Stow"
cd "$DOTFILES_DIR"
./stow-all.sh

echo "==> Enabling user services"
systemctl --user enable walker.service
systemctl --user enable elephant.service

echo "==> Switchover complete"
echo "If something breaks, run: ./unstow-all.sh"
echo "Your old files are at: $BACKUP_DIR"
