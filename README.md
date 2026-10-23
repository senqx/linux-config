# Linux configuration and setup guide

A practical guide to building and understanding an **Arch Linux i3/X11
desktop**, with my configurations for Alacritty, Rofi, i3status, and Vim.
The aim is to explain the choices so you can adapt the setup to your own machine.

Start with the [Arch and i3 setup guide](docs/arch-i3-guide.md) for the
walkthrough. The sections below describe the supplied files and how to install
them on an existing desktop.

## Files

| File | Purpose |
| --- | --- |
| `.config/i3/config` | Window manager, workspaces, shortcuts, audio keys |
| `.config/i3status/config` | CPU, memory, clock, and volume status |
| `.config/alacritty/alacritty.toml` | Terminal appearance and Zsh shell; Alacritty 0.14+ |
| `.config/rofi/config.rasi` | Application launcher theme |
| `.config/rofi/power.rasi` | Power-menu theme |
| `.local/bin/powermenu` | Lock, power off, or restart through Rofi |
| `.vimrc` | Editor settings and optional Vundle plugins |
| `Wallpapers/` | Wallpaper retained from the original setup |

The layout mirrors paths under your home directory. This setup targets i3 on
X11, not Sway or another Wayland compositor. Gaps require i3 4.22 or newer.

## Dependencies

On an already installed Arch system, the desktop components include:

```sh
sudo pacman -S --needed i3-wm i3status alacritty rofi nitrogen zsh vim xorg-setxkbmap
```

Install the Xorg stack and graphics drivers appropriate for your hardware by
following the [Arch Wiki](https://wiki.archlinux.org/title/Xorg). Configure
your chosen login/session manager separately.

The appearance uses Source Code Pro, Ubuntu, Font Awesome, and Papirus icons.
Install those fonts/icons or choose alternatives in the configs. Workspace and
status icons may appear as missing glyphs without a suitable icon font.

Audio shortcuts require `pactl`, supplied by PulseAudio or the `libpulse`
client tools with a PipeWire PulseAudio compatibility server. The volume widget
uses an ALSA mixer; adjust its device and mixer name for your audio setup.
Locking uses `dm-tool` and requires an active LightDM session. Replace that
command if you use another session manager or screen locker.

## Install selected files

Clone the repository and back up the corresponding files in your existing
configuration first. Copy only the components you want, from the repository root:

```sh
mkdir -p ~/.config/i3 ~/.config/i3status ~/.config/alacritty ~/.config/rofi ~/.local/bin
cp -i .config/i3/config ~/.config/i3/config
cp -i .config/i3status/config ~/.config/i3status/config
cp -i .config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
cp -i .config/rofi/config.rasi .config/rofi/power.rasi ~/.config/rofi/
cp -i .local/bin/powermenu ~/.local/bin/powermenu
chmod +x ~/.local/bin/powermenu
cp -i .vimrc ~/.vimrc
```

These commands target the default `~/.config` location. If you set
`XDG_CONFIG_HOME`, install the application configs there instead. The power
menu respects that variable.

Alacritty now uses TOML. If an existing YAML config remains, move it into your
backup so you have one active configuration. Review `/usr/bin/zsh` in the
terminal config; change it if your shell is installed elsewhere or you prefer
another shell.

Check these personal choices in the i3 config before reloading:

- `Mod4` (the Super/Windows key) as the modifier.
- US/Russian layouts, switched with Alt+Shift.
- Firefox/Steam workspace assignments and Steam floating rules.
- Fonts, colors, and gaps.
- The Nitrogen wallpaper command. Point it to an image you have locally, or
  comment it out. The repository wallpaper is not installed by the commands above.

## Shortcuts

| Shortcut | Action |
| --- | --- |
| Super+Enter | Terminal |
| Super+D | Application launcher |
| Super+1…0 | Switch workspaces |
| Super+Shift+1…0 | Move window to a workspace |
| Super+arrow | Change focus |
| Super+Shift+arrow | Move window |
| Super+R | Resize mode; Escape exits |
| Super+F | Fullscreen |
| Super+Shift+Q | Close window |
| Super+Shift+C | Reload configuration |
| Super+Shift+R | Restart i3 |
| Super+Ctrl+L | Power menu |

Validate the i3 config before reloading it:

```sh
i3 -C -c ~/.config/i3/config
```

## Vim plugins

Basic editor settings work without plugins. For the optional plugin setup,
install [Vundle](https://github.com/VundleVim/Vundle.vim) into
`~/.vim/bundle/Vundle.vim`, then run `:PluginInstall` in Vim.
YouCompleteMe needs its own build steps; follow its upstream instructions.
Tagbar needs Universal Ctags. Clipboard integration requires a Vim build with
clipboard support. An optional `~/.vim/.ycm_extra_conf.py` is loaded only if it
exists, with confirmation enabled.

## Scope and licensing

The configuration checks cover i3 syntax, the power-menu commands, TOML
syntax, and Vim startup. A complete fresh Arch installation has not been tested
with this revision. The [setup guide](docs/arch-i3-guide.md) explains the steps
and links to the Arch Wiki for installation details that depend on your hardware.

The repository currently has no declared license. The wallpaper's original
author and redistribution terms have not been verified; it is not covered by
any implied license for the configuration files. Third-party plugins, fonts,
and icons have their own licenses.
