default:
    @just --list

# Build and switch system configuration
system:
    sudo nixos-rebuild switch --flake .#$(hostname)

# Build and switch home-manager configuration
user:
    home-manager switch --flake . -b backup

# Update all flake inputs
update:
    nix flake update

# Show diff between current and previous generation
changelogs:
    nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link | tail -2 | head -1) /nix/var/nix/profiles/system

# Clean old generations, containers, and flatpak runtimes
clean:
    sudo nix-collect-garbage --delete-older-than 7d
    home-manager expire-generations "-7 days"
    sudo docker system prune -f
    podman system prune -f
    flatpak uninstall --unused -y

# Reboot into BIOS/UEFI firmware setup
bios:
    systemctl reboot --firmware-setup

# Create a new Distrobox container
distrobox-create name="fedora" image="registry.fedoraproject.org/fedora-toolbox:latest":
    distrobox create --name {{name}} --image {{image}}

# Enter a Distrobox container
distrobox-enter name="fedora":
    distrobox enter {{name}}

# Run restic backup now
backup:
    sudo systemctl start restic-backups-daily && sudo journalctl -fu restic-backups-daily

# Check backup status
backup-status:
    sudo systemctl status restic-backups-daily

# List backup snapshots
backup-list:
    sudo restic -r /tank/backups --password-file /etc/restic-password snapshots

# Restore latest backup to target directory
backup-restore target="/tmp/restore":
    sudo restic -r /tank/backups --password-file /etc/restic-password restore latest --target {{target}}
