# Show available commands
default:
    @just --list

# Build system configuration
system:
    sudo nixos-rebuild switch --flake .#erebor

# Build home-manager configuration
user:
    home-manager switch --flake .

# Update flake inputs
update:
    nix flake update

# Clean old generations
clean:
    sudo nix-collect-garbage --delete-older-than 7d
    home-manager expire-generations "-7 days"