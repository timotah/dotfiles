# Dotfiles

Managed with GNU Stow.

## Initial setup

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
./stow-all.sh
./check.sh
```

## To switch an existing machine over

1. Back up and run the switchover script:

```bash
cd ~/dotfiles
./switchover.sh
```

2. Verify everything:

```bash
./check.sh
```

## Stow packages

| Package | Purpose |
|---|---|
| `shell` | `.bashrc`, `.bash_profile` |
| `git` | `.gitconfig` |
| `nvim` | Neovim config |
| `ghostty` | Ghostty terminal config |
| `starship` | Starship prompt |
| `fontconfig` | Font aliases |
| `dunst` | Notification daemon config |
| `walker` | Application launcher config |
| `sway` | Sway window manager config |
| `swaylock` | Swaylock config |
| `waybar` | Waybar config and style |
| `gtk` | GTK 3/4 theme settings |
| `scripts` | Local bin scripts |
| `systemd-user` | User systemd services |
| `wallpapers` | User-local wallpapers |

## Package manager independence

`bootstrap.sh` detects the distro and uses the appropriate package manager.
Currently only the Fedora adapter is implemented. Arch and Debian adapters are
left as stubs.

## Known portability notes

- Sway config now uses a portable local include at `$HOME/.config/sway/config.d/*.conf`.
- Wallpaper paths now reference `$HOME/.local/share/backgrounds/kagurabachi.JPG`,
  vendored in this repo under `wallpapers/.local/share/backgrounds/`.
- Waybar `power-profiles-daemon` module and `custom/media`/`custom/power` blocks
  have been removed because those dependencies are not currently installed.
- Dunst uses default system icons. To enable Papirus, install it and uncomment the
  `icon_path` line in `dunst/.config/dunst/dunstrc`.
