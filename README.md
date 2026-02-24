# My NixOS Configuration

![Desktop Screenshot](assets/screenshot.jpg)

A personal NixOS flake with GNOME, Stylix theming, gaming, VFIO passthrough, and a modern CLI toolchain. Inspired by [Bluefin OS](https://projectbluefin.io/) and its opinionated, batteries-included desktop philosophy.

Steal anything useful!

## Hardware

| | |
|---|---|
| **CPU** | Intel i5-13600KF |
| **RAM** | 64 GB |
| **GPU 1** | NVIDIA RTX 4060 (main) |
| **GPU 2** | AMD Radeon Pro WX 5100 (VFIO passthrough) |
| **Storage** | ZFS pool (`tank`) with auto-scrub and snapshots |

## What's Inside

### System (`common/` + `modules/`)
- **GNOME** on Wayland with Stylix auto-theming
- **PipeWire** audio, Bluetooth, CUPS printing
- **NVIDIA** proprietary drivers (open kernel modules)
- **VFIO** GPU passthrough with Looking Glass (`kvmfr`)
- **Steam** + Proton-GE, GameMode
- **Ollama** with CUDA acceleration for local LLMs
- **Docker**, libvirt/QEMU/KVM, Sunshine streaming
- **ZFS** with auto-scrub, snapshots, and restic backups
- **Flatpak** (declarative) — Telegram, Bitwarden, Spotify, GIMP, Inkscape, Lutris, Heroic, Bottles, Zed, JetBrains Toolbox
- **Zen Browser** (declarative wrapFirefox)
- Firmware updates via fwupd, NuPhy keyboard support, Solaar for Logitech

### User (`home-manager/`)
- **Ghostty** terminal with Fish integration
- **Fish** shell + **Starship** prompt + **Atuin** history
- **Yazi** file manager, **Nautilus** with custom bookmarks
- **bat**, **eza**, **btop**, **fastfetch**, **fzf**, **zoxide**, **fd**, **ripgrep**, **dust**, **duf**, **procs**, **sd**, **tealdeer**
- **direnv** with nix-direnv, Node.js 22, Python 3, Claude Code
- **Stylix** dark theme — Inter font, JetBrains Mono, Papirus icons, Capitaine cursors

## Project Structure

```
nix-config/
├── flake.nix                 # Flake definition and inputs
├── Justfile                  # Command shortcuts
├── hosts/
│   └── erebor/               # Desktop workstation
│       ├── default.nix       # NVIDIA, VFIO, boot, restic backups, ZFS
│       └── hardware.nix      # Generated hardware config
├── modules/                  # Reusable NixOS modules (mkEnableOption)
│   ├── gaming.nix            # Steam, Proton-GE, GameMode
│   ├── gpu.nix               # Base graphics (OpenGL, Vulkan, 32-bit)
│   └── zfs.nix               # ZFS pools, scrub, snapshots
├── common/                   # Shared system config (all hosts)
│   ├── default.nix           # Imports everything below
│   ├── ai.nix                # Ollama (CUDA)
│   ├── audio.nix             # PipeWire
│   ├── bluetooth.nix         # Bluetooth
│   ├── docker.nix            # Docker
│   ├── flatpak.nix           # Declarative Flatpak packages
│   ├── gc.nix                # Garbage collection
│   ├── gnome.nix             # GNOME desktop
│   ├── gnupg.nix             # GnuPG
│   ├── locale.nix            # Timezone, i18n
│   ├── networking.nix        # Network
│   ├── nfs.nix               # NFS
│   ├── nix.nix               # Nix daemon, flakes
│   ├── nuphy.nix             # NuPhy keyboard
│   ├── packages.nix          # System packages, nh, nom, nvd
│   ├── power.nix             # Power management
│   ├── printing.nix          # CUPS
│   ├── rdp.nix               # GNOME RDP
│   ├── shell.nix             # Fish shell (system)
│   ├── solaar.nix            # Logitech devices
│   ├── ssh.nix               # SSH
│   ├── sunshine.nix          # Sunshine streaming
│   ├── user.nix              # User accounts
│   ├── virtualization.nix    # QEMU/KVM/libvirt
│   └── zen-browser.nix       # Zen Browser
├── home-manager/             # User config (home-manager)
│   ├── default.nix           # Entry point, Nautilus bookmarks
│   ├── config/
│   │   ├── default.nix       # Config imports
│   │   ├── dconf.nix         # GNOME dconf
│   │   └── stylix.nix        # Theme, fonts, icons, cursor
│   ├── hosts/
│   │   └── erebor.nix        # Looking Glass client config
│   ├── modules/
│   │   └── nautilus.nix      # Nautilus bookmarks module
│   ├── programs/
│   │   ├── default.nix       # Program imports
│   │   ├── fish.nix          # Fish shell
│   │   ├── starship.nix      # Starship prompt
│   │   ├── ghostty.nix       # Ghostty terminal
│   │   ├── atuin.nix         # Shell history
│   │   ├── bat.nix           # bat
│   │   ├── btop.nix          # System monitor
│   │   ├── eza.nix           # ls replacement
│   │   ├── fastfetch.nix     # System info
│   │   ├── fzf.nix           # Fuzzy finder
│   │   ├── yazi.nix          # File manager
│   │   ├── zoxide.nix        # Smart cd
│   │   ├── direnv.nix        # direnv + nix-direnv
│   │   ├── git.nix           # Git
│   │   └── packages.nix      # User packages
│   └── wallpapers/           # Wallpapers
├── pkgs/                     # Custom packages
└── overlays/
    └── default.nix           # Package overlays
```

## Usage

Everything is managed through `just`:

```bash
just system      # Build and switch NixOS config
just user        # Build and switch home-manager config
just update      # Update all flake inputs
just clean       # GC old generations + prune Docker + Flatpak
just changelogs  # Diff between current and previous generation
just backup      # Run restic backup now
just backup-list # List backup snapshots
just bios        # Reboot into UEFI firmware setup
```

Or manually:

```bash
sudo nixos-rebuild switch --flake .#erebor
home-manager switch --flake .
```

All files must be `git add`ed before Nix can see them.

## Acknowledgments

- [Bluefin OS](https://projectbluefin.io/) for the inspiration
- [NixOS](https://nixos.org/) and [Home Manager](https://github.com/nix-community/home-manager)
- [Stylix](https://github.com/danth/stylix) for system-wide theming
