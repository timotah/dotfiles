# Dotfiles

Managed with GNU Stow.

## Prerequisites

Install `git` and `stow` through your distribution's package manager.

```bash
# Fedora
sudo dnf install git stow
```

## Initial setup

```bash
git clone git@github.com:timotah/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
./stow-all.sh
./check.sh
```

To choose only some packages instead of all of them, use:

```bash
./stow-select.sh
```

## Switching an existing machine over

```bash
git clone git@github.com:timotah/dotfiles.git ~/dotfiles
cd ~/dotfiles
./switchover.sh
./check.sh
```

`switchover.sh` backs up your current config and replaces it with symlinks into this repo.

## What is managed

| Stow package | Contents |
|---|---|
| `shell` | `.bashrc`, `.bash_profile` |
| `git` | `.gitconfig` |
| `nvim` | Neovim config (Git submodule, [timotah/nvim-config](https://github.com/timotah/nvim-config)) |
| `ghostty` | Ghostty terminal config |
| `starship` | Starship prompt config |
| `fontconfig` | Font aliases |
| `dunst` | Notification daemon |
| `walker` | Application launcher |
| `elephant` | Custom power + screenshot menus for Walker |
| `sway` | Window manager config |
| `swaylock` | Lock screen config |
| `waybar` | Status bar |
| `gtk` | GTK 3/4 theme settings |
| `themes` | Nordic GTK theme (vendored) |
| `scripts` | `pick-color`, `screenshot-save` |
| `systemd-user` | Walker + Elephant services |
| `wallpapers` | Background images |

## Scripts

| Script | Purpose |
|---|---|
| `bootstrap.sh` | Detect distro and install packages |
| `stow-all.sh` | Symlink all packages into `$HOME` |
| `stow-select.sh` | Interactively choose which packages to symlink |
| `unstow-all.sh` | Remove all symlinks |
| `check.sh` | Verify commands, fonts, and symlinks |
| `switchover.sh` | Back up live configs and activate Stow |

## Notes for fresh installs

- This repo uses a Git submodule for Neovim. `stow-all.sh` and `switchover.sh` initialize it automatically, but if you clone manually, run `git submodule update --init --recursive`.
- `starship` and `autotiling-rs` are **not** in the default Fedora repositories. They must be installed separately if you want them.
- `power-profiles-daemon` and `papirus-icon-theme` are intentionally left out of the main setup. Add them later if needed.
- The Nordic GTK theme is vendored in the repo, so no separate package install is needed.

## Day-to-day workflow

Edit files directly inside `~/dotfiles`. Most changes take effect immediately because the live files are symlinks.

After changing a service file:

```bash
systemctl --user daemon-reload
systemctl --user restart elephant.service walker.service
```

After changing Sway config:

```bash
# Mod+Shift+c
```

Commit changes regularly:

```bash
cd ~/dotfiles
git add -A
git commit -m "..."
```

## Optional extensions

If you want to add power profile support or Papirus notification icons later, create small install scripts or package entries and keep them in the repo.
