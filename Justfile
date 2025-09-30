# Justfile for NixOS configuration management
# Run `just` or `just --list` to see all available commands

# Default recipe - show available commands
default:
    @just --list

# System operations
# ================

# Deploy system configuration (erebor)
deploy:
    sudo nixos-rebuild switch --flake .#erebor

# Test system configuration without switching (reverts on reboot)
test:
    sudo nixos-rebuild test --flake .#erebor

# Build system configuration without switching
build:
    sudo nixos-rebuild build --flake .#erebor

# Deploy with verbose output and trace
debug:
    sudo nixos-rebuild switch --flake .#erebor --show-trace --verbose

# Build boot configuration (activates on next reboot)
boot:
    sudo nixos-rebuild boot --flake .#erebor

# Show what would change without applying
dry:
    sudo nixos-rebuild dry-activate --flake .#erebor

# Home Manager operations
# =======================

# Deploy home-manager configuration
home:
    home-manager switch --flake .

# Build home-manager configuration without switching
home-build:
    home-manager build --flake .

# Maintenance
# ===========

# Update all flake inputs to latest versions
up:
    nix flake update

# Update specific flake input
update input:
    nix flake lock --update-input {{input}}

# Show system generation history
history:
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Show home-manager generation history
home-history:
    home-manager generations

# Clean old system generations (keep last 7 days)
clean:
    sudo nix-collect-garbage --delete-older-than 7d

# Deep clean - remove all old generations
gc:
    nix-collect-garbage -d

# Remove old home-manager generations
home-clean:
    home-manager expire-generations "-7 days"

# Validation
# ==========

# Check flake for errors
check:
    nix flake check

# Show flake metadata
info:
    nix flake metadata

# Show flake outputs
show:
    nix flake show

# Git operations
# ==============

# Stage all changes (required before nix commands)
add:
    git add .

# Stage and deploy system
deploy-all: add deploy

# Stage and deploy both system and home
full: add
    sudo nixos-rebuild switch --flake .#erebor
    home-manager switch --flake .

# GPU Management
# ==============

# Show GPU status
gpu-status:
    sudo /etc/scripts/gpu-status.sh

# Bind Radeon GPU to VFIO for VM passthrough
gpu-bind:
    sudo /etc/scripts/bind-radeon-gpu.sh

# Unbind Radeon GPU from VFIO (return to host)
gpu-unbind:
    sudo /etc/scripts/unbind-radeon-gpu.sh

# Utilities
# =========

# Search for a package
search query:
    nix search nixpkgs {{query}}

# Build specific package from flake
package name:
    nix build .#{{name}}

# Enter development shell with package
shell name:
    nix shell .#{{name}}