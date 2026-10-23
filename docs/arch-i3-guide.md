# Build an Arch Linux desktop with i3

This guide explains the path from a base Arch installation to a small,
customizable desktop using i3. The supplied dotfiles give you a working example
to study and change. You do not need to understand every setting before you
start, but it helps to know which component owns each job.

## 1. Install the base system

Follow the current [Arch installation guide](https://wiki.archlinux.org/title/Installation_guide)
for booting the installer, partitioning disks, installing the base packages,
and configuring your bootloader. Those steps depend on your hardware,
UEFI/BIOS mode, storage layout, and encryption choices.

The result should be a system that boots and lets you log in on a text console.
A working base system does not automatically provide a graphical desktop.
We will add its components next.

## 2. Understand and configure the network

Your machine needs several pieces of information to communicate:

| Setting | What it does |
| --- | --- |
| IP address | Identifies the interface on its network |
| Prefix/subnet mask | Determines which addresses are on the local network |
| Default gateway | Receives traffic destined for other networks |
| DNS servers | Translate names such as `archlinux.org` into addresses |

An IPv4 address has four numbers from 0 to 255, for example `192.168.1.20`.
A prefix such as `/24` describes the network portion of the address. Private
IPv4 addresses are reused on many local networks; routers commonly use NAT
when those machines access the internet. IPv6 provides a much larger address
space and is also widely deployed.

Most home networks provide these settings automatically through **DHCP**.
Use that as your starting point. A static address is useful when a machine
must have a predictable address, but it needs to fit the network and avoid
conflicting with another device or the DHCP pool. An unanswered ping does
not prove that an address is unused.

### Enable NetworkManager

While connected in the installer, install NetworkManager into the installed
system from its chroot. Or, if the installed system already has internet,
run the following as root there:

```sh
pacman -S networkmanager
systemctl enable NetworkManager
```

After booting the installed system, start it if it is not already running:

```sh
systemctl start NetworkManager
nmtui
```

In `nmtui`, use **Activate a connection** to select a wired connection or a
Wi-Fi network. Under **Edit a connection**, automatic IPv4/IPv6 configuration
uses the settings provided by the network. You can also set the hostname.

For a static configuration, obtain the address, prefix, gateway, and DNS
servers from the person managing the network. Enter those values in the
profile's IPv4 settings and reactivate the profile.

NetworkManager normally manages DNS for its connections. Configure DNS in the
connection profile instead of editing `/etc/resolv.conf` underneath it. Avoid
running multiple network managers on the same interface.

If the installed system has no connection and lacks NetworkManager, reconnect
in the Arch installer using the installation guide, mount your installed
system, enter its chroot, and install the package there.

### Diagnose a connection

```sh
ip link
ip address
ip route
nmcli device status
ping -c 3 1.1.1.1
getent hosts archlinux.org
```

`ip link` shows interfaces; `ip address` shows their addresses; `ip route`
shows routes, including the default gateway. A numeric-address ping can check
reachability independently of DNS, while `getent hosts` checks name resolution.
Some networks block ping, so a failed ping is a clue rather than a complete
diagnosis. Consult the [NetworkManager guide](https://wiki.archlinux.org/title/NetworkManager)
for connection-specific troubleshooting.

## 3. Create an everyday user

Use root for system administration and a regular account for your desktop.
If you have not created one, run these commands as root, replacing `learner`
with your chosen username:

```sh
useradd -m -G wheel -s /bin/bash learner
passwd learner
pacman -S sudo
EDITOR=vi visudo
```

In `visudo`, enable the line `%wheel ALL=(ALL:ALL) ALL`. This lets members of
`wheel` run administrator commands through `sudo`, with authentication.
`useradd -m` creates the home directory with the correct ownership; you do
not need to create it manually or edit `/etc/passwd` to change shells.

Log in as your new user. The remaining system-install commands use `sudo`.

## 4. Add the graphical components

A desktop is a set of cooperating programs:

- **Xorg** provides the display server for this X11 setup.
- **i3** arranges windows and handles its keyboard shortcuts.
- **i3status** supplies the information shown in the bar.
- **Alacritty** provides a terminal; **Rofi** launches applications.
- **Nitrogen** sets a wallpaper.
- A **display manager**, if you choose one, provides graphical login and starts a session.

Update the system and install the components:

```sh
sudo pacman -Syu
sudo pacman -S --needed xorg-server xorg-xinit xorg-setxkbmap i3-wm i3status alacritty rofi nitrogen zsh vim
```

Current i3 includes gaps; there is no need to install the old separate
`i3-gaps` package. Install graphics drivers appropriate for your hardware;
NVIDIA packages are not a universal requirement. See the
[Xorg guide](https://wiki.archlinux.org/title/Xorg) for driver and display setup.

### Choose how to start i3

You can start it manually from a text-console login or use graphical login.

For manual startup, create or edit `~/.xinitrc`, retaining the standard Arch
xinit setup described in the [xinit guide](https://wiki.archlinux.org/title/Xinit).
Its final command should be:

```sh
exec i3
```

Then start the session with `startx` from your regular user's local console.

For graphical login, LightDM is one option:

```sh
sudo pacman -S lightdm lightdm-gtk-greeter
sudo systemctl enable lightdm
```

Ensure `/etc/lightdm/lightdm.conf` selects `greeter-session=lightdm-gtk-greeter`
in its `[Seat:*]` section. Reboot, then select the i3 session at login. A display
manager normally uses i3's installed session entry; it does not need your
`.xinitrc`. See the [LightDM guide](https://wiki.archlinux.org/title/LightDM).

The supplied power menu uses `dm-tool lock`, which depends on a running LightDM
session. If you start with `startx`, replace that action with a screen locker
configured for your session.

## 5. Configure audio

Choose one audio server setup. A common option is PipeWire with its PulseAudio
compatibility service:

```sh
sudo pacman -S --needed pipewire pipewire-audio pipewire-alsa pipewire-pulse wireplumber libpulse
```

Follow the [PipeWire guide](https://wiki.archlinux.org/title/PipeWire) when
replacing an existing audio setup, then start a fresh user session.
`pactl info` helps confirm that the PulseAudio-compatible server is reachable.

The i3 audio shortcuts call `pactl` against the default output/input device.
The supplied i3status volume widget reads an ALSA mixer. If its value does not
match your output volume, inspect the ALSA devices and adjust that widget's
`device` and `mixer` settings for your system.

## 6. Install and understand the dotfiles

Follow the [README's copy instructions](../README.md#install-selected-files),
backing up your current files first. Each application reads its own config;
copying one file does not configure the entire desktop.

Read `.config/i3/config` first. It groups shortcuts, workspace rules, appearance,
startup commands, and bar configuration. The modifier is `Mod4`, usually the
Super/Windows key. The [shortcut table](../README.md#shortcuts) provides the
main controls.

Some choices are personal: US/Russian keyboard layouts, Firefox/Steam window
rules, fonts, and the wallpaper path. Change them to suit your machine. Install
Source Code Pro, Ubuntu, Font Awesome, and Papirus icons, or replace their names
and glyphs in the configs. Missing icon fonts can produce empty boxes.

Before loading your edited i3 config:

```sh
i3 -C -c ~/.config/i3/config
```

Then use Super+Shift+C to reload it. Startup commands marked `exec` generally
run when i3 starts, so a reload alone may not rerun commands such as keyboard
layout or wallpaper setup. Learn the distinction between `exec` and
`exec_always` in the [i3 user guide](https://i3wm.org/docs/userguide.html).

## 7. Customize Zsh and Vim

Zsh is optional. To make it your login shell after installing it:

```sh
chsh -s /usr/bin/zsh
```

Log out and back in for the change to take effect. Alacritty's supplied config
also explicitly starts `/usr/bin/zsh`; edit that setting if you prefer another
shell. A framework such as [Oh My Zsh](https://ohmyz.sh/) can simplify plugin
setup, but plain Zsh works without one. Follow upstream installation directions
as your regular user.

The supplied `.vimrc` enables basic editing settings even without plugins.
For the optional Vundle setup and plugin requirements, see
[Vim plugins](../README.md#vim-plugins). Install plugins deliberately and check
their own setup steps, especially YouCompleteMe's build requirements.

Try changing one setting at a time and checking the result. This makes it much
easier to understand which component caused a change and to recover if a
configuration does not behave as expected.
