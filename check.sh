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

echo "==> Checking stow links"
STOW_LINKS=(
  "$HOME/.bashrc"
  "$HOME/.bash_profile"
  "$HOME/.gitconfig"
  "$HOME/.config/sway"
  "$HOME/.config/waybar"
  "$HOME/.config/walker"
  "$HOME/.config/elephant"
  "$HOME/.config/dunst"
  "$HOME/.config/ghostty"
  "$HOME/.config/nvim"
  "$HOME/.local/share/backgrounds"
  "$HOME/.local/share/themes"
)
for link in "${STOW_LINKS[@]}"; do
  if [ -L "$link" ]; then
    echo "  OK: $link"
  elif [ -e "$link" ]; then
    echo "  WARN: $link exists but is not a symlink"
  else
    echo "  MISSING: $link"
    MISSING=1
  fi
done

if [ "$MISSING" -eq 1 ]; then
  echo "==> Some requirements are missing"
  exit 1
fi

echo "==> All checks passed"
