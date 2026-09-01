#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

# Packages that are safe to stow individually.
# These match the directory names under the dotfiles repo.
PACKAGES=(
  shell
  git
  nvim
  ghostty
  starship
  fontconfig
  dunst
  walker
  elephant
  sway
  swaylock
  waybar
  gtk
  themes
  scripts
  systemd-user
  wallpapers
)

SELECTED=()

if command -v fzf >/dev/null 2>&1; then
  # Use fzf for multi-select.
  # Tab or Space toggles selection; Enter confirms.
  mapfile -t SELECTED < <(
    printf '%s\n' "${PACKAGES[@]}" | fzf \
      --multi \
      --prompt "Select packages to stow (Tab/Space to toggle, Enter to confirm): " \
      --header "Use Tab or Space to select multiple packages" \
      --no-preview
  )
else
  echo "Available Stow packages:"
  for i in "${!PACKAGES[@]}"; do
    printf "  %2d) %s\n" "$((i + 1))" "${PACKAGES[$i]}"
  done

  echo ""
  echo "Enter numbers to stow, separated by spaces (e.g. 1 3 5), or 'a' for all."
  read -r selection

  if [[ "$selection" == "a" || "$selection" == "all" ]]; then
    SELECTED=("${PACKAGES[@]}")
  else
    for n in $selection; do
      if [[ "$n" =~ ^[0-9]+$ ]] && (( n >= 1 && n <= ${#PACKAGES[@]} )); then
        SELECTED+=("${PACKAGES[$((n - 1))]}")
      else
        echo "Invalid selection: $n" >&2
        exit 1
      fi
    done
  fi
fi

if (( ${#SELECTED[@]} == 0 )); then
  echo "No packages selected."
  exit 0
fi

echo ""
echo "Stowing: ${SELECTED[*]}"
stow -t "$HOME" -v "${SELECTED[@]}"

echo ""
echo "Done."
