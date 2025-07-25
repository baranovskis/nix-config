# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS flake configuration repository that manages both system-wide NixOS configuration and user-specific home-manager configuration. The setup uses the unstable nixpkgs channel and includes various specialized modules for gaming, theming (Stylix), VM tools, and custom packages.

## Common Commands

### System Configuration
```bash
# Rebuild and switch NixOS system configuration
sudo nixos-rebuild switch --flake .

# Test NixOS configuration without switching
sudo nixos-rebuild test --flake .

# Build NixOS configuration without switching
sudo nixos-rebuild build --flake .
```

### Home Manager Configuration
```bash
# Switch home-manager configuration
home-manager switch --flake .

# Build home-manager configuration
home-manager build --flake .
```

### Flake Management
```bash
# Update all flake inputs to latest versions
nix flake update

# Show flake information
nix flake show

# Build specific packages from the flake
nix build .#package-name

# Enter development shell with package
nix shell .#package-name
```

### Git Requirements
All changes must be tracked by git before nix can see them:
```bash
git add .
```

## Architecture

### Flake Structure
- `flake.nix`: Main flake definition with inputs and outputs
- `flake.lock`: Locked versions of all dependencies

### NixOS System Configuration (`nixos/`)
- `default.nix`: Main system configuration entry point
- Modular configuration files for specific functionality:
  - `hardware.nix`: Hardware-specific configuration
  - `user.nix`: User account definitions
  - `gnome.nix`: GNOME desktop environment
  - `nvidia.nix`: NVIDIA graphics drivers
  - `audio.nix`: Audio/PipeWire configuration
  - `gaming.nix`: Gaming-related packages and services
  - `libvirt.nix`: Virtualization with libvirt
  - `docker.nix`: Docker containerization
  - `networking.nix`: Network configuration
  - Other specialized modules (bluetooth, fonts, etc.)

### Home Manager Configuration (`home-manager/`)
- `default.nix`: Main home-manager configuration
- `config/`: Additional configuration modules
  - `default.nix`: General configuration settings
  - `dconf.nix`: GNOME dconf settings
- `zen.nix`: Zen browser configuration
- `stylix.yaml`: Theming configuration for Stylix
- `wallpapers/`: System wallpapers

### Custom Packages (`pkgs/`)
- `citron-emu/package.nix`: Custom emulator package
- Packages are exposed via overlays

### Overlays (`overlays/`)
- `default.nix`: Package overlays and modifications

## Key Features

### Theming System
- Uses Stylix for consistent theming across applications
- Base16 color scheme defined in `stylix.yaml`
- Automatic theming for GNOME and other applications

### Multiple Nixpkgs Channels
- `nixpkgs-unstable`: Primary channel for most packages
- `nixpkgs-stable`: Stable channel for specific tools
- Separate versioning allows stability where needed

### Specialized Inputs
- `home-manager`: User environment management
- `stylix`: System-wide theming
- `nix-gaming`: Gaming optimizations
- `nixvirt`: VM management tools
- `zen-browser`: Custom browser package
- `solaar`: Logitech device management

### User Configuration
- Username: `baranovskis`
- Home directory: `/home/baranovskis`
- Default shell: Fish (with Bash available)
- Desktop environment: GNOME with custom theming

## Development Workflow

1. Make changes to configuration files
2. Add files to git: `git add .`
3. Test changes: `sudo nixos-rebuild test --flake .` or `home-manager build --flake .`
4. Apply changes: `sudo nixos-rebuild switch --flake .` or `home-manager switch --flake .`
5. Update dependencies periodically: `nix flake update`

## Troubleshooting

- If nix can't find files, ensure they're tracked in git with `git add .`
- Use `nix flake update` if packages are outdated or missing
- Check `nixos-rebuild` logs for system configuration issues
- Verify hardware configuration matches actual system in `hardware.nix`