#!/usr/bin/env bash
set -euo pipefail

echo "==> Checking required commands"
COMMANDS=(
  sway
  swaylock
  swaybg
  waybar
  dunst
  walker
  ghostty
  starship
  nvim
  git
  grimshot
  grim
  wl-copy
  hyprpicker
  notify-send
  dunstify
  thunar
  pavucontrol
  nm-connection-editor
  stow
)

MISSING=0
for c in "${COMMANDS[@]}"; do
  if command -v "$c" >/dev/null 2>&1; then
    echo "  OK: $c"
  else
    echo "  MISSING: $c"
    MISSING=1
  fi
done

echo "==> Checking fonts"
if fc-list | grep -i "JetBrainsMono Nerd Font" >/dev/null; then
  echo "  OK: JetBrainsMono Nerd Font"
else
  echo "  MISSING: JetBrainsMono Nerd Font"
  MISSING=1
fi

echo "==> Checking symlinks"
if [ -L "$HOME/.config/sway/config" ]; then
  echo "  OK: sway config is a symlink"
else
  echo "  WARN: sway config is not a symlink"
fi

if [ "$MISSING" -eq 1 ]; then
  echo "==> Some requirements are missing"
  exit 1
fi

echo "==> All checks passed"
