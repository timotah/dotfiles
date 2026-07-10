#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PACKAGES_DIR="$DOTFILES_DIR/packages"

detect_distro() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$ID"
  else
    echo "unknown"
  fi
}

install_fedora() {
  echo "==> Installing Fedora base packages"
  sudo dnf install -y $(cat "$PACKAGES_DIR/fedora/base.txt")
  echo "==> Installing Fedora desktop packages"
  sudo dnf install -y $(cat "$PACKAGES_DIR/fedora/desktop.txt")
  echo "==> Installing Fedora fonts"
  sudo dnf install -y $(cat "$PACKAGES_DIR/fedora/fonts.txt")
}

install_flatpaks() {
  if command -v flatpak >/dev/null 2>&1; then
    echo "==> Installing Flatpaks"
    while read app; do
      [ -z "$app" ] && continue
      [[ "$app" =~ ^# ]] && continue
      flatpak install -y flathub "$app"
    done < "$PACKAGES_DIR/flatpak.txt"
  else
    echo "==> flatpak not found, skipping Flatpaks"
  fi
}

DISTRO=$(detect_distro)

case "$DISTRO" in
  fedora|rhel) install_fedora ;;
  arch|endeavouros|manjaro) echo "Arch adapter not yet implemented" ;;
  debian|ubuntu) echo "Debian adapter not yet implemented" ;;
  *) echo "Unsupported distro: $DISTRO" ;;
esac

install_flatpaks

echo "==> Bootstrap complete"
echo "Next: run ./stow-all.sh to symlink configs"
