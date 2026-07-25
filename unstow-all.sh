#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

PACKAGES=(
  shell
  git
  nvim
  ghostty
  starship
  fontconfig
  dunst
  walker
  sway
  swaylock
  waybar
  gtk
  themes
  scripts
  systemd-user
  wallpapers
)

echo "==> Unstowing packages"
stow -D -t "$HOME" -v "${PACKAGES[@]}"

echo "==> Reloading systemd user daemon"
systemctl --user daemon-reload

echo "==> Done"
